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
    <p>
        <asp:LinkButton ID="lbBPermitsClosed" runat="server" 
            onclick="lbBPermitsClosed_Click">Building Permits Closed</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbBPermitsOpen" runat="server" 
            onclick="lbBPermitsOpen_Click">Building Permits Open</asp:LinkButton>
    </p>
    <p>
        <asp:LinkButton ID="lbBPermitsExpired" runat="server" 
            onclick="lbBPermitsExpired_Click">Building Permits Expired</asp:LinkButton>
    </p>
</asp:Content>
