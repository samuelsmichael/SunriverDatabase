using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;

namespace SubmittalProposal
{
    public partial class Submittal2 : AbstractDatabase
    {
         protected override GridView getGridViewResults() {
            return gvResults;
        }
         public static DataSet SunriverDataSet() {
             DataSet ds = null;
             MemoryCache cache = MemoryCache.Default;
             string key = "SubmittalDS";
             ds = (DataSet)cache[key];
             if (ds == null) {
                 SqlCommand cmd = new SqlCommand("uspSubmittalsGetLogical");
                 ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                 ds.Tables[0].TableName = "Submittals";
                 CacheItemPolicy policy = new CacheItemPolicy();
                 policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                 cache.Add(key, ds, policy);
             }
             return ds;
         }
        protected override DataSet buildDataSet() {
            return SunriverDataSet();
        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend="";
            string and = "";
            if (Utils.isNothingNot(tbOwner.Text)) {
                sb.Append(prepend+"Owner: " + tbOwner.Text);
                prepend="  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbOwner.Text,"Own_Name"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbApplicant.Text)) {
                sb.Append(prepend + "Applicant: " + tbApplicant.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbApplicant.Text,"Applicant"));
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
                sbFilter.Append(and + " SubmittalId = " + tbSubmittalId.Text);
                and = " and ";
            }
            if (Utils.isNothingNot(tbBPermitId.Text)) {
                sb.Append(prepend + "BPermit Id: " + tbBPermitId.Text);
                prepend = "  ";
                sbFilter.Append(and + " BPermitId =" + tbBPermitId.Text);
                and = " and ";
            }
            if (ddlIsCommercial.SelectedValue != "Null") {
                sb.Append(prepend + " Is Commercial: " + ddlIsCommercial.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " IsCommercial = " + ddlIsCommercial.SelectedValue);
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }
        private int getSubmittalId(GridViewRow dr) {
            return Convert.ToInt32(dr.Cells[13].Text);
        }
        private string getOwner(DataRow dr) {
            return (string)dr["Own_Name"];
        }
        private DateTime? getMeetingDate(DataRow dr) {
            return Utils.ObjectToDateTimeNullable(dr["Mtg_Date"]);
        }
        private int? getBPermitId(DataRow dr) {
            return Utils.ObjectToIntNullable(dr["BPermitId"]);
        }
        private string getLotLane(DataRow dr) {
            return ((string)dr["Lot"]) + "\\" + (string)dr["Lane"];
        }

        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;

            DataSet ds = buildDataSet();
            DataTable sourceTable = ds.Tables[0];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "SubmittalId=" + getSubmittalId(row);
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            tbConditions.Text = (string)dr["Conditions"];
            tbOwnersName.Text = (string)dr["Own_Name"];
            tbLotName2.Text = (string)dr["Lot"];
            ddlLane2.SelectedValue = (string)dr["Lane"];
            tbApplicantName2.Text = (string)dr["Applicant"];
            tbContractorBB.Text = (string)dr["Contractor"];
            DateTime? meetingDate = Utils.ObjectToDateTimeNullable(dr["Mtg_Date"]);
            tbMeetingDate.Text = meetingDate.HasValue?meetingDate.Value.ToString("MM/dd/yyyy"):"";
            ddlProjectType.SelectedValue = (string)dr["ProjectType"];
            ddlProjectDecision.SelectedValue = (string)dr["ProjectDecision"];
            tbProject.Text = (string)dr["Project"];
            tbSubmittal.Text = (string)dr["Submittal"];
            cbIsCommercial.Checked=((string)dr["IsCommercial"])=="true"?true:false;
            int? permitid = getBPermitId(dr);
            CurrentBPermitId =permitid.HasValue? Convert.ToString(permitid.Value):"";
            
            return "Lot\\Lane: " + getLotLane(dr) + "  Submittal Id: " + getSubmittalId(row) + "  BPermitId :" + getBPermitId(dr) + "  Meeting Date: " + getMeetingDate(dr) + " Owner: " + getOwner(dr);
        }
        string CurrentBPermitId { get { return (string)Session["CurrentBPermitId"]; } set { Session["CurrentBPermitId"] = value; } }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                getGridViewResults().DataSource = buildDataSet();
                getGridViewResults().DataBind();
            }
        }
        protected override DataTable getGridViewDataTable() {
            return buildDataSet().Tables[0];
        }

        protected void lbGoToPermit_Click(object sender, EventArgs e) {
            Response.Redirect("~/BPermit.aspx?BPermitId="+CurrentBPermitId);
        }
    }
}