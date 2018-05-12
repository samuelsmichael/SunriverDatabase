<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="SubmittalProposal.Reports.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
        <table>
            <tr>
             <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Reg Date:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbRegDate" runat="server" Width="8em"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="cetbStartDate" runat="server" TargetControlID="tbRegDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbStartDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revReviewDateUpdate" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbRegDate" runat="server" ErrorMessage="Please enter a valid date" SetFocusOnError="true"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="tbRegDate" Font-Bold="true" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                    ID="ibtbStartDate" runat="server" />
            </td>
                </tr>
            </table>
</asp:Content>
