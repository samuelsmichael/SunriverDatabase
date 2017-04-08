<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="LapineRFDInvoices.aspx.cs" Inherits="SubmittalProposal.Reports.LapineRFDInvoices" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <table><tr><td>
                <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Report start date:"></asp:Label>
                <asp:TextBox CssClass="form_field" ID="tbFromDate" Width="9em" runat="server"></asp:TextBox>
                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibtbFromDate" runat="server" />
                </td>
                </tr></table>
                <ajaxToolkit:CalendarExtender ID="cetbFromDate" runat="server" TargetControlID="tbFromDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbFromDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbFromDate" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbFromDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>

            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Report end date:"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbToDate" Width="8em" runat="server"></asp:TextBox>
                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibtbToDate" runat="server" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:CalendarExtender ID="cetbToDate" runat="server" TargetControlID="tbToDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbToDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbToDate" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbToDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
            </td>
        </tr>
    </table>

</asp:Content>
