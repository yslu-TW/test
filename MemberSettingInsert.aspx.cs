using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Windows.Forms;

public partial class WebPage_FunctionListSettingInsert : common
{
    MgrRoleMaintainer MgrRoleMaintainer = new MgrRoleMaintainer();
    MgrRole_Model MgrRoleModel = new MgrRole_Model();
    DataTable dt = new DataTable();
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
        if(!IsPostBack)
        {
            common.sso.GetEmpInfo();
            loginEmpno = common.sso.empNo;
            BindDDL();

            string editMod = string.Empty, empno = string.Empty;
            try
            {
                editMod = Request.QueryString["editMod"].Trim();
                empno = Request.QueryString["empno"].Trim();
            }
            catch (Exception ex)
            {
                throw new Exception("MgrRole EditMod錯誤訊息：" + ex.Message);
            }

            if (editMod == "edit")
            {
                btn_insertdone.Visible = false;
                btn_editdone.Visible = true;
                tbx_empnoinsert.ReadOnly = true;  //不能修改empno
                DataTable dt=MgrRoleMaintainer.searchMgrRole("",empno, "","",""); ;
                if (dt.Rows.Count > 0)
                {
                    //帶出edit資料 呈現於畫面
                    ddl_group.SelectedValue= dt.Rows[0]["subType"].ToString().Trim();
                    tbx_empnoinsert.Text = dt.Rows[0]["empno"].ToString().Trim();

                    lbl_empnoinsertCname.Text = dt.Rows[0]["name"].ToString() + " 分機：" + dt.Rows[0]["tel"].ToString();
                }
            }
         }
    }

    protected void BindDDL()
    {
        ////設定ddl清單項目

        dt = doDBAccess.toSelect(getSqlStr.getRoleType(), loginEmpno);
        dt = MgrRoleMaintainer.getRoleType(dt.Rows[0]["roletype"].ToString());
        ddl_group.DataSource = dt;
        ddl_group.DataTextField = "subCname";
        ddl_group.DataValueField = "subType";
        ddl_group.DataBind();
    }

    protected void btn_insertdrop_Click(object sender, EventArgs e)
    {
        string script = "<script language='javascript'>parent.$.fn.colorbox.close();</script>";
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "送出", script, false);
    }
    
    protected void btn_editdone_Click(object sender, EventArgs e)
    {
        sso.GetEmpInfo();
        //修改的資料記錄到MgrRole_Model中對應的欄位
        MgrRoleModel.pRoletype = Convert.ToInt32(ddl_group.SelectedValue);
        MgrRoleModel.pEmpno = tbx_empnoinsert.Text.Trim();

        //紀錄修改前的empno
        string empno = Request.QueryString["empno"];

        if (empno == MgrRoleModel.pEmpno)//empno主鍵不變
        {
            MgrRoleMaintainer.toAlterMgrMember(MgrRoleModel);
            string script = "<script language='javascript'>window.alert('儲存成功');parent.$.fn.colorbox.close();</script>";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "送出", script, false);
        }
    }
    /// <summary>
    /// 替ddl增加指定的item
    /// </summary>
    /// <param name="ddl_item"></param>ddl
    /// <param name="dt"></param>datatable
    /// <returns></returns>
    public DropDownList setDDLItem(DropDownList ddl_item, DataTable dt, string ddlText, string ddlValue)
    {
        int ddlIndex = ddl_item.SelectedIndex;
        ddl_item.Items.Clear();
        ddl_item.Items.Add(new ListItem("請選擇", ""));

        foreach (DataRow dr in dt.Rows)
            ddl_item.Items.Add(new ListItem(dr[ddlText].ToString(), dr[ddlValue].ToString()));
        ddl_item.SelectedIndex = ddl_item.Items.Count < ddlIndex ? 0 : ddlIndex;

        return ddl_item;
    }
    /// <summary>
    /// 資料庫主健欄位防呆
    /// 開發於20161018_A50463
    /// 修改scipt指定於20161103_A50463
    /// </summary>
    /// <param name="UID"></param>
    /// <returns></returns>
    public Boolean isDataValid(string empno)
    {
        string msg = "";
        if (tbx_empnoinsert.Text.Trim() == "")
        {
            msg += "請輸入工號";
        }
        else
        {
            DataTable dt = MgrRoleMaintainer.searchMgrRole("", tbx_empnoinsert.Text.Trim(), "", "", "");
            if (dt.Rows.Count > 0)
            {
                msg += "成員已存在";
                string script = "<Script language='JavaScript'>alert('"+ msg + "');</Script>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", script, false);

                return false;
            }
        }

        
        return true;
    }

    protected void tbx_empnoinsert_TextChanged(object sender, EventArgs e)
    {
        if (tbx_empnoinsert.Text.Trim() != "")
        {
            if (isDataValid(tbx_empnoinsert.Text.Trim()))
            {
                DataTable dt = MgrRoleMaintainer.searchEmpInfo(tbx_empnoinsert.Text.Trim());
                if (dt.Rows.Count > 0)
                {
                    lbl_empnoinsertCname.Text = dt.Rows[0]["com_cname"].ToString() + " 分機：" + dt.Rows[0]["com_telext"].ToString();
                }
                else
                {
                    string script = "<Script language='JavaScript'>alert('查無資料!');</Script>";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", script, false);
                }
            }
        }
    }

    protected void btn_insertdone_Click(object sender, EventArgs e)
    {
        sso.GetEmpInfo();
        MgrRoleModel.pRoletype = 1;
        MgrRoleModel.pEmpno = tbx_empnoinsert.Text.Trim();

        if (isDataValid(MgrRoleModel.pEmpno))
        {
            Session["empno"] = tbx_empnoinsert.Text.Trim();
            MgrRoleMaintainer.toInsertMgrMember(MgrRoleModel);
            string script = "<script language='javascript'>window.alert('儲存成功');parent.$.fn.colorbox.close();</script>";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "送出", script, false);
        }
    }
}
