﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true"
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
    <p>
        2.02.0.1 -- 05/31/17<br />
        Citations -- <br />
        New Citations<br />
        --Changed Tab Order, Created on Focus<br />
        Reports:<br />
        --Turned to landacape Citations Open, Citations Closed,Citations Fine Summary, Vegitation, Parking Violation, Design Violation, Design Rules Summary.<br />
        <br />
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
</asp:Content>
