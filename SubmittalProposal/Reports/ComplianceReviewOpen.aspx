<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="ComplianceReviewOpen.aspx.cs" Inherits="SubmittalProposal.Reports.ComplianceReviewOpen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="From date:"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbFromDate" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibtbFromDate" runat="server" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:CalendarExtender ID="cetbFromDate" runat="server" TargetControlID="tbFromDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbFromDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revReviewDateUpdate" Display="Dynamic"
                    ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                    ControlToValidate="tbFromDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="To date:"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbToDate" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibtbToDate" runat="server" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:CalendarExtender ID="cetbToDate" runat="server" TargetControlID="tbToDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbToDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbToDate" Display="Dynamic"
                    ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                    ControlToValidate="tbToDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
            </td>
        </tr>
    </table>
</asp:Content>
