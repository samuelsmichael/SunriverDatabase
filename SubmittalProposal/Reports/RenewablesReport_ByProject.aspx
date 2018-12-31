    <%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="RenewablesReport_ByProject.aspx.cs" Inherits="SubmittalProposal.Reports.RenewablesReport_ByProject" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
        Project Name:   
        <asp:DropDownList ID="ddlProject" runat="server" DataTextField="ProjectName" DataValueField="ProjectName">
        </asp:DropDownList>

    </asp:Content>
