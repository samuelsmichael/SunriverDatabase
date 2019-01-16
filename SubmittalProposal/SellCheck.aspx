<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true" CodeBehind="SellCheck.aspx.cs" Inherits="SubmittalProposal.SellCheck" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
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
        <asp:Label ID="Label18" runat="server" Text="Requestor"></asp:Label>
        <asp:TextBox ID="tbRecipient" Width="80" runat="server"></asp:TextBox>
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
                <td valign="top"><!--<asp:Label CssClass="form_field_heading" ID="Label12" runat="server" Text="Realtor "></asp:Label>--></td>
                <td valign="top">
                    <!--<asp:DropDownList ID="ddlscRealtorUpdate" DataTextField="RealtyCo" DataValueField="RealtyCo" runat="server"></asp:DropDownList>-->
                </td>
                <td valign="top">
                        <!--<asp:Label CssClass="form_field_heading" ID="Label7" runat="server" Text="Address "></asp:Label>-->
                </td>
                <td valign="top">
                    <!--<table border="0" cellpadding="1" cellspacing="1">
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
                    </table>-->
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

           <asp:GridView Width="100%" ID="gvInspections" runat="server" AutoGenerateColumns="False"
            CellPadding="4" ForeColor="#333333" GridLines="None" ShowFooter="True" OnRowCancelingEdit="gvInspections_RowCancelingEdit"
            OnRowEditing="gvInspections_RowEditing" 
            OnRowUpdating="gvInspections_RowUpdating" DataKeyNames="scInspectionId" 
            onrowdatabound="gvInspections_RowDataBound">
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
                <asp:CommandField ButtonType="Link" CausesValidation="false" ShowEditButton="true" ShowCancelButton="true" />
                <asp:TemplateField HeaderText="Insp ID">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("scInspectionID") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="fts" runat="server" Width="5em" Text='<%# Bind("scInspectionID") %>'></asp:Label>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date">
                    <EditItemTemplate>
                        <table border="0" cellpadding="1" cellspacing="1">
                            <tr>
                                <td>                    
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox Width="8em" Text='<%# Bind("scDate", "{0:MM/dd/yyyy}") %>' CssClass="form_field" 
                                                    ID="tbDateUpdate" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                                    ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                    ID="ibtbDateUpdate" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <ajaxToolkit:CalendarExtender ID="cetbDateUpdate" runat="server" TargetControlID="tbDateUpdate"
                                        Format="MM/dd/yyyy" PopupButtonID="ibtbDateUpdate" />
                                    <asp:RegularExpressionValidator ForeColor="Red" ID="revtbDateUpdate" Display="Dynamic"
                                        ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                        ControlToValidate="tbDateUpdate" runat="server" ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1a" runat="server" Text='<%# Bind("scDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Comments">
                    <ItemTemplate>
                        <asp:Label ID="Label4x3a" runat="server" Enabled="false" Height="2em" Text='<%# getBRsInsteadOfCRLFs(Eval("scComments")) %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="tbscCommentsUpdate" runat="server" Width="35em" TextMode="MultiLine" Height="10em" Text='<%# Bind("scComments") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Prepared By">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Width="6em" Text='<%# Bind("scPreparedBy") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="tbPreparedByUpdatge" runat="server" Width="8em" Text='<%# Bind("scPreparedBy") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ladder Fuel">
                    <ItemTemplate>
                        <asp:Label ID="Label1c" runat="server" 
                            Text='<%# Bind("scLadderFuel") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="dllscLadderFuelUpdate" Width="8em" runat="server" 
                            DataTextField="scLadderFuel" DataValueField="LadderFuel"></asp:DropDownList>
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Nox Weeds">
                    <ItemTemplate>
                        <asp:Label ID="Label4u" runat="server" Text='<%# Bind("scNoxWeeds") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlNoxWeedsUpdate" runat="server" 
                            DataTextField="scNoxWeeds" DataValueField="scNoxWeeds" Width="8em">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Follow Ups">
                    <ItemTemplate><asp:Label runat="server" ID="lblTesting" Text='<%# getBRsInsteadOfBars(Eval("FollowUpDescriptions")) %>'></asp:Label></ItemTemplate>
                    <EditItemTemplate>
                        <asp:GridView ID="gvFollowUpEditing" runat="server" 
                            AutoGenerateColumns="False"  ShowFooter="true"
                            onrowcancelingedit="GridView1_RowCancelingEdit" 
                            onrowdeleting="GridView1_RowDeleting" 
                            onrowediting="GridView1_RowEditing" 
                            onrowupdated="GridView1_RowUpdated" 
                            onrowupdating="GridView1_RowUpdating" 
                         
                            onrowcommand="gvFollowUpEditing_RowCommand">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1xx3xxx3gasd6664asdfasdfasdfasdfsfasfasfafa33zfx" ForeColor="Black" runat="server" CausesValidation="False" 
                                            CommandName="Edit" Text="Edit"></asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="LinkButton1xxx33xeasdfasdfasdft" ForeColor="Black" OnClientClick="javascript: return true;" runat="server" CausesValidation="False" 
                                            CommandName="Update" Text="Update"></asp:LinkButton>
                                        &nbsp;<asp:LinkButton ID="LinkButton2xyz" ForeColor="Black" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton2v3he" OnClientClick="javascript: return confirm('Are you sure?')" ForeColor="Black" runat="server" CausesValidation="False" 
                                            CommandName="Delete" Text="Delete"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Id" SortExpression="SellCheckFollowUpId">
                                    <ItemTemplate>
                                        <asp:Label ID="Label33dcx103" runat="server" Text='<%# Bind("SellCheckFollowUpId") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button CommandName="Insert" ID="btnAddFollowUp" runat="server" Text="Add" />
                                    </FooterTemplate>
                                </asp:TemplateField >

                                <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="Label33dc" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbscFollowUpDescriptionUpdate333" runat="server" Height="10em" 
                                            Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="35em"></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="tbscFollowUpDescriptionUpdateFooter" runat="server" Height="10em" 
                                            TextMode="MultiLine" Width="35em"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                
                            </Columns>
                        </asp:GridView>
                
                    </EditItemTemplate>
                </asp:TemplateField>


            </Columns>
        </asp:GridView>

        <center style="margin-top: 5px;">
            <asp:LinkButton ID="lblNewInspection" CausesValidation="false" OnClick="lblNewInspection_OnClick" runat="server">New Inspection</asp:LinkButton>
        </center>
        <asp:Panel runat="server" CssClass="newitempopup" ID="pnlNewInspection">
            <asp:Panel runat="server" CssClass="newitemtitle" ID="pnlNewInspectionTitle">
                <span>New Inspection</span>
            </asp:Panel>
            <asp:Panel runat="server" Style="text-align: center;" ID="Panel6" CssClass="newitemcontent">
                <table border="0" cellpadding="3" cellspacing="3">
                    <tr>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label22" runat="server" Text="Date "></asp:Label>
                        </td>
                        <td class="form_field">
                            <table><tr><td>
                            <asp:TextBox CssClass="form_field_date" ID="tbDateNew" runat="server" width="60"></asp:TextBox>
                            </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                        ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibDateNew" 
                                        runat="server" /></td></tr></table>
                            <ajaxToolkit:CalendarExtender ID="cescDateNew" runat="server"
                                TargetControlID="tbDateNew"
                                Format="MM/dd/yyyy"
                                PopupButtonID="ibDateNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" 
                                ID="revDateNew"  Display="Dynamic" 
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbDateNew" runat="server" 
                                ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <!--<td>
                            <asp:Label CssClass="form_field_heading" ID="Label24" runat="server" Text="Fee "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlFeeNew"  Width="8em" runat="server" 
                                DataTextField="InspectionFee" DataValueField="InspectionFee"                                  
                                OnDataBound="ddlFeeNew_DataBound"></asp:DropDownList>
                        </td>-->
                        <td class="form_field_heading">Prepared By</td>
                        <td>
                            <asp:TextBox ID="tbPreparedByNew" Width="8em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <!--<tr>
                        <td><asp:Label CssClass="form_field_heading" ID="Label25" runat="server" Text="Paid "></asp:Label></td>
                        <td>
                            <asp:CheckBox runat="server" ID="cbPaidNew" />
                        </td>
                        <td><asp:Label CssClass="form_field_heading" ID="Label26" runat="server" Text="Paid Memo "></asp:Label></td>
                        <td>
                            <asp:TextBox CssClass="form_field_date" ID="tbPaidMemoNew" runat="server" width="60">
                            </asp:TextBox>
                        </td>
                        <td><asp:Label CssClass="form_field_heading" ID="Label27" runat="server" Text="Date Closed "></asp:Label></td>
                        <td>
                            <table><tr><td>
                            <asp:TextBox CssClass="form_field_date" ID="tbDateClosedNew" runat="server" width="60"></asp:TextBox>
                            </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                        ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibDateClosedNew" 
                                        runat="server" /></td></tr></table>
                            <ajaxToolkit:CalendarExtender ID="ceDatePaidNew" runat="server"
                                TargetControlID="tbDateClosedNew"
                                Format="MM/dd/yyyy"
                                PopupButtonID="ibDateClosedNew" />
                            <asp:RegularExpressionValidator ForeColor="Red" 
                                ID="retbDateClosedNew"  Display="Dynamic" 
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbDateClosedNew" runat="server" 
                                ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>

                        </td>
                    </tr> -->
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label28" runat="server" Text="Ladder Fuel "></asp:Label>
                        </td>
                        <td>
                           <asp:DropDownList ID="ddlLadderFuelNew" Width="8em" runat="server" DataTextField="LadderFuel" DataValueField="LadderFuel"></asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label29" runat="server" Text="Nox Weeds "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlNoxWeedsNew" Width="8em" runat="server" DataTextField="LadderFuel" DataValueField="LadderFuel"></asp:DropDownList>
                        </td>
                        <!--<td></td>
                        <td></td>-->
                    </tr>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label30" runat="server" Text="Comments "></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox Height="8em" TextMode="MultiLine"  Font-Size="Medium" ID="tbCommentsNew" runat="server" width="40em"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label31" runat="server" Text="Follow Up "></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox Height="8em" TextMode="MultiLine"  ToolTip="Distinguish different Follow-Up records by three stars (***)"  Font-Size="Medium" ID="tbFollowUpNew" runat="server" width="40em"></asp:TextBox>
                        </td>
                    </tr>
                </table>

                <center>
                    <table cellpadding="3">
                        <tr>
                            <td>
                                <asp:Button CausesValidation="true"  OnClientClick="javascript: return donewinspectionjedisok();" ID="btnNewInspectionOk" 
                                    runat="server" Text="Okay" OnClick="btnNewInspectionOk_Click" />
                            </td>
                            <td>
                                <asp:Button ID="btnNewInspectionCancel" runat="server" Text="Abort" CausesValidation="false" 
                                    OnClientClick="javascript: if (confirm('Are you sure that you wish to abort?')) {return true;} else {return false;}"
                                    OnClick="btnNewInspectionCancel_Click" />
                            </td>
                        </tr>
                    </table>
                </center>

            </asp:Panel>

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
        <asp:Button style="margin-left:1em;" ID="btnPrintForm" runat="server" OnClick="btnPrintForm_OnClick" CausesValidation="false" Text="Print Form" OnClientClick="javascript:window.print(); return true;" /> 

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
                        <asp:TextBox ID="tbscLotNew" Width="40"  MaxLength="5" runat="server" ></asp:TextBox>
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
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:Label CssClass="form_field_heading" ID="Label4s" runat="server" Text="Date "></asp:Label></td>
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
                        <td valign="top"><!--<asp:Label CssClass="form_field_heading" ID="Label13" runat="server" Text="Realtor "></asp:Label>--></td>
                        <td valign="top">
                            <!--<asp:DropDownList ID="ddlscRealtorNew"  Width="10em" DataTextField="RealtyCo" DataValueField="RealtyCo" runat="server"></asp:DropDownList>-->
                        </td>
                        <td valign="top">
                                <!-- <asp:Label CssClass="form_field_heading" ID="Label14" runat="server" Text="Address "></asp:Label>-->
                        </td>
                        <td valign="top">
                            <!--<table border="0" cellpadding="1" cellspacing="1">
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
                            </table>-->
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
         <asp:Panel ID="Panel33x991" GroupingText="Inspection" runat="server">
           <asp:Panel runat="server" Style="text-align: center;" ID="Panel4" CssClass="newitemcontent">
                <table border="0" cellpadding="3" cellspacing="3">
                    <tr>
                        <td class="form_field_heading">
                            <asp:Label CssClass="form_field_heading" ID="Label22zz3" runat="server" Text="Date "></asp:Label>
                        </td>
                        <td class="form_field">
                            <table><tr><td>
                            <asp:TextBox CssClass="form_field_date" ID="tbDateNewNewRequest" runat="server" width="60"></asp:TextBox>
                            </td><td><asp:ImageButton ImageAlign="AbsMiddle" ToolTip="Click to show date selector" 
                                        ImageUrl="~/Images/Calendar_scheduleHS.png" ID="ibDateNewNewRequest" 
                                        runat="server" /></td></tr></table>
                            <ajaxToolkit:CalendarExtender ID="cescDateNewNewRequest" runat="server"
                                TargetControlID="tbDateNewNewRequest"
                                Format="MM/dd/yyyy"
                                PopupButtonID="ibDateNewNewRequest" />
                            <asp:RegularExpressionValidator ForeColor="Red" 
                                ID="revDateNewNewRequest"  Display="Dynamic" 
                                ValidationExpression="^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$"
                                ControlToValidate="tbDateNewNewRequest" runat="server" 
                                ErrorMessage="Please enter a valid date"></asp:RegularExpressionValidator>
                        </td>
                        <td class="form_field_heading">Prepared By</td>
                        <td>
                            <asp:TextBox ID="tbPreparedByNewNewRequest" Width="8em" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label28NewRequest" runat="server" Text="Ladder Fuel "></asp:Label>
                        </td>
                        <td>
                           <asp:DropDownList ID="ddlLadderFuelNewNewRequest" Width="8em" runat="server" DataTextField="LadderFuel" DataValueField="LadderFuel"></asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label29NewRequest" runat="server" Text="Nox Weeds "></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlNoxWeedsNewNewRequest" Width="8em" runat="server" DataTextField="LadderFuel" DataValueField="LadderFuel"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label30NewRequest" runat="server" Text="Comments "></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox Height="8em" TextMode="MultiLine"  Font-Size="Medium" ID="tbCommentsNewNewRequest" runat="server" width="40em"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label CssClass="form_field_heading" ID="Label31NewRequest" runat="server" Text="Follow Up "></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox Height="8em" TextMode="MultiLine" Font-Size="Medium" ID="tbFollowUpNewNewRequest" runat="server" width="40em"></asp:TextBox>
                        </td>
                    </tr>
                </table>


            </asp:Panel>
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
            function donewinspectionjedisok() {
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
                    var loading = $(".loadingdb");
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
                        <asp:Button ID="btnNewRequestCancel" onclick="btnNewRequestCancel_Click" OnClientClick="javascript: return confirm('Are you sure that you wish to abort?')" runat="server" Text="Abort" />
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


