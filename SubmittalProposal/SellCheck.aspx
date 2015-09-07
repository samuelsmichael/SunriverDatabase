<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="SellCheck.aspx.cs" Inherits="SubmittalProposal.SellCheck" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <td>
        <asp:Label ID="Label18" runat="server" Text="Requestor"></asp:Label>
        <asp:TextBox ID="tbRecipient" Width="80" runat="server"></asp:TextBox>
    </td>

    <td>
        <asp:Label ID="Label20" runat="server" Text="Lot"></asp:Label>
        <asp:TextBox ID="tbLot" Width="40" MaxLength="5" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label21" runat="server" Text="Lane"></asp:Label>
        <asp:DropDownList ID="ddlLane" Width="100" runat="server" DataTextField="Lane" DataValueField="Lane">
        </asp:DropDownList>
    </td>
    <td>
        <asp:Label ID="Label3" runat="server" Text="Copy 1"></asp:Label>
        <asp:TextBox ID="tbscLTCCopy1" Width="80" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label23" runat="server" Text="Request ID"></asp:Label>
        <asp:TextBox ID="tbRequestId" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label1" runat="server" Text="Property ID"></asp:Label>
        <asp:TextBox ID="tbPropertyID" Width="46" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Label ID="Label2" runat="server" Text="Inspection ID"></asp:Label>
        <asp:TextBox ID="tbInspectionID" Width="46" runat="server"></asp:TextBox>
    </td>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ResultsContent" runat="server">
    <asp:GridView AllowSorting="True" ID="gvResults" AllowPaging="true" OnSelectedIndexChanged="gvResults_SelectedIndexChanged"
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
            <asp:BoundField DataField="scLTDate" HeaderText="Date" SortExpression="dateYYYYMMDD" DataFormatString="{0:d}" />
            <asp:BoundField DataField="scLot" HeaderText="Lot" SortExpression="scLot" />
            <asp:BoundField DataField="scLane" HeaderText="Lane" SortExpression="scLane" />
            <asp:BoundField DataField="scLTRecipient" HeaderText="Requestor" SortExpression="scLTRecipient" />
            <asp:BoundField DataField="scLTCCopy1" HeaderText="CCopy1" SortExpression="scLTCCopy1" />
            <asp:BoundField DataField="scRequestID" HeaderText="Request ID" SortExpression="scRequestID" />
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

    <asp:Panel ID="Panel1" GroupingText="Notification Letter Data" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top">
                <td valign="top" colspan="2">
                    <table border="0" cellpadding="1" cellspacing="1">
                        <tr>
                            <td><asp:Label CssClass="form_field_heading" ID="Label7x" runat="server" Text="Date "></asp:Label></td>
                            <td>                    
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox CssClass="form_field" ID="tbLTDateUpdate" Width="10em" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                ID="ibtbLTDateUpdate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <ajaxToolkit:CalendarExtender ID="ceLTDateUpdate" runat="server" TargetControlID="tbLTDateUpdate"
                                    Format="MM/dd/yyyy" PopupButtonID="ibtbLTDateUpdate" />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="revLTDateUpdate" Display="Dynamic"
                                    ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                    ControlToValidate="tbLTDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label5" runat="server" Text="Recipient "></asp:Label>
                </td>
                <td valign="top">
                     <asp:TextBox CssClass="form_field" ID="tbscLTRecipientUpdate" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                </td>
                <td valign="top">
                    <asp:Label CssClass="form_field_heading" ID="Label6" runat="server" Text="CC1 "></asp:Label>
                </td>
                <td valign="top">
                     <asp:TextBox CssClass="form_field" ID="tbscLTCCopy1Update" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr valign="top">
                <td valign="top"><asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Realtor "></asp:Label></td>
                <td valign="top">
                    <asp:DropDownList ID="ddlscRealtorUpdate" DataTextField="RealtyCo" DataValueField="RealtyCo" runat="server"></asp:DropDownList>
                </td>
                <td valign="top">
                        <asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Address "></asp:Label>
                </td>
                <td valign="top">
                    <table border="0" cellpadding="1" cellspacing="1">
                        <tr>
                            <td>
                                 <asp:TextBox CssClass="form_field" ID="tbscLTMailAddr1Update" Width="15em" MaxLength="30" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <asp:TextBox CssClass="form_field" ID="tbscLTMailAddr2Update" Width="15em" MaxLength="30" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <asp:TextBox CssClass="form_field" ID="tbscLTCityUpdate" Width="15em" MaxLength="30" runat="server"></asp:TextBox>
                                 <asp:TextBox CssClass="form_field" ID="tbscLTStateUpdate" Width="3em" MaxLength="3" runat="server"></asp:TextBox>
                                 <asp:TextBox CssClass="form_field" ID="tbscLTZipUpdate" Width="7em" MaxLength="10" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" valign="top">
                    <table border="0" cellpadding="1" cellspacing="1">
                        <tr>
                            <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label10" runat="server" Text="CC2 "></asp:Label>
                            </td>
                            <td valign="top">
                                 <asp:TextBox CssClass="form_field" ID="tbscLTCCopy2Update" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                    <asp:Label CssClass="form_field_heading" ID="Label11" runat="server" Text="CC3"></asp:Label>
                            </td>
                            <td valign="top">
                                 <asp:TextBox CssClass="form_field" ID="tbscLTCCopy3Update" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>   
    <asp:Panel ID="Panel2" GroupingText="Inspection Data" runat="server">

    <!--bubba2.txt -->

        <center style="margin-top: 5px;">
            <asp:LinkButton ID="lblNewInspection" CausesValidation="false" OnClick="lblNewInspection_OnClick" runat="server">New Inspection</asp:LinkButton>
        </center>
        <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewInspection">
            <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewInspectionTitle">
                <span>New Inspection</span>
            </asp:Panel>
            <asp:Panel runat="server" Style="text-align: center;" ID="Panel6" CssClass="newitemcontent">
                <table>
                    <tr>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Date"></asp:Label>
                        </td>
                        <td class="form_field">
                            <table><tr><td>
                            <asp:TextBox CssClass="form_field_date" ID="tbscDateNew" runat="server" width="60"></asp:TextBox>
                            </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                        ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibscDateNew" 
                                        runat="server" /></td></tr></table>
                            <ajaxToolkit:CalendarExtender ID="cescDateNew" runat="server"
                                TargetControlID="tbscDateNew"
                                Format="MM/dd/yyyy"
                                PopupButtonID="ibscDateNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" 
                                ID="revscDateNew"  Display="Dynamic" 
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbscDateNew" runat="server" 
                                ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                </table>

                <center>
                    <table cellpadding="3">
                        <tr>
                            <td>
                                <asp:Button  OnClientClick="javascript: return donewinspectionjedisok();" ID="btnNewInspectionOk" 
                                    runat="server" Text="Okay" OnClick="btnNewInspectionOk_Click" />
                            </td>
                            <td>
                                <asp:Button ID="btnNewInspectionCancel" runat="server" Text="Cancel" CausesValidation="false" 
                                    OnClientClick="javascript: if (confirm('Are you sure that you wish to cancel?')) {return true;} else {return false;}"
                                    OnClick="btnNewInspectionCancel_Click" />
                            </td>
                        </tr>
                    </table>
                </center>

            </asp:Panel>
            <script  language="javascript" type="text/javascript" >
                function donewinspectionjedisok() {
                    var loading = $(".loadingnewbpermit");
                    loading.show();
                    var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                    var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                    loading.css({ top: top, left: left });
                    return true;
                }
            </script>

        </asp:Panel>
        <asp:Button runat="server" ID="dummyNewInspection" style="display:none" />
        <ajaxToolkit:ModalPopupExtender ID="mpeNewInspection" runat="server" TargetControlID="dummyNewInspection"
            PopupControlID="pnlNewInspection" BackgroundCssClass="modalBackground" PopupDragHandleControlID="pnlNewInspectionTitle"
            />



    </asp:Panel>
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnSellRequestUpdate" OnClick="btnSellRequestUpdateOkay_Click" OnClientClick="javascript: return true;" runat="server" Text="Submit" />
        <asp:Label ID="lblSellRequestUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
        <asp:Label ID="lblDatePrintedHeading" runat="server" Text="Printed: "></asp:Label>
        <asp:Label ID="lblDatePrinted" runat="server" ></asp:Label>
        <asp:Button style="margin-left:1em;" ID="btnPrintForm" runat="server" CausesValidation="false" Text="Print Form" OnClientClick="javascript:alert('Not yet implemented');" /> 

    </center>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
    <asp:Panel runat="server" CssClass="newitempopup" Width="800" ID="pnlNewRequestId">
        <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewRequestTitleId">
            <span>New Request</span>
        </asp:Panel>
        <asp:Panel runat="server" style="text-align:center;" ID="pnlNewSubmittalContent" CssClass="newitemcontent">
            <p style="text-align:left;"> 
                RequestId  <asp:Label ID="lblAutoRequestId" runat="server"></asp:Label>
            </p>

         <asp:Panel ID="Panelbb1" GroupingText="Property Data" runat="server">
            <table border="0" cellpadding="2" cellspacing="2">
                <tr>
                    <td>
                        <asp:Label ID="Label17" runat="server" Text="Lot"></asp:Label>
                        <asp:TextBox ID="tbscLotNew" Width="40"  MaxLength="5" runat="server"></asp:TextBox>
                        <asp:Label runat="server" ForeColor="Red" ID="lblscLotNewErrorMsg"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label19" runat="server" Text="Lane"></asp:Label>
                        <asp:DropDownList EnableViewState="true" ID="ddlscLaneNew" Width="100" runat="server" DataTextField="Lane" DataValueField="Lane"></asp:DropDownList>
                        <asp:Label runat="server" ForeColor="Red" ID="lblddlscLaneNewErrorMsg"></asp:Label>
                    </td>
                </tr>
            </table>
         </asp:Panel>
         <asp:Panel ID="Panel3" GroupingText="Notification Letter Data" runat="server">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr valign="top">
                        <td valign="top" colspan="2">
                            <table border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td><asp:Label CssClass="form_field_heading" ID="Label4" runat="server" Text="Date "></asp:Label></td>
                                    <td>                    
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox CssClass="form_field" ID="tbLTDateNew" Width="10em" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ImageAlign="AbsMiddle" CausesValidation="false" ToolTip="Click to show date selector" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        ID="ibtbLTDateNew" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <ajaxToolkit:CalendarExtender ID="ceLTDateNew" runat="server" TargetControlID="tbLTDateNew"
                                            Format="MM/dd/yyyy" PopupButtonID="ibtbLTDateNew" />
                                        <asp:RegularExpressionValidator ForeColor="Red" ID="revLTDateNew" Display="Dynamic"
                                            ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                            ControlToValidate="tbLTDateNew" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label8" runat="server" Text="Recipient "></asp:Label>
                        </td>
                        <td valign="top">
                             <asp:TextBox CssClass="form_field" ID="tbscLTRecipientNew" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                        </td>
                        <td valign="top">
                            <asp:Label CssClass="form_field_heading" ID="Label9" runat="server" Text="CC1 "></asp:Label>
                        </td>
                        <td valign="top">
                             <asp:TextBox CssClass="form_field" ID="tbscLTCCopy1New" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td valign="top"><asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Realtor "></asp:Label></td>
                        <td valign="top">
                            <asp:DropDownList ID="ddlscRealtorNew"  Width="10em" DataTextField="RealtyCo" DataValueField="RealtyCo" runat="server"></asp:DropDownList>
                        </td>
                        <td valign="top">
                                <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Address "></asp:Label>
                        </td>
                        <td valign="top">
                            <table border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td>
                                         1: <asp:TextBox CssClass="form_field" ID="tbscLTMailAddr1New" Width="15em" MaxLength="30" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         2: <asp:TextBox CssClass="form_field" ID="tbscLTMailAddr2New" Width="15em" MaxLength="30" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         C: <asp:TextBox CssClass="form_field" ID="tbscLTCityNew" Width="15em" MaxLength="30" runat="server"></asp:TextBox>
                                         S: <asp:TextBox CssClass="form_field" ID="tbscLTStateNew" Width="3em" MaxLength="3" runat="server"></asp:TextBox>
                                         Z: <asp:TextBox CssClass="form_field" ID="tbscLTZipNew" Width="7em" MaxLength="10" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="2" valign="top">
                            <table border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td valign="top">
                                            <asp:Label CssClass="form_field_heading" ID="Label15" runat="server" Text="CC2 "></asp:Label>
                                    </td>
                                    <td valign="top">
                                         <asp:TextBox CssClass="form_field" ID="tbscLTCCopy2New" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                            <asp:Label CssClass="form_field_heading" ID="Label16" runat="server" Text="CC3"></asp:Label>
                                    </td>
                                    <td valign="top">
                                         <asp:TextBox CssClass="form_field" ID="tbscLTCCopy3New" Width="15em" MaxLength="35" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>   
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
                        <asp:Button ID="btnNewRequestOk" CausesValidation="true" OnClientClick="javascript: if(Page_IsValid) { return doOk();} " runat="server" Text="Okay" 
                            onclick="btnNewRequestOk_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btnNewRequestCancel" onclick="btnNewRequestCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to cancel?')" runat="server" Text="Cancel" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblRequestNewResults" Font-Bold="true" runat="server" Text=""></asp:Label>
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
    <asp:LinkButton ID="lbRequestNew" OnClick="lbRequestNewCmon_OnClick" CausesValidation="false" runat="server">New Request</asp:LinkButton>
    <asp:Button style="display:none;" ID="btnhidden1" runat="server" />

    <ajaxToolkit:ModalPopupExtender ID="mpeNewRequest" runat="server" TargetControlID="btnhidden1"
        PopupControlID="pnlNewRequestId" BackgroundCssClass="modalBackground" 
        PopupDragHandleControlID="pnlNewSubmittalTitleId"
        BehaviorID="jdpopupsubmittal" />
    <script language="javascript" type="text/javascript">

        function shown() {
            var tb = document.getElementById('<% =tbscLTRecipientNew.ClientID %>');
            tb.focus();
        }
        function pageLoad() {
            $addHandler(document, "keydown", OnKeyPress);
            var ddd = $find('jdpopupsubmittal');
            ddd.add_shown(shown);
        }

        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
                // I don't know about this                $find("jdpopup").hide();
            }
        }
    </script>
</asp:Content>


