<%@ Page Title="" Language="C#" MasterPageFile="~/Database.Master" AutoEventWireup="true"
    CodeBehind="Submittal2.aspx.cs" Inherits="SubmittalProposal.Submittal2" %>
    
<%@ Register src="PhotoManager.ascx" tagname="PhotoManager" tagprefix="uc1" %>
<%@ Register src="FileManager.ascx" tagname="FileManager" tagprefix="uc2" %>
    
<asp:Content ID="Content5xyz" ContentPlaceHolderID="HeadContent" runat="server">
<script language="javascript" type="text/javascript">
    function clientActiveTabChanged(sender, args) {
//alert('marre')
        if (sender.get_activeTabIndex() == 2) { // BPermit tab clicked
            document.getElementById(document.getElementById('Hidden1').value).click();
            //        __doPostBack('btnBPTabTrigger', '');
        } else {
        if (sender.get_activeTabIndex() == 0) { // Main tab clicked
            document.getElementById(document.getElementById('Hidden2').value).click();
            //        __doPostBack('btnBPTabTrigger', '');
        } else {
            if (sender.get_activeTabIndex() == 1) { // Main tab clicked
                document.getElementById(document.getElementById('Hidden3').value).click();
                //        __doPostBack('btnBPTabTrigger', '');
            }
        }
        }
//    alert('tab clicked: ' + sender.get_activeTabIndex());

 ////   __doPostBack('btnOrdersTrigger', '');
}
</script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbLot" Width="30" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" CssClass="form_field" runat="server" DataTextField="Lane"
            DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Owner"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbOwner" Width="85" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Submittal Id"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbSubmittalId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label23" runat="server" Text="BPermit#"></asp:Label>
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
        ForeColor="#333333" GridLines="None" AllowPaging="True" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        OnSorting="gvResults_Sorting" OnPageIndexChanging="gvResults_PageIndexChanging">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" Position="Bottom"
            PageButtonCount="15" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="Lot" HeaderText="Lot" SortExpression="Lot">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Lane" HeaderText="Lane" SortExpression="Lane">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Project" HeaderText="Project" SortExpression="Project">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="ProjectDecision" HeaderText="Descision" SortExpression="ProjectDecision">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Mtg_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Meeting Date"
                SortExpression="Mtg_Date">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="SubmittalId" HeaderText="Submittal Id" SortExpression="SubmittalId">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="BPermit#" HeaderText="Permit #" SortExpression="BPermit#">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
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

                <asp:UpdatePanel ID="updatePanel5" runat="server">
                    <ContentTemplate>
    <asp:Button ID="btnBPTabTrigger" style="display:none;" runat="server" Text="..-...u-.-.-.-" OnClick="btnBPTabTrigger_Click" />
    <asp:Button ID="btnMainTabTrigger" style="display:none;" runat="server" Text="..-...u-.-.-.-" OnClick="btnMainTabTrigger_Click" />
    <asp:Button ID="btnProjectConditionsTrigger" style="display:none;" runat="server" Text="..-...u-.-.-.-" OnClick="btnProjectConditionsTrigger_Click" />
    </ContentTemplate></asp:UpdatePanel>
    <input id="Hidden1" type="hidden" value="<% = btnBPTabTrigger.ClientID %>" />
    <input id="Hidden2" type="hidden" value="<% = btnMainTabTrigger.ClientID %>" />
    <input id="Hidden3" type="hidden" value="<% = btnProjectConditionsTrigger.ClientID %>" />
    <ajaxToolkit:TabContainer OnClientActiveTabChanged="clientActiveTabChanged" ActiveTabIndex="0" ID="TabContainer1" runat="server">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelApplicantInformation" HeaderText="Application Infromation">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3" runat="server">
                    <ContentTemplate>
                        <table width="100%" cellpadding="1" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" GroupingText="Owner" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbOwnersNameUpdate" Width="30em"
                                            MaxLength="40" runat="server" ></asp:TextBox>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel2" GroupingText="Sunriver Property" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Lot"></asp:Label>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbLotNameUpdate" Width="22"
                                            MaxLength="5" runat="server"></asp:TextBox>
                                        <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>
                                        <asp:DropDownList Enabled="false" ID="ddlLaneUpdate" CssClass="form_field" runat="server"
                                            DataTextField="Lane" DataValueField="Lane">
                                        </asp:DropDownList>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel3" GroupingText="Applicant" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbApplicantNameUpdate" MaxLength="25"
                                            runat="server" ></asp:TextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel4" GroupingText="Contractor" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbContractorUpdate" MaxLength="30"
                                            Width="30em" runat="server"></asp:TextBox>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel6" GroupingText="Meeting Date" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" Enabled="false" ID="tbMeetingDateUpdate" 
                                                    runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibMeetingDateUpdate" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="ceMeetingDateUpdate" runat="server" TargetControlID="tbMeetingDateUpdate"
                                            Format="MM/dd/yyyy" PopupButtonID="ibMeetingDateUpdate" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revMeetingDateUpdate" Display="Dynamic"
                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbMeetingDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="rfvMeedtingDateUpdate" ForeColor="Red" ControlToValidate="tbMeetingDateUpdate"
                                            runat="server" ErrorMessage="Meeting Date is required"></asp:RequiredFieldValidator>
                                    </asp:Panel>
                                </td>
                                <td>
                                    &nbsp;
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
                                                    <asp:DropDownList Enabled="false" CssClass="form_field" ID="ddlProjectTypeUpdate"
                                                        runat="server">
                                                        <asp:ListItem Value="">None</asp:ListItem>
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
                                                    <asp:DropDownList Enabled="false" CssClass="form_field" ID="ddlProjectDecisionUpdate"
                                                        runat="server">
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
                                                    <asp:CheckBox Enabled="false" ID="cbIsCommercialUpdate" runat="server" />
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
                                                    <asp:TextBox Enabled="false" CssClass="form_field" ID="tbProjectUpdate" MaxLength="100"
                                                        Width="100%" runat="server" TextMode="SingleLine" Rows="1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td colspan="7">
                                                    <asp:ImageButton 
                                                        OnClientClick="javascript:document.getElementById('MainContent_MainContent_FormContent_TabContainer1_tabPanelApplicantInformation_tbSubmittalUpdate').value=document.getElementById('MainContent_MainContent_FormContent_TabContainer1_tabPanelApplicantInformation_tbProjectUpdate').value;" 
                                                        CausesValidation="False" ID="ImgCopyProjectToSubmittal" runat="server" ImageUrl="~/images/expand_blue.jpg"                                                         
                                                        ToolTip="(Copy Project to Submittal)" /></td>



                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Submittal"></asp:Label>
                                                </td>
                                                <td colspan="6">
                                                    <asp:TextBox Enabled="false" CssClass="form_field" ID="tbSubmittalUpdate" Width="100%"
                                                        runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
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
                        <asp:TextBox Enabled="false" ID="tbConditionsUpdate" Style="width: 100%;" runat="server"
                            TextMode="MultiLine" Height="340px"></asp:TextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelBPermit" HeaderText="Building Permit">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel5a" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="pnlUpdateBPermitContent" runat="server">
                            <asp:Panel ID="Panel5" GroupingText="Building Permit Data" runat="server">
                                                                                                                                                                                                                                                                                                                                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label41a" runat="server" Text="BPermit#"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" MaxLength="20" ID="tbBPermitNbrUpdate" Width="5em"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Delay"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" MaxLength="255" ID="tbDelayUpdate" Width="3em"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Issued"></asp:Label>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbIssuedUpdate" Width="10em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibIssuedUpdate" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="ceIssuedUpdate" runat="server" TargetControlID="tbIssuedUpdate"
                                            Format="MM/dd/yyyy" PopupButtonID="ibIssuedUpdate" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revIssuedUpdate" Display="Dynamic"
                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbIssuedUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label25" runat="server" Text="Expired"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_lbl" ID="lblExpired" Width="9em" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label26" runat="server" Text="Closed"></asp:Label>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbClosedUpdate" Width="10em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibClosedUpdate" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="ceClosedUpdate" runat="server" TargetControlID="tbClosedUpdate"
                                            Format="MM/dd/yyyy" PopupButtonID="ibClosedUpdate" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revClosedUpdate" Display="Dynamic"
                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbClosedUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label32" runat="server" Text="Permit Required"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="rbListPermitRequiredUpdate" RepeatDirection="Horizontal"
                                            runat="server">
                                            <asp:ListItem>Yes</asp:ListItem>
                                            <asp:ListItem>No</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label34a" runat="server" Text="Contractor"></asp:Label>
                                    </td>
                                    <td colspan="7">
                                        <asp:DropDownList CssClass="form_field" runat="server" ID="ddlContractorUpdate" DataTextField="Company"
                                            DataValueField="SRContrRegID">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            </asp:Panel>
                            <asp:Panel ID="Panel12" GroupingText="Data from Applicant Form" runat="server">
                            <table border="0" cellpadding="2" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label33" runat="server" Text="Lot"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbLotNameUpdateBP" MaxLength="5" Width="35" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label34" runat="server" Text="Lane"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList CssClass="form_field" ID="ddlLaneUpdateBP" runat="server" DataTextField="Lane"
                                            DataValueField="Lane">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label35" runat="server" Text="Owner"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbOwnersNameUpdateBP" MaxLength="40" Width="20em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label36" runat="server" Text="Applicant"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" MaxLength="25" ID="tbApplicantNameUpdateBP" Width="20em" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label CssClass="form_field_heading" ID="Label37" runat="server" Text="Contractor"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox CssClass="form_field" MaxLength="30" ID="tbContractorUpdateBP" Width="20em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label38" runat="server" Text="Project"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" MaxLength="100" ID="tbProjectUpdateBP" runat="server" Width="20em"
                                            TextMode="MultiLine" Rows="4"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label39" runat="server" Text="Project Type"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList CssClass="form_field" ID="ddlProjectTypeUpdateBP" runat="server">
                                            <asp:ListItem Value="">None</asp:ListItem>
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
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <table width="100%">
                            <tr>
                                <td width="250px">
                                    <asp:Panel runat="server" ID="pnlPayments" GroupingText="Payments">
                                        <asp:GridView Width="100%" ID="gvPayments" runat="server" AutoGenerateColumns="False"
                                            CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True" OnRowCancelingEdit="gvPayments_RowCancelingEdit"
                                            OnRowEditing="gvPayments_RowEditing" OnRowUpdating="gvPayments_RowUpdating" DataKeyNames="BPPaymentId">
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
                                                <asp:TemplateField HeaderText="Nbr">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("BPPmt") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("BPPmt") %>'></asp:Label>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Fee">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="tbBPPaymentFeeUpdate" runat="server" Text='<%# Eval("BPFee$","{0:0.00}") %>'></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="revtbBPPaymentFeeUpdate" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="tbBPPaymentFeeUpdate" ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$"
                                                            runat="server" ErrorMessage="Must be an amount"></asp:RegularExpressionValidator>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("BPFee$","{0:c}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text="<%# getBPFeeTotal() %>"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Months">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="tbBPPaymentMonthsUpdate" runat="server" Text='<%# Bind("BPMonths") %>'></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="revtbBPPaymentMonthsUpdate" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="tbBPPaymentMonthsUpdate" ValidationExpression="^[0-9]+$" runat="server"
                                                            ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("BPMonths") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text="<%# getBPMonthsTotal() %>"></asp:Label>
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("BPPaymentId") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("BPPaymentId") %>'></asp:Label>
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <center style="margin-top: 5px;">
                                            <asp:Button runat="server" ID="dummylbBPermitNewPayment" Style="display: none" />
                                            <asp:Button ID="lbBPermitNewPayment" runat="server" Text="New Payment" OnClick="lbBPermitNewPayment_Click"
                                                OnClientClick="javascript: return true;" /></center>
                                        <asp:Panel runat="server" CssClass="newitempopup" ID="pnlBPermitNewPayment">
                                            <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlBPermitNewPaymentTitle">
                                                <span>New Payment</span>
                                            </asp:Panel>
                                            <asp:Panel runat="server" Style="text-align: center;" ID="Panel15" CssClass="newitemcontent">
                                                <table>
                                                    <tr>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label40" runat="server" Text="Fee"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPPaymentFeeNew" Width="8em" runat="server"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="revtbBPPaymentFeeNew" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="tbBPPaymentFeeNew" ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$"
                                                                runat="server" ErrorMessage="Must be an amount"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label41" runat="server" Text="Months"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPPaymentMonthsNew" Width="4em" runat="server"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="revBPPaymentMonthsNew" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="tbBPPaymentMonthsNew" ValidationExpression="^[0-9]+$" runat="server"
                                                                ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <center>
                                                <table cellpadding="3">
                                                    <tr>
                                                        <td>
                                                            <asp:Button OnClientClick="javascript: return true;" CausesValidation="true" ID="btnNewBPermitPaymentOk"
                                                                runat="server" Text="Okay" OnClick="btnNewBPermitPaymentOk_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnNewBPermitPaymentCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                                                runat="server" Text="Abort" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </center>
                                        </asp:Panel>
                                        <ajaxToolkit:ModalPopupExtender ID="mpeBPermitNewPayment" runat="server" TargetControlID="dummylbBPermitNewPayment"
                                            PopupControlID="pnlBPermitNewPayment" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlBPermitNewPaymentTitle"
                                            BehaviorID="jdpopupbpermitnewpayment" />
                                        <script language="javascript" type="text/javascript">
                                            function shownnp() {
                                                var tb = document.getElementById('<% =tbBPPaymentFeeNew.ClientID %>');
                                                tb.focus();

                                            }
                                            function pageLoadNewPayment() {
                                                var dddp = $find('jdpopupbpermitnewpayment');
                                                dddp.add_shown(shownnp);
                                            }

                                        </script>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel runat="server" ID="pnlReviews" GroupingText="Reviews">
                                        <asp:GridView ID="gvReviews" Width="100%" runat="server" AutoGenerateColumns="False"
                                            CellPadding="1" ForeColor="#333333" GridLines="None" OnRowCancelingEdit="gvReviews_RowCancelingEdit"
                                            OnRowEditing="gvReviews_RowEditing" OnRowUpdating="gvReviews_RowUpdating" DataKeyNames="BPReviewID">
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
                                                <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true" />
                                                <asp:TemplateField HeaderText="Nbr">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("BPRevw") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("BPRevw") %>'></asp:Label>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="1st Inspect">
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox CssClass="form_field_date" ID="tbBPermitReviewDateUpdate" runat="server"
                                                                        Width="60" Text='<%# Bind("BPReviewDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                        ID="ibBPermitReviewDateUpdate" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <ajaxToolkit:CalendarExtender ID="ceBPermitReviewDateUpdate" runat="server" TargetControlID="tbBPermitReviewDateUpdate"
                                                            Format="MM/dd/yyyy" PopupButtonID="ibBPermitReviewDateUpdate" />
                                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitReviewDateUpdate" Display="Dynamic"
                                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                            ControlToValidate="tbBPermitReviewDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("BPReviewDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action ">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("BPRActionDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox CssClass="form_field_date" ID="tbBPermitActionDateUpdate" runat="server"
                                                                        Width="60" Text='<%# Bind("BPRActionDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                        ID="ibBPermitActionDateUpdate" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <ajaxToolkit:CalendarExtender ID="ceBPermitActionDateUpdate" runat="server" TargetControlID="tbBPermitActionDateUpdate"
                                                            Format="MM/dd/yyyy" PopupButtonID="ibBPermitActionDateUpdate" />
                                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitActionDateUpdate" Display="Dynamic"
                                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                            ControlToValidate="tbBPermitActionDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Letter">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("BPRLetterDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:TextBox CssClass="form_field_date" ID="tbBPermitLetterDateUpdate" runat="server"
                                                                                    Width="60" Text='<%# Bind("BPRLetterDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                                    ID="ibBPermitLetterDateUpdate" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <ajaxToolkit:CalendarExtender ID="ceBPermitLetterDateUpdate" runat="server" TargetControlID="tbBPermitLetterDateUpdate"
                                                                        Format="MM/dd/yyyy" PopupButtonID="ibBPermitLetterDateUpdate" />
                                                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitLetterDateUpdate" Display="Dynamic"
                                                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                        ControlToValidate="tbBPermitLetterDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Letter Ref">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("BPRLetterRef", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox CssClass="form_field" ID="tbBPRLetterRefUpdate" runat="server" Width="105"
                                                            Text='<%# Bind("BPRLetterRef") %>' MaxLength="25"></asp:TextBox>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Comments">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("BPRComments") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox CssClass="form_field_wide" ID="tbBPRCommentsUpdate" runat="server" Width="123"
                                                            Rows="3" TextMode="MultiLine" Text='<%# Bind("BPRComments") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <center style="margin-top: 5px;">
                                            <asp:Button runat="server" ID="dummylbBPermitNewReview" Style="display: none" />
                                            <asp:Button ID="lbBPermitNewReview2" runat="server" Text="New Review" OnClick="lbBPermitNewReview_Click"
                                                OnClientClick="javascript: return true;" /></center>
                                        <asp:Panel runat="server" CssClass="newitempopup" ID="pnlBPermitNewReview">
                                            <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlBPermitNewReviewTitle">
                                                <span>New Review</span>
                                            </asp:Panel>
                                            <asp:Panel runat="server" Style="text-align: center;" ID="Panel16" CssClass="newitemcontent">
                                                <table>
                                                    <tr>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label42" runat="server" Text="Inspection Date"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field" ID="tbBPermitReviewDateNew" Width="8em" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="ceBPermitReviewDateNew" runat="server" TargetControlID="tbBPermitReviewDateNew"
                                                                Format="MM/dd/yyyy" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitReviewDateNew" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbBPermitReviewDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label43" runat="server" Text="Action Date"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field" ID="tbBPermitActionDateNew" Width="8em" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="ceBPermitActionDateNew" runat="server" TargetControlID="tbBPermitActionDateNew"
                                                                Format="MM/dd/yyyy" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitActionDateNew" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbBPermitActionDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label44" runat="server" Text="Letter Date"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field" ID="tbBPermitLetterDateNew" Width="8em" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="ceBPermitLetterDateNew" runat="server" TargetControlID="tbBPermitLetterDateNew"
                                                                Format="MM/dd/yyyy" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitLetterDateNew" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbBPermitLetterDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label45" runat="server" Text="Letter Reference"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPRLetterRefNew" MaxLength="25" Width="8em"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label46" runat="server" Text="Comments"></asp:Label>
                                                        </td>
                                                        <td align="left" class="form_field" colspan="9">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPRCommentsNew" Width="99%" runat="server"
                                                                TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <center>
                                                <table cellpadding="2" cellspacing="2">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnNewBPermitReviewOk" OnClientClick="javascript: return true;" CausesValidation="true"
                                                                runat="server" Text="Okay" OnClick="btnNewBPermitReviewOk_Click" />
                                                            <div style="font-size: xx-small;">
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnNewBPermitReviewCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                                                runat="server" Text="Abort" />
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
                                        <ajaxToolkit:ModalPopupExtender ID="mpeBPermitNewReview" runat="server" TargetControlID="dummylbBPermitNewReview"
                                            PopupControlID="pnlBPermitNewReview" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlBPermitNewReviewTitle"
                                            BehaviorID="jdpopupbpermitnewreview" />
                                        <script language="javascript" type="text/javascript">
                                            function shownnr() {
                                                var tb = document.getElementById('<% =tbBPermitReviewDateNew.ClientID %>');
                                                tb.focus();

                                            }
                                            function pageLoadNewReview() {
                                                alert('bubba')
                                                var dddp = $find('jdpopupbpermitnewreview');
                                                dddp.add_shown(shownnr);
                                            }
                                        </script>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                            <center>
                <asp:RadioButtonList ID="rblListOfPermits" RepeatDirection="Horizontal" AutoPostBack="true"  OnSelectedIndexChanged="rblListOfPermits_OnSelectedIndexChanged" runat="server">
                </asp:RadioButtonList>

                                <asp:LinkButton OnClick="lbNewPermitFromUpdatePermit_OnClick" ID="lbNewPermitFromUpdatePermit" runat="server">New Permit</asp:LinkButton>
                            </center>
                            </asp:Panel>

                        <asp:Panel runat="server" Visible="false" Style="text-align: center;" ID="pnlNewBPermitContent" CssClass="newitemcontent">
                                    <asp:Panel ID="Panel17" GroupingText="Building Permit Data" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label41x3" runat="server" Text="BPermit#"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" MaxLength="20" ID="tbBPermitNbrNew" Width="5em"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label47" runat="server" Text="Delay"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbDelayNew" Width="3em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label48" runat="server" Text="Issued"></asp:Label>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox CssClass="form_field_date" ID="tbIssuedNew" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                    ID="ibIssuedNew" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <ajaxToolkit:CalendarExtender ID="ceIssuedNew" runat="server" TargetControlID="tbIssuedNew"
                                                        Format="MM/dd/yyyy" PopupButtonID="ibIssuedNew" />
                                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revIssuedNew" Display="Dynamic"
                                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                        ControlToValidate="tbIssuedNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label50" runat="server" Text="Closed"></asp:Label>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox CssClass="form_field" ID="tbClosedNew" Width="10em" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                    ID="ibClosedNew" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <ajaxToolkit:CalendarExtender ID="ceClosedNew" runat="server" TargetControlID="tbClosedNew"
                                                        Format="MM/dd/yyyy" PopupButtonID="ibClosedNew" />
                                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revClosedNew" Display="Dynamic"
                                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                        ControlToValidate="tbClosedNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label51" runat="server" Text="Permit Required"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="rbListPermitRequiredNew" RepeatDirection="Horizontal" runat="server">
                                                        <asp:ListItem>Yes</asp:ListItem>
                                                        <asp:ListItem>No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label52" runat="server" Text="Contractor"></asp:Label>
                                                </td>
                                                <td colspan="7">
                                                    <asp:DropDownList CssClass="form_field" runat="server" ID="ddlContractorNew" DataTextField="Company"
                                                        DataValueField="SRContrRegID">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    <table style="width:100%;" cellpadding="0" cellspacing="0" border="0">
                                        <tr valign="top">
                                            <td valign="top">
                                            <asp:Panel runat="server" Style="text-align: center; " ID="Panel15xx" Width="185px" GroupingText="Payment" CssClass="newitemcontent">
                                                <table>
                                                    <tr>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label40xx" runat="server" Text="Fee"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPPaymentFeeNewNewPermit" Width="5em" runat="server"></asp:TextBox>
                                                            <asp:RegularExpressionValidator b ID="revtbBPPaymentFeeNewNewPermit" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="tbBPPaymentFeeNewNewPermit" ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$"
                                                                runat="server" ErrorMessage="Must be an amount"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label41NewPermit" runat="server" Text="Months"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPPaymentMonthsNewNewPermit" Width="3em" runat="server"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="revBPPaymentMonthsNewNewPermit" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="tbBPPaymentMonthsNewNewPermit" ValidationExpression="^[0-9]+$" runat="server"
                                                                ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            </td>
                                            <td valign="top">

                                            <asp:Panel runat="server" GroupingText="Review" Width="70%" Style="text-align: center;"  ID="Panel16rr" CssClass="newitemcontent">
                                                <table>
                                                    <tr>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label42rr" runat="server" Text="Inspection Date"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field" ID="tbBPermitReviewDateNewNewPermit" Width="8em" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="ceBPermitReviewDateNewNewPermit" runat="server" TargetControlID="tbBPermitReviewDateNewNewPermit"
                                                                Format="MM/dd/yyyy" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitReviewDateNewNewPermit" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbBPermitReviewDateNewNewPermit" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label43NewPermit" runat="server" Text="Action Date"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field" ID="tbBPermitActionDateNewNewPermit" Width="8em" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="ceBPermitActionDateNewNewPermit" runat="server" TargetControlID="tbBPermitActionDateNewNewPermit"
                                                                Format="MM/dd/yyyy" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitActionDateNewNewPermit" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbBPermitActionDateNewNewPermit" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label44NewPermit" runat="server" Text="Letter Date"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field" ID="tbBPermitLetterDateNewNewPermit" Width="8em" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="ceBPermitLetterDateNewNewPermit" runat="server" TargetControlID="tbBPermitLetterDateNewNewPermit"
                                                                Format="MM/dd/yyyy" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitLetterDateNewNewPermit" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbBPermitLetterDateNewNewPermit" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label45NewPermit" runat="server" Text="Letter Reference"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPRLetterRefNewNewPermit" MaxLength="25" Width="8em"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="form_field_heading">
                                                            <asp:Label CssClass="form_field_heading" ID="Label46NewPermit" runat="server" Text="Comments"></asp:Label>
                                                        </td>
                                                        <td align="left" class="form_field" colspan="9">
                                                            <asp:TextBox CssClass="form_field" ID="tbBPRCommentsNewNewPermit" Width="99%" runat="server"
                                                                TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    
                                    
                                    
                                    </asp:Panel>
                                    <asp:Panel ID="Panel18" GroupingText="Data from Application Form" runat="server">
                                        <table border="0" cellpadding="2" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label53" runat="server" Text="Lot"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbLotNameNewBP" Width="22" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label54" runat="server" Text="Lane"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="form_field" ID="ddlLaneNewBP" runat="server" DataTextField="Lane"
                                                        DataValueField="Lane">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label55" runat="server" Text="Owner"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbOwnersNameNewBP" Width="20em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label56" runat="server" Text="Applicant"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbApplicantNameNewBP" Width="20em" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label CssClass="form_field_heading" ID="Label57" runat="server" Text="Contractor"></asp:Label>
                                                </td>
                                                <td colspan="2">
                                                    <asp:TextBox CssClass="form_field" ID="tbContractorNewBP" Width="20em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label58" runat="server" Text="Project"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbProjectNewBP" runat="server" Width="20em"
                                                        TextMode="MultiLine" Rows="4"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label59" runat="server" Text="Project Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="form_field" ID="ddlProjectTypeNewBP" runat="server">
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
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </asp:Panel>



                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelSubmittalPhotos" HeaderText="Documents">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatexxxfumfxcanel1y8x432" runat="server">
                    <ContentTemplate>
                        <uc2:FileManager ID="FileManager4" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    
    </ajaxToolkit:TabContainer>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" Enabled="false" CausesValidation="true"
            ID="btnSubmitalUpdate" OnClick="btnSubmitalUpdate_Click" runat="server" Text="Submit" />
        <asp:Label ID="lblSubmitalUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <input id="Hidden1a" type="hidden" value="<% = btnTabTriggerApplicant.ClientID %>" />
    <input id="Hidden2a" type="hidden" value="<% = btnTabTriggerProject.ClientID %>" />

    <asp:Button ID="btnTabTriggerApplicant" style="display:none;" runat="server" Text="..-...u-.-.-.-" OnClick="TabContainer2ActiveTabChange_Applicant" />
    <asp:Button ID="btnTabTriggerProject" style="display:none;" runat="server" Text="..-...u-.-.-.-" OnClick="TabContainer2ActiveTabChange_Project" />

    <script language="javascript" type="text/javascript">
    </script>
    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewSubmittalId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewSubmittalTitleId">
            <span>New Submittal</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewSubmittalContent"
            CssClass="newitemcontent">
            <p style="text-align: left;">
                SubmittalId
                <asp:Label ID="lblAutoSubmittalId" runat="server"></asp:Label>
            </p>
            <script language="javascript" type="text/javascript">
                function clientActiveTabChangedNewSubmittal(sender, args) {
                debugger
                    if (sender.get_activeTabIndex() == 0) { // BPermit tab clicked
                        document.getElementById(document.getElementById('Hidden1a').value).click();
                        //        __doPostBack('btnBPTabTrigger', '');
                    } else {
                        if (sender.get_activeTabIndex() == 1) { // BPermit tab clicked
                            document.getElementById(document.getElementById('Hidden2a').value).click();
                        }
                    }
                }
            </script>
            <ajaxToolkit:TabContainer OnClientActiveTabChanged="clientActiveTabChangedNewSubmittal" Style="text-align: center;" Height="346" ActiveTabIndex="0"
                ID="TabContainer2" runat="server">
                <ajaxToolkit:TabPanel Width="900px" runat="server" ID="tabPanel1" HeaderText="Application Information">
                    <ContentTemplate>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel8" GroupingText="Owner" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Name"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="tbOwnersNameNew" MaxLength="40" Width="30em"
                                                    runat="server"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel9" GroupingText="Sunriver Property" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Lot"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="tbLotNameNew" Width="22" MaxLength="5" runat="server"></asp:TextBox>
                                                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Lane"></asp:Label>
                                                <asp:DropDownList ID="ddlLaneNew" CssClass="form_field" runat="server" DataTextField="Lane"
                                                    DataValueField="Lane">
                                                </asp:DropDownList>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel10" GroupingText="Applicant" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Name"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="tbApplicantNameNew" MaxLength="25" runat="server"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel11" GroupingText="Contractor" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label24" runat="server" Text="Name"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="tbContractorNew" MaxLength="30" Width="30em"
                                                    runat="server"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel13" GroupingText="Meeting Date" runat="server">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox CssClass="form_field" ID="tbMeetingDateNew" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                ID="ibMeetingDateNew" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajaxToolkit:CalendarExtender ID="ceMeetingDateNew" runat="server" TargetControlID="tbMeetingDateNew"
                                                    Format="MM/dd/yyyy" PopupButtonID="ibMeetingDateNew" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="revMeetingDateNew" Display="Dynamic"
                                                    ValidationGroup="SubmittalNew" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbMeetingDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                <asp:Label runat="server" ForeColor="Red" ID="lblRequiredMeetingDate"></asp:Label>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            &nbsp;
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
                                                            <asp:DropDownList CssClass="form_field" ID="ddlProjectTypeNew" runat="server">
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
                                                            <asp:DropDownList CssClass="form_field" ID="ddlProjectDecisionNew" runat="server">
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
                                                            <asp:CheckBox ID="cbIsCommercialNew" runat="server" />
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
                                                            <asp:TextBox CssClass="form_field" ID="tbProjectNew" MaxLength="100" Width="100%"
                                                                runat="server" TextMode="SingleLine" Rows="1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr align="left">
                                                        <td colspan="2">
                                                            <img style="margin-left:500px; alt="Click to copy" src="Images/expand_blue.jpg" onclick="javascript:document.getElementById('MainContent_MainContent_NewItemContent_TabContainer2_tabPanel1_tbSubmittalNew').value=document.getElementById('MainContent_MainContent_NewItemContent_TabContainer2_tabPanel1_tbProjectNew').value;" />
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Submittal"></asp:Label>
                                                        </td>
                                                        <td colspan="6">
                                                            <asp:TextBox CssClass="form_field" ID="tbSubmittalNew" Width="100%" runat="server"
                                                                TextMode="MultiLine" Rows="4"></asp:TextBox>
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
                <ajaxToolkit:TabPanel Width="900px" runat="server" ID="tabPanel2" HeaderText="Project Conditions">
                    <ContentTemplate>
                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="tbConditionsNew" Style="width: 100%;" runat="server" TextMode="MultiLine"
                                    Height="340px"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
            </ajaxToolkit:TabContainer>
        </asp:Panel>
        <script language="javascript" type="text/javascript">
            function doOk() {

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
                        <asp:Button ID="btnNewSubmittalOk" OnClientClick="javascript: if(Page_IsValid) { return doOk();}"
                            CausesValidation="true" runat="server" Text="Okay" OnClick="btnNewSubmittalOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewSubmittalCancel" OnClick="btnNewSubmittalCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to abort?')"
                            runat="server" Text="Abort" />
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
    <asp:LinkButton ID="lbSubmittalNew" OnClick="lbSubmittalNew_OnClick" runat="server">New Submittal</asp:LinkButton>
    <asp:Button Style="display: none;" ID="btnhidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewSubmittal" runat="server" TargetControlID="btnhidden1"
        PopupControlID="pnlNewSubmittalId" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewSubmittalTitleId"
        BehaviorID="jdpopupsubmittal" />
    <script language="javascript" type="text/javascript">
        function shown() {
            var tb = document.getElementById('<% =tbOwnersNameNew.ClientID %>');
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
