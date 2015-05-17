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
</asp:Content>
