<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="SellCheck.aspx.cs" Inherits="SubmittalProposal.SellCheck" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="Recipient"></asp:Label>
        <asp:TextBox ID="tbRecipient" Width="80" runat="server"></asp:TextBox>
    </td>

    <td>
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLot" Width="40" MaxLength="5" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" Width="100" runat="server" DataTextField="Lane" DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label3" runat="server" Text="Copy 1"></asp:Label>
        <asp:TextBox ID="tbscLTCCopy1" Width="80" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label23" runat="server" Text="Request ID"></asp:Label>
        <asp:TextBox ID="tbRequestId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="Property ID"></asp:Label>
        <asp:TextBox ID="tbPropertyID" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Inspection ID"></asp:Label>
        <asp:TextBox ID="tbInspectionID" Width="46" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" AllowPaging="true" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
        CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting"
        OnPageIndexChanging="gvResults_PageIndexChanging" PageSize="15">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" Position="Bottom"
            PageButtonCount="15" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="scLTDate" HeaderText="Date" SortExpression="dateYYYYMMDD" DataFormatString="{0:d}" />
            <asp:BoundField DataField="scLot" HeaderText="Lot" SortExpression="scLot" />
            <asp:BoundField DataField="scLane" HeaderText="Lane" SortExpression="scLane" />
            <asp:BoundField DataField="scLTRecipient" HeaderText="Recipient" SortExpression="scLTRecipient" />
            <asp:BoundField DataField="scLTCCopy1" HeaderText="CCopy1" SortExpression="scLTCCopy1" />
            <asp:BoundField DataField="scRequestID" HeaderText="Request ID" SortExpression="scRequestID" />
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
