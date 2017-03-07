<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="ComRoster_Liaisons.aspx.cs" Inherits="SubmittalProposal.ComRoster_Liaisons" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Lxabel18" runat="server" Text="Name"></asp:Label>
        <asp:TextBox ID="tbComRosterLiaisonsNameLU" Width="80" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Lxabel2" runat="server" Text="Committee"></asp:Label>
        <asp:DropDownList ID="ddlComRosterLiaisonsCommitteeLU" DataTextField="CommitteeName" DataValueField="CommitteeID"
            runat="server">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Lxabel3" runat="server" Text="Liaison Type"></asp:Label>
        <asp:DropDownList ID="ddlComRosterLiaisonTypeLU" runat="server" DataTextField="LiaisonType" DataValueField="LiaisonType"></asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Lxabel1" runat="server" Text="LiaisonID"></asp:Label>
        <asp:TextBox ID="tbComRosterLiaisonIDLU" Width="46" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height: 400px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False" DataKeyNames="LiaisonID"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="LiaisonName" HeaderText="Name" SortExpression="LiaisonName" />
                <asp:BoundField DataField="LiaisonType" HeaderText="Type" SortExpression="LiaisonType" />
                <asp:BoundField DataField="LiaisonSRPhone" HeaderText="SR Phone" SortExpression="LiaisonSRPhone" />
                <asp:BoundField DataField="LiaisonEmail" HeaderText="LiaisonEmail" SortExpression="Email" />
                <asp:BoundField DataField="LiaisonNRMail" HeaderText="NR Address" SortExpression="LiaisonNRMail" />
                <asp:BoundField DataField="LiaisonNRPhone" HeaderText="NR Phone" SortExpression="LiaisonNRPhone" />
                <asp:BoundField DataField="Committees" HeaderText="Committees" SortExpression="Committees" />
                <asp:BoundField DataField="LiaisonID" HeaderText="LiaisonID" SortExpression="LiaisonID" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="top">
            <td valign="top">
                <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="First Name"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterLiaisonNameUpdate" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Liaison Type"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="dllComRosterLiaisonLiaisonTypeUpdate" runat="server" DataTextField="LiaisonType" DataValueField="LiaisonType"></asp:DropDownList>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label10x3" runat="server" Text="SR Mail1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterLiaisonsSRMailAddr1Update" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label10x3dc" runat="server" Text="SR Mail2"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterLiaisonsSRMailAddr2Update" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr valign="top">
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3x33" runat="server" Text="SR Phone"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterLiaisonsSRPhoneUpdate" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3x332zs" runat="server" Text="Represents"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterLiaisonsRepresentsUpdate" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Email"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="tbComRosterLiaisonsEmailUpdate" MaxLength="50" Width="24.5em" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr valign="top">
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label4x11" runat="server" Text="NR Mail Addr"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="tbComRosterLiaisonsNRMailAddrUpdate" Width="24em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="NR Phone"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterLiaisonsNRPhoneUpdate" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnComRosterLiaisonUpdate" OnClick="btnComRosterLiaisonUpdateOkay_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblComRosterLiaisonUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <center>
        <asp:LinkButton ID="lbNewComRosterLiaison" CausesValidation="false" OnClick="lbNewComRosterLiaison_OnClick"
            runat="server">New Liaison</asp:LinkButton>
    </center>
    <script language="javascript" type="text/javascript">
        function donewcomrosterjedisok() {
            var loading = $(".loadingnewbpermit");
            loading.show();
            var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
            var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
            loading.css({ top: top, left: left });
            return true;
        }
    </script>
    <asp:Panel runat="server" CssClass="newitempopup" Width="900" ID="pnlComRosterLiaisonNewContent">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlComRosterLiaisonNewTitle">
            <span>New Liaison</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewComRosterLiaisonContent"
            CssClass="newitemcontent">
        <table border="0" cellpadding="2" cellspacing="2">
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel7x" runat="server" Text="First Name"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComRosterLiaisonNameNew" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel7" runat="server" Text="Liaison Type"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="dllComRosterLiaisonLiaisonTypeNew" runat="server" DataTextField="LiaisonType" DataValueField="LiaisonType"></asp:DropDownList>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel10x3" runat="server" Text="SR Mail1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComRosterLiaisonsSRMailAddr1New" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel10x3dc" runat="server" Text="SR Mail2"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComRosterLiaisonsSRMailAddr2New" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel3x33" runat="server" Text="SR Phone"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComRosterLiaisonsSRPhoneNew" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel3x332zs" runat="server" Text="Represents"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComRosterLiaisonsRepresentsNew" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel3" runat="server" Text="Email"></asp:Label>
                </td>
                <td colspan="3">
                    <asp:TextBox ID="tbComRosterLiaisonsEmailNew" MaxLength="50" Width="24.5em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel4x11" runat="server" Text="NR Mail Addr"></asp:Label>
                </td>
                <td colspan="3">
                    <asp:TextBox ID="tbComRosterLiaisonsNRMailAddrNew" Width="24em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Lb2abel5" runat="server" Text="NR Phone"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbComRosterLiaisonsNRPhoneNew" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <center>
            <table cellpadding="3">
                <tr>
                    <td>
                        <asp:Button CausesValidation="true" OnClientClick="javascript: return true;"
                            ID="btnNewComRosterLiaisonOk" runat="server" Text="Okay" OnClick="btnNewComRosterLiaisonOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnComRosterLiaisonNewCancel" runat="server" Text="Abort" CausesValidation="false"
                            OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                            OnClick="btnNewComRosterLiaisonCancel_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:Label ID="lblComRosterLiaisonNewMessage" Font-Bold="true" ForeColor="Red" runat="server" ></asp:Label></td>
                </tr>
            </table>
        </center>
    </asp:Panel>
    </asp:Panel>
    <asp:Button Style="display: none;" ID="btnComRosterLiaisonhidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewComRosterLiaison" runat="server" TargetControlID="btnComRosterLiaisonhidden1"
        PopupControlID="pnlComRosterLiaisonNewContent" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlComRosterLiaisonNewTitle"
        BehaviorID="jdpopupComRosterLiaisonnew" />
</asp:Content>
