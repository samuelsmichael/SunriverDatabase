<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Submittal.aspx.cs" Inherits="SubmittalProposal.Submittal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Panel ID="PnlSearchBar" runat="server" CssClass="collapsePanelHeader"
        Height="30px">
            <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                <div style="float: left;">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>Search criteria</td>
                            <td><asp:Label ID="LblSearch" CssClass="collapsePanelText" Text="" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                </div>
                <div style="float: right; vertical-align: middle;">
                    <asp:ImageButton CausesValidation="False" ID="ImgSearchBar" runat="server"
                        ImageUrl="~/images/expand_blue.jpg" AlternateText="(Show details...)" />
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="PnlSearchContent" DefaultButton="btnGo" runat="server">
            <table border="0" cellpadding="2" cellspacing="0" style="width:100%; white-space:nowrap;">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Owner"></asp:Label>
                        <asp:TextBox ID="tbOwner" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Applicant"></asp:Label>
                        <asp:TextBox ID="tbApplicant" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Lot"></asp:Label>
                        <asp:TextBox ID="tbLot" Width="30" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Lane"></asp:Label>
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
                        <asp:Label ID="Label4" runat="server" Text="Submittal Id"></asp:Label>
                        <asp:TextBox ID="tbSubmittalId" Width="66" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="BPermit Id"></asp:Label>
                        <asp:TextBox ID="tbBPermitId" Width="66" runat="server"></asp:TextBox>
                    </td>
                    <td align="right" style="width:5%">
                        <asp:Button ID="btnGo" runat="server" Text="Go" onclick="btnGo_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender 
        ID="CPESearch" runat="server" 
        TargetControlID="PnlSearchContent"
        ExpandControlID="PnlSearchBar" 
        CollapseControlID="PnlSearchBar"
        TextLabelID="LblSearch" 
        ImageControlID="ImgSearchBar" 
        CollapsedText=""
        ExpandedText="" 
        ExpandedImage="~/Images/collapse_blue.jpg" 
        CollapsedImage="~/Images/expand_blue.jpg"
        Collapsed="true" 
        SuppressPostBack="True" 
        Enabled="True">
    </ajaxToolkit:CollapsiblePanelExtender>
        <asp:Panel style="margin-top:4px;" ID="PnlDataGridBar" runat="server" CssClass="collapsePanelHeader"
            Height="30px">
            <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                <div style="float: left;">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>Search results</td>
                            <td><asp:Label ID="LblDataGrid" CssClass="collapsePanelText" Text="" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                </div>
                <div style="float: right; vertical-align: middle;">
                    <asp:ImageButton CausesValidation="False" ID="ImgDataGridBar" runat="server"
                        ImageUrl="~/images/expand_blue.jpg" AlternateText="(Show details...)" />
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="PnlDataGridContent" runat="server">
            <div style="overflow:auto; width:920px; ">
                <asp:GridView AllowSorting="True" ID="gvResults" 
                    
                    style="width:100%; white-space:nowrap;" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" ForeColor="#333333" GridLines="None" 
                    onselectedindexchanged="gvResults_SelectedIndexChanged" onsorting="gvResults_Sorting"
                >
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField ButtonType="Link"
                         SelectText="Select"  ShowSelectButton="true" />
                    <asp:BoundField DataField="OwnersName" HeaderText="Owner's Name" 
                        SortExpression="OwnersName" />
                    <asp:BoundField DataField="Applicant" HeaderText="Applicant" 
                        SortExpression="Applicant" />
                    <asp:BoundField DataField="Lot" HeaderText="Lot" SortExpression="Lot" />
                    <asp:BoundField DataField="Lane" HeaderText="Lane" SortExpression="Lane" />
                    <asp:BoundField DataField="Block" HeaderText="Block" SortExpression="Block" />
                    <asp:BoundField DataField="Village" HeaderText="Village" 
                        SortExpression="Village" />
                    <asp:BoundField DataField="ProjectType" HeaderText="Project Type" 
                        SortExpression="ProjectType" />
                    <asp:BoundField DataField="MeetingDate" HeaderText="Meeting Date" 
                        SortExpression="MeetingDate" />
                    <asp:BoundField DataField="ExpDate" HeaderText="Exp Date" 
                        SortExpression="ExpDate" />
                    <asp:BoundField DataField="Project" HeaderText="Project" 
                        SortExpression="Project" />
                    <asp:BoundField DataField="Decision" HeaderText="Descision" 
                        SortExpression="Descision" />
                    <asp:BoundField DataField="Contractor" HeaderText="Contractor" 
                        SortExpression="Contractor" />
                    <asp:BoundField DataField="SubmittalId" HeaderText="Submittal Id" 
                        SortExpression="SubmittalId" />
                    <asp:BoundField DataField="BPermitId" HeaderText="BPermitId" 
                        SortExpression="BPermitId" />
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
            </div>
        </asp:Panel>
    <ajaxToolkit:CollapsiblePanelExtender 
        ID="CPEDataGrid" runat="server" 
        TargetControlID="PnlDataGridContent"
        ExpandControlID="PnlDataGridBar" 
        CollapseControlID="PnlDataGridBar"
        TextLabelID="LblDataGrid" 
        ImageControlID="ImgDataGridBar" 
        CollapsedText=""
        ExpandedText="" 
        ExpandedImage="~/Images/collapse_blue.jpg" 
        CollapsedImage="~/Images/expand_blue.jpg"
        Collapsed="true" 
        SuppressPostBack="True" 
        Enabled="True">
    </ajaxToolkit:CollapsiblePanelExtender>
    <asp:Panel style="margin-top:4px;"  ID="PnlFormBar" runat="server" CssClass="collapsePanelHeader"
        Height="30px">
            <div style="padding: 5px; cursor: pointer; vertical-align: middle;">
                <div style="float: left;">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>Form</td>
                            <td><asp:Label ID="LBLForm" CssClass="collapsePanelText" Text="" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                </div>
                <div style="float: right; vertical-align: middle;">
                    <asp:ImageButton CausesValidation="False" ID="ImgFormBar" runat="server"
                        ImageUrl="~/images/expand_blue.jpg" AlternateText="(Show details...)" />
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="PnlFormContent" BorderWidth="0" 
            DefaultButton="btnUpdate" runat="server">
            <ajaxToolkit:TabContainer height="366" ActiveTabIndex="0" ID="TabContainer1" runat="server">

            <ajaxToolkit:TabPanel runat="server"  ID="tabPanelApplicantInformation" HeaderText="Applicant Infromation">
                <ContentTemplate>
                    <asp:UpdatePanel ID="updatePanel3" runat="server">
                        <ContentTemplate>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="Panel1" GroupingText="Owner" runat="server">
                                            <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Name"></asp:Label>   
                                            <asp:TextBox CssClass="form_field" ID="tbOwnersName" runat="server"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                    <td>
                                        <asp:Panel ID="Panel2" GroupingText="Sunriver Property" runat="server">
                                            <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Lot"></asp:Label>   
                                            <asp:TextBox CssClass="form_field" ID="tbLotName2" Width="22" runat="server"></asp:TextBox>
                                            <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Lane"></asp:Label>   
                                            <asp:DropDownList CssClass="form_field" ID="ddlLane2" runat="server">
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

                                        </asp:Panel>
                                    </td>
                                    <td>
                                        <asp:Panel ID="Panel3" GroupingText="Applicant" runat="server">
                                            <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Name"></asp:Label>   
                                            <asp:TextBox CssClass="form_field" ID="tbApplicantName2" runat="server"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="Panel4" GroupingText="Contractor" runat="server">
                                            <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Name"></asp:Label>   
                                            <asp:TextBox CssClass="form_field" ID="tbContractorBB" runat="server"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                    <td>
                                        <asp:Panel ID="Panel5" GroupingText="Project Fees" runat="server">
                                            <table border="0" cellpadding="2" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Review fee"></asp:Label></td>
                                                    <td><asp:TextBox CssClass="form_field" ID="tbReviewFee" runat="server"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label CssClass="form_field_heading" style="margin-top:3px;" ID="Label13" runat="server" Text="Date fee paid"></asp:Label></td>
                                                    <td><asp:TextBox CssClass="form_field" ID="tbDateFeePaid" runat="server"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                            
                                        </asp:Panel>
                                    </td>
                                    <td>
                                        <asp:Panel ID="Panel6" GroupingText="Meeting Date" runat="server">
                                            <asp:TextBox CssClass="form_field" ID="tbMeetingDate" runat="server"></asp:TextBox>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td  colspan="3">
                                        <asp:Panel ID="Panel7" GroupingText="Submittal" runat="server">
                                            <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Project Type"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="form_field" ID="ddlProjectType" runat="server">
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
                                                    <td align="right"><asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Project Decision"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="form_field" ID="ddlProjectDecision" runat="server">
                                                            <asp:ListItem Value="A">A - Approved</asp:ListItem>
                                                            <asp:ListItem Value="AWC">AWC - Approved with Conditions</asp:ListItem>
                                                            <asp:ListItem Value="DEF">DEF - Deferred</asp:ListItem>
                                                            <asp:ListItem Value="DEN">DEN - Denied</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Project"></asp:Label>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:TextBox CssClass="form_field" ID="tbProject" Width="95%" runat="server" TextMode="SingleLine" Rows="1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Submittal"></asp:Label>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:TextBox CssClass="form_field" ID="tbSubmittal" Width="95%" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
                                                    </td>
                                                </tr>

                                            </table>
                                               
                                            
                                               
                                            
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                       </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel runat="server" ID="tabPanelProjectConditions" HeaderText="Project Conditions">
                <ContentTemplate>
                    <asp:UpdatePanel ID="updatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:TextBox ID="tbConditions" style="width:100%;" runat="server" 
                                TextMode="MultiLine" Height="340px"></asp:TextBox>
                       </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>

            </ajaxToolkit:TabContainer>
            <center style="margin-bottom:4px;margin-top:4px;">
                <asp:Button ID="btnUpdate" runat="server" Text="Submit" /></center>
        </asp:Panel>


    <ajaxToolkit:CollapsiblePanelExtender 
        ID="CPEForm" runat="server" 
        TargetControlID="PnlFormContent"
        ExpandControlID="PnlFormBar" 
        CollapseControlID="PnlFormBar"
        TextLabelID="LblForm" 
        ImageControlID="ImgFormBar" 
        CollapsedText=""
        ExpandedText="" 
        ExpandedImage="~/Images/collapse_blue.jpg" 
        CollapsedImage="~/Images/expand_blue.jpg"
        Collapsed="true" 
        SuppressPostBack="True" 
        Enabled="True">
    </ajaxToolkit:CollapsiblePanelExtender>
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
