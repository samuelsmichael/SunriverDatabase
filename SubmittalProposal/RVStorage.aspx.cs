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
    public partial class RVStorage : AbstractDatabase {
        private int rvLeastIDBeingEdited {
            get {
                object obj = ViewState["rvLeastIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                ViewState["rvLeastIDBeingEdited"] = value;
            }
        }
        protected void gvRVStorageAvailableSpaces_SelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvRVStorageAvailableSpaces.SelectedRow;
            Object obj = row.Cells;
            tbCurrentSpaceProtectedUpdate.Text = row.Cells[1].Text;
            PendingSpace=row.Cells[1].Text;
            mpeAvailableSpaces.Hide();
        }

        private string SpaceBeforeUpdate {
            get {
                DataTable sourceTable = getGridViewDataTable();
                DataView view = new DataView(sourceTable);
                view.RowFilter = "RVLeaseID=" + rvLeastIDBeingEdited;
                DataTable tblFiltered = view.ToTable();
                DataRow dr = tblFiltered.Rows[0];
                return Utils.ObjectToString(dr["tRVDSpace"]);
            }
        }
        private string PendingSpace {
            get {
                return Utils.ObjectToString(Session["rvstoragePendingSpace"]);
            }
            set {
                Session["rvstoragePendingSpace"] = Utils.ObjectToString(value);
            }
        }

        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            tcRVStorageUpdate.ActiveTabIndex = 0;
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            rvLeastIDBeingEdited = Convert.ToInt32(row.Cells[7].Text);

            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "RVLeaseID=" + rvLeastIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            #region Owner Information
            tbRVOwnerFirstNameUpdate.Text = Common.Utils.ObjectToString(dr["FirstName"]);
            tbRVOwnerLastNameUpdate.Text = Common.Utils.ObjectToString(dr["LastName"]);
            tbDriversLicenseUpdate.Text = Common.Utils.ObjectToString(dr["DrivLics#"]);
            tbEmailUpdate.Text = Common.Utils.ObjectToString(dr["E-Mail"]);
            tbOtherPhoneUpdate.Text = Common.Utils.ObjectToString(dr["OtherPhone"]);
            tbSunriverPhoneUpdate.Text = Common.Utils.ObjectToString(dr["SunriverPhone"]);
            tbAddr1OwnerInfo.Text = Common.Utils.ObjectToString(dr["Addr1"]);
            tbAddr2OwnerInfo.Text = Common.Utils.ObjectToString(dr["Addr2"]);
            tbCityOwnerInfo.Text = Common.Utils.ObjectToString(dr["City"]);
            tbRegionOwnerInfo.Text = Common.Utils.ObjectToString(dr["Region"]);
            tbPostalCodeOwnerInfo.Text = Common.Utils.ObjectToString(dr["PostalCode"]);
            tbSunriverAddressOwnerInfo.Text = Common.Utils.ObjectToString(dr["Attn"]);
            if ((Common.Utils.isNothingNot(dr["CustomerID"]))) {
                tbOwnerIdOwnerInfo.Text = Common.Utils.ObjectToString(dr["CustomerID"]);
                SqlConnection conn = null;
                SqlCommand cmd = null;
                try {
                    conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                    conn.Open();
                    cmd = new SqlCommand("udfFindOnePropertyIDFromCustomerID", conn);
                    cmd.Parameters.Add("@CustomerID", SqlDbType.NVarChar).Value = Utils.ObjectToString(dr["CustomerID"]);
                    SqlParameter retValue = new SqlParameter("@nvarcharResult",SqlDbType.NVarChar);                    
                    retValue.Direction = ParameterDirection.ReturnValue;
                    cmd.Parameters.Add(retValue);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    tbPropertyIdOwnerInfo.Text = retValue.Value==null?"":retValue.Value.ToString();
                } finally {
                    try { cmd.Dispose(); } catch { }
                    try { conn.Close(); } catch { }
                }
            } else {
                tbOwnerIdOwnerInfo.Text = "";
                tbPropertyIdOwnerInfo.Text = "";
            }
            //    tbAddr1Update.Text = Common.Utils.ObjectToString(dr["NO-MailAddr1"]);
            //    tbAddr2Update.Text = Common.Utils.ObjectToString(dr["NO-MailAddr2"]);
            //    tbCityUpdate.Text = Common.Utils.ObjectToString(dr["NO-City"]);
            //    tbRegionUpdate.Text = Common.Utils.ObjectToString(dr["NO-State"]);
            //    tbPostalCodeUpdate.Text = Common.Utils.ObjectToString(dr["NO-Zip"]);
            //    tbSunriverAddressUpdate.Text = Common.Utils.ObjectToString(dr["NO-SunriverAddr"]);
            tbCurrentSpaceProtectedUpdate.Text = Utils.ObjectToString(dr["tRVDSpace"]);
            PendingSpace = Utils.ObjectToString(dr["tRVDSpace"]);
            #endregion
            #region RV & Space Into tab
            ddlRVSpaceInfoSpaceSizeReqdUpdate.SelectedValue = Utils.ObjectToString(dr["SpaceSizeReqt"]);
            ddlRVSpaceInfoElectricalReqdYesNoUpdate.SelectedValue = Utils.ObjectToBool(dr["ElectricReqt"]) ? "Yes" : "No";
            tbVehicleLengthUpdate.Text = Utils.ObjectToString(dr["VehicleLength"]);
            tbRVTypeUpdate.Text= Utils.ObjectToString(dr["RVType"]);
            tbRVMakeUpdate.Text= Utils.ObjectToString(dr["RVMake"]);
            tbRVModelUpdate.Text= Utils.ObjectToString(dr["RVModel"]);
            tbVehicleLicenseUpdate.Text=Utils.ObjectToString(dr["VehLics#"]);
            tbVehicleLicenseStateUpdate.Text=Utils.ObjectToString(dr["VehLicsState"]);
            string lien=Utils.ObjectToString(dr["Lien"]);
            tbLienUpdate.Text = lien;
            ddlSpaceTypeUpdate.SelectedValue = Utils.ObjectToString(dr["SpaceType"]);
            ddlPermanentAssignmentUpdate.SelectedValue = Utils.ObjectToBool(dr["PermanantAssign"]) ? "Yes" : "No";
            #endregion
            #region Lease Information
            ddlPaymentThisYearUpdate.SelectedValue = Utils.ObjectToBool(dr["LeasePaid"]) ? "Yes" : "No";
            DateTime? leaseStartDate = Utils.ObjectToDateTimeNullable(dr["LeaseStartDate"]);
            tbLeaseStartDateUpdate.Text=leaseStartDate.HasValue?leaseStartDate.Value.ToString("d"):"";
            ddlLeaseCancelledUpdate.SelectedValue = Utils.ObjectToBool(dr["LeaseCancelled"]) ? "Yes" : "No";
            DateTime? waitListDateUpdate = Utils.ObjectToDateTimeNullable(dr["WaitListDate"]);
            tbWaitListDateUpdate.Text = waitListDateUpdate.HasValue ? waitListDateUpdate.Value.ToString("d") : "";
            DateTime? leaseCancelledDate = Utils.ObjectToDateTimeNullable(dr["LeaseCancelDate"]);
            tbLeaseCancelledDate.Text = leaseCancelledDate.HasValue ? leaseCancelledDate.Value.ToString("d") : "";
            tbNotesUpdate.Text = Utils.ObjectToString(dr["Notes"]);
            #endregion
            #region Non-Owner Info
            int? clientid = Utils.ObjectToIntNullable(dr["CustomerID"]);
            string isOwner = "No";
            string firstName = Utils.ObjectToString(dr["FirstName"]).ToLower();
            if ((clientid.HasValue && firstName != "police") || firstName == "publicworks") {
                isOwner = "Yes";
            }

            lblIsSROAOwnerUpdate.Text = isOwner;
            #endregion
            return "RVLease ID: " + rvLeastIDBeingEdited + "  First Name:" + dr["FirstName"] + " Last Name: " + dr["LastName"] + (Common.Utils.ObjectToBool(dr["LeaseCancelled"])?"<span style='margin-left:3em;color:Red'>CANCELLED</span>":"");

        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbLastNameSearch.Text)) {
                sb.Append(prepend + "LastName: " + tbLastNameSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbLastNameSearch.Text, "LastName"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlSpaceInfoSearch.SelectedValue)) {
                sb.Append(prepend + "Space: " + ddlSpaceInfoSearch.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " tRVDSpace = '" + ddlSpaceInfoSearch.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbRVLeaseIdSearch.Text)) {
                int rvLeaseId = -999;
                try {
                    rvLeaseId = Convert.ToInt32(tbRVLeaseIdSearch.Text);
                    sb.Append(prepend + "RV Lease ID: " + tbRVLeaseIdSearch.Text);
                    prepend = "  ";
                    sbFilter.Append(and + " RVLeaseID = " + tbRVLeaseIdSearch.Text );
                        ;
                    and = " and ";
                } catch { 
                }
            }
            if (Utils.isNothingNot(ddlYesNoSearch.SelectedValue)) {
                sb.Append(prepend + "Cancelled: " + ddlYesNoSearch.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " LeaseCancelled = " + (ddlYesNoSearch.SelectedValue=="Yes" ? "1":"0"));
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }

        protected void btnShowAvailableSpaces_OnClick(object sender, EventArgs args) {
            gvRVStorageAvailableSpaces.DataSource = buildDataSet().Tables[3];
            gvRVStorageAvailableSpaces.DataBind();
            mpeAvailableSpaces.Show();
        }

        protected override GridView getGridViewResults() {
            return gvResults;
        }
 
        protected string getLeaseCancelled(object value) {
            string retValue = "";
            try {
                if (Convert.ToBoolean(value)) {
                    retValue = "True";
                }
            } catch { }
            return retValue;
        }

        private static string DataSetCacheKey = "RVDataSet";
        protected override System.Data.DataSet buildDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = DataSetCacheKey;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspRVStorageTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["RVLeaseID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["tSISpace"] };
                ds.Tables[3].PrimaryKey = new DataColumn[] { ds.Tables[3].Columns["tSISpace"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;

        }

        protected override System.Data.DataTable getGridViewDataTable() {
            DataSet ds = buildDataSet();
            return ds.Tables[0];
        }

        protected void btnRVUpdateOkay_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspRVUpdate");

                cmd.Parameters.Add("@RvLeaseID", SqlDbType.Int).Value = rvLeastIDBeingEdited;
                
                //cmd.Parameters.Add("@scRealtor", SqlDbType.NVarChar).Value = ddlscRealtorUpdate.SelectedValue;
                //DateTime? date = Utils.ObjectToDateTimeNullable(tbLTDateUpdate.Text);
                //if (date.HasValue) {
                //    cmd.Parameters.Add("@scLTDate", SqlDbType.DateTime).Value = date;
                //}
                //cmd.Parameters.Add("@scLTRecipient", SqlDbType.NVarChar).Value = tbscLTRecipientUpdate.Text;
                //cmd.Parameters.Add("@scLTMailAddr1", SqlDbType.NVarChar).Value = tbscLTMailAddr1Update.Text;
                //cmd.Parameters.Add("@scLTMailAddr2", SqlDbType.NVarChar).Value = tbscLTMailAddr2Update.Text;
                //cmd.Parameters.Add("@scLTCity", SqlDbType.NVarChar).Value = tbscLTCityUpdate.Text;
                //cmd.Parameters.Add("@scLTState", SqlDbType.NVarChar).Value = tbscLTStateUpdate.Text;
                //cmd.Parameters.Add("@scLTZip", SqlDbType.NVarChar).Value = tbscLTZipUpdate.Text;
                //cmd.Parameters.Add("@scLTCCopy1", SqlDbType.NVarChar).Value = tbscLTCCopy1Update.Text;
                //cmd.Parameters.Add("@scLTCCopy2", SqlDbType.NVarChar).Value = tbscLTCCopy2Update.Text;
                //cmd.Parameters.Add("@scLTCCopy3", SqlDbType.NVarChar).Value = tbscLTCCopy3Update.Text;
                //cmd.Parameters.Add("@scLot", SqlDbType.NVarChar).Value = scLotBeingEdited;
                //cmd.Parameters.Add("@scLane", SqlDbType.NVarChar).Value = scLaneBeingEdited;
                //cmd.Parameters.Add("@fkscPropID", SqlDbType.NVarChar).Value = scfkPropIDBeingEdited;
                //cmd.CommandType = CommandType.StoredProcedure;

                //SqlParameter newscRequestID = new SqlParameter("@NewscRequestID", SqlDbType.Int);
                //newscRequestID.Direction = ParameterDirection.Output;
                //cmd.Parameters.Add(newscRequestID);

               ////// Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
                PendingSpace = null;
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }

        }

        protected override Label getUpdateResultsLabel() {
            return lblRVUpdateResults;
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            tbRVOwnerFirstNameUpdate.Enabled = true;
            tbRVOwnerLastNameUpdate.Enabled = true;
            tbDriversLicenseUpdate.Enabled = true;
            tbEmailUpdate.Enabled = true;
            tbSunriverPhoneUpdate.Enabled = true;
            tbOtherPhoneUpdate.Enabled = true;
            tbStateUpdate.Enabled = true;
            btnRVUpdate.Visible = true;
            tbVehicleLengthUpdate.Enabled = true;
            tbRVTypeUpdate.Enabled = true;
            tbRVMakeUpdate.Enabled = true;
            tbRVModelUpdate.Enabled = true;
            tbVehicleLicenseUpdate.Enabled = true;
            tbVehicleLicenseStateUpdate.Enabled = true;
            tbLienUpdate.Enabled = true;
            ddlRVSpaceInfoElectricalReqdYesNoUpdate.Enabled = true;
            ddlRVSpaceInfoSpaceSizeReqdUpdate.Enabled = true;
            ddlSpaceTypeUpdate.Enabled = true;
            ddlPermanentAssignmentUpdate.Enabled = true;
            ddlPaymentThisYearUpdate.Enabled = true;
            tbLeaseStartDateUpdate.Enabled = true;
            ibtbLeaseStartDateUpdate.Enabled = true;
            cetbLeaseStartDateUpdate.Enabled = true;
            ddlLeaseCancelledUpdate.Enabled = true;
            tbWaitListDateUpdate.Enabled = true;
            ibtbWaitListDateUpdate.Enabled = true;
            cetbWaitListDateUpdate.Enabled = true;
            tbLeaseCancelledDate.Enabled = true;
            ibtbLeaseCancelledDate.Enabled = true;
            cbtbLeaseCancelledDate.Enabled = true;
            tbNotesUpdate.Enabled = true;
        }

        protected override void lockYourUpdateFields() {
            ddlPermanentAssignmentUpdate.Enabled = false;
            ddlSpaceTypeUpdate.Enabled = false;
            tbRVOwnerFirstNameUpdate.Enabled = false;
            tbRVOwnerLastNameUpdate.Enabled = false;
            tbDriversLicenseUpdate.Enabled = false;
            tbEmailUpdate.Enabled = false;
            tbSunriverPhoneUpdate.Enabled = false;
            tbOtherPhoneUpdate.Enabled = false;
            tbStateUpdate.Enabled = false;
            btnRVUpdate.Visible = false;
            tbVehicleLengthUpdate.Enabled = false;
            tbRVTypeUpdate.Enabled = false;
            tbRVMakeUpdate.Enabled = false;
            tbRVModelUpdate.Enabled = false;
            tbVehicleLicenseUpdate.Enabled = false;
            tbVehicleLicenseStateUpdate.Enabled = false;
            tbLienUpdate.Enabled = false;
            ddlRVSpaceInfoElectricalReqdYesNoUpdate.Enabled = false;
            ddlRVSpaceInfoSpaceSizeReqdUpdate.Enabled = false;
            ddlPaymentThisYearUpdate.Enabled = false;
            tbLeaseStartDateUpdate.Enabled = false;
            ibtbLeaseStartDateUpdate.Enabled = false;
            cetbLeaseStartDateUpdate.Enabled = false;
            ddlLeaseCancelledUpdate.Enabled = false;
            tbWaitListDateUpdate.Enabled = false;
            ibtbWaitListDateUpdate.Enabled = false;
            cetbWaitListDateUpdate.Enabled = false;
            tbLeaseCancelledDate.Enabled = false;
            ibtbLeaseCancelledDate.Enabled = false;
            cbtbLeaseCancelledDate.Enabled = false;
            tbNotesUpdate.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            tbLastNameSearch.Text = "";
            tbRVLeaseIdSearch.Text = "";
            ddlSpaceInfoSearch.SelectedIndex = 0;
        }

        protected override void clearAllNewFormInputFields() {
           // throw new NotImplementedException();
        }

        protected override string UpdateRoleName {
            get { return "canupdateRVStorage"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            MemoryCache cache = MemoryCache.Default;
            cache.Remove("RVDataSet");
            expandCPESearch();
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                DataView dv = new DataView(buildDataSet().Tables[1]);
                DataTable dt = dv.Table.Copy();
                DataRow dr = dt.NewRow();
                dr["tSISpace"] = "";
                dt.Rows.InsertAt(dr, 0);
                ddlSpaceInfoSearch.DataSource = dt;
                ddlSpaceInfoSearch.DataBind();

                ddlRVSpaceInfoSpaceSizeReqdUpdate.DataSource = buildDataSet().Tables[2];
                ddlRVSpaceInfoSpaceSizeReqdUpdate.DataBind();
            }
        }

        /// <summary>
        /// The form hasn't been updated yet; so this is a place where inter-tab communication can take place.
        ///   -- PendingSpace has the Space from the Owner Info tab; so use that value on the RV & Space information tab.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void tcRVStorageUpdate_ActiveTabChanged(object sender, EventArgs e) {
            string space = PendingSpace;
            tbRVSpaceInfoSpaceProtectedUpdate.Text = space;
            DataRow drSpaceInfo = buildDataSet().Tables[1].Rows.Find(space);
            string fmtAnnualRent = String.Format("{0:C}", Utils.ObjectToDecimal0IfNull(Utils.ObjectToString(drSpaceInfo["AnnualRent"])));
            switch (tcRVStorageUpdate.ActiveTabIndex) {
                case 1:
                    #region RV & Space Into tab
                    tbSpaceSizeRVTabUpdate.Text = Utils.ObjectToString(drSpaceInfo["tSISpaceSize"]);
                    tbElectricalServiceRVTabUpdate.Text = Utils.ObjectToBool(drSpaceInfo["tSIElectServ"]) ? "Yes" : "No";
                    tbRVSpaceInfoSpaceLeasedProtectedUpdate.Text = Utils.ObjectToBool(drSpaceInfo["SpaceLeased"]) ? "Yes" : "No";
                    tbAnnualRentRVTabUpdate.Text = fmtAnnualRent;
                    #endregion
                    break;
                case 2:
                #region Lease Information
                    tbRVSpaceLeaseInformationProtectedUpdate.Text = PendingSpace;
                    tbLeaseInformationAnnualRentProtectedUpdate.Text = fmtAnnualRent;

                #endregion
                    break;
                default:
                    break;
            }
        }
    }
}