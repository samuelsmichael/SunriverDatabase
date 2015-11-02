<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="RVRenewNow2.aspx.cs" Inherits="SubmittalProposal.Reports.RVRenewNow2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table cellpadding="2" cellspacing="2">
        <tr >
            <td>Enter Cutoff month:</td>
                <td>
                    <asp:TextBox ID="tbPastDueMonth" runat="server" Width="3em" MaxLength="12"></asp:TextBox>
                </td>
                    <asp:Label ID="lbError" runat="server"  Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
                <td>
                </td>
        </tr>
    </table>
</asp:Content>
