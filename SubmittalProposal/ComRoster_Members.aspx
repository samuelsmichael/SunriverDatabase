<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="ComRoster_Members.aspx.cs" Inherits="SubmittalProposal.ComRoster_Members" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="Name"></asp:Label>
        <asp:TextBox ID="tbComRosterMembersNameLU" Width="80" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Committee"></asp:Label>
        <asp:DropDownList ID="ddlComRosterMembersCommitteeLU" DataTextField="CommitteeName" DataValueField="CommitteeID"
            runat="server">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="MemberID"></asp:Label>
        <asp:TextBox ID="tbComRosterMemberIDLU" Width="46" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height: 400px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                <asp:BoundField DataField="SRPhone" HeaderText="SR Phone" SortExpression="SRPhone" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="NRMailAddr" HeaderText="NR Address" SortExpression="NRMailAddr" />
                <asp:BoundField DataField="NRPhone" HeaderText="NR Phone" SortExpression="NRPhone" />
                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                <asp:BoundField DataField="Committees" HeaderText="Committees" SortExpression="Committees" />
                <asp:BoundField DataField="MemberID" HeaderText="MemberID" SortExpression="MemberID" />
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
                <asp:TextBox ID="tbComRosterMembersFirstNameUpdate" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Last Name"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterMembersLastNameUpdate" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label10x3" runat="server" Text="SR Mail Addr1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterMembersSRMailAddr1Update" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label10x3dc" runat="server" Text="SR Mail Addr2"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterMembersSRMailAddr2Update" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr valign="top">
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3x33" runat="server" Text="SR Phone"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterMembersSRPhoneUpdate" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3x332zs" runat="server" Text="FAX"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterMembersFAXUpdate" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Email"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="tbComRosterMembersEmailUpdate" MaxLength="50" Width="27em" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr valign="top">
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label4x11" runat="server" Text="NR Mail Addr"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterMembersNRMailAddrUpdate" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="NR Phone"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbComRosterMembersNRPhoneUpdate" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Comments"></asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox TextMode="MultiLine" ID="tbComRosterMembersCommentsUpdate" Height="4em" Width="27em" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnComRosterMemberUpdate" OnClick="btnComRosterMemberUpdateOkay_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblComRosterMemberUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <center>
        <asp:LinkButton ID="lbNewComRosterMember" CausesValidation="false" OnClick="lbNewComRosterMember_OnClick"
            runat="server">New Member</asp:LinkButton>
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
    <asp:Panel runat="server" CssClass="newitempopup" Width="900" ID="pnlComRosterMemberNewContent">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlComRosterMemberNewTitle">
            <span>New Member</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewComRosterMemberContent"
            CssClass="newitemcontent">
            <table border="0" cellpadding="2" cellspacing="2">
                <tr valign="top">
                    <td valign="top">
                        <asp:Label CssClass="form_field_heading" ID="Laabel7x" runat="server" Text="First Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersFirstNameNew" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel7" runat="server" Text="Last Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersLastNameNew" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel10x3" runat="server" Text="SR Mail Addr1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersSRMailAddr1New" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel10x3dc" runat="server" Text="SR Mail Addr2"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersSRMailAddr2New" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr valign="top">
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel3x33" runat="server" Text="SR Phone"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersSRPhoneNew" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel3x332zs" runat="server" Text="FAX"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersFAXNew" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel3" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="tbComRosterMembersEmailNew" MaxLength="50" Width="27em" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr valign="top">
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel4x11" runat="server" Text="NR Mail Addr"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersNRMailAddrNew" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel5" runat="server" Text="NR Phone"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbComRosterMembersNRPhoneNew" MaxLength="20" Width="8em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Laabel4" runat="server" Text="Comments"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox TextMode="MultiLine" ID="tbComRosterMembersCommentsNew" Height="4em" Width="27em" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <center>
                <table cellpadding="3">
                    <tr>
                        <td>
                            <asp:Button CausesValidation="true" OnClientClick="javascript: return donewcomrosterjedisok();"
                                ID="btnComRosterMemberNewOkay" runat="server" Text="Okay" OnClick="btnNewComRosterMemberOk_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnComRosterMemberNewCancel" runat="server" Text="Cancel" CausesValidation="false"
                                OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                OnClick="btnNewComRosterMemberCancel_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="lblComRosterMemberNewMessage" Font-Bold="true" ForeColor="Red" runat="server" ></asp:Label></td>
                    </tr>
                </table>
            </center>
        </asp:Panel>
    </asp:Panel>
    <asp:Button Style="display: none;" ID="btnComRosterMemberhidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewComRosterMember" runat="server" TargetControlID="btnComRosterMemberhidden1"
        PopupControlID="pnlComRosterMemberNewContent" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlComRosterMemberNewTitle"
        BehaviorID="jdpopupComRosterMembernew" /></asp:Content>
