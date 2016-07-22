<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true"
    CodeBehind="BallotVerify_Query.aspx.cs" Inherits="SubmittalProposal.Reports.BallotVerify_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <div style="border: thin solid black;">
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Voted:"></asp:Label>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rblVoted" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Enabled="true" Selected="True" Text="Voted" Value="Yes"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Selected="False" Text="Not Voted" Value="No"></asp:ListItem>
                                    <asp:ListItem Enabled="true" Selected="False" Text="Either" Value="Either"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <asp:Panel ID="pnlType" runat="server">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Area:"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlArea" runat="server">
                                        <asp:ListItem Enabled="true" Text="All" Value="All"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Text="California" Value="ca"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Text="Oregon" Value="or"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Text="Washington" Value="wa"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Text="USA-Other" Value="usa"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Text="Sunriver" Value="sunriver"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Text="No zip" Value="nozip"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
