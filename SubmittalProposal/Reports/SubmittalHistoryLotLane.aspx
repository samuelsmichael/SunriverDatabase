﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="SubmittalHistoryLotLane.aspx.cs" Inherits="SubmittalProposal.Reports.SubmittalHistoryLotLane" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Lot/Lane"></asp:Label>
            <asp:DropDownList ID="ddlSubmittalHistoryLotLane" runat="server" DataTextField="LotLaneDisplay" DataValueField="LotLaneKey" >
            </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>