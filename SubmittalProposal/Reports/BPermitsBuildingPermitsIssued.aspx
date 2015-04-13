<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="BPermitsBuildingPermitsIssued.aspx.cs" Inherits="SubmittalProposal.Reports.BPermitsBuildingPermitsIssued" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Report heading:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbReportHeading" runat="server" Text="Building Permits - Issued"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="From date:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbFromDate" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="To date:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbToDate" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
