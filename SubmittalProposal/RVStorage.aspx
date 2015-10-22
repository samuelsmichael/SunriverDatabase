<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="RVStorage.aspx.cs" Inherits="SubmittalProposal.RVStorage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="Last name"></asp:Label>
        <asp:TextBox ID="tbLastNameSearch" Width="125" MaxLength="25" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="lblSpaceInfo" runat="server" Text="Space #"></asp:Label>
        <asp:DropDownList runat="server" ID="ddlSpaceInfoSearch" DataTextField="tSISpace"
            DataValueField="tSISpace">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="RV Lease Id"></asp:Label>
        <asp:TextBox ID="tbRVLeaseIdSearch" Width="46" MaxLength="6" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label12" runat="server" Text="Cancelled"></asp:Label>
        <asp:DropDownList runat="server" ID="ddlYesNoSearch">
            <asp:ListItem Selected="True"></asp:ListItem>
            <asp:ListItem>Yes</asp:ListItem>
            <asp:ListItem>No</asp:ListItem>
        </asp:DropDownList>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" AllowPaging="True" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
        Style="width: 100%; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
        CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting"
        OnPageIndexChanging="gvResults_PageIndexChanging" PageSize="15">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" Position="Bottom"
            PageButtonCount="15" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="FirstName" HeaderText="FName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="L Name" SortExpression="LastName" />
            <asp:BoundField DataField="tRVDSpace" HeaderText="Space" SortExpression="tRVDSpace" />
            <asp:BoundField DataField="SunriverPhone" HeaderText="Sunriver Phone" SortExpression="SunriverPhone" />
            <asp:BoundField DataField="CustomerID" HeaderText="Owner ID" SortExpression="CustomerID" />            
            <asp:TemplateField HeaderText="Cancelled" SortExpression="LeaseCancelled">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# getLeaseCancelled(Eval("LeaseCancelled")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="RVLeaseID" HeaderText="Lease ID" SortExpression="RVLeaseID" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">

                    <asp:Panel runat="server" CssClass="newitempopup" ID="pnlAvailableSpaces">
                        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlAvailableSpacesTitle">

                            <table style="width: 100%;">
                                <tr>
                                    <td width="10%"></td>
                                    <td align="center"><asp:Label id="lbl" runat="server" Text="Available Spaces" ></asp:Label>
                                    </td>
                                    <td width="10%"><asp:HyperLink id="closePopup" runat="server" CssClass="ClosePopupCls">Close [x]</asp:HyperLink>
                                    </td>
                                </tr>
                            </table>

                            
                        </asp:Panel>
                        <asp:Panel runat="server" Style="height:200px;overflow:auto; text-align: center;" ID="Panel6">



    <asp:GridView ID="gvRVStorageAvailableSpaces" OnSelectedIndexChanged="gvRVStorageAvailableSpaces_SelectedIndexChanged"
        runat="server" AutoGenerateColumns="False"
        CellPadding="4" ForeColor="#333333" GridLines="None" 
        
        Style="width: 100%; white-space: nowrap;" >

        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
        </EmptyDataTemplate>
        <Columns>
            <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
            <asp:BoundField DataField="tSISpace" HeaderText="Space" />
            <asp:BoundField DataField="tSISpaceSize" HeaderText="Size" />
            <asp:BoundField DataField="tSIElectServ" HeaderText="Electricity" />
            <asp:BoundField DataField="AnnualRent" HeaderText="Annual Rent" DataFormatString="{0:c}" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>



                        </asp:Panel>
                    </asp:Panel>




    <ajaxToolkit:TabContainer Height="316" ActiveTabIndex="0" ID="tcRVStorageUpdate" AutoPostBack="true"
                        runat="server"  onactivetabchanged="tcRVStorageUpdate_ActiveTabChanged">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelOwnerInformation" HeaderText="Owner Information">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3aa" runat="server">
                    <ContentTemplate>
                        <table cellpadding="4" width="100%" cellspacing="4" border="0">
                            <tr valign="top">
                                <td  width="50%" valign="top">
                                    <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="pnlRVStorageInputUpdate" GroupingText="Input Info">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label2" runat="server" Text="First Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbRVOwnerFirstNameUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Last Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbRVOwnerLastNameUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Sunriver phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbSunriverPhoneUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Other phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbOtherPhoneUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbEmailUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Driver's license"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbDriversLicenseUpdate" MaxLength="20" Width="125"
                                                        runat="server"></asp:TextBox>
                                                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="State"></asp:Label>                                                
                                                    <asp:TextBox CssClass="form_field" ID="tbStateUpdate" MaxLength="5" Width="25" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Current space"></asp:Label>
                                                </td>
                                                <td>
                                                        <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbCurrentSpaceProtectedUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                        <asp:Button ID="btnShowAvailableSpacesUpdate" OnClick="btnShowAvailableSpaces_OnClick" runat="server" Text="Available Spaces" CausesValidation="false" />
                                                        <asp:Button runat="server" ID="dummyAvailableSpaces" style="display:none" />
                                                        <ajaxToolkit:ModalPopupExtender ID="mpeAvailableSpaces" runat="server" TargetControlID="dummyAvailableSpaces"
                                                            PopupControlID="pnlAvailableSpaces" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlAvailableSpacesTitle"
                                                            CancelControlID="closePopup"
                                                            BehaviorID="bipopupAvailableSpaces" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td valign="top">
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlRVStorageDerivedUpdateMailingAddress" GroupingText="Mailing Address">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbAddr1OwnerInfo" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbAddr2OwnerInfo" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbCityOwnerInfo" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbRegionOwnerInfo" MaxLength="3" Width="25"
                                                        runat="server"></asp:TextBox>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbPostalCodeOwnerInfo" MaxLength="10" Width="66"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlRVStorageDerivedUpdateSunriverAddress" GroupingText="Sunriver Address">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbSunriverAddressOwnerInfo" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="Panel1" GroupingText="IDs">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <td>
                                                <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Property ID"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox CssClass="form_field_alwaysprotected" ID="tbPropertyIdOwnerInfo" MaxLength="25" Width="125"
                                                    runat="server"></asp:TextBox>
                                            </td>

                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Owner ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" ID="tbOwnerIdOwnerInfo" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
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
        <ajaxToolkit:TabPanel runat="server" ID="tabPanel1" HeaderText="RV & Space Information">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel1" runat="server">
                    <ContentTemplate>
                        <table cellpadding="4" width="100%" cellspacing="4" border="0">
                            <tr valign="top">
                                <td  width="50%" valign="top">
                                    <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="Panel2" GroupingText="Input Info">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Electrical Req'd"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlRVSpaceInfoElectricalReqdYesNoUpdate" runat="server">
                                                        <asp:ListItem>Yes</asp:ListItem>
                                                        <asp:ListItem Selected="True">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Space Size Req'd"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlRVSpaceInfoSpaceSizeReqdUpdate" runat="server" DataValueField="tSRSpaceSize" DataTextField="tSRSpaceSize">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td  width="50%" valign="top">
                                    <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="Panel3" GroupingText="Leased Space Info">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Space"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" CssClass="form_field_alwaysprotected" Width="55" MaxLength="5"
                                                        ID="tbRVSpaceInfoSpaceProtectedUpdate"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Leased?"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" CssClass="form_field_alwaysprotected" Width="55" MaxLength="5"
                                                        ID="tbRVSpaceInfoSpaceLeasedProtectedUpdate"></asp:TextBox>
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
        <ajaxToolkit:TabPanel runat="server" ID="tabPanel2" HeaderText="Lease Information">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel2" runat="server">
                    <ContentTemplate>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanel3" HeaderText="NonOwner Information">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3" runat="server">
                    <ContentTemplate>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnRVUpdate" OnClick="btnRVUpdateOkay_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblRVUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
