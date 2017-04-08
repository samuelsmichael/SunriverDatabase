<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="CitationsReport_ViolatorHistory.aspx.cs" Inherits="SubmittalProposal.Reports.CitationsReport_ViolatorHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="LastName:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbLastName" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="tbLastName" Font-Bold="true" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ErrorMessage="Required"></asp:RequiredFieldValidator>
</asp:Content>
