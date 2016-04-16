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


            object dateFormPrinted = Utils.ObjectToString(dr["DateFormPrinted"]);
            if (Utils.isNothingNot(dateFormPrinted)) {
                lblDatePrinted.Text = dateFormPrinted.ToString();
            }
            return "Last name: " + Utils.ObjectToString(dr["VLastName"]) + "nbsp;nbsp;nbsp;First name: " + Utils.ObjectToString(dr["VFirstName"]) + "     CitationID: " + CitationsIDBeingEdited;
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
        }
        protected override string UpdateRoleName {
            get { return "canupdatecitations"; }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        protected void btnCitationsUpdateOkay_Click(object sender, EventArgs args) {
        }
    }
}