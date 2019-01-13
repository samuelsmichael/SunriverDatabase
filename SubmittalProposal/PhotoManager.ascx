<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PhotoManager.ascx.cs"
    Inherits="SubmittalProposal.PhotoManager" %>    
    
    <asp:Panel ID="pnlPhotos" runat="server" Width="100%" style="height:244px; overflow:auto; padding-bottom: 1em;">
        <asp:DataList ID="RepeaterImagesJD" RepeatDirection="Horizontal" runat="server" onitemcommand="RepeaterImagesJD_ItemCommand1" 
            >
            <ItemTemplate>
                <asp:Panel runat="server" style="border:1 thin black;" ID="jdidpanel">
                    <table>
                        <tr>
                            <td align="center"><asp:Image style="padding:5px;" ID="Image" runat="server" ImageUrl='<%# Container.DataItem %>' Height="200"  />
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:CheckBox ID="cbSelect" TextAlign="Left" Visible='<%# IsLinkVisible%>' CssClass='<%# Container.DataItem %>' Text="select" runat="server" />
                            </td>
                        </tr>
                    </table>                    
                    
                    
                </asp:Panel>
            </ItemTemplate>
        </asp:DataList>
    </asp:Panel>
<br />
<center><asp:Button ID="btnUnlink" ToolTip="Unlinking doesn't delete the photo, it just disassociates it with this item." Text="Unlink selected images" runat="server" OnClientClick="return true;" OnClick="btnUnlink_Click" /></center>
<center><asp:Label ID="wgaph333" runat="server" ForeColor="Green" Visible="false"></asp:Label></center>
<br />
<asp:Panel ID="pnlControl" runat="server" GroupingText="Add a file">
    <asp:UpdatePanel ID="photomanagerupdatePanel" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
        <ContentTemplate>
            <asp:FileUpload ID="FileUploadControl" runat="server" />
            <br />
            <asp:Label ID="StatusLabel" runat="server" ForeColor="Green" />
            <asp:Button ID="btnSave" Text="Upload" runat="server" OnClientClick="return true;" OnClick="UploadButton_Click"
                Style="display: none;" />
            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Panel>
