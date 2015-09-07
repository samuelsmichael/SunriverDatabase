<%@ Page Title="" Language="C#" MasterPageFile="~/Reports/Reports.Master" AutoEventWireup="true" CodeBehind="SellCheckHistory.aspx.cs" Inherits="SubmittalProposal.Reports.SellCheckHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Heading" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderReportParms" runat="server">
    <table>
        <tr>
            <td>
                    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Lot:"></asp:Label>
                    <asp:TextBox CssClass="form_field" ID="tbLot" Width="4em" runat="server"></asp:TextBox>
            </td>
            <td>
                    <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Lane:"></asp:Label>
                    <asp:DropDownList ID="ddlLane" Width="100" runat="server" DataTextField="Lane" DataValueField="Lane"></asp:DropDownList>

            </td>
        </tr>
    </table>

</asp:Content>
