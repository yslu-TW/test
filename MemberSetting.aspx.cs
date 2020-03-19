using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class FunctionListSetting : common
{
    MgrRoleMaintainer MgrRoleMaintainer = new MgrRoleMaintainer();
    MgrRole_Model MgrRole = new MgrRole_Model();
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    GetSqlStr getSqlStr = new GetSqlStr();
    common common = new common();
    DoDBAccess doDBAccess = new DoDBAccess();

    /// <summary>
    /// 登入者工號
    /// </summary>
    public string loginEmpno
    {
        set { ViewState["loginEmpno"] = value; }
        get
        {
            if (ViewState["loginEmpno"] == null)
                return string.Empty;
            return ViewState["loginEmpno"].ToString();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            common.sso.GetEmpInfo();
            loginEmpno = common.sso.empNo;
            BindDDL();
            sgv_mgrgroup_DataBind();
        }
    }
  
    protected void btn_query_Click(object sender, EventArgs e)
    {
        sgv_mgrgroup_DataBind();
    }
    protected void BindDDL()
    {
        dt =doDBAccess.toSelect(getSqlStr.getRoleType(),loginEmpno);
        if (dt.Rows.Count > 0)
        {
            dt =MgrRoleMaintainer.getRoleType(dt.Rows[0]["roletype"].ToString());        
            ddl_group.DataSource = dt;
            ddl_group.DataTextField = "subCname";
            ddl_group.DataValueField = "subType";
            ddl_group.DataBind();
        }
        ddl_group.Items.Insert(0, new ListItem("全部群組", ""));

        ds = common.GetOrgBasicData("");
        ddl_org.DataSource = ds;
        ddl_org.DataTextField = "org_abbr_chnm2";
        ddl_org.DataValueField = "org_orgcd";
        ddl_org.DataBind();
        ddl_org.Items.Insert(0, new ListItem("請選擇", ""));
    }

    /// <summary>
    /// 依使用者輸入的資料繫結管理者資訊
    /// </summary>
    protected void sgv_mgrgroup_DataBind()
    {
        string empno = tbx_empNo.Text;
        if (Session["empno"] != null)
        {
            empno = Session["empno"].ToString();
        }
        string roletype = ddl_group.SelectedValue;
        string org = ddl_org.SelectedValue;

        dt = MgrRoleMaintainer.searchMgrRole(loginEmpno, empno,"", roletype,org);
        ViewState["dt"] = dt;
        sgv_mgrgroup.DataSource = dt;
        sgv_mgrgroup.DataBind();

        Session["empno"] = null;
    }

    /// <summary>
    /// 分頁索引
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sgv_mgrgroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        sgv_mgrgroup.PageIndex = e.NewPageIndex;
        sgv_mgrgroup_DataBind();
    }
    
    /// <summary>
    /// 使用者新增資料，確定欄位不為空後寫入資料庫
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_insertSubWin_Click(object sender, EventArgs e)
    {
        string script = "<script language='javascript'>mgrGroupSettingInsert('','');</script>";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "送出", script, false);
    }

    protected void lbtn_postback_Click(object sender, EventArgs e)
    {
        sgv_mgrgroup_DataBind();
    }

    /// <summary>
    /// 刪除管理者群組成員
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void sgv_mgrgroup_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditRow")
        {
            int index = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            string empno = ((Label)sgv_mgrgroup.Rows[index].Cells[1].FindControl("lbl_empno")).Text.Trim();

            string script = "<script language='javascript'>mgrGroupSettingInsert('edit','" + empno + "');</script>";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "送出", script, false);
        }

        if (e.CommandName == "DeleteRow")
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")  //如果按下確定執行刪除語法
            {
                int index = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                string empno = ((Label)sgv_mgrgroup.Rows[index].Cells[1].FindControl("lbl_empno")).Text.Trim();
                MgrRoleMaintainer.deleteMgrMember(empno);
            }
            sgv_mgrgroup_DataBind();
        }
    }

    protected void btn_export_Click(object sender, EventArgs e)
    {
        dt = (DataTable)ViewState["dt"];
        dt.Columns.Remove("roletype");
        dt.Columns.Remove("subType");

        Excelexport_NPOI.NPOI_ExportExcel Export = new Excelexport_NPOI.NPOI_ExportExcel();

        NPOI.SS.UserModel.IWorkbook workbook = Export.ExportToFile(dt, "群組,單位,工號,姓名,分機,院區別,在職狀態".Split(','), null, "管理者群組維護", "2003", false, string.Empty, 1, 0, null);

        Export.ExportExeclfile();
    }

    protected void btn_clear_Click(object sender, EventArgs e)
    {
        ddl_group.ClearSelection();
        ddl_org.ClearSelection();
        tbx_empNo.Text = "";
        sgv_mgrgroup_DataBind();
    }
}
