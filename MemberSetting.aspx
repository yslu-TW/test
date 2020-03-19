<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MgrGroupSetting.aspx.cs" Inherits="FunctionListSetting" %>

<%@ Register Assembly="SmartGridView" Namespace="GridView3Probe" TagPrefix="cc1" %>
<%@ Register Src="../UserControl/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="../UserControl/footer.ascx" TagName="footer" TagPrefix="uc2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="關鍵字" />
    <meta name="description" content="描述" />
    <!--告訴搜尋引擎這篇網頁的內容或摘要。-->
    <meta name="generator" content="Notepad" />
    <!--告訴搜尋引擎這篇網頁是用什麼軟體製作的。-->
    <meta name="author" content=" " />
    <!--告訴搜尋引擎這篇網頁是由誰製作的。-->
    <meta name="copyright" content="本網頁著作權所有" />
    <!--告訴搜尋引擎這篇網頁是...... -->
    <meta name="revisit-after" content="3 days" />
    <!--告訴搜尋引擎3天之後再來一次這篇網頁，也許要重新登錄。-->
    <title></title>
    <link rel="stylesheet" href="../css/bootstrap.css" />
    <!-- normalize & bootstrap's grid system -->
    <link href="../css/font-awesome.min.css" rel="stylesheet">
    <!-- css icon -->
    <link href="../css/animate.min.css" rel="stylesheet" type="text/css" />
    <!-- css3動畫庫:https://daneden.github.io/animate.css/ -->
    <link href="../css/superfish.css" rel="stylesheet" type="text/css" />
    <!-- 桌機版下拉選單 -->
    <link href="../css/colorbox.css" rel="stylesheet" type="text/css" />
    <!-- colorbox -->
    <link href="../css/jquery.powertip.css" rel="stylesheet" type="text/css" />
    <!-- powertip:tooltips -->
    <link href="../css/jquery.mmenu.css" rel="stylesheet" type="text/css" />
    <!-- mmenu css:行動裝置選單 -->
    <link href="../css/slider-pro.min.css" rel="stylesheet" type="text/css" />
    <!-- RWD輪播 -->
    <link href="../css/jquery.treetable.css" rel="stylesheet" type="text/css" />
    <!-- treetable -->
    <link href="../css/jquery.treetable.theme.default.css" rel="stylesheet" type="text/css" />
    <!-- treetable -->
    <link href="../css/OchiLayout.css" rel="stylesheet" type="text/css" />
    <!-- ochsion layout base -->
    <link href="../css/OchiColor.css" rel="stylesheet" type="text/css" />
    <!-- ochsion layout color -->
    <link href="../css/OchiRWD.css" rel="stylesheet" type="text/css" />
    <!-- ochsion layout RWD -->
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <!-- 低於IE9時設定CSS -->
    <!--[if lte IE 9]>
      <link href='css/ie9fix.css' rel='stylesheet'>
<![endif]-->
    <noscript>
<link href="../css/NoJSstyle.css" rel="stylesheet" type="text/css" />
</noscript>
    <!-- 基本套件 -->
    <script type="text/javascript" src="../js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="../js/modernizr-svg.js"></script>
    <!-- 判斷瀏覽器支援SVG -->
    <script type="text/javascript" src="../js/jquery.breakpoint-min.js"></script>
    <!-- 斷點設定 -->
    <!-- 框架套件 -->
    <script type="text/javascript" src="../js/superfish.min.js"></script>
    <!-- 桌機版下拉選單 -->
    <script type="text/javascript" src="../js/jquery.mmenu.min.js"></script>
    <!-- mmenu js:行動裝置選單 -->
    <script type="text/javascript" src="../js/jquery.touchSwipe.min.js"></script>
    <!-- 增加JS觸控操作 for mmenu -->
    <script type="text/javascript" src="../js/jquery.colorbox.js"></script>
    <!-- colorbox -->
    <script type="text/javascript" src="../js/jquery.powertip.min.js"></script>
    <!-- powertip:tooltips -->
    <script type="text/javascript" src="../js/animatescroll.min.js"></script>
    <!-- 動態滾動 -->
    <!-- 動畫套件 -->
    <script type="text/javascript" src="../js/jquery-timing.min.js"></script>
    <!-- 組織動畫用JS.wait() -->
    <script type="text/javascript" src="../js/TweenMax.min.js"></script>
    <!-- GSAP -->
    <!-- 滾動偵測 -->
    <script type="text/javascript" src="../js/jquery.scrollmagic.min.js"></script>
    <!-- scrollmagic配合捲軸動畫 -->
    <script type="text/javascript" src="../js/jquery.scrollmagic.debug.js"></script>
    <!-- scrollmagic配合捲軸動畫:顯示起啟位置參考線(上線前移除) -->
    <!-- 網站套件 -->
    <script type="text/javascript" src="../js/jquery.sliderPro.min.js"></script>
    <!-- RWD輪播 -->
    <script type="text/javascript" src="../js/jquery.treetable.js"></script>
    <!-- treetable -->

    <script type="text/javascript">
        $(document).ready(function () {
            ;
        });
        function mgrGroupSettingInsert(editMod, empno) {
            $.colorbox({
                href: '../SubWin/MgrGroupSettingInsert.aspx?editMod=' + editMod + '&empno=' + empno, iframe: true, width: "800px", height: "300px",
                transition: "elastic", opacity: "0.5", onClosed: function () { triger_click(); }, overlayClose: false
            });
        }

        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("您確定要刪除?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

        function triger_click() {
            lnk = document.getElementById('lbtn_postback');
            lnk.click();
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="WrapperBody" id="WrapperBody">
            <uc1:header ID="header" runat="server" />

            <div id="ContentWrapper" class="margin20T">

                <div class="container">
                    <div class="twocol titlewithline">
                        <div class="left font-size5">管理者群組維護</div>
                        <div class="right">管理功能 >管理者群組維護</div>
                    </div>

                    <div class="fixwidth">

                        <div class="gentable margin10T">
                            <div class="gentable">
                                <div class="twocol margin10T font-normal">
                                <div class="left"><span class="font-title titlebackicon">群組</span><asp:DropDownList ID="ddl_group" runat="server" class="inputex"></asp:DropDownList>&nbsp;<span class="font-title titlebackicon">單位</span><asp:DropDownList ID="ddl_org" runat="server" class="inputex"></asp:DropDownList>&nbsp;<span class="font-title titlebackicon">工號/姓名</span><asp:TextBox ID="tbx_empNo" runat="server" type="text" class="inputex"></asp:TextBox><asp:Button ID="btn_clear" runat="server" Class="genbtnS" Text="清除條件" OnClick="btn_clear_Click" /><asp:Button ID="btn_query" runat="server" href="#" Class="genbtnS" OnClick="btn_query_Click" Text="查詢"></asp:Button></div>
                                <div class="right"><asp:Button ID="btn_export" runat="server" href="#" Class="genbtnS colorboxS" Text="匯出" OnClick="btn_export_Click"></asp:Button><asp:Button ID="btn_insertSubWin" runat="server" href="#" Class="genbtnS colorboxS" Text="新增" OnClick="btn_insertSubWin_Click"></asp:Button></div>
                                    </div>
                            </div>
                        </div>
                    </div>
                    <!-- fixwidth -->

                    <div class="fixwidth">
                        <%--<div class="twocol margin15T">
                            <div class="right">
                                
                            </div>
                            <div class="right">
                                
                            </div>
                        </div>--%>
                        <!-- twocol -->


                        <!-- twocol -->
                        <div class="stripetree font-normal margin10T">
                            <cc1:SmartGridView ID="sgv_mgrgroup" runat="server" AllowPaging="True" OnRowDataBound="sgv_mgrgroup_RowDataBound" AutoGenerateColumns="False" Width="100%" OnPageIndexChanging="sgv_mgrgroup_PageIndexChanging"
                                OnRowDeleting="sgv_mgrgroup_RowDeleting" OnRowCommand="sgv_mgrgroup_OnRowCommand">
                                <EmptyDataTemplate>
                                    <div class="font-normal">
                                        <asp:Label ID="lbl_sgv_code_nodata" runat="server" Text="目前無資料"></asp:Label>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField HeaderText="群組" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_mgr" runat="server" Text='<%# Eval("subCname") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="單位" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_org" runat="server" Text='<%# Eval("org_abbr_chnm2") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="工號" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_empno" runat="server" Text='<%# Eval("empno") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="姓名" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_name" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="分機" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_tel" runat="server" Text='<%# Eval("tel") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="院區別" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_secno" runat="server" Text='<%# Eval("secno") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="在職狀態" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_state" runat="server" Text='<%# Eval("state") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="操作" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtn_dataModify" runat="server" Text='修改' CommandName="EditRow"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtn_dataDelete" runat="server" Text='刪除' OnClientClick="Confirm()" CommandName="DeleteRow" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="lbtn_update" runat="server" CommandName="Update" Text='更新'></asp:LinkButton>
                                            <asp:LinkButton ID="lbtn_cancelUpdate" runat="server" CommandName="Cancel" Text='取消'></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>

                                </Columns>
                                <CustomPagerSettings PagingMode="Webabcd" TextFormat="每頁{0}筆/共{1}筆&#160;&#160;&#160;第{2}頁/共{3}頁&#160;&#160;" />
                                <PagerStyle VerticalAlign="Middle" BorderStyle="None" BorderWidth="0px" HorizontalAlign="Center" CssClass="PagerStyle" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="首頁" LastPageText="末頁" NextPageText="下一頁" PreviousPageText="上一頁" />
                            </cc1:SmartGridView>
                            <asp:LinkButton ID="lbtn_postback" runat="server" OnClick="lbtn_postback_Click"></asp:LinkButton>
                        </div>

                        <!-- twocol -->
                    </div>
                    <!-- container -->
                </div>
                <!-- ContentWrapper -->

            </div>
            <!-- WrapperBody -->
            <br>
            <uc2:footer ID="footer1" runat="server" />
    </form>
</body>
</html>
