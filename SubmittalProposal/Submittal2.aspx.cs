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
        private static string SUBMITTAL_CACHE_KEY = "SubmittalDS";
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
                cmd.Parameters.Add("@Own_Name", SqlDbType.VarChar).Value = tbOwnersNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneUpdate.SelectedValue;
                cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Contractor",SqlDbType.NVarChar).Value=tbContractorUpdate.Text.Trim();
                decimal? reviewFee=(tbReviewFeeUpdate.Text.Trim()=="")?(decimal?)null:Convert.ToDecimal(tbReviewFeeUpdate.Text.Trim());
                cmd.Parameters.Add("@ProjectFee",SqlDbType.Decimal).Value=reviewFee;
                cmd.Parameters.Add("@FeeDate",SqlDbType.DateTime).Value=(tbDateFeePaidUpdate.Text.Trim()=="")?(DateTime?)null:Convert.ToDateTime(tbDateFeePaidUpdate.Text.Trim());
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
                performPostUpdateSuccessfulActions("Update successful", SUBMITTAL_CACHE_KEY);
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
            CurrentSubmittalId = Convert.ToInt32(dr.Cells[13].Text);
            return CurrentSubmittalId.Value;
        }
        private string getOwner(DataRow dr) {
            return Utils.ObjectToString(dr["Own_Name"]);
        }
        private DateTime? getMeetingDate(DataRow dr) {
            return Utils.ObjectToDateTimeNullable(dr["Mtg_Date"]);
        }
        private int? getBPermitId(DataRow dr) {
            return Utils.ObjectToIntNullable(dr["BPermitId"]);
        }
        private string getLotLane(DataRow dr) {
            return (Utils.ObjectToString(dr["Lot"])) + "\\" + Utils.ObjectToString(dr["Lane"]);
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
            tbDateFeePaidUpdate.Text = feePaidDate.HasValue ? feePaidDate.Value.ToString("MM/dd/yyyy") : "";
            decimal reviewFee = 0;
            try {
                reviewFee=Convert.ToDecimal(dr["ProjectFee"]);
            } catch {
            }
            tbReviewFeeUpdate.Text = reviewFee==0?"":reviewFee.ToString("0.00");
            ddlProjectTypeUpdate.SelectedValue = Utils.ObjectToString(dr["ProjectType"]);
            if (ddlProjectDecisionUpdate.Items.FindByText(Utils.ObjectToString(dr["ProjectDecision"])) == null) {
                ddlProjectDecisionUpdate.Items.Add(new ListItem(Utils.ObjectToString(dr["ProjectDecision"]), Utils.ObjectToString(dr["ProjectDecision"])));
            }
            ddlProjectDecisionUpdate.SelectedValue = Utils.ObjectToString(dr["ProjectDecision"]);
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
                ddlLane.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
                ddlLane.DataBind();
                ddlLaneUpdate.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
                ddlLaneUpdate.DataBind();
                ddlLaneNew.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
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

        protected void lbGoToPermit_Click(object sender, EventArgs args) {
            Response.Redirect("~/BPermit.aspx?BPermitId="+CurrentBPermitId);
        }

        protected void btnNewSubmittalOk_Click(object sender, EventArgs args) {
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
                decimal? reviewFee = (tbReviewFeeNew.Text.Trim() == "") ? (decimal?)null : Convert.ToDecimal(tbReviewFeeNew.Text.Trim());
                cmd.Parameters.Add("@ProjectFee", SqlDbType.Decimal).Value = reviewFee;
                cmd.Parameters.Add("@FeeDate", SqlDbType.DateTime).Value = (tbDateFeePaidNew.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(tbDateFeePaidNew.Text.Trim());
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
                performPostNewSuccessfulActions("Submittal added successfully", SUBMITTAL_CACHE_KEY,tbSubmittalId, Convert.ToInt32(newSubmittalId.Value));
            } catch (Exception e) {
                performPostNewFailedActions("Submittal not added. Msg: " + e.Message);
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
            tbReviewFeeNew.Text = "";
            tbDateFeePaidNew.Text = "";
            tbMeetingDateNew.Text = "";
            ddlProjectTypeNew.SelectedIndex = 0;
            ddlProjectDecisionNew.SelectedIndex = 0;
            cbIsCommercialNew.Checked = false;
            tbProjectNew.Text = "";
            tbSubmittalNew.Text = "";
            tbConditionsNew.Text = "";
        }
    }
}