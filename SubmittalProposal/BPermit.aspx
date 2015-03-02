<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="BPermit.aspx.cs" Inherits="SubmittalProposal.BPermit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
                <td>
                    <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
                    <asp:TextBox ID="tbLot" Width="30" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
                    <asp:DropDownList ID="ddlLane" runat="server">
                        <asp:ListItem>Choose lane</asp:ListItem>
                        <asp:ListItem>Sage Springs</asp:ListItem>
                        <asp:ListItem>Salishan</asp:ListItem>
                        <asp:ListItem>Sandhill</asp:ListItem>
                        <asp:ListItem>Sandtrap</asp:ListItem>
                        <asp:ListItem>Sarazen</asp:ListItem>
                        <asp:ListItem>Sequoia</asp:ListItem>
                        <asp:ListItem>Shadow</asp:ListItem>
                        <asp:ListItem>Shag Bark</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label ID="Label22" runat="server" Text="Submittal Id"></asp:Label>
                    <asp:TextBox ID="tbSubmittalId" Width="66" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label23" runat="server" Text="BPermit Id"></asp:Label>
                    <asp:TextBox ID="tbBPermitId" Width="66" runat="server"></asp:TextBox>
                </td>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" 
        style="width:100%; white-space:nowrap;" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="gvResults_SelectedIndexChanged" 
        onsorting="gvResults_Sorting"
    >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ButtonType="Link"
                    SelectText="Select"  ShowSelectButton="true" />
            <asp:BoundField DataField="Lot" HeaderText="Lot" SortExpression="Lot" />
            <asp:BoundField DataField="Lane" HeaderText="Lane" SortExpression="Lane" />
            <asp:BoundField DataField="SubmittalId" HeaderText="Submittal Id" 
                SortExpression="SubmittalId" />
            <asp:BoundField DataField="BPermitId" HeaderText="BPermitId" 
                SortExpression="BPermitId" />
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
