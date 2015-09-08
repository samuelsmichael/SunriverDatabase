<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="SellCheckLetter.aspx.cs" Inherits="SubmittalProposal.Reports.SellCheckLetter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="InspectionID:"></asp:Label>
                    <asp:TextBox CssClass="form_field" ID="tbInspectionID" Width="4em" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>

</asp:Content>
