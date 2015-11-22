<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SubmittalProposal.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
        <asp:Button ID="btnClose" runat="server" OnClick="bbb" Text="Close" />
    
    </div>
    </form>

                            <asp:Button runat="server" ID="btndummyNewPart" Style="display: none" />
                            <asp:Panel runat="server" CssClass="newitempopup" ID="pnlLRFDPanelNewPart">
                                <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlLRFDPanelNewPartTitle">
                                    <span>New Part</span>
                                </asp:Panel>
                                <asp:Panel runat="server" Style="text-align: center;" ID="Panel6x12" CssClass="newitemcontent">
                                    <table>
                                        <tr>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Description"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbPartDescriptionNew" Width="17em" MaxLength="30" runat="server"></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label33" runat="server" Text="Part Number"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbPartNumberNew" Width="7em" MaxLength="15" runat="server"></asp:TextBox>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Labelx33" runat="server" Text="Cost"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox CssClass="form_field" ID="tbLRFDPartRateNew" Width="7em" runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbLRFDPartRateNew" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbLRFDPartRateNew" ValidationExpression="[0-9]+(\.[0-9][0-9]?)?" runat="server"
                                                    ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>
                                            </td>
                                            <td class="form_field_heading">
                                                <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Quantity"></asp:Label>
                                            </td>
                                            <td class="form_field">
                                                <asp:TextBox ID="tbRFDNewPartsPTQuantity" Width="45px" MaxLength="4"  runat="server"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revtbRFDNewPartsPTQuantity" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="tbRFDNewPartsPTQuantity" ValidationExpression="(?<![-.])\b[0-9]+\b(?!\.[0-9])" runat="server"
                                                    ErrorMessage="Must be numeric"></asp:RegularExpressionValidator>      
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <script language="javascript" type="text/javascript">
                                    function donewPartjedisok() {
                                        var loading = $(".loadingnewbpermit");
                                        loading.show();
                                        var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                                        var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                                        loading.css({ top: top, left: left });
                                        return true;
                                    }
                                </script>
                                <center>
                                    <table cellpadding="3">
                                        <tr>
                                            <td>
                                                <asp:Button CausesValidation="true" OnClientClick="javascript: return donewPartjedisok();" ID="btnNewLRFDPartOk"
                                                    runat="server" Text="Okay" OnClick="btnNewLRFDPartOk_Click" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnNewLRFDPartCancel" OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                                    runat="server" Text="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                            </asp:Panel>
                            <ajaxToolkit:ModalPopupExtender ID="mpeLRFDNewPart" runat="server" TargetControlID="btndummyNewPart"
                                PopupControlID="pnlLRFDPanelNewPart" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlLRFDPanelNewPartTitle"
                                BehaviorID="jdpopupbLRFDnewPart" />
</body>
</html>
