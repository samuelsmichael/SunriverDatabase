<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RVReportsMain.aspx.cs" Inherits="SubmittalProposal.RVReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>Submittal Reports</h2>
        </center>
    </p>
    <p>
        <asp:LinkButton ID="lbSpaceInventory" runat="server" 
            onclick="lbSpaceInventory_Click">Space Inventory</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbSpacesEmpty" runat="server" 
            onclick="lbSpacesEmpty_Click">RV Spaces - Empty</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbMailingLabels" runat="server" 
            onclick="lbMailingLabels_Click">Mailing Labels</asp:LinkButton>
     </p>
     <hr />
     <h2>Billing Reports</h2>
    <p>
        <asp:LinkButton ID="lbPastDue" runat="server" 
            onclick="lbPastDue_Click">Past Due</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbRenewNow" runat="server" 
            onclick="lbRenewNow_Click">Renew Now</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbBillingInfo" runat="server" 
            onclick="lbBillingInfo_Click">Billing Info</asp:LinkButton>
     </p>
</asp:Content>
