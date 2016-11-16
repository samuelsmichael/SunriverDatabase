using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Common;
using System.Runtime.Caching;
using System.Text;

namespace SubmittalProposal {
    public partial class OwnerConcerns : AbstractDatabase {
        private static string DataSetCacheKey = "OWNERCONCERSDATASETCACHEKEY";
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["OwnerConcernsSQLConnectionString"].ConnectionString;
            }
        }
        public static DataSet OwnerConcernsDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            ds = (DataSet)cache[DataSetCacheKey];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspOwnerConcernsTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["OCCase#"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(DataSetCacheKey, ds, policy);
            }
            return ds;
        }
        private int CaseIdBeingEdited {
            get {
                object obj = Session["ComOwnerConcernsCaseIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["ComOwnerConcernsCaseIDBeingEdited"] = value;
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            CaseIdBeingEdited = Convert.ToInt32(row.Cells[8].Text);
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "[OCCase#]=" + CaseIdBeingEdited;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            tbOwnerConcernsFirstNameUpdate.Text = Utils.ObjectToString(dr["FirstName"]);
            tbOwnerConcernsLastNameUpdate.Text = Utils.ObjectToString(dr["LastName"]);
            tbOwnerConcernsOwnerIDUpdate.Text = Utils.ObjectToString(dr["OwnerID#"]);
            tbOwnerConcernsPhoneNbrUpdate.Text = Utils.ObjectToString(dr["OwnerPhone#"]);
            tbOwnerConcernsEmailUpdate.Text=Utils.ObjectToString(dr["EmailAddr"]);
            tbOwnerConcernsSunriverAddress.Text=Utils.ObjectToString(dr["SRLotLane"]);
            tbOwnerConcernsCustPhone.Text = Utils.ObjectToString(dr["CustPhone"]);
            tbOwnerConcernsMailAddr1.Text=Utils.ObjectToString(dr["MailAddr1"]);
            tbOwnerConcernsMailAddr2.Text = Utils.ObjectToString(dr["MailAddr2"]);
            tbOwnerConcernsMailCity.Text=Utils.ObjectToString(dr["MailCity"]);
            tbOwnerConcernsMailState.Text = Utils.ObjectToString(dr["MailState"]);
            tbOwnerConcernsMailPostalCode.Text = Utils.ObjectToString(dr["MailZip"]);
            string referred1 = Utils.ObjectToString(dr["DeptReferred1"]);
            ddlOwnerConcernsDeptReferred1Update.SelectedValue=referred1;
            string referred2 = Utils.ObjectToString(dr["DeptReferred2"]);
            ddlOwnerConcernsDeptReferred2Update.SelectedValue=referred2;
            string category = Utils.ObjectToString(dr["Category"]);
            ddlOwnerConcernsCategoryUpdate.SelectedValue = category;
            tbOwnerConcernsStartedByUpdate.Text = Utils.ObjectToString(dr["StartFormBy"]);
            DateTime? submitDate = Utils.ObjectToDateTimeNullable(dr["SubmitDate"]);
            if (submitDate.HasValue) {
                tbOwnerConcernsSubmitDateUpdate.Text = submitDate.Value.ToString("MM/dd/yyyy");
            } else {
                tbOwnerConcernsSubmitDateUpdate.Text = "";
            }
            tbOwnerConcernsClosedByUpdate.Text = Utils.ObjectToString(dr["CloseFormBy"]);
            tbOwnerConcernsApprovedByUpdate.Text = Utils.ObjectToString(dr["ApprovedBy"]);
            tbOwnerConcernsNotifiedByUpdate.Text = Utils.ObjectToString(dr["NotifiedBy"]);
            DateTime? notifiedDate=Utils.ObjectToDateTimeNullable(dr["NotifyDate"]);
            if (notifiedDate.HasValue) {
                tbOwnerConcernsNotifiedDateUpdate.Text = notifiedDate.Value.ToString("MM/dd/yyyy");
            } else {
                tbOwnerConcernsNotifiedDateUpdate.Text = "";
            }
            object dateFormPrinted = Utils.ObjectToString(dr["DateFormPrinted"]);
            if (Utils.isNothingNot(dateFormPrinted)) {
                lblDatePrinted.Text = dateFormPrinted.ToString();
            }

            return "Name: " + Utils.ObjectToString(dr["FullName"]) + "     Case#: " + CaseIdBeingEdited;

        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbOwnerConcernsNameLU.Text)) {
                sb.Append(prepend + "Name: " + tbOwnerConcernsNameLU.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbOwnerConcernsNameLU.Text, "FullName"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbOwnerConcernsSunriverAddressLU.Text)) {
                sb.Append(prepend + "Name: " + tbOwnerConcernsSunriverAddressLU.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbOwnerConcernsSunriverAddressLU.Text, "SRLotLane"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlOwnerConcernsDepartmentReferredLU.SelectedValue) && ddlOwnerConcernsDepartmentReferredLU.SelectedIndex != 0) {
                sb.Append(prepend + "Department Referred: " + ddlOwnerConcernsDepartmentReferredLU.SelectedItem);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(ddlOwnerConcernsDepartmentReferredLU.SelectedValue, "DeptReferred1"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlOwnerConcernsResolvedLU.SelectedValue) && ddlOwnerConcernsResolvedLU.SelectedIndex != 0) {
                sb.Append(prepend + "Resolved: " + ddlOwnerConcernsResolvedLU.SelectedValue);
                prepend = "  ";
                if (ddlOwnerConcernsResolvedLU.SelectedValue.ToLower() == "yes") {
                    sbFilter.Append(and + " ResolutionDate is not null");
                } else {
                    sbFilter.Append(and + " ResolutionDate is null");
                }
                and = " and ";
            }
            if (Utils.isNothingNot(ddlOwnerConcernsCategoryLU.SelectedValue) && ddlOwnerConcernsCategoryLU.SelectedIndex != 0) {
                sb.Append(prepend + "Category: " + ddlOwnerConcernsCategoryLU.SelectedItem);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(ddlOwnerConcernsCategoryLU.SelectedValue, "Category"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbOwnerConcernsCaseNbrLU.Text)) {
                sb.Append(prepend + "Case #: " + tbOwnerConcernsCaseNbrLU.Text);
                prepend = "  ";
                sbFilter.Append(and + " [OCCase#] = '" + tbOwnerConcernsCaseNbrLU.Text + "'");
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();

        }

        protected override GridView getGridViewResults() {
            return gvResults;
        }

        protected override System.Data.DataSet buildDataSet() {
            return OwnerConcernsDataSet();
        }

        protected override System.Data.DataTable getGridViewDataTable() {
            return buildDataSet().Tables[0];
        }

        protected override Label getUpdateResultsLabel() {
            return lblOwnerConcernsUpdateResults;
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            tbOwnerConcernsFirstNameUpdate.Enabled = true;
            tbOwnerConcernsLastNameUpdate.Enabled = true;
            tbOwnerConcernsOwnerIDUpdate.Enabled = true;
            btnNonOwnerLookupSunriverPropertyOwnerInformation.Enabled = true;
            btnOwnerConcernsUpdate.Visible = true;
            tbOwnerConcernsPhoneNbrUpdate.Enabled = true;
            tbOwnerConcernsEmailUpdate.Enabled = true;
            ddlOwnerConcernsDeptReferred1Update.Enabled = true;
            ddlOwnerConcernsDeptReferred2Update.Enabled = true;
            ddlOwnerConcernsCategoryUpdate.Enabled = true;
            tbOwnerConcernsStartedByUpdate.Enabled = true;
            tbOwnerConcernsSubmitDateUpdate.Enabled = true;
            tbOwnerConcernsClosedByUpdate.Enabled = true;
            tbOwnerConcernsApprovedByUpdate.Enabled = true;
            tbOwnerConcernsNotifiedByUpdate.Enabled = true;
            tbOwnerConcernsNotifiedDateUpdate.Enabled = true;
            ibOwnerConcernsNotifiedDateUpdate.Enabled = true;
            ibOwnerConcernsSubmitDateUpdate.Enabled = true;
            tbOwnerConcernsConcernDescriptionUpdate.Enabled = true;
            tbOwnerConcernsConcernResolutionUpdate.Enabled = true;
        }

        protected override void lockYourUpdateFields() {
            tbOwnerConcernsFirstNameUpdate.Enabled = false;
            tbOwnerConcernsLastNameUpdate.Enabled = false;
            tbOwnerConcernsOwnerIDUpdate.Enabled = false;
            btnNonOwnerLookupSunriverPropertyOwnerInformation.Enabled = false;
            btnOwnerConcernsUpdate.Visible = false;

            tbOwnerConcernsPhoneNbrUpdate.Enabled = false;
            tbOwnerConcernsEmailUpdate.Enabled = false;
            tbOwnerConcernsSunriverAddress.Enabled = false;
            tbOwnerConcernsCustPhone.Enabled = false;
            tbOwnerConcernsMailAddr1.Enabled = false;
            tbOwnerConcernsMailAddr2.Enabled = false;
            tbOwnerConcernsMailCity.Enabled = false;
            tbOwnerConcernsMailPostalCode.Enabled = false;
            tbOwnerConcernsMailState.Enabled = false;
            ddlOwnerConcernsDeptReferred1Update.Enabled = false;
            ddlOwnerConcernsDeptReferred2Update.Enabled = false;
            ddlOwnerConcernsCategoryUpdate.Enabled = false;
            tbOwnerConcernsStartedByUpdate.Enabled = false;
            tbOwnerConcernsSubmitDateUpdate.Enabled = false;
            tbOwnerConcernsClosedByUpdate.Enabled = false;
            tbOwnerConcernsApprovedByUpdate.Enabled = false;
            tbOwnerConcernsNotifiedByUpdate.Enabled = false;
            tbOwnerConcernsNotifiedDateUpdate.Enabled = false;
            ibOwnerConcernsNotifiedDateUpdate.Enabled = false;
            ibOwnerConcernsSubmitDateUpdate.Enabled = false;
            tbOwnerConcernsConcernDescriptionUpdate.Enabled = false;
            tbOwnerConcernsConcernResolutionUpdate.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            tbOwnerConcernsNameLU.Text = "";
            ddlOwnerConcernsDepartmentReferredLU.SelectedIndex = -1;
            ddlOwnerConcernsCategoryLU.SelectedIndex = -1;
            tbOwnerConcernsCaseNbrLU.Text = "";
            tbOwnerConcernsSunriverAddressLU.Text = "";
            ddlOwnerConcernsResolvedLU.SelectedIndex = -1;
        }

        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }
        public static string MyMenuName = "Owner Concerns";
        protected override string childMenuName {
            get { return MyMenuName; }
        }

        protected override string UpdateRoleName {
            get { return "canupdateownerconcerns"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                bindDepartmentReferredToDropdown();
                bindCategoryDropdown();
            }
        }
        private void bindDepartmentReferredToDropdown() {
            DataTable department = OwnerConcernsDataSet().Tables[2].Copy();
            DataRow row = department.NewRow();
            row["Department"] = "";
            row["DeptSelector"] = "";
            department.Rows.InsertAt(row, 0);
            ddlOwnerConcernsDepartmentReferredLU.DataSource = department;
            ddlOwnerConcernsDepartmentReferredLU.DataBind();
            ddlOwnerConcernsDeptReferred1Update.DataSource = department;
            ddlOwnerConcernsDeptReferred1Update.DataBind();
            ddlOwnerConcernsDeptReferred2Update.DataSource = department;
            ddlOwnerConcernsDeptReferred2Update.DataBind();
        }
        private void bindCategoryDropdown() {
            DataTable category = OwnerConcernsDataSet().Tables[1].Copy();
            DataRow row = category.NewRow();
            row["Category"] = "";
            category.Rows.InsertAt(row, 0);
            ddlOwnerConcernsCategoryLU.DataSource = category;
            ddlOwnerConcernsCategoryLU.DataBind();
            ddlOwnerConcernsCategoryUpdate.DataSource = category;
            ddlOwnerConcernsCategoryUpdate.DataBind();
        }
        protected void btnOwnerConcernsUpdateOkay_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspComRosterMemberSet");
/*                cmd.Parameters.Add("@MemberID", SqlDbType.Int).Value = MemberIDBeingEdited;
                cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = tbComRosterMembersFirstNameUpdate.Text;
                cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = tbComRosterMembersLastNameUpdate.Text;
                cmd.Parameters.Add("@SRMailAddr1", SqlDbType.NVarChar).Value = tbComRosterMembersSRMailAddr1Update.Text;
                cmd.Parameters.Add("@SRMailAddr2", SqlDbType.NVarChar).Value = tbComRosterMembersSRMailAddr2Update.Text;
                cmd.Parameters.Add("@SRPhone", SqlDbType.NVarChar).Value = tbComRosterMembersSRPhoneUpdate.Text;
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = tbComRosterMembersEmailUpdate.Text;
                cmd.Parameters.Add("@SRFax", SqlDbType.NVarChar).Value = tbComRosterMembersFAXUpdate.Text;
                cmd.Parameters.Add("@NRMailAddr", SqlDbType.NVarChar).Value = tbComRosterMembersNRMailAddrUpdate.Text;
                cmd.Parameters.Add("@NRPhone", SqlDbType.NVarChar).Value = tbComRosterMembersNRPhoneUpdate.Text;
                cmd.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = tbComRosterMembersCommentsUpdate.Text;
                SqlParameter newMemberID = new SqlParameter("@NewMemberID", SqlDbType.Int);
                newMemberID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newMemberID);
                Utils.executeNonQuery(cmd, ConnectionString);*/
                performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }
        #region Stuff for managing the popup of the Find Owner
        protected bool ImInTimerTick {
            get {
                object obj = Session["ImInTimerTicks"];
                return obj == null ? false : (bool)obj;
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
///                        Button1X.Text = "Find Owner/Property";
                        Session["valueselectedbyfind"] = null;
                    }

                    /*
                     *  winhidden -> user closed the window with the red X, or Alt-F1 (4?)
                     *  Session["byebye"] is set when user clicks the Choose button
                    */
                    if (winhidden.Value == "y" || (Session["byebye"] != null && ((string)Session["byebye"]) == "yes")) {
                        Session["byebye"] = null;
                        TimerTickerEnabled = false;
   ///                     Button1X.Text = "Find Owner/Property";
                    }

                    if (Session["HereCommaHaveAClientID"] != null) {
                        
                        if (Session["PriorClientIDRVStorage"] == null || !((Session["HereCommaHaveAClientID"] == (Session["PriorClientIDRVStorage"])))) {
                            if (!(tbOwnerConcernsOwnerIDUpdate.Text.Equals((string)Session["HereCommaHaveAClientID"]))) {
                                tbOwnerConcernsOwnerIDUpdate.Text = Common.Utils.ObjectToString(Session["HereCommaHaveAClientID"]);

                                SqlCommand cmd = new SqlCommand("uspClientInfoGet");
                                cmd.Parameters.Add("ClientID", SqlDbType.NVarChar).Value = Session["HereCommaHaveAClientID"];
                                cmd.CommandType = CommandType.StoredProcedure;
                                // Update as many fields as I can be sure of

                                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                                if (ds != null && ds.Tables != null && ds.Tables.Count > 0 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0) {
                                    DataRow dr = ds.Tables[0].Rows[0];

                                    tbOwnerConcernsSunriverAddress.Text = Utils.ObjectToString(dr["SRAddress"]);
                                    tbOwnerConcernsCustPhone.Text = Utils.ObjectToString(dr["Phone"]);
                                    tbOwnerConcernsMailAddr1.Text = Utils.ObjectToString(dr["Addr1"]);
                                    tbOwnerConcernsMailAddr2.Text = Utils.ObjectToString(dr["Addr2"]);
                                    tbOwnerConcernsMailCity.Text = Utils.ObjectToString(dr["City"]);
                                    tbOwnerConcernsMailState.Text = Utils.ObjectToString(dr["Region"]);
                                    tbOwnerConcernsMailPostalCode.Text = Utils.ObjectToString(dr["PostalCode"]);
                                }

                                Session["PriorClientIDRVStorage"] = Session["HereCommaHaveAClientID"];
                                Session["HereCommaHaveAClientID"] = null;



                            }
                            timetoclosewindowhidden.Value = "y";

                        }
                    }
                }
                ImInTimerTick = false;
            }
        }

        private bool TimerTickerEnabled {
            get {
                object obj = Session["TimerTickerEnableBB"];
                return obj != null;
            }
            set {
                Session["TimerTickerEnableBB"] = value;
                if (value) {
                    if (!Timer1.Enabled) {
                        Timer1.Enabled = true;
                    }
                } else {
                    if (Timer1.Enabled) {
                        Timer1.Enabled = false;
                    }
                }
            }
        }
        #endregion
        private void doFindOwnerPropertyClickedUpdate() {
            Session["byebye"] = null;
            Session["valueselectedbyfind"] = null;
            TimerTickerEnabled = true;
            Timer1.Enabled = true;
        }
        protected void btnNonOwnerLookupSunriverPropertyOwnerInformation_onclick(object sender, EventArgs args) {
            doFindOwnerPropertyClickedUpdate();
        }
        protected void btnPrintForm_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspOwnerConcernsDateFormPrintedUpdate");
            cmd.Parameters.Add("@OCCase#", SqlDbType.Int).Value = CaseIdBeingEdited;
            Utils.executeNonQuery(cmd, ConnectionString);
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            lblDatePrinted.Text = DateTime.Now.ToString();
        }
    }
}