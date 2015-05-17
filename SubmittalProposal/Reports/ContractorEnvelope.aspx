<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="ContractorEnvelope.aspx.cs" Inherits="SubmittalProposal.Reports.ContractorEnvelope" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Contractor:"></asp:Label>
                <asp:DropDownList CssClass="form_field" runat="server" ID="ddlContractor" DataTextField="Company" DataValueField="SRContrRegID"></asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
