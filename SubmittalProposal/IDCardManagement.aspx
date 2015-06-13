<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="IDCardManagement.aspx.cs" Inherits="SubmittalProposal.IDCardManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td width="300">
        <asp:Label ID="Label21" runat="server" Text="Find by Lot Number Order"></asp:Label>
        <asp:DropDownList Font-Names="Courier New" AutoPostBack="true"
            ID="ddlLotLaneOrder" runat="server" DataTextField="SrLotLaneOwner" 
            DataValueField="PropIdBarCustId" 
            onselectedindexchanged="ddlLotLaneOrder_SelectedIndexChanged" >
        </asp:DropDownList>
    </td>
    <td width="300">
        <asp:Label ID="Label1" runat="server" Text="Find by Name Order"></asp:Label>
        <asp:DropDownList Font-Names="Courier New" AutoPostBack="true"
            ID="ddlNameOrder" runat="server" DataTextField="NameSRLotLane" 
            DataValueField="PropIdBarCustId" 
            onselectedindexchanged="ddlNameOrder_SelectedIndexChanged" >
        </asp:DropDownList>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <table width="100%">
        <tr>
            <th width="50%" align="center">
                Property
            </th>
            <th width="50%" align="center">
                Owner
            </th>
        </tr>
        <tr>
            <td width="50%" align="center">
                <table>
                    <tr>
                        <td>
                            Lot/Lane
                        </td>
                        <td>
                            <asp:Label ID="lbPropertyLotLane" runat="server"> </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            County Address
                        </td>
                        <td>
                            <asp:Label ID="lbPropertyCountyAddress" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Property Id
                        </td>
                        <td>
                            <asp:Label ID="lbPropertyPropertyId" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="50%" align="center">
                <table>
                    <tr>
                        <td>
                            Name
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerName" runat="server"> </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerAddressStreet" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerCityStateZip" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Phone
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerPhone" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <asp:GridView Width="100%" ID="gvCardholders" runat="server" AutoGenerateColumns="False"
        CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True" OnRowCancelingEdit="gvCardholders_RowCancelingEdit"
        OnRowEditing="gvCardholders_RowEditing" OnRowUpdating="gvCardholders_RowUpdating" DataKeyNames="CardID">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
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
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true"
                ShowCancelButton="true" />
            <asp:TemplateField HeaderText="Card ID">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CardID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <EditItemTemplate>
                    <asp:TextBox ID="tbBPPaymentFeeUpdate" runat="server" Text='<%# Bind("cdFirstName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("cdFirstName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
