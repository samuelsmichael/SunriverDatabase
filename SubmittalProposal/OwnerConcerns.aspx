<%@ Page Title="" Language="C#" MasterPageFile="~/Database.master" AutoEventWireup="true"
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
        <asp:TextBox ID="tbOwnerConcernsNameLU" Width="8em" runat="server"></asp:TextBox>
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
        <asp:TextBox ID="tbOwnerConcernsSunriverAddressLU" Width="8em" runat="server"></asp:TextBox>
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
                <asp:BoundField DataField="SRLotLane" HeaderText="SR Address" 
                    SortExpression="SRLotLane" >
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
    <asp:Panel runat="server" ID="pnlOwnerConcernsClientInfo" GroupingText="Owner Info">
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
        <asp:Panel runat="server" ID="pnlOwnersConcernsMailingInfo" GroupingText="Mailing Address">
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
    <center>
        <asp:Button Style="margin-bottom: 14px; margin-top: 14px;" CausesValidation="true"
            ID="btnOwnerConcernsUpdate" OnClick="btnOwnerConcernsUpdateOkay_Click" OnClientClick="javascript: return true;"
            runat="server" Text="Submit" />
        <asp:Label ID="lblOwnerConcernsUpdateResults" Font-Bold="true" runat="server" Text=""></asp:Label>
    </center>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="NewItemContent" runat="server">
</asp:Content>
