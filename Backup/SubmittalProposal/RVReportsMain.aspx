<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RVReportsMain.aspx.cs" Inherits="SubmittalProposal.RVReportsMain" %>
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
    <h2>RV Reports</h2>
    <p>
        <asp:LinkButton ID="lbSpaceInventory" runat="server" 
            onclick="lbSpaceInventory_Click">Space Inventory</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbSpacesEmpty" runat="server" 
            onclick="lbSpacesEmpty_Click">RV Spaces - Empty</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbMailingLabels" runat="server" 
            onclick="lbMailingLabels_Click">Mailing Labels</asp:LinkButton>
     </p>
     <hr />
     <h2>Billing Reports</h2>
    <p>
        <asp:LinkButton ID="lbPastDue" runat="server" 
            onclick="lbPastDue_Click">Past Due</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbRenewNow" runat="server" 
            onclick="lbRenewNow_Click">Renew Now</asp:LinkButton>
     </p>
    <p>
        <asp:LinkButton ID="lbBillingInfo" runat="server" 
            onclick="lbBillingInfo_Click">Billing Info</asp:LinkButton>
     </p>
     <hr />
     <h2>Procedures</h2>
    <p>
        <script type="text/javascript" language="javascript">
            function myFunction() {
                var x=false;
                if (confirm("If you press Okay, then all of your non-cancelled leases will be updated to paid NO") == true) {
                    if (confirm("Are you sure that you wish to proceed?") == true) {
                        x=true;
                    }
                } else {
                    x = false;
                }
                return x;
            }
        </script>
        <table cellpadding="3" cellspacing="">
            <tr>
                <td>        
                    <asp:LinkButton ID="lbUpdateAllLeasePaidToNo" runat="server" 
                         OnClientClick="javascript:return myFunction()"
                         OnClick="lbUpdateAllLeasePaidToNo_Click">Update all lease Paid to NO
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:Label ID="lblStatus" runat="server"  ForeColor="Green" Font-Bold="true" ></asp:Label>
                </td>
            </tr>
        </table>

     </p>
     <hr />
     <h2>Queries</h2>
    <p>
        <asp:LinkButton ID="lbCrossReference" runat="server" 
            onclick="lbCrossReference_Click">Cross Referrence</asp:LinkButton>
     </p>
</asp:Content>
