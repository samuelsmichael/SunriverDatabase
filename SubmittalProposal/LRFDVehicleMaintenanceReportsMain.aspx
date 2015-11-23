﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LRFDVehicleMaintenanceReportsMain.aspx.cs" Inherits="SubmittalProposal.LRFDVehicleMaintenanceReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>LRFD Vehicle Maintenance Reports</h2>
        </center>
    </p>
    <p>
        <asp:LinkButton ID="lbVehicleMaintenanceHistory" runat="server" 
            onclick="lbVehicleMaintenanceHistory_Click">Vehicle Maintenance History</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbShopActivity" runat="server" 
            onclick="lbShopActivity_Click">Shop Activity</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbMechanicActivity" runat="server" 
            onclick="lbMechanicActivity_Click">Mechanic Activity</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbLapineRFDVehicles" runat="server" 
            onclick="lbLapineRFDVehicles_Click">Lapine RFD Vehicles</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbLapineRFDInvoices" runat="server" 
            onclick="lbLapineRFDInvoices_Click">Lapine RFD Invoices</asp:LinkButton>
    </p>    
</asp:Content>
