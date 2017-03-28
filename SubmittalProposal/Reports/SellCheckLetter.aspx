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
            <td>
                    <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Employee:"></asp:Label>
                    <asp:DropDownList ID="ddlEmployee" runat="server">
                        <asp:ListItem>Claire McClafferty</asp:ListItem>
                        <asp:ListItem>Shane Hostbjor</asp:ListItem>
                    </asp:DropDownList>
            </td>
            <td>
                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Title:"></asp:Label>
                    <asp:DropDownList ID="ddlTitle" runat="server">
                        <asp:ListItem>Code Enforcement Officer</asp:ListItem>
                        <asp:ListItem>Field Operator</asp:ListItem>
                    </asp:DropDownList>
            </td>
        </tr>
    </table>

</asp:Content>
