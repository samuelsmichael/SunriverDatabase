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
                        Display="Dynamic" ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
                        ControlToValidate="tbLic_X_DateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Active"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbActiveUpdate" MaxLength="5" Width="41" runat="server"></asp:TextBox>
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
                        Display="Dynamic" ValidationExpression="^((0?[13578]|10|12)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/|.)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/|.)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$"
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
</asp:Content>
