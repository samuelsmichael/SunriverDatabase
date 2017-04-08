<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="OwnerConcernsReport.aspx.cs" Inherits="SubmittalProposal.Reports.OwnerConcernsReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Department:"></asp:Label>
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlDepartmentsParm" DataTextField="Department"
                    DataValueField="Department">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Report:"></asp:Label>
            </td>
            <td>
                <asp:DropDownList runat="server" ID="ddlReport">
                    <asp:ListItem Selected="True" Text="All Concerns" Value="All Concerns"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Concern Categories" Value="Concern Categories"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Concerns Open" Value="Concerns Open"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Concerns Closed" Value="Concerns Closed"></asp:ListItem>
                    <asp:ListItem Selected="False" Text="Category Summary" Value="Category Summary"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Start:"></asp:Label>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbOwnerConcernsStartDate"
                                runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibOwnerConcernsStartDate" runat="server" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:CalendarExtender ID="ceOwnerConcernsStartDate" runat="server"
                    TargetControlID="tbOwnerConcernsStartDate" Format="MM/dd/yyyy" PopupButtonID="ibOwnerConcernsStartDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revOwnerConcernsStartDate"
                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbOwnerConcernsStartDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="End:"></asp:Label>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbOwnerConcernsEndDate"
                                runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                ID="ibOwnerConcernsEndDate" runat="server" />
                        </td>
                    </tr>
                </table>
                <ajaxToolkit:CalendarExtender ID="ceOwnerConcernsEndDate" runat="server"
                    TargetControlID="tbOwnerConcernsEndDate" Format="MM/dd/yyyy" PopupButtonID="ibOwnerConcernsEndDate" />
                <asp:RegularExpressionValidator ForeColor="Red" ID="revOwnerConcernsEndDate"
                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                    ControlToValidate="tbOwnerConcernsEndDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
            </td>
        </tr>
    </table>
</asp:Content>
