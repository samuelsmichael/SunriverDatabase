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
        private String zCustomerID {
            get{
                return Utils.ObjectToString(Session["zRVStorageCustomerID"]);
            } set {
                Session["zRVStorageCustomerID"]=value;
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
            lblLeasedCancelledErrorMessage.Text = "";
            DataSet ds = null;
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
            tbStateUpdate.Text=Common.Utils.ObjectToString(dr["DrivLicsState"]);
            tbEmailUpdate.Text = Common.Utils.ObjectToString(dr["E-Mail"]);
            tbOtherPhoneUpdate.Text = Common.Utils.ObjectToString(dr["OtherPhone"]);
            tbSunriverPhoneUpdate.Text = Common.Utils.ObjectToString(dr["SunriverPhone"]);
            tbAddr1OwnerInfoUpdate.Text = Common.Utils.ObjectToString(dr["Addr1"]);
            tbAddr2OwnerInfo.Text = Common.Utils.ObjectToString(dr["Addr2"]);
            tbCityOwnerInfo.Text = Common.Utils.ObjectToString(dr["City"]);
            tbRegionOwnerInfo.Text = Common.Utils.ObjectToString(dr["Region"]);
            tbPostalCodeOwnerInfo.Text = Common.Utils.ObjectToString(dr["PostalCode"]);
            tbSunriverAddressOwnerInfo.Text = Common.Utils.ObjectToString(dr["Attn"]);
            if ((Common.Utils.isNothingNot(dr["CustomerID"]))) {
                tbOwnerIdOwnerInfo.Text = Common.Utils.ObjectToString(dr["CustomerID"]);
                zCustomerID=Common.Utils.ObjectToString(dr["CustomerID"]);
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
                zCustomerID=null;
            }
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
            tbNonOwnerFirstNameUpdate.Text = Common.Utils.ObjectToString(dr["FirstName"]);
            tbRVNonOwnerLastNameUpdate.Text = Common.Utils.ObjectToString(dr["LastName"]);
            tbNonOwnerSunriverPhoneUpdate.Text = Common.Utils.ObjectToString(dr["SunriverPhone"]);
            tbNonOwnerOtherPhoneUpdate.Text = Common.Utils.ObjectToString(dr["OtherPhone"]);
            tbNonOwnerEmailUpdate.Text = Common.Utils.ObjectToString(dr["E-Mail"]);
            tbNonOwnerDriversLicenseUpdate.Text = Common.Utils.ObjectToString(dr["DrivLics#"]);
            tbNonOwnerStateUpdate.Text = Common.Utils.ObjectToString(dr["DrivLicsState"]);
            tbAddr1NonOwnerInfoUpdate.Text = Common.Utils.ObjectToString(dr["NO-MailAddr1"]);
            tbAddr2NonOwnerInfoUpdate.Text = Common.Utils.ObjectToString(dr["NO-MailAddr2"]);
            tbCityNonOwnerInfoUpdate.Text = Common.Utils.ObjectToString(dr["NO-City"]);
            tbRegionNonOwnerInfoUpdate.Text = Common.Utils.ObjectToString(dr["NO-State"]);
            tbPostalCodeNonOwnerInfoUpdate.Text = Common.Utils.ObjectToString(dr["NO-Zip"]);
            tbNonOwnerSunriverAddressUpdate.Text = Common.Utils.ObjectToString(dr["NO-SunriverAddr"]);

            #endregion
            return "RVLease ID: " + rvLeastIDBeingEdited + "  First Name:" + dr["FirstName"] + " Last Name: " + dr["LastName"] + (Common.Utils.ObjectToBool(dr["LeaseCancelled"])?"<span id='spnCancelledId' style='margin-left:3em;color:Red'>CANCELLED</span>":"");

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
            if (Utils.isNothingNot(tbCustomerIDSearch.Text)) {
                int rvCustomerID = -999;
                try {
                    rvCustomerID = Convert.ToInt32(tbCustomerIDSearch.Text);
                    sb.Append(prepend + "Customer ID: " + tbCustomerIDSearch.Text);
                    prepend = "  ";
                    sbFilter.Append(and + " CustomerID = '" + tbCustomerIDSearch.Text + "'");
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

        protected bool ImInTimerTick {
            get {
                object obj = Session["ImInTimerTicks"];
                return obj==null?false:(bool)obj;
            }
            set {
                Session["ImInTimerTicks"] = value;
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e) {
            if (!ImInTimerTick) {
                ImInTimerTick = true;
                if (TimerTickerEnabled) {
                    if (Session["valueselectedbyfind"] != null) {
                        Button1X.Text = "Find Owner/Property";
                        Session["valueselectedbyfind"] = null;
                    }

                    /*
                     *  winhidden -> user closed the window with the red X, or Alt-F1 (4?)
                     *  Session["byebye"] is set when user clicks the Choose button
                    */
                    if (winhidden.Value == "y" || (Session["byebye"] != null && ((string)Session["byebye"]) == "yes")) {
                        Session["byebye"] = null;
                        TimerTickerEnabled = false;
                        Button1X.Text = "Find Owner/Property";
                    }
                    /*           if (Session["HereCommaHaveAPropertyId"] != null) {
                                   if (!(Session["HereCommaHaveAPropertyID"]==(Session["PriorPropertIDRVStorage"]))) {
                                       if (!(tbPropertyIdOwnerInfo.Text.Equals((string)Session["HereCommaHaveAPropertyID"]))) {
                                           Session["PriorPropertIDRVStorage"] = Session["HereCommaHaveAPropertyID"];
                                           Session["HereCommaHaveAPropertyID"] = null;
                                           btnRVUpdateOkay_Click(null, null);
                                           timetoclosewindowhidden.Value = "y";
                                       }
                                   }
                               } */
                    if (Session["HereCommaHaveAClientID"] != null) {

                        if (Session["PriorClientIDRVStorage"] == null || !((Session["HereCommaHaveAClientID"] == (Session["PriorClientIDRVStorage"])))) {
                            if (!(tbRVOwnerFirstNameUpdate.Text.Equals((string)Session["HereCommaHaveAClientID"]))) {

                                SqlCommand cmd = new SqlCommand("uspClientInfoGet");
                                cmd.Parameters.Add("ClientID", SqlDbType.NVarChar).Value = Session["HereCommaHaveAClientID"];
                                cmd.CommandType = CommandType.StoredProcedure;
                                // Update as many fields as I can be sure of

                                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                                if (ds != null && ds.Tables != null && ds.Tables.Count > 0 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0) {
                                    DataRow dr = ds.Tables[0].Rows[0];
                                    tbRVOwnerFirstNameUpdate.Text = Utils.ObjectToString(dr["PrimaryOwner"]);
                                    
                                    tbRVOwnerLastNameUpdate.Text = "";
                                    tbOtherPhoneUpdate.Text = "";
                                    tbEmailUpdate.Text = "";
                                    tbDriversLicenseUpdate.Text = "";
                                    tbNonOwnerSunriverPhoneUpdate.Text = Utils.ObjectToString(dr["Addr1"]);
                                    tbAddr1OwnerInfoUpdate.Text = Utils.ObjectToString(dr["Addr1"]);
                                    tbAddr2OwnerInfo.Text = Utils.ObjectToString(dr["Addr2"]); 
                                    tbSunriverPhoneUpdate.Text = Utils.ObjectToString(dr["Phone"]); 
                                    tbCityOwnerInfo.Text = Utils.ObjectToString(dr["City"]); ;
                                    tbRegionOwnerInfo.Text = Utils.ObjectToString(dr["Region"]); ;
                                    tbPostalCodeOwnerInfo.Text = Utils.ObjectToString(dr["PostalCode"]); ;
                                    tbSunriverAddressOwnerInfo.Text = Utils.ObjectToString(dr["SRAddress"]);

                                    btnRVUpdateOkay_Click(null, null);
                                    timetoclosewindowhidden.Value = "y";
                                    tbNonOwnerPropertyOwnerId.Text = Utils.ObjectToString(Session["HereCommaHaveAClientID"]);
                                    tbNonOwnerPropertyOwnerNameUpdate.Text = Utils.ObjectToString(dr["PrimaryOwner"]);

                                }

                                Session["PriorClientIDRVStorage"] = Session["HereCommaHaveAClientID"];
                                zCustomerID = Utils.ObjectToString(Session["HereCommaHaveAClientID"]);
                                Session["HereCommaHaveAClientID"] = null;



                            }
                        }
                    }
                }
                ImInTimerTick = false;
            }
        }
        private bool TimerTickerEnabled {
            get {
                object obj=Session["TimerTickerEnableBB"];
                return obj!=null; 
            }
            set {
                Session["TimerTickerEnableBB"] = value;
                if (value) {
                    if (!Timer1.Enabled) {
                        Timer1.Enabled = true;
                    }
                } else {
                    if(Timer1.Enabled) {
                        Timer1.Enabled=false;
                    }
                }
            }
        }
        private void doFindOwnerPropertyClickedUpdate() {
            Session["byebye"] = null;
            Session["valueselectedbyfind"] = null;
            TimerTickerEnabled = true;
            Timer1.Enabled = true;
        }
        protected void button1click(object sender, EventArgs args) {
            doFindOwnerPropertyClickedUpdate();
        }
        public static string DataSetCacheKey = "RVDataSet";
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

    cmd.Parameters.Add("@CustomerID",SqlDbType.NVarChar).Value=zCustomerID;
    cmd.Parameters.Add("@FirstName",SqlDbType.NVarChar).Value=tbRVOwnerFirstNameUpdate.Text;
    cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = tbRVOwnerLastNameUpdate.Text;
    cmd.Parameters.Add("@NO_MailAddr1", SqlDbType.NVarChar).Value = tbAddr1NonOwnerInfoUpdate.Text;
    cmd.Parameters.Add("@NO_MailAddr2", SqlDbType.NVarChar).Value = tbAddr2NonOwnerInfoUpdate.Text;

    cmd.Parameters.Add("@NO_City", SqlDbType.NVarChar).Value = tbCityNonOwnerInfoUpdate.Text;
    cmd.Parameters.Add("@NO_State", SqlDbType.NVarChar).Value = tbRegionNonOwnerInfoUpdate.Text;
    cmd.Parameters.Add("@NO_Zip", SqlDbType.NVarChar).Value = tbPostalCodeNonOwnerInfoUpdate.Text;
    cmd.Parameters.Add("@NO_SunriverAddr", SqlDbType.NVarChar).Value = tbNonOwnerSunriverAddressUpdate.Text;
    cmd.Parameters.Add("@SunriverPhone", SqlDbType.NVarChar).Value = tbSunriverPhoneUpdate.Text;
    cmd.Parameters.Add("@OtherPhone", SqlDbType.NVarChar).Value = tbOtherPhoneUpdate.Text;
    cmd.Parameters.Add("@E_Mail", SqlDbType.NVarChar).Value = tbEmailUpdate.Text;
    cmd.Parameters.Add("@DrivLics#", SqlDbType.NVarChar).Value = tbDriversLicenseUpdate.Text;
    cmd.Parameters.Add("@DrivLicsState", SqlDbType.NVarChar).Value = tbStateUpdate.Text;
    cmd.Parameters.Add("@RVType", SqlDbType.NVarChar).Value = tbRVTypeUpdate.Text;
    cmd.Parameters.Add("@RVMake", SqlDbType.NVarChar).Value = tbRVMakeUpdate.Text;
    cmd.Parameters.Add("@RVModel", SqlDbType.NVarChar).Value = tbRVModelUpdate.Text;
    cmd.Parameters.Add("@VehLics#", SqlDbType.NVarChar).Value = tbVehicleLicenseUpdate.Text;
    cmd.Parameters.Add("@VehLicsState", SqlDbType.NVarChar).Value = tbVehicleLicenseStateUpdate.Text;
    cmd.Parameters.Add("@VehicleLength", SqlDbType.NVarChar).Value = tbVehicleLengthUpdate.Text;
    cmd.Parameters.Add("@SpaceSizeReqt", SqlDbType.NVarChar).Value = ddlRVSpaceInfoSpaceSizeReqdUpdate.SelectedValue;
    cmd.Parameters.Add("@ElectricReqt",SqlDbType.Bit).Value=ddlRVSpaceInfoElectricalReqdYesNoUpdate.SelectedValue=="Yes";
    cmd.Parameters.Add("@Lien", SqlDbType.NVarChar).Value = tbLienUpdate.Text;
    cmd.Parameters.Add("@tRVDSpace",SqlDbType.NVarChar).Value=PendingSpace;
    cmd.Parameters.Add("@SpaceType",SqlDbType.NVarChar).Value=ddlSpaceTypeUpdate.SelectedValue;
    cmd.Parameters.Add("@PermanantAssign",SqlDbType.Bit).Value=ddlPermanentAssignmentUpdate.SelectedValue=="Yes";
    cmd.Parameters.Add("@LeasePaid",SqlDbType.Bit).Value=ddlPaymentThisYearUpdate.SelectedValue=="Yes";
    cmd.Parameters.Add("@Notes", SqlDbType.NVarChar).Value = tbNotesUpdate.Text;
    DateTime? waitListDate = Utils.ObjectToDateTimeNullable(tbWaitListDateUpdate.Text);
    if (waitListDate.HasValue) {
        cmd.Parameters.Add("@WaitListDate", SqlDbType.DateTime).Value = waitListDate;
    }
    DateTime? leaseStartDate = Utils.ObjectToDateTimeNullable(tbLeaseStartDateUpdate.Text);
    if (leaseStartDate.HasValue) {
        cmd.Parameters.Add("@LeaseStartDate", SqlDbType.DateTime).Value = leaseStartDate;
    }
    DateTime? leaseCancelDate = Utils.ObjectToDateTimeNullable(tbLeaseCancelledDate.Text);
    if (leaseCancelDate.HasValue) {
        cmd.Parameters.Add("@LeaseCancelDate", SqlDbType.DateTime).Value = leaseCancelDate;
    }

    cmd.Parameters.Add("@LeaseCancelled",SqlDbType.Bit).Value=ddlLeaseCancelledUpdate.SelectedValue=="Yes";
//    @WarningFlag1 nvarchar(18),
//    @Credit$ real,
//    @CreditPaid bit,
//    @FinalRent real,
    cmd.Parameters.Add("@PropOwnerName", SqlDbType.NVarChar).Value = tbNonOwnerPropertyOwnerNameUpdate.Text;
    cmd.Parameters.Add("@PropOwnerID", SqlDbType.NVarChar).Value = tbNonOwnerPropertyOwnerId.Text;

                SqlParameter newscRVLeaseID = new SqlParameter("@NewscLeaseID", SqlDbType.Int);
                newscRVLeaseID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newscRVLeaseID);


                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                clearAllSelectionInputFields();
                tbCustomerIDSearch.Text = zCustomerID;
                performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
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
            btnShowAvailableSpacesUpdate.Enabled = true;
            btnShowAvailableSpacesAdd.Enabled = true;
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

            tbNonOwnerFirstNameUpdate.Enabled = true;
            tbRVNonOwnerLastNameUpdate.Enabled = true;
            tbNonOwnerSunriverPhoneUpdate.Enabled = true;
            tbNonOwnerOtherPhoneUpdate.Enabled = true;
            tbNonOwnerEmailUpdate.Enabled = true;
            tbNonOwnerDriversLicenseUpdate.Enabled = true;
            tbNonOwnerStateUpdate.Enabled = true;
            tbAddr1NonOwnerInfoUpdate.Enabled = true;
            tbAddr2NonOwnerInfoUpdate.Enabled = true;
            tbCityNonOwnerInfoUpdate.Enabled = true;
            tbRegionNonOwnerInfoUpdate.Enabled = true;
            tbPostalCodeNonOwnerInfoUpdate.Enabled = true;
            tbNonOwnerSunriverAddressUpdate.Enabled = true;
            Button1X.Enabled = true;
            btnNonOwnerLookupSunriverPropertyOwnerInformation.Enabled = true;
            Button1X_Add.Enabled = true;
            btnNonOwnerLookupSunriverPropertyOwnerInformationAdd.Enabled = true;
        }

        protected override void lockYourUpdateFields() {
            btnShowAvailableSpacesUpdate.Enabled = false;
            btnShowAvailableSpacesAdd.Enabled = false;
            Button1X.Enabled = false;
            btnNonOwnerLookupSunriverPropertyOwnerInformation.Enabled = false;
            Button1X_Add.Enabled = false;
            btnNonOwnerLookupSunriverPropertyOwnerInformationAdd.Enabled = false;

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
            tbNonOwnerFirstNameUpdate.Enabled = false;
            tbRVNonOwnerLastNameUpdate.Enabled = false;
            tbNonOwnerSunriverPhoneUpdate.Enabled = false;
            tbNonOwnerOtherPhoneUpdate.Enabled = false;
            tbNonOwnerEmailUpdate.Enabled = false;
            tbNonOwnerDriversLicenseUpdate.Enabled = false;
            tbNonOwnerStateUpdate.Enabled = false;
            tbAddr1NonOwnerInfoUpdate.Enabled = false;
            tbAddr2NonOwnerInfoUpdate.Enabled = false;
            tbCityNonOwnerInfoUpdate.Enabled = false;
            tbRegionNonOwnerInfoUpdate.Enabled = false;
            tbPostalCodeNonOwnerInfoUpdate.Enabled = false;
            tbNonOwnerSunriverAddressUpdate.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            tbLastNameSearch.Text = "";
            tbRVLeaseIdSearch.Text = "";
            ddlSpaceInfoSearch.SelectedIndex = 0;
            tbCustomerIDSearch.Text = "";
        }

        protected override void clearAllNewFormInputFields() {
            tbRVOwnerFirstNameAdd.Text = "";
            tbRVOwnerLastNameAdd.Text = "";
            tbSunriverPhoneAdd.Text = "";
            tbOtherPhoneAdd.Text = "";
            tbEmailAdd.Text = "";
            tbDriversLicenseAdd.Text = "";
            tbStateAdd.Text = "";
            tbCurrentSpaceProtectedAdd.Text = "";
            tbAddr1OwnerInfoAdd.Text = "";
            tbAddr2OwnerInfoAdd.Text = "";
            tbCityOwnerInfoAdd.Text = "";
            tbRegionOwnerInfoAdd.Text = "";
            tbPostalCodeOwnerInfoAdd.Text = "";
            tbSunriverAddressOwnerInfoAdd.Text = "";
            tbPropertyIdOwnerInfoAdd.Text="";
            tbOwnerIdOwnerInfoAdd.Text = "";
            ddlRVSpaceInfoElectricalReqdYesNoAdd.SelectedValue = "No";
            ddlRVSpaceInfoSpaceSizeReqdAdd.SelectedIndex = 0;
            tbVehicleLengthAdd.Text = "";
            tbRVTypeAdd.Text = "";
            tbRVMakeAdd.Text = "";
            tbRVModelAdd.Text = "";
            tbVehicleLicenseAdd.Text = "";
            tbVehicleLicenseStateAdd.Text = "";
            tbLienAdd.Text = "";
            tbRVSpaceInfoSpaceProtectedAdd.Text = "";
            tbRVSpaceInfoSpaceLeasedProtectedAdd.Text = "";
            ddlSpaceTypeAdd.SelectedIndex = 0;
            ddlPermanentAssignmentAdd.SelectedValue = "No";
            tbSpaceSizeRVTabAdd.Text = "";
            tbElectricalServiceRVTabAdd.Text = "";
            tbAnnualRentRVTabAdd.Text = "";
            ddlPaymentThisYearAdd.SelectedValue = "No";
            tbLeaseStartDateAdd.Text = "";
            tbLeaseStartDateAdd.Text = "";
            ddlLeaseCancelledAdd.SelectedValue = "No";
            tbWaitListDateAdd.Text = "";
            tbLeaseCancelledDateAdd.Text = "";
            tbRVSpaceLeaseInformationProtectedAdd.Text = "";
            tbLeaseInformationAnnualRentProtectedAdd.Text = "";
            tbNotesAdd.Text = "";
            tbNonOwnerFirstNameAdd.Text = "";
            tbRVNonOwnerLastNameAdd.Text = "";
            tbNonOwnerSunriverPhoneAdd.Text = "";
            tbNonOwnerOtherPhoneAdd.Text = "";
            tbNonOwnerEmailAdd.Text = "";
            tbNonOwnerDriversLicenseAdd.Text = "";
            tbNonOwnerStateAdd.Text = "";
            tbNonOwnerCurrentSpaceProtectedAdd.Text = "";
            tbAddr1NonOwnerInfoAdd.Text = "";
            tbAddr2NonOwnerInfoAdd.Text = "";
            tbCityNonOwnerInfoAdd.Text = "";
            tbRegionNonOwnerInfoAdd.Text = "";
            tbPostalCodeNonOwnerInfoAdd.Text = "";
            tbNonOwnerSunriverAddressAdd.Text = "";
            lblIsSROAOwnerAdd.Text = "";
            tbNonOwnerPropertyOwnerNameAdd.Text = "";
            tbNonOwnerPropertyOwnerIdAdd.Text = "";
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
                
                Session["HereCommaHaveAPropertyID"] = null;
                Session["PriorPropertIDRVStorage"]=null;
                Session["HereCommaHaveAClientID"] = null;
                Session["HereCommaHaveAPropertyID_Add"] = null;
                Session["PriorPropertIDRVStorage_Add"] = null;
                Session["HereCommaHaveAClientID_Add"] = null;

                
                DataView dv = new DataView(buildDataSet().Tables[1]);
                DataTable dt = dv.Table.Copy();
                DataRow dr = dt.NewRow();
                dr["tSISpace"] = "";
                dt.Rows.InsertAt(dr, 0);
                ddlSpaceInfoSearch.DataSource = dt;
                ddlSpaceInfoSearch.DataBind();

                ddlRVSpaceInfoSpaceSizeReqdUpdate.DataSource = buildDataSet().Tables[2];
                ddlRVSpaceInfoSpaceSizeReqdUpdate.DataBind();
                ddlRVSpaceInfoSpaceSizeReqdAdd.DataSource = buildDataSet().Tables[2];
                ddlRVSpaceInfoSpaceSizeReqdAdd.DataBind();
                Timer1.Enabled = false;
                TimerTickerEnabled = false;
                Timer2.Enabled = false;
                TimerTickerEnabled_Add = false;
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
            string fmtAnnualRent = "";
            try {
                String.Format("{0:C}", Utils.ObjectToDecimal0IfNull(Utils.ObjectToString(drSpaceInfo["AnnualRent"])));
            } catch { }
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
                #region Non Owner Information
                case 3:
                    tbNonOwnerCurrentSpaceProtectedUpdate.Text = PendingSpace;
                    break;
                #endregion
                default:
                    break;
            }
        }
        protected void btnNonOwnerLookupSunriverPropertyOwnerInformation_onclick(object sender, EventArgs args) {
            doFindOwnerPropertyClickedUpdate();
        }
        protected void aNonOwnerFieldChanged_TextChanged(object sender, EventArgs args) {
            tbOtherPhoneUpdate.Text = tbNonOwnerOtherPhoneUpdate.Text;
            tbRVOwnerFirstNameUpdate.Text = tbNonOwnerFirstNameUpdate.Text;
            tbRVOwnerLastNameUpdate.Text = tbRVNonOwnerLastNameUpdate.Text;
            tbSunriverPhoneUpdate.Text = tbNonOwnerSunriverPhoneUpdate.Text;
            tbEmailUpdate.Text = tbNonOwnerEmailUpdate.Text;
            tbDriversLicenseUpdate.Text = tbNonOwnerDriversLicenseUpdate.Text;
            tbStateUpdate.Text = tbNonOwnerStateUpdate.Text;
        }
        protected void aNonOwnerAddFieldChanged_TextChanged(object sender, EventArgs args) {
            tbOtherPhoneUpdate.Text = tbNonOwnerOtherPhoneAdd.Text;
            tbRVOwnerFirstNameUpdate.Text = tbNonOwnerFirstNameAdd.Text;
            tbRVOwnerLastNameUpdate.Text = tbRVNonOwnerLastNameAdd.Text;
            tbSunriverPhoneUpdate.Text = tbNonOwnerSunriverPhoneAdd.Text;
            tbEmailUpdate.Text = tbNonOwnerEmailAdd.Text;
            tbDriversLicenseUpdate.Text = tbNonOwnerDriversLicenseAdd.Text;
            tbStateUpdate.Text = tbNonOwnerStateAdd.Text;
        }
        protected void btnNonOwnerLookupSunriverPropertyOwnerInformationAdd_onclick(object sender, EventArgs args) {
            doFindOwnerPropertyClickedAdd();
        }

        protected void anOwnerAddFieldChanged_TextChanged(object sender, EventArgs args) {
            tbNonOwnerOtherPhoneAdd.Text = tbOtherPhoneAdd.Text;
            tbNonOwnerFirstNameAdd.Text = tbRVOwnerFirstNameAdd.Text;
            tbRVNonOwnerLastNameAdd.Text = tbRVOwnerLastNameAdd.Text;
            tbNonOwnerSunriverPhoneAdd.Text = tbSunriverPhoneAdd.Text;
            tbNonOwnerEmailAdd.Text = tbEmailAdd.Text;
            tbNonOwnerDriversLicenseAdd.Text = tbDriversLicenseAdd.Text;
            tbNonOwnerStateAdd.Text = tbStateAdd.Text;
        }
        protected void anOwnerFieldChanged_TextChanged(object sender, EventArgs args) {
            tbNonOwnerOtherPhoneUpdate.Text = tbOtherPhoneUpdate.Text;
            tbNonOwnerFirstNameUpdate.Text = tbRVOwnerFirstNameUpdate.Text;
            tbRVNonOwnerLastNameUpdate.Text=tbRVOwnerLastNameUpdate.Text;
            tbNonOwnerSunriverPhoneUpdate.Text=tbSunriverPhoneUpdate.Text;
            tbNonOwnerEmailUpdate.Text = tbEmailUpdate.Text;
            tbNonOwnerDriversLicenseUpdate.Text=tbDriversLicenseUpdate.Text;
            tbNonOwnerStateUpdate.Text=tbStateUpdate.Text;
        }
        protected void ddlLeaseCancelledUpdate_OnSelectedIndexChanged(object sender, EventArgs args) {
            if (((DropDownList)sender).SelectedValue == "No") { // changed from Yes to No
                SqlCommand cmd = new SqlCommand("uspSpaceLeased");
                cmd.Parameters.Add("@Space", SqlDbType.NVarChar).Value = PendingSpace;
                SqlParameter rvLeaseID = new SqlParameter("@RVLeaseID", SqlDbType.Int, 10);
                rvLeaseID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(rvLeaseID);
                SqlParameter name = new SqlParameter("@Name", SqlDbType.NVarChar, 51);
                name.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(name);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                if (Utils.isNothingNot(rvLeaseID.Value)) {
                    lblLeasedCancelledErrorMessage.Text = "This space is already leased by " + name.Value + " (RVLeaseID " + rvLeaseID.Value + ").";
                    ((DropDownList)sender).SelectedValue = "Yes";
                }
            }
            /* This doesn't work.  Trying to update red "Cancelled" msg dynamically. No big deal, as it will get updated as soon as the user goes back to look at that record. */
            if (((DropDownList)sender).SelectedValue == "Yes") {
                ClientScriptManager cs = Page.ClientScript;
                StringBuilder cstext2 = new StringBuilder();
                cstext2.Append("<script type=\"text/javascript\">");
                cstext2.Append("try {document.getElementById('spnCancelledId').value)='Cancelled'} catch (e) {alert(e.toString())} </");
                cstext2.Append("script>");
                Type cstype = this.GetType();
                String csname2 = "UpdateCancelledStatusYes";
                cs.RegisterClientScriptBlock(cstype, csname2, cstext2.ToString(), false);
            } else {
            }
        }
        protected void lbRVStorageNewCmon_OnClick(object sender, EventArgs args) {
            mpeNewRVStorage.Show();
        }
        protected void btnNewRVStorageCancel_Click(object sender, EventArgs args) {
            clearAllSelectionInputFields();
            clearAllNewFormInputFields();
        }
        protected void btnNewRVStorageOk_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd=new SqlCommand("uspRVUpdate");
                SqlParameter newscRVLeaseID = new SqlParameter("@NewscLeaseID", SqlDbType.Int);
                newscRVLeaseID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newscRVLeaseID);

                cmd.Parameters.Add("@CustomerID", SqlDbType.NVarChar).Value = zCustomerID;
                cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = tbRVOwnerFirstNameAdd.Text;
                cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = tbRVOwnerLastNameAdd.Text;
                cmd.Parameters.Add("@NO_MailAddr1", SqlDbType.NVarChar).Value = tbAddr1NonOwnerInfoAdd.Text;
                cmd.Parameters.Add("@NO_MailAddr2", SqlDbType.NVarChar).Value = tbAddr2NonOwnerInfoAdd.Text;

                cmd.Parameters.Add("@NO_City", SqlDbType.NVarChar).Value = tbCityNonOwnerInfoAdd.Text;
                cmd.Parameters.Add("@NO_State", SqlDbType.NVarChar).Value = tbRegionNonOwnerInfoAdd.Text;
                cmd.Parameters.Add("@NO_Zip", SqlDbType.NVarChar).Value = tbPostalCodeNonOwnerInfoAdd.Text;
                cmd.Parameters.Add("@NO_SunriverAddr", SqlDbType.NVarChar).Value = tbNonOwnerSunriverAddressAdd.Text;
                cmd.Parameters.Add("@SunriverPhone", SqlDbType.NVarChar).Value = tbSunriverPhoneAdd.Text;
                cmd.Parameters.Add("@OtherPhone", SqlDbType.NVarChar).Value = tbOtherPhoneAdd.Text;
                cmd.Parameters.Add("@E_Mail", SqlDbType.NVarChar).Value = tbEmailAdd.Text;
                cmd.Parameters.Add("@DrivLics#", SqlDbType.NVarChar).Value = tbDriversLicenseAdd.Text;
                cmd.Parameters.Add("@DrivLicsState", SqlDbType.NVarChar).Value = tbStateAdd.Text;
                cmd.Parameters.Add("@RVType", SqlDbType.NVarChar).Value = tbRVTypeAdd.Text;
                cmd.Parameters.Add("@RVMake", SqlDbType.NVarChar).Value = tbRVMakeAdd.Text;
                cmd.Parameters.Add("@RVModel", SqlDbType.NVarChar).Value = tbRVModelAdd.Text;
                cmd.Parameters.Add("@VehLics#", SqlDbType.NVarChar).Value = tbVehicleLicenseAdd.Text;
                cmd.Parameters.Add("@VehLicsState", SqlDbType.NVarChar).Value = tbVehicleLicenseStateAdd.Text;
                cmd.Parameters.Add("@VehicleLength", SqlDbType.NVarChar).Value = tbVehicleLengthAdd.Text;
                cmd.Parameters.Add("@SpaceSizeReqt", SqlDbType.NVarChar).Value = ddlRVSpaceInfoSpaceSizeReqdAdd.SelectedValue;
                cmd.Parameters.Add("@ElectricReqt", SqlDbType.Bit).Value = ddlRVSpaceInfoElectricalReqdYesNoAdd.SelectedValue == "Yes";
                cmd.Parameters.Add("@Lien", SqlDbType.NVarChar).Value = tbLienAdd.Text;
                cmd.Parameters.Add("@tRVDSpace", SqlDbType.NVarChar).Value = tbRVSpaceInfoSpaceProtectedAdd.Text;
                cmd.Parameters.Add("@SpaceType", SqlDbType.NVarChar).Value = ddlSpaceTypeAdd.SelectedValue;
                cmd.Parameters.Add("@PermanantAssign", SqlDbType.Bit).Value = ddlPermanentAssignmentAdd.SelectedValue == "Yes";
                cmd.Parameters.Add("@LeasePaid", SqlDbType.Bit).Value = ddlPaymentThisYearAdd.SelectedValue == "Yes";
                cmd.Parameters.Add("@Notes", SqlDbType.NVarChar).Value = tbNotesAdd.Text;
                DateTime? waitListDate = Utils.ObjectToDateTimeNullable(tbWaitListDateAdd.Text);
                if (waitListDate.HasValue) {
                    cmd.Parameters.Add("@WaitListDate", SqlDbType.DateTime).Value = waitListDate;
                }
                DateTime? leaseStartDate = Utils.ObjectToDateTimeNullable(tbLeaseStartDateAdd.Text);
                if (leaseStartDate.HasValue) {
                    cmd.Parameters.Add("@LeaseStartDate", SqlDbType.DateTime).Value = leaseStartDate;
                }
                DateTime? leaseCancelDate = Utils.ObjectToDateTimeNullable(tbLeaseCancelledDateAdd.Text);
                if (leaseCancelDate.HasValue) {
                    cmd.Parameters.Add("@LeaseCancelDate", SqlDbType.DateTime).Value = leaseCancelDate;
                }

                cmd.Parameters.Add("@LeaseCancelled", SqlDbType.Bit).Value = ddlLeaseCancelledAdd.SelectedValue == "Yes";
                //    @WarningFlag1 nvarchar(18),
                //    @Credit$ real,
                //    @CreditPaid bit,
                //    @FinalRent real,
                cmd.Parameters.Add("@PropOwnerName", SqlDbType.NVarChar).Value = tbNonOwnerPropertyOwnerNameAdd.Text;
                cmd.Parameters.Add("@PropOwnerID", SqlDbType.NVarChar).Value = tbNonOwnerPropertyOwnerIdAdd.Text;



                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                clearAllNewFormInputFields();
                performPostNewSuccessfulActions("RV Storage added", DataSetCacheKey, null, tbRVLeaseIdSearch, (int)newscRVLeaseID.Value);

            } catch (Exception e2) {
                performPostNewFailedActions("RVStorage not added. Msg: " + e2.Message);
            }
        }
         /// <summary>
        /// The form hasn't been updated yet; so this is a place where inter-tab communication can take place.
        ///   -- PendingSpace has the Space from the Owner Info tab; so use that value on the RV & Space information tab.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void tcRVStorageAdd_ActiveTabChanged(object sender, EventArgs e) {
            mpeNewRVStorage.Show();
        }
        protected void btnShowAvailableSpacesAdd_OnClick(object sender, EventArgs args) {
            gvRVStorageAvailableSpaces_Add.DataSource = buildDataSet().Tables[3];
            gvRVStorageAvailableSpaces_Add.DataBind();
            mpeNewRVStorage.Show();
            mpeAvailableSpacesAdd.Show();
        }
        protected void gvRVStorageAvailableSpaces_SelectedIndexChanged_Add(object sender, EventArgs args) {
            GridViewRow row = gvRVStorageAvailableSpaces_Add.SelectedRow;
            Object obj = row.Cells;
            tbCurrentSpaceProtectedAdd.Text = row.Cells[1].Text;
            tbNonOwnerCurrentSpaceProtectedAdd.Text = row.Cells[1].Text;
            tbRVSpaceInfoSpaceProtectedAdd.Text = row.Cells[1].Text;
            tbRVSpaceLeaseInformationProtectedAdd.Text = row.Cells[1].Text;
            
            mpeAvailableSpacesAdd.Hide();
            mpeNewRVStorage.Show();
        }
        protected void doFindOwnerPropertyClickedAdd() {
            Session["byebye_add"] = null;
            Session["valueselectedbyfind_add"] = null;
            Timer2.Enabled = true;
            TimerTickerEnabled_Add = true;
            mpeNewRVStorage.Show();
        }
        protected void Button1X_Add_OnClick(object sender, EventArgs args) {
            doFindOwnerPropertyClickedAdd();
        }
        protected bool ImInTimerTick_Add {
            get {
                object obj = Session["ImInTimerTick_Add"];
                return obj == null ? false : (bool)obj;
            }
            set {
                Session["ImInTimerTick_Add"] = value;
            }
        }

        protected void Timer2_Tick(object sender, EventArgs e) {
            if (!ImInTimerTick_Add) {
                ImInTimerTick_Add = true;
                if (TimerTickerEnabled_Add) {
                    if (Session["valueselectedbyfind_add"] != null) {
                        Button1X_Add.Text = "Find Owner/Property";
                        Session["valueselectedbyfind_add"] = null;
                    }

                    /*
                     *  winhidden_add -> user closed the window with the red X, or Alt-F1 (4?)
                     *  Session["byebye"] is set when user clicks the Choose button
                    */
                    if (winhidden_add.Value == "y" || (Session["byebye_add"] != null && ((string)Session["byebye_add"]) == "yes")) {
                        Session["byebye_add"] = null;
                        TimerTickerEnabled_Add = false;
                        Button1X_Add.Text = "Find Owner/Property";
                        mpeNewRVStorage.Show();
                    }
                    /*           if (Session["HereCommaHaveAPropertyId"] != null) {
                                   if (!(Session["HereCommaHaveAPropertyID"]==(Session["PriorPropertIDRVStorage"]))) {
                                       if (!(tbPropertyIdOwnerInfo.Text.Equals((string)Session["HereCommaHaveAPropertyID"]))) {
                                           Session["PriorPropertIDRVStorage"] = Session["HereCommaHaveAPropertyID"];
                                           Session["HereCommaHaveAPropertyID"] = null;
                                           btnRVUpdateOkay_Click(null, null);
                                           timetoclosewindowhidden.Value = "y";
                                       }
                                   }
                               } */
                    if (Session["HereCommaHaveAClientID_Add"] != null) {

                        if (Session["PriorClientIDRVStorage_Add"] == null || !((Session["HereCommaHaveAClientID_Add"] == (Session["PriorClientIDRVStorage_Add"])))) {
                            if (!(tbRVOwnerFirstNameUpdate.Text.Equals((string)Session["HereCommaHaveAClientID_Add"]))) {

                                SqlCommand cmd = new SqlCommand("uspClientInfoGet");
                                cmd.Parameters.Add("ClientID", SqlDbType.NVarChar).Value = Session["HereCommaHaveAClientID_Add"];
                                cmd.CommandType = CommandType.StoredProcedure;
                                // Update as many fields as I can be sure of

                                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                                if (ds != null && ds.Tables != null && ds.Tables.Count > 0 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0) {
                                    DataRow dr = ds.Tables[0].Rows[0];
                                    tbRVOwnerFirstNameAdd.Text = Utils.ObjectToString(dr["PrimaryOwner"]);
                                    tbRVOwnerLastNameAdd.Text = "";
                                    tbOtherPhoneAdd.Text = "";
                                    tbEmailAdd.Text = "";
                                    tbDriversLicenseAdd.Text = "";
                                    tbNonOwnerSunriverPhoneAdd.Text = Utils.ObjectToString(dr["Addr1"]);
                                    tbAddr1OwnerInfoAdd.Text = Utils.ObjectToString(dr["Addr1"]);
                                    tbAddr2OwnerInfoAdd.Text = Utils.ObjectToString(dr["Addr2"]); ;
                                    tbSunriverPhoneAdd.Text = Utils.ObjectToString(dr["Phone"]); ;
                                    tbCityOwnerInfoAdd.Text = Utils.ObjectToString(dr["City"]); ;
                                    tbRegionOwnerInfoAdd.Text = Utils.ObjectToString(dr["Region"]); ;
                                    tbPostalCodeOwnerInfoAdd.Text = Utils.ObjectToString(dr["PostalCode"]); ;
                                    tbSunriverAddressOwnerInfoAdd.Text = Utils.ObjectToString(dr["SRAddress"]);
                                    tbNonOwnerPropertyOwnerIdAdd.Text = Utils.ObjectToString(Session["HereCommaHaveAClientID_Add"]);
                                    tbNonOwnerPropertyOwnerNameAdd.Text = Utils.ObjectToString(dr["PrimaryOwner"]);

                                    timetoclosewindowhidden_add.Value = "y";
                                }

                                Session["PriorClientIDRVStorage_Add"] = Session["HereCommaHaveAClientID_Add"];
                                zCustomerID = Utils.ObjectToString(Session["HereCommaHaveAClientID_Add"]);
                                Session["HereCommaHaveAClientID_Add"] = null;
                            }
                        }
                    }
                }
                ImInTimerTick_Add = false;
            }
        }
        private bool TimerTickerEnabled_Add {
            get {
                object obj = Session["TimerTickerEnableBB_Add"];
                return obj != null;
            }
            set {
                Session["TimerTickerEnableBB_Add"] = value;
                if (value) {
                    if (!Timer2.Enabled) {
                        Timer2.Enabled = true;
                    }
                } else {
                    if (Timer2.Enabled) {
                        Timer2.Enabled = false;
                    }
                }
            }
        }
        public static string MyMenuName = "RV Storage";
        protected override string childMenuName {
            get { return MyMenuName; }
        }
    }
}