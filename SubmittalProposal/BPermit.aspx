<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="BPermit.aspx.cs" Inherits="SubmittalProposal.BPermit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="Owner"></asp:Label>
        <asp:TextBox ID="tbOwner" Width="90" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label19" runat="server" Text="Applicant"></asp:Label>
        <asp:TextBox ID="tbApplicant" Width="90" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLot" Width="20" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" runat="server" DataTextField="Lane" DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label22" runat="server" Text="Submittal Id"></asp:Label>
        <asp:TextBox ID="tbSubmittalId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label23" runat="server" Text="BPermit Id"></asp:Label>
        <asp:TextBox ID="tbBPermitId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label6" runat="server" Text="Delay"></asp:Label>
        <asp:TextBox ID="tbDelaySearch" Width="20" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" AllowPaging="true" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
        CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting"
        OnPageIndexChanging="gvResults_PageIndexChanging" PageSize="15">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" Position="Bottom"
            PageButtonCount="15" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="Lot" HeaderText="Lot" SortExpression="Lot" />
            <asp:BoundField DataField="Lane" HeaderText="Lane" SortExpression="Lane" />
            <asp:BoundField DataField="SubmittalId" HeaderText="Submittal Id" SortExpression="SubmittalId" />
            <asp:BoundField DataField="BPermitId" HeaderText="BPermitId" SortExpression="BPermitId" />
            <asp:BoundField DataField="BPIssueDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Issue Date"
                SortExpression="BPIssueDate" />
            <asp:TemplateField HeaderText="Expires" SortExpression="BPExpires">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("BPExpires","{0:MM/dd/yyyy}") %>'
                        ForeColor='<%# getForeColorForExpireDate(Eval("BPExpires")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="BPClosed" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Closed"
                SortExpression="BPClosed" />
            <asp:BoundField DataField="BPDelay" HeaderText="Delay" SortExpression="BPDelay" />
            <asp:BoundField DataField="OwnersName" HeaderText="Owner's Name" SortExpression="OwnersName" />
            <asp:BoundField DataField="Applicant" HeaderText="Applicant" SortExpression="Applicant" />
            <asp:BoundField DataField="Contractor" HeaderText="Contractor" SortExpression="Contractor" />
            <asp:BoundField DataField="BPermitReqd" HeaderText="Permit Reqd" SortExpression="BPermitReqd" />
            <asp:BoundField DataField="ProjectType" HeaderText="Project Type" SortExpression="ProjectType" />
            <asp:BoundField DataField="Project" HeaderText="Project" SortExpression="Project" />
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
    <asp:Panel ID="Panel1" GroupingText="Building Permit Data" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Delay"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbDelay" Width="3em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Issued"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbIssued" Width="10em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Expired"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_lbl" ID="lblExpired" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Closed"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbClosed" Width="10em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Permit Required"></asp:Label>
                </td>
                <td>
                    <asp:RadioButtonList ID="rbListPermitRequired" RepeatDirection="Horizontal" runat="server">
                        <asp:ListItem>Yes</asp:ListItem>
                        <asp:ListItem>No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" GroupingText="Data from Submittal Form" runat="server">
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Lot"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbLotName2" Width="22" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList CssClass="form_field" ID="ddlLane2" runat="server" DataTextField="Lane"
                        DataValueField="Lane">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Owner"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbOwnersName" Width="20em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Applicant"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbApplicantName2" Width="20em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Contractor"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox CssClass="form_field" ID="tbContractorBB" Width="20em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Project"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbProject" runat="server" Width="20em" TextMode="MultiLine"
                        Rows="4"></asp:TextBox>
                </td>
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
                        OnRowEditing="gvPayments_RowEditing" OnRowUpdating="gvPayments_RowUpdating">
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
                            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowCancelButton="true" />
                            <asp:BoundField DataField="BPPmt" HeaderText="Nbr" />
                            <asp:TemplateField HeaderText="Fee">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("BPFee$","{0:c}") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("BPFee$","{0:c}") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# getBPFeeTotal() %>'></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Months">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("BPMonths") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("BPMonths") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# getBPMonthsTotal() %>'></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="BPPayType" HeaderText="Pay Type" />
                        </Columns>
                    </asp:GridView>
                    <center style="margin-top: 5px;">
                        <asp:LinkButton ID="lbBPermitNewPayment" runat="server">New Payment</asp:LinkButton></center>
                    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlBPermitNewPayment">
                        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlBPermitNewPaymentTitle">
                            <span>New Payment</span>
                        </asp:Panel>
                        <asp:Panel runat="server" Style="text-align: center;" ID="Panel6" CssClass="newitemcontent">
                            <table>
                                <tr>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label34" runat="server" Text="Payment Number"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="tbBPermitNewPaymentNumber" Width="3em" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Fee"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="TextBox3" Width="8em" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label33" runat="server" Text="Months"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="TextBox12" Width="4em" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table width="100%">
                            <tr>
                                <td>
                                    <asp:Button ID="btnNewBPermitPaymentOk" runat="server" Text="Okay" OnClick="btnNewBPermitPaymentOk_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnNewBPermitPaymentCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                        runat="server" Text="Cancel" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <ajaxToolkit:ModalPopupExtender ID="mpeBPermitNewPayment" runat="server" TargetControlID="lbBPermitNewPayment"
                        PopupControlID="pnlBPermitNewPayment" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlBPermitNewPaymentTitle"
                        BehaviorID="jdpopupbpermitnewpayment" />
                    <script language="javascript" type="text/javascript">
                        function shownnp() {
                            var tb = document.getElementById('<% =tbBPermitNewPaymentNumber.ClientID %>');
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
                        CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCancelingEdit="gvReviews_RowCancelingEdit"
                        OnRowEditing="gvReviews_RowEditing" OnRowUpdating="gvReviews_RowUpdating">
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
                            <asp:CommandField ButtonType="Link" ShowEditButton="true" />
                            <asp:BoundField DataField="BPRevw" HeaderText="Nbr" />
                            <asp:BoundField DataField="BPReviewDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="1st Inspect" />
                            <asp:BoundField DataField="BPRActionDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Action " />
                            <asp:BoundField DataField="BPRLetterDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Letter" />
                            <asp:BoundField DataField="BPRLetterRef" HeaderText="Letter Ref" />
                            <asp:BoundField DataField="BPRComments" HeaderText="Comments" />
                        </Columns>
                    </asp:GridView>
                    <center style="margin-top: 5px;">
                        <asp:LinkButton ID="lbBPermitNewReview" runat="server">New Review</asp:LinkButton>
                    </center>
                    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlBPermitNewReview">
                        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlBPermitNewReviewTitle">
                            <span>New Review</span>
                        </asp:Panel>
                        <asp:Panel runat="server" Style="text-align: center;" ID="Panel8" CssClass="newitemcontent">
                            <table>
                                <tr>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label35" runat="server" Text="Review Number"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="tbBPermitNewReviewNumber" Width="3em" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label36" runat="server" Text="Inspection Date"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="TextBox14" Width="8em" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label38" runat="server" Text="Action Date"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="TextBox13" Width="8em" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label39" runat="server" Text="Letter Date"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="TextBox16" Width="8em" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label37" runat="server" Text="Letter Reference"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="TextBox15" Width="8em" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label40" runat="server" Text="Comments"></asp:Label>
                                    </td>
                                    <td align="left" class="form_field" colspan="9">
                                        <asp:TextBox CssClass="form_field" ID="TextBox17" Width="99%" runat="server" TextMode="MultiLine"
                                            Rows="3"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <center>
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td>
                                        <asp:Button ID="Button1" runat="server" Text="Okay" OnClick="btnNewBPermitReviewOk_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="Button2" OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                            runat="server" Text="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </asp:Panel>
                    <ajaxToolkit:ModalPopupExtender ID="mpeBPermitNewReview" runat="server" TargetControlID="lbBPermitNewReview"
                        PopupControlID="pnlBPermitNewReview" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlBPermitNewReviewTitle"
                        BehaviorID="jdpopupbpermitnewreview" />
                    <script language="javascript" type="text/javascript">
                        function shownnr() {
                            var tb = document.getElementById('<% =tbBPermitNewReviewNumber.ClientID %>');
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
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true" ID="btnBPermitUpdate" OnClick="btnBPermitUpdate_Click" runat="server"
            Text="Submit" />
        <asp:Label ID="lblBPermitUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <script language="javascript" type="text/javascript">
        function onNewBPermitCancel() {
            if (confirm("Are you sure that you wish to cancel?")) {
                return true;
            } else {
                return false;
            }
        }
    </script>
    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewBPermitId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewBPermitTitleId">
            <span>New Building Permit</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewBPermitContent" CssClass="newitemcontent">
            <asp:Panel ID="Panel3" GroupingText="Building Permit Data" runat="server">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Delay"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="tbNewBPermitDelay" Width="3em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Issued"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="TextBox4" Width="10em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="SubmittalID"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="TextBox11" Width="10em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label24" runat="server" Text="Closed"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="TextBox5" Width="10em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label25" runat="server" Text="Permit Required"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RadioButtonList1" RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="Panel4" GroupingText="Data from Submittal Form" runat="server">
                <table border="0" cellpadding="2" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label26" runat="server" Text="Lot"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="TextBox6" Width="22" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Lane"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="form_field" ID="ddlNewBPermitLane" runat="server" DataTextField="Lane"
                                DataValueField="Lane">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label28" runat="server" Text="Owner"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="TextBox7" Width="20em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label29" runat="server" Text="Applicant"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="TextBox8" Width="20em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label CssClass="form_field_heading" ID="Label30" runat="server" Text="Contractor"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox CssClass="form_field" ID="TextBox9" Width="20em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Project"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="TextBox10" runat="server" Width="20em" TextMode="MultiLine"
                                Rows="4"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label32" runat="server" Text="Project Type"></asp:Label>
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
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table width="100%">
                <tr>
                    <td>
                        <asp:Button ID="btnNewBPermitOk" runat="server" Text="Okay" OnClick="btnNewBPermitOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewBPermitCancel" OnClientClick="return onNewBPermitCancel()"
                            runat="server" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>
    <asp:LinkButton ID="lbBPermintNew" runat="server">New Building Permit</asp:LinkButton>
    <ajaxToolkit:ModalPopupExtender ID="mpeNewBPermit" runat="server" TargetControlID="lbBPermintNew"
        PopupControlID="pnlNewBPermitId" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewBPermitTitleId"
        BehaviorID="jdpopupbpermit" />
    <script language="javascript" type="text/javascript">
        function shown() {
            var tb = document.getElementById('<% =tbNewBPermitDelay.ClientID %>');
            tb.focus();

        }
        function pageLoad() {
            var dddp = $find('jdpopupbpermit');
            dddp.add_shown(shown);

        }

        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
                // I don't know about this                $find("jdpopup").hide();
            }
        }
    </script>
</asp:Content>
