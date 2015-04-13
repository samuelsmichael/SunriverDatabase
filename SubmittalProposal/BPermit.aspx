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
        <asp:TextBox ID="tbLot" Width="40" MaxLength="5" runat="server"></asp:TextBox>
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
                    <asp:TextBox CssClass="form_field" MaxLength="255" ID="tbDelayUpdate" Width="3em"
                        runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Issued"></asp:Label>
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
                        ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                        ControlToValidate="tbIssuedUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Expired"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_lbl" ID="lblExpired" Width="9em" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Closed"></asp:Label>
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
                        ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                        ControlToValidate="tbClosedUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Permit Required"></asp:Label>
                </td>
                <td>
                    <asp:RadioButtonList ID="rbListPermitRequiredUpdate" RepeatDirection="Horizontal"
                        runat="server">
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
                    <asp:TextBox CssClass="form_field" ID="tbLotNameUpdate" MaxLength="5" Width="35"
                        runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList CssClass="form_field" ID="ddlLaneUpdate" runat="server" DataTextField="Lane"
                        DataValueField="Lane">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Owner"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbOwnersNameUpdate" MaxLength="40" Width="20em"
                        runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Applicant"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" MaxLength="25" ID="tbApplicantNameUpdate" Width="20em"
                        runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Contractor"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox CssClass="form_field" MaxLength="30" ID="tbContractorUpdate" Width="20em"
                        runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Project"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" MaxLength="100" ID="tbProjectUpdate" runat="server"
                        Width="20em" TextMode="MultiLine" Rows="4"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Project Type"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList CssClass="form_field" ID="ddlProjectTypeUpdate" runat="server">
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
                        OnRowEditing="gvPayments_RowEditing" 
                        OnRowUpdating="gvPayments_RowUpdating" DataKeyNames="BPPaymentId">
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
                            <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true" ShowCancelButton="true" />
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
                                    <asp:TextBox ID="tbBPPaymentFeeUpdate" runat="server" 
                                        Text='<%# Eval("BPFee$","{0:0.00}") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revtbBPPaymentFeeUpdate" ForeColor="Red" Display="Dynamic" ControlToValidate="tbBPPaymentFeeUpdate"
                                             ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$" runat="server" ErrorMessage="Must be an amount"></asp:RegularExpressionValidator>

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
                                    <asp:TextBox ID="tbBPPaymentMonthsUpdate" runat="server" 
                                        Text='<%# Bind("BPMonths") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revtbBPPaymentMonthsUpdate" ForeColor="Red" Display="Dynamic" ControlToValidate="tbBPPaymentMonthsUpdate" ValidationExpression="^[0-9]+$" runat="server" ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>
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
                        <asp:LinkButton ID="lbBPermitNewPayment" runat="server">New Payment</asp:LinkButton></center>
                    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlBPermitNewPayment">
                        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlBPermitNewPaymentTitle">
                            <span>New Payment</span>
                        </asp:Panel>
                        <asp:Panel runat="server" Style="text-align: center;" ID="Panel6" CssClass="newitemcontent">
                            <table>
                                <tr>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Fee"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="tbBPPaymentFeeNew" Width="8em" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revtbBPPaymentFeeNew" ForeColor="Red" Display="Dynamic" ControlToValidate="tbBPPaymentFeeNew"
                                             ValidationExpression="^(\$|)([1-9]\d{0,2}(\,\d{3})*|([1-9]\d*))(\.\d{2})?$" runat="server" ErrorMessage="Must be an amount"></asp:RegularExpressionValidator>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label33" runat="server" Text="Months"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="tbBPPaymentMonthsNew" Width="4em" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revBPPaymentMonthsNew" ForeColor="Red" Display="Dynamic" ControlToValidate="tbBPPaymentMonthsNew" ValidationExpression="^[0-9]+$" runat="server" ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <script  language="javascript" type="text/javascript" >
                            function donewpaymentjedisok() {
                                var loading = $(".loadingnewbpermit");
                                loading.show();
                                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                                loading.css({ top: top, left: left });
                                return true;
                            }
                        </script>

                        <center>
                            <table cellpadding="3">
                                <tr>
                                    <td>
                                        <asp:Button  OnClientClick="javascript: return donewpaymentjedisok();" ID="btnNewBPermitPaymentOk" runat="server" Text="Okay" OnClick="btnNewBPermitPaymentOk_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnNewBPermitPaymentCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                            runat="server" Text="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </asp:Panel>
                    <ajaxToolkit:ModalPopupExtender ID="mpeBPermitNewPayment" runat="server" TargetControlID="lbBPermitNewPayment"
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
                        OnRowEditing="gvReviews_RowEditing" OnRowUpdating="gvReviews_RowUpdating" 
                        DataKeyNames="BPReviewID">
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
                                    <table><tr><td>
                                    <asp:TextBox CssClass="form_field_date" ID="tbBPermitReviewDateUpdate" runat="server" width="60"
                                            Text='<%# Bind("BPReviewDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                    </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                                ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibBPermitReviewDateUpdate" 
                                                runat="server" /></td></tr></table>
                                    <ajaxToolkit:CalendarExtender ID="ceBPermitReviewDateUpdate" runat="server"
                                        TargetControlID="tbBPermitReviewDateUpdate"
                                        Format="MM/dd/yyyy"
                                        PopupButtonID="ibBPermitReviewDateUpdate" />
                                    <asp:RegularExpressionValidator ForeColor="Red" 
                                        ID="revBPermitReviewDateUpdate"  Display="Dynamic" 
                                        ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                        ControlToValidate="tbBPermitReviewDateUpdate" runat="server" 
                                        ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" 
                                        Text='<%# Bind("BPReviewDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action ">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" 
                                        Text='<%# Bind("BPRActionDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <table><tr><td>
                                    <asp:TextBox CssClass="form_field_date" ID="tbBPermitActionDateUpdate" runat="server" width="60"
                                            Text='<%# Bind("BPRActionDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                    </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                                ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibBPermitActionDateUpdate" 
                                                runat="server" /></td></tr></table>
                                    <ajaxToolkit:CalendarExtender ID="ceBPermitActionDateUpdate" runat="server"
                                        TargetControlID="tbBPermitActionDateUpdate"
                                        Format="MM/dd/yyyy"
                                        PopupButtonID="ibBPermitActionDateUpdate" />
                                    <asp:RegularExpressionValidator ForeColor="Red" 
                                        ID="revBPermitActionDateUpdate"  Display="Dynamic" 
                                        ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                        ControlToValidate="tbBPermitActionDateUpdate" runat="server" 
                                        ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Letter">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" 
                                        Text='<%# Bind("BPRLetterDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <table><tr><td>
                                                <asp:TextBox CssClass="form_field_date" ID="tbBPermitLetterDateUpdate" runat="server" width="60"
                                                    Text='<%# Bind("BPRLetterDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                                    ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibBPermitLetterDateUpdate" 
                                                    runat="server" /></td></tr></table>
                                                <ajaxToolkit:CalendarExtender ID="ceBPermitLetterDateUpdate" runat="server"
                                                    TargetControlID="tbBPermitLetterDateUpdate"
                                                    Format="MM/dd/yyyy"
                                                    PopupButtonID="ibBPermitLetterDateUpdate" />
                                                <asp:RegularExpressionValidator ForeColor="Red" 
                                                    ID="revBPermitLetterDateUpdate"  Display="Dynamic" 
                                                    ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                                    ControlToValidate="tbBPermitLetterDateUpdate" runat="server" 
                                                    ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Letter Ref">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" 
                                        Text='<%# Bind("BPRLetterRef", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox CssClass="form_field" ID="tbBPRLetterRefUpdate" runat="server" width="105"
                                        Text='<%# Bind("BPRLetterRef") %>' MaxLength="25"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Comments">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("BPRComments") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox CssClass="form_field_wide" ID="tbBPRCommentsUpdate" runat="server" Width="123" Rows="3" TextMode="MultiLine" 
                                        Text='<%# Bind("BPRComments") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
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
                                        <asp:Label CssClass="form_field_heading" ID="Label36" runat="server" Text="Inspection Date"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <table><tr><td>
                                        <asp:TextBox CssClass="form_field" ID="tbBPermitReviewDateNew" Width="8em" runat="server"></asp:TextBox>
                                        </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibBPermitReviewDateNew" runat="server" /></td></tr></table>
                                        <ajaxToolkit:CalendarExtender ID="ceBPermitReviewDateNew" runat="server"
                                            TargetControlID="tbBPermitReviewDateNew"
                                            Format="MM/dd/yyyy"
                                            PopupButtonID="ibBPermitReviewDateNew" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitReviewDateNew"  Display="Dynamic" 
                                            ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                            ControlToValidate="tbBPermitReviewDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label38" runat="server" Text="Action Date"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <table><tr><td>
                                        <asp:TextBox CssClass="form_field" ID="tbBPermitActionDateNew" Width="8em" runat="server"></asp:TextBox>
                                        </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibBPermitActionDateNew" runat="server" /></td></tr></table>
                                        <ajaxToolkit:CalendarExtender ID="ceBPermitActionDateNew" runat="server"
                                            TargetControlID="tbBPermitActionDateNew"
                                            Format="MM/dd/yyyy"
                                            PopupButtonID="ibBPermitActionDateNew" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitActionDateNew"  Display="Dynamic" 
                                            ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                            ControlToValidate="tbBPermitActionDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label39" runat="server" Text="Letter Date"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <table><tr><td>
                                        <asp:TextBox CssClass="form_field" ID="tbBPermitLetterDateNew" Width="8em" runat="server"></asp:TextBox>
                                        </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibBPermitLetterDateNew" runat="server" /></td></tr></table>
                                        <ajaxToolkit:CalendarExtender ID="ceBPermitLetterDateNew" runat="server"
                                            TargetControlID="tbBPermitLetterDateNew"
                                            Format="MM/dd/yyyy"
                                            PopupButtonID="ibBPermitLetterDateNew" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revBPermitLetterDateNew"  Display="Dynamic" 
                                            ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                            ControlToValidate="tbBPermitLetterDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label37" runat="server" Text="Letter Reference"></asp:Label>
                                    </td>
                                    <td class="form_field">
                                        <asp:TextBox CssClass="form_field" ID="tbBPRLetterRefNew" MaxLength="25" Width="8em" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_field_heading">
                                        <asp:Label CssClass="form_field_heading" ID="Label40" runat="server" Text="Comments"></asp:Label>
                                    </td>
                                    <td align="left" class="form_field" colspan="9">
                                        <asp:TextBox CssClass="form_field" ID="tbBPRCommentsNew" Width="99%" runat="server" TextMode="MultiLine"
                                            Rows="3"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <script  language="javascript" type="text/javascript" >
                            function doOkNewReview() {
                            
                                var loading = $(".loadingdb");
                                loading.show();
                                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                                loading.css({ top: top, left: left });
                                return true;
                            }

                        </script>
                        <center>
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnNewBPermitReviewOk" OnClientClick="javascript: return doOkNewReview();}" CausesValidation="true" runat="server" Text="Okay" OnClick="btnNewBPermitReviewOk_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnNewBPermitReviewCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                            runat="server" Text="Cancel" />
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
                    <ajaxToolkit:ModalPopupExtender ID="mpeBPermitNewReview" runat="server" TargetControlID="lbBPermitNewReview"
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
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnBPermitUpdate" OnClick="btnBPermitUpdate_Click" OnClientClick="javascript: return true;" runat="server" Text="Submit" />
        <asp:Label ID="lblBPermitUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <script language="javascript" type="text/javascript">

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
                            <asp:TextBox CssClass="form_field" ID="tbDelayNew" Width="3em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Issued"></asp:Label>
                        </td>
                        <td>
                            <table><tr><td>
                            <asp:TextBox CssClass="form_field_date" ID="tbIssuedNew" runat="server"></asp:TextBox>
                            </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibIssuedNew" runat="server" /></td></tr></table>
                            <ajaxToolkit:CalendarExtender ID="ceIssuedNew" runat="server"
                                TargetControlID="tbIssuedNew"
                                Format="MM/dd/yyyy"
                                PopupButtonID="ibIssuedNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="revIssuedNew"  Display="Dynamic" 
                                ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                ControlToValidate="tbIssuedNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="SubmittalID"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="tbSubmittalIdNew" Width="10em" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSubmittalIdNew" ForeColor="Red" Display="Dynamic" ControlToValidate="tbSubmittalIdNew" runat="server" ErrorMessage="SubmittalId is Required"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label24" runat="server" Text="Closed"></asp:Label>
                        </td>
                        <td>
                            <table><tr><td>
                            <asp:TextBox CssClass="form_field" ID="tbClosedNew" Width="10em" runat="server"></asp:TextBox>
                            </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibClosedNew" runat="server" /></td></tr></table>
                            <ajaxToolkit:CalendarExtender ID="ceClosedNew" runat="server"
                                TargetControlID="tbClosedNew"
                                Format="MM/dd/yyyy"
                                PopupButtonID="ibClosedNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="revClosedNew"  Display="Dynamic" 
                                ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                                ControlToValidate="tbClosedNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label25" runat="server" Text="Permit Required"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rbListPermitRequiredNew" RepeatDirection="Horizontal" runat="server">
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
                            <asp:TextBox CssClass="form_field" ID="tbLotNameNew" Width="22" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Lane"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="form_field" ID="ddlLaneNew" runat="server" DataTextField="Lane"
                                DataValueField="Lane">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label28" runat="server" Text="Owner"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="tbOwnersNameNew" Width="20em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label29" runat="server" Text="Applicant"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="tbApplicantNameNew" Width="20em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label CssClass="form_field_heading" ID="Label30" runat="server" Text="Contractor"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox CssClass="form_field" ID="tbContractorNew" Width="20em" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Project"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="form_field" ID="tbProjectNew" runat="server" Width="20em"
                                TextMode="MultiLine" Rows="4"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label32" runat="server" Text="Project Type"></asp:Label>
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
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <center>

                        <script  language="javascript" type="text/javascript" >
                            function doOkNewBPermit() {
                                
                                var loading = $(".loadingnewbpermit");
                                loading.show();
                                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                                loading.css({ top: top, left: left });
                                return true;
                            }


                        </script>

                <table cellpadding="4">
                    <tr>
                        <td>
                            <asp:Button  OnClientClick="javascript: return doOkNewBPermit();"  ID="btnNewBPermitOk"  runat="server" Text="Okay" OnClick="btnNewBPermitOk_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnNewBPermitCancel" OnClick="btnNewBPermitCancel_Click" OnClientClick="javacript: return confirm('Are you sure that you wish to cancel?')"
                                runat="server" Text="Cancel" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblBPermitNewResults" Font-Bold="true" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                <div class="loadingnewbpermit" align="center">
                    Processing. Please wait.<br />
                    <br />
                    <img src="Images/animated_progress.gif" alt="" />
                </div>
            </center>
        </asp:Panel>
    </asp:Panel>
    <asp:LinkButton ID="lbBPermintNew" Visible="false" runat="server">New Building Permit</asp:LinkButton>
    <asp:Button runat="server" ID="dummyNewBPermit" style="display:none" />
    <asp:HiddenField ID="hfAutoShowPopupNew" Value="n" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewBPermit" runat="server" TargetControlID="dummyNewBPermit"
        PopupControlID="pnlNewBPermitId" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewBPermitTitleId"
        BehaviorID="jdpopupbpermit" />
    <script language="javascript" type="text/javascript">
        Sys.Application.add_load(pageLoadPopupNewBPermit);
        function shown() {
            var tb = document.getElementById('<% =tbDelayNew.ClientID %>');
            tb.focus();
        }
        function pageLoadPopupNewBPermit() {
            var dddp = $find('jdpopupbpermit');
            dddp.add_shown(shown);
            var showauto = document.getElementById('<%=hfAutoShowPopupNew.ClientID %>');
            //alert("showauto.value=" + showauto.value);
            if (showauto && showauto.value == "y") {
                showauto.value = "n"
                dddp.show();
            }
        }

        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
                // I don't know about this                $find("jdpopup").hide();
            }
        }
    </script>
</asp:Content>
