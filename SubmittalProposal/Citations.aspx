﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
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
                <td><asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Sunriver Status"></asp:Label></td>
                <td colspan="3">
                    <asp:DropDownList ID="ddlSunriverStatusUpdate" DataTextField="FineStatus" DataValueField="FineStatus" runat="server">
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
                <td><asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="City"></asp:Label></td>
                <td><asp:TextBox ID="tbCitationsCityUpdate" MaxLength="20" Width="15em" runat="server"></asp:TextBox></td>
                <td align="right"><asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="State"></asp:Label></td>
                <td><asp:TextBox ID="tbCitationsStateUpdate" MaxLength="2" Width="3em" runat="server"></asp:TextBox></td>
                <td><asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Zip"></asp:Label></td>
                <td><asp:TextBox ID="tbCitationsZipUpdate" MaxLength="10" Width="6em" runat="server"></asp:TextBox></td>
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
