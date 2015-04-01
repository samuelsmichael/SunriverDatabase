<%@ Page Title="About Us" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="SubmittalProposal.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2 style="margin-bottom:8px;">
        Release notes
    </h2>
    <div style="height:350px;overflow:scroll;">
        <ul>
            <li  style="font-weight:bold;">Version .11</li>
                <ul>
                    <li>Modifications to the Search Results in Submittal</li>
                    <li>Meeting Date is mandatory</li>
                    <li>Incorporated "keep record locked" function.  Note, currently this function is only working with the Submittals page, since the other two pages don't yet actually perform updates or adds.</li>
                    <li>Hide the Go To Permit link if the Project Decision is anything other than A or AWC.</li>
                    <li>Project Fees section removed.</li>
                    <li>New Submittal panel now shows the new SubmittalId at the top of the page.</li>
                </ul>
            <li  style="font-weight:bold;">Version .10</li>
                <ul>
                    <li>Update and add functions work in Submittal</li>
                </ul>
            <li style="font-weight:bold;">Version .09 </li>
                <ul>First Crystal Report</ul>
            <li style="font-weight:bold;">Version .08 </li>
            <ul>
                <li>Search of lane is no longer a "like"-type search.  Instead, it's an "exact-match"-type search.</li>
                <li>All "new" links (e.g. - New Submittal, New Payment) now function.</li>
                <li>Payments and Reviews grids (in Building Permit) now demonstrate the editing function.</li>
            </ul>
            <p>
                This completes the "wireframes" construction.  Please note that these wireframes are for purposes
                of defining the layout and the flow.  They do not perform database updates or changes.
            </p>
            <p>The steps that follow before going live are:</p>
            <ol>                
                <li>Perform the updating to the database</li>
                <li>Write the reports</li>
                <li>Incorporate Authorization/Security</li>
            </ol>
        </ul>        
        <ul>
            <li style="font-weight:bold;">Version .07 </li>
            <ul>
                <li>Search of lot number is no longer a "like"-type search.  Instead, it's an "exact-match"-type search.</li>
                <li>Fixed a bug: Compliance Review wasn't coming up.</li>
                <li>Just the first glimpse of how I propose to handle the "new item" function ... using "modal popups".  This is available on Submittals, only.</li>
            </ul>
        </ul>        
        <ul>
            <li style="font-weight:bold;">Version .06 </li>
            <ul>
                <li>Now showing data from actual databases (as of mid-March).</li>
            </ul>
        </ul>
        <ul>
            <li style="font-weight:bold;">Version .05 </li>
            <ul>
                <li>Fixed a problem happening in Chrome: the Compliance Letter (paging) control was being cut-off at the bottom</li>
            </ul>
        </ul>
        <ul>
            <li style="font-weight:bold;">Version .04 </li>
            <ul>
                <li>Compliance Review database</li>
                <ul>
                    <li>Notes</li>
                    <ul>
                        <li>All the data in this database is included.</li>
                        <li>There are two versions of the Compliance Letter tab.  One uses paging, one uses scrolling.  Which do you like better?  (ReviewId 144 is an example of 2 Compliance Letters)</li>
                    </ul>
                </ul>
            </ul>
        </ul>
        <ul>
            <li style="font-weight:bold;margin-bottom:5px;margin-top:5px;">Version .03 </li>
            <ul>
                <li>Enhancements</li>
                <ul>
                    <li><b>Date Expired</b> is now computed (DateIssued + <i>nbr of months paid</i>).</li>
                    <li><b>Date Expired</b> is shown in red if it's past today.</li>
                </ul>
            
            </ul>
        </ul>
        <ul>
            <li style="font-weight:bold;margin-bottom:5px;margin-top:5px;">Version .02 </li>
            <ul>
                <li>Enhancements</li>
                <ul>
                    <li>Building Permit page is coded</li>
                    <li>On the Submittal form, the submittal section is on the same tab as the Applicant information</li>
                    <li>Added IsCommercial to Submittals database</li>
                    <li>You can now put *blank into a search textbox, and this means: "items whose value is blank"</li>
                    <li>On the Submittal form, there is now a link to the Permit page</li>
                </ul>
            
            </ul>
        </ul>
        <ul>
            <li style="font-weight:bold;margin-bottom:5px;">Version .01 </li>
            <ul>
                <li>The top panel allows users to make certain selection criteria. The criteria act
                    like the LIKE command in SQL. Thus, if you key in MI for the Owner's Name field,
                    then you'll get all records that have "mi" anywhere. You can test this ... but note
                    that for the purposes of this demonstration, all the fields are simple text fields.
                    Keep this in mind if you try to filter by a date field. </li>
                <li>The middle panel defaults to showing all of the rows; and then is filtered by the
                    selection panel. Note the following:
                    <ul>
                        <li>I am just showing a few fields here for demonstration purposes. In the live system
                            we will show all or any fields that you like. </li>
                        <li>You will be able to sort on any field. </li>
                        <li>There will be scroll bars both vertically as well as horizontally, as necessary.
                        </li>
                        <li>The color scheme is, of course, configurable. </li>
                        <li>When the user presses the select link, then the bottom panel -- the Form Panel opens.
                        </li>
                    </ul>
                </li>
                <li>The Form Panel will ressemble your current form. I have just thrown something together
                    here so that we can discuss this "Expandable Panels" paradigm. </li>
            </ul>        
        </ul>    
    </div>
</asp:Content>
