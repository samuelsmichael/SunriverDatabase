<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="BPermit.aspx.cs" Inherits="SubmittalProposal.BPermit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
                <td>
                    <asp:Label ID="Label18" runat="server" Text="Owner"></asp:Label>
                    <asp:TextBox ID="tbOwner" Width="100" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label19" runat="server" Text="Applicant"></asp:Label>
                    <asp:TextBox ID="tbApplicant" Width="100" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
                    <asp:TextBox ID="tbLot" Width="30" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
                    <asp:DropDownList ID="ddlLane" runat="server">
                        <asp:ListItem>Choose lane</asp:ListItem>
                        <asp:ListItem>Sage Springs</asp:ListItem>
                        <asp:ListItem>Salishan</asp:ListItem>
                        <asp:ListItem>Sandhill</asp:ListItem>
                        <asp:ListItem>Sandtrap</asp:ListItem>
                        <asp:ListItem>Sarazen</asp:ListItem>
                        <asp:ListItem>Sequoia</asp:ListItem>
                        <asp:ListItem>Shadow</asp:ListItem>
                        <asp:ListItem>Shag Bark</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label ID="Label22" runat="server" Text="Submittal Id"></asp:Label>
                    <asp:TextBox ID="tbSubmittalId" Width="66" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label23" runat="server" Text="BPermit Id"></asp:Label>
                    <asp:TextBox ID="tbBPermitId" Width="66" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="Delay"></asp:Label>
                    <asp:TextBox ID="tbDelaySearch" Width="20" runat="server"></asp:TextBox>
                </td>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" 
        style="width:100%; white-space:nowrap;" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="gvResults_SelectedIndexChanged" 
        onsorting="gvResults_Sorting"
    >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link"
                    SelectText="Select"  ShowSelectButton="true" />
            <asp:BoundField DataField="Lot" HeaderText="Lot" SortExpression="Lot" />
            <asp:BoundField DataField="Lane" HeaderText="Lane" SortExpression="Lane" />
            <asp:BoundField DataField="fkSubmittalID_PD" HeaderText="Submittal Id" 
                SortExpression="fkSubmittalID_PD" />
            <asp:BoundField DataField="BPermitId" HeaderText="BPermitId" 
                SortExpression="BPermitId" />
            <asp:BoundField DataField="BPIssueDate" DataFormatString="MM/dd/yyyy" HeaderText="Issue Date" SortExpression="BPIssueDate" />
            <asp:TemplateField HeaderText="Expires" SortExpression="BPExpires">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("BPExpires") %>' 
                        ForeColor='<%# getForeColorForExpireDate(Eval("BPExpires")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="BPClosed" DataFormatString="MM/dd/yyyy" HeaderText="Closed" SortExpression="BPClosed" />
            <asp:BoundField DataField="BPDelay" HeaderText="Delay" SortExpression="BPDelay" />
            <asp:BoundField DataField="OwnersName" HeaderText="Owner's Name" 
                SortExpression="OwnersName" />
            <asp:BoundField DataField="Applicant" HeaderText="Applicant" 
                SortExpression="Applicant" />
            <asp:BoundField DataField="Contractor" HeaderText="Contractor" 
                SortExpression="Contractor" />
            <asp:BoundField DataField="BPermitReqd" HeaderText="Permit Reqd" 
                SortExpression="BPermitReqd" />
            <asp:BoundField DataField="ProjectType" HeaderText="Project Type" 
                SortExpression="ProjectType" />
            <asp:BoundField DataField="Project" HeaderText="Project" SortExpression="Project" />

        </Columns>
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
    </asp:GridView>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <asp:Panel ID="Panel1" GroupingText="Building Permit Data" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Delay"></asp:Label> 
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbDelay" Width="3em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label1" runat="server" Text="Issued"></asp:Label> 
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbIssued" Width="10em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="Expired"></asp:Label> 
                </td>
                <td>
                    <asp:Label CssClass="form_field_lbl" ID="lblExpired" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Closed"></asp:Label> 
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbClosed" Width="10em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Permit Required"></asp:Label> 
                </td>
                <td>
                    <asp:RadioButtonList ID="rbListPermitRequired" RepeatDirection="Horizontal" runat="server">
                        <asp:ListItem>Yes</asp:ListItem>
                        <asp:ListItem>No</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" GroupingText="Data from Submittal Form" runat="server">
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Lot"></asp:Label>
                 </td>
                 <td>
                    <asp:TextBox CssClass="form_field" ID="tbLotName2" Width="22" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>   
                </td>
                <td>
                    <asp:DropDownList  CssClass="form_field" ID="ddlLane2" runat="server">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        <asp:ListItem>Sage Springs</asp:ListItem>
                        <asp:ListItem>Salishan</asp:ListItem>
                        <asp:ListItem>Sandhill</asp:ListItem>
                        <asp:ListItem>Sandtrap</asp:ListItem>
                        <asp:ListItem>Sarazen</asp:ListItem>
                        <asp:ListItem>Sequoia</asp:ListItem>
                        <asp:ListItem>Shadow</asp:ListItem>
                        <asp:ListItem>Shag Bark</asp:ListItem>
                        <asp:ListItem>Squirrel</asp:ListItem>
                        <asp:ListItem>Tumalo</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Owner"></asp:Label>   
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbOwnersName" Width="20em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Applicant"></asp:Label>   
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbApplicantName2" Width="20em" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Contractor"></asp:Label>  
                </td>
                <td colspan="2"> 
                    <asp:TextBox CssClass="form_field" ID="tbContractorBB"  Width="20em" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Project"></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="form_field" ID="tbProject" runat="server" Width="20em" TextMode="SingleLine" Rows="1"></asp:TextBox>
                </td>
                <td>
                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Project Type"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList CssClass="form_field"  ID="ddlProjectType" runat="server">
                        <asp:ListItem Value="AA">AA - Administrative Approval</asp:ListItem>
                        <asp:ListItem Value="ALT">ALT - Alteration\Addition</asp:ListItem>
                        <asp:ListItem Value="CAI">CAI - Common Area Improvement</asp:ListItem>
                        <asp:ListItem Value="COM">COM - Commercial Construction</asp:ListItem>
                        <asp:ListItem Value="MA">MA - Minor Addition</asp:ListItem>
                        <asp:ListItem Value="NEW">NEW - New Construction</asp:ListItem>
                        <asp:ListItem Value="PRE">PRE - Preliminary</asp:ListItem>
                        <asp:ListItem Value="RER">RER - ReReview\Revision</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>        
    </asp:Panel>
    <table width="100%">
        <tr>
            <td>
                <asp:Panel runat="server" ID="pnlPayments" GroupingText="Payments">
                    <asp:GridView ID="gvPayments" runat="server" AutoGenerateColumns="False" 
                        CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True">
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
                            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowCancelButton="true" />
                            <asp:BoundField DataField="BPPmt" HeaderText="Nbr" />
                            <asp:TemplateField HeaderText="Fee">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("[BPFee$]") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("[BPFee$]") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%# getBPFeeTotal() %>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Months">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2"  runat="server" Text='<%# Bind("BPMonths") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("BPMonths") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%# getBPMonthsTotal() %>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="BPPayType" HeaderText="Pay Type" />
                        </Columns>
                    </asp:GridView>
                    <center style="margin-top:5px;">
                        <asp:LinkButton ID="LinkButton1" runat="server">New Payment</asp:LinkButton></center>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel runat="server" ID="pnlReviews" GroupingText="Reviews">
                    <asp:GridView ID="gvReviews" runat="server" AutoGenerateColumns="False" 
                        CellPadding="4" ForeColor="#333333" GridLines="None">
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
                            <asp:CommandField ButtonType="Link" ShowEditButton="true" />
                            <asp:BoundField DataField="BPRevw" HeaderText="Nbr" />
                            <asp:BoundField DataField="BPReviewDate" DataFormatString="MM/dd/yyyy" HeaderText="1st Inspect" />
                            <asp:BoundField DataField="BPRActionDate" DataFormatString="MM/dd/yyyy" HeaderText="Action " />
                            <asp:BoundField DataField="BPRLetterDate" DataFormatString="MM/dd/yyyy" HeaderText="Letter" />
                            <asp:BoundField DataField="BPRLetterRef" HeaderText="Letter Ref" />
                            <asp:BoundField DataField="BPRComments" HeaderText="Comments" />
                        </Columns>
                    </asp:GridView>
                    <center style="margin-top:5px;">
                        <asp:LinkButton ID="LinkButton2" runat="server">New Review</asp:LinkButton></center>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
