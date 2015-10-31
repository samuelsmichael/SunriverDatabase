<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="RVPastDue.aspx.cs" Inherits="SubmittalProposal.Reports.RVLease.RVPastDue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table cellpadding="2" cellspacing="2">
        <tr >
            <td>Enter Cutoff month:</td>
            <td><asp:TextBox runat="server" ID="tbPastDueMonth" Width="3em" MaxLength="12"></asp:TextBox></td>
            <td><asp:Label runat="server" ID="lbError" Text="" Font-Bold="true" ForeColor="Red"></asp:Label></td>
        </tr>
    </table>
    
</asp:Content>
