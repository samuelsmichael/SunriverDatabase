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

        <asp:Button ID="Button1" runat="server"  PostBackUrl="https://app.smartsheet.com/b/form?EQBCT=b9a0aa4d70ea40278c433c2ad1704871" Text="Submit IT Ticket" /> ......................   

        <asp:Button ID="Button2" runat="server" PostBackUrl="https://mail2.srowners.org/owa" Text="Outlook Online (OWA)" />


    </p>
    <p>
        <asp:Button ID="Button6" runat="server" PostBackUrl="sroagis/" Text="SROA Database" /> ......................  
        <asp:Button ID="Button3" runat="server" PostBackUrl="sroagis:2412/" Text="SROA Database Trainer" />
    </p>
    <p>
        <asp:Button ID="Button4" runat="server" PostBackUrl="ativenet.active.com/sunriverowners/login" Text="Activenet" />......................
        <asp:Button ID="Button5" runat="server" PostBackUrl="ativenet.active.com/sunriverownerstrainer/login" Text="Activenet Trainer" />    
    </p>    <p>
        Click on one of the tabs in order to open the database.
    </p>
    <p style="font-weight:bold;">
        2.10 -- 01/2018
    </p>
        <ul style="font-size:x-small;font-weight:bold;margin-top:-8px;">
        
<li>Enhancement: You can work with Submittal records that don't have Project Type.</li>
</ul>
</asp:Content>
