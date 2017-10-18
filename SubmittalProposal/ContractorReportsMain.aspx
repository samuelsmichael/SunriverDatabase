<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContractorReportsMain.aspx.cs" Inherits="SubmittalProposal.ContractorReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>Contractor Reports</h2>
        </center>
    </p>
    <p>
        <asp:LinkButton ID="lbContractorsByCategory" runat="server" 
            onclick="lbContractorsByCategory_Click">Contractors by Category</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbContractorsAllData" runat="server" 
            onclick="lbContractorsAllData_Click">Contractors All Data</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbContractorsList" runat="server" 
            onclick="lbContractorsList_Click">Contractors List</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbCategoryList" runat="server" 
            onclick="lbCategoryList_Click">Category List</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbContractorEnvelope" runat="server" 
            onclick="lbContractorEnvelope_Click">Contractor Envelope</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbContractorMailingLabels" runat="server" 
            onclick="ContractorMailingLabels_Click">Contractor Mailing Labels</asp:LinkButton>
    </p>
    <p>
        <center>
            <h2>Contractor CSVs</h2>
        </center>
    <p>
        <asp:LinkButton ID="lbContractorMailingLabelsCSV" runat="server" 
            onclick="ContractorMailingLabelsCSV_Click">Contractor Mailing Labels CSV</asp:LinkButton>
    </p>
    </p>
</asp:Content>
