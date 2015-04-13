<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BPermitReportsMain.aspx.cs" Inherits="SubmittalProposal.BPermitReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>Building Permit Reports</h2>
        </center>
    </p>
    <p>
        <asp:LinkButton ID="lbBPermitsIssued" runat="server" 
            onclick="lbBPermitsIssued_Click">Building Permits Issued</asp:LinkButton>
    </p>
</asp:Content>
