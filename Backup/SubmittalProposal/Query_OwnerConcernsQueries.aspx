<%@ Page Title="" Language="C#" MasterPageFile="~/AbstractQuery2.master" AutoEventWireup="true"
    CodeBehind="Query_OwnerConcernsQueries.aspx.cs" Inherits="SubmittalProposal.Query_OwnerConcernsQueries" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderQueryParms" runat="server">
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Department:"></asp:Label>
                <asp:DropDownList runat="server" ID="ddlDepartmentsParm" DataTextField="Department"
                    DataValueField="Department">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Category:"></asp:Label>
                <asp:DropDownList runat="server" ID="ddlCategoryParm" DataTextField="Category" DataValueField="Category">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Open/Closed:"></asp:Label>
                <asp:DropDownList runat="server" ID="ddlOpensCloseds">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                    <asp:ListItem Text="Open" Value="True"></asp:ListItem>
                    <asp:ListItem Text="Closed" Value="False"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Start:"></asp:Label>
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
