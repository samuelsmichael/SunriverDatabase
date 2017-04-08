<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="OwnerPropertyFinder.aspx.cs" Inherits="SubmittalProposal.OwnerPropertyFinder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
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
        <asp:Label ID="Label18" runat="server" Text="Name"></asp:Label>
        <asp:TextBox ID="tbNameSearch" Width="125" MaxLength="25" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="Property ID"></asp:Label>
        <asp:TextBox ID="tbPropertyID" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="First name"></asp:Label>
        <asp:TextBox ID="TextBox1" Width="125" MaxLength="25" runat="server"></asp:TextBox>
    </td>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:Panel runat="server" ID="pnlResults" Style="height:200px;overflow:auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
        
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="SRLot" HeaderText="Lot" SortExpression="SRLot" />
                <asp:BoundField DataField="SRLane" HeaderText="Lane" SortExpression="SRLane" />
                <asp:BoundField DataField="PrimaryOwner" HeaderText="Owner" SortExpression="PrimaryOwner" />
                <asp:BoundField DataField="SRPropID" HeaderText="Property Id" SortExpression="SRPropID" />
                <asp:BoundField DataField="CustID" HeaderText="Customer Id" SortExpression="CustID" />
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
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
                <asp:UpdatePanel ID="updatePanel3aa" runat="server">
                    <ContentTemplate>
                        <table cellpadding="4" width="100%" cellspacing="4" border="0">
                            <tr valign="top">
                                <td  width="50%" valign="top">
                                    <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="pnlOwnerPropertySearchInputUpdate" GroupingText="Input Info">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Owner Id"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" runat="server" ID="tbOwnerId" MaxLength="25" Width="165"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbName" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Contact"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbContact" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Sunriver phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbSunriverPhone"  MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbEmail" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnSelect" OnClick="btnSelect_Click" OnClientClick="return true;" 
            runat="server" Text="Select" />
        <asp:Label ID="lblDumbo" Font-Bold="true" runat="server" Text=""></asp:Label>
      
    </center>
                                
                            </ContentTemplate>
                        </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
