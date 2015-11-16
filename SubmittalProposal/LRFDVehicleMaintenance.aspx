<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="LRFDVehicleMaintenance.aspx.cs" Inherits="SubmittalProposal.LRFDVehicleMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label01" runat="server" Text="Vehicle #"></asp:Label>
        <asp:DropDownList ID="ddlVehicle_Search" runat="server" DataValueField="Number" DataTextField="VechicleNameForDDLs">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Work Order ID"></asp:Label>
        <asp:TextBox ID="tbWorkOrder_Search" runat="server" MaxLength="10" Width="10em" Text="LRFD-"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height: 350px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="VWOID" HeaderText="VWOID" SortExpression="VWOID" />
                <asp:BoundField DataField="fkNumber" HeaderText="Vehicle #" SortExpression="fkNumber" />
                <asp:BoundField DataField="VehicleName" HeaderText="Vehicle Name" SortExpression="VehicleName" />
                <asp:BoundField DataField="Date In" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Request Date In"
                    SortExpression="Date In" />
                <asp:BoundField DataField="Request By" HeaderText="Requested By" SortExpression="Requested By" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <ajaxToolkit:TabContainer Height="316" ActiveTabIndex="0" ID="tcLRFDUpdateTabWorkOrder" AutoPostBack="true"
                        runat="server">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelOwnerInformation" HeaderText="Work Order">
            <ContentTemplate>

                <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlLRFDUpdate0"
                    GroupingText="Data Entry">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="By"></asp:Label>
                            </td>
                            <td style="white-space: nowrap;">
                                <asp:TextBox CssClass="form_field" MaxLength="20" Width="8em" runat="server" ID="tbRFDUpdateDataEntryBy"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbLRFDUpdateDataEntryDate" runat="server"></asp:TextBox>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbLRFDUpdateDataEntryDate" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="cetbLRFDUpdateDataEntryDate" runat="server" TargetControlID="tbLRFDUpdateDataEntryDate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibtbLRFDUpdateDataEntryDate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbLRFDUpdateDataEntryDate"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbLRFDUpdateDataEntryDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>

                <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlLRFDUpdate1"
                    GroupingText="Work Order Request">
                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Work Order #"></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_lbl" ID="lblRFDUpdateWOI" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label3x3" runat="server" Text="Vehicle"></asp:Label>
                            </td>
                            <td colspan="4">
                                <asp:DropDownList ID="ddlRFDUpdateVehicleNumber" runat="server" DataValueField="Number"
                                    DataTextField="VechicleNameForDDLs">
                                </asp:DropDownList>
                                Dept: <asp:Label CssClass="form_field_lbl" ID="lblRFDUpdateDepartmentId" runat="server" Text=""></asp:Label>
                                Admin: <asp:Label CssClass="form_field_lbl" ID="lblRFDUpdateDepartmentAdminCharges" runat="server" Text=""></asp:Label>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Request"></asp:Label>
                            </td>
                            <td>
                                <table border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td>
                                            By
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="form_field" MaxLength="20" Width="8em" runat="server" ID="tbRFDUpdateRequestedBy"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Date In</td>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" ID="tbLRFDUpdateRequestDateIn" runat="server"></asp:TextBox>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibtbLRFDUpdateRequestDateIn" runat="server" />
                                            <ajaxToolkit:CalendarExtender ID="cetbLRFDUpdateRequestDateIn" runat="server" TargetControlID="tbLRFDUpdateRequestDateIn"
                                                Format="MM/dd/yyyy" PopupButtonID="ibtbLRFDUpdateRequestDateIn" />
                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revtbLRFDUpdateRequestDateIn"
                                                Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                ControlToValidate="tbLRFDUpdateRequestDateIn" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                                                    <td>
                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Nature"></asp:Label>
                </td>
                            <td colspan="4">
                                <asp:TextBox ID="tbRFDUpdateVehicleDescription" Width="550px" TextMode="MultiLine"
                                    Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Odometer Reading"></asp:Label></td>
                            <td><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbLRFDUpdateOdometerReading"></asp:TextBox></td>
                            <td><asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Hour Meter"></asp:Label></td>
                            <td colspan="1"><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbLRFDUpdateHourReading"></asp:TextBox></td>
                            <td colspan="2">
                                <asp:Label ID="Label12" runat="server" Text="Estimate"></asp:Label>
                                <asp:DropDownList runat="server" ID="ddlYesNoBlankEstimateUpdate">
                                    <asp:ListItem Selected="True"></asp:ListItem>
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlWorkOrderResults"
                    GroupingText="Work Order Results">
                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                        <tr>
                            <td>Procedure Performed</td>
                            <td>
                                <asp:TextBox ID="tbRFDUpdateProcedurePerformed" Width="550px" TextMode="MultiLine"
                                    Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                            <td>Date Out</td>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbRFDUpdateVehicleDateOut" runat="server"></asp:TextBox>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbRFDUpdateVehicleDateOut" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="cetbRFDUpdateVehicleDateOut" runat="server" TargetControlID="tbRFDUpdateVehicleDateOut"
                                    Format="MM/dd/yyyy" PopupButtonID="ibtbLRFDUpdateRequestDateIn" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbRFDUpdateVehicleDateOut"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbRFDUpdateVehicleDateOut" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabRFDUpdateParts" HeaderText="Parts-Labor-Services">
            <ContentTemplate>
                <table border="0" cellpadding="3" cellspacing="0" width="100%">
                    <tr>
                        <td>Parts</td>
                        <td>
                            <div style="overflow:auto;height:6em;">

                                <asp:GridView Width="100%" ID="gvRFDUpdateParts" runat="server" AutoGenerateColumns="False"
                                    CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True" 
                                    OnRowCancelingEdit="gvUpdateParts_RowCancelingEdit"
                                    OnRowEditing="gvUpdateParts_RowEditing" 
                                    OnRowUpdating="gvUpdateParts_RowUpdating" DataKeyNames="VWOPartID">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                    <EmptyDataTemplate>
                                        <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true"
                                            ShowCancelButton="true" />
                                        <asp:BoundField DataField="VWOPartID" HeaderText="ID" SortExpression="VWOPartID" />
                                        <asp:TemplateField HeaderText="Nbr">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdd3" runat="server" Text='<%# Bind("PTDescription") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbRFDUpdatePartsPTDescription" runat="server" Text= '<%# Bind("PtDescription") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Comments</td>
                        <td colspan="4">
                            <asp:TextBox ID="tbRFDUpdateComments" Width="550px" TextMode="MultiLine"
                                Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

    </ajaxToolkit:TabContainer>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnRFDUpdate" OnClick="btnRFDUpdate_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblRFDUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
   
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
