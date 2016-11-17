<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PhotoManager.ascx.cs"
    Inherits="SubmittalProposal.PhotoManager" %>
    <asp:Panel ID="pnlPhotos" runat="server" Width="100%" style="height:204px; overflow:auto; padding-bottom: 1em;">
        <asp:Repeater ID="RepeaterImages" runat="server" >
            <ItemTemplate>
                <asp:Image style="padding:5px;" ID="Image" runat="server" ImageUrl='<%# Container.DataItem %>' Height="200"  />
            </ItemTemplate>
        </asp:Repeater>
    </asp:Panel>
<asp:Panel ID="pnlControl" runat="server" GroupingText="Add a file">
    <asp:UpdatePanel ID="photomanagerupdatePanel" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
        <ContentTemplate>
            <asp:FileUpload ID="FileUploadControl" runat="server" />
            <br />
            <asp:Label ID="StatusLabel" runat="server" ForeColor="Green" />
            <asp:Button ID="btnSave" Text="Upload" runat="server" OnClick="UploadButton_Click"
                Style="display: none;" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Panel>
