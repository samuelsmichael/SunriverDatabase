<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true"
    CodeBehind="ComRoster_Home.aspx.cs" Inherits="SubmittalProposal.ComRoster_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="upBallotVerify" runat="server">
        <ContentTemplate>
            <asp:Panel ID="PnlCommitteesBar" runat="server" CssClass="collapsePanelHeader" Height="30px">
                <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                    <div style="float: left;">
                        Committees
                    </div>
                    <div style="float: right; vertical-align: middle;">
                        <asp:ImageButton CausesValidation="False" ID="ImgCommitteesBar" runat="server" ImageUrl="~/images/expand_blue.jpg"
                            AlternateText="(Show details...)" />
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="PnlCommitteesContent" runat="server">
                <asp:GridView ID="dgCommittees" runat="server" AutoGenerateColumns="False" AutoGenerateSelectButton="true"
                    CellPadding="4" OnSelectedIndexChanged="dgCommittees_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField HeaderText="Name" DataField="CommitteeName" />
                        <asp:BoundField HeaderText="Status" DataField="Status" />
                        <asp:BoundField HeaderText="Charter Date" DataField="CharterDate" DataFormatString="{0:MM/yyyy}" />
                        <asp:BoundField HeaderText="ID" DataField="CommitteeID" />
                    </Columns>
                </asp:GridView>
                <center><asp:LinkButton ID="lbNewCommittee" runat="server">New Committee</asp:LinkButton></center>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="CPECommittees" runat="server" TargetControlID="PnlCommitteesContent"
                ExpandControlID="PnlCommitteesBar" CollapseControlID="PnlCommitteesBar" TextLabelID="LblCommittees"
                ImageControlID="ImgCommitteesBar" CollapsedText="" ExpandedText="" ExpandedImage="~/Images/collapse_blue.jpg"
                CollapsedImage="~/Images/expand_blue.jpg" Collapsed="false" SuppressPostBack="False"
                Enabled="True">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel Style="margin-top: 4px;" ID="PnlCommitteeUpdateBar" runat="server" CssClass="collapsePanelHeader"
                Height="30px">
                <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                    <div style="float: left;">
                        Selected committee:
                        <asp:Label runat="server" ID="lblCommitteeNameForUpdatePanel"></asp:Label>
                    </div>
                    <div style="float: right; vertical-align: middle;">
                        <asp:ImageButton CausesValidation="False" ID="ImgCommitteeUpdateBar" runat="server"
                            ImageUrl="~/images/expand_blue.jpg" AlternateText="(Show details...)" />
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel runat="server" ID="PnlCommitteeUpdateContent">
                <asp:CheckBox ID="cbUnlockRecordCommittee" AutoPostBack="true" Text="Unlock record"
                    TextAlign="Left" runat="server" OnCheckedChanged="cbUnlockRecordCommittee_CheckedChanged" />
                <table cellpadding="0" width="100%" cellspacing="0" border="0">
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox Enabled="false" ID="tbCommitteeNameUpdate" MaxLength="45" Width="19em" runat="server"></asp:TextBox>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label7x2" runat="server" Text="Charter Date"></asp:Label>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox Enabled="false" CssClass="form_field_date" ID="tbCharterDateUpdate" Width="7em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton Enabled="false" ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            ID="ibCharterDateUpdate" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender Enabled="false" ID="cvCharterDateUpdate" runat="server" TargetControlID="tbCharterDateUpdate"
                                Format="MM/dd/yyyy" PopupButtonID="ibCharterDateUpdate" />
                            <asp:RegularExpressionValidator Enabled="false" ForeColor="Red" ID="rvcvCharterDateUpdate" Display="Dynamic"
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbCharterDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Status"></asp:Label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList Enabled="false" ID="ddlCommitteeStatusUpdate" runat="server">
                                <asp:ListItem Selected="True">Active</asp:ListItem>
                                <asp:ListItem>Inactive</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td colspan="6" align="left">
                            <center><table border="0" cellpadding="3" cellspacing="3" >
                                <tr valign="top">
                                    <td valign="top" align="right">
                                        <asp:Label CssClass="form_field_heading" ID="lbl33x104" runat="server" Text="# of Members"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox Enabled="false" ID="tbCommitteeNbrOfMembersUpdate" MaxLength="2" Width="1.7em" runat="server"></asp:TextBox>
                                        <asp:CustomValidator Enabled="false" ID="cvCommitteeNbrOfMembersUpdate" ControlToValidate="tbCommitteeNbrOfMembersUpdate"
                                            Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                            ErrorMessage="Must numeric" OnServerValidate="cvCommitteeNbrOfMembersUpdate_ServerValidate"></asp:CustomValidator>

                                    </td>
                                    <td valign="top">
                                        <asp:Label CssClass="form_field_heading" ID="Label1x4xc" runat="server" Text="Notes"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox Enabled="false" ID="tbCommitteeNbrOfMembersNotesUpdate" Width="34em" runat="server" TextMode="MultiLine" Height="4em"></asp:TextBox>
                                    </td>
                                </tr>
                            </table></center>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="q103z33" runat="server" Text="Term Notes"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox Enabled="false" ID="tbCommitteeTermNotesUpdate" Width="34em" runat="server" TextMode="MultiLine" Height="4em"></asp:TextBox>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="z103q33" runat="server" Text="Term (years)"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox Enabled="false" ID="tbCommitteeTermYearsUpdate" MaxLength="2" Width="1.7em" runat="server"></asp:TextBox>
                            <asp:CustomValidator Enabled="false" ID="cvCommitteeTermYearsUpdate" ControlToValidate="tbCommitteeTermYearsUpdate"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must numeric" OnServerValidate="cvCommitteeNbrOfMembersUpdate_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Lababel1z3a3dd3l1" runat="server" Text="# of Terms Limit"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox Enabled="false" ID="tbCommitteeNbrOfTermsLimitUpdate" MaxLength="2" Width="1.7em" runat="server"></asp:TextBox>
                            <asp:CustomValidator Enabled="false" ID="cvCommitteeNbrOfTermsLimitUpdate" ControlToValidate="tbCommitteeNbrOfTermsLimitUpdate"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must numeric" OnServerValidate="cvCommitteeNbrOfMembersUpdate_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td colspan="6" align="left">
                            <center><table border="0" cellpadding="3" cellspacing="3" >
                                <tr valign="top">
                                    <td valign="top" align="right">
                                        <asp:Label CssClass="form_field_heading" ID="lbl33333x104" runat="server" Text="Alternate Members Allowed"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox Enabled="false" ID="cbCommitteeAlternateMembersAllowed" runat="server" />
                                    </td>
                                    <td valign="top">
                                        <asp:Label CssClass="form_field_heading" ID="Lab33el1x4xc" runat="server" Text="Associate Members Allowed"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:CheckBox Enabled="false" ID="cbCommitteeAssociateMembersAllowed" runat="server" />
                                    </td>
                                </tr>
                            </table></center>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td colspan="6">
                            <center>
                                <asp:Button ID="btnCommitteeUpdateSubmit" Visible="false" runat="server" Text="Submit" 
                                    onclick="btnCommitteeUpdateSubmit_Click" />
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <asp:Label ID="lblCommitteeUpdateMessage" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="CPECommitteeUpdate" runat="server" TargetControlID="PnlCommitteeUpdateContent"
                ExpandControlID="PnlCommitteeUpdateBar" CollapseControlID="PnlCommitteeUpdateBar"
                TextLabelID="LblCommitteeUpdate" ImageControlID="ImgCommitteeUpdateBar" CollapsedText=""
                ExpandedText="" ExpandedImage="~/Images/collapse_blue.jpg" CollapsedImage="~/Images/expand_blue.jpg"
                Collapsed="true" SuppressPostBack="True" Enabled="True">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel Style="margin-top: 4px;" ID="PnlLiaisonAndCommitteeListsBar" runat="server"
                CssClass="collapsePanelHeader" Height="30px">
                <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                    <div style="float: left;">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    Liaison and Committee Lists
                                </td>
                                <td>
                                    <asp:Label ID="LBLLiaisonAndCommitteeLists" CssClass="collapsePanelText" Text=""
                                        runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="float: right; vertical-align: middle;">
                        <asp:ImageButton CausesValidation="False" ID="ImgLiaisonAndCommitteeListsBar" runat="server"
                            ImageUrl="~/images/expand_blue.jpg" AlternateText="(Show details...)" />
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel runat="server" ID="PnlLiaisonAndCommitteeListsContent">
                <asp:CheckBox ID="cbUnlockRecordLists" AutoPostBack="true" Text="Unlock record" TextAlign="Left"
                    runat="server" OnCheckedChanged="cbUnlockRecordCommittee_CheckedChanged" />
                <table>
                    <tr>
                        <td style="width: 50%;">
                            <asp:Panel Width="100%" runat="server" ID="pnlLiaisonList" GroupingText="Liaison List">
                            </asp:Panel>
                            <center><asp:LinkButton ID="lbWorkWithLiaisons" runat="server">Work with Liaisons</asp:LinkButton></center>
                        </td>
                        <td style="width: 50%;">
                            <asp:Panel Width="100%" runat="server" ID="pnlMemberListAndCommitteeTerms" GroupingText="Member List & Committee Terms">
                            </asp:Panel>
                            <center><asp:LinkButton ID="lbWorkWithMembers" runat="server">Work with Members</asp:LinkButton></center>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="CPELiaisonAndCommitteeLists" runat="server"
                TargetControlID="PnlLiaisonAndCommitteeListsContent" ExpandControlID="PnlLiaisonAndCommitteeListsBar"
                CollapseControlID="PnlLiaisonAndCommitteeListsBar" TextLabelID="LblLiaisonAndCommitteeLists"
                ImageControlID="ImgLiaisonAndCommitteeListsBar" CollapsedText="" ExpandedText=""
                ExpandedImage="~/Images/collapse_blue.jpg" CollapsedImage="~/Images/expand_blue.jpg"
                Collapsed="true" SuppressPostBack="True" Enabled="True">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
