<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
    CodeBehind="RenewablesReportsMain.aspx.cs" Inherits="SubmittalProposal.RenewablesReportsMain" %>
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
    <h2>Renewables Reports</h2>
    
    <table cellpadding="6" cellspacing="6">
        <tr>
            <td>
                <asp:LinkButton ID="lbByProjectName" runat="server" 
                    onclick="lbByProjectName_Click">By Project</asp:LinkButton>
            </td>
        </tr>
     </table>
</asp:Content>
