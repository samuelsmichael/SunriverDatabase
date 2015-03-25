﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Database.Master" AutoEventWireup="true"
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
                                        <asp:TextBox CssClass="form_field" ID="tbOwnersName" Width="30em" runat="server"></asp:TextBox>
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
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" Style="margin-top: 3px;" ID="Label13" runat="server"
                                                        Text="Date fee paid"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbDateFeePaid" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="Panel6" GroupingText="Meeting Date" runat="server">
                                        <asp:TextBox CssClass="form_field" ID="tbMeetingDate" runat="server"></asp:TextBox>
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
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
                                                <asp:TextBox CssClass="form_field" ID="TextBox2" Width="22" runat="server"></asp:TextBox>
                                                <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Lane"></asp:Label>
                                                <asp:DropDownList ID="DropDownList1" CssClass="form_field" runat="server" DataTextField="Lane"
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
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label CssClass="form_field_heading" Style="margin-top: 3px;" ID="Label26" runat="server"
                                                                Text="Date fee paid"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="form_field" ID="TextBox6" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                        <td>
                                            <asp:Panel ID="Panel13" GroupingText="Meeting Date" runat="server">
                                                <asp:TextBox CssClass="form_field" ID="TextBox7" runat="server"></asp:TextBox>
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
        <table width="100%">
            <tr>
                <td>
                    <asp:Button ID="btnNewSubmittalOk" TabIndex="3" runat="server" Text="Okay" />
                </td>
                <td>
                    <asp:Button ID="btnNewSubmittalCancel" TabIndex="4" runat="server" Text="Cancel" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:LinkButton ID="lbSubmittalNew" runat="server">New Submittal</asp:LinkButton>
    <ajaxToolkit:ModalPopupExtender ID="MPE" runat="server" TargetControlID="lbSubmittalNew"
        PopupControlID="pnlNewSubmittalId" BackgroundCssClass="modalBackground" OkControlID="btnNewSubmittalOk"
        CancelControlID="btnNewSubmittalCancel" PopupDragHandleControlID="pnlNewSubmittalTitleId"
        BehaviorID="jdpopup" />
    <script language="javascript" type="text/javascript">
        function shown() {
            var tb = document.getElementById('<% =tbSubmittalNewName.ClientID %>');
            tb.focus();
        }
        function pageLoad() {
            $addHandler(document, "keydown", OnKeyPress);
            var ddd = $find('jdpopup');
            ddd.add_shown(shown);
        }

        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
// I don't know about this                $find("jdpopup").hide();
            }
        }
    </script>
</asp:Content>