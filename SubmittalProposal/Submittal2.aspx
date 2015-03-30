<%@ Page Title="" Language="C#" MasterPageFile="~/Database.Master" AutoEventWireup="true"
    CodeBehind="Submittal2.aspx.cs" Inherits="SubmittalProposal.Submittal2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Owner"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbOwner" Width="90" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="Applicant"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbApplicant" Width="90" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbLot" Width="20" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" CssClass="form_field" runat="server" DataTextField="Lane"
            DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Submittal Id"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbSubmittalId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label23" runat="server" Text="BPermit Id"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbBPermitId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Is Commercial"></asp:Label>
        <asp:DropDownList CssClass="form_field" ID="ddlIsCommercial" runat="server">
            <asp:ListItem Selected="True" Text="" Value="Null"></asp:ListItem>
            <asp:ListItem Text="True" Value="True"></asp:ListItem>
            <asp:ListItem Text="False" Value="False"></asp:ListItem>
        </asp:DropDownList>
    </td>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" PageSize="15" Style="width: 100%;
        white-space: nowrap;" runat="server" AutoGenerateColumns="False" CellPadding="4"
        ForeColor="#333333" GridLines="None" AllowPaging="true" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        OnSorting="gvResults_Sorting" OnPageIndexChanging="gvResults_PageIndexChanging">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" Position="Bottom"
            PageButtonCount="15" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="Own_Name" HeaderText="Owner's Name" SortExpression="Own_Name" />
            <asp:BoundField DataField="Applicant" HeaderText="Applicant" SortExpression="Applicant" />
            <asp:BoundField DataField="Lot" HeaderText="Lot" SortExpression="Lot" />
            <asp:BoundField DataField="Lane" HeaderText="Lane" SortExpression="Lane" />
            <asp:BoundField DataField="Block" HeaderText="Block" SortExpression="Block" />
            <asp:BoundField DataField="Village" HeaderText="Village" SortExpression="Village" />
            <asp:BoundField DataField="ProjectType" HeaderText="Project Type" SortExpression="ProjectType" />
            <asp:BoundField DataField="Mtg_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Meeting Date"
                SortExpression="Mtg_Date" />
            <asp:BoundField DataField="App_Exp_Dt" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Exp Date"
                SortExpression="App_Exp_Dt" />
            <asp:BoundField DataField="Project" HeaderText="Project" SortExpression="Project" />
            <asp:BoundField DataField="ProjectDecision" HeaderText="Descision" SortExpression="ProjectDecision" />
            <asp:BoundField DataField="Contractor" HeaderText="Contractor" SortExpression="Contractor" />
            <asp:BoundField DataField="SubmittalId" HeaderText="Submittal Id" SortExpression="SubmittalId" />
            <asp:BoundField DataField="BPermitId" HeaderText="BPermitId" SortExpression="BPermitId" />
            <asp:BoundField DataField="IsCommercial" HeaderText="Is Commercial" SortExpression="IsCommercial" />
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FormContent" runat="server">

    <ajaxToolkit:TabContainer Height="346" ActiveTabIndex="0" ID="TabContainer1" runat="server">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelApplicantInformation" HeaderText="Applicant Infromation">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3" runat="server">
                    <ContentTemplate>

                        <table width="100%" cellpadding="1" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" GroupingText="Owner" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" ID="tbOwnersNameUpdate" Width="30em" runat="server"></asp:TextBox>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel2" GroupingText="Sunriver Property" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Lot"></asp:Label>
                                        <asp:TextBox CssClass="form_field" ID="tbLotName2" Width="22" runat="server"></asp:TextBox>
                                        <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>
                                        <asp:DropDownList ID="ddlLane2" CssClass="form_field" runat="server" DataTextField="Lane"
                                            DataValueField="Lane">
                                        </asp:DropDownList>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel3" GroupingText="Applicant" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" ID="tbApplicantName2" runat="server"></asp:TextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel4" GroupingText="Contractor" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" ID="tbContractorBB" Width="30em" runat="server"></asp:TextBox>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel5" GroupingText="Project Fees" runat="server">
                                        <table border="0" cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Review fee"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbReviewFee" runat="server"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" Style="margin-top: 3px;" ID="Label13" runat="server"
                                                        Text="Date fee paid"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbDateFeePaidUpdate" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibDateFeePaid2" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="ceDateFeePaid2" runat="server"
                                            TargetControlID="tbDateFeePaidUpdate"
                                            Format="MM/dd/yyyy"
                                            PopupButtonID="ibDateFeePaid2" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revDateFeePaid2"  Display="Dynamic" 
                                            ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                            ControlToValidate="tbDateFeePaidUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel6" GroupingText="Meeting Date" runat="server">
                                        <table><tr><td>
                                        <asp:TextBox CssClass="form_field" ID="tbMeetingDateUpdate" runat="server"></asp:TextBox>
                                        </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibMeetingDateUpdate" runat="server" /></td></tr></table>
                                    <ajaxToolkit:CalendarExtender ID="ceMeetingDateUpdate" runat="server"
                                        TargetControlID="tbMeetingDateUpdate"
                                        Format="MM/dd/yyyy"
                                        PopupButtonID="ibMeetingDateUpdate" />
                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revMeetingDateUpdate"  Display="Dynamic" 
                                        ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                        ControlToValidate="tbMeetingDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:Panel ID="Panel7" GroupingText="Submittal" runat="server">
                                        <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Project Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="form_field" ID="ddlProjectType" runat="server">
                                                        <asp:ListItem Value="AA">AA - Administrative Approval</asp:ListItem>
                                                        <asp:ListItem Value="ALT">ALT - Alteration\Addition</asp:ListItem>
                                                        <asp:ListItem Value="CAI">CAI - Common Area Improvement</asp:ListItem>
                                                        <asp:ListItem Value="COM">COM - Commercial Construction</asp:ListItem>
                                                        <asp:ListItem Value="MA">MA - Minor Addition</asp:ListItem>
                                                        <asp:ListItem Value="NEW">NEW - New Construction</asp:ListItem>
                                                        <asp:ListItem Value="PRE">PRE - Preliminary</asp:ListItem>
                                                        <asp:ListItem Value="RER">RER - ReReview\Revision</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Project Decision"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="form_field" ID="ddlProjectDecision" runat="server">
                                                        <asp:ListItem Value="A">A - Approved</asp:ListItem>
                                                        <asp:ListItem Value="AWC">AWC - Approved with Conditions</asp:ListItem>
                                                        <asp:ListItem Value="DEF">DEF - Deferred</asp:ListItem>
                                                        <asp:ListItem Value="DEN">DEN - Denied</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Is Commercial"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbIsCommercial" runat="server" />
                                                </td>
                                                <td width="15%" align="right">
                                                    <asp:LinkButton ID="lbGoToPermit" runat="server" OnClick="lbGoToPermit_Click">Go to Permit</asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Project"></asp:Label>
                                                </td>
                                                <td colspan="6">
                                                    <asp:TextBox CssClass="form_field" ID="tbProject" Width="100%" runat="server" TextMode="SingleLine"
                                                        Rows="1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Submittal"></asp:Label>
                                                </td>
                                                <td colspan="6">
                                                    <asp:TextBox CssClass="form_field" ID="tbSubmittal" Width="100%" runat="server" TextMode="MultiLine"
                                                        Rows="4"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelProjectConditions" HeaderText="Project Conditions">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel4" runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="tbConditions" Style="width: 100%;" runat="server" TextMode="MultiLine"
                            Height="340px"></asp:TextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true" ID="btnSubmitalUpdate" OnClick="btnSubmitalUpdate_Click" runat="server"
            Text="Submit" />
        <asp:Label ID="lblSubmitalUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <script language="javascript" type="text/javascript">
        function onNewSubmittalCancel() {
            if (confirm("Are you sure that you wish to cancel?")) {
                return true;
            } else {
                return false;
            }
        }
    </script>
    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewSubmittalId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewSubmittalTitleId">
            <span>New Submittal</span>
        </asp:Panel>
        <asp:Panel runat="server" style="text-align:center;" ID="pnlNewSubmittalContent" CssClass="newitemcontent">
            <ajaxToolkit:TabContainer  style="text-align:center;" Height="346" ActiveTabIndex="0" ID="TabContainer2" runat="server">
                <ajaxToolkit:TabPanel Width="900px" runat="server" ID="tabPanel1" HeaderText="Applicant Infromation">
                    <ContentTemplate>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel8" GroupingText="Owner" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Name"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="tbSubmittalNewName" Width="30em" runat="server"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel9" GroupingText="Sunriver Property" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Lot"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="tbSubmittalNewLot" Width="22" runat="server"></asp:TextBox>
                                                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Lane"></asp:Label>
                                                <asp:DropDownList ID="ddlSubmittalNewLane" CssClass="form_field" runat="server" DataTextField="Lane"
                                                    DataValueField="Lane">
                                                </asp:DropDownList>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel10" GroupingText="Applicant" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Name"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="TextBox3" runat="server"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel11" GroupingText="Contractor" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label24" runat="server" Text="Name"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="TextBox4" Width="30em" runat="server"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel12" GroupingText="Project Fees" runat="server">
                                                <table border="0" cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" ID="Label25" runat="server" Text="Review fee"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="form_field" ID="TextBox5" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" Style="margin-top: 3px;" ID="Label26" runat="server"
                                                                Text="Date fee paid"></asp:Label>

                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="form_field" ID="tbDateFeePaidNew" runat="server"></asp:TextBox>

                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ImageAlign="Middle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibDateFeePaid1" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajaxToolkit:CalendarExtender ID="cexDateFeePaidNew" runat="server"
                                                    TargetControlID="tbDateFeePaidNew"
                                                    Format="MM/dd/yyyy"
                                                    PopupButtonID="ibDateFeePaid1" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="revDateFeePaid1" Display="Dynamic" 
                                                    ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                                    ControlToValidate="tbDateFeePaidNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel13" GroupingText="Meeting Date" runat="server">
                                                <table><tr><td>
                                                <asp:TextBox CssClass="form_field" ID="tbMeetingDateAdd" runat="server"></asp:TextBox>
                                                </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibMeetingDateAdd" runat="server" /></td></tr></table>
                                                <ajaxToolkit:CalendarExtender ID="cbMeetingDateAdd" runat="server"
                                                    TargetControlID="tbMeetingDateAdd"
                                                    Format="MM/dd/yyyy"
                                                    PopupButtonID="ibMeetingDateAdd" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="revMeetingDateAdd"  Display="Dynamic" 
                                                    ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                                    ControlToValidate="tbMeetingDateAdd" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <asp:Panel ID="Panel14" GroupingText="Submittal" runat="server">
                                                <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Project Type"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList CssClass="form_field" ID="DropDownList2" runat="server">
                                                                <asp:ListItem Value="AA">AA - Administrative Approval</asp:ListItem>
                                                                <asp:ListItem Value="ALT">ALT - Alteration\Addition</asp:ListItem>
                                                                <asp:ListItem Value="CAI">CAI - Common Area Improvement</asp:ListItem>
                                                                <asp:ListItem Value="COM">COM - Commercial Construction</asp:ListItem>
                                                                <asp:ListItem Value="MA">MA - Minor Addition</asp:ListItem>
                                                                <asp:ListItem Value="NEW">NEW - New Construction</asp:ListItem>
                                                                <asp:ListItem Value="PRE">PRE - Preliminary</asp:ListItem>
                                                                <asp:ListItem Value="RER">RER - ReReview\Revision</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label CssClass="form_field_heading" ID="Label28" runat="server" Text="Project Decision"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList CssClass="form_field" ID="DropDownList3" runat="server">
                                                                <asp:ListItem Value="A">A - Approved</asp:ListItem>
                                                                <asp:ListItem Value="AWC">AWC - Approved with Conditions</asp:ListItem>
                                                                <asp:ListItem Value="DEF">DEF - Deferred</asp:ListItem>
                                                                <asp:ListItem Value="DEN">DEN - Denied</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label CssClass="form_field_heading" ID="Label29" runat="server" Text="Is Commercial"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                                        </td>
                                                        <td width="15%" align="right">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" ID="Label30" runat="server" Text="Project"></asp:Label>
                                                        </td>
                                                        <td colspan="6">
                                                            <asp:TextBox CssClass="form_field" ID="TextBox8" Width="100%" runat="server" TextMode="SingleLine"
                                                                Rows="1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Submittal"></asp:Label>
                                                        </td>
                                                        <td colspan="6">
                                                            <asp:TextBox CssClass="form_field" ID="TextBox9" Width="100%" runat="server" TextMode="MultiLine"
                                                                Rows="4"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel Width="900px"  runat="server" ID="tabPanel2" HeaderText="Project Conditions">
                    <ContentTemplate>
                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="TextBox10" Style="width: 100%;" runat="server" TextMode="MultiLine"
                                    Height="340px"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
            </ajaxToolkit:TabContainer>
        </asp:Panel>
        <center>
            <table cellpadding="4">
                <tr>
                    <td>
                        <asp:Button ID="btnNewSubmittalOk" CausesValidation="true" runat="server" Text="Okay" 
                            onclick="btnNewSubmittalOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewSubmittalCancel" OnClientClick="return onNewSubmittalCancel()" runat="server" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </center>
    </asp:Panel>
    <asp:LinkButton ID="lbSubmittalNew" runat="server">New Submittal</asp:LinkButton>

    <ajaxToolkit:ModalPopupExtender ID="mpeNewSubmittal" runat="server" TargetControlID="lbSubmittalNew"
        PopupControlID="pnlNewSubmittalId" BackgroundCssClass="modalBackground"
        PopupDragHandleControlID="pnlNewSubmittalTitleId"
        BehaviorID="jdpopupsubmittal" />
    <script language="javascript" type="text/javascript">
        function shown() {
            var tb = document.getElementById('<% =tbSubmittalNewName.ClientID %>');
            tb.focus();
        }
        function pageLoad() {
            $addHandler(document, "keydown", OnKeyPress);
            var ddd = $find('jdpopupsubmittal');
            ddd.add_shown(shown);
        }

        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
// I don't know about this                $find("jdpopup").hide();
            }
        }
    </script>
</asp:Content>
