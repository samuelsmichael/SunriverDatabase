<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ComplianceReviewReportsMain.aspx.cs" Inherits="SubmittalProposal.ComplianceReviewReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>Compliance Review Reports</h2>
        </center>
    </p>
    <p>
        <asp:LinkButton ID="lbComplianceHistory" runat="server" 
            onclick="lbComplianceHistory_Click">Compliance History</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbComplianceReviewsOpen" runat="server" 
            onclick="lbComplianceReviewsOpen_Click">Compliance Reviews Open</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbComplianceReviewsSummary" runat="server" 
            onclick="lbComplianceReviewsSummary_Click">Compliance Reviews Summary</asp:LinkButton>
    </p>
</asp:Content>
