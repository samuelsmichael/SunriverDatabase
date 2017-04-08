<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="SubmittalProposal._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Welcome to Sunriver!
    </h2>
    <p>
        The databases that you are authorized to are shown as tabs in the menu bar.
    </p>
    <p>

        <asp:Button ID="Button1" runat="server" OnClick="https://app.smartsheet.com/b/form?EQBCT=b9a0aa4d70ea40278c433c2ad1704871" Text="Submit IT Ticket" /> ......................   

        <asp:Button ID="Button2" runat="server" OnClick="https://mail2.srowners.org/owa" Text="Outlook Online (OWA)" />


    </p>
    <p>
        <asp:Button ID="Button6" runat="server" OnClick="sroagis/" Text="SROA Database" /> ......................  
        <asp:Button ID="Button3" runat="server" OnClick="sroagis:2412/" Text="SROA Database Trainer" />
    </p>
    <p>
        <asp:Button ID="Button4" runat="server" OnClick="ativenet.active.com/sunriverowners/login" Text="Activenet" />......................
        <asp:Button ID="Button5" runat="server" OnClick="ativenet.active.com/sunriverownerstrainer/login" Text="Activenet Trainer" />    
    </p>    <p>
        Click on one of the tabs in order to open the database.
    </p>
</asp:Content>
