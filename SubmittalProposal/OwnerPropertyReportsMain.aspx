<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OwnerPropertyReportsMain.aspx.cs" Inherits="SubmittalProposal.OwnerPropertyReportsMain" %>
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
        </center>
    </p>
    <h2>Owner/Property Reports</h2>
    
    <table cellpadding="6" cellspacing="6">
        <tr>
            <td>
                <asp:LinkButton ID="lbEnvelopes" runat="server" 
                    onclick="lbEnvelopes_Click">Envelopes</asp:LinkButton>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
     </table>
</asp:Content>
