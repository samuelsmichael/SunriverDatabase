﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
    CodeBehind="OwnerConcerns.aspx.cs" Inherits="SubmittalProposal.OwnerConcerns" %>

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
        <asp:Label ID="Label18" runat="server" Text="Name"></asp:Label>
        <asp:TextBox ID="tbOwnerConcernsNameLU" Width="6em" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2x3" runat="server" Text="Department Referred"></asp:Label>
        <asp:DropDownList ID="ddlOwnerConcernsDepartmentReferredLU" Width="6em" DataTextField="Department"
            DataValueField="Department" runat="server">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label3" runat="server" Text="Category"></asp:Label>
        <asp:DropDownList ID="ddlOwnerConcernsCategoryLU" Width="8em" DataTextField="Category"
            DataValueField="Category" runat="server">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="SR Address"></asp:Label>
        <asp:TextBox ID="tbOwnerConcernsSunriverAddressLU" Width="6em" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label20" runat="server" Text="Resolved"></asp:Label>
        <asp:DropDownList ID="ddlOwnerConcernsResolvedLU" runat="server">
            <asp:ListItem Selected="True" Text="" Value=""></asp:ListItem>
            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
            <asp:ListItem Text="No" Value="No"></asp:ListItem>
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Case#"></asp:Label>
        <asp:TextBox ID="tbOwnerConcernsCaseNbrLU" Width="3em" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <div style="height: 400px; overflow: auto;">
        <asp:GridView AllowSorting="True" ID="gvResults" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
            Style="width: 100%;" runat="server" AutoGenerateColumns="False" DataKeyNames="OCCase#"
            CellPadding="4" ForeColor="#333333" GridLines="None" OnSorting="gvResults_Sorting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EmptyDataTemplate>
                <asp:Label ID="lblEmptyTxt" runat="server" Text="No rows found"></asp:Label>
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Link" SelectText="Select" ShowSelectButton="true" />
                <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                <asp:BoundField DataField="DeptReferred1" HeaderText="Dept Referred" SortExpression="DeptReferred1" />
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                <asp:BoundField DataField="SubmitDate" HeaderText="Submit Date" SortExpression="SubmitDate"
                    DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="ResolutionDate" HeaderText="Resolution Date" SortExpression="ResolutionDate"
                    DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="SRLotLane" HeaderText="SR Address" SortExpression="SRLotLane">
                    <HeaderStyle Wrap="False" />
                    <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Description" HeaderText="Description"></asp:BoundField>
                <asp:BoundField DataField="OCCase#" HeaderText="Cast #"></asp:BoundField>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FormContent" runat="server">
    <asp:Timer ID="Timer1" Enabled="false" OnTick="Timer1_Tick" runat="server" Interval="1000" />
    <ajaxToolkit:TabContainer ActiveTabIndex="0" ID="TabContainer1" runat="server">
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelOwnerConcernsMainData" HeaderText="Main Data">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3aa44x456" runat="server">
                    <ContentTemplate>
                        <table border="0" cellpadding="2" cellspacing="2">
                            <tr valign="top">
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="First Name"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbOwnerConcernsFirstNameUpdate" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Last Name"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbOwnerConcernsLastNameUpdate" MaxLength="30" Width="10em" runat="server"></asp:TextBox>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="Phone #"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbOwnerConcernsPhoneNbrUpdate" MaxLength="30" Width="6em" runat="server"></asp:TextBox>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Email"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbOwnerConcernsEmailUpdate" MaxLength="30" Width="12em" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlOwnerConcernsClientInfo"
                            GroupingText="Owner Info">
                            <table border="0" cellpadding="2" cellspacing="2">
                                <tr>
                                    <td valign="top">
                                        <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Sunriver Address"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbOwnerConcernsSunriverAddress" Width="11em" runat="server"></asp:TextBox>
                                    </td>
                                    <td valign="top">
                                        <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="Phone #"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbOwnerConcernsCustPhone" Width="6em" runat="server"></asp:TextBox>
                                    </td>
                                    <td valign="top">
                                        <asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Owner ID"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbOwnerConcernsOwnerIDUpdate" MaxLength="10" Width="4em" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnNonOwnerLookupSunriverPropertyOwnerInformation" runat="server"
                                            Text="Find Owner/Property" OnClick="btnNonOwnerLookupSunriverPropertyOwnerInformation_onclick"
                                            OnClientClick="javascript:openwindow();return true;" />
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlOwnersConcernsMailingInfo"
                                GroupingText="Mailing Address">
                                <table border="0" cellpadding="2" cellspacing="2">
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="tbOwnerConcernsMailAddr1" Width="20em" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tbOwnerConcernsMailAddr2" Width="20em" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tbOwnerConcernsMailCity" Width="10em" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tbOwnerConcernsMailState" Width="2em" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tbOwnerConcernsMailPostalCode" Width="7em" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </asp:Panel>
                        <table border="0" cellpadding="2" cellspacing="2">
                            <tr valign="top">
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="Dept Referred 1"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:DropDownList ID="ddlOwnerConcernsDeptReferred1Update" runat="server" DataTextField="Department"
                                        DataValueField="Department" Width="11em">
                                    </asp:DropDownList>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label17" runat="server" Text="Dept Referred 2"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:DropDownList ID="ddlOwnerConcernsDeptReferred2Update" runat="server" DataTextField="Department"
                                        DataValueField="Department" Width="11em">
                                    </asp:DropDownList>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label19cm" runat="server" Text="Category"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:DropDownList ID="ddlOwnerConcernsCategoryUpdate" runat="server" DataTextField="Category"
                                        DataValueField="Category" Width="11em">
                                    </asp:DropDownList>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label21" runat="server" Text="Public Works WO#"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="tbOwnerConcernsPublicWorksWONbr" Width="2em" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <table border="0" cellpadding="2" cellspacing="2">
                            <tr valign="top">
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="Started By"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="tbOwnerConcernsStartedByUpdate" MaxLength="25" Width="6em" runat="server"></asp:TextBox>
                                </td>
                                <td align="right" valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Submit date"></asp:Label>
                                </td>
                                <td valign="top">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbOwnerConcernsSubmitDateUpdate"
                                                    runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                    ID="ibOwnerConcernsSubmitDateUpdate" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <ajaxToolkit:CalendarExtender ID="ceOwnerConcernsSubmitDateUpdate" runat="server"
                                        TargetControlID="tbOwnerConcernsSubmitDateUpdate" Format="MM/dd/yyyy" PopupButtonID="ibOwnerConcernsSubmitDateUpdate" />
                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revOwnerConcernsSubmitDateUpdate"
                                        Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                        ControlToValidate="tbOwnerConcernsSubmitDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Approved By"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbOwnerConcernsApprovedByUpdate" MaxLength="25" Width="6em" runat="server"></asp:TextBox>
                                </td>
                                <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="Notified By"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="tbOwnerConcernsNotifiedByUpdate" MaxLength="25" Width="6em" runat="server"></asp:TextBox>
                                </td>
                                <td valign="top" align="right">
                                    <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="Notified date:"></asp:Label>
                                </td>
                                <td valign="top">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbOwnerConcernsNotifiedDateUpdate"
                                                    runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                    ID="ibOwnerConcernsNotifiedDateUpdate" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <ajaxToolkit:CalendarExtender ID="ceOwnerConcernsNotifiedDateUpdate" runat="server"
                                        TargetControlID="tbOwnerConcernsNotifiedDateUpdate" Format="MM/dd/yyyy" PopupButtonID="ibOwnerConcernsNotifiedDateUpdate" />
                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revOwnerConcernsNotifiedDateUpdate"
                                        Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                        ControlToValidate="tbOwnerConcernsNotifiedDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelOwnerConcernsDescriptions" HeaderText="Description/Resolution">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel3ay7a" runat="server">
                    <ContentTemplate>
                        <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlOwnerConcernsConcernDescription" Width="100%" GroupingText="Concern">
                            <asp:TextBox runat="server" TextMode="MultiLine" ID="tbOwnerConcernsConcernDescriptionUpdate" Height="4em" Rows="4" Width="96%"></asp:TextBox>
                        </asp:Panel>
                        <asp:Panel CssClass="form_field_panel_squished" runat="server" ID="pnlOwnerConcernsConcernResolution" Width="100%" GroupingText="Resolution">
                            <asp:TextBox runat="server" TextMode="MultiLine" ID="tbOwnerConcernsConcernResolutionUpdate" Height="4em" Rows="4" Width="96%"></asp:TextBox>
                            <table border="0" cellpadding="3" cellspacing="0">
                                <tr valign="middle">
                                    <td valign="top">
                                        <asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Closed By"></asp:Label>
                                    </td>
                                    <td valign="top">
                                        <asp:TextBox ID="tbOwnerConcernsClosedByUpdate" MaxLength="25" Width="6em" runat="server"></asp:TextBox>
                                    </td>
                                    <td valign="top">
                                        <asp:Label CssClass="form_field_heading" ID="Label19xllk" runat="server" Text="Resolution Date"></asp:Label>
                                    </td>
                                    <td valign="top">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field_date" Width="9em" ID="tbOwnerConcernsResolutionDateUpdate"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibOwnerConcernsResolutionDateUpdate" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="ceOwnerConcernsResolutionDateUpdate" runat="server"
                                            TargetControlID="tbOwnerConcernsResolutionDateUpdate" Format="MM/dd/yyyy" PopupButtonID="ibOwnerConcernsResolutionDateUpdate" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revOwnerConcernsResolutionDateUpdate"
                                            Display="Dynamic" ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbOwnerConcernsResolutionDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabPanelOwnerConcernsPhotos" HeaderText="Photos">
            <ContentTemplate>
                <asp:UpdatePanel ID="updatePanel1y8" runat="server">
                    <ContentTemplate>
                    This page intentionally left blank
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
    <center>
        <div style="margin-bottom: 2em; padding-bottom: 2em;">
            <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
                ID="btnOwnerConcernsUpdate" OnClick="btnOwnerConcernsUpdateOkay_Click" OnClientClick="javascript: return true;"
                runat="server" Text="Submit" />
            <asp:Label ID="lblOwnerConcernsUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblDatePrintedHeading" runat="server" Text="Printed: "></asp:Label>
            <asp:Label ID="lblDatePrinted" runat="server"></asp:Label>
            <asp:Button Style="margin-left: 1em;" ID="btnPrintForm" runat="server" OnClick="btnPrintForm_OnClick"
                CausesValidation="false" Text="Print Form" OnClientClick="javascript:window.print(); return true;" />
                &nbsp;
        </div>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
