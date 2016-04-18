<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="Citations.aspx.cs" Inherits="SubmittalProposal.Citations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="LastName"></asp:Label>
        <asp:TextBox ID="tbCitationLastNameLU" Width="80" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Fine Status"></asp:Label>
        <asp:DropDownList ID="ddlFineStatusLU" DataTextField="FineStatus" DataValueField="FineStatus"
            runat="server">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="CitationID"></asp:Label>
        <asp:TextBox ID="tbCitationIDLU" Width="46" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height: 400px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="VFirstName" HeaderText="First Name" SortExpression="VFirstName" />
                <asp:BoundField DataField="VLastName" HeaderText="Last Name" SortExpression="VLastName" />
                <asp:BoundField DataField="OffenseDate" HeaderText="Offence Date" SortExpression="OffenseDate"
                    DataFormatString="{0:d}" />
                <asp:BoundField DataField="FineStatus" HeaderText="Fine Status" SortExpression="FineStatus" />
                <asp:BoundField DataField="CitationID" HeaderText="CitationID" SortExpression="CitationID" />
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <asp:Panel ID="pnlCitationsViolatorUpdate" runat="server" GroupingText="Violator">
        <table border="0" cellpadding="0" cellspacing="2">
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="Last Name"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbCitationsLastNameUpdate" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Sunriver Status"></asp:Label>
                </td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlSunriverStatusUpdate" DataTextField="FineStatus" DataValueField="FineStatus"
                        runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="First Name"></asp:Label>
                </td>
                <td colspan="5">
                    <asp:TextBox ID="tbCitationsFirstNameUpdate" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Address1"></asp:Label>
                </td>
                <td colspan="5">
                    <asp:TextBox ID="tbCitationsAddress1Update" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Address2"></asp:Label>
                </td>
                <td colspan="5">
                    <asp:TextBox ID="tbCitationsAddress2Update" MaxLength="35" Width="15em" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="City"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbCitationsCityUpdate" MaxLength="20" Width="15em" runat="server"></asp:TextBox>
                </td>
                <td align="right">
                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="State"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbCitationsStateUpdate" MaxLength="2" Width="3em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Zip"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbCitationsZipUpdate" MaxLength="10" Width="6em" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlCitations" runat="server" GroupingText="Violations List">
        <table>
            <tr>
                <td><asp:Label CssClass="form_field_heading" ID="lbl17x332" runat="server" Text="Date"></asp:Label></td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox CssClass="form_field_date" ID="tbCitationsViolationsDateUpdate" Width="7em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibCitationsViolationsDateUpdate" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <ajaxToolkit:CalendarExtender ID="ceCitationsViolationsDateUpdate" runat="server" TargetControlID="tbCitationsViolationsDateUpdate"
                        Format="MM/dd/yyyy" PopupButtonID="ibCitationsViolationsDateUpdate" />
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revCitationsViolationsDateUpdate" Display="Dynamic"
                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                        ControlToValidate="tbCitationsViolationsDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </td>
                <td><asp:Label CssClass="form_field_heading" ID="lbl17x332a3" runat="server" Text="Location"></asp:Label></td>
                <td><asp:TextBox CssClass="form_field" runat="server" ID="tbCitationsViolationsLocationUpdate" Width="20em" MaxLength="50"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="4">
                    <div style="height: 10em; width:900px; overflow: auto;">
                        <asp:GridView ID="gvViolations" 
                            Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
                            CellPadding="4" ForeColor="#333333" GridLines="None" 
                            onrowediting="gvViolations_RowEditing" 
                            onrowupdating="gvViolations_RowUpdating" 
                            onrowcancelingedit="gvViolations_RowCancelingEdit" 
                            ShowFooter="true"
                            onrowdatabound="gvViolations_RowDataBound">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true" ShowCancelButton="true" />
                                <asp:BoundField DataField="fkRuleID" HeaderText="Rule #" 
                                    SortExpression="fkRuleID" />
                                <asp:BoundField DataField="ViolationID" HeaderText="Violation Id" 
                                    SortExpression="ViolationID" />
                                <asp:BoundField DataField="RuleDescription" HeaderText="Rule Description" 
                                    SortExpression="RuleDescription" />
                                <asp:TemplateField HeaderText="Fine $" SortExpression="ScheduleFine">
                                    <ItemTemplate>
                                        <asp:Label ID="lblScheduleFineUpdate" runat="server" 
                                            Text='<%# Bind("ScheduleFine", "{0:c}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbScheduleFineUpdate" runat="server" Text='<%# Bind("ScheduleFine") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblSumFine" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="IssueAsWarning" HeaderText="Warning" 
                                    SortExpression="IssueAsWarning" />
                                <asp:BoundField DataField="ViolationNotes" HeaderText="Violation Notes" 
                                    SortExpression="ViolationNotes" />
                                <asp:BoundField DataField="ORS#" HeaderText="ORS #" SortExpression="ORS#" />
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

                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlCitationsFineUpdate" GroupingText="Fine Information">
        <table>
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label1sx0" runat="server" Text="Fine Status"></asp:Label>
                </td>
                <td colspan="5">
                    <asp:DropDownList runat="server" ID="ddlCitationsFineStatusUpdate" DataTextField="FineStatus" 
                        DataValueField="FineStatus"
                    ></asp:DropDownList>
                </td>
            </tr>

        </table>
    </asp:Panel>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnCitationsUpdate" OnClick="btnCitationsUpdateOkay_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblCitationsUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
        <asp:Label ID="lblDatePrintedHeading" runat="server" Text="Printed: "></asp:Label>
        <asp:Label ID="lblDatePrinted" runat="server"></asp:Label>
        <asp:Button Style="margin-left: 1em;" ID="btnPrintForm" runat="server" OnClick="btnPrintForm_OnClick"
            CausesValidation="false" Text="Print Form" OnClientClick="javascript:window.print(); return true;" />
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
