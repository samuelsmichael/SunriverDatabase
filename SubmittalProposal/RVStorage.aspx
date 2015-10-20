<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="RVStorage.aspx.cs" Inherits="SubmittalProposal.RVStorage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="Last name"></asp:Label>
        <asp:TextBox ID="tbLastNameSearch" Width="125" MaxLength="25" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="lblSpaceInfo" runat="server" Text="Space #"></asp:Label>
        <asp:DropDownList runat="server" ID="ddlSpaceInfoSearch" DataTextField="tSISpace" DataValueField="tSISpace">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="RV Lease Id"></asp:Label>
        <asp:TextBox ID="tbRVLeaseId" Width="46" MaxLength="6" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" AllowPaging="True" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
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
            <asp:BoundField DataField="FirstName" HeaderText="FName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="L Name" SortExpression="LastName" />
            <asp:BoundField DataField="tRVDSpace" HeaderText="Space" SortExpression="tRVDSpace" />
            <asp:BoundField DataField="SunriverPhone" HeaderText="Sunriver Phone" SortExpression="SunriverPhone" />
            <asp:TemplateField HeaderText="Cancelled" SortExpression="LeaseCancelled">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# getLeaseCancelled(Eval("LeaseCancelled")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="RVLeaseID" HeaderText="Lease ID" SortExpression="RVLeaseID" />
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
