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
    
    <table cellpadding="6" cellspacing="6">
        <tr>
            <td>
                <asp:LinkButton ID="lbHearingCalendar" runat="server" 
                    onclick="lbHearingCalendar_Click">Hearing Calendar</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbFineSummary" runat="server" 
                    onclick="lbFineSummary_Click">Fine Summary</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbORSViolationSummary" runat="server" 
                    onclick="lbORSViolationSummary_Click">Violations - ORS</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lbCitationsOpen" runat="server" 
                    onclick="lbCitationsOpen_Click">Citations Open</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbRuleSummary" runat="server" 
                    onclick="lbRuleSummary_Click">Rule Summary</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbORSWarningSummary" runat="server" 
                    onclick="lbORSWarningSummary_Click">Warnings - ORS</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lbCitationsClosed" runat="server" 
                    onclick="lbCitationsClosed_Click">Citations Closed</asp:LinkButton>

            </td>
            <td>
                <asp:LinkButton ID="lbDesignSummary" runat="server" 
                    onclick="lbDesignSummary_Click">Design Summary</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbParkingViolations" runat="server" 
                    onclick="lbParkingViolations_Click">Parking Violations</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lbFineWriteoff" runat="server" 
                    onclick="lbFineWriteoff_Click">Fine Writeoff</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbVegetation" runat="server" 
                    onclick="lbVegetation_Click">Vegetation</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbParkingWarningSummary" runat="server" 
                    onclick="lbParkingWarningSummary_Click">Parking Warnings</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lbBalancesToAcctg" runat="server" 
                    onclick="lbBalancesToAcctg_Click">Balances to Acctg</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbViolatorHistory" runat="server" 
                    onclick="lbViolatorHistory_Click">Violator History</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbDesignRuleFines" runat="server" 
                    onclick="lbDesignRuleFines_Click">Design Rule - Fines</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <asp:LinkButton ID="lbDesignRuleWarnings" runat="server" 
                    onclick="lbDesignRuleWarnings_Click">Design Rule - Warnings</asp:LinkButton>
            </td>
        </tr>
     </table>
</asp:Content>
