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

                    <tr>
                        <td>Service</td>
                        <td>
                            <div style="overflow:auto;height:6em;">

                                <asp:GridView Width="100%" ID="gvRFDUpdateService" runat="server" AutoGenerateColumns="False"
                                    CellPadding="1" ForeColor="#333333" GridLines="None" ShowFooter="true" 
                                    OnRowCancelingEdit="gvUpdateService_RowCancelingEdit"
                                    OnRowEditing="gvUpdateService_RowEditing" Font-Size="X-Small"
                                    OnRowUpdating="gvUpdateService_RowUpdating" DataKeyNames="VWOCtrServID">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                    <EmptyDataTemplate>
                                        <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
                                    </EmptyDataTemplate>                                    
                                    <Columns>
                                        <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true"
                                            ShowCancelButton="true" />
                                        <asp:TemplateField HeaderText="Description" SortExpression="CSDescription">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdd3" runat="server" Text='<%# Bind("CSDescription") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbRFDUpdateServiceDescription" runat="server" Text= '<%# Bind("CSDescription") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vendor" SortExpression="CSVendor">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xdd3" runat="server" Text='<%# Bind("CSVendor") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbRFDUpdateServiceVendor" runat="server" Text= '<%# Bind("CSVendor") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>Total Contracted Services:</FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cost" SortExpression="CSCost">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3xddx3" runat="server" Text='<%# Eval("CSCost","{0:c}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="tbRFDUpdateLaborMechRate" runat="server" Text= ''<%# Eval("CSCost","{0:c}") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblX102" runat="server" Text='<%# getTotalServicesCost() %>'></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="VWOCtrServID" HeaderText="Service ID" ControlStyle-BackColor="LightGray" SortExpression="VWOCtrServID" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>



</body>
</html>
