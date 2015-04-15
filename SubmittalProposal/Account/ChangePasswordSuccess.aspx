<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="ChangePasswordSuccess.aspx.cs" Inherits="SubmittalProposal.Account.ChangePasswordSuccess" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Change Password
    </h2>
    <p>
        Your password has been changed successfully.
    </p>
    <p class="submitButton" style="text-align:center;">
        <asp:LinkButton ID="LinkButton1" PostBackUrl="~/Default.aspx" runat="server">Continue</asp:LinkButton>
    </p>
</asp:Content>
