using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;

namespace SubmittalProposal
{
    public partial class Submittal : System.Web.UI.Page
    {
        private DataSet buildDataSet() {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("OwnersName"));
            dt.Columns.Add(new DataColumn("Lot"));
            dt.Columns.Add(new DataColumn("Lane"));
            dt.Columns.Add(new DataColumn("Block"));
            dt.Columns.Add(new DataColumn("Village"));
            dt.Columns.Add(new DataColumn("ProjectType"));
            dt.Columns.Add(new DataColumn("MeetingDate"));
            dt.Columns.Add(new DataColumn("ExpDate"));
            dt.Columns.Add(new DataColumn("Project"));
            dt.Columns.Add(new DataColumn("Decision"));
            dt.Columns.Add(new DataColumn("Contractor"));
            dt.Columns.Add(new DataColumn("Applicant"));
            dt.Columns.Add(new DataColumn("SubmittalId"));
            dt.Columns.Add(new DataColumn("BPermitId"));
            dt.Columns.Add(new DataColumn("Conditions"));
            dt.Columns.Add(new DataColumn("Submittal"));
            ds.Tables.Add(dt);
            DataRow dr1 = dt.NewRow();
            dr1["OwnersName"] = "Mike Samuels";
            dr1["Lot"] = "1";
            dr1["Lane"] = "Squirrel";
            dr1["Village"] = "MVE II";
            dr1["ProjectType"] = "ALT";
            dr1["MeetingDate"] = "4/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "7/04/2015";
            dr1["Project"] = "Water fountain";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Doug Rohan Construction";
            dr1["Applicant"] = "Steven Smith";
            dr1["SubmittalId"]="12345";
            dr1["BPermitId"] = "73190";
            dr1["Conditions"] = "1.  The submitted site plan does not note depth of common past the rear \n"+
                                "property line, nor show tree to be removed or saved accurately.  The \n"+
                                "site plan should be re-submitted for review and approval.\n\n"+
                                "2.  The elevation plans submitted show no attic venting.  Space should \n"+
                                "be vented with eave and gable vents or eave vents with continuous vented \n"+
                                "ridge.\n\n"+
                                "3.  The exterior elevation section of the proposed privacy screen or \n"+
                                "fence should be resubmitted with a wall section.";
            dr1["Submittal"] = "Build a very large water landscape that includes a fountain.";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Jason Schneider";
            dr1["Lot"] = "10";
            dr1["Lane"] = "Tumalo";
            dr1["Village"] = "MVW I";
            dr1["ProjectType"] = "ALT";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Swimming Pool";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Wendy Brinkley";
            dr1["Applicant"] = "George Smith";
            dr1["SubmittalId"] = "234567";
            dr1["BPermitId"] = "73410";
            dr1["Conditions"] = "All work must be done by the beginning of summer.";
            dr1["Submittal"] = "Build an olympic-sized swimming pool in the backyard.";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Ralph Jones";
            dr1["Lot"] = "2";
            dr1["Lane"] = "Squirrel";
            dr1["Village"] = "MVW II";
            dr1["ProjectType"] = "ALT";
            dr1["MeetingDate"] = "4/19/2015";
            dr1["Block"] = "11";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Build hanging garden";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Jack Gardener";
            dr1["Applicant"] = "Billie Jones";
            dr1["SubmittalId"] = "244567";
            dr1["BPermitId"] = "72410";
            dr1["Conditions"] = "Must have proper drainage and sprinkler system";
            dr1["Submittal"] = "Build hanging garden";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Roy Rogers";
            dr1["Lot"] = "5";
            dr1["Lane"] = "Squirrel";
            dr1["Village"] = "MVE I";
            dr1["ProjectType"] = "NEW";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Painting exterior";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Jonathan Painter";
            dr1["Applicant"] = "Dale Evans";
            dr1["SubmittalId"] = "4567";
            dr1["BPermitId"] = "410";
            dr1["Conditions"] = "Colors must be Fall colors";
            dr1["Submittal"] = "Exterior Paint Job";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Gilbert Sullivan";
            dr1["Lot"] = "9";
            dr1["Lane"] = "Squirrel";
            dr1["Village"] = "RV III";
            dr1["ProjectType"] = "MA";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Hot tub";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Wella Jonas";
            dr1["Applicant"] = "Jim Fisher";
            dr1["SubmittalId"] = "234567";
            dr1["BPermitId"] = "73410";
            dr1["Conditions"] = "Colors shall be submitted later for siding and rail system for administrative approval.  New pavers shall match existing.";
            dr1["Submittal"] = "Deck/Wall/Hot tub";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Jerry Halbrought";
            dr1["Lot"] = "6";
            dr1["Lane"] = "Squirrel";
            dr1["Village"] = "";
            dr1["ProjectType"] = "AA";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "4";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Add heater storage";
            dr1["Decision"] = "DEF";
            dr1["Contractor"] = "J Heater, Inc";
            dr1["Applicant"] = "";
            dr1["SubmittalId"] = "2567";
            dr1["BPermitId"] = "70";
            dr1["Conditions"] = "None";
            dr1["Submittal"] = "Add heater storage";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Fred Flintstone";
            dr1["Lot"] = "10";
            dr1["Lane"] = "Shadow";
            dr1["Village"] = "MV I";
            dr1["ProjectType"] = "Skylights";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Skylights";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "United Roofs";
            dr1["Applicant"] = "Steven Smith";
            dr1["SubmittalId"] = "1567";
            dr1["BPermitId"] = "7310";
            dr1["Conditions"] = "Waterproofing of 2nd degree";
            dr1["Submittal"] = "Addition of skylights";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Laneita Cox";
            dr1["Lot"] = "7";
            dr1["Lane"] = "Sarazen";
            dr1["Village"] = "MV I";
            dr1["ProjectType"] = "NEW";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Deck and spa";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Hot Tubs and Decks, LLC";
            dr1["Applicant"] = "Cox Communications";
            dr1["SubmittalId"] = "23967";
            dr1["BPermitId"] = "7010";
            dr1["Conditions"] = "Must be birch wood color";
            dr1["Submittal"] = "Deck and spa";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Mickey Mantel";
            dr1["Lot"] = "7";
            dr1["Lane"] = "Sandtrap";
            dr1["Village"] = "MW I";
            dr1["ProjectType"] = "NEW";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Build a baseball field, and they will come.";
            dr1["Decision"] = "A";
            dr1["Contractor"] = "Philadelphia Ball Parks";
            dr1["Applicant"] = "Yogi Berra";
            dr1["SubmittalId"] = "237";
            dr1["BPermitId"] = "110";
            dr1["Conditions"] = "Must have 20' outfield walls";
            dr1["Submittal"] = "Full-sized baseball park";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Jack Rickstraw";
            dr1["Lot"] = "4";
            dr1["Lane"] = "Salishan";
            dr1["Village"] = "MWM I";
            dr1["ProjectType"] = "NEW";
            dr1["MeetingDate"] = "7/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "12/04/2015";
            dr1["Project"] = "Swimming pool";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Bill's Pools";
            dr1["Applicant"] = "Bill";
            dr1["SubmittalId"] = "21267";
            dr1["BPermitId"] = "1310";
            dr1["Conditions"] = "Lifeguard stand";
            dr1["Submittal"] = "Swimming Pool";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Phil Lewis";
            dr1["Lot"] = "12";
            dr1["Lane"] = "Sandtrap";
            dr1["Village"] = "FCV IV";
            dr1["ProjectType"] = "NEW";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Practice Putting Green";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "Green Thumbs, Inc";
            dr1["Applicant"] = "Arnold Palmer";
            dr1["SubmittalId"] = "2673";
            dr1["BPermitId"] = "73";
            dr1["Conditions"] = "Must be surrounded by trees";
            dr1["Submittal"] = "Putting green";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Marre mais Marre";
            dr1["Lot"] = "3";
            dr1["Lane"] = "Sequoia";
            dr1["Village"] = "FP II";
            dr1["ProjectType"] = "Roof";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Roof";
            dr1["Decision"] = "A";
            dr1["Contractor"] = "Bend Roofing";
            dr1["Applicant"] = "Steve Silverthorne";
            dr1["SubmittalId"] = "277";
            dr1["BPermitId"] = "774";
            dr1["Conditions"] = "Body color approved.  Applicant shall find antoher trim color more in \n"+
                    "keeping with current design committee guidelines.";
            dr1["Submittal"] = "New roof";
            dt.Rows.Add(dr1);
            dr1 = dt.NewRow();
            dr1["OwnersName"] = "Ktms Enterprises";
            dr1["Lot"] = "4";
            dr1["Lane"] = "Shadow";
            dr1["Village"] = "DP IV";
            dr1["ProjectType"] = "NEW";
            dr1["MeetingDate"] = "3/19/2015";
            dr1["Block"] = "14";
            dr1["ExpDate"] = "5/04/2015";
            dr1["Project"] = "Storage room addition";
            dr1["Decision"] = "AWC";
            dr1["Contractor"] = "";
            dr1["Applicant"] = "Fresna Sunshine";
            dr1["SubmittalId"] = "1381";
            dr1["BPermitId"] = "4013";
            dr1["Conditions"] = "Trim color (fascia only) is approved. Body color is too light.Sugggest \n"+
                    "one shade darker #5363m country twill.";
            dr1["Submittal"] = ".";
            dt.Rows.Add(dr1);
            return ds;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                gvResults.DataSource= buildDataSet();
                gvResults.DataBind();
            }
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            CPESearch.CollapsedText = "";
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend="";
            string and = "";
            if (Utils.isNothingNot(tbOwner.Text)) {
                sb.Append(prepend+"Owner: " + tbOwner.Text);
                prepend="  ";
                sbFilter.Append(and + " OwnersName like '*" + tbOwner.Text +"*'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbApplicant.Text)) {
                sb.Append(prepend + "Applicant: " + tbApplicant.Text);
                prepend = "  ";
                sbFilter.Append(and + " Applicant like '*" + tbApplicant.Text + "*'");
                and = " and ";
            }
            if(Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " Lot like '*" + tbLot.Text + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower()!="choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " Lane like '*" + ddlLane.SelectedValue + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbSubmittalId.Text)) {
                sb.Append(prepend + "Submittal Id: " + tbSubmittalId.Text);
                prepend = "  ";
                sbFilter.Append(and + " SubmittalId like '*" + tbSubmittalId.Text + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbBPermitId.Text)) {
                sb.Append(prepend + "BPermit Id: " + tbBPermitId.Text);
                prepend = "  ";
                sbFilter.Append(and + " BPermitId like '*" + tbBPermitId.Text + "*'");
                and = " and ";
            }

            CPEDataGrid.CollapsedText = "";

            CPESearch.CollapsedText = sb.ToString();
            CPESearch.Collapsed = true;
            CPESearch.ClientState = "true";
            DataSet ds = buildDataSet();
            if (sbFilter.Length > 0) {
                DataTable sourceTable = ds.Tables[0];
                DataView view = new DataView(sourceTable);
                view.RowFilter = sbFilter.ToString();
                DataTable tblFiltered = view.ToTable();
                gvResults.DataSource = tblFiltered;
                gvResults.DataBind();
            } else {
                gvResults.DataSource = ds;
                gvResults.DataBind();
            }
            CPEDataGrid.Collapsed=false;
            CPEDataGrid.ClientState = "false";
        }
        private string getSubmittalId(GridViewRow dr) {
            return dr.Cells[13].Text;
        }
        private string getOwner(DataRow dr) {
            return (string)dr["OwnersName"];
        }
        private string getMeetingDate(DataRow dr) {
            return (string)dr["MeetingDate"];
        }
        private string getBPermitId(DataRow dr) {
            return (string)dr["BPermitId"];
        }
        private string getLotLane(DataRow dr) {
            return ((string)dr["Lot"]) + "\\" + (string)dr["Lane"];
        }
        protected void gvResults_SelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj=row.Cells;
            CPEDataGrid.CollapsedText = "Selected Submittal Id: " + getSubmittalId(row);
            CPEDataGrid.Collapsed = true;
            CPEDataGrid.ClientState = "true";

            DataSet ds = buildDataSet();
            DataTable sourceTable = ds.Tables[0];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "SubmittalId="+getSubmittalId(row);
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            tbConditions.Text = (string)dr["Conditions"];
            tbOwnersName.Text = (string)dr["OwnersName"];
            tbLotName2.Text = (string)dr["Lot"];
            ddlLane2.SelectedValue= (string)dr["Lane"];
            tbApplicantName2.Text = (string)dr["Applicant"];
            tbContractorBB.Text = (string)dr["Contractor"];
            tbMeetingDate.Text = (string)dr["MeetingDate"];
            ddlProjectType.SelectedValue = (string)dr["ProjectType"];
            ddlProjectDecision.SelectedValue = (string)dr["Decision"];
            tbProject.Text = (string)dr["Project"];
            tbSubmittal.Text = (string)dr["Submittal"];

            CPEForm.ExpandedText = "Lot\\Lane: " + getLotLane(dr)+ "  Submittal Id: " + getSubmittalId(row) + "  BPermitId :" + getBPermitId(dr) + "  Meeting Date: " + getMeetingDate(dr) + " Owner: " + getOwner(dr);
            CPEForm.Collapsed = false;
            CPEForm.ClientState = "false";
        }

        protected void gvResults_Sorting(object sender, GridViewSortEventArgs e) {

            DataSet ds = buildDataSet();
            DataTable sourceTable = ds.Tables[0];
            DataView view = new DataView(sourceTable);
            if (ViewState["sortExpression"] == null) {
                ViewState["sortExpression"] = e.SortExpression + " desc";
            }
            string[] sortData = ViewState["sortExpression"].ToString().Trim().Split(' ');
            if (e.SortExpression == sortData[0]) {
                if (sortData[1] == "ASC") {
                    view.Sort = e.SortExpression + " " + "DESC";
                    this.ViewState["sortExpression"] = e.SortExpression + " " + "DESC";
                } else {
                    view.Sort = e.SortExpression + " " + "ASC";
                    this.ViewState["sortExpression"] = e.SortExpression + " " + "ASC";
                }
            } else {
                view.Sort = e.SortExpression + " " + "ASC";
                this.ViewState["sortExpression"] = e.SortExpression + " " + "ASC";
            }
            DataTable tblOrdered = view.ToTable();
            ((GridView)sender).DataSource = tblOrdered;
            ((GridView)sender).DataBind();
        }
    }
}