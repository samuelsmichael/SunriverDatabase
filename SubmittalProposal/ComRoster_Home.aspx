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
                        <asp:BoundField HeaderText="Charter Date" DataField="CharterDate" DataFormatString="d" />
                        <asp:BoundField HeaderText="ID" DataField="CommitteeID" />
                    </Columns>
                </asp:GridView>
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
                        <asp:Label runat="server" ID="lblCommitteeNameForUpdatePanel">Programming Committee</asp:Label>
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
                Here's where I put the Committee Update controls
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
                        </td>
                        <td style="width: 50%;">
                            <asp:Panel Width="100%" runat="server" ID="pnlMemberListAndCommitteeTerms" GroupingText="Member List & Committee Terms">
                            </asp:Panel>
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
