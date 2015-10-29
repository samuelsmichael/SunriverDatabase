<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="RVStorage.aspx.cs" Inherits="SubmittalProposal.RVStorage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
        
        <asp:HiddenField ID="winhidden" Value="n" runat="server" />
        <asp:HiddenField ID="timetoclosewindowhidden" runat="server" Value="n" />
        <script language="javascript" type="text/javascript">
            function chkwinclosed() {
                if (document.getElementById("<%=timetoclosewindowhidden.ClientID %>").value == "y") {
                    document.getElementById("<%=timetoclosewindowhidden.ClientID %>").value = "n";
                    document.getElementById("<%=winhidden.ClientID %>").value = "y";
                        win2.close();
                    return
                }

                if (win2.closed) {
                    document.getElementById("<%=winhidden.ClientID %>").value = "y";
                    return;
                }
                setTimeout("chkwinclosed()", 1000)
            }
            function openwindow() {
                //Allow for borders.
                width = 1000;
                height = 600;
                leftPosition = (window.screen.width / 2) - ((width / 2) + 10);
                //Allow for title and status bars.
                topPosition = (window.screen.height / 2) - ((height / 2) + 50);
                document.getElementById("<%=winhidden.ClientID %>").value = "n";
                vars = 'status=no,width=' + width + ',height=' + height + ',left=' + leftPosition + ',top=' + topPosition + ',toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,directories=no';
                win2 = window.open('OwnerPropertyFinder.aspx', '_blank', vars); 
                setTimeout('chkwinclosed()', 2000);
            }
        </script>

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
        <asp:Label ID="Label47" runat="server" Text="Customer ID"></asp:Label>
        <asp:TextBox ID="tbCustomerIDSearch" Width="46" MaxLength="6" runat="server"></asp:TextBox>
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

    <ajaxToolkit:TabContainer Height="316" ActiveTabIndex="0" ID="tcRVStorageUpdate" AutoPostBack="true"
                        runat="server"  onactivetabchanged="tcRVStorageUpdate_ActiveTabChanged">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelOwnerInformation" HeaderText="Owner Information">
            <ContentTemplate>
                <asp:Timer ID="Timer1" Enabled="false" OnTick="Timer1_Tick" runat="server" Interval="1000" />
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
                                                    <asp:TextBox CssClass="form_field" ID="tbRVOwnerFirstNameUpdate" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                    <asp:Button ID="Button1X" Text="Find Owner/Property" runat="server" 
                                                        OnClick="button1click" 
                                                        OnClientClick="javascript:openwindow();return true;" />
                                      
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Last Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbRVOwnerLastNameUpdate" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label3" runat="server" Text="Sunriver phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbSunriverPhoneUpdate" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Other phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbOtherPhoneUpdate" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbEmailUpdate" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Driver's license"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbDriversLicenseUpdate" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="20" Width="125"
                                                        runat="server"></asp:TextBox>
                                                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="State"></asp:Label>                                                
                                                    <asp:TextBox CssClass="form_field" ID="tbStateUpdate" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="5" Width="25" runat="server"></asp:TextBox>
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
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbAddr1OwnerInfoUpdate" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbAddr2OwnerInfo" MaxLength="25" Width="165"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbCityOwnerInfo" MaxLength="25" Width="165"
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
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Vehicle Length"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbVehicleLengthUpdate" MaxLength="10" Width="50"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label19" runat="server" Text="RV Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbRVTypeUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label20" runat="server" Text="RV Make"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbRVMakeUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label21" runat="server" Text="RV Model"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbRVModelUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Vehicle License #"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbVehicleLicenseUpdate" MaxLength="15" Width="75"
                                                        runat="server"></asp:TextBox>
                                                    <asp:Label CssClass="form_field_heading" ID="Label23" runat="server" Text="State"></asp:Label>                                                
                                                    <asp:TextBox CssClass="form_field" ID="tbVehicleLicenseStateUpdate" MaxLength="5" Width="25" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label24" runat="server" Text="Lien"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbLienUpdate" MaxLength="30" Width="150"
                                                        runat="server"></asp:TextBox>
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
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label25" runat="server" Text="Space Type"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddlSpaceTypeUpdate">
                                                        <asp:ListItem Selected="True">Primary</asp:ListItem>
                                                        <asp:ListItem>Multiple</asp:ListItem>
                                                        <asp:ListItem>Owner</asp:ListItem>
                                                        <asp:ListItem>Non-Owner</asp:ListItem>
                                                    </asp:DropDownList>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label26" runat="server" Text="Permanent Assignment"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddlPermanentAssignmentUpdate">
                                                        <asp:ListItem Selected="True">Yes</asp:ListItem>
                                                        <asp:ListItem>No</asp:ListItem>
                                                    </asp:DropDownList>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Space Size"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" CssClass="form_field_alwaysprotected" Width="50" MaxLength="10"
                                                        ID="tbSpaceSizeRVTabUpdate"></asp:TextBox>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label28" runat="server" Text="Electrical Service"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" CssClass="form_field_alwaysprotected" Width="50" MaxLength="10"
                                                        ID="tbElectricalServiceRVTabUpdate"></asp:TextBox>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label29" runat="server" Text="Annual Rent"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" CssClass="form_field_alwaysprotected" Width="50" MaxLength="10"
                                                        ID="tbAnnualRentRVTabUpdate"></asp:TextBox>

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

                        <table cellpadding="4" width="100%" cellspacing="4" border="0">
                            <tr valign="top">
                                <td  width="25%" valign="top">
                                        <table cellpadding="4" cellspacing="4" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label30" runat="server" Text="Payment This Year"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlPaymentThisYearUpdate" runat="server">
                                                        <asp:ListItem>Yes</asp:ListItem>
                                                        <asp:ListItem Selected="True">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label32" runat="server" Text="Least Start Date"></asp:Label>
                                                </td>
                                                <td style="white-space:nowrap">
                                                    <asp:TextBox CssClass="form_field" ID="tbLeaseStartDateUpdate" MaxLength="10" Width="75"
                                                        runat="server"></asp:TextBox>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibtbLeaseStartDateUpdate" runat="server" />
                                                </td>
                                                <ajaxToolkit:CalendarExtender ID="cetbLeaseStartDateUpdate" runat="server" TargetControlID="tbLeaseStartDateUpdate"
                                                    Format="MM/dd/yyyy" PopupButtonID="ibtbLeaseStartDateUpdate" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="revtbLeaseStartDateUpdate" Display="Dynamic"
                                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbLeaseStartDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Lease Cancelled"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddlLeaseCancelledUpdate_OnSelectedIndexChanged" ID="ddlLeaseCancelledUpdate" runat="server">
                                                        <asp:ListItem>Yes</asp:ListItem>
                                                        <asp:ListItem Selected="True">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:Label runat="server" ID="lblLeasedCancelledErrorMessage" Font-Bold="true" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label33" runat="server" Text="Wait List Date"></asp:Label>
                                                </td>
                                                <td style="white-space:nowrap">
                                                    <asp:TextBox CssClass="form_field" ID="tbWaitListDateUpdate" MaxLength="10" Width="75"
                                                        runat="server"></asp:TextBox>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibtbWaitListDateUpdate" runat="server" />
                                                </td>
                                                <ajaxToolkit:CalendarExtender ID="cetbWaitListDateUpdate" runat="server" TargetControlID="tbWaitListDateUpdate"
                                                    Format="MM/dd/yyyy" PopupButtonID="ibtbWaitListDateUpdate" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="rvtbWaitListDateUpdate" Display="Dynamic"
                                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbWaitListDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label36" runat="server" Text="Lease Cancelled Date"></asp:Label>
                                                </td>
                                                <td style="white-space:nowrap">
                                                    <asp:TextBox CssClass="form_field" ID="tbLeaseCancelledDate" MaxLength="10" Width="75"
                                                        runat="server"></asp:TextBox>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibtbLeaseCancelledDate" runat="server" />
                                                </td>
                                                <ajaxToolkit:CalendarExtender ID="cbtbLeaseCancelledDate" runat="server" TargetControlID="tbLeaseCancelledDate"
                                                    Format="MM/dd/yyyy" PopupButtonID="ibtbLeaseCancelledDate" />
                                                <asp:RegularExpressionValidator ForeColor="Red" ID="rvtbLeaseCancelledDate" Display="Dynamic"
                                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                                    ControlToValidate="tbLeaseCancelledDate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label35" runat="server" Text="RV Space #"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" CssClass="form_field_alwaysprotected" Width="50" MaxLength="5"
                                                        ID="tbRVSpaceLeaseInformationProtectedUpdate"></asp:TextBox>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label34" runat="server" Text="Annual Rent"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" CssClass="form_field_alwaysprotected" Width="75" MaxLength="10"
                                                        ID="tbLeaseInformationAnnualRentProtectedUpdate"></asp:TextBox>

                                                </td>
                                            </tr>
                                            
                                        </table>

                                </td>
                                <td valign="top">
                                    <asp:Panel ID="pnlNotes" BorderWidth="0" BorderColor="White" BorderStyle="None" runat="server" Width="39em" GroupingText="Notes">
                                        <center><asp:TextBox runat="server" ID="tbNotesUpdate" Height="8em" TextMode="MultiLine" Width="40em"></asp:TextBox></center>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanel3" HeaderText="NonOwner Information">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3" runat="server">
                    <ContentTemplate>
                        <table cellpadding="1" width="100%" cellspacing="1" border="0">
                            <tr valign="top">
                                <td  width="50%" valign="top">
                                    <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="Panel4" GroupingText="Non-Owner Input">
                                        <table cellpadding="2" cellspacing="2" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label37" runat="server" Text="First Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbNonOwnerFirstNameUpdate" OnTextChanged="aNonOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label38" runat="server" Text="Last Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbRVNonOwnerLastNameUpdate" OnTextChanged="aNonOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label39" runat="server" Text="Sunriver phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbNonOwnerSunriverPhoneUpdate" OnTextChanged="aNonOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label40" runat="server" Text="Other phone"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" AutoPostBack="true" ID="tbNonOwnerOtherPhoneUpdate" OnTextChanged="aNonOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label41" runat="server" Text="Email"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbNonOwnerEmailUpdate" OnTextChanged="aNonOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label42" runat="server" Text="Driver's license"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbNonOwnerDriversLicenseUpdate" OnTextChanged="aNonOwnerFieldChanged_TextChanged" MaxLength="20" Width="125"
                                                        runat="server"></asp:TextBox>
                                                    <asp:Label CssClass="form_field_heading" ID="Label43" runat="server" Text="State"></asp:Label>                                                
                                                    <asp:TextBox CssClass="form_field" ID="tbNonOwnerStateUpdate" OnTextChanged="aNonOwnerFieldChanged_TextChanged" MaxLength="5" Width="25" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label CssClass="form_field_heading" ID="Label44" runat="server" Text="Current space"></asp:Label>
                                                </td>
                                                <td>
                                                        <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbNonOwnerCurrentSpaceProtectedUpdate" MaxLength="25" Width="125"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="Panel5" GroupingText="Mailing Address">
                                        <table cellpadding="2" cellspacing="2" border="0">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="tbAddr1NonOwnerInfoUpdate" MaxLength="25" Width="155"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox  ID="tbAddr2NonOwnerInfoUpdate" MaxLength="25" Width="155"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="tbCityNonOwnerInfoUpdate" MaxLength="25" Width="155"
                                                        runat="server"></asp:TextBox>
                                                    <asp:TextBox ID="tbRegionNonOwnerInfoUpdate" MaxLength="3" Width="25"
                                                        runat="server"></asp:TextBox>
                                                    <asp:TextBox ID="tbPostalCodeNonOwnerInfoUpdate" MaxLength="10" Width="66"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="Panel8" GroupingText="Sunriver Address">
                                                    <asp:TextBox ID="tbNonOwnerSunriverAddressUpdate" MaxLength="10" Width="155"
                                                        runat="server"></asp:TextBox>
                                    </asp:Panel>

                                </td>
                                <td>
                                    <asp:Panel CssClass="form_field_panel_squished" style="background-color:rgb(249,253,173);"  runat="server" ID="Panel7" GroupingText="SROA Owner">
                                        <center><asp:Label ID="lblIsSROAOwnerUpdate" runat="server"></asp:Label></center>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="Panel9" GroupingText="Property Owner Information">
                            <table cellpadding="4" width="100%" cellspacing="4" border="0">
                                <tr valign="top">
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label45" runat="server" Text="Property Owner Name"></asp:Label>
                                    </td>
                                    <td   valign="top">
                                        <asp:TextBox ID="tbNonOwnerPropertyOwnerNameUpdate" MaxLength="25" Width="155"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label46" runat="server" Text="Prop Owner ID#"></asp:Label>
                                    </td>
                                    <td   valign="top">
                                        <asp:TextBox ID="tbNonOwnerPropertyOwnerId" MaxLength="25" Width="155"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnNonOwnerLookupSunriverPropertyOwnerInformation" runat="server" Text="Lookup Sunriver Property Owner Information"
                                                 OnClick="btnNonOwnerLookupSunriverPropertyOwnerInformation_onclick" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
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
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnRVUpdate" OnClick="btnRVUpdateOkay_Click" 
            runat="server" Text="Submit" />
        <asp:Label ID="lblRVUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
   
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <asp:Panel runat="server" CssClass="newitempopup" Width="800" ID="pnlNewRVStorageId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewRVStorageTitleId">
            <span>New RV Storage</span>
        </asp:Panel>
        <asp:Panel runat="server" style="text-align:center;" ID="pnlNewRVStorageContent" CssClass="newitemcontent">
            <ajaxToolkit:TabContainer Height="316" ActiveTabIndex="0" ID="TabContainer1" AutoPostBack="true"
                        runat="server"  onactivetabchanged="tcRVStorageAdd_ActiveTabChanged">
                <ajaxToolkit:TabPanel runat="server" ID="tabPanel4" HeaderText="Owner Information">
                    <ContentTemplate>
                    <asp:UpdatePanel ID="updatePanel4" runat="server">
                        <ContentTemplate>

                            <table cellpadding="4" width="100%" cellspacing="4" border="0">
                                <tr valign="top">
                                    <td  width="50%" valign="top">
                                        <asp:Panel CssClass="form_field_panel_squished"  runat="server" ID="Panel10" GroupingText="Input Info">
                                            <table cellpadding="4" cellspacing="4" border="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label CssClass="form_field_heading" ID="Label48" runat="server" Text="First Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="form_field" ID="tbRVOwnerFirstNameAdd" OnTextChanged="anOwnerAddFieldChanged_TextChanged" MaxLength="25" Width="125"
                                                            runat="server"></asp:TextBox>
                                                        <asp:Button ID="btnFindOwnerProperty" Text="Find Owner/Property" runat="server" 
                                                            OnClick="btnFindOwnerProperty_OnClick" 
                                                            OnClientClick="javascript:openwindow();return true;" />
                                      
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label9xa" runat="server" Text="Last Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbRVOwnerLastNameAdd" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label3xa" runat="server" Text="Sunriver phone"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbSunriverPhoneAdd" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label4xa" runat="server" Text="Other phone"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbOtherPhoneAdd" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label5xa" runat="server" Text="Email"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbEmailAdd" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="25" Width="125"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label6xa" runat="server" Text="Driver's license"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="form_field" ID="tbDriversLicenseAdd" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="20" Width="125"
                                            runat="server"></asp:TextBox>
                                        <asp:Label CssClass="form_field_heading" ID="Label7xa" runat="server" Text="State"></asp:Label>                                                
                                        <asp:TextBox CssClass="form_field" ID="tbStateAdd" OnTextChanged="anOwnerFieldChanged_TextChanged" MaxLength="5" Width="25" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label CssClass="form_field_heading" ID="Label8xa" runat="server" Text="Current space"></asp:Label>
                                    </td>
                                    <td>
                                            <asp:TextBox CssClass="form_field_alwaysprotected" disabled="disabled" ID="tbCurrentSpaceProtectedAdd" MaxLength="25" Width="125"
                                            runat="server"></asp:TextBox>
                                            <asp:Button ID="btnShowAvailableSpacesAdd" OnClick="btnShowAvailableSpacesAdd_OnClick" runat="server" Text="Available Spaces" CausesValidation="false" />
                                    </td>
                                </tr>

                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>

                <ajaxToolkit:TabPanel runat="server" ID="tabPanel4a1" HeaderText="RV & Space Information">
                    <ContentTemplate>
                    <asp:UpdatePanel ID="updatePanel4ac" runat="server">
                        <ContentTemplate>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel runat="server" ID="tabPanel4b2" HeaderText="Lease Information">
                    <ContentTemplate>
                    <asp:UpdatePanel ID="updatePanel4bb" runat="server">
                        <ContentTemplate>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel runat="server" ID="tabPanel4c3" HeaderText="NonOwner Information">
                    <ContentTemplate>
                    <asp:UpdatePanel ID="updatePanel4ca" runat="server">
                        <ContentTemplate>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
            </ajaxToolkit:TabContainer>
        </asp:Panel>
        <script  language="javascript" type="text/javascript" >
            function doOk() {

                var loading = $(".loadingdb");
                loading.show();
                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                loading.css({ top: top, left: left });
                return true;
            }

            // Called when async postback ends
            function prm_EndRequest(sender, args) {
                // get the divImage and hide it again
                //debugger
                if (sender._postBackSettings.sourceElement.id.indexOf("BtnGo") != -1 || sender._postBackSettings.sourceElement.id.indexOf("gvResults") != -1
                || (sender._postBackSettings.sourceElement.id.indexOf("btnNew") != -1 && sender._postBackSettings.sourceElement.id.indexOf("Ok") != -1)) {
                    var loading = $(".loading");
                    loading.hide();
                }
            }

        </script>
        <center>
            <table cellpadding="4">
                <tr>
                    <td>
                        <asp:Button ID="btnNewRVStorageOk" CausesValidation="true" OnClientClick="javascript: if(Page_IsValid) { return doOk();} " runat="server" Text="Okay" 
                            onclick="btnNewRVStorageOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewRVStorageCancel" onclick="btnNewRVStorageCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to cancel?')" runat="server" Text="Cancel" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblRVStorageNewResults" Font-Bold="true" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>

            <div class="loadingdb" align="center">
                Processing. Please wait.<br />
                <br />
                <img src="Images/animated_progress.gif" alt="" />
            </div>
        </center>

    </asp:Panel>


    <asp:LinkButton ID="lbRVStorageNew" OnClick="lbRVStorageNewCmon_OnClick" CausesValidation="false" runat="server">New Request</asp:LinkButton>
    <asp:Button style="display:none;" ID="btnhiddenrvstorage1" runat="server" />
    <ajaxToolkit:ModalPopupExtender ID="mpeNewRVStorage" runat="server" TargetControlID="btnhiddenrvstorage1"
        PopupControlID="pnlNewRVStorageId" BackgroundCssClass="modalBackground" 
        PopupDragHandleControlID="pnlNewRVStorageTitleId"
        BehaviorID="jdpopuprvstorage" />   
</asp:Content>
  