<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="ComRoster_HomeReport_OneRoster.aspx.cs" Inherits="SubmittalProposal.Reports.ComRoster_HomeReport_OneRoster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <center><table>
        <tr>
            <td>
                <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="CommitteeID"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlComRoster_HomeReport_OneRosterCommitteeLU" DataTextField="CommitteeName" DataValueField="CommitteeID"
                    runat="server">
                </asp:DropDownList>
            </td>
        </tr>
    </table></center>
</asp:Content>
