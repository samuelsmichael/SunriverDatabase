<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="Envelope.aspx.cs" Inherits="SubmittalProposal.Reports.Envelope" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
    <center>
        <table cellpadding="2" cellspacing="1" border="0">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Print envelope for"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" Style="font-weight: bold;" ID="lblPrintEnvelopeFor"
                        runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </center>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table cellpadding="3" width="100%">
        <tr valign="top">
            <td>
                <table>
                    <tr>
                        <td colspan="2">
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
