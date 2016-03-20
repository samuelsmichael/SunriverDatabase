<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.Master" AutoEventWireup="true"
    CodeBehind="ITAdmin.aspx.cs" Inherits="SubmittalProposal.ITAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
                        return confirm("If you press Okay, then blah blah blah (the procedure will run). Are you sure that you wish to proceed?")
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
                </table>
            </p>
            <hr />
            <h2>
                Queries</h2>
            <p>
                <asp:LinkButton ID="lbCrossReference" runat="server" OnClick="lbCrossReference_Click">Some Query</asp:LinkButton>
            </p>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
