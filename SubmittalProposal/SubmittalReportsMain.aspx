﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmittalReportsMain.aspx.cs" Inherits="SubmittalProposal.SubmittalReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>Submittal Reports</h2>
        </center>
    </p>
    <p>
        <asp:LinkButton ID="lbAdministrativeApproval" runat="server" 
            onclick="lbAdministrativeApproval_Click">Administrative Approval</asp:LinkButton>
     </p>
     <p>
        <asp:LinkButton ID="lbHistoryLotLane" runat="server" 
            onclick="lbHistoryLotLane_Click">History Lot/Lane</asp:LinkButton>
    </p>
     <p>
        <asp:LinkButton ID="lbSubmittalStatus" runat="server" 
            onclick="lbSubmittalStatus_Click">Submittal Status</asp:LinkButton>
    </p>
</asp:Content>
