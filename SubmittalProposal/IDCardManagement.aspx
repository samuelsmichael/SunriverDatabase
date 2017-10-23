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
    <table cellpadding="4" cellpadding="0" border="0" width="95%">
        <tr>
            <td>
                <asp:Label ID="lblGuestPass1NbrUpdate" runat="server" Text="Guest pass 1: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbGuestPass1NbrUpdate" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblGuestPass2NbrUpdate" runat="server" Text="Guest pass 2: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tbGuestPass2NbrUpdate" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                <asp:Button ID="btnUpdateGuestPasses" runat="server" 
                    Text="Update Guest Pass Nbrs" Visible="false" onclick="btnUpdateGuestPasses_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                <asp:Label ID="lblGuestPassesUpdateResults" Font-Bold="true" Visible="false" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div style="width:95%; text-align:center;">
    </div>
    <asp:GridView Width="100%" ID="gvCardholders" runat="server" AutoGenerateColumns="False" AllowSorting="true"
        CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True" 
        OnRowDataBound="gv_RowDataBound" 
        DataKeyNames="CardID" OnSorting="gvCardholders_Sorting">
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
            <asp:TemplateField ItemStyle-Width = "30px" HeaderText = "">
               <ItemTemplate>
                   <asp:LinkButton ID="lnkEdit" runat="server" Text = "Edit" OnClick = "Edit"></asp:LinkButton>
               </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Card ID">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("CardID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name" SortExpression="cdFirstName">
                <ItemTemplate>
                    <asp:Label ID="Label1i" runat="server" Text='<%# Bind("cdFirstName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Last Name" SortExpression="cdLastName">
                <ItemTemplate>
                    <asp:Label ID="Label1a" runat="server" Text='<%# Bind("cdLastName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Card Class">
                <ItemTemplate>
                    <asp:Label ID="Label1b" runat="server" Text='<%# Bind("cdClass") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Birth Date">
                <ItemTemplate>
                    <asp:Label ID="Label1c" runat="server" Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Age">
                <ItemTemplate>
                    <asp:Label ID="Label1d" runat="server" Text='<%# FormatAge(Eval("cdDOB")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Card Status">
                <ItemTemplate>
                    <asp:Label ID="Label1e" runat="server" Text='<%# Bind("cdStatus") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Issue Date">
                <ItemTemplate>
                    <asp:Label ID="Label1f" runat="server" Text='<%# Eval("cdIssueDate","{0:MM/dd/yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fee Paid">
                <ItemTemplate>
                    <asp:Label ID="Label1g" runat="server" Text='<%# Eval("cdFeePaid","{0:c}") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ID Card">
                <ItemTemplate>
                    <asp:Label ID="lblCardIssued" runat="server" Text='<%# FormatCardIssued(Eval("cdIDCardIssued")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rec Pass">
                <ItemTemplate>
                    <asp:Label ID="lblRecPassIssued" runat="server" Text='<%# FormatCardIssued(Eval("cdRecPassIssued")) %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comments">
                <ItemTemplate>
                    <asp:Label ID="Label1h" runat="server" Text='<%# Bind("cdComments") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Permanent Note">
                <ItemTemplate>
                    <asp:Label ID="Label1ij" runat="server" Text='<%# Bind("cdPermanentNote") %>'></asp:Label>
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
                            <asp:TextBox CssClass="form_field" ID="tbcdFirstNameNew" AutoPostBack="true" OnTextChanged="tbcdFirstNameNew_OnTextChanged" MaxLength="20" Width="13em"
                                runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Last name"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbcdLastNameNew"  AutoPostBack="true" OnTextChanged="tbcdLastNameNew_OnTextChanged" MaxLength="20" Width="13em"
                                runat="server"></asp:TextBox>
                        </td>
                        <td style="white-space:nowrap;">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Birthdate"></asp:Label>
                                    </td>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td><asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>' AutoPostBack="true" OnTextChanged="tbcdDateOfBirthNew_OnTextChanged" CssClass="form_field" ID="tbcdDateOfBirthNew"
                                                        Width="6em" runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td> Age: <asp:Label runat="server" ID="lblAgeNew"></asp:Label></td>
                                            </tr>
                                       </table>
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

                            <asp:CustomValidator ControlToValidate="tbcdDateOfBirthNew" ID="cvtbcdDateOfBirthNew" runat="server" ErrorMessage="Required when Dependent"
                                 Display="Dynamic" ValidateEmptyText="true" ForeColor="Red" Font-Bold="true" OnServerValidate="DateOfBirth_OnValidate"
                            ></asp:CustomValidator>
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
                            <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Card status"></asp:Label>
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
                                        <asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>'  AutoPostBack="true" OnTextChanged="tbIssueDateNew_OnTextChanged"  CssClass="form_field" ID="tbIssueDateNew"
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
            <asp:Panel runat="server" ID="pnlPermanentNoteNew" GroupingText="Permanent Note">
                            <asp:TextBox  ID="tbPermanentNoteNew" TextMode="MultiLine" MaxLength="30" Width="50em"
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
                        <asp:Button ID="btnNewIDCardOkId" OnClientClick="javascript: if(Page_IsValid) { return true;}"
                            CausesValidation="true" runat="server" Text="Okay" OnClick="btnNewIDCardOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewIDCardCancelId" CausesValidation="false" OnClick="btnNewIDCardCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to abort?')"
                            runat="server" Text="Abort" />
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


    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlUpdateIDCardId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlUpdateIDCardTitleId">
            <span>Update ID Card</span>
        </asp:Panel>

        <asp:Panel runat="server" Style="text-align: center;" ID="pnlUpdateIDCardContent" CssClass="newitemcontent">
            <asp:Panel ID="Panel2" GroupingText="Card Ownder Info" runat="server">
                <table width="100%" cellpadding="3" cellspacing="3">
                    <tr style="white-space:nowrap;">
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="First name"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbcdFirstNameUpdate"  AutoPostBack="true" OnTextChanged="tbcdFirstNameUpdate_OnTextChanged" MaxLength="20" Width="13em"
                                runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Last name"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbcdLastNameUpdate"  AutoPostBack="true" OnTextChanged="tbcdLastNameUpdate_OnTextChanged" MaxLength="20" Width="13em"
                                runat="server"></asp:TextBox>
                        </td>
                        <td style="white-space:nowrap;">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Birthdate"></asp:Label>
                                    </td>
                                    <td>

                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td><asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>' AutoPostBack="true" 
                                                        OnTextChanged="tbcdDateOfBirthUpdate_OnTextChanged" CssClass="form_field" ID="tbcdDateOfBirthUpdate"
                                                        Width="6em" runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td> Age: <asp:Label runat="server" ID="lblAgeUpdate"></asp:Label></td>
                                            </tr>
                                       </table>
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
                            <asp:CustomValidator ControlToValidate="tbcdDateOfBirthUpdate" ID="cvtbcdDateOfBirthUpdate" runat="server" ErrorMessage="Required when Dependent"
                                 Display="Dynamic" ValidateEmptyText="true" ForeColor="Red" Font-Bold="true" OnServerValidate="DateOfBirth_OnValidateUpdate"
                            ></asp:CustomValidator>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="Panel3" GroupingText="Card Info" runat="server">
                <table width="100%" cellpadding="1" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Card class"></asp:Label>
                            <asp:DropDownList ID="ddlcdClassUpdate" DataTextField="cdClass" DataValueField="cdClass"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Card status"></asp:Label>
                            <asp:DropDownList ID="ddlcdCardStatusUpdate" DataTextField="cdStatus" DataValueField="cdStatus"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Fee paid"></asp:Label>
                            <asp:TextBox CssClass="form_field" ID="tbFeePaidUpdate" MaxLength="6" Width="4em"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel  runat="server" ID="pnlIssuedUpdate" GroupingText="Issued">
                <table align="center" cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Date"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>' AutoPostBack="true" OnTextChanged="tbIssueDateUpdate_OnTextChanged" CssClass="form_field" ID="tbIssueDateUpdate"
                                            Width="6em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            ID="ibtbIssueDateUpdate" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <ajaxToolkit:CalendarExtender ID="cetbIssueDateUpdate" runat="server" TargetControlID="tbIssueDateUpdate"
                                Format="MM/dd/yyyy" PopupButtonID="ibtbIssueDateUpdate" />
                            <asp:RegularExpressionValidator ForeColor="Red" ID="retbIssueDateUpdate" Display="Dynamic"
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbIssueDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Id Card"></asp:Label>
                            <asp:DropDownList ID="ddlIssuedIdCardUpdate" DataTextField="cdYesNo" DataValueField="cdYesNo"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Rec Pass"></asp:Label>
                            <asp:DropDownList ID="ddlIssuedRecPassUpdate" DataTextField="cdYesNo" DataValueField="cdYesNo"
                                runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnlCommentsUpdate" GroupingText="Comments">
                            <asp:TextBox  ID="tbCommentsUpdate" TextMode="MultiLine" Width="50em"
                                runat="server"></asp:TextBox>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnlPermanentNoteUpdate" GroupingText="Permanent Note">
                            <asp:TextBox  ID="tbPermanentNoteUpdate" TextMode="MultiLine" MaxLength="30" Width="50em"
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
                || (sender._postBackSettings.sourceElement.id.indexOf("btnUpdate") != -1 && sender._postBackSettings.sourceElement.id.indexOf("Ok") != -1)) {
                    var loading = $(".loading");
                    loading.hide();
                }
            }

        </script>


        <center>
            <table cellpadding="4">
                <tr>
                    <td>
                        <asp:LinkButton ID="lbUpdatePrevious" CausesValidation="true" runat="server" OnClick="lbUpdatePrevious_OnClick"><<</asp:LinkButton>
                    </td>
                    <td>
                        <asp:Button ID="btnUpdateIDCardOkId" OnClientClick="javascript: if(Page_IsValid) { return true;}"
                            CausesValidation="true" runat="server" Text="Okay" OnClick="btnUpdateIDCardOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnUpdateIDCardCancelId" CausesValidation="false" OnClick="btnUpdateIDCardCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to abort?')"
                            runat="server" Text="Abort" />
                    </td>
                    <td>
                        <asp:LinkButton ID="lbUpdateNext" CausesValidation="true" runat="server" OnClick="lbUpdateNext_OnClick">>></asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lblIDCardUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
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
    <asp:Button Style="display: none;" ID="btnhidden2" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeUpdateIDCard" runat="server" TargetControlID="btnhidden2"
        PopupControlID="pnlUpdateIDCardId" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlUpdateIDCardTitleId"
        BehaviorID="jdpopupidcardupdate" />



</asp:Content>
