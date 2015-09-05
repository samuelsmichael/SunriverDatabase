<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="SellCheck.aspx.cs" Inherits="SubmittalProposal.SellCheck" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="Requestor"></asp:Label>
        <asp:TextBox ID="tbRecipient" Width="80" runat="server"></asp:TextBox>
    </td>

    <td>
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLot" Width="40" MaxLength="5" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" Width="100" runat="server" DataTextField="Lane" DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label3" runat="server" Text="Copy 1"></asp:Label>
        <asp:TextBox ID="tbscLTCCopy1" Width="80" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label23" runat="server" Text="Request ID"></asp:Label>
        <asp:TextBox ID="tbRequestId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="Property ID"></asp:Label>
        <asp:TextBox ID="tbPropertyID" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Inspection ID"></asp:Label>
        <asp:TextBox ID="tbInspectionID" Width="46" runat="server"></asp:TextBox>
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
            <asp:BoundField DataField="scLTDate" HeaderText="Date" SortExpression="dateYYYYMMDD" DataFormatString="{0:d}" />
            <asp:BoundField DataField="scLot" HeaderText="Lot" SortExpression="scLot" />
            <asp:BoundField DataField="scLane" HeaderText="Lane" SortExpression="scLane" />
            <asp:BoundField DataField="scLTRecipient" HeaderText="Requestor" SortExpression="scLTRecipient" />
            <asp:BoundField DataField="scLTCCopy1" HeaderText="CCopy1" SortExpression="scLTCCopy1" />
            <asp:BoundField DataField="scRequestID" HeaderText="Request ID" SortExpression="scRequestID" />
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
    <asp:Panel ID="Panelx103" GroupingText="Property For Sale" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Sunriver Address"></asp:Label>
                    <asp:Label CssClass="form_field" ID="lblLot" runat="server"></asp:Label>
                    <asp:Label CssClass="form_field" ID="lblLane" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_Heading" ID="Label8a" runat="server" Text="Property ID"></asp:Label>
                    <asp:Label CssClass="form_field" ID="lblPropertyID" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_Heading" ID="Label9" runat="server" Text="Request ID"></asp:Label>
                    <asp:Label CssClass="form_field" ID="lblRequestID" runat="server"></asp:Label>
                </td>
                <td align="right">
                    <asp:Label ID="Label9a" runat="server" Text="Printed: "></asp:Label>
                    <asp:Label ID="lblDatePrinted" runat="server" ></asp:Label>
                    <asp:Button ID="btnPrintForm" runat="server" CausesValidation="false" Text="Print Form" OnClientClick="javascript:alert('Not yet implemented');" /> 
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel1" GroupingText="Notification Letter Data" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="Date"></asp:Label>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox CssClass="form_field" ID="tbLTDateUpdate" Width="10em" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                    ID="ibtbLTDateUpdate" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <ajaxToolkit:CalendarExtender ID="ceLTDateUpdate" runat="server" TargetControlID="tbV"
                        Format="MM/dd/yyyy" PopupButtonID="ibIssuedUpdate" />
                    <asp:RegularExpressionValidator ForeColor="Red" ID="revLTDateUpdate" Display="Dynamic"
                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                        ControlToValidate="tbLTDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                </td>
            </tr>
        </table>
    </asp:Panel>
        <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnSellRequestUpdate" OnClick="btnSellRequest_Click" OnClientClick="javascript: return true;" runat="server" Text="Submit" />
        <asp:Label ID="lblSellRequestUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
