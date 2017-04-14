<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="CitationsReport_CitationData.aspx.cs" Inherits="SubmittalProposal.Reports.CitationsReport_CitationData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Citation #:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbCitationNbr" runat="server" Width="6em"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="tbCitationNbr" Font-Bold="true" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>

</asp:Content>
