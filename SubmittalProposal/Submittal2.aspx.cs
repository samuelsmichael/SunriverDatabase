using System;
using System.Collections.Generic;

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
        private static string SUBMITTAL_CACHE_KEY = "SubmittalDS";
        protected override string UpdateRoleName {
            get { return "canupdatesubmittals"; }
        }
         protected override GridView getGridViewResults() {
            return gvResults;
        }
         public static DataSet SunriverDataSet() {
             DataSet ds = null;
             MemoryCache cache = MemoryCache.Default;
             string key = SUBMITTAL_CACHE_KEY;
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

        protected override Label getUpdateResultsLabel() {
            return lblSubmitalUpdateResults;
        }
        protected override Label getNewResultsLabel() {
            return lblSubmitalNewResults;
        }

        protected void btnSubmitalUpdate_Click(object sender, EventArgs args) {
            lblSubmitalUpdateResults.Text = "";
            try {
                SqlCommand cmd = new SqlCommand(
                    "uspSubmittalUpdate"
                );
                cmd.Parameters.Add("@SubmittalId", SqlDbType.Int).Value = CurrentSubmittalId;
                cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneUpdate.SelectedValue;
                cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Contractor",SqlDbType.NVarChar).Value=tbContractorUpdate.Text.Trim();
                cmd.Parameters.Add("@Mtg_Date",SqlDbType.DateTime).Value=(tbMeetingDateUpdate.Text.Trim()=="")?(DateTime?)null:Convert.ToDateTime(tbMeetingDateUpdate.Text.Trim());
                cmd.Parameters.Add("@ProjectType",SqlDbType.NVarChar).Value=ddlProjectTypeUpdate.SelectedValue;
                cmd.Parameters.Add("@ProjectDecision",SqlDbType.NVarChar).Value=ddlProjectDecisionUpdate.SelectedValue;
                cmd.Parameters.Add("@IsCommercial",SqlDbType.Bit).Value=cbIsCommercialUpdate.Checked;
                cmd.Parameters.Add("@Project",SqlDbType.NVarChar).Value=tbProjectUpdate.Text.Trim();
                cmd.Parameters.Add("@Submittal",SqlDbType.NVarChar).Value=tbSubmittalUpdate.Text.Trim();
                cmd.Parameters.Add("@Conditions", SqlDbType.NVarChar).Value = tbConditionsUpdate.Text.Trim();
                SqlParameter dummy = new SqlParameter("@NewSubmittalId", SqlDbType.Int);
                dummy.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(dummy);
                Utils.executeNonQuery(cmd,
                    System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Update successful", SUBMITTAL_CACHE_KEY,null);
            } catch (Exception e) {
                performPostUpdateFailedActions("Update failed. Msg: " + e.Message);
            }
        }
        private int? CurrentSubmittalId {
            get {
                object obj = ViewState["CurrentSubmittalId"];
                return obj == null ? null : (int?)obj;
            }
            set {
                ViewState["CurrentSubmittalId"] = value;
            }
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
                sbFilter.Append(and + " Lot = '" + tbLot.Text+"'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower()!="choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " Lane = '" + ddlLane.SelectedValue + "'");
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
            CurrentSubmittalId = Convert.ToInt32(dr.Cells[6].Text);
            return CurrentSubmittalId.Value;
        }
        private string getOwner(DataRow dr) {
            return Utils.ObjectToString(dr["Own_Name"]);
        }
        private DateTime? getMeetingDate(DataRow dr) {
            return Utils.ObjectToDateTimeNullable(dr["Mtg_Date"]);
        }
        private int? getBPermitId(DataRow dr) {
            return Utils.ObjectToIntNullable(dr["BPermitID"]);
        }
        private string getLotLane(DataRow dr) {
            return (Utils.ObjectToString(dr["Lot"])) + "\\" + Utils.ObjectToString(dr["Lane"]);
        }

        protected override void lockYourUpdateFields() {
            btnSubmitalUpdate.Enabled = false;
            tbOwnersNameUpdate.Enabled = false;
            tbLotNameUpdate.Enabled = false;
            tbApplicantNameUpdate.Enabled = false;
            tbContractorUpdate.Enabled = false;
            tbMeetingDateUpdate.Enabled = false;
            ddlProjectTypeUpdate.Enabled = false;
            ddlProjectDecisionUpdate.Enabled = false;
            cbIsCommercialUpdate.Enabled = false;
            tbProjectUpdate.Enabled = false;
            tbSubmittalUpdate.Enabled = false;
            tbConditionsUpdate.Enabled = false;
            ddlLaneUpdate.Enabled = false;
        }
        protected override void unlockYourUpdateFields() {
            btnSubmitalUpdate.Enabled = true;
            tbOwnersNameUpdate.Enabled = true;
            tbLotNameUpdate.Enabled = true;
            tbApplicantNameUpdate.Enabled = true;
            tbContractorUpdate.Enabled = true;
            tbMeetingDateUpdate.Enabled = true;
            ddlProjectTypeUpdate.Enabled = true;
            ddlProjectDecisionUpdate.Enabled = true;
            cbIsCommercialUpdate.Enabled = true;
            tbProjectUpdate.Enabled = true;
            tbSubmittalUpdate.Enabled = true;
            tbConditionsUpdate.Enabled = true;
            ddlLaneUpdate.Enabled = true;
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
            tbConditionsUpdate.Text = Utils.ObjectToString(dr["Conditions"]);
            tbOwnersNameUpdate.Text = Utils.ObjectToString(dr["Own_Name"]);
            tbLotNameUpdate.Text = Utils.ObjectToString(dr["Lot"]);
            if(ddlLaneUpdate.Items.FindByText(Utils.ObjectToString(dr["Lane"]))==null) {
                ddlLaneUpdate.Items.Add(new ListItem(Utils.ObjectToString(dr["Lane"]),Utils.ObjectToString(dr["Lane"])));
            }
            ddlLaneUpdate.SelectedValue = Utils.ObjectToString(dr["Lane"]);
            tbApplicantNameUpdate.Text = Utils.ObjectToString(dr["Applicant"]);
            tbContractorUpdate.Text = Utils.ObjectToString(dr["Contractor"]);
            DateTime? meetingDate = Utils.ObjectToDateTimeNullable(dr["Mtg_Date"]);
            tbMeetingDateUpdate.Text = meetingDate.HasValue?meetingDate.Value.ToString("MM/dd/yyyy"):"";
            DateTime? feePaidDate = Utils.ObjectToDateTimeNullable(dr["FeeDate"]);
            ddlProjectTypeUpdate.SelectedValue = Utils.ObjectToString(dr["ProjectType"]);
            if (ddlProjectDecisionUpdate.Items.FindByText(Utils.ObjectToString(dr["ProjectDecision"])) == null) {
                ddlProjectDecisionUpdate.Items.Add(new ListItem(Utils.ObjectToString(dr["ProjectDecision"]), Utils.ObjectToString(dr["ProjectDecision"])));
            }
            ddlProjectDecisionUpdate.SelectedValue = Utils.ObjectToString(dr["ProjectDecision"]);
            if (ddlProjectDecisionUpdate.SelectedValue == "A" || ddlProjectDecisionUpdate.SelectedValue == "AWC") {
                lbGoToPermit.Visible = true;
            } else {
                lbGoToPermit.Visible = false;
            }
            tbProjectUpdate.Text = Utils.ObjectToString(dr["Project"]);
            tbSubmittalUpdate.Text = Utils.ObjectToString(dr["Submittal"]);
            cbIsCommercialUpdate.Checked=Convert.ToBoolean(dr["IsCommercial"]);
            int? permitid = getBPermitId(dr);
            CurrentBPermitId =permitid.HasValue? Convert.ToString(permitid.Value):"";
            
            return "Lot\\Lane: " + getLotLane(dr) + "  Submittal Id: " + getSubmittalId(row) + "  BPermitId :" + getBPermitId(dr) + "  Meeting Date: " + getMeetingDate(dr) + " Owner: " + getOwner(dr);
        }
        string CurrentBPermitId { get { return (string)Session["CurrentBPermitId"]; } set { Session["CurrentBPermitId"] = value; } }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
                ddlLaneUpdate.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneUpdate.DataBind();
                ddlLaneNew.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneNew.DataBind();
                /*
                if (!this.ClientScript.IsStartupScriptRegistered("startupBB")) {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<script type='text/javascript'>");
                    sb.Append("Sys.Application.add_load(modalSetup);");
                    sb.Append("function modalSetup() {");
                    sb.Append(String.Format("var modalPopup = $find('{0}');", MPE.BehaviorID));
                    sb.Append("modalPopup.add_shown(shown); }");
                    sb.Append("</script>");
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "startupBB", sb.ToString());
                }
                 */
            }
        }
        protected override DataTable getGridViewDataTable() {
            return buildDataSet().Tables[0];
        }

        protected void lbSubmittalNew_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspFindHighestSubmittalId");
            DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
            int maxSubmittalId = Convert.ToInt32(ds.Tables[0].Rows[0]["SubmittalId"]);
            maxSubmittalId++;
            lblAutoSubmittalId.Text = "" + maxSubmittalId;
            mpeNewSubmittal.Show();

        }


        protected void lbGoToPermit_Click(object sender, EventArgs args) {
            Session["ShowBPermitID"] = CurrentBPermitId;
            Session["ShowSubmittalID"] = CurrentSubmittalId;
            Response.Redirect("~/BPermit.aspx");
        }

        protected void btnNewSubmittalCancel_Click(object sender, EventArgs args) {
            clearAllSelectionInputFields();
        }

        protected void btnNewSubmittalOk_Click(object sender, EventArgs args) {

            lblRequiredMeetingDate.Text = "";
            if (tbMeetingDateNew.Text.Trim() == "") {
                lblRequiredMeetingDate.Text = "Meeting Date is a required field.";
                mpeNewSubmittal.Show();
            } else {
                lblSubmitalUpdateResults.Text = "";
                try {
                    SqlCommand cmd = new SqlCommand(
                        "uspSubmittalUpdate"
                    );
                    cmd.Parameters.Add("@Own_Name", SqlDbType.VarChar).Value = tbOwnersNameNew.Text.Trim();
                    cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameNew.Text.Trim();
                    cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneNew.SelectedValue;
                    cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameNew.Text.Trim();
                    cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorNew.Text.Trim();
                    cmd.Parameters.Add("@Mtg_Date", SqlDbType.DateTime).Value = (tbMeetingDateNew.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(tbMeetingDateNew.Text.Trim());
                    cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeNew.SelectedValue;
                    cmd.Parameters.Add("@ProjectDecision", SqlDbType.NVarChar).Value = ddlProjectDecisionNew.SelectedValue;
                    cmd.Parameters.Add("@IsCommercial", SqlDbType.Bit).Value = cbIsCommercialNew.Checked;
                    cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectNew.Text.Trim();
                    cmd.Parameters.Add("@Submittal", SqlDbType.NVarChar).Value = tbSubmittalNew.Text.Trim();
                    cmd.Parameters.Add("@Conditions", SqlDbType.NVarChar).Value = tbConditionsNew.Text.Trim();
                    SqlParameter newSubmittalId = new SqlParameter("@NewSubmittalId", SqlDbType.Int);
                    newSubmittalId.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newSubmittalId);
                    Utils.executeNonQuery(cmd,
                        System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                    performPostNewSuccessfulActions("Submittal added successfully", SUBMITTAL_CACHE_KEY, null, tbSubmittalId, Convert.ToInt32(newSubmittalId.Value));
                    mpeNewSubmittal.Hide();
                } catch (Exception e) {
                    performPostNewFailedActions("Submittal not added. Msg: " + e.Message);
                }
            }
        }
        protected override void clearAllSelectionInputFields() {
            tbOwner.Text = "";
            tbApplicant.Text = "";
            tbLot.Text = "";
            ddlLane.SelectedIndex = 0;
            tbSubmittalId.Text = "";
            tbBPermitId.Text = "";
            ddlIsCommercial.SelectedIndex = 0;
            tbOwnersNameNew.Text = "";
            tbLotNameNew.Text = "";
            ddlLaneNew.SelectedIndex = 0;
            tbApplicantNameNew.Text = "";
            tbContractorNew.Text = "";
            ddlProjectDecisionNew.SelectedIndex = 0;
            cbIsCommercialNew.Checked = false;
            tbProjectNew.Text = "";
            tbSubmittalNew.Text = "";
            tbConditionsNew.Text = "";
            tbMeetingDateNew.Text = "";
        }
    }
}