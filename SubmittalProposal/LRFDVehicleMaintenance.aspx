<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="LRFDVehicleMaintenance.aspx.cs" Inherits="SubmittalProposal.LRFDVehicleMaintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label01" runat="server" Text="Vehicle #"></asp:Label>
        <asp:DropDownList ID="ddlVehicle_Search" runat="server" DataValueField="Number" DataTextField="VechicleNameForDDLs"></asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Work Order ID"></asp:Label>
        <asp:TextBox ID="tbWorkOrder_Search" runat="server" MaxLength="10" Width="10em" Text="LRFD-"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height:350px; overflow:auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting"
            >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="VWOID" HeaderText="VWOID" SortExpression="VWOID" />
                <asp:BoundField DataField="fkNumber" HeaderText="Vehicle #" SortExpression="fkNumber" />
                <asp:BoundField DataField="VehicleName" HeaderText="Vehicle Name" SortExpression="VehicleName" />
                <asp:BoundField DataField="Date In" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Request Date In"
                    SortExpression="Date In" />
                <asp:BoundField DataField="Request By" HeaderText="Requested By" SortExpression="Requested By" />
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
