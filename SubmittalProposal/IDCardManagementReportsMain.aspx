﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IDCardManagementReportsMain.aspx.cs" Inherits="SubmittalProposal.IDCardManagementReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p style="width:100%">
        <center>
            <table width="100%">
                <tr>
                    <td width="10%"></td>
                    <td>                
                    <td align="right">
                        <asp:LinkButton style="font-size:smaller;" CausesValidation="false" ID="lbHome"  runat="server" onclick="lbHome_Click">Home</asp:LinkButton>
                    </td>
                    <td width="10%"></td>
                    </td>
                </tr>
            </table>
            <h2>ID Card Maintenance Procedures</h2>
        </center>
    </p>

    <p>
        <asp:LinkButton ID="lbIDCardMaintenanceClearComments" runat="server" 
            OnClientClick="javascript: if (confirm('WARNING! This will clear all of the comments in the Card table. Are you sure that you wish to continue?')) {return true;} else {return false;}"
            onclick="lbCardMaintenanceClearComments_Click">Clear Comments</asp:LinkButton>
    </p>
    <p>
        <asp:Label ID="lblClearCommentsResults" runat="server" Visible="false" Text="Comments have been cleared." ForeColor="Green" Font-Bold="true"></asp:Label>
    </p>

</asp:Content>
