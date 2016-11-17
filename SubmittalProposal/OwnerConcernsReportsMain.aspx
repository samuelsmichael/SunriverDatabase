<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OwnerConcernsReportsMain.aspx.cs" Inherits="SubmittalProposal.OwnerConcernsReportsMain" %>
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
    <h2>Reports</h2>
    <p>
        <asp:LinkButton ID="lbOwnerConcernReports" runat="server" 
            onclick="lbOwnerConcernReports_Click">Reports</asp:LinkButton>
     </p>
     <hr />
     <h2>Queries</h2>
    <p>
        <asp:LinkButton ID="lbOwnerConcernQueries" runat="server" 
            onclick="lbOwnerConcernQueries_Click">Owner Concerns</asp:LinkButton>
     </p>
</asp:Content>
