<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="ContractorMailingLabels.aspx.cs" Inherits="SubmittalProposal.Reports.ContractorMailingLabels" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Registration start date:"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbRegistrationStartDate" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ImageAlign="AbsMiddle" CausesValidation="false" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibtbRegistrationStartDate" runat="server" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:CalendarExtender ID="cetbRegistrationStartDate" runat="server" TargetControlID="tbRegistrationStartDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbRegistrationStartDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revReviewDateUpdate" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbRegistrationStartDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="tbRegistrationStartDate" ForeColor="Red" SetFocusOnError="true"  ErrorMessage="Required"></asp:RequiredFieldValidator>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Registration end date:"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbRegistrationEndDate" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ImageAlign="AbsMiddle" CausesValidation="false" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibtbRegistrationEndDate" runat="server" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:CalendarExtender ID="cetbRegistrationEndDate" runat="server" TargetControlID="tbRegistrationEndDate"
                    Format="MM/dd/yyyy" PopupButtonID="ibtbRegistrationEndDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator1" Display="Dynamic"
                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbRegistrationStartDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" runat="server" ControlToValidate="tbRegistrationEndDate" ForeColor="Red" SetFocusOnError="true"  ErrorMessage="Required"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
</asp:Content>
