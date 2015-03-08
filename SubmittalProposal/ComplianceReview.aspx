<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="ComplianceReview.aspx.cs" Inherits="SubmittalProposal.ComplianceReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td width="40">
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLot" Width="30" runat="server"></asp:TextBox>
    </td>
    <td width="100">
        <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" runat="server" 
            DataTextField="Lane" DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td width="184">
        <asp:Label ID="Label1" runat="server" Text="Comments"></asp:Label>
        <asp:TextBox ID="tbComments" Width="180" runat="server"></asp:TextBox>
    </td>
    <td width="184">
        <asp:Label ID="Label2" runat="server" Text="Rule"></asp:Label>
        <asp:TextBox ID="tbRule" Width="100" runat="server"></asp:TextBox>
    </td>
    <td width="66">
        <asp:Label ID="Label22" runat="server" Text="Review Id"></asp:Label>
        <asp:TextBox ID="tbReviewId" Width="66" runat="server"></asp:TextBox>
    </td>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" 
        style="width:100%;" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="gvResults_SelectedIndexChanged" 
        onsorting="gvResults_Sorting"
    >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link"
                    SelectText="Select"  ShowSelectButton="true" />
            <asp:BoundField DataField="crDate" DataFormatString=" {0:d}" 
                HeaderText="Review Date" SortExpression="crDate" >
            <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="crLot" HeaderText="Lot" SortExpression="crLot" />
            <asp:BoundField DataField="crLane" HeaderText="Lane" SortExpression="crLane" />
            <asp:BoundField DataField="crComments" HeaderText="Comments" />
            <asp:BoundField DataField="crRule" HeaderText="Rule" />
            <asp:BoundField DataField="crCorrection" HeaderText="Correction" />
            <asp:BoundField DataField="crFollowUp" HeaderText="Follow-up" >
            <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="crCloseDate" DataFormatString=" {0:d}" SortExpression="crCloseDate"
                HeaderText="Close" />
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
