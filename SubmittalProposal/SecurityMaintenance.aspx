<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true"
    CodeBehind="SecurityMaintenance.aspx.cs" Inherits="SubmittalProposal.SecurityMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript">
                jQuery("a").filter(function () {
                    return this.innerHTML.indexOf("Delete") == 0;
                }).click(function () {
                    return confirm("Are you sure you want to delete this record?");
                });
            </script>
            <h2>
                Security Admin</h2>
            <center><table width="100%" cellpadding="1" cellspacing="1" border="0">
                <tr align="center" valign="top">
                    <td width="60%" align="center">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:GridView ID="gvUsers" AllowPaging="true" DataKeyNames="UserId" AutoGenerateEditButton="True"
                                        AutoGenerateColumns="False" runat="server" OnRowCancelingEdit="gvUsers_RowCancelingEdit"
                                        OnRowDeleting="gvUsers_RowDeleting" OnRowEditing="gvUsers_RowEditing" OnRowUpdating="gvUsers_RowUpdating"
                                        Caption="Users" OnRowCommand="gvUsers_RowCommand" 
                                        onpageindexchanging="gvUsers_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbUserDelete" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this entry?');">Delete </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbUserChangePassword" runat="server" CommandName="ChangePassword">Change Password </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="UserId" HeaderText="UserId" Visible="false" />
                                            <asp:BoundField DataField="UserName" HeaderText="Name" ControlStyle-Width="110" />
                                            <asp:BoundField DataField="Email" HeaderText="Email" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSecurityUserResults" Font-Bold="true" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <br />
                                    <asp:LinkButton ID="lbAddUser" runat="server" OnClick="lbAddUser_Click">New User</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" width="40%">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td align="center">Roles</td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="height:19em; overflow:auto;">
                                        <asp:GridView ID="gvRolls" AllowPaging="false" DataKeyNames="RoleName" 
                                            AutoGenerateColumns="False" runat="server" 
                                            OnRowDeleting="gvRolls_RowDeleting" 
                                            >
                                            <Columns>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbRollDelete" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this entry?');">Delete </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="RollId" HeaderText="RollId" Visible="false" />
                                                <asp:BoundField DataField="RoleName" HeaderText="Name"  />
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSecurityRoleResults" Font-Bold="true" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <br />
                                    <asp:LinkButton ID="lbAddRoll" runat="server" OnClick="lbAddRoll_Click">New Roll</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table></center>
            <asp:Panel runat="server" CssClass="newitempopup" Width="977" ID="pnlNewSecurityUser">
                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewSecurityUserTitleId">
                    <span>New User</span>
                </asp:Panel>
                <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewUserContent" CssClass="newitemcontent">
                    <center>
                        <table cellpadding="1" cellspacing="1" border="1">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSecurityNewUserName" runat="server" Text="User Name"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbSecurityNewUserName" Width="30em" MaxLength="255" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSecurityNewUserPassword" runat="server" Text="Password"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbSecurityNewUserPassword" Width="30em" MaxLength="128" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSecurityNewUserEmail" runat="server" Text="Email"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbSecurityNewUserEmail" Width="30em" MaxLength="255" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="4">
                            <tr>
                                <td>
                                    <asp:Button ID="btnNewUserOk" CausesValidation="true" OnClientClick="javascript: if(Page_IsValid) { return doOk();} "
                                        runat="server" Text="Okay" OnClick="btnNewSecurityUserOk_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnNewSecurityUserCancel" OnClick="btnNewSecurityUserCancel_Click"
                                        OnClientClick="javascript: return confirm('Are you sure that you wish to cancel?')"
                                        runat="server" Text="Cancel" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblSecurityNewUserResults" Font-Bold="true" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <div class="loadingdb" align="center">
                            Processing. Please wait.<br />
                            <br />
                            <img src="Images/animated_progress.gif" alt="" />
                        </div>
                    </center>
                </asp:Panel>
                <script language="javascript" type="text/javascript">
                    function doOk() {

                        var loading = $(".loadingdb");
                        loading.show();
                        var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                        var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                        loading.css({ top: top, left: left });
                        return true;
                    }

                    // Called when async postback ends
                    function prm_EndRequest(sender, args) {
                        // get the divImage and hide it again
                        //debugger
                        if (sender._postBackSettings.sourceElement.id.indexOf("BtnGo") != -1 || sender._postBackSettings.sourceElement.id.indexOf("gvResults") != -1
                || (sender._postBackSettings.sourceElement.id.indexOf("btnNew") != -1 && sender._postBackSettings.sourceElement.id.indexOf("Ok") != -1)) {
                            var loading = $(".loading");
                            loading.hide();
                        }
                    }

                </script>
            </asp:Panel>
            <asp:Button Style="display: none;" ID="btnhiddennewuser1" runat="server" />
            <ajaxToolkit:ModalPopupExtender ID="mpeNewSecurityUser" runat="server" TargetControlID="btnhiddennewuser1"
                PopupControlID="pnlNewSecurityUser" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewSecurityUserTitleId"
                BehaviorID="jdpopupnewuser" />

            <asp:Panel runat="server" CssClass="newitempopup" Width="400" ID="pnlChangePassword">
                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlChangePasswordTitleId">
                    <span>Change </span> 
                    <asp:Label ID="lblNameOfUserWhosePasswordWereChanging" runat="server" ></asp:Label><span>'s Password</span>
                </asp:Panel>
                <asp:Panel runat="server" ID="pnlChangePasswordContent" CssClass="newitemcontent">

                        <table cellpadding="1" cellspacing="1" border="1">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNewPassword" runat="server" Text="New Password"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbNewPassword" Width="15em" MaxLength="128" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="4">
                            <tr>
                                <td>
                                    <asp:Button ID="btnNewPasswordOkay2" CausesValidation="true" OnClientClick="javascript: if(Page_IsValid) { return doOk();} "
                                        runat="server" Text="Okay" OnClick="btnNewPasswordOkay_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnNewPasswordCancel" OnClick="btnNewPasswordCancel_Click"
                                        OnClientClick="javascript: return confirm('Are you sure that you wish to cancel?')"
                                        runat="server" Text="Cancel" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblNewPasswordMessage" ForeColor="Red" Font-Bold="true" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>


                </asp:Panel>
            </asp:Panel>
            



            <asp:Button Style="display: none;" ID="btnhiddenchgpassword" runat="server" />
            <ajaxToolkit:ModalPopupExtender ID="mpeChangePassword" runat="server" TargetControlID="btnhiddenchgpassword"
                PopupControlID="pnlChangePassword" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlChangePasswordTitleId"
                BehaviorID="jdpopupchgpassword" />

            <asp:Panel runat="server" CssClass="newitempopup" Width="977" ID="pnlNewSecurityRole">
                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewSecurityRoleTitleId">
                    <span>New User</span>
                </asp:Panel>
                <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewRoleContent" CssClass="newitemcontent">
                    <center>
                        <table cellpadding="1" cellspacing="1" border="1">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSecurityNewRoleName" runat="server" Text="Role Name"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbSecurityNewRoleName" Width="30em" MaxLength="255" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            </tr>
                        </table>
                        <table cellpadding="4">
                            <tr>
                                <td>
                                    <asp:Button ID="btnNewRoleOk" CausesValidation="true" OnClientClick="javascript: if(Page_IsValid) { return doOk();} "
                                        runat="server" Text="Okay" OnClick="btnNewSecurityRoleOk_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnNewSecurityRoleCancel" OnClick="btnNewSecurityRoleCancel_Click"
                                        OnClientClick="javascript: return confirm('Are you sure that you wish to cancel?')"
                                        runat="server" Text="Cancel" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Label1" Font-Bold="true" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <div class="loadingdb" align="center">
Processing. Please wait.<br />
                            <br />
                            <img src="Images/animated_progress.gif" alt="" />
                        </div>
                    </center>
                </asp:Panel>
                <script language="javascript" type="text/javascript">
                    function doOk() {

                        var loading = $(".loadingdb");
                        loading.show();
                        var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                        var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                        loading.css({ top: top, left: left });
                        return true;
                    }

                    // Called when async postback ends
                    function prm_EndRequest(sender, args) {
                        // get the divImage and hide it again
                        //debugger
                        if (sender._postBackSettings.sourceElement.id.indexOf("BtnGo") != -1 || sender._postBackSettings.sourceElement.id.indexOf("gvResults") != -1
                || (sender._postBackSettings.sourceElement.id.indexOf("btnNew") != -1 && sender._postBackSettings.sourceElement.id.indexOf("Ok") != -1)) {
                            var loading = $(".loading");
                            loading.hide();
                        }
                    }

                </script>
            </asp:Panel>

            
            <asp:Button Style="display: none;" ID="btnhiddennewrole1" runat="server" />
            <ajaxToolkit:ModalPopupExtender ID="mpeNewSecurityRole" runat="server" TargetControlID="btnhiddennewrole1"
                PopupControlID="pnlNewSecurityRole" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewSecurityRoleTitleId"
                BehaviorID="jdpopupnewrole" />



        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
