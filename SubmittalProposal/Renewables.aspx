<%@ Page Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="Renewables.aspx.cs" Inherits="SubmittalProposal.Renewables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Project Name"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbProjectName" Width="85" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="Business"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbBusinessName" Width="85" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="RenewableID"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbRenewableID" Width="35" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="GridView1" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
        DataKeyNames="renewID" CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" SortExpression="ProjectName" />
            <asp:BoundField DataField="Business" HeaderText="Business Name" SortExpression="Business" />
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <table border="0" cellpadding="0" cellspacing="2">
        <tr valign="top">
            <td valign="top">
                <asp:Label CssClass="form_field_heading" ID="Label7xaa" runat="server" Text="Project Name"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbRenewablesProjectNameUpdate" MaxLength="100" Width="15em" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label7sxx2" runat="server" Text="Business Name"></asp:Label>
            </td>
            <td colspan="1">
                <td>
                    <asp:TextBox ID="tbRenewablesBusinessNameUpdate" MaxLength="50" Width="15em" runat="server"></asp:TextBox>
                </td>
            </td>
        </tr>
    </table>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnRenewablesUpdate" OnClick="btnRenewablesUpdateOkay_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblRenewablesResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <center>
        <asp:Button ID="lbNewRenewable" CausesValidation="false" OnClick="lbNewRenewable_OnClick" Text="New Renewable"
            runat="server"></asp:Button>
    </center>

    <asp:Panel runat="server" CssClass="newitempopup" Width="800" ID="pnlRenewableNewContent">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlRenewableNewTitle">
            <span>New Renewable</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewRenewableContent"
            CssClass="newitemcontent">
            <table border="0" cellpadding="0" cellspacing="2">
                <tr valign="top">
                    <td valign="top">
                        <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Project Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbRenewablesProjectNameNew" MaxLength="100" Width="15em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Business Name"></asp:Label>
                    </td>
                    <td colspan="1">
                        <td>
                            <asp:TextBox ID="tbRenewablesBusinessNameNew" MaxLength="50" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </td>
                </tr>
            </table>
            <center>
                <table cellpadding="3">
                    <tr>
                        <td>
                            <asp:Button CausesValidation="true" TabIndex="21" OnClientClick="javascript: return true;"
                                ID="btnNewRenewablesOkay" runat="server" Text="Okay" OnClick="btnNewRenewablesOk_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnRenewablesNewCancel" TabIndex="22" runat="server" Text="Abort"
                                CausesValidation="false" OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                OnClick="btnNewRenewablesCancel_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="lblRenewalbesNewMessage" Font-Bold="true" ForeColor="Red" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </center>
        </asp:Panel>
    </asp:Panel>
    <asp:Button Style="display: none;" ID="btnrenewablehidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewRenewable" runat="server" TargetControlID="btnrenewablehidden1"
        PopupControlID="pnlRenewableNewContent" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlRenewableNewTitle"
        BehaviorID="jdpopuprenewablenew" />

</asp:Content>
