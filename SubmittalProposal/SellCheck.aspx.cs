using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using System.Text;

namespace SubmittalProposal {
    public partial class SellCheck : AbstractDatabase {
        public static DataSet SCDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = DataSetCacheKey;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspSellCheckTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["scRequestID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["scInspectionID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        protected static string DataSetCacheKey {
            get { return "SCDS"; }
        }
        protected override System.Data.DataSet buildDataSet() {
            return SCDataSet();
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
            }
        }
        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }
        protected override void clearAllSelectionInputFields() {
            tbLot.Text = "";
            ddlLane.SelectedIndex = 0;
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return SCDataSet().Tables[0];
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }
        protected override Label getUpdateResultsLabel() {
            throw new NotImplementedException();
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            throw new NotImplementedException();
        }
        protected override void lockYourUpdateFields() {
            throw new NotImplementedException();
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbRecipient.Text)) {
                sb.Append(prepend + "Recipient: " + tbRecipient.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbRecipient.Text, "scLTRecipient"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " scLot = '" + tbLot.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbRequestId.Text)) {
                sb.Append(prepend + "RequestID: " + tbRequestId.Text);
                prepend = "  ";
                sbFilter.Append(and + " scRequestID = '" + tbRequestId.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbPropertyID.Text)) {
                sb.Append(prepend + "Property ID: " + tbPropertyID.Text);
                prepend = "  ";
                sbFilter.Append(and + " fkscPropID = '" + tbPropertyID.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbInspectionID.Text)) {
                sb.Append(prepend + "Inspection ID: " + tbInspectionID.Text);
                prepend = "  ";
                int inspectionId = -999;
                try {
                    inspectionId=Convert.ToInt32(tbInspectionID.Text);} catch {}
                sbFilter.Append(and + " exists (select scInspectionID from tblSellCheck where scInspectionID = " + inspectionId +")" );
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " scLane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();

        }
        protected override void unlockYourUpdateFields() {
            throw new NotImplementedException();
        }
        protected override string UpdateRoleName {
            get { return "canupdatesellcheck"; }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {}
    }
}