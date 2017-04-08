<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BlankWorkOrderSROA.aspx.cs" Inherits="SubmittalProposal.Reports.SROAVehicleMaintenance.BlankWorkOrderSROA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1 {
            width: 88px;
            height: 131px;
        }
    </style>
    <style type="text/css" media="print">
         .noprint 
         {
             display:none !important;
         }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height:100%;">
    <div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="10%"><img alt="SROA" class="style1" 
                    longdesc="SROA" src="../../Images/SROA2.png" /></td>
                <td width="70%" align="center">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style=" text-align:center; font-size:14pt; font-weight:bold; border: medium solid #000000; padding-left:2em; padding-right:2em;">SROA</td>
                        </tr>
                        <tr>
                            <td  style=" text-align:center; font-size:18pt; font-weight:bold; text-decoration:underline; border: medium solid #000000; padding-left:2em; padding-right:2em;">Vehicle Maintenance<br />Work Sheet</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="2" cellspacing="0">
                        <tr >
                            <td></td>
                            <td></td>
                            <td>
                                <input disabled="disabled" style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text4" type="text"  value="SROA-" />
                            </td>                        
                        </tr>
                        <tr >
                            <td style="border-right: medium solid black;">Data&nbsp;</td>
                            <td>&nbsp;By:</td>
                            <td>
                                <input style="border: thin  solid black;text-align:center;height:1.7em; width:13em;" id="Text3" type="text" />
                            </td>                        
                        </tr>
                        <tr>
                            <td style="border-right: medium solid black;">Entry&nbsp;</td>
                            <td>&nbsp;Date:</td>
                            <td>
                                <input style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text2" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2">Estimate</td>
                            <td>
                                <input style="border: thin solid black; text-align:center; height:1.7em; width:13em;" id="Text1" type="text" /></td>
                        </tr>
                    </table>                    
                </td>
            </tr>
        </table><br />
        <table width="100%" border="0" cellpadding="2" cellspacing="0">
            <tr>
                <td width="38%">
                    <table width="100%" border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <td></td>
                            <td>Vehicle Number:<br /><input style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text5" type="text" /></td></tr>
                        <tr>
                            <td align="right"><b>Requested By:</b>&nbsp;</td>
                            <td><input style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text7" type="text" /></td>
                        </tr>
                        <tr>
                            <td align="right"><b>Requested Date In:</b>&nbsp;</td>
                            <td><input style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text8" type="text" /></td>
                        </tr>
                        <tr>
                            <td align="right"><b>Vehicle Date Out:</b>&nbsp;</td>
                            <td><input style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text9" type="text" /></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table width="100%" border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <td width="15%" align="right" style="padding-right:5px;"><b>Nature of<br />Request:</b></td>
                            <td><input style="border: thin solid black;text-align:center;height:7em;width:42em;" id="Text6" type="text" /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <table border="0" cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td><b>Odometer Reading:</b></td>
                                        <td><input style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text11" type="text" /></td>
                                        <td><b>Hour Meter:</b></td>
                                        <td><input style="border: thin solid black;text-align:center;height:1.7em; width:13em;" id="Text10" type="text" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table><br />
        <table width="100%">
            <tr>
                <td width="10%" align="right"><b>Procedure<br />Performed<br />On Vehicle:</b></td>
                <td><input style="border: thin solid black;text-align:center;height:10em;width:100%" id="Text67" type="text" /></td>
            </tr>
        </table><br />
        <table width="100%">
            <tr>
                <td width="10%" align="right"><b>Parts<br />Used<br />on This<br />Work<br />Order</b></td>
                <td>
                    <table width="100%" cellpadding="1" cellspacing="1">
                        <tr>
                            <th></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="60%"><b>Description</b></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="15%"><b>Part #</b></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="12%"><b>Rate</b></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="13%"><b>Quantity</b></th>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>1</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text12" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text12" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text13" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text14" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>2</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text15" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text16" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text17" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text18" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>3</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text19" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text20" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text21" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text22" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>4</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text23" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text24" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text25" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text26" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>5</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text27" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text28" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text29" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text30" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>6</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text31" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text32" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text33" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text34" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>7</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text35" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text36" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text37" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text38" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>8</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text39" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text40" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text41" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text42" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>9</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text43" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text44" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text45" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text46" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>10</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text47" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text48" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text49" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text50" type="text" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div style="width:100%; margin-top:5px; font-size:9pt; font-style:italic; text-decoration:underline; text-align:center;">
            For more parts, mechanics or services, attach additional sheets.  Database for each Vehicle Work<br />
            Order can accomodate an unlimited number of parts, labor or services enteries.         
        </div>
        <table width="100%">
            <tr>
            <td align="left" style="width:60%;">
        <table style="margin-top:5px; width="75%">
            <tr>
                <td width="10%" align="right"><b>Mechanics<br />on this<br />Work<br />Order</b></td>
                <td>
                    <table width="100%" cellpadding="1" cellspacing="1">
                        <tr>
                            <th></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="60%"><b>Mechanic</b></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="20%"><b>Rate - $/Hr</b></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="20%"><b>Hours</b></th>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>1</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text51" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text52" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text57" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>2</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text53" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text54" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text58" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>3</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text55" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text59" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text56" type="text" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
            </td>
            <td class="noprint" align="center">
                <input type="button" style="  background-color:#eeeeee; color:#119988; font-weight:bold; text-align:center;padding:3px;width:12em; height:6em;"onClick="javascript:window.print();" value="Print Blank Work Order" />
                <asp:Button runat="server" ID="btnGoBack" OnClick="btnGoBack_OnClick" Text="Exit" />
            </td>
        </tr>
        </table>
        <table style="margin-top:5px; width="100%">
            <tr>
                <td width="10%" align="right"><b>Contracted<br />Services<br />on this<br />Work<br />Order</b></td>
                <td>
                    <table width="100%" cellpadding="1" cellspacing="1">
                        <tr>
                            <th></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="60%"><b>Description</b></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="20%"><b>Vendor</b></th>
                            <th style="border: thin solid black;text-align:center;" align="center" width="20%"><b>Cost</b></th>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>1</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text60" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text61" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text62" type="text" /></td>
                        </tr>
                        <tr>
                            <td style="background-color:Gray;border: thin solid black;text-align:center; padding-left:3px; padding-right:3px;"><center>2</center></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text63" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text64" type="text" /></td>
                            <td><input style="width:100%;border: thin solid black;text-align:center;width:100%;height:1.7em;" id="Text65" type="text" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div style="margin-top:11px; text-decoration:underline;"><b>Comments:</b></div>
        <div style="width:100%;">
            <input style="width:100%;border: thin solid black;text-align:center;width:100%;height:5em;" id="Text66"  type="text" />
        </div>
        </div>
    </form>
</body>
</html>
