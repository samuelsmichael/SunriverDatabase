<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="SROAVehicleMaintenance.aspx.cs" Inherits="SubmittalProposal.SROAVehicleMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label01" runat="server" Text="Vehicle #"></asp:Label>
        <asp:DropDownList ID="ddlVehicle_Search" runat="server" DataValueField="Number" DataTextField="VechicleNameForDDLs">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Work Order ID"></asp:Label>
        <asp:TextBox ID="tbWorkOrder_Search" runat="server" MaxLength="10" Width="10em" Text="SROA-"></asp:TextBox>
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
                <asp:BoundField DataField="Request By" HeaderText="Requested By" SortExpression="Request By" />
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
    <ajaxToolkit:TabContainer Height="316" ActiveTabIndex="0" ID="tcSROAUpdateTabWorkOrder" AutoPostBack="true"
                        runat="server">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelOwnerInformation" HeaderText="Work Order">
            <ContentTemplate>

                <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlSROAUpdate0"
                    GroupingText="Data Entry">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="By"></asp:Label>
                            </td>
                            <td style="white-space: nowrap;">
                                <asp:TextBox CssClass="form_field" MaxLength="20" Width="8em" runat="server" ID="tbSROAUpdateDataEntryBy"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Date"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbSROAUpdateDataEntryDate" runat="server"></asp:TextBox>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbSROAUpdateDataEntryDate" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="cetbSROAUpdateDataEntryDate" runat="server" TargetControlID="tbSROAUpdateDataEntryDate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibtbSROAUpdateDataEntryDate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbSROAUpdateDataEntryDate"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbSROAUpdateDataEntryDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>

                <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlSROAUpdate1"
                    GroupingText="Work Order Request">
                    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Work Order #"></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_lbl" ID="lbSROAUpdateWOI" runat="server" Text=""></asp:Label>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label3x3" runat="server" Text="Vehicle"></asp:Label>
                            </td>
                            <td colspan="4">
                                <asp:DropDownList ID="ddSROAUpdateVehicleNumber" runat="server" DataValueField="Number"
                                    DataTextField="VechicleNameForDDLs">
                                </asp:DropDownList>
                                Dept: <asp:Label CssClass="form_field_lbl" ID="lbSROAUpdateDepartmentId" runat="server" Text=""></asp:Label><br />
                                Admin: <asp:Label CssClass="form_field_lbl" ID="lbSROAUpdateDepartmentAdminCharges" runat="server" Text=""></asp:Label>
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
                                            <asp:TextBox CssClass="form_field" MaxLength="20" Width="8em" runat="server" ID="tbSROAUpdateRequestedBy"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Date In</td>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" ID="tbSROAUpdateRequestDateIn" runat="server"></asp:TextBox>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibtbSROAUpdateRequestDateIn" runat="server" />
                                            <ajaxToolkit:CalendarExtender ID="cetbSROAUpdateRequestDateIn" runat="server" TargetControlID="tbSROAUpdateRequestDateIn"
                                                Format="MM/dd/yyyy" PopupButtonID="ibtbSROAUpdateRequestDateIn" />
                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revtbSROAUpdateRequestDateIn"
                                                Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                ControlToValidate="tbSROAUpdateRequestDateIn" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                                                    <td>
                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Nature"></asp:Label>
                </td>
                            <td colspan="4">
                                <asp:TextBox ID="tbSROAUpdateVehicleDescription" Width="550px" TextMode="MultiLine"
                                    Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Odometer Reading"></asp:Label></td>
                            <td><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbSROAUpdateOdometerReading"></asp:TextBox></td>
                            <td><asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Hour Meter"></asp:Label></td>
                            <td colspan="1"><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbSROAUpdateHourReading"></asp:TextBox></td>
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
                                <asp:TextBox ID="tbSROAUpdateProcedurePerformed" Width="550px" TextMode="MultiLine"
                                    Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                            <td>Date Out</td>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbSROAUpdateVehicleDateOut" runat="server"></asp:TextBox>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbSROAUpdateVehicleDateOut" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="cettbSROAUpdateVehicleDateOut" runat="server" TargetControlID="tbSROAUpdateVehicleDateOut"
                                    Format="MM/dd/yyyy" PopupButtonID="ibtbSROAUpdateVehicleDateOut" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbSROAUpdateVehicleDateOut"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbSROAUpdateVehicleDateOut" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabSROAUpdateParts" HeaderText="Parts-Labor-Services">
            <ContentTemplate>
                <table border="0" cellpadding="3" cellspacing="0" width="100%">
                    <tr valign="top">
                        <td valign="top">Parts</td>
                        <td>
                            <div style="overflow:auto;height:6em;">

                                <asp:GridView Width="100%" ID="gvSROAUpdateParts" runat="server" AutoGenerateColumns="False"
                                    CellPadding="1" ForeColor="#333333" GridLines="None" ShowFooter="true" 
                                    OnRowCancelingEdit="gvUpdateParts_RowCancelingEdit"
                                    OnRowEditing="gvUpdateParts_RowEditing" Font-Size="X-Small"
                                    OnRowDeleting="gvUpdateParts_RowDeleting"
                                    OnRowUpdating="gvUpdateParts_RowUpdating" DataKeyNames="VWOPartID"
                                    OnRowDataBound ="gvUpdateParts_OnRowDataBound">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <EditRowStyle BackColor="#999999" Font-Size="X-Small" />
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
                                        <asp:Label ID="lblEmptyTxt" runat="server" Text="No Parts items"></asp:Label>
                                    </EmptyDataTemplate>                                    
                                    <Columns>
                                        <asp:CommandField ItemStyle-Width="75px" ButtonType="Link" CausesValidation="false" ShowDeleteButton="true" ShowEditButton="true"
                                            ShowCancelButton="true" />
                                        <asp:TemplateField ItemStyle-Width="125px" HeaderText="Description" SortExpression="PTDescription" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xddxxx3" runat="server" Text='<%# Bind("PTDescription") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdatePartsPTDescription" runat="server" Width="100px" MaxLength="30" Text= '<%# Bind("PtDescription") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField  ItemStyle-Width="55px" HeaderText="Number" SortExpression="PTNumber" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdyyyd3" runat="server" Text='<%# Bind("PTNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdatePartsPTNumber" Width="55px" MaxLength="15"  runat="server" Text= '<%# Bind("PtNumber") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Width="75px" HeaderText="Rate" SortExpression="PTRate"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdzzzd3" runat="server" Text= '<%# Eval("PTRate","{0:c}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdatePartsPTRate" Width="75px" MaxLength="10"  runat="server" Text= '<%# Eval("PTRate","{0:c}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Width="61px" HeaderText="Quantity" SortExpression="PtQuan"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdred3" runat="server" Text= '<%# Bind("PtQuan") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdatePartsPTQuantity" Width="35px" MaxLength="4"  runat="server" Text= '<%# Bind("PtQuan") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField  ItemStyle-Width="100px" HeaderText="Cost" ItemStyle-BackColor="#ffff99"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xderd3" runat="server" Text= '<%# getCost(Eval("PtQuan"),Eval("PtRate")) %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Width="125px" HeaderText="Surcharge" ItemStyle-BackColor="#ffff99"   HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3ccfxdd3" runat="server"   Text= '<%# getSurcharge(Eval("PtQuan"),Eval("PtRate")) %>'></asp:Label>
                                                <asp:Label ID="Label344xu" runat="server" Text= '<%# getSurchargeRateAsPercentage() %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Total Parts Cost:
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Width="100px" HeaderText="Item Cost"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-BackColor="#ffff99" ControlStyle-BackColor="#FFFF99">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdddddg3" runat="server" Text= '<%# getItemCost(Eval("PtQuan"),Eval("PtRate")) %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblX102" runat="server" Text='<%# getTotalPartsCostString() %>'></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField ReadOnly="true"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataField="VWOPartID" HeaderText="PardId" ControlStyle-BackColor="LightGray" SortExpression="VWOPartID" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                                <center style="margin-top: 0px;">
                                    <asp:LinkButton ID="lbSROANewPart" CausesValidation="false" OnClick="lblSROANewPart_OnClick" runat="server">New Part</asp:LinkButton>
                                </center>
                            <asp:Button runat="server" ID="btndummyNewPart" Style="display: none" />
                            <asp:Panel runat="server" CssClass="newitempopup" ID="pnlSROAPanelNewPart">
                                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlSROAPanelNewPartTitle">
                                    <span>New Part</span>
                                </asp:Panel>
                                <asp:Panel runat="server" Style="text-align: center;" ID="Panel2" CssClass="newitemcontent">
                                    <table>
                                        <tr>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Description"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbPartDescriptionNew" Width="17em" MaxLength="30" runat="server"></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Part Number"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbPartNumberNew" Width="7em" MaxLength="15" runat="server"></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Cost"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbSROAPartRateNew" Width="7em" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbSROAPartRateNew" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbSROAPartRateNew" ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$" runat="server"
                                                    ErrorMessage="Must be amnt"></asp:RegularExpressionValidator>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Quantity"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox ID="tbSROANewPartsPTQuantity" Width="45px" MaxLength="4"  runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbSROANewPartsPTQuantity" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbSROANewPartsPTQuantity" ValidationExpression="^[0-9]+$" runat="server"
                                                    ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>      
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <center>
                                    <table cellpadding="3">
                                        <tr>
                                            <td>
                                                <asp:Button CausesValidation="true" OnClientClick="javascript: return donewPartjedisok();" ID="btnNewSROAPartOk"
                                                    runat="server" Text="Okay" OnClick="btnNewSROAPartOk_Click" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnNewSROAPartCancel" CausesValidation="false" OnClientClick="if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                                    runat="server" Text="Abort" />
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                            </asp:Panel>
                            <ajaxToolkit:ModalPopupExtender ID="mpeSROANewPart" runat="server" TargetControlID="btndummyNewPart"
                                PopupControlID="pnlSROAPanelNewPart" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlSROAPanelNewPartTitle"
                                BehaviorID="jdpopupbSROAnewPart" />
                        </td>
                    </tr>
                    
                    <tr valign="top">
                        <td valign="top">Labor</td>
                        <td>
                            <div style="overflow:auto;height:6em;">

                                <asp:GridView Width="100%" ID="gvSROAUpdateLabor" runat="server" AutoGenerateColumns="False"
                                    CellPadding="1" ForeColor="#333333" GridLines="None" ShowFooter="true" 
                                    OnRowCancelingEdit="gvUpdateLabor_RowCancelingEdit"
                                    OnRowDataBound="gvUpdateLabor_OnRowDataBound"
                                    OnRowEditing="gvUpdateLabor_RowEditing" Font-Size="X-Small"
                                    OnRowDeleting="gvUpdateLabor_RowDeleting"
                                    OnRowUpdating="gvUpdateLabor_RowUpdating" DataKeyNames="VWOLaborID">
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
                                        <asp:Label ID="lblEmptyTxt" runat="server" Text="No Labor items"></asp:Label>
                                    </EmptyDataTemplate>                                    
                                    <Columns>
                                        <asp:CommandField ItemStyle-Width="100px" HeaderStyle-Width="100px" ButtonType="Link" CausesValidation="false" ShowEditButton="true"
                                            ShowCancelButton="true" ShowDeleteButton="true" />
                                        <asp:TemplateField ItemStyle-Width="150px" HeaderStyle-Width="150px" HeaderText="Mechanic" SortExpression="MechName" 
                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdmsrred3" runat="server" Text='<%# Bind("MechName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddSROAUpdateLaborMechName" DataTextField="MechName" DataValueField="MechID"></asp:DropDownList>
                                                <asp:Label ID="lbSROAUpdateLaborMechName" runat="server" Text='<%# Bind("MechName") %>' Visible="false"></asp:Label>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField  ItemStyle-Width="100px" HeaderStyle-Width="100px" HeaderText="Rate $/Hr" SortExpression="MechRate"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xddx3" runat="server" Text='<%# Eval("MechRate","{0:c}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdateLaborMechRate" runat="server" Text= '<%# Eval("MechRate","{0:c}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField  ItemStyle-Width="150px" HeaderStyle-Width="150px" HeaderText="Hours" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="marre3Ladbel3xdd3x" runat="server" Text= '<%# Bind("MechHours") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdateLaborMechHours" runat="server" Text= '<%# Bind("MechHours") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>Total Labor Cost:</FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Width="222px" HeaderStyle-Width="222px" HeaderText="Cost" ItemStyle-BackColor="#ffff99"   HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" >
                                            <ItemTemplate>
                                                <asp:Label ID="ddLdadbel3xdd3" runat="server" Text= '<%# getCost(Eval("MechHours"),Eval("MechRate")) %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblX102" runat="server" Text='<%# getTotalLaborCostString() %>'></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField  ReadOnly="true"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataField="VWOLaborID" HeaderText="Labor ID" ControlStyle-BackColor="LightGray" SortExpression="VWOLaborID" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                            <center style="margin-top: -8px;">
                                <asp:LinkButton ID="lbSROANewLabor" CausesValidation="false" OnClick="lbSROANewLabor_OnClick"  runat="server">New Labor</asp:LinkButton>
                            </center>
                            <asp:Button runat="server" ID="btndummyNewLabor" Style="display: none" />
                            <asp:Panel runat="server" CssClass="newitempopup" ID="pnlSROAPanelNewLabor">
                                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlSROAPanelNewLaborTitle">
                                    <span>New Labor</span>
                                </asp:Panel>
                                <asp:Panel runat="server" Style="text-align: center;" ID="Panel6x12" CssClass="newitemcontent">
                                    <table>
                                        <tr>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Mechanic Name"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:DropDownList OnSelectedIndexChanged="ddSROANewLaborMechName_OnSelectedIndexChanged" AutoPostBack="true" runat="server" ID="ddSROANewLaborMechName" DataTextField="MechName" DataValueField="MechID"></asp:DropDownList>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label33" runat="server" Text="Rate"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbSROALaborRateNew" Width="6em" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbSROALaborRateNew" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbSROALaborRateNew" ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$" runat="server"
                                                    ErrorMessage="Must be amnt"></asp:RegularExpressionValidator>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Labelx33" runat="server" Text="Hours"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbSROALaborHoursNew" Width="3em" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbSROALaborHoursNew" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbSROALaborHoursNew" ValidationExpression="^[0-9]+$" runat="server"
                                                    ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <center>
                                    <table cellpadding="3">
                                        <tr>
                                            <td>
                                                <asp:Button CausesValidation="true" OnClientClick="javascript: return donewlaborjedisok();" ID="btnNewSROALaborOk"
                                                    runat="server" Text="Okay" OnClick="btnNewSROALaborOk_Click" />
                                            </td>
                                            <td>
                                                <asp:Button CausesValidation="false" ID="btnNewSROALaborCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                                    runat="server" Text="Abort" />
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                            </asp:Panel>
                            <ajaxToolkit:ModalPopupExtender ID="mpeSROANewLabor" runat="server" TargetControlID="btndummyNewLabor"
                                PopupControlID="pnlSROAPanelNewLabor" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlSROAPanelNewLaborTitle"
                                BehaviorID="jdpopupbSROAnewlabor" />

                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">Service</td>
                        <td>
                            <div style="overflow:auto;height:6em;">

                                <asp:GridView Width="100%" ID="gvSROAUpdateService" runat="server" AutoGenerateColumns="False"
                                    CellPadding="1" ForeColor="#333333" GridLines="None" ShowFooter="true" 
                                    OnRowCancelingEdit="gvUpdateService_RowCancelingEdit"
                                    OnRowDeleting="gvUpdateService_RowDeleting"
                                    OnRowDataBound ="gvUpdateService_OnRowDataBound"
                                    OnRowEditing="gvUpdateService_RowEditing" Font-Size="X-Small"
                                    OnRowUpdating="gvUpdateService_RowUpdating" DataKeyNames="VWOCtrServID">
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
                                        <asp:Label ID="lblEmptyTxt" runat="server" Text="No Service Items"></asp:Label>
                                    </EmptyDataTemplate>                                    
                                    <Columns>
                                        <asp:CommandField ItemStyle-Width="100px" HeaderStyle-Width="100px" ButtonType="Link" CausesValidation="true" ShowEditButton="true"
                                            ShowCancelButton="true" ShowDeleteButton="true" />
                                        <asp:TemplateField HeaderText="Description" SortExpression="CSDescription" 
                                             ItemStyle-Width="210px" HeaderStyle-Width="210px"
                                             HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xddsss3" runat="server" Text='<%# Bind("CSDescription") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdateServiceDescription" runat="server" Text= '<%# Bind("CSDescription") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vendor" SortExpression="CSVendor" ItemStyle-Width="150px" HeaderStyle-Width="150px"
                                             HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FooterStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xddttt3" runat="server" Text='<%# Bind("CSVendor") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdateServiceVendor" runat="server" Text= '<%# Bind("CSVendor") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>Total Contracted Services:</FooterTemplate>
                                            
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cost" SortExpression="CSCost" 
                                            ItemStyle-Width="264px" HeaderStyle-Width="264px"
                                            ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xddx3" runat="server" Text='<%# Eval("CSCost","{0:c}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbSROAUpdateServiceCost" runat="server" Text= '<%# Eval("CSCost","{0:c}") %>'></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbSROAUpdateServiceCost" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbSROAUpdateServiceCost" ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$" runat="server"
                                                    ErrorMessage="Must be amnt"></asp:RegularExpressionValidator>

                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label style="text-align:right;" ID="lblX102" runat="server" Text='<%# getTotalServicesCostString() %>'></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" DataField="VWOCtrServID" HeaderText="Service ID" ControlStyle-BackColor="LightGray" SortExpression="VWOCtrServID" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                            <table style="margin-top:0px; font-size:x-small;" width="100%" cellpadding="0" border="0" cellspacing="0">
                                <tr>
                                    <td align="right" style="width:644px; font-weight:bold;">Total Work Order:</td>
                                    <td align="right" style="font-weight:bold;">
                                        <asp:Label runat="server" ID="lblTotalWorkOrderCost"></asp:Label>
                                    </td>
                                    <td style="width:86px;"></td>
                                </tr>
                            </table>
                            <center style="margin-top: -16px;">
                                <asp:LinkButton  CausesValidation="false" ID="lbSROANewService" OnClick="lbSROANewService_OnClick" runat="server">New Service</asp:LinkButton>
                            </center>
                            <asp:Button runat="server" ID="btndummyNewService" Style="display: none" />
                            <asp:Panel runat="server" CssClass="newitempopup" ID="pnlSROAPanelNewService">
                                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlSROAPanelNewServiceTitle">
                                    <span>New Service</span>
                                </asp:Panel>
                                <asp:Panel runat="server" Style="text-align: center;" ID="Panel1" CssClass="newitemcontent">
                                    <table>
                                        <tr>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Description"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbServiceDescriptionNew" Width="35em" MaxLength="50" runat="server"></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Vendor"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbServiceVendorNew" Width="12em" MaxLength="20" runat="server"></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Cost"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbSROAServiceCostNew" Width="7em" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbSROAServiceCostNew" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbSROAServiceCostNew" ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$" runat="server"
                                                    ErrorMessage="Must be amnt"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <center>
                                    <table cellpadding="3">
                                        <tr>
                                            <td>
                                                <asp:Button OnClientClick="javascript: return donewServicejedisok();" ID="btnNewSROAServiceOk"
                                                    runat="server" Text="Okay" OnClick="btnNewSROAServiceOk_Click" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnNewSROAServiceCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                                    runat="server" Text="Abort" />
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                            </asp:Panel>
                            <ajaxToolkit:ModalPopupExtender ID="mpeSROANewService" runat="server" TargetControlID="btndummyNewService"
                                PopupControlID="pnlSROAPanelNewService" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlSROAPanelNewServiceTitle"
                                BehaviorID="jdpopupbSROAnewService" />


                        </td>
                    </tr>

                    
                    <tr>
                        <td>Comments</td>
                        <td colspan="4">
                            <asp:TextBox ID="tbSROAUpdateComments" Width="530px" TextMode="MultiLine"
                                Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

    </ajaxToolkit:TabContainer>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnSROAUpdate" OnClick="btnSROAUpdate_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lbSROAUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
   
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <asp:LinkButton ID="lbSROAVehicleMaintenanceNew" OnClick="lbSROAVehicleMaintenanceNew_OnClick" Visible="false" runat="server">New SROAVehicle Work Order</asp:LinkButton>
    <center>
        <asp:Label ID="lbSROANewResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
    <asp:Button style="display:none;" ID="btnhidden1xx" runat="server" />
      <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewSROAVehicleMaintenanceId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewSROAVehicleMaintenanceTitleId">
            <span>New SROAVehicle Work Order</span>
        </asp:Panel>

        <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlSROANew0Id"
                GroupingText="Data Entry">
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label19nn" runat="server" Text="By"></asp:Label>
                    </td>
                    <td style="white-space: nowrap;">
                        <asp:TextBox MaxLength="20" Width="8em"  runat="server" ID="tbSROANewDataEntryBy"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label20nn" runat="server" Text="Date"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field_date" ID="tbSROANewDataEntryDate" runat="server"></asp:TextBox>
                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                            ID="ibtbSROANewDataEntryDate" runat="server" />
                        <ajaxToolkit:CalendarExtender ID="cetbSROANewDataEntryDate" runat="server" TargetControlID="tbSROANewDataEntryDate"
                            Format="MM/dd/yyyy" PopupButtonID="ibtbSROANewDataEntryDate" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="revtbSROANewDataEntryDate"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbSROANewDataEntryDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                </tr>
            </table>
            </asp:Panel>
    
        <asp:Panel runat="server" CssClass="form_field_panel_squished" ID="pnlSROANew1"
            GroupingText="Work Order Request">
            <table border="0" cellpadding="3" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_lbl" ID="lbSROANewWOI" runat="server" Text="Work Order #"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field_alwaysprotected" Enabled="false" ID="tbNewWorkOrderNbr" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label3x3nnn" runat="server" Text="Vehicle"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:DropDownList ID="ddSROANewVehicleNumber" AutoPostBack="true" OnSelectedIndexChanged="ddSROANewVehicleNumber_OnSelectedIndexChanged"  runat="server" DataValueField="Number"
                            DataTextField="VechicleNameForDDLs">
                        </asp:DropDownList>
                        Dept: <asp:Label CssClass="form_field_lbl" ID="lbSROANewDepartmentId" runat="server" Text=""></asp:Label>
                        Admin: <asp:Label CssClass="form_field_lbl" ID="lbSROANewDepartmentAdminCharges" runat="server" Text=""></asp:Label>
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
                                    <asp:TextBox CssClass="form_field" MaxLength="20" Width="8em" runat="server" ID="tbSROANewRequestedBy"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Date In</td>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" ID="tbSROANewRequestDateIn" runat="server"></asp:TextBox>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibtbSROANewRequestDateIn" runat="server" />
                                    <ajaxToolkit:CalendarExtender ID="cetbSROANewRequestDateIn" runat="server" TargetControlID="tbSROANewRequestDateIn"
                                        Format="MM/dd/yyyy" PopupButtonID="ibtbSROANewRequestDateIn" />
                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revtbSROANewRequestDateIn"
                                        Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                        ControlToValidate="tbSROANewRequestDateIn" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label4nnn" runat="server" Text="Nature"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="tbSROANewVehicleDescription" Width="500px" TextMode="MultiLine"
                            Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label CssClass="form_field_heading" ID="Label9nnn" runat="server" Text="Odometer Reading"></asp:Label></td>
                    <td><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbSROANewOdometerReading"></asp:TextBox></td>
                    <td><asp:Label CssClass="form_field_heading" ID="Label10nnn" runat="server" Text="Hour Meter"></asp:Label></td>
                    <td colspan="1"><asp:TextBox CssClass="form_field" MaxLength="10" Width="8em" runat="server" ID="tbSROANewHourReading"></asp:TextBox></td>
                    <td>
                        <asp:Label ID="Label19" runat="server" Text="Estimate"></asp:Label>
                    </td>
                    <td>
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
                    <td align="left">
                        <asp:TextBox ID="tbSROANewProcedurePerformed" Width="500px" TextMode="MultiLine"
                            Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="true"></asp:TextBox>
                    </td>
                    <td>Date Out</td>
                    <td>
                        <asp:TextBox CssClass="form_field_date" ID="tbSROANewVehicleDateOut" runat="server"></asp:TextBox>
                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                            ID="ibtbSROANewVehicleDateOut" runat="server" />
                        <ajaxToolkit:CalendarExtender ID="cettbSROANewVehicleDateOut" runat="server" TargetControlID="tbSROANewVehicleDateOut"
                            Format="MM/dd/yyyy" PopupButtonID="ibtbSROANewVehicleDateOut" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="revtbSROANewVehicleDateOut"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbSROANewVehicleDateOut" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>Comments</td>
                    <td align="left">
                        <asp:TextBox ID="tbSROANewComments" Width="500px" TextMode="MultiLine"
                            Height="3em"  CssClass="form_field" style=" font-size: 1em !important;" runat="server" Enabled="true"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </asp:Panel>

         <script  language="javascript" type="text/javascript" >
             function doOk() {

                 var loading = $(".loadingdb");
                 loading.show();
                 var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                 var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                 loading.css({ top: top, left: left });
                 return true;
             }
             function donewServicejedisok() {
                 var loading = $(".loadingdb");
                 loading.show();
                 var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                 var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                 loading.css({ top: top, left: left });
                 return true;
             }
             function donewlaborjedisok() {
                 var loading = $(".loadingdb");
                 loading.show();
                 var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                 var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                 loading.css({ top: top, left: left });
                 return true;
             }
             function donewPartjedisok() {
                 var loading = $(".loadingdb");
                 loading.show();
                 var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                 var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                 loading.css({ top: top, left: left });
                 return true;
             }

             // Called when async postback ends
             function prm_EndRequest(sender, args) {
                 // get the divImage and hide it again
                 //debugger
                 if (sender._postBackSettings.sourceElement.id.indexOf("BtnGo") != -1 || sender._postBackSettings.sourceElement.id.indexOf("gvResults") != -1
                || (sender._postBackSettings.sourceElement.id.indexOf("btnNew") != -1 && sender._postBackSettings.sourceElement.id.indexOf("Ok") != -1)) {
                     var loading = $(".loading");
                     loading.hide();
                 }
             }

        </script>
        <center>
            <table cellpadding="4">
                <tr>
                    <td>
                        <asp:Button ID="btnNewSROAVehicleMaintenanceOk"  OnClientClick="javascript: if(Page_IsValid) { return doOk();}" CausesValidation="true" runat="server" Text="Okay" 
                            onclick="btnNewSROAVehicleMaintenanceOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewbtnNewSROAVehicleMaintenanceNewCancel" onclick="btnNewSSROAVehicleMaintenanceCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to abort?')" runat="server" Text="Abort" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblSubmitalNewResults" Font-Bold="true" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>

            <div class="loadingdb" align="center">
                Processing. Please wait.<br />
                <br />
                <img src="Images/animated_progress.gif" alt="" />
            </div>



        </center>

    </asp:Panel>

    <ajaxToolkit:ModalPopupExtender ID="mpeSROAVehicleMaintenance" runat="server" TargetControlID="btnhidden1xx"
        PopupControlID="pnlNewSROAVehicleMaintenanceId" BackgroundCssClass="modalBackground" 
        PopupDragHandleControlID="pnlNewSROAVehicleMaintenanceTitleId"
        BehaviorID="jdpopupsSROAVehicleMaintenanceBehaviorId" />
    <script language="javascript" type="text/javascript">

    </script>
</asp:Content>
