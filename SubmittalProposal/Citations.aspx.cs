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
        public static DataSet CIDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = DataSetCacheKey;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspCitationsTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["CitationsSQLConnectionString"].ConnectionString);
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
            throw new NotImplementedException();
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
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            throw new NotImplementedException();
        }
        protected override void lockYourUpdateFields() {
           
        }
        protected override Label getUpdateResultsLabel() {
            throw new NotImplementedException();
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
        protected override void unlockYourUpdateFields() {
            throw new NotImplementedException();
        }
        protected override string UpdateRoleName {
            get { throw new NotImplementedException(); }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
    }
}