<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="OwnerPropertyReport_Envelope.aspx.cs" Inherits="SubmittalProposal.Reports.OwnerPropertyReport_Envelope" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
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
        </tr>
    </table>
    <asp:Panel runat="server" ID="pnlResults" Visible="false" Style="height: 200px; overflow: auto;">
        <h2 runat="server" id="pnlResultsHeading"></h2>
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
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
    <hr />
    <table cellpadding="3" width="100%">
        <tr valign="top">
            <td>
                <table>
                    <tr>
                        <td colspan="2" style="font-weight:bold;">
                            Return Address
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Name:
                        </td>
                        <td>
                            <asp:TextBox ID="tbReturnAddressName" Width="20em" runat="server" Text="Sunriver Homeowners Assocation"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address:
                        </td>
                        <td>
                            <asp:TextBox ID="tbReturnAddressAddress" Width="20em" Text="57455 Abbot Dr" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            City State Zip:
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbReturnAddressCity" Text="Sunriver" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbReturnAddressState" Text="OR" Width="2em" MaxLength="2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbReturnAddressZip" Text="97707" Width="6em" MaxLength="10" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
