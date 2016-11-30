<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PDFsPage.aspx.cs" Inherits="SubmittalProposal.PDFsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HyperLink style="float:right;font-size:x-small;" ID="HyperLink1" NavigateUrl="~/Default.aspx" runat="server">Home</asp:HyperLink>
    <asp:HiddenField ID="hfRootDirectory" runat="server" />
    <center><h2><asp:Label runat="server" ID="lblPDFsPageHeading" /></h2></center>
    <asp:Panel ID="pnlPDFs" runat="server" Width="100%" style="height:450px; overflow:auto; padding-bottom: 1em;">
        <asp:Repeater ID="RepeaterPDFs" runat="server" 
            onitemdatabound="RepeaterPDFs_ItemDataBound"  >
            <ItemTemplate>
                <table cellpadding="3" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <asp:ImageButton ID="ibPDFFile" ImageUrl="~/Images/PDFImage.png" runat="server" />
                        </td>
                        <td>
                            <asp:LinkButton ID="lbPDFFile" OnClick="lbPDFFile_OnClick"  runat="server"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
    </asp:Panel>
    
</asp:Content>
