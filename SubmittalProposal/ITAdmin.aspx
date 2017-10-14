<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.Master" AutoEventWireup="true"
    CodeBehind="ITAdmin.aspx.cs" Inherits="SubmittalProposal.ITAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <center><h2>IT Admin</h2></center>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <h2 style="margin-top:-4px;">
                Reports</h2>
            <p style="margin-top:-4px;">
                <asp:LinkButton ID="lbPastDue" runat="server" OnClick="lbPastDue_Click">Some Report</asp:LinkButton>
            </p>
            <hr />
            <h2 style="margin-top:-4px;">
                Procedures</h2>
            <p style="margin-top:-4px;">
                <script type="text/javascript" language="javascript">
                    function myFunction() {
                        return confirm("If you press Okay, then such-and-such procedure will run. Are you sure that you wish to proceed?")
                    }
                </script>
                <table cellpadding="3" cellspacing="">
                    <tr>
                        <td>
                            <asp:LinkButton ID="lbRunSomeProcedure" runat="server" OnClientClick="javascript:return myFunction()"
                                OnClick="lbRunSomeProcedure_Click">Run some procedure
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:Label ID="lblRunSomeProcedureStatus" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>        
                            <asp:LinkButton ID="lbIDCardMaintenanceClearComments" runat="server" 
                                OnClientClick="javascript: if (confirm('WARNING! This will clear all of the comments in the Card table. Are you sure that you wish to continue?')) {return true;} else {return false;}"
                                onclick="lbCardMaintenanceClearComments_Click">ID Card Management - Clear Comments</asp:LinkButton>
                        </td>
                        <td><asp:Label ID="lblIdCardMaintenanceClearCommentsResult" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="lbInitializeBallotVerify" runat="server" 
                                OnClientClick="javascript: if (confirm('WARNING! This will clear all of the records in the BallotVerify table. Are you sure that you wish to continue?')) {return true;} else {return false;}"
                                onclick="lbInitializeBallotVerify_Click">Initialize Ballot Verify</asp:LinkButton>
                        </td>
                        <td><asp:Label ID="lblInitializeBallotVerifyCommentsResult" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label></td>
                    </tr>
                </table>
            </p>
            <hr />
            <h2 style="margin-top:-4px;">
                Queries</h2>
            <p style="margin-top:-4px;">
                <asp:LinkButton ID="lbCrossReference" runat="server" OnClick="lbCrossReference_Click">Some Query</asp:LinkButton>
            </p>
            <hr />
            <h2 style="margin-top:-4px;">
                Miscellaneous</h2>
            <p style="margin-top:-4px;">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                <asp:Button ID="btnClearCache" runat="server" Text="Clear data cache" 
                    onclick="btnClearCache_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                <asp:LinkButton ID="lbSecurityMaintenance" runat="server" OnClick="lbSecurityMaintenance_Click">Security Admin</asp:LinkButton>
                        </td>
                    </tr>
                </table>

            </p>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
