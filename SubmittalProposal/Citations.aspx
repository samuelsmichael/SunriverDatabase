<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="Citations.aspx.cs" Inherits="SubmittalProposal.Citations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="LastName"></asp:Label>
        <asp:TextBox ID="tbCitationLastNameLU" Width="80" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Fine Status"></asp:Label>
        <asp:DropDownList ID="ddlFineStatusLU" DataTextField="FineStatus" DataValueField="FineStatus"
            runat="server">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="Citation#"></asp:Label>
        <asp:TextBox ID="tbCitationIDLU" Width="46" MaxLength="10" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height: 400px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False" DataKeyNames="CitationID"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="VFirstName" HeaderText="First Name" SortExpression="VFirstName" />
                <asp:BoundField DataField="VLastName" HeaderText="Last Name" SortExpression="VLastName" />
                <asp:BoundField DataField="OffenseDate" HeaderText="Offence Date" SortExpression="OffenseDate"
                    DataFormatString="{0:d}" />
                <asp:BoundField DataField="FineStatus" HeaderText="Fine Status" SortExpression="FineStatus" />
                <asp:BoundField DataField="Citation#" HeaderText="Citation#" SortExpression="Citation#" />
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
    <asp:Panel ID="pnlCitationsViolatorUpdate" runat="server" GroupingText="Violator">
        <table border="0" cellpadding="0" cellspacing="2">
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="Last Name"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbCitationsLastNameUpdate" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Sunriver Status"></asp:Label>
                </td>
                <td colspan="1">
                    <asp:DropDownList ID="ddlSunriverStatusUpdate" DataTextField="SunriverStatus" DataValueField="SunriverStatus"
                        runat="server">
                    </asp:DropDownList>
                </td>
                <td colspan="2" rowspan="2">
                    <table>
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Citing Officer"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tbCitingOfficerUpdate" MaxLength="20" Width="11em" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Hearing Date"></asp:Label>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" ID="tbHearingDateUpdate" Width="7em" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibHearingDateUpdate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <ajaxToolkit:CalendarExtender ID="cvHearingDateUpdate" runat="server" TargetControlID="tbHearingDateUpdate"
                        Format="MM/dd/yyyy" PopupButtonID="ibHearingDateUpdate" />
                    <asp:RegularExpressionValidator ForeColor="Red" ID="rvcvHearingDateUpdate" Display="Dynamic"
                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                        ControlToValidate="tbHearingDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </td>
                <td><asp:Label CssClass="form_field_heading" ID="Label30" runat="server" Text="Citation#"></asp:Label></td>
                <td><asp:TextBox ID="tbCitationNbrUpdate" Width="46" MaxLength="10" runat="server"></asp:TextBox>
                    <asp:CustomValidator ID="cvCitationNbrUpdate" ControlToValidate="tbCitationNbrUpdate" ValidateEmptyText="true"
                        Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                        ErrorMessage="Req'd" OnServerValidate="cvCitationNbr_ServerValidateUpdate"></asp:CustomValidator>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="First Name"></asp:Label>
                </td>
                <td colspan="7">
                    <asp:TextBox ID="tbCitationsFirstNameUpdate" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Address1"></asp:Label>
                </td>
                <td colspan="7">
                    <asp:TextBox ID="tbCitationsAddress1Update" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Address2"></asp:Label>
                </td>
                <td colspan="7">
                    <asp:TextBox ID="tbCitationsAddress2Update" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="City"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbCitationsCityUpdate" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                </td>
                <td align="right">
                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="State"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbCitationsStateUpdate" MaxLength="2" Width="3em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Zip"></asp:Label>
                </td>
                <td align="left" colspan="1">
                    <asp:TextBox ID="tbCitationsZipUpdate" MaxLength="10" Width="8em" runat="server"></asp:TextBox>
                </td>
                <td align="left" colspan="2">
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlCitations" runat="server" GroupingText="Violations List">
        <table border="0">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="lbl17x332" runat="server" Text="Date"></asp:Label>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbCitationsViolationsDateUpdate" Width="7em"
                                    runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibCitationsViolationsDateUpdate" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <ajaxToolkit:CalendarExtender ID="ceCitationsViolationsDateUpdate" runat="server"
                        TargetControlID="tbCitationsViolationsDateUpdate" Format="MM/dd/yyyy" PopupButtonID="ibCitationsViolationsDateUpdate" />
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revCitationsViolationsDateUpdate"
                        Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                        ControlToValidate="tbCitationsViolationsDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="lbl17x332a3" runat="server" Text="Location"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" runat="server" ID="tbCitationsViolationsLocationUpdate"
                        Width="20em" MaxLength="50"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div style="height: 8em; width: 900px; overflow: auto;">
                        <asp:GridView ID="gvViolations" Style="width: 100%; white-space: nowrap;" runat="server"
                            AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"
                            OnRowEditing="gvViolations_RowEditing" OnRowUpdating="gvViolations_RowUpdating"
                            OnRowCancelingEdit="gvViolations_RowCancelingEdit" ShowFooter="True" OnRowDataBound="gvViolations_RowDataBound">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true"
                                    ShowCancelButton="true" />
                                <asp:TemplateField HeaderText="Rule #" SortExpression="fkRuleID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRuleIDItemUpdate" runat="server" Text='<%# Bind("fkRuleID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblRuleIDEditUpdate" runat="server" Text='<%# Eval("fkRuleID") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Violation Id" SortExpression="ViolationID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblViolationIdItem" runat="server" Text='<%# Bind("ViolationID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblViolationIdEdit" runat="server" Text='<%# Eval("ViolationID") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rule Description" SortExpression="RuleDescription">
                                    <ItemTemplate>
                                        <asp:Label ID="tbRuleDescriptionUpdate" runat="server" Text='<%# Bind("RuleDescription") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlRulesUpdate" runat="server" DataTextField="RuleDescription"
                                            DataValueField="RuleID">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fine $" SortExpression="ScheduleFine">
                                    <ItemTemplate>
                                        <asp:Label ID="lblScheduleFineUpdate" runat="server" Text='<%# Bind("ScheduleFine", "{0:c}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbScheduleFineUpdate" runat="server" Text='<%# Bind("ScheduleFine", "{0:c}") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblSumFine" runat="server"></asp:Label>
                                        &nbsp;Total fine
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Warning" SortExpression="IssueAsWarning">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIssueAsWarningUpdate" runat="server" Style="padding: 2px;" Text='<%# Bind("IssueAsWarning") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="cbIssueAsWarningUpdate" runat="server" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ViolationNotes" HeaderText="Violation Notes" SortExpression="ViolationNotes" />
                                <asp:BoundField DataField="ORS#" HeaderText="ORS #" SortExpression="ORS#" />
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
                    <center>
                        <asp:LinkButton ID="lbNewViolation" CausesValidation="false" OnClientClick="javascript: return true;" OnClick="lbNewViolation_OnClick"
                            runat="server">New Violation</asp:LinkButton>
                    </center>
                </td>
            </tr>
        </table>
        <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewViolation">
            <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewViolationTitle">
                <span>New Violation</span>
            </asp:Panel>
            <asp:Panel runat="server" Style="text-align: center;" ID="Panelx36" CssClass="newitemcontent">
                <table border="0" cellpadding="3" cellspacing="3">
                    <tr>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Rule "></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:DropDownList ID="ddlRulesNew" runat="server" DataTextField="RuleDescription"
                                DataValueField="RuleID">
                            </asp:DropDownList>
                        </td>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label1x12" runat="server" Text="Fine $ "></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:TextBox ID="tbScheduleFineNew" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="ORS #"></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:TextBox ID="tbORSNumberNew" runat="server"></asp:TextBox>
                        </td>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Labelab22" runat="server" Text="Issued as a Warning "></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:CheckBox ID="cbIssueAsWarningNew" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Labelabc22" runat="server" Text="Notes"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="tbViolationNotesNew" Width="99%" TextMode="MultiLine" Height="4em"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:Label ID="lblNewViolationMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
                <center>
                    <table cellpadding="3">
                        <tr>
                            <td>
                                <asp:Button CausesValidation="true" OnClientClick="javascript: return true;"
                                    ID="btnNewViolationOk" runat="server" Text="Okay" OnClick="btnNewViolationOk_Click" />
                            </td>
                            <td>
                                <asp:Button ID="btnNewViolationCancel" runat="server" Text="Abort" CausesValidation="false"
                                    OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                    OnClick="btnNewViolationCancel_Click" />
                            </td>
                        </tr>
                    </table>
                </center>
            </asp:Panel>
        </asp:Panel>
        <asp:Button runat="server" ID="dummyNewViolation" Style="display: none" />
        <ajaxToolkit:ModalPopupExtender ID="mpeNewViolation" runat="server" TargetControlID="dummyNewViolation"
            PopupControlID="pnlNewViolation" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewViolationTitle" />
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlCitationsFineUpdate" GroupingText="Fine Information">
        <table width="100%">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label1sx0" runat="server" Text="Fine Status"></asp:Label>
                </td>
                <td colspan="5">
                    <asp:DropDownList runat="server" ID="ddlCitationsFineStatusUpdate" DataTextField="FineStatus"
                        DataValueField="FineStatus">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="font-weight: bold;">
                    Calculated Value No Data Entry
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Magistrate Fine"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbMagistrateFineUpdate" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                    <asp:CustomValidator ID="cvMagistrateFine" ControlToValidate="tbMagistrateFineUpdate"
                        Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                        ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvMagistrateFine_ServerValidate"></asp:CustomValidator>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="To Accounting"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbToAccountingUpdate" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                    <asp:CustomValidator ID="cvToAccounting" ControlToValidate="tbToAccountingUpdate"
                        Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                        ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvToAccounting_ServerValidate"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="lblTotalCitationFine" runat="server"
                        Text="Total Citation Fine"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbTotalCitationFineUpdate" MaxLength="7" Width="6em" runat="server"
                        ReadOnly="true"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label13x3a" runat="server" Text="Judicial Fine"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbJudicialFineUpdate" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                    <asp:CustomValidator ID="cvJudicialFine" ControlToValidate="tbJudicialFineUpdate"
                        Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                        ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvJudicialFine_ServerValidate"></asp:CustomValidator>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label14x3" runat="server" Text="Writeoff Amount"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbWriteoffAmountUpdate" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                    <asp:CustomValidator ID="cvWriteoffAmount" ControlToValidate="tbWriteoffAmountUpdate"
                        Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                        ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvWriteoffAmount_ServerValidate"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Labelqppa" runat="server" Text="Pre-pay Amount"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbPrepayAmount" MaxLength="7" Width="6em" FontBold="true" ForeColor="Red"
                        runat="server" ReadOnly="true"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Assessed Fine"></asp:Label>
                </td>
                <td colspan="3">
                    <asp:TextBox ID="tbAssessedFineUpdate" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                    <asp:CustomValidator ID="cvAssessedFine" ControlToValidate="tbAssessedFineUpdate"
                        Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                        ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvAssessedFine_ServerValidate"></asp:CustomValidator>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlMagistrateNotes" GroupingText="Magistrate Notes">
        <div style="height: 3.3em; overflow: auto;">
            <asp:TextBox runat="server" Height="2em" Width="95%" TextMode="MultiLine" ID="tbMagistrateNotesUpdate"></asp:TextBox>
        </div>
    </asp:Panel>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnCitationsUpdate" OnClick="btnCitationsUpdateOkay_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblCitationsUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
        <asp:Label ID="lblDatePrintedHeading" runat="server" Text="Printed: "></asp:Label>
        <asp:Label ID="lblDatePrinted" runat="server"></asp:Label>
        <asp:Button Style="margin-left: 1em;" ID="btnPrintForm" runat="server" OnClick="btnPrintForm_OnClick"
            CausesValidation="false" Text="Print Form" OnClientClick="javascript:window.print(); return true;" />
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <center>
        <asp:Button ID="lbNewCitation" CausesValidation="false" OnClick="lbNewCitation_OnClick" Text="New Citation"
            runat="server"></asp:Button>
    </center>
    <asp:Panel runat="server" CssClass="newitempopup" Width="800" ID="pnlCitationNewContent">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlCitationNewTitle">
            <span>New Citation</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewCitationContent"
            CssClass="newitemcontent">
            <asp:Panel ID="pnlCitationsViolatorNew" runat="server" GroupingText="Violator">
                <table border="0" cellpadding="0" cellspacing="2">
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Last Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbCitationsLastNameNew" TabIndex="1" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Sunriver Status"></asp:Label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList ID="ddlSunriverStatusNew" TabIndex="8" DataTextField="SunriverStatus" DataValueField="SunriverStatus"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                        <td colspan="2" rowspan="2">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="Citing Officer"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbCitingOfficerNew" TabIndex="9" MaxLength="20" Width="11em" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label20" runat="server" Text="Hearing Date"></asp:Label>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_date" TabIndex="10" ID="tbHearingDateNew" Width="7em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton TabIndex="-1"  ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibHearingDateNew" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender ID="cvHearingDateNew" runat="server" TargetControlID="tbHearingDateNew"
                                Format="MM/dd/yyyy" PopupButtonID="ibHearingDateNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="rvcvHearingDateNew" Display="Dynamic"
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbHearingDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td><asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Citation#"></asp:Label></td>
                        <td><asp:TextBox ID="tbCitationNbrNew" TabIndex="11" Width="46" MaxLength="10" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvCitationNbrNew" ControlToValidate="tbCitationNbrNew" ValidateEmptyText="true"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Req'd" OnServerValidate="cvCitationNbr_ServerValidateNew"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label21" runat="server" Text="First Name"></asp:Label>
                        </td>
                        <td colspan="7">
                            <asp:TextBox ID="tbCitationsFirstNameNew" TabIndex="2" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label23" runat="server" Text="Address1"></asp:Label>
                        </td>
                        <td colspan="7">
                            <asp:TextBox ID="tbCitationsAddress1New" TabIndex="3" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label24" runat="server" Text="Address2"></asp:Label>
                        </td>
                        <td colspan="7">
                            <asp:TextBox ID="tbCitationsAddress2New" TabIndex="4" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label25" runat="server" Text="City"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbCitationsCityNew" TabIndex="5" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                        </td>
                        <td align="right">
                            <asp:Label CssClass="form_field_heading" ID="Label26" runat="server" Text="State"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbCitationsStateNew" TabIndex="6" MaxLength="2" Width="3em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Zip"></asp:Label>
                        </td>
                        <td align="left" colspan="1">
                            <asp:TextBox ID="tbCitationsZipNew" TabIndex="7" MaxLength="10" Width="8em" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="Panel1" runat="server" GroupingText="Violations List">
                <table border="0">
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label28" runat="server" Text="Date"></asp:Label>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox CssClass="form_field_date" ID="tbCitationsViolationsDateNew" TabIndex="12" Width="7em"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton  TabIndex="-2" ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            ID="ibCitationsViolationsDateNew" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender ID="ceCitationsViolationsDateNew" runat="server" TargetControlID="tbCitationsViolationsDateNew"
                                Format="MM/dd/yyyy" PopupButtonID="ibCitationsViolationsDateNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="revCitationsViolationsDateNew"
                                Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbCitationsViolationsDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label29" runat="server" Text="Location"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" runat="server" ID="tbCitationsViolationsLocationNew"
                                 TabIndex="13" Width="20em" MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>
                </table>
 
            </asp:Panel>
            
            
            
<asp:Panel runat="server" Style="text-align: center;" ID="Panel2xx" CssClass="newitemcontent" GroupingText="New Violation (If you don't wish to add a violation at this time, leave the Rule blank.)">
                <table border="0" cellpadding="3" cellspacing="3">
                    <tr>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label32xx" runat="server" Text="Rule "></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:DropDownList ID="ddlRulesNewNewCit" runat="server" DataTextField="RuleDescription"
                                DataValueField="RuleID">
                            </asp:DropDownList>
                        </td>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label33xx" runat="server" Text="Fine $ "></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:TextBox ID="tbScheduleFineNewNewCit" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label34xx" runat="server" Text="ORS #"></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:TextBox ID="tbORSNumberNewNewCit" runat="server"></asp:TextBox>
                        </td>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label35xx" runat="server" Text="Issued as a Warning "></asp:Label>
                        </td>
                        <td class="form_field">
                            <asp:CheckBox ID="cbIssueAsWarningNewNewCit" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label39xx" runat="server" Text="Notes"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="tbViolationNotesNewNewCit" Width="99%" TextMode="MultiLine" Height="4em"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:Label ID="lblNewViolationMessageNewCit" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>            
            
            
            
            
            <asp:Panel runat="server" ID="pnlCitationsFineNew" GroupingText="Fine Information">
                <table width="100%">
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="font-weight: bold;">
                            <asp:Label CssClass="form_field_heading" ID="Label36" runat="server" Text="Fine Status"></asp:Label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList runat="server" ID="ddlCitationsFineStatusNew"  TabIndex="14" DataTextField="FineStatus"
                                DataValueField="FineStatus">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label37" runat="server" Text="Magistrate Fine"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbMagistrateFineNew"  TabIndex="15" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvMagistrateFineNew" ControlToValidate="tbMagistrateFineNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvMagistrateFine_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label38" runat="server" Text="To Accounting"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbToAccountingNew" TabIndex="18" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator2" ControlToValidate="tbToAccountingNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvToAccounting_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label40" runat="server" Text="Judicial Fine"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbJudicialFineNew"  TabIndex="16" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator3" ControlToValidate="tbJudicialFineNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvJudicialFine_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label41" runat="server" Text="Writeoff Amount"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbWriteoffAmountNew" TabIndex="19" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator4" ControlToValidate="tbWriteoffAmountNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvWriteoffAmount_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label43" runat="server" Text="Assessed Fine"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="tbAssessedFineNew"  TabIndex="17" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator5" ControlToValidate="tbAssessedFineNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvAssessedFine_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="Panel5" GroupingText="Magistrate Notes">
                <div style="height: 3.3em; overflow: auto;">
                    <asp:TextBox runat="server" TabIndex="20" Height="2em" Width="95%" TextMode="MultiLine" ID="tbMagistrateNotesNew"></asp:TextBox>
                </div>
            </asp:Panel>
            <center>
                <table cellpadding="3">
                    <tr>
                        <td>
                            <asp:Button CausesValidation="true"  TabIndex="21" OnClientClick="javascript: return true;"
                                ID="btnNewCitationOkay" runat="server" Text="Okay" OnClick="btnNewCitationOk_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnCitationNewCancel"  TabIndex="22" runat="server" Text="Abort" CausesValidation="false"
                                OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                OnClick="btnNewCitationCancel_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="lblCitationNewMessage" Font-Bold="true" ForeColor="Red" runat="server" ></asp:Label></td>
                    </tr>
                </table>
            </center>
        </asp:Panel>
    </asp:Panel>
    <asp:Button Style="display: none;" ID="btncitationhidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewCitation" runat="server" TargetControlID="btncitationhidden1"
        PopupControlID="pnlCitationNewContent" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlCitationNewTitle"
        BehaviorID="jdpopupcitationnew" />
</asp:Content>
