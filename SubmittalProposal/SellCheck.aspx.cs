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
        private int scRequestIDBeingEdited {
            get {
                object obj = ViewState["scRequestIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                ViewState["scRequestIDBeingEdited"] = value;
            }
        }
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
            tbRecipient.Text = "";
            tbscLTCCopy1.Text = "";
            tbRequestId.Text = "";
            tbPropertyID.Text = "";
            tbInspectionID.Text = "";
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
            return lblSellRequestUpdateResults;
        }
        private int getscRequestID(GridViewRow dr) {
            return Convert.ToInt32(dr.Cells[6].Text);
        }
        private string getLotLane(DataRow dr) {
            return Utils.ObjectToString(dr["scLot"]) + "\\" + Utils.ObjectToString(dr["scLane"]);
        }
        private string getPropertyId(DataRow dr) {
            return Utils.ObjectToString(dr["fkscPropID"]);
        }
        private string getRecipient(DataRow dr) {
            return Utils.ObjectToString(dr["scLTRecipient"]);
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            scRequestIDBeingEdited = getscRequestID(row);
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "scRequestID=" + getscRequestID(row);
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            lblLot.Text = Utils.ObjectToString(dr["scLot"]);
            lblLane.Text = Utils.ObjectToString(dr["scLane"]);
            lblPropertyID.Text = getPropertyId(dr);
            lblRequestID.Text = Utils.ObjectToString(dr["scRequestID"]);
            lblPropertyID.Text = "";
            object dateFormPrinted = Utils.ObjectToString(dr["DateFormPrinted"]);
            if (Utils.isNothingNot(dateFormPrinted)) {
                lblDatePrinted.Text = ((DateTime)dateFormPrinted).ToString();
            }

            return "Lot\\Lane: " + getLotLane(dr) + "  Request ID: " + scRequestIDBeingEdited + "  Property ID:" + getPropertyId(dr) + " Requestor: " + getRecipient(dr);
        }
        protected override void lockYourUpdateFields() {
            //throw new NotImplementedException();
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
            if (Utils.isNothingNot(tbscLTCCopy1.Text)) {
                sb.Append(prepend + "Recipient: " + tbscLTCCopy1.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbscLTCCopy1.Text, "scLTCCopy1"));
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

                sbFilter.Append(and + Common.Utils.getDataViewQuery("," + inspectionId + ",", "inspectionIDs")) 
                    ;           
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
        protected void btnSellRequest_Click(object sender, EventArgs args) {
            throw new NotImplementedException();
        }
    }
}