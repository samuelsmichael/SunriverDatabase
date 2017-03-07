<%@ Page Title="" Language="C#" MasterPageFile="~/Database.Master" AutoEventWireup="true"
    CodeBehind="Submittal2.aspx.cs" Inherits="SubmittalProposal.Submittal2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Owner"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbOwner" Width="85" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="Applicant"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbApplicant" Width="85" runat="server"></asp:TextBox>
    </td>
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
        ForeColor="#333333" GridLines="None" AllowPaging="True" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        OnSorting="gvResults_Sorting" 
        OnPageIndexChanging="gvResults_PageIndexChanging">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" Position="Bottom"
            PageButtonCount="15" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="Lot" HeaderText="Lot" SortExpression="Lot" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Lane" HeaderText="Lane" SortExpression="Lane" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Project" HeaderText="Project" 
                SortExpression="Project" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="ProjectDecision" HeaderText="Descision" 
                SortExpression="ProjectDecision" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Mtg_Date" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Meeting Date"
                SortExpression="Mtg_Date" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="SubmittalId" HeaderText="Submittal Id" 
                SortExpression="SubmittalId" >
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
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbOwnersNameUpdate" Width="30em" MaxLength="40" runat="server"></asp:TextBox>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel2" GroupingText="Sunriver Property" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Lot"></asp:Label>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbLotNameUpdate" Width="22" MaxLength="5" runat="server"></asp:TextBox>
                                        <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>
                                        <asp:DropDownList Enabled="false" ID="ddlLaneUpdate" CssClass="form_field" runat="server" DataTextField="Lane"
                                            DataValueField="Lane">
                                        </asp:DropDownList>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel3" GroupingText="Applicant" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbApplicantNameUpdate" MaxLength="25" runat="server"></asp:TextBox>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel4" GroupingText="Contractor" runat="server">
                                        <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Name"></asp:Label>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbContractorUpdate" MaxLength="30" Width="30em" runat="server"></asp:TextBox>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel6" GroupingText="Meeting Date" runat="server">
                                        <table><tr><td>
                                        <asp:TextBox CssClass="form_field" Enabled="false" ID="tbMeetingDateUpdate" runat="server"></asp:TextBox>
                                        </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibMeetingDateUpdate" runat="server" /></td></tr></table>
                                        <ajaxToolkit:CalendarExtender ID="ceMeetingDateUpdate" runat="server"
                                            TargetControlID="tbMeetingDateUpdate"
                                            Format="MM/dd/yyyy"
                                            PopupButtonID="ibMeetingDateUpdate" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revMeetingDateUpdate"  Display="Dynamic" 
                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbMeetingDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="rfvMeedtingDateUpdate" ForeColor="Red" ControlToValidate="tbMeetingDateUpdate" runat="server" ErrorMessage="Meeting Date is required"></asp:RequiredFieldValidator>
                                    </asp:Panel>
                                </td>
                                <td>&nbsp;</td>
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
                                                    <asp:DropDownList Enabled="false" CssClass="form_field" ID="ddlProjectTypeUpdate" runat="server">
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
                                                    <asp:DropDownList Enabled="false" CssClass="form_field" ID="ddlProjectDecisionUpdate" runat="server">
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
                                                    <asp:TextBox Enabled="false" CssClass="form_field" ID="tbProjectUpdate" MaxLength="100" Width="100%" runat="server" TextMode="SingleLine"
                                                        Rows="1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Submittal"></asp:Label>
                                                </td>
                                                <td colspan="6">
                                                    <asp:TextBox Enabled="false" CssClass="form_field" ID="tbSubmittalUpdate" Width="100%" runat="server" TextMode="MultiLine"
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
                        <asp:TextBox Enabled="false" ID="tbConditionsUpdate" Style="width: 100%;" runat="server" TextMode="MultiLine"
                            Height="340px"></asp:TextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" Enabled="false" CausesValidation="true" ID="btnSubmitalUpdate" OnClick="btnSubmitalUpdate_Click" runat="server"
            Text="Submit" />
        <asp:Label ID="lblSubmitalUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <script language="javascript" type="text/javascript">
    </script>
    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewSubmittalId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewSubmittalTitleId">
            <span>New Submittal</span>
        </asp:Panel>
        <asp:Panel runat="server" style="text-align:center;" ID="pnlNewSubmittalContent" CssClass="newitemcontent">
            <p style="text-align:left;"> 
                SubmittalId  <asp:Label ID="lblAutoSubmittalId" runat="server"></asp:Label>
            </p>
            <ajaxToolkit:TabContainer  style="text-align:center;" Height="346" ActiveTabIndex="0" ID="TabContainer2" runat="server">
                <ajaxToolkit:TabPanel Width="900px" runat="server" ID="tabPanel1" HeaderText="Applicant Information">
                    <ContentTemplate>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel8" GroupingText="Owner" runat="server">
                                                <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Name"></asp:Label>
                                                <asp:TextBox CssClass="form_field" ID="tbOwnersNameNew" MaxLength="40" Width="30em" runat="server"></asp:TextBox>
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
                                                <asp:TextBox CssClass="form_field" ID="tbContractorNew" MaxLength="30" Width="30em" runat="server"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel13" GroupingText="Meeting Date" runat="server">
                                                <table><tr><td>
                                                <asp:TextBox CssClass="form_field" ID="tbMeetingDateNew" runat="server"></asp:TextBox>
                                                </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibMeetingDateNew" runat="server" /></td></tr></table>
                                                <ajaxToolkit:CalendarExtender ID="ceMeetingDateNew" runat="server"
                                                    TargetControlID="tbMeetingDateNew"
                                                    Format="MM/dd/yyyy"
                                                    PopupButtonID="ibMeetingDateNew" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="revMeetingDateNew"  Display="Dynamic" ValidationGroup="SubmittalNew"
                                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbMeetingDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                <asp:Label runat="server" ForeColor="Red" ID="lblRequiredMeetingDate"></asp:Label>
                                            </asp:Panel>
                                        </td>
                                        <td>&nbsp;</td>
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
                                                            <asp:TextBox CssClass="form_field" ID="tbProjectNew" MaxLength="100" Width="100%" runat="server" TextMode="SingleLine"
                                                                Rows="1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Submittal"></asp:Label>
                                                        </td>
                                                        <td colspan="6">
                                                            <asp:TextBox CssClass="form_field" ID="tbSubmittalNew" Width="100%" runat="server" TextMode="MultiLine"
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
                                <asp:TextBox ID="tbConditionsNew" Style="width: 100%;" runat="server" TextMode="MultiLine"
                                    Height="340px"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
            </ajaxToolkit:TabContainer>
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

        // Called when async postback ends
        function prm_EndRequest(sender, args) {
            // get the divImage and hide it again
            //debugger
            if (sender._postBackSettings.sourceElement.id.indexOf("BtnGo") != -1 || sender._postBackSettings.sourceElement.id.indexOf("gvResults") != -1
                || (sender._postBackSettings.sourceElement.id.indexOf("btnNew") != -1 && sender._postBackSettings.sourceElement.id.indexOf("Ok" )!=-1)) {
                var loading = $(".loading");
                loading.hide();
            }
        }

        </script>
        <center>
            <table cellpadding="4">
                <tr>
                    <td>
                        <asp:Button ID="btnNewSubmittalOk"  OnClientClick="javascript: if(Page_IsValid) { return doOk();}" CausesValidation="true" runat="server" Text="Okay" 
                            onclick="btnNewSubmittalOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewSubmittalCancel" onclick="btnNewSubmittalCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to abort?')" runat="server" Text="Abort" />
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

    <asp:LinkButton ID="lbSubmittalNew" OnClick="lbSubmittalNew_OnClick"  runat="server">New Submittal</asp:LinkButton>
    <asp:Button style="display:none;" ID="btnhidden1" runat="server" />

    <ajaxToolkit:ModalPopupExtender ID="mpeNewSubmittal" runat="server" TargetControlID="btnhidden1"
        PopupControlID="pnlNewSubmittalId" BackgroundCssClass="modalBackground" 
        PopupDragHandleControlID="pnlNewSubmittalTitleId"
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
