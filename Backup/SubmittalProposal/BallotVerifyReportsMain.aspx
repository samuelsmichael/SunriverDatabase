<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="BallotVerifyReportsMain.aspx.cs" Inherits="SubmittalProposal.BallotVerifyReportsMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p style="width: 100%">
        <center>
            <table width="100%">
                <tr>
                    <td width="10%">
                    </td>
                    <td>
                        <td align="right">
                            <asp:LinkButton Style="font-size: smaller;" CausesValidation="false" ID="lbHome"
                                runat="server" OnClick="lbHome_Click">Home</asp:LinkButton>
                        </td>
                        <td width="10%">
                        </td>
                    </td>
                </tr>
            </table>
        </center>
    </p>
    <h2>
        Ballot Verify Reports</h2>
    <asp:Panel runat="server" ID="pnlReportsBlock" GroupingText="Block Votes" Style="padding: 8px; border: thin solid black;">
        <table cellpadding="6" cellspacing="6">
            <tr>
                <td>
                    <asp:LinkButton ID="lbTheRidge" runat="server" OnClick="lbCBBlockVotes_Ridge_Click">The Ridge</asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="lbSrResort" runat="server" OnClick="lbCBBlockVotes_SRResort_Click">SR Resort</asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="lbThePines" runat="server" OnClick="lbThePines_Click">The Pines</asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlBallotVerifyQueries" GroupingText="Other Queries" Style="padding: 8px; border: thin solid black;">
        <table cellpadding="6" cellspacing="6">
            <tr>
                <td>
                    <asp:LinkButton ID="lbSortedByZip" runat="server" OnClick="lbSortedByZip_Click">Sorted by Zip</asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
