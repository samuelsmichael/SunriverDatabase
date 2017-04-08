<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="ComRoster_HomeReport_CommitteeListAll.aspx.cs" Inherits="SubmittalProposal.Reports.ComRoster_HomeReport_CommitteeListAll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <center><table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Report Date:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbReportDate" runat="server" Width="8em"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="cetbReportDate" runat="server" TargetControlID="tbReportDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbReportDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revReviewDateUpdate" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbReportDate" runat="server" ErrorMessage="Please enter a valid date" SetFocusOnError="true"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="tbReportDate" Font-Bold="true" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table></center>
</asp:Content>
