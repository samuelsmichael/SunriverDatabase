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
        private string scLotBeingEdited {
            get {
                return (string)ViewState["scLotBeingEdited"];
            }
            set {
                ViewState["scLotBeingEdited"] = value;
            }
        }
        private string scLaneBeingEdited {
            get {
                return (string)ViewState["scLaneBeingEdited"];
            }
            set {
                ViewState["scLaneBeingEdited"] = value;
            }
        }
        private string scfkPropIDBeingEdited {
            get {
                return (string)ViewState["scfkPropIDBeingEdited"];
            }
            set {
                ViewState["scfkPropIDBeingEdited"] = value;
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
        public static DataSet dsRealtor {
            get {
                MemoryCache cache = MemoryCache.Default;
                string key = "DSRL";
                DataSet ds = (DataSet)cache[key];
                if (ds == null) {
                    CacheItemPolicy policy = new CacheItemPolicy();
                    policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                    ds = Utils.getDataSetFromQuery("SELECT RealtyCo FROM [tblRealtyCoList{LU}] ORDER BY [RealtyCo]", System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
                    cache.Add(key, ds, policy);
                }
                return ds;
            }
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
                DataSet realtor=dsRealtor;
                DataRow dr=realtor.Tables[0].NewRow();
                dr["RealtyCo"]="";
                realtor.Tables[0].Rows.InsertAt(dr,0);
                ddlscRealtorUpdate.DataSource = realtor;
                ddlscRealtorUpdate.DataBind();
            }
        }
        protected override void clearAllNewFormInputFields() {
            tbscLotNew.Text = "";
            ddlscLaneNew.SelectedIndex = 0;
            tbLTDateNew.Text = "";
            tbscLTRecipientNew.Text = "";
            tbscLTCCopy1New.Text = "";
            tbscLTCCopy2New.Text = "";
            tbscLTCCopy3New.Text = "";
            tbscLTMailAddr1New.Text = "";
            tbscLTMailAddr2New.Text = "";
            tbscLTCityNew.Text = "";
            tbscLTStateNew.Text = "";
            tbscLTZipNew.Text = "";
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
            return lblRequestNewResults;
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
            scLotBeingEdited = (string)dr["scLot"];
            scLaneBeingEdited = (string)dr["scLane"];
            scfkPropIDBeingEdited = (string)dr["fkscPropID"];
            object dateFormPrinted = Utils.ObjectToString(dr["DateFormPrinted"]);
            if (Utils.isNothingNot(dateFormPrinted)) {
                lblDatePrinted.Text = ((DateTime)dateFormPrinted).ToString();
            }
            DateTime? date = Utils.ObjectToDateTimeNullable(dr["scLTDate"]);
            if (date.HasValue) {
                tbLTDateUpdate.Text = date.Value.ToShortDateString();
            }
            tbscLTRecipientUpdate.Text=Utils.ObjectToString(dr["scLTRecipient"]);
            tbscLTMailAddr1Update.Text = Utils.ObjectToString(dr["scLTMailAddr1"]);
            tbscLTMailAddr2Update.Text = Utils.ObjectToString(dr["scLTMailAddr2"]);
            tbscLTCityUpdate.Text = Utils.ObjectToString(dr["scLTCity"]);
            tbscLTStateUpdate.Text = Utils.ObjectToString(dr["scLTState"]);
            tbscLTZipUpdate.Text = Utils.ObjectToString(dr["scLTZip"]);
            tbscLTCCopy1Update.Text = Utils.ObjectToString(dr["scLTCCopy1"]);
            tbscLTCCopy2Update.Text = Utils.ObjectToString(dr["scLTCCopy2"]);
            string realtor=Utils.ObjectToString(dr["scRealtor"]);
            if (Utils.isNothingNot(realtor)) {
                ddlscRealtorUpdate.SelectedValue = realtor;
            } else {
                ddlscRealtorUpdate.SelectedIndex = 0;
            }

            return "Lot\\Lane: " + getLotLane(dr) + "  Request ID: " + scRequestIDBeingEdited + "  Property ID:" + getPropertyId(dr) + " Requestor: " + getRecipient(dr);
        }
        protected override void lockYourUpdateFields() {
            tbLTDateUpdate.Enabled = false;
            ibtbLTDateUpdate.Visible = false;
            tbscLTRecipientUpdate.Enabled = false;
            tbscLTMailAddr1Update.Enabled = false;
            tbscLTMailAddr2Update.Enabled = false;
            tbscLTCityUpdate.Enabled = false;
            tbscLTStateUpdate.Enabled = false;
            tbscLTZipUpdate.Enabled = false;
            tbscLTCCopy1Update.Enabled = false;
            tbscLTCCopy2Update.Enabled = false;
            tbscLTCCopy3Update.Enabled = false;
            btnSellRequestUpdate.Visible = false;
            btnPrintForm.Visible = true;
            lblDatePrinted.Visible = true;
            lblDatePrintedHeading.Visible = true;
            ddlscRealtorUpdate.Enabled = false;
            lblSellRequestUpdateResults.Visible = false;
        }
        protected override void unlockYourUpdateFields() {
            lblSellRequestUpdateResults.Visible = true;
            btnPrintForm.Visible = false;
            lblDatePrinted.Visible = false;
            lblDatePrintedHeading.Visible = false;
            tbLTDateUpdate.Enabled = true;
            ibtbLTDateUpdate.Visible = true;
            tbscLTRecipientUpdate.Enabled = true;
            tbscLTMailAddr1Update.Enabled = true;
            tbscLTMailAddr2Update.Enabled = true;
            tbscLTCityUpdate.Enabled = true;
            tbscLTStateUpdate.Enabled = true;
            tbscLTZipUpdate.Enabled = true;
            tbscLTCCopy1Update.Enabled = true;
            tbscLTCCopy2Update.Enabled = true;
            tbscLTCCopy3Update.Enabled = true;
            btnSellRequestUpdate.Visible = true;
            ddlscRealtorUpdate.Enabled = true;
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
        protected override string UpdateRoleName {
            get { return "canupdatesellcheck"; }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        protected void btnSellRequestUpdateOkay_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspSellCheckRequestUpdate");

                cmd.Parameters.Add("@scRequestID", SqlDbType.Int).Value = scRequestIDBeingEdited;
                cmd.Parameters.Add("@scRealtor", SqlDbType.NVarChar).Value = ddlscRealtorUpdate.SelectedValue;
                DateTime? date = Utils.ObjectToDateTimeNullable(tbLTDateUpdate.Text);
                if (date.HasValue) {
                    cmd.Parameters.Add("@scLTDate", SqlDbType.DateTime).Value = date;
                }
                cmd.Parameters.Add("@scLTRecipient", SqlDbType.NVarChar).Value = tbscLTRecipientUpdate.Text;
                cmd.Parameters.Add("@scLTMailAddr1", SqlDbType.NVarChar).Value = tbscLTMailAddr1Update.Text;
                cmd.Parameters.Add("@scLTMailAddr2", SqlDbType.NVarChar).Value = tbscLTMailAddr2Update.Text;
                cmd.Parameters.Add("@scLTCity", SqlDbType.NVarChar).Value = tbscLTCityUpdate.Text;
                cmd.Parameters.Add("@scLTState", SqlDbType.NVarChar).Value = tbscLTStateUpdate.Text;
                cmd.Parameters.Add("@scLTZip", SqlDbType.NVarChar).Value = tbscLTZipUpdate.Text;
                cmd.Parameters.Add("@scLTCCopy1", SqlDbType.NVarChar).Value = tbscLTCCopy1Update.Text;
                cmd.Parameters.Add("@scLTCCopy2", SqlDbType.NVarChar).Value = tbscLTCCopy2Update.Text;
                cmd.Parameters.Add("@scLTCCopy3", SqlDbType.NVarChar).Value = tbscLTCCopy3Update.Text;
                cmd.Parameters.Add("@scLot", SqlDbType.NVarChar).Value = scLotBeingEdited;
                cmd.Parameters.Add("@scLane", SqlDbType.NVarChar).Value = scLaneBeingEdited;
                cmd.Parameters.Add("@fkscPropID", SqlDbType.NVarChar).Value = scfkPropIDBeingEdited;
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter newscRequestID = new SqlParameter("@NewscRequestID", SqlDbType.Int);
                newscRequestID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newscRequestID);

                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }

        }
        protected void btnNewRequestCancel_Click(object sender, EventArgs args) {
            clearAllSelectionInputFields();
        }
        protected void btnNewRequestOk_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspSellCheckRequestUpdate");

                cmd.Parameters.Add("@scRealtor", SqlDbType.NVarChar).Value = ddlscRealtorUpdate.SelectedValue;
                DateTime? date = Utils.ObjectToDateTimeNullable(tbLTDateUpdate.Text);
                if (date.HasValue) {
                    cmd.Parameters.Add("@scLTDate", SqlDbType.DateTime).Value = date;
                }
                cmd.Parameters.Add("@scLTRecipient", SqlDbType.NVarChar).Value = tbscLTRecipientUpdate.Text;
                cmd.Parameters.Add("@scLTMailAddr1", SqlDbType.NVarChar).Value = tbscLTMailAddr1Update.Text;
                cmd.Parameters.Add("@scLTMailAddr2", SqlDbType.NVarChar).Value = tbscLTMailAddr2Update.Text;
                cmd.Parameters.Add("@scLTCity", SqlDbType.NVarChar).Value = tbscLTCityUpdate.Text;
                cmd.Parameters.Add("@scLTState", SqlDbType.NVarChar).Value = tbscLTStateUpdate.Text;
                cmd.Parameters.Add("@scLTZip", SqlDbType.NVarChar).Value = tbscLTZipUpdate.Text;
                cmd.Parameters.Add("@scLTCCopy1", SqlDbType.NVarChar).Value = tbscLTCCopy1Update.Text;
                cmd.Parameters.Add("@scLTCCopy2", SqlDbType.NVarChar).Value = tbscLTCCopy2Update.Text;
                cmd.Parameters.Add("@scLTCCopy3", SqlDbType.NVarChar).Value = tbscLTCCopy3Update.Text;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@scLot", SqlDbType.NVarChar).Value = tbscLotNew.Text;
                cmd.Parameters.Add("@scLane", SqlDbType.NVarChar).Value = ddlscLaneNew.SelectedValue;
                ((SiteMaster)Master.Master).getPropIDForLotLane( tbscLotNew.Text, ddlscLaneNew.SelectedValue);

            SqlParameter newscRequestID = new SqlParameter("@NewscRequestID", SqlDbType.Int);
            newscRequestID.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(newscRequestID);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);

            performPostNewSuccessfulActions("SellCheck Request added", DataSetCacheKey, null, tbRequestId, (int)newscRequestID.Value);
            } catch (Exception e2) {
                performPostNewFailedActions("BPermit not added. Msg: " + e2.Message);
            }
        }
        protected void lbRequestNewCmon_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspFindHighestRequestId");
            DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
            int maxRequestId = Convert.ToInt32(ds.Tables[0].Rows[0]["RequestID"]);
            maxRequestId++;
            ddlscLaneNew.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
            ddlscLaneNew.DataBind();

            lblAutoRequestId.Text = "" + maxRequestId;
            mpeNewRequest.Show();

        }
    }
}