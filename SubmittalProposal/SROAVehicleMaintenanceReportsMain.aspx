<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SROAVehicleMaintenanceReportsMain.aspx.cs" Inherits="SubmittalProposal.SROAVehicleMaintenanceReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>SROA Vehicle Maintenance Reports</h2>
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
            onclick="lbLapineRFDVehicles_Click">SROA Vehicles</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbLapineRFDInvoices" runat="server" 
            onclick="lbLapineRFDInvoices_Click">SROA Invoices</asp:LinkButton>
    </p>    
    <p>
        <asp:LinkButton ID="lbPrintBlankWO" runat="server" 
            onclick="lbPrintBlankWO_Click">Blank Work Order</asp:LinkButton>
    </p>    

</asp:Content>
