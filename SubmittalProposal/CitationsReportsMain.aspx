<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CitationsReportsMain.aspx.cs" Inherits="SubmittalProposal.CitationsReportsMain" %>
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
    <h2>Citations Reports</h2>
    <p>
        <asp:LinkButton ID="lbHearingCalendar" runat="server" 
            onclick="lbHearingCalendar_Click">Hearing Calendar</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbCitationsOpen" runat="server" 
            onclick="lbCitationsOpen_Click">Citations Open</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="LinkButton1" runat="server" 
            onclick="lbCitationsClosed_Click">Citations Closed</asp:LinkButton>
     </p>

</asp:Content>
