<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="AllInfoCrystalReportsPage.aspx.cs" Inherits="SubmittalProposal.Reports.AllInfoCrystalReportsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
    <center><h3>All Property Info</h3></center>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Lot"></asp:Label>
    <asp:TextBox CssClass="form_field" ID="tbLot" runat="server" Width="8em"></asp:TextBox>
    <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Lane"></asp:Label>
    <asp:DropDownList ID="ddlLane" Width="100" runat="server" DataTextField="Lane" DataValueField="Lane">
    </asp:DropDownList>

</asp:Content>

