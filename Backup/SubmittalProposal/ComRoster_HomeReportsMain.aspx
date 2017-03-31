<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ComRoster_HomeReportsMain.aspx.cs" Inherits="SubmittalProposal.ComRoster_HomeReportsMain" %>
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
                <asp:LinkButton ID="lbCommitteeData" runat="server" 
                    onclick="lbCommitteeData_Click">Committee Data</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbChairPersonList" runat="server" 
                    onclick="lbChairPersonList_Click">Chair Person List</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbComRosters" runat="server" 
                    onclick="lbCommitteeRosters_Click">Committee Rosters</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="lbOneRoster" runat="server" 
                    onclick="lbOneRoster_Click">One Roster</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbExpiringTerms" runat="server" 
                    onclick="lbExpiringTerms_Click">Expiring Terms</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="lbCommitteeListAll" runat="server" 
                    onclick="lbCommitteeListAll_Click">Committee List - All</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
