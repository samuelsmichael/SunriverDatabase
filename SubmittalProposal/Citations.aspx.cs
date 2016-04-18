using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using Common;
using System.Text;

namespace SubmittalProposal {
    public partial class Citations : AbstractDatabase {
        private static string DataSetCacheKey = "CIDATASETCACHEKEY";
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["CitationsSQLConnectionString"].ConnectionString;
            }
        }
        public static DataSet CIDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = DataSetCacheKey;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspCitationsTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["CitationID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["ViolationID"] };
                ds.Tables[3].PrimaryKey = new DataColumn[] { ds.Tables[3].Columns["RuleID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }
        protected override System.Data.DataSet buildDataSet() {
            return CIDataSet();
        }
        private void bindDDLs() {
            DataTable dtFineStatus = CIDataSet().Tables[2].Copy();
            DataRow row=dtFineStatus.NewRow();
            row["FineStatus"] = "";
            dtFineStatus.Rows.InsertAt(row,0);
            ddlFineStatusLU.DataSource = dtFineStatus;
            ddlFineStatusLU.DataBind();
            DataTable dtFineStatus2 = CIDataSet().Tables[2].Copy();
            DataRow row2 = dtFineStatus2.NewRow();
            row2["FineStatus"] = "";
            dtFineStatus2.Rows.InsertAt(row2,0);
            ddlSunriverStatusUpdate.DataSource=dtFineStatus2;
            ddlSunriverStatusUpdate.DataBind();
            ddlCitationsFineStatusUpdate.DataSource = dtFineStatus2;
            ddlCitationsFineStatusUpdate.DataBind();
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                bindDDLs();
            }
        }
        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }
        protected override void clearAllSelectionInputFields() {
            tbCitationLastNameLU.Text = "";
            ddlFineStatusLU.SelectedIndex = 0;
            tbCitationIDLU.Text = "";
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return CIDataSet().Tables[0];
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }
        private int CitationsIDBeingEdited {
            get {
                object obj = Session["CitationsIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["CitationsIDBeingEdited"] = value;
            }
        }
        private DateTime? getViolationDate(DataRow dr) {
            try {
                return (DateTime?)dr["OffenseDate"];
            } catch {
                return (DateTime?)null;
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            CitationsIDBeingEdited = Convert.ToInt32(row.Cells[5].Text);
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "CitationID=" + CitationsIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            Session["CitationsTblFiltered"] = tblFiltered;
            DataRow dr = tblFiltered.Rows[0];
            tbCitationsLastNameUpdate.Text=Utils.ObjectToString(dr["VLastName"]);
            tbCitationsFirstNameUpdate.Text=Utils.ObjectToString(dr["VFirstName"]);
            tbCitationsAddress1Update.Text = Utils.ObjectToString(dr["VMailAddr1"]);
            tbCitationsAddress2Update.Text = Utils.ObjectToString(dr["VMailAddr2"]);
            tbCitationsCityUpdate.Text = Utils.ObjectToString(dr["VCity"]);
            tbCitationsStateUpdate.Text = Utils.ObjectToString(dr["VState"]);
            tbCitationsZipUpdate.Text = Utils.ObjectToString(dr["VZip"]);
            string fineStatus = Utils.ObjectToString(dr["FineStatus"]);
            ddlSunriverStatusUpdate.SelectedValue = fineStatus;
            DateTime? violationDate=getViolationDate(dr);
            tbCitationsViolationsDateUpdate.Text = violationDate.HasValue ? violationDate.Value.ToString("MM/dd/yyyy") : "";
            tbCitationsViolationsLocationUpdate.Text = Utils.ObjectToString(dr["OffenseLocation"]);
            ddlCitationsFineStatusUpdate.SelectedValue = Utils.ObjectToString(dr["FineStatus"]);

            bind_gvViolations();

            object dateFormPrinted = Utils.ObjectToString(dr["DateFormPrinted"]);
            if (Utils.isNothingNot(dateFormPrinted)) {
                lblDatePrinted.Text = dateFormPrinted.ToString();
            }
            return "Last name: " + Utils.ObjectToString(dr["VLastName"]) + "nbsp;nbsp;nbsp;First name: " + Utils.ObjectToString(dr["VFirstName"]) + "     CitationID: " + CitationsIDBeingEdited;
        }

        private void bind_gvViolations() {
            DataTable sourceTableViolations = CIDataSet().Tables[1];
            DataView viewViolations = new DataView(sourceTableViolations);
            viewViolations.RowFilter = "fkCitationID=" + CitationsIDBeingEdited;
            DataTable tblFilteredViolations = viewViolations.ToTable();
            gvViolations.DataSource = tblFilteredViolations;
            gvViolations.DataBind();
        }

        protected void btnPrintForm_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspCitationsDateFormPrintedUpdate");
            cmd.Parameters.Add("@CitationID", SqlDbType.Int).Value = CitationsIDBeingEdited;
            Utils.executeNonQuery(cmd, ConnectionString);
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            lblDatePrinted.Text = DateTime.Now.ToString();
        }

        protected override Label getUpdateResultsLabel() {
            return lblCitationsUpdateResults;
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";

            if (Utils.isNothingNot(tbCitationLastNameLU.Text)) {
                sb.Append(prepend + "Last name: " + tbCitationLastNameLU.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbCitationLastNameLU.Text, "VLastName"));
                and = " and ";
            }

            if (Utils.isNothingNot(ddlFineStatusLU.SelectedValue) && ddlFineStatusLU.SelectedValue.ToLower() != "") {
                sb.Append(prepend + "Fine status: " + ddlFineStatusLU.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " FineStatus = '" + ddlFineStatusLU.SelectedValue + "'");
                and = " and ";
            }

            if (Utils.isNothingNot(tbCitationIDLU.Text)) {
                sb.Append(prepend + "CitationId: " + tbCitationIDLU.Text);
                prepend = "  ";
                sbFilter.Append(and + " CitationID = '" + tbCitationIDLU.Text + "'");
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }
        protected override void lockYourUpdateFields() {
            btnCitationsUpdate.Visible = false;
            tbCitationsLastNameUpdate.Enabled = false;
            tbCitationsFirstNameUpdate.Enabled = false;
            tbCitationsAddress1Update.Enabled = false;
            tbCitationsAddress2Update.Enabled = false;
            tbCitationsCityUpdate.Enabled = false;
            tbCitationsStateUpdate.Enabled = false;
            tbCitationsZipUpdate.Enabled = false;
            ddlSunriverStatusUpdate.Enabled = false;
            tbCitationsViolationsDateUpdate.Enabled=false;
            tbCitationsViolationsLocationUpdate.Enabled = false;
            ibCitationsViolationsDateUpdate.Enabled = false;
            gvViolations.Enabled = false;
            ddlCitationsFineStatusUpdate.Enabled = false;
        }

        protected override void unlockYourUpdateFields() {
            btnCitationsUpdate.Visible=true;
            tbCitationsLastNameUpdate.Enabled = true;
            tbCitationsFirstNameUpdate.Enabled = true;
            tbCitationsAddress1Update.Enabled = true;
            tbCitationsAddress2Update.Enabled = true;
            tbCitationsCityUpdate.Enabled = true;
            tbCitationsStateUpdate.Enabled = true;
            tbCitationsZipUpdate.Enabled = true;
            ddlSunriverStatusUpdate.Enabled = true;
            tbCitationsViolationsDateUpdate.Enabled = true;
            tbCitationsViolationsLocationUpdate.Enabled = true;
            ibCitationsViolationsDateUpdate.Enabled = true;
            gvViolations.Enabled = true;
            ddlCitationsFineStatusUpdate.Enabled = true;
        }
        protected override string UpdateRoleName {
            get { return "canupdatecitations"; }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        protected void btnCitationsUpdateOkay_Click(object sender, EventArgs args) {
        }

        protected void gvViolations_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvViolations.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            bind_gvViolations();
        }

        protected void gvViolations_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvViolations.Rows[e.RowIndex];
            try {
/*                int inspectionId = Convert.ToInt32(((Label)row.Cells[1].Controls[1]).Text);
                DateTime? date = Utils.ObjectToDateTimeNullable(((TextBox)row.Cells[2].Controls[1]).Text);
                string comments = ((TextBox)row.Cells[3].Controls[1]).Text;
                string strfee = ((DropDownList)row.Cells[4].Controls[1]).SelectedValue;
                decimal? fee = Utils.isNothing(strfee) ? (decimal?)null : Utils.ObjectToDecimal(strfee);
                bool paid = ((CheckBox)row.Cells[5].Controls[1]).Checked;
                string paidMemo = ((TextBox)row.Cells[6].Controls[1]).Text;
                DateTime? dateClosed = Utils.ObjectToDateTimeNullable(((TextBox)row.Cells[7].Controls[1]).Text);
                string ladderFuel = ((DropDownList)row.Cells[8].Controls[1]).SelectedValue;
                string noxWeeds = ((DropDownList)row.Cells[9].Controls[1]).SelectedValue;
                string followUp = ((TextBox)row.Cells[10].Controls[1]).Text;

                SqlCommand cmd = new SqlCommand("uspSellCheckInspectionUpdate");

                cmd.Parameters.Add("@scInspectionID", SqlDbType.Int).Value = inspectionId;
                cmd.Parameters.Add("@fkscRequestID", SqlDbType.Int).Value = scRequestIDBeingEdited;
                cmd.Parameters.Add("@scDate", SqlDbType.DateTime).Value = date.HasValue ? date.Value : (DateTime?)null;
                cmd.Parameters.Add("@scFee", SqlDbType.Money).Value = fee;
                cmd.Parameters.Add("@scPaid", SqlDbType.Bit).Value = paid;
                cmd.Parameters.Add("@scPaidMemo", SqlDbType.NVarChar).Value = paidMemo;
                cmd.Parameters.Add("@scDateClosed", SqlDbType.DateTime).Value = (dateClosed.HasValue ? dateClosed.Value : (DateTime?)null);
                cmd.Parameters.Add("@scLadderFuel", SqlDbType.NVarChar).Value = ladderFuel;
                cmd.Parameters.Add("@scNoxWeeds", SqlDbType.NVarChar).Value = noxWeeds;
                cmd.Parameters.Add("@scComments", SqlDbType.NVarChar).Value = comments;
                cmd.Parameters.Add("@scFollowUp", SqlDbType.NVarChar).Value = followUp;
                SqlParameter newid = new SqlParameter("@NewID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
*/
                performPostUpdateSuccessfulActions("Violation updated", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Violoation not updated. Error msg: " + ee.Message);
            }
            //Reset the edit index.
            gvViolations.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvViolations();

        }

        protected void gvViolations_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvViolations.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvViolations();
        }

        decimal sumFine = 0;
        protected void gvViolations_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                String text=null;
                object control = e.Row.FindControl("lblScheduleFineUpdate");
                if (control != null) { // we're not in edit mode
                    text = ((Label)control).Text;
                } else {
                    control = e.Row.FindControl("tbScheduleFineUpdate");
                    if (control != null) { // we're in edit mode
                        text = ((TextBox)control).Text;
                    }
                }
                sumFine += Utils.ObjectToDecimal0IfNull(text.Replace("$",""));
            }
            if (e.Row.RowType == DataControlRowType.Footer) {
                Label lbl = (Label)e.Row.FindControl("lblSumFine");
                lbl.Text = sumFine.ToString("c");
            }
        }
    }
}