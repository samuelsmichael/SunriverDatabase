<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="Envelope.aspx.cs" Inherits="SubmittalProposal.Reports.Envelope" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
    <table cellpadding="1" width="100%" cellspacing="1" border="0">
        <tr align="center">
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Print envelope for"></asp:Label>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" style="font-weight:bold;" ID="lblPrintEnvelopeFor" runat="server" ></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <asp:RadioButtonList ID="rbListTypeOfAddress" runat="server" RepeatDirection="Horizontal">
        <asp:ListItem Selected="True" Value="sunriver">Use Sunriver Address</asp:ListItem>
        <asp:ListItem Value="home">Use Home Address</asp:ListItem>
    </asp:RadioButtonList>
</asp:Content>
