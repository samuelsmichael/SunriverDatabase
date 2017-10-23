<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="ComplianceReviewHistory.aspx.cs" Inherits="SubmittalProposal.Reports.ComplianceReviewHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td width="40">
                <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
                <asp:TextBox ID="tbLot" Width="40" MaxLength="5" runat="server"></asp:TextBox>
            </td>
            <td width="100">
                <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
                <asp:DropDownList ID="ddlLane" runat="server" DataTextField="Lane" DataValueField="Lane">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
