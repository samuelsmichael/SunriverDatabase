<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.Master" AutoEventWireup="true"
    CodeBehind="ITAdmin.aspx.cs" Inherits="SubmittalProposal.ITAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <center><h2>IT Admin</h2></center>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <h2>
                Reports</h2>
            <p>
                <asp:LinkButton ID="lbPastDue" runat="server" OnClick="lbPastDue_Click">Some Report</asp:LinkButton>
            </p>
            <hr />
            <h2>
                Procedures</h2>
            <p>
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
            <h2>
                Queries</h2>
            <p>
                <asp:LinkButton ID="lbCrossReference" runat="server" OnClick="lbCrossReference_Click">Some Query</asp:LinkButton>
            </p>
            <hr />
            <h2>
                Miscellaneous</h2>
            <p>
                <asp:LinkButton ID="lbSecurityMaintenance" runat="server" OnClick="lbSecurityMaintenance_Click">Security Admin</asp:LinkButton>
            </p>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
