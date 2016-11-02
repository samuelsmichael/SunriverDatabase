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
                    <div style="float:right;vertical-align:middle;margin-right:.5em">
                        <asp:LinkButton Font-Bold="false" ForeColor="White" ID="lbWorkWithLiaisonsBar" Visible="false" OnClientClick="javascript: return true;" runat="server" Text="Work with Liaisons "
                            OnClick="lbWorkWithLiaisons_click" />
                    </div>
                    <div style="float:right;vertical-align:middle;margin-right:.5em"">
                        <asp:LinkButton Font-Bold="false" ID="lbWorkWithMembersBar" Visible="false" OnClientClick="javascript: return true;" runat="server" Text="Work with Members "
                            ForeColor="White" OnClick="lbWorkWithMembers_click" />
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
                            <asp:TextBox Enabled="false" ID="tbCommitteeNameUpdate" MaxLength="45" Width="19em"
                                runat="server"></asp:TextBox>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label7x2" runat="server" Text="Charter Date"></asp:Label>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox Enabled="false" CssClass="form_field_date" ID="tbCharterDateUpdate"
                                            Width="7em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton Enabled="false" ImageAlign="AbsMiddle" ToolTip="Click to show date selector"
                                            ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibCharterDateUpdate" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender Enabled="false" ID="cvCharterDateUpdate" runat="server"
                                TargetControlID="tbCharterDateUpdate" Format="MM/dd/yyyy" PopupButtonID="ibCharterDateUpdate" />
                            <asp:RegularExpressionValidator Enabled="false" ForeColor="Red" ID="rvcvCharterDateUpdate"
                                Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
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
                            <center>
                                <table border="0" cellpadding="3" cellspacing="3">
                                    <tr valign="top">
                                        <td valign="top" align="right">
                                            <asp:Label CssClass="form_field_heading" ID="lbl33x104" runat="server" Text="# of Members"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox Enabled="false" ID="tbCommitteeNbrOfMembersUpdate" MaxLength="2" Width="1.7em"
                                                runat="server"></asp:TextBox>
                                            <asp:CustomValidator Enabled="false" ID="cvCommitteeNbrOfMembersUpdate" ControlToValidate="tbCommitteeNbrOfMembersUpdate"
                                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                                ErrorMessage="Must numeric" OnServerValidate="cvCommitteeNbrOfMembersUpdate_ServerValidate"></asp:CustomValidator>
                                        </td>
                                        <td valign="top">
                                            <asp:Label CssClass="form_field_heading" ID="Label1x4xc" runat="server" Text="Notes"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox Enabled="false" ID="tbCommitteeNbrOfMembersNotesUpdate" Width="34em"
                                                runat="server" TextMode="MultiLine" Height="4em"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="q103z33" runat="server" Text="Term Notes"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox Enabled="false" ID="tbCommitteeTermNotesUpdate" Width="34em" runat="server"
                                TextMode="MultiLine" Height="4em"></asp:TextBox>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="z103q33" runat="server" Text="Term (years)"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox Enabled="false" ID="tbCommitteeTermYearsUpdate" MaxLength="2" Width="1.7em"
                                runat="server"></asp:TextBox>
                            <asp:CustomValidator Enabled="false" ID="cvCommitteeTermYearsUpdate" ControlToValidate="tbCommitteeTermYearsUpdate"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must numeric" OnServerValidate="cvCommitteeNbrOfMembersUpdate_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Lababel1z3a3dd3l1" runat="server" Text="# of Terms Limit"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox Enabled="false" ID="tbCommitteeNbrOfTermsLimitUpdate" MaxLength="2"
                                Width="1.7em" runat="server"></asp:TextBox>
                            <asp:CustomValidator Enabled="false" ID="cvCommitteeNbrOfTermsLimitUpdate" ControlToValidate="tbCommitteeNbrOfTermsLimitUpdate"
                                Display="Dynamic" ForeColor="Red" Font-Bold="true" SetFocusOnError="true" runat="server"
                                ErrorMessage="Must numeric" OnServerValidate="cvCommitteeNbrOfMembersUpdate_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td colspan="6" align="left">
                            <center>
                                <table border="0" cellpadding="3" cellspacing="3">
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
                                </table>
                            </center>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td colspan="6">
                            <center>
                                <asp:Button ID="btnCommitteeUpdateSubmit" Visible="false" runat="server" Text="Submit"
                                    OnClick="btnCommitteeUpdateSubmit_Click" />
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
            <asp:Panel Enabled="false" Width="100%" Style="margin-top: 4px;" ID="PnlLiaisonAndCommitteeListsBar"
                runat="server" CssClass="collapsePanelHeader" Height="30px">
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
            <asp:Panel Width="100%" runat="server" ID="PnlLiaisonAndCommitteeListsContent">
                <table>
                    <tr valign="top">
                        <td style="width: 50%;">
                            <asp:Panel Width="100%" runat="server" ID="pnlLiaisonList" Enabled='false' GroupingText="Liaison List">
                                <asp:GridView Width="100%" ID="gvLiaisonList" runat="server" BackColor="White" 
                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Style="margin-top: 0px"
                                    OnRowCancelingEdit="gvLiaisonList_RowCancelingEdit" AutoGenerateColumns="False"
                                     OnRowDeleting="gvLiaisonList_RowDeleting"
                                     OnRowDataBound="gvLiaisonList_RowDataBound"
                                    DataKeyNames="RosterLiaisonID">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Liaison Name">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlLiaisonListLiaisonName" runat="server" DataTextField="LiaisonNameAndType"
                                                    DataValueField="LiaisonID">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1dtt" runat="server" Text='<%# Bind("LiaisonName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Liaison Type">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlLiaisonListLiaisonType" runat="server" DataTextField="LiaisonType"
                                                    DataValueField="LiaisonType">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("LiaisonType") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="LiaisonID" DataField="LiaisonID" Visible="False" />
                                        <asp:CommandField ShowDeleteButton="True" />
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                    <RowStyle ForeColor="#000066" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                                </asp:GridView>
                                <center>
                                    <asp:LinkButton ID="lbLiaisonInCommitteeAdd" Visible="false" runat="server" OnClick="lbLiaisonInCommitteeAdd_Click">Add</asp:LinkButton></center>
                                <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewLiaison">
                                    <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewLiaisonTitle">
                                        <span>New Liaison</span>
                                    </asp:Panel>
                                    <asp:Panel runat="server" Style="text-align: center;" ID="Panelx36" CssClass="newitemcontent">
                                        <table border="0" cellpadding="3" cellspacing="3">
                                            <tr>
                                                <td class="form_field_heading">
                                                    <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Name "></asp:Label>
                                                </td>
                                                <td class="form_field">
                                                    <asp:DropDownList ID="ddlLiaisonNew" runat="server" DataTextField="LiaisonNameAndType"
                                                        DataValueField="LiaisonID">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <asp:Label ID="lblNewLiaisonMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <center>
                                            <table cellpadding="3">
                                                <tr>
                                                    <td>
                                                        <asp:Button CausesValidation="true" OnClientClick="javascript: if(Page_IsValid) { return doComRosterOk();} "
                                                            ID="btnNewLiaisonOk" runat="server" Text="Okay" OnClick="btnNewLiaisonOk_Click" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnNewLiaisonCancel" runat="server" Text="Cancel" CausesValidation="false"
                                                            OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                                            OnClick="btnNewLiaisonCancel_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </center>
                                    </asp:Panel>
                                    <script language="javascript" type="text/javascript">
                                        function doComRosterOk() {

                                            var loading = $(".loadingdb");
                                            loading.show();
                                            var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                                            var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                                            loading.css({ top: top, left: left });
                                            return true;
                                        }
                                    </script>
                                </asp:Panel>
                                <asp:Button runat="server" ID="dummyNewLiaison" Style="display: none" />
                                <ajaxToolkit:ModalPopupExtender ID="mpeNewLiaison" runat="server" TargetControlID="dummyNewLiaison"
                                    PopupControlID="pnlNewLiaison" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewLiaisonTitle" />
                            </asp:Panel>
                            <center>
                                <asp:LinkButton ID="lbWorkWithLiaisons" Visible="false" OnClick="lbWorkWithLiaisons_click" runat="server">Work with Liaisons</asp:LinkButton></center>
                        </td>
                        <td style="width: 50%;">
                            <asp:Panel Width="100%" runat="server" Enabled="false" ID="pnlMemberListAndCommitteeTerms"
                                GroupingText="Member List & Committee Terms">
                                <asp:GridView Width="100%" ID="gvMemberListAndCommitteeTerms" runat="server" AutoGenerateColumns="false"
                                    AutoGenerateEditButton="true" OnRowEditing="gvMemberListAndCommitteeTerms_RowEditing"
                                    OnRowDeleting="gvMemberListAndCommitteeTerms_RowDeleting" OnRowUpdating="gvMemberListAndCommitteeTerms_RowUpdating"
                                    OnRowCancelingEdit="gvMemberListAndCommitteeTerms_RowCancelingEdit" OnRowDataBound="gvMemberListAndCommitteeTerms_RowDataBound"
                                    DataKeyNames="RosterMemberID,MemberID" BackColor="White" BorderColor="#999999"
                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Member Name">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlMemberListAndCommitteeTermsNames" runat="server" DataTextField="FullName"
                                                    DataValueField="MemberID">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1ssc3" runat="server" Text='<%# Bind("MemberName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Title">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlMemberListAndCommitteeTermsTitles" runat="server" DataTextField="MTitle"
                                                    DataValueField="TitleSort">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label122ff" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Appointed">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbMemberListAndCommitteeTermsAppointed" runat="server" Width="6em"
                                                    Text='<%# Convert.ToDateTime(Eval("Appointed")).ToString("MM/yyyy") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1d3d5" runat="server" Text='<%# Convert.ToDateTime(Eval("Appointed")).ToString("MM/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbMemberListAndCommitteeTermsStart" runat="server" Width="6em" Text='<%# Convert.ToDateTime(Eval("Start")).ToString("MM/yyyy") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblMemberListAndCommitteeTermsStart" runat="server" Text='<%# Convert.ToDateTime(Eval("Start")).ToString("MM/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="End">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbMemberListAndCommitteeTermsEnd" runat="server" Width="6em" Text='<%# Convert.ToDateTime(Eval("End")).ToString("MM/yyyy") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblMemberListAndCommitteeTermsEnd" runat="server" Text='<%# Convert.ToDateTime(Eval("End")).ToString("MM/yyyy") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Term">
                                            <EditItemTemplate>
                                                <asp:DropDownList runat="server" ID="ddlCommitteeMemberTerm">
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1sxx1" runat="server" Text='<%# Bind("Term") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ShowDeleteButton="True" />
                                        <asp:BoundField HeaderText="MemberID" DataField="MemberID" Visible="False" />
                                    </Columns>
                                    <AlternatingRowStyle BackColor="#DCDCDC" />
                                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#000065" />
                                </asp:GridView>
                                <center>
                                    <asp:LinkButton ID="lbMemberListAndCommitteeTermsAdd" Visible="false" runat="server"
                                        OnClick="lbMemberListAndCommitteeTermsAdd_Click">Add</asp:LinkButton></center>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewCommitteeMember">
                                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewCommitteeMemberTitle">
                                    <span>New Committee Member</span>
                                </asp:Panel>
                                <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewCommitteMemberMainPanel"
                                    CssClass="newitemcontent">
                                    <table border="0" cellpadding="3" cellspacing="3">
                                        <tr>
                                            <td>
                                                <asp:Label CssClass="form_field_heading" ID="Label2x33n" runat="server" Text="Appointed"></asp:Label>
                                            </td>
                                                
                                            <td>
                                                <asp:DropDownList ID="ddlMemberListAndCommitteeTermsNamesAdd" runat="server" DataTextField="FullName"
                                                    DataValueField="MemberID">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Label CssClass="form_field_heading" ID="Label1xx33" runat="server" Text="Title"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlMemberListAndCommitteeTermsTitlesAdd" runat="server" DataTextField="MTitle"
                                                    DataValueField="TitleSort">
                                                </asp:DropDownList>
                                            </td>
                                                <asp:Label CssClass="form_field_heading" ID="Labsel1" runat="server" Text="Term"></asp:Label>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlCommitteeMemberTermAdd">
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                </asp:DropDownList>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:Label CssClass="form_field_heading" ID="Label1f3" runat="server" Text="Appointed"></asp:Label>
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox  CssClass="form_field_date" ID="tbCommitteeMemberAppointedNew" Width="7em"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector"
                                                                ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibCommitteeMemberAppointedNew" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajaxToolkit:CalendarExtender  ID="ceCommitteeMemberAppointedNew" runat="server"
                                                    TargetControlID="tbCommitteeMemberAppointedNew" Format="MM/dd/yyyy" PopupButtonID="ibCommitteeMemberAppointedNew" />
                                                <asp:RegularExpressionValidator  ForeColor="Red" ID="RegularExpressionValidator1"
                                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbCommitteeMemberAppointedNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </td>

                                            <td valign="top">
                                                <asp:Label CssClass="form_field_heading" ID="Label33vvd" runat="server" Text="Start"></asp:Label>
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox  CssClass="form_field_date" ID="tbCommitteeMemberStartNew" Width="7em"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton  ImageAlign="AbsMiddle" ToolTip="Click to show date selector"
                                                                ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibCommitteeMemberStartNew" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajaxToolkit:CalendarExtender  ID="ceCommitteeMemberStartNew" runat="server"
                                                    TargetControlID="tbCommitteeMemberStartNew" Format="MM/dd/yyyy" PopupButtonID="ibCommitteeMemberStartNew" />
                                                <asp:RegularExpressionValidator  ForeColor="Red" ID="RegularExpressionValidator2"
                                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbCommitteeMemberStartNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </td>
                                            <td valign="top">
                                                <asp:Label CssClass="form_field_heading" ID="Label4cc33" runat="server" Text="End"></asp:Label>
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox  CssClass="form_field_date" ID="tbCommitteeMemberEndNew" Width="7em"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton  ImageAlign="AbsMiddle" ToolTip="Click to show date selector"
                                                                ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibCommitteeMemberEndNew" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajaxToolkit:CalendarExtender  ID="ceCommitteeMemberEndNew" runat="server"
                                                    TargetControlID="tbCommitteeMemberEndNew" Format="MM/dd/yyyy" PopupButtonID="ibCommitteeMemberEndNew" />
                                                <asp:RegularExpressionValidator  ForeColor="Red" ID="RegularExpressionValidator3"
                                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbCommitteeMemberEndNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td colspan="6" align="center">
                                                <asp:Label ID="lblNewCommitteeMemberMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <center>
                                        <table cellpadding="3">
                                            <tr>
                                                <td>
                                                    <asp:Button CausesValidation="true" OnClientClick="javascript: if(Page_IsValid) { return doComRosterOk();} "
                                                        ID="btnNewCommitteeMemberOk" runat="server" Text="Okay" OnClick="btnNewCommitteeMemberOk_Click" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnNewCommitteeMemberCancel" runat="server" Text="Cancel" CausesValidation="false"
                                                        OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                                        OnClick="btnNewCommitteeMemberCancel_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </center>
                                </asp:Panel>
                                <script language="javascript" type="text/javascript">
                                    function doComRosterOk() {

                                        var loading = $(".loadingdb");
                                        loading.show();
                                        var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                                        var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                                        loading.css({ top: top, left: left });
                                        return true;
                                    }
                                </script>
                            </asp:Panel>
                            <asp:Button runat="server" ID="dummyNewCommitteeMember" Style="display: none" />
                            <ajaxToolkit:ModalPopupExtender ID="mpeNewCommitteeMember" runat="server" TargetControlID="dummyNewCommitteeMember"
                                PopupControlID="pnlNewCommitteeMember" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewCommitteeMemberTitle" />
                            <center>
                                <asp:LinkButton ID="lbWorkWithMembers" OnClick="lbWorkWithMembers_click" Visible="false" runat="server" >Work with Members</asp:LinkButton></center>
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
