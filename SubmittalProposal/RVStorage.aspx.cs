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
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            rvLeastIDBeingEdited = Convert.ToInt32(row.Cells[7].Text);

            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "RVLeaseID=" + rvLeastIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];

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
            DataTable dt = buildDataSet().Tables[3].Copy();
            DataRow drMySpace = dt.NewRow();
            drMySpace["tSISpace"]=dr["tRVDSpace"];
            DataRow drFind=dt.Rows.Find(dr["tRVDSpace"]);
            if (drFind != null) {
                dt.Rows.Remove(drFind);
            }
            dt.Rows.InsertAt(drMySpace,0);
            ddlAvailableSpacesUpdate.DataSource = dt;
            ddlAvailableSpacesUpdate.DataBind();
            ddlAvailableSpacesUpdate.SelectedIndex = 0;

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
            if (Utils.isNothingNot(ddlYesNo.SelectedValue)) {
                sb.Append(prepend + "Cancelled: " + ddlYesNo.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " LeaseCancelled = " + (ddlYesNo.SelectedValue=="Yes" ? "1":"0"));
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
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
                return;
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

                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
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
            tbRVOwnerFirstNameUpdate.Enabled = true;
            tbRVOwnerLastNameUpdate.Enabled = true;
            tbDriversLicenseUpdate.Enabled = true;
            tbEmailUpdate.Enabled = true;
            tbSunriverPhoneUpdate.Enabled = true;
            tbOtherPhoneUpdate.Enabled = true;
            tbStateUpdate.Enabled = true;
            ddlAvailableSpacesUpdate.Enabled = true;
        }

        protected override void lockYourUpdateFields() {
            tbRVOwnerFirstNameUpdate.Enabled = false;
            tbRVOwnerLastNameUpdate.Enabled = false;
            tbDriversLicenseUpdate.Enabled = false;
            tbEmailUpdate.Enabled = false;
            tbSunriverPhoneUpdate.Enabled = false;
            tbOtherPhoneUpdate.Enabled = false;
            tbStateUpdate.Enabled = false;
            ddlAvailableSpacesUpdate.Enabled = false;
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
            }
        }
    }
}