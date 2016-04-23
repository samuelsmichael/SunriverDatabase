<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dummy.aspx.cs" Inherits="SubmittalProposal.Dummy" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
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
                            <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="Last Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbCitationsLastNameNew" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Sunriver Status"></asp:Label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList ID="ddlSunriverStatusNew" DataTextField="SunriverStatus" DataValueField="SunriverStatus"
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
                                        <asp:TextBox ID="tbCitingOfficerNew" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
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
                                                    <asp:TextBox CssClass="form_field_date" ID="tbHearingDateNew" Width="7em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
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
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="First Name"></asp:Label>
                        </td>
                        <td colspan="5">
                            <asp:TextBox ID="tbCitationsFirstNameNew" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Address1"></asp:Label>
                        </td>
                        <td colspan="5">
                            <asp:TextBox ID="tbCitationsAddress1New" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Address2"></asp:Label>
                        </td>
                        <td colspan="5">
                            <asp:TextBox ID="tbCitationsAddress2New" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="City"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbCitationsCityNew" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                        </td>
                        <td align="right">
                            <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="State"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbCitationsStateNew" MaxLength="2" Width="3em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Zip"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="tbCitationsZipNew" MaxLength="10" Width="6em" runat="server"></asp:TextBox>
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
                                        <asp:TextBox CssClass="form_field_date" ID="tbCitationsViolationsDateNew" Width="7em"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            ID="ibCitationsViolationsDateNew" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender ID="ceCitationsViolationsDateNew" runat="server"
                                TargetControlID="tbCitationsViolationsDateNew" Format="MM/dd/yyyy" PopupButtonID="ibCitationsViolationsDateNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="revCitationsViolationsDateNew"
                                Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbCitationsViolationsDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="lbl17x332a3" runat="server" Text="Location"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" runat="server" ID="tbCitationsViolationsLocationNew"
                                Width="20em" MaxLength="50"></asp:TextBox>
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
                                        <asp:Button CausesValidation="true" OnClientClick="javascript: return donewviolationjedisok();"
                                            ID="btnNewViolationOk" runat="server" Text="Okay" OnClick="btnNewViolationOk_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnNewViolationCancel" runat="server" Text="Cancel" CausesValidation="false"
                                            OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
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
            <asp:Panel runat="server" ID="pnlCitationsFineNew" GroupingText="Fine Information">
                <table width="100%">
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label1sx0" runat="server" Text="Fine Status"></asp:Label>
                        </td>
                        <td colspan="5">
                            <asp:DropDownList runat="server" ID="ddlCitationsFineStatusNew" DataTextField="FineStatus"
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
                            <asp:TextBox ID="tbMagistrateFineNew" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvMagistrateFine" ControlToValidate="tbMagistrateFineNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvMagistrateFine_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="To Accounting"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbToAccountingNew" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvToAccounting" ControlToValidate="tbToAccountingNew"
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
                            <asp:TextBox ID="tbTotalCitationFineNew" MaxLength="7" Width="6em" runat="server"
                                ReadOnly="true"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label13x3a" runat="server" Text="Judicial Fine"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbJudicialFineNew" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvJudicialFine" ControlToValidate="tbJudicialFineNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvJudicialFine_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label14x3" runat="server" Text="Writeoff Amount"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbWriteoffAmountNew" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvWriteoffAmount" ControlToValidate="tbWriteoffAmountNew"
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
                            <asp:TextBox ID="tbAssessedFineNew" MaxLength="7" Width="6em" runat="server"></asp:TextBox>
                            <asp:CustomValidator ID="cvAssessedFine" ControlToValidate="tbAssessedFineNew"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must be an amount (or blank)" OnServerValidate="cvAssessedFine_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnlMagistrateNotes" GroupingText="Magistrate Notes">
                <div style="height: 3.3em; overflow: auto;">
                    <asp:TextBox runat="server" Height="2em" Width="95%" TextMode="MultiLine" ID="tbMagistrateNotesNew"></asp:TextBox>
                </div>
            </asp:Panel>
            <center>
                <table cellpadding="3">
                    <tr>
                        <td>
                            <asp:Button CausesValidation="true" OnClientClick="javascript: return donewviolationjedisok();"
                                ID="btnCitationNewOkay" runat="server" Text="Okay" OnClick="btnNewCitationOk_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnCitationNewCancel" runat="server" Text="Cancel" CausesValidation="false"
                                OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                OnClick="btnNewCitationCancel_Click" />
                        </td>
                    </tr>
                </table>
            </center>
        </asp:Panel>
    </asp:Panel>
    <asp:LinkButton ID="lbCitationNew" OnClick="lbCitationNew_OnClick" CausesValidation="false"
        runat="server">New Citation</asp:LinkButton>
    <asp:Button Style="display: none;" ID="btncitationhidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewCitation" runat="server" TargetControlID="btncitationhidden1"
        PopupControlID="pnlCitationNewContent" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlCitationNewTitle"
        BehaviorID="jdpopupcitationnew" />
    </form>
</body>
</html>
