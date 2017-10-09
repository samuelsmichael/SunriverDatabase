<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="OwnerProperty.aspx.cs" Inherits="SubmittalProposal.OwnerProperty" %>

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
        <asp:Label ID="Label2" runat="server" Text="DC Address"></asp:Label>
        <asp:TextBox ID="tbDCAddress" runat="server" Width="125" MaxLength="33"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:Panel runat="server" ID="pnlResults" Style="height: 200px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="SRLot" HeaderText="Lot" SortExpression="SRLotSortable" />
                <asp:BoundField DataField="SRLane" HeaderText="Lane" SortExpression="SRLane" />
                <asp:BoundField DataField="PrimaryOwner" HeaderText="Owner" SortExpression="PrimaryOwner" />
                <asp:BoundField DataField="DC_Address" HeaderText="DC Address" SortExpression="DC_Address" />
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
                    <td width="50%" valign="top">
                        <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlOwnerPropertyOwnerInfoUpdate"
                            GroupingText="Owner Info">
                            <table cellpadding="4" width="100%" cellspacing="4" border="0">
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Owner Id"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" runat="server" ID="tbOwnerIdUpdate" MaxLength="25"
                                            Width="165"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbNameUpdate" MaxLength="25" Width="165" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Contact"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbContactUpdate" MaxLength="25" Width="165"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Mail Addr1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbMailAddr1Update" MaxLength="25" Width="165"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Mail Addr2"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbMailAddr2Update" MaxLength="25" Width="165"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="City"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbMailCityUpdate" MaxLength="25" Width="165"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="State"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbMailStateUpdate" MaxLength="25" Width="165"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Country"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbMailCountryUpdate" MaxLength="25" Width="165"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Zip"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbMailZipUpdate" MaxLength="25" Width="165"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                    <td width="50%" valign="top">
                        <table cellpadding="4" width="100%" cellspacing="4" border="0">
                            <tr>
                                <td>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlOwnerPropertyCommunicationsUpdate"
                                        GroupingText="Communications">
                                        <table cellpadding="4" width="100%" cellspacing="4" border="0">
                                            <tr>
                                                <td width="30%">
                                                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Sunriver phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbSunriverPhoneUpdate" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Fax"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbFaxUpdate" MaxLength="25" Width="165" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbEmailUpdate" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Internet"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbInternetUpdate" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlOwnerPropertyPropertyInfo"
                                        GroupingText="Property Information">
                                        <table cellpadding="4" cellspacing="4" width="100%" style="border: thin solid #0000aa;">
                                            <tr>
                                                <td colspan="2" style="background: #C0C0DE; text-align: center; color: #0000aa">
                                                    SROA Database
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="30%">
                                                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="PropID"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox CssClass="form_field" ID="tbPropIDUpdate" Width="165" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="30%">
                                                    <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="Property Addr"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox CssClass="form_field" ID="tbPropertyAddrUpdate" Width="165" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="30%">
                                                    <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Purchase Date"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox CssClass="form_field" ID="tbPurchaseDateUpdate" Width="165" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <table cellpadding="4" cellspacing="4" width="100%" style="border: thin solid #0000aa;
                                            margin-top: 4px;">
                                            <tr>
                                                <td colspan="2" style="background: #C0C0DE; text-align: center; color: #0000aa">
                                                    Deschutes County Database
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="30%">
                                                    <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="DC Tax Lot ID"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox CssClass="form_field" ID="tbDCTaxLotIDUpdate" Width="165" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="30%">
                                                    <asp:Label CssClass="form_field_heading" ID="Label23" runat="server" Text="DC Address"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox CssClass="form_field" ID="tbDCAddressUpdate" Width="165" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <center>
                <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
                    ID="btnSubmitUpdate" OnClick="btnSubmitUpdate_Click" OnClientClick="return true;"
                    runat="server" Text="Submit" />
                <asp:Label ID="lblDumbo" Font-Bold="true" runat="server" Text=""></asp:Label>
            </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
