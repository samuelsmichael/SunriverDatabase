<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="ComplianceReview.aspx.cs" Inherits="SubmittalProposal.ComplianceReview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td width="40">
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLot" Width="30" runat="server"></asp:TextBox>
    </td>
    <td width="100">
        <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" runat="server" DataTextField="Lane" DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td width="184">
        <asp:Label ID="Label1" runat="server" Text="Comments"></asp:Label>
        <asp:TextBox ID="tbComments" Width="180" runat="server"></asp:TextBox>
    </td>
    <td width="184">
        <asp:Label ID="Label2" runat="server" Text="Rule"></asp:Label>
        <asp:TextBox ID="tbRule" Width="100" runat="server"></asp:TextBox>
    </td>
    <td width="66">
        <asp:Label ID="Label22" runat="server" Text="Review Id"></asp:Label>
        <asp:TextBox ID="tbReviewId" Width="66" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" Style="width: 100%;" runat="server"
        AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"
        OnSelectedIndexChanged="gvResults_SelectedIndexChanged" OnSorting="gvResults_Sorting"
        OnPageIndexChanging="gvResults_PageIndexChanging" PageSize="15" AllowPaging="true">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" Position="Bottom"
            PageButtonCount="15" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="crDate" DataFormatString=" {0:d}" HeaderText="Review Date"
                SortExpression="crDate">
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="crLot" HeaderText="Lot" SortExpression="crLot" />
            <asp:BoundField DataField="crLane" HeaderText="Lane" SortExpression="crLane" />
            <asp:BoundField DataField="crComments" HeaderText="Comments" />
            <asp:BoundField DataField="crRule" HeaderText="Rule" />
            <asp:BoundField DataField="crCorrection" HeaderText="Correction" />
            <asp:BoundField DataField="crFollowUp" HeaderText="Follow-up">
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="crCloseDate" DataFormatString=" {0:d}" SortExpression="crCloseDate"
                HeaderText="Close" />
            <asp:BoundField DataField="crReviewID" HeaderText="Inspection Nbr">
                <ItemStyle HorizontalAlign="Center" />
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
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <ajaxToolkit:TabContainer Height="376" ActiveTabIndex="0" ID="TabContainer1" runat="server">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelComplianceRuleData" HeaderText="Compliance Review">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3aa" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="Panel1" GroupingText="Review" runat="server">
                            <table width="100%" cellpadding="4" cellspacing="4" border="0">
                                <tr valign="middle">
                                    <td align="right">
                                        <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Review date:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbReviewDate" runat="server"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Close date:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbCloseDate" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Comments:"></asp:Label>
                                    </td>
                                    <td width="100%">
                                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="tbCommentsForm" runat="server"
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel CssClass="form_field_panel" ID="Panel2" GroupingText="Other comments"
                            runat="server">
                            <table width="100%" cellpadding="4" cellspacing="4" border="0">
                                <tr valign="middle">
                                    <td align="right">
                                        <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Design rule:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" Width="15em" ID="tbDesignRule" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Req'd Action:"></asp:Label>
                                    </td>
                                    <td width="60%">
                                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="tbRequiredAction"
                                            runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Follow up:"></asp:Label>
                                    </td>
                                    <td width="40%">
                                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="tbFollowUp" runat="server"
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelComplianceLetterData" HeaderText="Compliance Letter (Paging)">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel1aa" runat="server">
                    <ContentTemplate>
                        <asp:FormView Width="100%" ID="fvComplianceLetter" AllowPaging="true" runat="server"
                            OnDataBound="fvComplianceLetter_OnDataBound" BackColor="White" BorderColor="#3366CC"
                            BorderStyle="Inset" OnModeChanging="fvComplianceLetter_OnModeChanging" BorderWidth="3px"
                            CellPadding="4" GridLines="Both" OnPageIndexChanging="fvComplianceLetter_PageIndexChanging"
                            DataKeyNames="crLTID">
                            <EditRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" ForeColor="#003399" />
                            <ItemTemplate>
                                <div class="formviewdiv">
                                    <asp:Panel CssClass="form_field_panel_squished" ID="Panel1" GroupingText="Dates"
                                        runat="server">
                                        <table width="100%" cellpadding="4" cellspacing="4" border="0">
                                            <tr valign="middle">
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Letter date:"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="crLtDate" runat="server"
                                                        Text='<%# Eval("crLTDate","{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Action deadline:"></asp:Label>
                                                </td>
                                                <td class="form_field">
                                                    <asp:TextBox CssClass="form_field_date" Text='<%# Eval("crLTActionDate","{0:MM/dd/yyyy}") %>'
                                                        Width="9em" ID="crLTActionDate" runat="server"></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Letter Id:"></asp:Label>
                                                </td>
                                                <td class="form_field">
                                                    <asp:Label CssClass="form_field" ID="lblcrLTID" runat="server" Text='<%# Eval("crLTID") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="To"
                                        ID="pnlComplianceLetterTo">
                                        <table width="100%">
                                            <tr>
                                                <td valign="top">
                                                    <table width="100%">
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                Owner name:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox runat="server" ID="crLTRecipient" CssClass="form_field_address" Text='<%# Eval("crLTRecipient") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                Address:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddr" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTMailAddr") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddr2" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTMailAddr2") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTCityStateZip" runat="server" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTCity+State+Zip") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top">
                                                    <table>
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                cc:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTCCopy1" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy1") %>'></asp:TextBox>
                                                            </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy2" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy2") %>'></asp:TextBox>
                                                </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy3" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy3") %>'></asp:TextBox>
                                                </td>
                                                </td>
                                            </tr>
                                        </table>
                                        </td> </tr> </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="From"
                                        ID="pnlFromCompliance">
                                        <table cellpadding="4" cellspacing="4">
                                            <tr>
                                                <td class="form_field_heading" align="right">
                                                    Signature:
                                                </td>
                                                <td class="form_field">
                                                    <asp:DropDownList ID="ddlCRFromSignature" runat="server">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                        <asp:ListItem Value="Hugh Palcic" Text="Hugh Palcic"></asp:ListItem>
                                                        <asp:ListItem Value="Bill Peck" Text="Bill Peck"></asp:ListItem>
                                                        <asp:ListItem Value="Shane Hostbjor" Text="Shane Hostbjor"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Title:
                                                    <asp:DropDownList ID="ddlCRFromTitle" runat="server">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                        <asp:ListItem Value="Director of Community Development" Text="Director of Community Development"></asp:ListItem>
                                                        <asp:ListItem Value="Compliance Inspector" Text="Compliance Inspector"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="Letter Attachment"
                                        ID="Panel3">
                                        <table>
                                            <tr>
                                                <td class="form_field_heading" align="right">
                                                    Type:
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="crLTAttachType" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTAttachType") %>'></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Description:
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTAttachDescription" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTAttachDescription") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </ItemTemplate>
                        </asp:FormView>
                        <center>
                            <asp:LinkButton ID="lbComplianceReviewNewLetter" runat="server" CausesValidation="False"
                                CommandName="New" Text="New Letter" /></center>
                        <asp:Panel runat="server" CssClass="newitempopup" ID="pnlComplianceReviewNewLetter">
                            <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlComplianceReviewNewLetterTitle">
                                <span>New Letter</span>
                            </asp:Panel>
                            <asp:Panel runat="server" Style="text-align: center;" ID="Panel6" CssClass="newitemcontent">
                                <asp:Panel CssClass="form_field_panel_squished" ID="Panel4" GroupingText="Dates"
                                    runat="server">
                                    <table width="100%" cellpadding="4" cellspacing="4" border="0">
                                        <tr valign="middle">
                                            <td class="form_field_heading" align="right">
                                                <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Letter date:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbNewComplianceReviewLetterLetterDate"
                                                    runat="server" Text='<%# Eval("crLTDate","{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading" align="right">
                                                <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Action deadline:"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field_date" Text='<%# Eval("crLTActionDate","{0:MM/dd/yyyy}") %>'
                                                    Width="9em" ID="TextBox7" runat="server"></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading" align="right">
                                                &nbsp;
                                            </td>
                                            <td class="form_field">
                                                <asp:Label CssClass="form_field" ID="Label19" runat="server" Text='<%# Eval("crLTID") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="To"
                                    ID="Panel7">
                                    <table width="100%">
                                        <tr>
                                            <td valign="top">
                                                <table width="100%">
                                                    <tr>
                                                        <td class="form_field_heading" align="right">
                                                            Owner name:
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox runat="server" ID="TextBox8" CssClass="form_field_address" Text='<%# Eval("crLTRecipient") %>'></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="form_field_heading" align="right">
                                                            Address:
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox ID="TextBox9" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTMailAddr") %>'></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox ID="TextBox10" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTMailAddr2") %>'></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox ID="TextBox11" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCity+State+Zip") %>'></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top">
                                                <table>
                                                    <tr>
                                                        <td class="form_field_heading" align="right">
                                                            cc:
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox ID="TextBox12" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy1") %>'></asp:TextBox>
                                                        </td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="form_field_address">
                                                <asp:TextBox ID="TextBox13" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy2") %>'></asp:TextBox>
                                            </td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="form_field_address">
                                                <asp:TextBox ID="TextBox14" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy3") %>'></asp:TextBox>
                                            </td>
                                            </td>
                                        </tr>
                                    </table>
                                    </td> </tr> </table>
                                </asp:Panel>
                                <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="From"
                                    ID="Panel8">
                                    <table cellpadding="4" cellspacing="4">
                                        <tr>
                                            <td class="form_field_heading" align="right">
                                                Signature:
                                            </td>
                                            <td class="form_field">
                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="Hugh Palcic" Text="Hugh Palcic"></asp:ListItem>
                                                    <asp:ListItem Value="Bill Peck" Text="Bill Peck"></asp:ListItem>
                                                    <asp:ListItem Value="Shane Hostbjor" Text="Shane Hostbjor"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td class="form_field_heading" align="right">
                                                Title:
                                                <asp:DropDownList ID="DropDownList2" runat="server">
                                                    <asp:ListItem Value="" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="Director of Community Development" Text="Director of Community Development"></asp:ListItem>
                                                    <asp:ListItem Value="Compliance Inspector" Text="Compliance Inspector"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="Letter Attachment"
                                    ID="Panel9">
                                    <table>
                                        <tr>
                                            <td class="form_field_heading" align="right">
                                                Type:
                                            </td>
                                            <td class="form_field_address">
                                                <asp:TextBox ID="TextBox15" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTAttachType") %>'></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading" align="right">
                                                Description:
                                            </td>
                                            <td class="form_field_address">
                                                <asp:TextBox ID="TextBox16" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTAttachDescription") %>'></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </asp:Panel>
                            <center>
                                <table cellpadding="3">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnNewComplianceReviewLetterOk" runat="server" Text="Okay" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnNewComplianceReviewLetterCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                                runat="server" Text="Cancel" />
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </asp:Panel>
                        <ajaxToolkit:ModalPopupExtender ID="mpeComplianceReviewNewLetter" runat="server"
                            TargetControlID="lbComplianceReviewNewLetter" PopupControlID="pnlComplianceReviewNewLetter"
                            BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlComplianceReviewNewLetterTitle"
                            BehaviorID="jdpopupcompliancereviewnewletter" />
                        <script language="javascript" type="text/javascript">
                            function shown() {
                                var tb = document.getElementById('<% =tbNewComplianceReviewLetterLetterDate.ClientID %>');
                                tb.focus();

                            }
                            function pageLoad() {
                                var dddp = $find('jdpopupcompliancereviewnewletter');
                                dddp.add_shown(shown);
                            }

                            function OnKeyPress(args) {
                                if (args.keyCode == Sys.UI.Key.esc) {
                                    // I don't know about this                $find("jdpopup").hide();
                                }
                            }
                        </script>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelComplanceLetterDataScrolling" HeaderText="Compliance Letter (Scrolling)">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel1" runat="server">
                    <ContentTemplate>
                        <div style="overflow: scroll; height: 350px;">
                            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                                <ItemTemplate>
                                    <asp:Panel CssClass="form_field_panel_squished" ID="Panel1" GroupingText="Dates"
                                        runat="server">
                                        <table width="100%" cellpadding="4" cellspacing="4" border="0">
                                            <tr valign="middle">
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Letter date:"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="crLtDate" runat="server"
                                                        Text='<%# Eval("crLTDate","{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Action deadline:"></asp:Label>
                                                </td>
                                                <td class="form_field">
                                                    <asp:TextBox CssClass="form_field_date" Text='<%# Eval("crLTActionDate","{0:MM/dd/yyyy}") %>'
                                                        Width="9em" ID="crLTActionDate" runat="server"></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Letter Id:"></asp:Label>
                                                </td>
                                                <td class="form_field">
                                                    <asp:Label CssClass="form_field" ID="lblcrLTID" runat="server" Text='<%# Eval("crLTID") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="To"
                                        ID="pnlComplianceLetterTo">
                                        <table width="100%">
                                            <tr>
                                                <td valign="top">
                                                    <table width="100%">
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                Owner name:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox runat="server" ID="crLTRecipient" CssClass="form_field_address" Text='<%# Eval("crLTRecipient") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                Address:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddr" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTMailAddr") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddr2" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTMailAddr2") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTCityStateZip" runat="server" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTCity+State+Zip") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top">
                                                    <table>
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                cc:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTCCopy1" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy1") %>'></asp:TextBox>
                                                            </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy2" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy2") %>'></asp:TextBox>
                                                </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy3" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy3") %>'></asp:TextBox>
                                                </td>
                                                </td>
                                            </tr>
                                        </table>
                                        </td> </tr> </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="From"
                                        ID="pnlFromCompliance">
                                        <table cellpadding="4" cellspacing="4">
                                            <tr>
                                                <td class="form_field_heading" align="right">
                                                    Signature:
                                                </td>
                                                <td class="form_field">
                                                    <asp:DropDownList ID="ddlCRFromSignature" runat="server">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                        <asp:ListItem Value="Hugh Palcic" Text="Hugh Palcic"></asp:ListItem>
                                                        <asp:ListItem Value="Bill Peck" Text="Bill Peck"></asp:ListItem>
                                                        <asp:ListItem Value="Shane Hostbjor" Text="Shane Hostbjor"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Title:
                                                    <asp:DropDownList ID="ddlCRFromTitle" runat="server">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                        <asp:ListItem Value="Director of Community Development" Text="Director of Community Development"></asp:ListItem>
                                                        <asp:ListItem Value="Compliance Inspector" Text="Compliance Inspector"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" GroupingText="Letter Attachment"
                                        ID="Panel3">
                                        <table>
                                            <tr>
                                                <td class="form_field_heading" align="right">
                                                    Type:
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="crLTAttachType" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTAttachType") %>'></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Description:
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTAttachDescription" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTAttachDescription") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <center>
                            <asp:LinkButton Style="padding: 20px;" ID="NewButton" runat="server" CausesValidation="False"
                                CommandName="New" Text="New Letter" /></center>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true" ID="btnComplianceUpdate" OnClick="btnComplianceReviewUpdate_Click" runat="server"
            Text="Submit" />
        <asp:Label ID="lblComplianceReviewUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <script language="javascript" type="text/javascript">
        function onNewComplianceReviewCancel() {
            if (confirm("Are you sure that you wish to cancel?")) {
                return true;
            } else {
                return false;
            }
        }
    </script>
    <asp:Panel runat="server" Width="900px" CssClass="newitempopup" ID="pnlNewComplianceReviewId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewComplianceReviewTitleId">
            <span>New Compliance Review</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" GroupingText="Location" ID="Panel10"
            CssClass="newitemcontent">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label26" runat="server" Text="Lot"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="TextBox1" Width="29" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Lane"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlNewComplianceReviewLane" runat="server"
                            DataTextField="Lane" DataValueField="Lane">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" GroupingText="Main Information"
            ID="pnlNewComplianceReviewContent" CssClass="newitemcontent">
            <table width="100%" cellpadding="4" cellspacing="4" border="0">
                <tr valign="middle">
                    <td align="right">
                        <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Review date:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbNewComplianceReviewReviewDate"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="right">
                        <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Close date:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field_date" Width="9em" ID="TextBox2" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Comments:"></asp:Label>
                    </td>
                    <td width="100%">
                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="TextBox3" runat="server"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel CssClass="form_field_panel" ID="Panel5" GroupingText="Other comments"
            runat="server">
            <table width="100%" cellpadding="4" cellspacing="4" border="0">
                <tr valign="middle">
                    <td align="right">
                        <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Design rule:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" Width="15em" ID="TextBox4" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Req'd Action:"></asp:Label>
                    </td>
                    <td width="60%">
                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="TextBox5" runat="server"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Follow up:"></asp:Label>
                    </td>
                    <td width="40%">
                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="TextBox6" runat="server"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <center>
                <table cellpadding="2" cellspacing="2">
                    <tr>
                        <td>
                            <asp:Button ID="btnNewComplianceReviewOk" CausesValidation="true" runat="server" Text="Okay" OnClick="btnNewComplianceReviewOk_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnNewComplianceReviewCancel" OnClientClick="return onNewComplianceReviewCancel()"
                                runat="server" Text="Cancel" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblComplianceReviewNewResults" Font-Bold="true" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
            </center>
        </asp:Panel>
    </asp:Panel>
    <asp:LinkButton ID="lbNewComplianceReview" runat="server">New Compliance Review</asp:LinkButton>
    <ajaxToolkit:ModalPopupExtender ID="mpeNewComplianceReview" runat="server" TargetControlID="lbNewComplianceReview"
        PopupControlID="pnlNewComplianceReviewId" BackgroundCssClass="modalBackground"
        PopupDragHandleControlID="pnlNewComplianceReviewTitleId" BehaviorID="jdpopupnewcompliancereview" />
    <script language="javascript" type="text/javascript">
        function shown() {
            var tb = document.getElementById('<% =tbNewComplianceReviewReviewDate.ClientID %>');
            tb.focus();

        }
        function pageLoad() {
            var dddp = $find('jdpopupnewcompliancereview');
            dddp.add_shown(shown);
        }

        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
                // I don't know about this                $find("jdpopup").hide();
            }
        }
    </script>
</asp:Content>
