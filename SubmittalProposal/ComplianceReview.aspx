<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="ComplianceReview.aspx.cs" Inherits="SubmittalProposal.ComplianceReview" %>
<%@ Register src="PhotoManager.ascx" tagname="PhotoManager" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td width="40">
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLot" Width="40" MaxLength="5" runat="server"></asp:TextBox>
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
                        <asp:Panel ID="crPropertyUpdate" GroupingText="Property" runat="server" CssClass="form_field_panel_squished">
                            <table cellpadding="1" cellspacing="1" border="0">
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Lot"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbCRLotNameUpdate" MaxLength="5" Width="35"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList CssClass="form_field" ID="ddlCRLaneUpdate" runat="server" DataTextField="Lane"
                                            DataValueField="Lane">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="Panel1" GroupingText="Review" runat="server" CssClass="form_field_panel_squished">
                            <table width="100%" cellpadding="1" cellspacing="1" border="0">
                                <tr valign="middle">
                                    <td align="right">
                                        <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Review date:"></asp:Label>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbReviewDateUpdate" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibReviewDateUpdate" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="ceReviewDateUpdate" runat="server" TargetControlID="tbReviewDateUpdate"
                                            Format="MM/dd/yyyy" PopupButtonID="ibReviewDateUpdate" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revReviewDateUpdate" Display="Dynamic"
                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbReviewDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                    <td align="right">
                                        <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Close date:"></asp:Label>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbCloseDateUpdate" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibCloseDateUpdate" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbCloseDateUpdate"
                                            Format="MM/dd/yyyy" PopupButtonID="ibCloseDateUpdate" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator1"
                                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbCloseDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Comments:"></asp:Label>
                                    </td>
                                    <td width="100%">
                                        <asp:TextBox CssClass="form_field_mediumtextbox" Width="100%" ID="tbCommentsFormUpdate"
                                            runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="Panel2" GroupingText="Other comments" CssClass="form_field_panel_squished"
                            runat="server">
                            <table width="100%" cellpadding="1" cellspacing="1" border="0">
                                <tr valign="middle">
                                    <td align="right">
                                        <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Design rule:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" Width="15em" ID="tbDesignRuleUpdate" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Req'd Action:"></asp:Label>
                                    </td>
                                    <td width="60%">
                                        <asp:TextBox CssClass="form_field_mediumtextbox" Width="100%" ID="tbRequiredActionUpdate"
                                            runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Follow up:"></asp:Label>
                                    </td>
                                    <td width="40%">
                                        <asp:TextBox CssClass="form_field_mediumtextbox" Width="100%" ID="tbFollowUpUpdate"
                                            runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="Panel11" GroupingText="Compliance Letters" CssClass="form_field_panel_squished"
                            runat="server">


                            <div style="height: 8em; width: 900px; overflow: auto;">
                                <asp:GridView ID="gvComplianceLetters" Style="width: 100%; white-space: nowrap;" runat="server"
                                    AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None"
                                    OnRowEditing="gvComplianceLetters_RowEditing" OnRowUpdating="gvComplianceLetters_RowUpdating"
                                    OnRowCancelingEdit="gvComplianceLetters_RowCancelingEdit" ShowFooter="True" OnRowDataBound="gvComplianceLetters_RowDataBound">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <EmptyDataTemplate>
                                        <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true"
                                            ShowCancelButton="true" />
                                        <asp:TemplateField HeaderText="Letter Date" SortExpression="crLTDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLetterDateUpdate" runat="server" Text='<%# Bind("crLTDate", "{0:M-dd-yyyy}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="tbLetterDateEditUpdate" runat="server" Text='<%# Eval("crLTDate", "{0:M-dd-yyyy}") %>'></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                ID="ibLetterDateEditUpdate" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajaxToolkit:CalendarExtender ID="cvLetterDateEditUpdate" runat="server" TargetControlID="tbLetterDateEditUpdate"
                                                    Format="MM/dd/yyyy" PopupButtonID="ibLetterDateEditUpdate" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="rvcvLetterDateEditUpdate" Display="Dynamic"
                                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbLetterDateEditUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action Deadline" SortExpression="crLTActionDate">
                                            <ItemTemplate>
                                                <asp:Label ID="lblActionDeadlineItem" runat="server" Text='<%# Bind("crLTActionDate", "{0:M-dd-yyyy}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="tbActionDeadlineEdit" runat="server" Text='<%# Eval("crLTActionDate", "{0:M-dd-yyyy}") %>'></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                ID="ibActionDeadlineEdit" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajaxToolkit:CalendarExtender ID="cvActionDeadlineEdit" runat="server" TargetControlID="tbActionDeadlineEdit"
                                                    Format="MM/dd/yyyy" PopupButtonID="ibActionDeadlineEdit" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="rvcvActionDeadlineEdit" Display="Dynamic"
                                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbActionDeadlineEdit" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>



                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Letter Id" SortExpression="fkcrReviewID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblfkcrReviewIDItem" runat="server" Text='<%# Bind("crLTID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblfkcrReviewIDEdit" runat="server" Text='<%# Bind("crLTID") %>'></asp:Label>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
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
                            </div>


                            <br />
                            <center><asp:Button runat="server" ID="btnComplianceReviewNewLetter" CausesValidation="false" CommandName="New" Text="New Letter" /></center>
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
                                                    <asp:Label CssClass="form_field_heading" ID="Label1x36" runat="server" Text="Letter date:"></asp:Label>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbcrLtDateNew" runat="server"
                                                                    Text='<%# Eval("crLTDate","{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                    ID="ibcrLtDateNew" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <ajaxToolkit:CalendarExtender ID="cecrLtDateNew" runat="server" TargetControlID="tbcrLtDateNew"
                                                        Format="MM/dd/yyyy" PopupButtonID="ibcrLtDateNew" />
                                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revcrLtDateNew" Display="Dynamic"
                                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                        ControlToValidate="tbcrLtDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label1xx7" runat="server" Text="Action deadline:"></asp:Label><br />
                                                    <asp:Label ID="Labelxx416" runat="server" Text="(Note: leave blank to default to 30 days after Letter Date.<br> If you actually want this to be blank, key in 1/1/1900.)" style="font-size:smaller;"></asp:Label> 
                                                </td>
                                                <td class="form_field">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox CssClass="form_field_date" Text='<%# Eval("crLTActionDate","{0:MM/dd/yyyy}") %>'
                                                                    Width="9em" ID="crLTActionDateNew" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                    ID="ibcrLTActionDateNew" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <ajaxToolkit:CalendarExtender ID="cecrLTActionDateNew" runat="server" TargetControlID="crLTActionDateNew"
                                                        Format="MM/dd/yyyy" PopupButtonID="ibcrLTActionDateNew" />
                                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revcrLTActionDateNew" Display="Dynamic"
                                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                        ControlToValidate="crLTActionDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    &nbsp;
                                                </td>
                                                <td class="form_field">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel Visible="false" CssClass="form_field_panel_squished" runat="server" GroupingText="To"
                                        ID="Panelxx97">
                                        <table width="100%">
                                            <tr>
                                                <td valign="top">
                                                    <table width="100%">
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                Owner name:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox runat="server" ID="tbcrLTRecipientNew" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTRecipient") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                Address:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddrNew" runat="server" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTMailAddr") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddr2New" runat="server" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTMailAddr2") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTCityStateZipNew" runat="server" CssClass="form_field_address"
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
                                                                <asp:TextBox ID="tbcrLTCCopy1New" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy1") %>'></asp:TextBox>
                                                            </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy2New" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy2") %>'></asp:TextBox>
                                                </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy3New" runat="server" CssClass="form_field_address" Text='<%# Eval("crLTCCopy3") %>'></asp:TextBox>
                                                </td>
                                                </td>
                                            </tr>
                                        </table>
                                        </td> </tr> </table>
                                    </asp:Panel>
                                    <asp:Panel Visible="false" CssClass="form_field_panel_squished" runat="server" GroupingText="From"
                                        ID="Panelxx48">
                                        <table cellpadding="4" cellspacing="4">
                                            <tr>
                                                <td class="form_field_heading" align="right">
                                                    Signature:
                                                </td>
                                                <td class="form_field">
                                                    <asp:DropDownList ID="ddlCRFromSignatureNew" runat="server">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                        <asp:ListItem Value="Hugh Palcic" Text="Hugh Palcic"></asp:ListItem>
                                                        <asp:ListItem Value="Bill Peck" Text="Bill Peck"></asp:ListItem>
                                                        <asp:ListItem Value="Shane Hostbjor" Text="Shane Hostbjor"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Title:
                                                    <asp:DropDownList ID="ddlCRFromTitleNew" runat="server">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                        <asp:ListItem Value="Director of Community Development" Text="Director of Community Development"></asp:ListItem>
                                                        <asp:ListItem Value="Compliance Inspector" Text="Compliance Inspector"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel Visible="false" CssClass="form_field_panel_squished" runat="server" GroupingText="Letter Attachment"
                                        ID="Panesl9">
                                        <table>
                                            <tr>
                                                <td class="form_field_heading" align="right">
                                                    Type:
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="crLTAttachTypeNew" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTAttachType") %>'></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Description:
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTAttachDescriptionNew" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTAttachDescription") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </asp:Panel>
                                <center>
                                    <table cellpadding="3">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnNewComplianceReviewLetterOk" OnClientClick="javascript: return true;" OnClick="btnNewComplianceReviewLetterOk_Click"
                                                    CausesValidation="true" runat="server" Text="Okay" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnNewComplianceReviewLetterCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                                    runat="server" Text="Abort" />
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                            </asp:Panel>
                            <ajaxToolkit:ModalPopupExtender ID="mpeComplianceReviewNewLetter" runat="server"
                                TargetControlID="btnComplianceReviewNewLetter" PopupControlID="pnlComplianceReviewNewLetter"
                                BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlComplianceReviewNewLetterTitle"
                                BehaviorID="jdpopupcompliancereviewnewletter" />
                            <script language="javascript" type="text/javascript">
                                function shown() {
                                    var tb = document.getElementById('<% =tbcrLtDateNew.ClientID %>');
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

                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelComplianceReviewPhotos" HeaderText="Photo">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatexxxfumfcanel1y8x432" runat="server">
                    <ContentTemplate>
                        <uc1:PhotoManager ID="PhotoManager2" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" Visible="false" ID="tabPanelComplianceLetterData" HeaderText="Compliance Letter">
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
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbcrLtDateUpdate" runat="server"
                                                                    Text='<%# Eval("crLTDate","{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                    ID="ibLtDateUpdate" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <ajaxToolkit:CalendarExtender ID="cecrLtDateUpdate" runat="server" TargetControlID="tbcrLtDateUpdate"
                                                        Format="MM/dd/yyyy" PopupButtonID="ibLtDateUpdate" />
                                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revcrLtDateUpdate" Display="Dynamic"
                                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                        ControlToValidate="tbcrLtDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Action deadline:"></asp:Label>
                                                </td>
                                                <td class="form_field">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox CssClass="form_field_date" Text='<%# Eval("crLTActionDate","{0:MM/dd/yyyy}") %>'
                                                                    Width="9em" ID="tbcrLTActionDateUpdate" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                    ID="ibtbcrLTActionDateUpdate" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <ajaxToolkit:CalendarExtender ID="cetbcrLTActionDateUpdate" runat="server" TargetControlID="tbcrLTActionDateUpdate"
                                                        Format="MM/dd/yyyy" PopupButtonID="ibtbcrLTActionDateUpdate" />
                                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revtbcrLTActionDateUpdate" Display="Dynamic"
                                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                        ControlToValidate="tbcrLTActionDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Letter Id:"></asp:Label>
                                                </td>
                                                <td class="form_field">
                                                    <asp:Label CssClass="form_field" ID="lblcrLTIDUpdate" runat="server" Text='<%# Eval("crLTID") %>'></asp:Label>
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
                                                                <asp:TextBox runat="server" ID="tbcrLTRecipientUpdate" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTRecipient") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="form_field_heading" align="right">
                                                                Address:
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddrUpdate" runat="server" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTMailAddr") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTMailAddr2Update" runat="server" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTMailAddr2") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="form_field_address">
                                                                <asp:TextBox ID="tbcrLTCityStateZipUpdate" runat="server" CssClass="form_field_address"
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
                                                                <asp:TextBox ID="tbcrLTCCopy1Update" runat="server" CssClass="form_field_address"
                                                                    Text='<%# Eval("crLTCCopy1") %>'></asp:TextBox>
                                                            </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy2Update" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTCCopy2") %>'></asp:TextBox>
                                                </td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTCCopy3Update" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTCCopy3") %>'></asp:TextBox>
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
                                                    <asp:DropDownList ID="ddlCRFromSignatureUpdate" runat="server">
                                                        <asp:ListItem Value="" Text=""></asp:ListItem>
                                                        <asp:ListItem Value="Hugh Palcic" Text="Hugh Palcic"></asp:ListItem>
                                                        <asp:ListItem Value="Bill Peck" Text="Bill Peck"></asp:ListItem>
                                                        <asp:ListItem Value="Shane Hostbjor" Text="Shane Hostbjor"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Title:
                                                    <asp:DropDownList ID="ddlCRFromTitleUpdate" runat="server">
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
                                                    <asp:TextBox ID="crLTAttachTypeUpdate" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTAttachType") %>'></asp:TextBox>
                                                </td>
                                                <td class="form_field_heading" align="right">
                                                    Description:
                                                </td>
                                                <td class="form_field_address">
                                                    <asp:TextBox ID="tbcrLTAttachDescriptionUpdate" runat="server" CssClass="form_field_address"
                                                        Text='<%# Eval("crLTAttachDescription") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </ItemTemplate>
                        </asp:FormView>
                        <center>
                            <asp:LinkButton ID="btnComplianceReviewNewLetterOld" runat="server" CausesValidation="False"
                                CommandName="New" Text="New Letter" /></center>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel Visible="false" runat="server" ID="tabPanelComplanceLetterDataScrolling"
            HeaderText="Compliance Letter (Scrolling)">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel1" runat="server">
                    <ContentTemplate>
                        <div style="overflow: scroll; height: 350px;">
                            <asp:Panel runat="server" ID="pnlComplianceLetterRepeater">
                                <asp:Repeater ID="rptrComplianceLetter" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                                    <ItemTemplate>
                                        <div style="border: 1px solid #0000FF; padding-bottom: 4px;">
                                            <asp:Panel CssClass="form_field_panel_squished" ID="Panel1" GroupingText="Dates"
                                                runat="server">
                                                <table width="100%" cellpadding="4" cellspacing="4" border="0">
                                                    <tr valign="middle">
                                                        <td class="form_field_heading" align="right">
                                                            <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Letter date:"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbcrLtDateUpdate" runat="server"
                                                                            Text='<%# Eval("crLTDate","{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                            ID="ibcrLtDateUpdate" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="cecrLtDateUpdate" runat="server" TargetControlID="tbcrLtDateUpdate"
                                                                Format="MM/dd/yyyy" PopupButtonID="ibcrLtDateUpdate" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revcrLtDateUpdate" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbcrLtDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading" align="right">
                                                            <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Action deadline:"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox CssClass="form_field_date" Text='<%# Eval("crLTActionDate","{0:MM/dd/yyyy}") %>'
                                                                            Width="9em" ID="tbcrLTActionDateUpdate" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                            ID="ibcrLTActionDateUpdate" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <ajaxToolkit:CalendarExtender ID="cecrLTActionDateUpdate" runat="server" TargetControlID="tbcrLTActionDateUpdate"
                                                                Format="MM/dd/yyyy" PopupButtonID="ibcrLTActionDateUpdate" />
                                                            <asp:RegularExpressionValidator ForeColor="Red" ID="revcrLTActionDateUpdate" Display="Dynamic"
                                                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                                ControlToValidate="tbcrLTActionDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td class="form_field_heading" align="right">
                                                            <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Letter Id:"></asp:Label>
                                                        </td>
                                                        <td class="form_field">
                                                            <asp:Label CssClass="form_field" ID="lblcrLTIDUpdate" runat="server" Text='<%# Eval("crLTID") %>'></asp:Label>
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
                                                                        <asp:TextBox runat="server" ID="tbcrLTRecipientUpdate" CssClass="form_field_address"
                                                                            Text='<%# Eval("crLTRecipient") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="form_field_heading" align="right">
                                                                        Address:
                                                                    </td>
                                                                    <td class="form_field_address">
                                                                        <asp:TextBox ID="tbcrLTMailAddrUpdate" runat="server" CssClass="form_field_address"
                                                                            Text='<%# Eval("crLTMailAddr") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                    <td class="form_field_address">
                                                                        <asp:TextBox ID="tbcrLTMailAddr2Update" runat="server" CssClass="form_field_address"
                                                                            Text='<%# Eval("crLTMailAddr2") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                    <td class="form_field_address">
                                                                        <asp:TextBox ID="tbcrLTCityStateZipUpdate" runat="server" CssClass="form_field_address"
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
                                                                        <asp:TextBox ID="tbcrLTCCopy1Update" runat="server" CssClass="form_field_address"
                                                                            Text='<%# Eval("crLTCCopy1") %>'></asp:TextBox>
                                                                    </td>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox ID="tbcrLTCCopy2Update" runat="server" CssClass="form_field_address"
                                                                Text='<%# Eval("crLTCCopy2") %>'></asp:TextBox>
                                                        </td>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox ID="tbcrLTCCopy3Update" runat="server" CssClass="form_field_address"
                                                                Text='<%# Eval("crLTCCopy3") %>'></asp:TextBox>
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
                                                            <asp:DropDownList ID="ddlCRFromSignatureUpdate" runat="server">
                                                                <asp:ListItem Value="" Text=""></asp:ListItem>
                                                                <asp:ListItem Value="Hugh Palcic" Text="Hugh Palcic"></asp:ListItem>
                                                                <asp:ListItem Value="Bill Peck" Text="Bill Peck"></asp:ListItem>
                                                                <asp:ListItem Value="Shane Hostbjor" Text="Shane Hostbjor"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="form_field_heading" align="right">
                                                            Title:
                                                            <asp:DropDownList ID="ddlCRFromTitleUpdate" runat="server">
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
                                                            <asp:TextBox ID="crLTAttachTypeUpdate" runat="server" CssClass="form_field_address"
                                                                Text='<%# Eval("crLTAttachType") %>'></asp:TextBox>
                                                        </td>
                                                        <td class="form_field_heading" align="right">
                                                            Description:
                                                        </td>
                                                        <td class="form_field_address">
                                                            <asp:TextBox ID="tbcrLTAttachDescriptionUpdate" runat="server" CssClass="form_field_address"
                                                                Text='<%# Eval("crLTAttachDescription") %>'></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </asp:Panel>
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
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnComplianceUpdate" OnClick="btnComplianceReviewUpdate_Click" runat="server"
            Text="Submit" />
        <asp:Label ID="lblComplianceReviewUpdateResults" Font-Bold="true" runat="server"
            Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <script language="javascript" type="text/javascript">
        function onNewComplianceReviewCancel() {
            if (confirm("Are you sure that you wish to abort?")) {
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
                        <asp:TextBox CssClass="form_field" ID="tbComplianceReviewLotNew" Width="29" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Lane"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlNewComplianceReviewLaneNew" runat="server"
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
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbReviewDateNew" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibReviewDateNew" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbReviewDateNew"
                            Format="MM/dd/yyyy" PopupButtonID="ibReviewDateNew" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator2"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbReviewDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                    <td align="right">
                        <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Close date:"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbCloseDateNew" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibCloseDateNew" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="tbCloseDateNew"
                            Format="MM/dd/yyyy" PopupButtonID="ibCloseDateNew" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator3"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbCloseDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Comments:"></asp:Label>
                    </td>
                    <td width="100%">
                        <asp:TextBox CssClass="form_field_mediumtextbox" Width="100%" ID="tbCommentsFormNew"
                            runat="server" TextMode="MultiLine"></asp:TextBox>
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
                        <asp:TextBox CssClass="form_field" Width="15em" ID="tbDesignRuleNew" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Req'd Action:"></asp:Label>
                    </td>
                    <td width="60%">
                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="tbRequiredActionNew"
                            runat="server" TextMode="MultiLine"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Follow up:"></asp:Label>
                    </td>
                    <td width="40%">
                        <asp:TextBox CssClass="form_field_bigtextbox" Width="100%" ID="tbFollowUpNew" runat="server"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel CssClass="form_field_panel" ID="Panel7te33" GroupingText="Compliance Letter"
            runat="server">
            <table width="100%" cellpadding="4" cellspacing="4" border="0">
                <tr valign="middle">
                    <td class="form_field_heading" align="right">
                        <asp:Label CssClass="form_field_heading" ID="Label1x3600" runat="server" Text="Letter date:"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbcrLtDateNewNewComplianceReview" runat="server"
                                        Text='<%# Eval("crLTDate","{0:MM/dd/yyyy}") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibcrLtDateNewNewComplianceReview" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="cecrLtDateNewNewComplianceReview" runat="server" TargetControlID="tbcrLtDateNewNewComplianceReview"
                            Format="MM/dd/yyyy" PopupButtonID="ibcrLtDateNewNewComplianceReview" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="revcrLtDateNewNewComplianceReview" Display="Dynamic"
                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbcrLtDateNewNewComplianceReview" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                    <td class="form_field_heading" align="right">
                        <asp:Label CssClass="form_field_heading" ID="Label1xx7xxx3" runat="server" Text="Action deadline:"></asp:Label><br />
                        <asp:Label ID="Labelxx41c36" runat="server" Text="(leave blank to default to 30 days after Letter Date)" style="font-size:smaller;"></asp:Label> 
                    </td>
                    <td class="form_field">
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Text='<%# Eval("crLTActionDate","{0:MM/dd/yyyy}") %>'
                                        Width="9em" ID="crLTActionDateNewNewComplianceReview" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibcrLTActionDateNewNewComplianceReview" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="cecrLTActionDateNewNewComplianceReview" runat="server" TargetControlID="crLTActionDateNewNewComplianceReview"
                            Format="MM/dd/yyyy" PopupButtonID="ibcrLTActionDateNewNewComplianceReview" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="revcrLTActionDateNewNewComplianceReview" Display="Dynamic"
                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="crLTActionDateNewNewComplianceReview" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                    <td class="form_field_heading" align="right">
                        &nbsp;
                    </td>
                    <td class="form_field">
                        &nbsp;
                    </td>
                </tr>
            </table>

        </asp:Panel>
        <center>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                        <asp:Button ID="btnNewComplianceOk" CausesValidation="true" runat="server" Text="Okay"
                            OnClick="btnNewComplianceReviewOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnComplianceOkayUpdate" OnClientClick="return onNewComplianceReviewCancel()"
                            runat="server" Text="Abort" />
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
    <asp:Button ID="btnNewComplianceReview" runat="server" Text="New Compliance Review" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewComplianceReview" runat="server" TargetControlID="btnNewComplianceReview"
        PopupControlID="pnlNewComplianceReviewId" BackgroundCssClass="modalBackground"
        PopupDragHandleControlID="pnlNewComplianceReviewTitleId" BehaviorID="jdpopupnewcompliancereview" />
    <script language="javascript" type="text/javascript">
        function shown() {
            var tb = document.getElementById('<% =tbComplianceReviewLotNew.ClientID %>');
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
