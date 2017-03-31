<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="BallotVerify.aspx.cs" Inherits="SubmittalProposal.BallotVerify" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLotSearch" Width="20" MaxLength="5" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLaneSearch" Width="60" runat="server" DataTextField="Lane" DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="Owner Name"></asp:Label>
        <asp:TextBox ID="tbNameSearch" Width="75" MaxLength="25" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label4" runat="server" Text="Address"></asp:Label>
        <asp:TextBox ID="tbAddressSearch" Width="75" MaxLength="25" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label3" runat="server" Text="Postal Code"></asp:Label>
        <asp:TextBox ID="tbPostalCodeSearch" Width="40" MaxLength="25" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label18" runat="server" Text="Customer Id"></asp:Label>
        <asp:TextBox ID="tbCustdIdSearch" Width="40" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Property Id"></asp:Label>
        <asp:TextBox ID="tbPropertyIdSearch" Width="40" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label12" runat="server" Text="Voted"></asp:Label>
        <asp:DropDownList runat="server" ID="ddlVotedSearch">
            <asp:ListItem Selected="True"></asp:ListItem>
            <asp:ListItem>Yes</asp:ListItem>
            <asp:ListItem>No</asp:ListItem>
        </asp:DropDownList>
    </td>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height: 400px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting"
            DataKeyNames="BallotVerifyId">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="OwnerName" HeaderText="Owner Name" SortExpression="OwnerName" />
                <asp:BoundField DataField="tblArShipTo_Addr1" HeaderText="SR Address" SortExpression="tblArShipTo_Addr1" />
                <asp:BoundField DataField="PostalCode" HeaderText="Postal Code" SortExpression="PostalCode" />
                <asp:BoundField DataField="PropID" HeaderText="Property ID" SortExpression="PropID" />
                <asp:BoundField DataField="CustId" HeaderText="Owner ID" SortExpression="CustId" />            
                <asp:TemplateField HeaderText="Voted" SortExpression="Voted">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# getVoted(Eval("Voted")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <asp:Panel Width="95%" ID="pnlCitationsViolatorUpdate" runat="server" GroupingText="IDs">
        <table border="0" cellpadding="5" cellspacing="3">
            <tr valign="top">               
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="Property Id"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbPropertyIdUpdate" Width="45"
                    runat="server"></asp:TextBox>
                </td>
                <td class="form_field_heading">
                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Cust Id"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbCustomrIdUpdate" Width="45"
                    runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel Width="95%" ID="Panel1" runat="server" GroupingText="Info">
        <table border="0" cellpadding="5" cellspacing="3">
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Group Code"></asp:Label>
                </td>
                    <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbGroupCodeUpdate" Width="45"
                    runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Name"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbOwnerNameUpdate" Width="145"
                    runat="server"></asp:TextBox>
                </td>
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Addr1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbCustAddr1Update" Width="145"
                    runat="server"></asp:TextBox>
                </td>
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Addr2"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbCustAddr2Update" Width="145"
                    runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Contact"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbContactUpate" Width="145"
                    runat="server"></asp:TextBox>
                </td>
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Sunriver Addr"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbSunriverAddrUpdate" Width="145"
                    runat="server"></asp:TextBox>
                </td>
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Postal Code"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbPostalCodeUpdate" Width="45"
                    runat="server"></asp:TextBox>
                </td>
            <</tr>
        </table>
</asp:Panel>
    <asp:Panel Width="95%" ID="Panel2" runat="server" GroupingText="Has Voted">
        <table border="0" cellpadding="5" cellspacing="3">
            <tr valign="top">
                <td class="form_field_heading">
                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Has Voted"></asp:Label>
                </td>
                <td class="form_field">
                    <asp:CheckBox ID="cbVotedUpdate" runat="server" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnBallotVerifyUpdate" OnClick="btnBallotVerifyUpdateOkay_Click" Visible="false" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label runat="server" ID="BallotVerifyUpdateResultsId"></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>

