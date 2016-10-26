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
    </td></asp:Content>
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
                <asp:BoundField DataField="SRPhone" HeaderText="Phone" SortExpression="SRPhone" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="NRMailAddr" HeaderText="NR Address" SortExpression="NRMailAddr" />
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
