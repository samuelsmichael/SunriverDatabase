<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="IDCardManagement.aspx.cs" Inherits="SubmittalProposal.IDCardManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <table>
            <tr>
                <td>
                    <asp:Label ID="Label21" runat="server" Text="Find by Lot Number"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtLotLaneSearch" Width="640px" runat="server" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                    <ajaxToolkit:TextBoxWatermarkExtender WatermarkCssClass="watermarkclass" runat="server"
                        TargetControlID="txtLotLaneSearch" WatermarkText="Key in any part of the SR Address (2 char minimum)">
                    </ajaxToolkit:TextBoxWatermarkExtender>
                    <script type="text/javascript" language="javascript">
                        function AutoCompleteEx_OnClientItemSelected(sender, args) {
                            __doPostBack(sender.get_element().name, '');
                        }
                    </script>
                    <ajaxToolkit:AutoCompleteExtender ServiceMethod="SearchByLotLane" MinimumPrefixLength="2"
                        CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="txtLotLaneSearch"
                        CompletionListCssClass="completionlistcssclass" CompletionListItemCssClass="completionlistitemscssclass"
                        OnClientItemSelected="AutoCompleteEx_OnClientItemSelected" ID="AutoCompleteExtender2"
                        runat="server" CompletionListHighlightedItemCssClass="completionlisthighlighteditemcssclass">
                    </ajaxToolkit:AutoCompleteExtender>
                </td>
            </tr>
            <tr>
                <td>
                    Find by name
                </td>
                <td>
                    <asp:TextBox ID="txtContactsSearch" Width="640px" runat="server" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                    <ajaxToolkit:TextBoxWatermarkExtender WatermarkCssClass="watermarkclass" ID="TextBoxWatermarkExtender1"
                        runat="server" TargetControlID="txtContactsSearch" WatermarkText="Key in any part of the owner's name (2 char minimum)">
                    </ajaxToolkit:TextBoxWatermarkExtender>
                    <ajaxToolkit:AutoCompleteExtender ServiceMethod="SearchByName" MinimumPrefixLength="2"
                        CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" TargetControlID="txtContactsSearch"
                        CompletionListCssClass="completionlistcssclass" CompletionListItemCssClass="completionlistitemscssclass"
                        OnClientItemSelected="AutoCompleteEx_OnClientItemSelected" ID="AutoCompleteExtender1"
                        runat="server" CompletionListHighlightedItemCssClass="completionlisthighlighteditemcssclass">
                    </ajaxToolkit:AutoCompleteExtender>
                </td>
            </tr>
        </table>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <table width="100%">
        <tr>
            <th width="50%" align="center">
                Property
            </th>
            <th width="50%" align="center">
                Owner
            </th>
        </tr>
        <tr>
            <td width="50%" align="center">
                <table>
                    <tr>
                        <td>
                            Lot/Lane
                        </td>
                        <td>
                            <asp:Label ID="lbPropertyLotLane" runat="server"> </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            County Address
                        </td>
                        <td>
                            <asp:Label ID="lbPropertyCountyAddress" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Property Id
                        </td>
                        <td>
                            <asp:Label ID="lbPropertyPropertyId" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="50%" align="center">
                <table>
                    <tr>
                        <td>
                            Name
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerName" runat="server"> </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerAddressStreet" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerCityStateZip" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Phone
                        </td>
                        <td>
                            <asp:Label ID="lbOwnerPhone" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <asp:GridView Width="100%" ID="gvCardholders" runat="server" AutoGenerateColumns="False"
        CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True" OnRowCancelingEdit="gvCardholders_RowCancelingEdit"
        OnRowEditing="gvCardholders_RowEditing" OnRowDataBound="gv_RowDataBound" OnRowUpdating="gvCardholders_RowUpdating"
        DataKeyNames="CardID">
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
            <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true"
                ShowCancelButton="true" />
            <asp:TemplateField HeaderText="Card ID">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CardID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <EditItemTemplate>
                    <asp:TextBox ID="tbcdFirstNameUpdate" runat="server" Text='<%# Bind("cdFirstName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1i" runat="server" Text='<%# Bind("cdFirstName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Last Name">
                <EditItemTemplate>
                    <asp:TextBox ID="tbcdLastNameUpdate" runat="server" Text='<%# Bind("cdLastName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1a" runat="server" Text='<%# Bind("cdLastName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Card Class">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlcdClassUpdate" DataTextField="cdClass" DataValueField="cdClass"
                        runat="server">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1b" runat="server" Text='<%# Bind("cdClass") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Birth Date">
                <ItemTemplate>
                    <asp:Label ID="Label1c" runat="server" Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>' CssClass="form_field" ID="tbcdDateOfBirthUpdate"
                                    Width="8em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbcdDateOfBirthUpdate" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <ajaxToolkit:CalendarExtender ID="cetbcdDateOfBirthUpdate" runat="server" TargetControlID="tbcdDateOfBirthUpdate"
                        Format="MM/dd/yyyy" PopupButtonID="ibtbcdDateOfBirthUpdate" />
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revtbcdDateOfBirthUpdate" Display="Dynamic"
                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                        ControlToValidate="tbcdDateOfBirthUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Age">
                <ItemTemplate>
                    <asp:Label ID="Label1d" runat="server" Text='<%# FormatAge(Eval("cdDOB")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Card Status">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlcdCardStatusUpdate" DataTextField="cdStatus" DataValueField="cdStatus"
                        runat="server">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1e" runat="server" Text='<%# Bind("cdStatus") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Issue Date">
                <ItemTemplate>
                    <asp:Label ID="Label1f" runat="server" Text='<%# Eval("cdIssueDate","{0:MM/dd/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox Text='<%# Eval("cdIssueDate","{0:MM/dd/yyyy}") %>' CssClass="form_field"
                                    ID="tbcdIssueDateUpdate" Width="8em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbcdIssueDateUpdate" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <ajaxToolkit:CalendarExtender ID="cetbcdIssueDateUpdate" runat="server" TargetControlID="tbcdIssueDateUpdate"
                        Format="MM/dd/yyyy" PopupButtonID="ibtbcdIssueDateUpdate" />
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revtbcdIssueDateUpdate" Display="Dynamic"
                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                        ControlToValidate="tbcdIssueDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fee Paid">
                <ItemTemplate>
                    <asp:Label ID="Label1g" runat="server" Text='<%# Eval("cdFeePaid","{0:c}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox Text='<%# Eval("cdFeePaid","{0:c}") %>' CssClass="form_field" ID="tbcdFeePaidUpdate"
                        Width="8em" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ID Card">
                <ItemTemplate>
                    <asp:Label ID="lblCardIssued" runat="server" Text='<%# FormatCardIssued(Eval("cdIDCardIssued")) %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlcdIDCardIssuedUpdate" DataTextField="cdYesNo" DataValueField="cdYesNo"
                        runat="server">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rec Pass">
                <ItemTemplate>
                    <asp:Label ID="lblRecPassIssued" runat="server" Text='<%# FormatCardIssued(Eval("cdRecPassIssued")) %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlcdRecPassIssuedUpdate" DataTextField="cdYesNo" DataValueField="cdYesNo"
                        runat="server">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comments">
                <EditItemTemplate>
                    <asp:TextBox ID="tbcdCommentsUpdate" runat="server" Text='<%# Bind("cdComments") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1h" runat="server" Text='<%# Bind("cdComments") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Label ID="lblIDCardManagementUpdateResults" Font-Bold="true" runat="server"
        Text=""></asp:Label>
    <asp:LinkButton ID="lbNewIdCardId" OnClick="lbIDCardNew_OnClick" runat="server">New ID Card</asp:LinkButton>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewIDCardId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewIDCardTitleId">
            <span>New ID Card</span>
        </asp:Panel>
        <asp:Panel runat="server" Style="text-align: center;" ID="pnlNewIDCardContent" CssClass="newitemcontent">
            <asp:Panel ID="Panel8" GroupingText="Card Ownder Info" runat="server">
                <table width="100%" cellpadding="3" cellspacing="3">
                    <tr style="white-space:nowrap;">
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="First name"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbcdFirstNameNew" MaxLength="20" Width="13em"
                                runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Last name"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbcdLastNameNew" MaxLength="20" Width="13em"
                                runat="server"></asp:TextBox>
                        </td>
                        <td style="white-space:nowrap;">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Birthdate"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>' CssClass="form_field" ID="tbcdDateOfBirthNew"
                                            Width="6em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            ID="ibtbcdDateOfBirthNew" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender ID="cetbcdDateOfBirthNew" runat="server" TargetControlID="tbcdDateOfBirthNew"
                                Format="MM/dd/yyyy" PopupButtonID="ibtbcdDateOfBirthNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="revtbcdDateOfBirthNew" Display="Dynamic"
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbcdDateOfBirthNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="Panel1" GroupingText="Card Info" runat="server">
                <table width="100%" cellpadding="1" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Card class"></asp:Label>
                            <asp:DropDownList ID="ddlcdClassNew" DataTextField="cdClass" DataValueField="cdClass"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Card class"></asp:Label>
                            <asp:DropDownList ID="ddlcdCardStatusNew" DataTextField="cdStatus" DataValueField="cdStatus"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Fee paid"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbFeePaidNew" MaxLength="6" Width="4em"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel  runat="server" ID="pnlIssuedNew" GroupingText="Issued">
                <table align="center" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Date"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>' CssClass="form_field" ID="tbIssueDateNew"
                                            Width="6em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            ID="ibtbIssueDateNew" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender ID="cetbIssueDateNew" runat="server" TargetControlID="tbIssueDateNew"
                                Format="MM/dd/yyyy" PopupButtonID="ibtbIssueDateNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="retbIssueDateNew" Display="Dynamic"
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbIssueDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Id Card"></asp:Label>
                            <asp:DropDownList ID="ddlIssuedIdCardNew" DataTextField="cdYesNo" DataValueField="cdYesNo"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Rec Pass"></asp:Label>
                            <asp:DropDownList ID="ddlIssuedRecPassNew" DataTextField="cdYesNo" DataValueField="cdYesNo"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnlCommentsNew" GroupingText="Comments">
                <asp:TextBox  ID="tbCommentsNew" TextMode="MultiLine" Width="50em"
                    runat="server"></asp:TextBox>
            </asp:Panel>
        </asp:Panel>
        <script language="javascript" type="text/javascript">
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
                || (sender._postBackSettings.sourceElement.id.indexOf("btnNew") != -1 && sender._postBackSettings.sourceElement.id.indexOf("Ok") != -1)) {
                    var loading = $(".loading");
                    loading.hide();
                }
            }

        </script>
        <center>
            <table cellpadding="4">
                <tr>
                    <td>
                        <asp:Button ID="btnNewIDCardOkId" OnClientClick="javascript: if(Page_IsValid) { return doOk();}"
                            CausesValidation="true" runat="server" Text="Okay" OnClick="btnNewIDCardOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewIDCardCancelId" OnClick="btnNewIDCardCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to cancel?')"
                            runat="server" Text="Cancel" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblIDCardNewResults" Font-Bold="true" runat="server" Text=""></asp:Label>
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
    <asp:Button Style="display: none;" ID="btnhidden1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewIDCard" runat="server" TargetControlID="btnhidden1"
        PopupControlID="pnlNewIDCardId" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewIDCardTitleId"
        BehaviorID="jdpopupidcard" />
</asp:Content>
