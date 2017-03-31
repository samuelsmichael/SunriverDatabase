<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="CitationsReport_ParkingWarningSummary.aspx.cs" Inherits="SubmittalProposal.Reports.CitationsReport_ParkingWarningSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Start Date:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbStartDate" runat="server" Width="8em"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="cetbStartDate" runat="server" TargetControlID="tbStartDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbStartDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revReviewDateUpdate" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbStartDate" runat="server" ErrorMessage="Please enter a valid date" SetFocusOnError="true"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="tbStartDate" Font-Bold="true" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                    ID="ibtbStartDate" runat="server" />
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="End Date:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbEndDate" runat="server" Width="8em"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="cetbEndDate" runat="server" TargetControlID="tbEndDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbEndDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator1" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbEndDate" runat="server" ErrorMessage="Please enter a valid date" SetFocusOnError="true"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbEndDate" Font-Bold="true" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                    ID="ibtbEndDate" runat="server" />
            </td>
        </tr>
    </table>

</asp:Content>
