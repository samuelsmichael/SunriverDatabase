<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="Contractor.aspx.cs" Inherits="SubmittalProposal.Contractor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td width="100">
        <asp:Label ID="Label20" runat="server" Text="Company Name"></asp:Label>
        <asp:TextBox ID="tbCompanyName" Width="100" MaxLength="70" runat="server"></asp:TextBox>
    </td>
    <td width="100">
        <asp:Label ID="Label1" runat="server" Text="Contact Name"></asp:Label>
        <asp:TextBox ID="tbContactName" Width="100" MaxLength="50" runat="server"></asp:TextBox>
    </td>
    <td width="60">
        <asp:Label ID="Label2" runat="server" Text="License #"></asp:Label>
        <asp:TextBox ID="tbLicenseNumber" Width="60" MaxLength="8" runat="server"></asp:TextBox>
    </td>
    <td width="80">
        <asp:Label ID="Label3" runat="server" Text="Category"></asp:Label>
        <asp:TextBox ID="tbCategory" Width="80" MaxLength="35" runat="server"></asp:TextBox>
    </td>
    <td width="66">
        <asp:Label ID="Label24" runat="server" Text="SRContrRegID"></asp:Label>
        <asp:TextBox ID="tbSRContrRegID" Width="66" runat="server"></asp:TextBox>
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
            <asp:BoundField DataField="Reg_Date" DataFormatString=" {0:d}" HeaderText="Reg Date"
                SortExpression="Reg_Date">
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Company" HeaderText="Company" SortExpression="Company" />
            <asp:BoundField DataField="Contact" HeaderText="Contact" SortExpression="Contact" />
            <asp:BoundField DataField="Phone_1" HeaderText="Phone 1" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Lic_Number" HeaderText="License" />
            <asp:BoundField DataField="CAT_1" HeaderText="Category 1"></asp:BoundField>
            <asp:BoundField DataField="SRContrRegID" HeaderText="SRContrRegID" SortExpression="SRContrRegID" />
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
    <div class="updatepanel">
        <asp:Panel ID="Panel1" CssClass="form_field_panel_squished" GroupingText="Contractor data"
            runat="server">
            <table cellpadding="2" cellspacing="2" border="0">
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label18" runat="server" Text="Company"></asp:Label>
                    </td>
                    <td colspan="5">
                        <asp:TextBox CssClass="form_field" ID="tbCompanyUpdate" MaxLength="70" Width="355"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Contact name"></asp:Label>
                    </td>
                    <td colspan="5">
                        <asp:TextBox CssClass="form_field" ID="tbContactUpdate" MaxLength="50" Width="355"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Addr1"></asp:Label>
                    </td>
                    <td colspan="5">
                        <asp:TextBox CssClass="form_field" ID="tbMailAddr1Update" MaxLength="40" Width="355"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Addr2"></asp:Label>
                    </td>
                    <td colspan="5">
                        <asp:TextBox CssClass="form_field" ID="tbMailAddr2Update" MaxLength="40" Width="355"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="City"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="tbCityUpdate" MaxLength="20" Width="135" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="State"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="tbStateUpdate" MaxLength="2" Width="35" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Zip"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="tbZipUpdate" MaxLength="10" Width="75" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="License #"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="tbLic_NumberUpdate" MaxLength="8" Width="60"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Expires"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbLic_X_DateUpdate" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibLic_X_DateUpdate" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbLic_X_DateUpdate"
                            Format="MM/dd/yyyy" PopupButtonID="ibLic_X_DateUpdate" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator1"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbLic_X_DateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Active"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="tbActiveUpdate" MaxLength="5" Width="45" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Phone 1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="tbPhone1Update" MaxLength="14" Width="100"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Phone 2"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox CssClass="form_field" ID="tbPhone2Update" MaxLength="14" Width="100"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Fax"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox CssClass="form_field" ID="tbFaxUpdate" MaxLength="14" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox CssClass="form_field" ID="tbEmailUpdate" MaxLength="40" Width="205"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="Panel2" CssClass="form_field_panel_squished" GroupingText="Registration data"
            runat="server">
            <table cellpadding="2" cellspacing="2" border="0">
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="Category 1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory1Update" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label21" runat="server" Text="Category 2"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory2Update" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Registration date"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbReg_DateUpdate" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibReg_DateUpdate" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbReg_DateUpdate"
                            Format="MM/dd/yyyy" PopupButtonID="ibReg_DateUpdate" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator2"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbReg_DateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Category 3"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory3Update" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label23" runat="server" Text="Category 4"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory4Update" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="Panelx" runat="server" GroupingText="Comment">
            <asp:TextBox CssClass="form_field" ID="tbCommentUpdate" Width="855" runat="server"
                TextMode="MultiLine" Height="100"></asp:TextBox>
        </asp:Panel>
        <center>
            <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
                ID="btnContactUpdate" OnClick="btnContractorUpdate_Click" runat="server" Text="Submit" />
            <asp:Label ID="lblContactUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
        </center>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <script language="javascript" type="text/javascript">
        function onNewContractorCancel() {
            if (confirm("Are you sure that you wish to cancel?")) {
                return true;
            } else {
                return false;
            }
        }
    </script>
    <asp:Panel runat="server" Width="900px" CssClass="newitempopup" ID="pnlNewContractorId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewContractorTitleId">
            <span>New Contractor</span>
        </asp:Panel>
        <asp:Panel ID="Panel11" CssClass="newitemcontent" GroupingText="Contractor data"
            runat="server">
            <table cellpadding="2" cellspacing="0" border="0">
                <tr>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label28" runat="server" Text="Company"></asp:Label>
                    </td>
                    <td colspan="5" align="left">
                        <asp:TextBox CssClass="form_field" ID="tbCompanyNew" MaxLength="70" Width="355" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label29" runat="server" Text="Contact name"></asp:Label>
                    </td>
                    <td align="left" colspan="5">
                        <asp:TextBox CssClass="form_field" ID="tbContactNew" MaxLength="50" Width="355" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label30" runat="server" Text="Addr1"></asp:Label>
                    </td>
                    <td align="left" colspan="5">
                        <asp:TextBox CssClass="form_field" ID="tbMailAddr1New" MaxLength="40" Width="355"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Addr2"></asp:Label>
                    </td>
                    <td  align="left" colspan="5">
                        <asp:TextBox CssClass="form_field" ID="tbMailAddr2New" MaxLength="40" Width="355"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label32" runat="server" Text="City"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox CssClass="form_field" ID="tbCityNew" MaxLength="20" Width="135" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label33" runat="server" Text="State"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox CssClass="form_field" ID="tbStateNew" MaxLength="2" Width="35" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label34" runat="server" Text="Zip"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox CssClass="form_field" ID="tbZipNew" MaxLength="10" Width="75" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label35" runat="server" Text="License #"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox CssClass="form_field" ID="tbLic_NumberNew" MaxLength="8" Width="60"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label36" runat="server" Text="Expires"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbLic_X_DateNew" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibLic_X_DateNew" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="tbLic_X_DateNew"
                            Format="MM/dd/yyyy" PopupButtonID="ibLic_X_DateNew" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator4"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbLic_X_DateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label37" runat="server" Text="Active"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox CssClass="form_field" ID="tbActiveNew" MaxLength="5" Width="45" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label38" runat="server" Text="Phone 1"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox CssClass="form_field" ID="tbPhone1New" MaxLength="14" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label39" runat="server" Text="Phone 2"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox CssClass="form_field" ID="tbPhone2New" MaxLength="14" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label40" runat="server" Text="Fax"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox CssClass="form_field" ID="tbFaxNew" MaxLength="14" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Label CssClass="form_field_heading" ID="Label41" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox CssClass="form_field" ID="tbEmailNew" MaxLength="40" Width="205" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="Panel12" CssClass="newitemcontent" GroupingText="Registration data"
            runat="server">
            <table cellpadding="2" cellspacing="2" border="0">
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label42" runat="server" Text="Category 1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory1New" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label43" runat="server" Text="Category 2"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory2New" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label44" runat="server" Text="Registration date"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbReg_DateNew" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                        ID="ibReg_DateNew" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="tbReg_DateNew"
                            Format="MM/dd/yyyy" PopupButtonID="ibReg_DateNew" />
                        <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator5"
                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                            ControlToValidate="tbReg_DateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label45" runat="server" Text="Category 3"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory3New" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label CssClass="form_field_heading" ID="Label46" runat="server" Text="Category 4"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="form_field" ID="ddlCategory4New" runat="server" DataTextField="Category"
                            DataValueField="Category">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="Panel3" CssClass="newitemcontent" runat="server" GroupingText="Comment">
            <asp:TextBox CssClass="form_field" ID="tbCommentNew" Width="855" runat="server" TextMode="MultiLine"
                Height="100"></asp:TextBox>
        </asp:Panel>
        <center>
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                        <asp:Button ID="btnNewContractorOk" CausesValidation="true" runat="server" Text="Okay"
                            OnClick="btnNewContractorOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnContractorCancelNew" OnClientClick="return onNewContractorCancel()"
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
    <asp:LinkButton ID="lbNewContractor" runat="server">New Contractor</asp:LinkButton>
    <ajaxToolkit:ModalPopupExtender ID="mpeNewContractor" runat="server" TargetControlID="lbNewContractor"
        PopupControlID="pnlNewContractorId" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewContractorTitleId"
        BehaviorID="jdpopupnewContractor" />
    <script language="javascript" type="text/javascript">
        function shown() {
            var tb = document.getElementById('<% =tbCompanyNew.ClientID %>');
            tb.focus();

        }
        function pageLoad() {
            var dddp = $find('jdpopupnewContractor');
            dddp.add_shown(shown);
        }

        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
                // I don't know about this                $find("jdpopup").hide();
            }
        }
    </script>
</asp:Content>
