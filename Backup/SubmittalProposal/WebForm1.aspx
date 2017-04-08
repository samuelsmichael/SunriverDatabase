<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SubmittalProposal.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
        <asp:Button ID="btnClose" runat="server" OnClick="bbb" Text="Close" />
    
    </div>
    </form>
    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewLRFDVehicleMaintenanceId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewLRFDVehicleMaintenanceTitleId">
            <span>New LRFDVehicle Work Order</span>
        </asp:Panel>

           <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlLRFDNewId"
                    GroupingText="Data Entry">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="By"></asp:Label>
                            </td>
                            <td style="white-space: nowrap;">
                                <asp:TextBox CssClass="form_field" MaxLength="20" Width="8em" runat="server" ID="tbRFDNewDataEntryBy"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbLRFDNewDataEntryDate" runat="server"></asp:TextBox>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbLRFDNewDataEntryDate" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="cetbLRFDNewDataEntryDate" runat="server" TargetControlID="tbLRFDNewDataEntryDate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibtbLRFDNewDataEntryDate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbLRFDNewDataEntryDate"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbLRFDNewDataEntryDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>


                <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlLRFDNew1"
                    GroupingText="Work Order Request">
                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label7nnn" runat="server" Text="Work Order #"></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_lbl" ID="lblRFDNewWOI" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label3x3nnn" runat="server" Text="Vehicle"></asp:Label>
                            </td>
                            <td colspan="4">
                                <asp:DropDownList ID="ddlRFDNewVehicleNumber" runat="server" DataValueField="Number"
                                    DataTextField="VechicleNameForDDLs">
                                </asp:DropDownList>
                                Dept: <asp:Label CssClass="form_field_lbl" ID="lblRFDNewDepartmentId" runat="server" Text=""></asp:Label><br />s
                                Admin: <asp:Label CssClass="form_field_lbl" ID="lblRFDNewDepartmentAdminCharges" runat="server" Text=""></asp:Label>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label6nnn" runat="server" Text="Request"></asp:Label>
                            </td>
                            <td>
                                <table border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td>
                                            By
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="form_field" MaxLength="20" Width="8em" runat="server" ID="tbRFDNewRequestedBy"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Date In</td>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" ID="tbLRFDNewRequestDateIn" runat="server"></asp:TextBox>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibtbLRFDNewRequestDateIn" runat="server" />
                                            <ajaxToolkit:CalendarExtender ID="cetbLRFDNewRequestDateIn" runat="server" TargetControlID="tbLRFDNewRequestDateIn"
                                                Format="MM/dd/yyyy" PopupButtonID="ibtbLRFDNewRequestDateIn" />
                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revtbLRFDNewRequestDateIn"
                                                Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                ControlToValidate="tbLRFDNewRequestDateIn" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                                                    <td>
                    <asp:Label CssClass="form_field_heading" ID="Label4nnn" runat="server" Text="Nature"></asp:Label>
                </td>
                            <td colspan="4">
                                <asp:TextBox ID="tbRFDNewVehicleDescription" Width="550px" TextMode="MultiLine"
                                    Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label CssClass="form_field_heading" ID="Label9nnn" runat="server" Text="Odometer Reading"></asp:Label></td>
                            <td><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbLRFDNewOdometerReading"></asp:TextBox></td>
                            <td><asp:Label CssClass="form_field_heading" ID="Label10nnn" runat="server" Text="Hour Meter"></asp:Label></td>
                            <td colspan="1"><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbLRFDNewHourReading"></asp:TextBox></td>
                            <td colspan="2">
                                <asp:Label ID="Label12" runat="server" Text="Estimate"></asp:Label>
                                <asp:DropDownList runat="server" ID="ddlYesNoBlankEstimateNew">
                                    <asp:ListItem Selected="True"></asp:ListItem>
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlWorkOrderResultsNew"
                    GroupingText="Work Order Results">
                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                        <tr>
                            <td>Procedure Performed</td>
                            <td>
                                <asp:TextBox ID="tbRFDNewProcedurePerformed" Width="550px" TextMode="MultiLine"
                                    Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                            <td>Date Out</td>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbRFDNewVehicleDateOut" runat="server"></asp:TextBox>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbRFDNewVehicleDateOut" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="cettbRFDNewVehicleDateOut" runat="server" TargetControlID="tbRFDNewVehicleDateOut"
                                    Format="MM/dd/yyyy" PopupButtonID="ibtbRFDNewVehicleDateOut" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbRFDNewVehicleDateOut"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbRFDNewVehicleDateOut" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>


            </asp:Panel>
                
                
                </body>
</html>
