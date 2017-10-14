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
    public partial class SellCheck : AbstractDatabase, ICanHavePDFs {
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
        public DataSet getLadderFuelDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "LFDSt";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspLadderFuelGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
                DataRow dr = ds.Tables[0].NewRow();
                dr["LadderFuel"] = null;
                ds.Tables[0].Rows.InsertAt(dr, 0);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }
        public DataSet getFeesDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "FEDSt";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspFeesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
                DataRow dr = ds.Tables[0].NewRow();
                dr["InspectionFee"] = DBNull.Value;
                dr["InspectionType"] = null;
                ds.Tables[0].Rows.InsertAt(dr, 0);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        public static string DataSetCacheKey {
            get { return "SCDS"; }
        }
        protected override System.Data.DataSet buildDataSet() {
            return SCDataSet();
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
                DataSet realtor = dsRealtor;
                DataRow dr = realtor.Tables[0].NewRow();
                dr["RealtyCo"] = "";
                realtor.Tables[0].Rows.InsertAt(dr, 0);
                ddlscRealtorUpdate.DataSource = realtor;
                ddlscRealtorUpdate.DataBind();
                ddlscRealtorNew.DataSource = realtor;
                ddlscRealtorNew.DataBind();

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
            bind_gvInspections(scRequestIDBeingEdited);
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "scRequestID=" + getscRequestID(row);
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            scLotBeingEdited = (string)dr["scLot"];
            scLaneBeingEdited = (string)dr["scLane"];
            scfkPropIDBeingEdited = (string)dr["fkscPropID"];
            SetLaneLotForPDFs(scLaneBeingEdited + " " + scLotBeingEdited);

            object dateFormPrinted = Utils.ObjectToString(dr["DateFormPrinted"]);
            if (Utils.isNothingNot(dateFormPrinted)) {
                lblDatePrinted.Text = dateFormPrinted.ToString();
            }
            DateTime? date = Utils.ObjectToDateTimeNullable(dr["scLTDate"]);
            if (date.HasValue) {
                tbLTDateUpdate.Text = date.Value.ToShortDateString();
            }
            tbscLTRecipientUpdate.Text = Utils.ObjectToString(dr["scLTRecipient"]);
            tbscLTMailAddr1Update.Text = Utils.ObjectToString(dr["scLTMailAddr1"]);
            tbscLTMailAddr2Update.Text = Utils.ObjectToString(dr["scLTMailAddr2"]);
            tbscLTCityUpdate.Text = Utils.ObjectToString(dr["scLTCity"]);
            tbscLTStateUpdate.Text = Utils.ObjectToString(dr["scLTState"]);
            tbscLTZipUpdate.Text = Utils.ObjectToString(dr["scLTZip"]);
            tbscLTCCopy1Update.Text = Utils.ObjectToString(dr["scLTCCopy1"]);
            tbscLTCCopy2Update.Text = Utils.ObjectToString(dr["scLTCCopy2"]);
            tbscLTCCopy3Update.Text = Utils.ObjectToString(dr["scLTCCopy3"]);
            string realtor = Utils.ObjectToString(dr["scRealtor"]);
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
            lblNewInspection.Visible = false;
            lbRequestNew.Visible = false;
            gvInspections.Enabled = false;
        }
        protected override void unlockYourUpdateFields() {
            gvInspections.Enabled = true;
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
            lblNewInspection.Visible = true;
            lbRequestNew.Visible = true;
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
                    inspectionId = Convert.ToInt32(tbInspectionID.Text);
                } catch { }

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
        protected void btnPrintForm_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspSellCheckRequestDateFormPrintedUpdate");
            cmd.Parameters.Add("@scRequestID", SqlDbType.Int).Value = scRequestIDBeingEdited;
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            lblDatePrinted.Text = DateTime.Now.ToString();
        }
        protected void btnNewRequestCancel_Click(object sender, EventArgs args) {
            clearAllSelectionInputFields();
            clearAllNewFormInputFields();
        }
        protected void btnNewRequestOk_Click(object sender, EventArgs args) {
            try {
                bool gotErrorBecauseValidatorsDontWorkHereForSomeReason = false;
                lblddlscLaneNewErrorMsg.Text = "";
                if (Utils.isNothing(tbscLotNew.Text)) {
                    lblscLotNewErrorMsg.Text = "required";
                    gotErrorBecauseValidatorsDontWorkHereForSomeReason = true;
                } else {
                    lblscLotNewErrorMsg.Text = "";
                }
                if (ddlscLaneNew.SelectedIndex == 0) {
                    lblddlscLaneNewErrorMsg.Text = "required";
                    gotErrorBecauseValidatorsDontWorkHereForSomeReason = true;
                } else {
                    lblddlscLaneNewErrorMsg.Text = "";
                }
                string propid = null;
                if (!gotErrorBecauseValidatorsDontWorkHereForSomeReason) {
                    propid = ((SiteMaster)Master.Master.Master).getPropIDForLotLane(tbscLotNew.Text, ddlscLaneNew.SelectedValue);
                }
                if (!gotErrorBecauseValidatorsDontWorkHereForSomeReason && Utils.isNothing(propid)) {
                    lblddlscLaneNewErrorMsg.Text = "Property doesn't exist";
                    gotErrorBecauseValidatorsDontWorkHereForSomeReason = true;
                }
                if (gotErrorBecauseValidatorsDontWorkHereForSomeReason) {
                    mpeNewRequest.Show();
                    return;
                }

                SqlCommand cmd = new SqlCommand("uspSellCheckRequestUpdate");

                cmd.Parameters.Add("@scRealtor", SqlDbType.NVarChar).Value = ddlscRealtorNew.SelectedValue;
                DateTime? date = Utils.ObjectToDateTimeNullable(tbLTDateNew.Text);
                if (date.HasValue) {
                    cmd.Parameters.Add("@scLTDate", SqlDbType.DateTime).Value = date;
                }
                cmd.Parameters.Add("@scLTRecipient", SqlDbType.NVarChar).Value = tbscLTRecipientNew.Text;
                cmd.Parameters.Add("@scLTMailAddr1", SqlDbType.NVarChar).Value = tbscLTMailAddr1New.Text;
                cmd.Parameters.Add("@scLTMailAddr2", SqlDbType.NVarChar).Value = tbscLTMailAddr2New.Text;
                cmd.Parameters.Add("@scLTCity", SqlDbType.NVarChar).Value = tbscLTCityNew.Text;
                cmd.Parameters.Add("@scLTState", SqlDbType.NVarChar).Value = tbscLTStateNew.Text;
                cmd.Parameters.Add("@scLTZip", SqlDbType.NVarChar).Value = tbscLTZipNew.Text;
                cmd.Parameters.Add("@scLTCCopy1", SqlDbType.NVarChar).Value = tbscLTCCopy1New.Text;
                cmd.Parameters.Add("@scLTCCopy2", SqlDbType.NVarChar).Value = tbscLTCCopy2New.Text;
                cmd.Parameters.Add("@scLTCCopy3", SqlDbType.NVarChar).Value = tbscLTCCopy3New.Text;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@scLot", SqlDbType.NVarChar).Value = tbscLotNew.Text;
                cmd.Parameters.Add("@scLane", SqlDbType.NVarChar).Value = ddlscLaneNew.SelectedValue;
                cmd.Parameters.Add("@fkscPropID", SqlDbType.NVarChar).Value = propid;

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
            lblddlscLaneNewErrorMsg.Text = "";
            lblscLotNewErrorMsg.Text = "";
            lblAutoRequestId.Text = "" + maxRequestId;
            ddlscRealtorNew.SelectedIndex = 0;
            mpeNewRequest.Show();
        }
        protected void gvInspections_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvInspections.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            bind_gvInspections(scRequestIDBeingEdited);
        }

        protected void gvInspections_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvInspections.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvInspections(scRequestIDBeingEdited);
        }

        protected void gvInspections_RowUpdating(object sender, GridViewUpdateEventArgs e) {

            GridViewRow row = gvInspections.Rows[e.RowIndex];
            try {
                int inspectionId = Convert.ToInt32(((Label)row.Cells[1].Controls[1]).Text);
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

                performPostUpdateSuccessfulActions("Inspection updated", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Inspection not updated. Error msg: " + ee.Message);
            }
            //Reset the edit index.
            gvInspections.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvInspections(scRequestIDBeingEdited);
        }
        private void bind_gvInspections(int scRequestID) {
            DataTable sourceTableInspections = SCDataSet().Tables[1];
            DataView viewInspections = new DataView(sourceTableInspections);
            viewInspections.RowFilter = "fkscRequestID=" + scRequestID;
            DataTable tblFilteredReviews = viewInspections.ToTable();
            gvInspections.DataSource = tblFilteredReviews;
            gvInspections.DataBind();
        }
        protected void btnNewInspectionOk_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspSellCheckInspectionUpdate");

                cmd.Parameters.Add("@fkscRequestID", SqlDbType.Int).Value = scRequestIDBeingEdited;
                DateTime? date = Utils.ObjectToDateTimeNullable(tbDateNew.Text);
                cmd.Parameters.Add("@scDate", SqlDbType.DateTime).Value = date.HasValue ? date.Value : (DateTime?)null;
                decimal? fee = Utils.isNothing(ddlFeeNew.SelectedValue) ? (decimal?)null : Utils.ObjectToDecimal(ddlFeeNew.SelectedValue);
                cmd.Parameters.Add("@scFee", SqlDbType.Money).Value = fee;
                cmd.Parameters.Add("@scPaid", SqlDbType.Bit).Value = cbPaidNew.Checked;
                cmd.Parameters.Add("@scPaidMemo", SqlDbType.NVarChar).Value = tbPaidMemoNew.Text;
                DateTime? dateClosed = Utils.ObjectToDateTimeNullable(tbDateClosedNew.Text);
                cmd.Parameters.Add("@scDateClosed", SqlDbType.DateTime).Value = (dateClosed.HasValue ? dateClosed.Value : (DateTime?)null);
                cmd.Parameters.Add("@scLadderFuel", SqlDbType.NVarChar).Value = ddlLadderFuelNew.SelectedValue;
                cmd.Parameters.Add("@scNoxWeeds", SqlDbType.NVarChar).Value = ddlNoxWeedsNew.SelectedValue;
                cmd.Parameters.Add("@scComments", SqlDbType.NVarChar).Value = tbCommentsNew.Text;
                cmd.Parameters.Add("@scFollowUp", SqlDbType.NVarChar).Value = tbFollowUpNew.Text;
                SqlParameter newid = new SqlParameter("@NewID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString);

                performPostUpdateSuccessfulActions("Inspection added", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Inspection not updated. Error msg: " + ee.Message);
            }
            mpeNewInspection.Hide();
        }
        protected void btnNewInspectionCancel_Click(object sender, EventArgs args) {
            mpeNewInspection.Hide();

        }
        protected void lblNewInspection_OnClick(object sender, EventArgs args) {
            tbDateNew.Text = "";
            cbPaidNew.Checked = false;
            tbPaidMemoNew.Text = "";
            tbDateClosedNew.Text = "";
            ddlLadderFuelNew.DataSource = getLadderFuelDataSet();
            ddlLadderFuelNew.DataBind();
            ddlLadderFuelNew.SelectedIndex = -1;
            ddlNoxWeedsNew.DataSource = getLadderFuelDataSet();
            ddlNoxWeedsNew.DataBind();
            ddlNoxWeedsNew.SelectedIndex = -1;

            ddlFeeNew.DataSource = getFeesDataSet();
            ddlFeeNew.DataBind();
            ddlFeeNew.SelectedIndex = -1;

            
            tbCommentsNew.Text = "";
            tbFollowUpNew.Text = "";
            mpeNewInspection.Show();
        }
        public string getBRsInsteadOfCRLFs(object str) {
            if (Utils.isNothing(str)) {
                return "";
            }
            string strOfstr = (string)str;
            return strOfstr.Replace("\r\n", "<br />").Replace("\n", "<br />").Replace("\r", "<br />");
        }

        protected void gvInspections_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0) {
                    DropDownList ddList = (DropDownList)e.Row.FindControl("dllscLadderFuelUpdate");
                    if (ddList != null) {
                        //bind dropdownlist
                        DataTable dt = getLadderFuelDataSet().Tables[0];
                        ddList.DataSource = dt;
                        ddList.DataTextField = "LadderFuel";
                        ddList.DataValueField = "LadderFuel";
                        ddList.DataBind();
                        DataRowView dr = e.Row.DataItem as DataRowView;
                        ddList.SelectedValue = dr["scLadderFuel"].ToString();
                    }
                    DropDownList ddList2 = (DropDownList)e.Row.FindControl("ddlNoxWeedsUpdate");
                    if (ddList2 != null) {
                        //bind dropdownlist
                        DataTable dt = getLadderFuelDataSet().Tables[0];
                        ddList2.DataSource = dt;
                        ddList2.DataTextField = "LadderFuel";
                        ddList2.DataValueField = "LadderFuel";
                        ddList2.DataBind();
                        DataRowView dr = e.Row.DataItem as DataRowView;
                        ddList2.SelectedValue = dr["scNoxWeeds"].ToString();
                    }
                    DropDownList ddList3 = (DropDownList)e.Row.FindControl("ddlFeeUpdate");
                    if (ddList3 != null) {
                        //bind dropdownlist
                        DataTable dt = getFeesDataSet().Tables[0];
                        ddList3.DataSource = dt;
                        ddList3.DataTextField = "InspectionFee";
                        ddList3.DataValueField = "InspectionFee";
                        ddList3.DataBind();
                        DataRowView dr = e.Row.DataItem as DataRowView;
                        ddList3.SelectedValue = dr["scFee"].ToString();
                    }
                }
            }
        }

        protected void ddlFeeNew_DataBound(object sender, EventArgs e) {
            foreach (ListItem Item in ((DropDownList)sender).Items) {
                decimal? fee = Utils.isNothing(Item.Text) ? (decimal?)null : Convert.ToDecimal(Item.Text);
                if (fee.HasValue) {
                    Item.Text = fee.Value.ToString("c");
                }
            }
        }
        protected void ddlFeeUpdate_DataBound(object sender, EventArgs e) {
            foreach (ListItem Item in ((DropDownList)sender).Items) {
                decimal? fee = Utils.isNothing(Item.Text) ? (decimal?)null : Convert.ToDecimal(Item.Text);
                if (fee.HasValue) {
                    Item.Text = fee.Value.ToString("c");
                }
            }
        }
        public static string MyMenuName = "Sell Check";
        protected override string childMenuName {
            get { return MyMenuName; }
        }

        public bool HasPropertyAvailable {
            get { return Utils.isNothingNot(scfkPropIDBeingEdited); }
        }

        public void SetLaneLotForPDFs(string lanelot) {
            LaneLotForPDFs = lanelot;
        }
    }
}