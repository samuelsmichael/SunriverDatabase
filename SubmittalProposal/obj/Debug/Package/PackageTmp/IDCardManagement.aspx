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
                     <asp:TextBox ID="txtLotLaneSearch" Width="640px" runat="server" 
                                            ontextchanged="txtSearch_TextChanged"></asp:TextBox>

                     <ajaxToolkit:TextBoxWatermarkExtender WatermarkCssClass="watermarkclass" runat="server" TargetControlID="txtLotLaneSearch" WatermarkText="Key in any part of the SR Address (2 char minimum)"></ajaxToolkit:TextBoxWatermarkExtender>


                     <script type="text/javascript" language="javascript">
                         function AutoCompleteEx_OnClientItemSelected(sender, args) {
                             __doPostBack(sender.get_element().name, '');
                         }
                     </script>
                    <ajaxToolkit:autocompleteextender ServiceMethod="SearchByLotLane"
                        MinimumPrefixLength="2"
                        CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtLotLaneSearch"
                         CompletionListCssClass="completionlistcssclass"
                          CompletionListItemCssClass="completionlistitemscssclass"
                          OnClientItemSelected="AutoCompleteEx_OnClientItemSelected"
                        ID="AutoCompleteExtender2" runat="server" CompletionListHighlightedItemCssClass="completionlisthighlighteditemcssclass">
                    </ajaxToolkit:autocompleteextender>



                </td>
            </tr>
            <tr>
                <td>Find by name</td>
                <td>
                     <asp:TextBox ID="txtContactsSearch" Width="640px" runat="server" 
                                            ontextchanged="txtSearch_TextChanged"></asp:TextBox>
                     <ajaxToolkit:TextBoxWatermarkExtender WatermarkCssClass="watermarkclass" ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtContactsSearch" WatermarkText="Key in any part of the owner's name (2 char minimum)"></ajaxToolkit:TextBoxWatermarkExtender>


                    <ajaxToolkit:autocompleteextender ServiceMethod="SearchByName"
                        MinimumPrefixLength="2"
                        CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtContactsSearch"
                         CompletionListCssClass="completionlistcssclass"
                          CompletionListItemCssClass="completionlistitemscssclass"
                          OnClientItemSelected="AutoCompleteEx_OnClientItemSelected"
                        ID="AutoCompleteExtender1" runat="server" CompletionListHighlightedItemCssClass="completionlisthighlighteditemcssclass">
                    </ajaxToolkit:autocompleteextender>
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
                    <asp:Label ID="Label1c" runat="server" Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>'
                        ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                        <table><tr><td>
                        <asp:TextBox Text='<%# Eval("cdDOB","{0:MM/dd/yyyy}") %>' CssClass="form_field" ID="tbcdDateOfBirthUpdate" Width="8em" runat="server"></asp:TextBox>
                        </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibtbcdDateOfBirthUpdate" runat="server" /></td></tr></table>
                        <ajaxToolkit:CalendarExtender ID="cetbcdDateOfBirthUpdate" runat="server"
                            TargetControlID="tbcdDateOfBirthUpdate"
                            Format="MM/dd/yyyy"
                            PopupButtonID="ibtbcdDateOfBirthUpdate" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="revtbcdDateOfBirthUpdate"  Display="Dynamic" 
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
                    <asp:Label ID="Label1f" runat="server" Text='<%# Eval("cdIssueDate","{0:MM/dd/yyyy}") %>'
                        ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                        <table><tr><td>
                        <asp:TextBox Text='<%# Eval("cdIssueDate","{0:MM/dd/yyyy}") %>' CssClass="form_field" ID="tbcdIssueDateUpdate" Width="8em" runat="server"></asp:TextBox>
                        </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibtbcdIssueDateUpdate" runat="server" /></td></tr></table>
                        <ajaxToolkit:CalendarExtender ID="cetbcdIssueDateUpdate" runat="server"
                            TargetControlID="tbcdIssueDateUpdate"
                            Format="MM/dd/yyyy"
                            PopupButtonID="ibtbcdIssueDateUpdate" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="revtbcdIssueDateUpdate"  Display="Dynamic" 
                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbcdIssueDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fee Paid">
                <ItemTemplate>
                    <asp:Label ID="Label1g" runat="server" Text='<%# Eval("cdFeePaid","{0:c}") %>'
                        ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox Text='<%# Eval("cdFeePaid","{0:c}") %>' CssClass="form_field" ID="tbcdFeePaidUpdate" Width="8em" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ID Card">
                <ItemTemplate>
                    <asp:Label ID="lblCardIssued" runat="server" Text='<%# FormatCardIssued(Eval("cdIDCardIssued")) %>'
                        ></asp:Label>
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
                    <asp:Label ID="lblRecPassIssued" runat="server" Text='<%# FormatCardIssued(Eval("cdRecPassIssued")) %>'
                        ></asp:Label>
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
    <asp:Label ID="lblIDCardManagementUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
