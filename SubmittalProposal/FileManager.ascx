<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileManager.ascx.cs"
    Inherits="SubmittalProposal.FileManager" %>    
    
    <asp:Panel ID="pnlPhotos" runat="server" Width="100%" style="height:244px; overflow:auto; padding-bottom: 1em;">
        <asp:DataList ID="RepeaterImagesJD" RepeatDirection="Horizontal" runat="server" onitemdatabound="RepeaterImagesJD_ItemDataBound" 
            >
            <ItemTemplate>
                <asp:Panel runat="server" style="border:1 thin black;" ID="jdidpanel">
                    <table>
                        <tr>
                            <td align="center"><asp:Image style="padding:5px;" ID="Image" runat="server" ImageUrl= Height="125"  />
                            </td>
                        </tr>
                        <tr>
                            <td align="center">   
                                <asp:Label ID="lbName"  runat="server" ></asp:Label>
                            </td>                            
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:CheckBox ID="cbSelect" TextAlign="Left" CssClass='<%# Container.DataItem %>' Text="Select" runat="server" />
                            </td>
                        </tr>
                    </table>                    
                    
                    
                </asp:Panel>
            </ItemTemplate>
        </asp:DataList>
    </asp:Panel>
<br />
<center><asp:Button ID="btnUnlink" ToolTip="Unlinking doesn't delete the photo, it just disassociates it with this item." Text="Unlink selected items" runat="server" OnClientClick="return true;" OnClick="btnUnlink_Click" /></center>
<center><asp:Button style="margin-top:5px;" ID="btnOpen" ToolTip="Open the item" Text="Open selected items" runat="server" OnClientClick="return true;" OnClick="btnOpen_Click" /></center>
<center><asp:Label style="margin-top:5px;" ID="wgaph333" runat="server" ForeColor="Green" Visible="false"></asp:Label></center>
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
