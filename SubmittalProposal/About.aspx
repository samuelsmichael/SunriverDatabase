﻿<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="SubmittalProposal.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Release notes
    </h2>
    <ul>
       <li>
       The top panel allows users to make certain selection criteria. The criteria act like the LIKE 
       command in SQL.  Thus, if you key in MI for the Owner's Name field, then you'll get
       all records that have "mi" anywhere.  You can test this ... but note that
       for the purposes of this demonstration, all the fields are simple text fields. Keep this in
       mind if you try to filter by a date field.
       </li>
       <li>
       The middle panel defaults to showing all of the rows; and then is filtered by the selection panel.
       Note the following:
       <ul>
            <li>I am just showing a few fields here for demonstration purposes.  In the live
                 system we will show all or any fields that you like.
            </li>
            <li>
                You will be able to sort on any field.
            </li>
            <li>There will be scroll bars both vertically 
       as well as horizontally, as necessary.
            </li>
            <li>
                The color scheme is, of course, configurable.
            </li>
            <li>
            When the user presses the select link, then the bottom panel -- the Form Panel opens.
            </li>
       </ul>
       
       </li>
       <li>
       The Form Panel will ressemble your current form.  I have just thrown something together here
       so that we can discuss this "Expandable Panels" paradigm.
       </li>
    </ul>
</asp:Content>
