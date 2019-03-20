<%@ Page Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="Renewables_MJS.aspx.cs" Inherits="SubmittalProposal.Renewables_MJS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label4xx3" runat="server" Text="SROA Department"></asp:Label>
        <asp:DropDownList ID="ddlDepartmentSearch" runat="server" DataTextField="Department"
            DataValueField="Department">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label5ee3" runat="server" Text="SROA Department Contact"></asp:Label>
        <asp:DropDownList ID="ddlDepartmentContactSearch" runat="server" DataTextField="EmailContactName1"
            DataValueField="EmailContactName1">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Project"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbProjectName" Width="60" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="Business"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbBusinessName" Width="60" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="RenewableID"></asp:Label>
        <asp:TextBox CssClass="form_field" ID="tbRenewableID" Width="25" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="GridView1" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
        DataKeyNames="renewID" CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" SortExpression="ProjectName" />
            <asp:BoundField DataField="Business" HeaderText="Business" SortExpression="Business" />
            <asp:BoundField DataField="TermOfRenewable" HeaderText="Terms of Renewal" SortExpression="TermOfRenewable" />
            <asp:BoundField DataField="TermCost" HeaderText="Term Cost" SortExpression="TermCost" />
            <asp:BoundField DataField="RenewableEndDate" HeaderText="Renewable End Date" DataFormatString="{0:MM/dd/yyyy}"
                SortExpression="RenewableEndDate" />
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
    <table border="0" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td colspan="2">
                <asp:Panel ID="Panel1Update" GroupingText="Project" runat="server" CssClass="form_field_panel_squished">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label7xaaUpdate" runat="server" Text="Name"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field" ID="tbRenewablesProjectNameUpdate" MaxLength="100"
                                    Width="14em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label11x3Update" runat="server" Text="Type"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList CssClass="form_field" ID="ddlTypeUpdate" runat="server" DataTextField="DocName"
                                    DataValueField="ID">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label4xx33xUpdate" runat="server" Text="SROA Dept"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList  CssClass="form_field" ID="ddlDepartmentUpdate" runat="server" DataTextField="Department"
                                    DataValueField="Department">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label43x4ghgupdate" runat="server" Text="Term"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList  CssClass="form_field" ID="ddlTermUpdate" runat="server" DataTextField="TermOfRenewable"
                                    DataValueField="ID">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label43xehupdate" runat="server" Text="Auto Renew"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAutoRenewalUpdate" runat="server">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:DropDownList>
                                
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label4update" runat="server" Text="Cost"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field" Width="7em" ID="tbCostUpdate" MaxLength="50"
                                    runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label5cc3Update" runat="server" Text="Payment Type"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field" ID="tbPaymentTypeUpdate" MaxLength="100"
                                    Width="14em" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr valign="top">
            <td colspan="2">
                <asp:Panel ID="pnlRenewablesBusinessUpdate" GroupingText="Business" runat="server" CssClass="form_field_panel_squished">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label7sxx2sUpdate" runat="server" Text="Name"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field" ID="tbRenewablesBusinessNameUpdate" MaxLength="50"
                                    Width="15em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label422c0Update" runat="server" Text="Address"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field" ID="tbRenewablesBusinessAddressUpdate" MaxLength="100"
                                    Width="15em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label5xx9Update" runat="server" Text="Phone"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field" ID="tbRenewablesBusinessPhoneUpdate" MaxLength="50"
                                    Width="9em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label6pp0Update" runat="server" Text="Contact Name"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox CssClass="form_field" ID="tbRenewablesBusinessContactNameUpdate" MaxLength="50"
                                    Width="9em" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr valign="top">
            <td colspan="2">
                <asp:Panel ID="Panel2Update" GroupingText="Dates" runat="server" CssClass="form_field_panel_squished">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td align="right">
                                <asp:Label CssClass="form_field_heading" ID="Label7Update" runat="server" Text="Start:"></asp:Label>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbRenewableDateStartUpdate"
                                                runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibRenewableDateStartUpdate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <ajaxToolkit:CalendarExtender ID="ceRenewableDateStartUpdate" runat="server" TargetControlID="tbRenewableDateStartUpdate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibRenewableDateStartUpdate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revRenewableDateStartUpdate"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbRenewableDateStartUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                            <td align="right">
                                <asp:Label CssClass="form_field_heading" ID="Label8Update" runat="server" Text="End:"></asp:Label>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbRenewableDateEndUpdate"
                                                runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibRenewableDateEndUpdate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <ajaxToolkit:CalendarExtender ID="ceRenewableDateEndUpdate" runat="server" TargetControlID="tbRenewableDateEndUpdate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibRenewableDateEndUpdate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revRenewableDateEndUpdate" Display="Dynamic"
                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbRenewableDateEndUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label9Update" runat="server" Text="Review:"></asp:Label>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbRenewableDateReviewUpdate"
                                                runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibRenewableDateReviewUpdate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <ajaxToolkit:CalendarExtender ID="ceRenewableDateReviewUpdate" runat="server" TargetControlID="tbRenewableDateReviewUpdate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibRenewableDateReviewUpdate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revRenewableDateReviewUpdate"
                                    Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbRenewableDateReviewUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label10Update" runat="server" Text="Term:"></asp:Label>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbRenewableDateTermUpdate"
                                                runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibRenewableDateTermUpdate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <ajaxToolkit:CalendarExtender ID="ceRenewableDateTermUpdate" runat="server" TargetControlID="tbRenewableDateTermUpdate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibRenewableDateTermUpdate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revRenewableDateTermUpdate" Display="Dynamic"
                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbRenewableDateTermUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>

        <tr valign="top">
            <td colspan="2">
                <asp:Panel ID="Panel3x322Update" GroupingText="Notes" runat="server" CssClass="form_field_panel_squished">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td align="right">
                                <asp:TextBox Width="790" ID="tbNotesUpdate" TextMode="MultiLine" runat="server" Rows="3"></asp:TextBox> 
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>

    </table>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnRenewablesUpdate" OnClick="btnRenewablesUpdateSubmit_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblRenewablesResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <center>
        <asp:Button ID="btnNewRenewable" CausesValidation="false" OnClick="btnNewRenewable_OnClick"
            Text="New Renewable" runat="server"></asp:Button>
    </center>
    <asp:Panel runat="server" CssClass="newitempopup" Width="800" ID="pnlRenewableNewContent">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlRenewableNewTitle">
            <span>New Renewable</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewRenewableContent"
            CssClass="newitemcontent">
            <table border="0" cellpadding="0" cellspacing="2">
                <tr valign="top">
                    <td valign="top">
                        <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Project Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbRenewablesProjectNameNew" MaxLength="100" Width="15em" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Business Name"></asp:Label>
                    </td>
                    <td colspan="1">
                        <td>
                            <asp:TextBox ID="tbRenewablesBusinessNameNew" MaxLength="50" Width="15em" runat="server"></asp:TextBox>
                        </td>
                    </td>
                </tr>
            </table>
            <center>
                <table cellpadding="3">
                    <tr>
                        <td>
                            <asp:Button CausesValidation="true" TabIndex="21" OnClientClick="javascript: return true;"
                                ID="btnNewRenewablesOkay" runat="server" Text="Okay" OnClick="btnNewRenewablesOk_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnRenewablesNewCancel" TabIndex="22" runat="server" Text="Abort"
                                CausesValidation="false" OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                OnClick="btnNewRenewablesCancel_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="lblRenewalbesNewMessage" Font-Bold="true" ForeColor="Red" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </center>
        </asp:Panel>
    </asp:Panel>
    <asp:Button Style="display: none;" ID="btnrenewablehidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewRenewable" runat="server" TargetControlID="btnrenewablehidden1"
        PopupControlID="pnlRenewableNewContent" BackgroundCssClass="modalBackground"
        PopupDragHandleControlID="pnlRenewableNewTitle" BehaviorID="jdpopuprenewablenew" />
</asp:Content>
