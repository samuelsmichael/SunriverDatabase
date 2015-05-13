<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="ContractorAllData.aspx.cs" Inherits="SubmittalProposal.Reports.ContractorAllData" %>

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
                <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="List year as YYYY:"></asp:Label>
            </td>
            <td>
                <asp:TextBox CssClass="form_field" Width="75" ID="tbListYear" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" runat="server" ControlToValidate="tbListYear" ForeColor="Red" SetFocusOnError="true"  ErrorMessage="Required"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="RangeValidator1" MinimumValue="2001" MaximumValue="2199" ControlToValidate="tbListYear" runat="server" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter a valid year"></asp:RangeValidator>
            </td>
        </tr>
    </table>
</asp:Content>
