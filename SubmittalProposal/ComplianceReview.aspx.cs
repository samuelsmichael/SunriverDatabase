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
using System.Configuration;

namespace SubmittalProposal {
    public partial class ComplianceReview : AbstractDatabase {
        public static DataSet CRDataSet() {
            DataSet ds = null;
            MemoryCache cache=MemoryCache.Default;
            string key = "CRDS";
            ds = (DataSet)cache[key];
            if (ds == null) {            
                ds = Utils.getDataSetFromQuery("Select * from tblComplianceReview;select * from tblComplianceLetterData;", System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master).dsLotLane;
                ddlLane.DataBind();
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            throw new NotImplementedException();
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " crLot like '*" + tbLot.Text + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " crLane like '*" + ddlLane.SelectedValue + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbComments.Text)) {
                sb.Append(prepend + "Comments: " + tbComments.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbComments.Text, "crComments"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbRule.Text)) {
                sb.Append(prepend + "Rule: " + tbRule.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbRule.Text, "crRule"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbReviewId.Text)) {
                sb.Append(prepend + "Review Id: " + tbReviewId.Text);
                prepend = "  ";
                sbFilter.Append(and + " crReviewId = " + tbReviewId.Text);
                and = " and ";
            }
            searchCriteria=sb.ToString();
            filterString=sbFilter.ToString();
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override System.Data.DataSet buildDataSet() {
            return CRDataSet();
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return CRDataSet().Tables[0];
        }
    }
}