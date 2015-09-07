<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SellCheckReportsMain.aspx.cs" Inherits="SubmittalProposal.SellCheckReportsMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        <center>
            <h2>Submittal Reports</h2>
        </center>
    </p>
    <p>
        <asp:LinkButton ID="lbFeesDue" runat="server" 
            onclick="lbFeesDue_Click">Fees Due</asp:LinkButton>
     </p>
     <p>
        <asp:LinkButton ID="lbSellCheckList" runat="server" 
            onclick="lbSellCheckList_Click">Sell Check List</asp:LinkButton>
    </p>
     <p>
        <asp:LinkButton ID="lbSellCheckLetter" runat="server" 
            onclick="lbSellCheckLetter_Click">Sell Check Letter</asp:LinkButton>
    </p>
     <p>
        <asp:LinkButton ID="lbSellCheckHistory" runat="server" 
            onclick="lbSellCheckHistory_Click">Sell Check History</asp:LinkButton>
    </p>
     <p>
        <asp:LinkButton ID="lbSellCheck" runat="server" 
            onclick="lbSellCheck_Click">Sell Check</asp:LinkButton>
    </p>

</asp:Content>
