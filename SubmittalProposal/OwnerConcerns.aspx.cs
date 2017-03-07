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
    public partial class OwnerConcerns : AbstractDatabase, IHasPhotos {
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
        public string CurrentItemKey {
            get {
                return Utils.ObjectToString(CaseIdBeingEdited);
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
            tbOwnerConcernsConcernDescriptionUpdate.Text = Utils.ObjectToString(dr["Description"]);
            tbOwnerConcernsConcernResolutionUpdate.Text = Utils.ObjectToString(dr["Resolution"]);
            tbOwnerConcernsPublicWorksWONbr.Text = Utils.ObjectToString(dr["PubWksWO#"]);
            DateTime? notifiedDate=Utils.ObjectToDateTimeNullable(dr["NotifyDate"]);
            if (notifiedDate.HasValue) {
                tbOwnerConcernsNotifiedDateUpdate.Text = notifiedDate.Value.ToString("MM/dd/yyyy");
            } else {
                tbOwnerConcernsNotifiedDateUpdate.Text = "";
            }
            DateTime? resolutionDate = Utils.ObjectToDateTimeNullable(dr["ResolutionDate"]);
            if (resolutionDate.HasValue) {
                tbOwnerConcernsResolutionDateUpdate.Text = resolutionDate.Value.ToString("MM/dd/yyyy");
            } else {
                tbOwnerConcernsResolutionDateUpdate.Text = "";
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
            return lblOwnerConcernsNewMessage;
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
            tbOwnerConcernsResolutionDateUpdate.Enabled = true;
            ibOwnerConcernsNotifiedDateUpdate.Enabled = true;
            tbOwnerConcernsConcernDescriptionUpdate.Enabled = true;
            tbOwnerConcernsConcernResolutionUpdate.Enabled = true;
            tbOwnerConcernsPublicWorksWONbr.Enabled = true;
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
            tbOwnerConcernsResolutionDateUpdate.Enabled = false;
            ibOwnerConcernsNotifiedDateUpdate.Enabled = false;
            tbOwnerConcernsConcernDescriptionUpdate.Enabled = false;
            tbOwnerConcernsConcernResolutionUpdate.Enabled = false;
            tbOwnerConcernsPublicWorksWONbr.Enabled = false;
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
            tbOwnerConcernsFirstNameNew.Text = "";
            tbOwnerConcernsLastNameNew.Text = "";
            tbOwnerConcernsPhoneNbrNew.Text = "";
            tbOwnerConcernsEmailNew.Text = "";
            tbOwnerConcernsSunriverAddressNew.Text = "";
            tbOwnerConcernsCustPhoneNew.Text = "";
            tbOwnerConcernsOwnerIDNew.Text = "";
            tbOwnerConcernsMailAddr1New.Text = "";
            tbOwnerConcernsMailAddr2New.Text = "";
            tbOwnerConcernsMailCityNew.Text = "";
            tbOwnerConcernsMailStateNew.Text = "";
            tbOwnerConcernsMailPostalCodeNew.Text = "";
            ddlOwnerConcernsDeptReferred1New.SelectedIndex = -1;
            ddlOwnerConcernsDeptReferred2New.SelectedIndex = -1;
            ddlOwnerConcernsCategoryNew.SelectedIndex = -1;
            tbOwnerConcernsPublicWorksWONbrNew.Text = "";
            tbOwnerConcernsStartedByNew.Text = "";
            tbOwnerConcernsApprovedByNew.Text = "";
            tbOwnerConcernsNotifiedByNew.Text = "";
            tbOwnerConcernsNotifiedDateNew.Text = "";
            tbOwnerConcernsConcernDescriptionNew.Text = "";
            tbOwnerConcernsConcernResolutionNew.Text = "";
            tbOwnerConcernsClosedByNew.Text = "";
            tbOwnerConcernsResolutionDateNew.Text = "";
            getNewResultsLabel().Text = "";
            tbOwnerConcernsSubmitDateNew.Text = "";
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
            if (Common.Utils.isNothingNot(Session["CaseID"])) {
                clearAllSelectionInputFields();
                tbOwnerConcernsCaseNbrLU.Text=Utils.ObjectToString(Session["ShowCaseID"]);
                Session["ShowCaseID"] = null;
                ((Database)Master).doGo();
                gvResults.SelectRow(0);
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
            ddlOwnerConcernsDeptReferred1New.DataSource = department;
            ddlOwnerConcernsDeptReferred1New.DataBind();
            ddlOwnerConcernsDeptReferred2New.DataSource = department;
            ddlOwnerConcernsDeptReferred2New.DataBind();
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
            ddlOwnerConcernsCategoryNew.DataSource = category;
            ddlOwnerConcernsCategoryNew.DataBind();
        }
        protected void btnOwnerConcernsUpdateOkay_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspOwnerConcernsSet");
                cmd.Parameters.Add("@OCCase#",SqlDbType.Int).Value=CaseIdBeingEdited;
                DateTime? submitDate=Utils.ObjectToDateTimeNullable(tbOwnerConcernsSubmitDateUpdate.Text);
                if(submitDate.HasValue) {
                    cmd.Parameters.Add("@SubmitDate",SqlDbType.DateTime).Value=submitDate.Value;
                }
                cmd.Parameters.Add("@FirstName",SqlDbType.NVarChar).Value=tbOwnerConcernsFirstNameUpdate.Text;
                cmd.Parameters.Add("@LastName",SqlDbType.NVarChar).Value=tbOwnerConcernsLastNameUpdate.Text;
                string ownerID=tbOwnerConcernsOwnerIDUpdate.Text.Trim();
                if(Utils.isNothingNot(ownerID)) {
                    cmd.Parameters.Add("@OwnerID#",SqlDbType.NVarChar).Value=ownerID;
                }
                cmd.Parameters.Add("@OwnerPhone#",SqlDbType.NVarChar).Value=tbOwnerConcernsPhoneNbrUpdate.Text;
                cmd.Parameters.Add("@DeptReferred1",SqlDbType.NVarChar).Value=ddlOwnerConcernsDeptReferred1Update.SelectedValue;
                cmd.Parameters.Add("@DeptReferred2",SqlDbType.NVarChar).Value=ddlOwnerConcernsDeptReferred2Update.SelectedValue;
                cmd.Parameters.Add("@Category",SqlDbType.NVarChar).Value=ddlOwnerConcernsCategoryUpdate.SelectedValue;
                cmd.Parameters.Add("@Description",SqlDbType.NVarChar).Value=tbOwnerConcernsConcernDescriptionUpdate.Text;
                cmd.Parameters.Add("@Resolution",SqlDbType.NVarChar).Value=tbOwnerConcernsConcernResolutionUpdate.Text;
                cmd.Parameters.Add("@StartFormBy", SqlDbType.NVarChar).Value = tbOwnerConcernsStartedByUpdate.Text;
                DateTime? resolutionDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsResolutionDateUpdate.Text);
                if(resolutionDate.HasValue) {
                    cmd.Parameters.Add("@ResolutionDate",SqlDbType.DateTime).Value=resolutionDate;
                }
                cmd.Parameters.Add("@CloseFormBy",SqlDbType.NVarChar).Value=tbOwnerConcernsClosedByUpdate.Text;
                cmd.Parameters.Add("@ApprovedBy",SqlDbType.NVarChar).Value=tbOwnerConcernsApprovedByUpdate.Text;
                cmd.Parameters.Add("@NotifiedBy",SqlDbType.NVarChar).Value=tbOwnerConcernsNotifiedByUpdate.Text;
                DateTime? notifyDate=Utils.ObjectToDateTimeNullable(tbOwnerConcernsNotifiedDateUpdate.Text);
                if(notifyDate.HasValue) {
                    cmd.Parameters.Add("@NotifyDate",SqlDbType.DateTime).Value=notifyDate;
                }
                cmd.Parameters.Add("@SRAddress",SqlDbType.NVarChar).Value=tbOwnerConcernsSunriverAddress.Text;
                cmd.Parameters.Add("@EmailAddr",SqlDbType.NVarChar).Value=tbOwnerConcernsEmailUpdate.Text;
                int? pubWksWO = Utils.ObjectToIntNullable(tbOwnerConcernsPublicWorksWONbr.Text);
                if (pubWksWO.HasValue) {
                    cmd.Parameters.Add("@PubWksWO#", SqlDbType.Int).Value = pubWksWO.Value;
                }
                SqlParameter newOCCase=new SqlParameter("@NewOCCase#",SqlDbType.Int);
                newOCCase.Direction=ParameterDirection.Output;
                cmd.Parameters.Add(newOCCase);
                Utils.executeNonQuery(cmd, ConnectionString);
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
                        if (isAddNewMemberOpen) {
                            mpeNewOwnerConcerns.Show();
                        }
   ///                     Button1X.Text = "Find Owner/Property";
                    }

                    if (Session["HereCommaHaveAClientID"] != null) {
                        
                        if (Session["PriorClientIDRVStorage"] == null || !((Session["HereCommaHaveAClientID"] == (Session["PriorClientIDRVStorage"])))) {
                            if (!
                                    ((!isAddNewMemberOpen && tbOwnerConcernsOwnerIDUpdate.Text.Equals((string)Session["HereCommaHaveAClientID"]))
                                            ||
                                    (isAddNewMemberOpen && tbOwnerConcernsOwnerIDNew.Text.Equals((string)Session["HereCommaHaveAClientID"])))
                                            
                                ) {
                                    if (!isAddNewMemberOpen) {
                                        tbOwnerConcernsOwnerIDUpdate.Text = Common.Utils.ObjectToString(Session["HereCommaHaveAClientID"]);
                                    } else {
                                        tbOwnerConcernsOwnerIDNew.Text = Common.Utils.ObjectToString(Session["HereCommaHaveAClientID"]);
                                    }

                                SqlCommand cmd = new SqlCommand("uspClientInfoGet");
                                cmd.Parameters.Add("ClientID", SqlDbType.NVarChar).Value = Session["HereCommaHaveAClientID"];
                                cmd.CommandType = CommandType.StoredProcedure;
                                // Update as many fields as I can be sure of

                                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                                if (ds != null && ds.Tables != null && ds.Tables.Count > 0 && ds.Tables[0].Rows != null && ds.Tables[0].Rows.Count > 0) {
                                    DataRow dr = ds.Tables[0].Rows[0];

                                    if (!isAddNewMemberOpen) {
                                        tbOwnerConcernsSunriverAddress.Text = Utils.ObjectToString(dr["SRAddress"]);
                                        tbOwnerConcernsCustPhone.Text = Utils.ObjectToString(dr["Phone"]);
                                        tbOwnerConcernsMailAddr1.Text = Utils.ObjectToString(dr["Addr1"]);
                                        tbOwnerConcernsMailAddr2.Text = Utils.ObjectToString(dr["Addr2"]);
                                        tbOwnerConcernsMailCity.Text = Utils.ObjectToString(dr["City"]);
                                        tbOwnerConcernsMailState.Text = Utils.ObjectToString(dr["Region"]);
                                        tbOwnerConcernsMailPostalCode.Text = Utils.ObjectToString(dr["PostalCode"]);
                                    } else {
                                        tbOwnerConcernsSunriverAddressNew.Text = Utils.ObjectToString(dr["SRAddress"]);
                                        tbOwnerConcernsCustPhoneNew.Text = Utils.ObjectToString(dr["Phone"]);
                                        tbOwnerConcernsMailAddr1New.Text = Utils.ObjectToString(dr["Addr1"]);
                                        tbOwnerConcernsMailAddr2New.Text = Utils.ObjectToString(dr["Addr2"]);
                                        tbOwnerConcernsMailCityNew.Text = Utils.ObjectToString(dr["City"]);
                                        tbOwnerConcernsMailStateNew.Text = Utils.ObjectToString(dr["Region"]);
                                        tbOwnerConcernsMailPostalCodeNew.Text = Utils.ObjectToString(dr["PostalCode"]);
                                    }
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
                if (!isAddNewMemberOpen) {
                    if (value) {
                        if (!Timer1.Enabled) {
                            Timer1.Enabled = true;
                        }
                    } else {
                        if (Timer1.Enabled) {
                            Timer1.Enabled = false;
                        }
                    }
                } else {
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
        }
        #endregion
        private void doFindOwnerPropertyClickedUpdate() {
            Session["byebye"] = null;
            Session["valueselectedbyfind"] = null;
            TimerTickerEnabled = true;
            Timer1.Enabled = true;
        }
        private void doFindOwnerPropertyClickedNew() {
            Session["byebye"] = null;
            Session["valueselectedbyfind"] = null;
            TimerTickerEnabled = true;
            Timer2.Enabled = true;
            mpeNewOwnerConcerns.Show();
        }
        protected void btnNonOwnerLookupSunriverPropertyOwnerInformation_onclick(object sender, EventArgs args) {
            doFindOwnerPropertyClickedUpdate();
        }
        protected void btnNonOwnerLookupSunriverPropertyOwnerInformationNew_onclick(object sender, EventArgs args) {
            doFindOwnerPropertyClickedNew();
            mpeNewOwnerConcerns.Show();
        }
        protected void btnPrintForm_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspOwnerConcernsDateFormPrintedUpdate");
            cmd.Parameters.Add("@OCCase#", SqlDbType.Int).Value = CaseIdBeingEdited;
            Utils.executeNonQuery(cmd, ConnectionString);
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            lblDatePrinted.Text = DateTime.Now.ToString();
        }
        protected void btnNewOwnerConcernsOk_Click(object sender, EventArgs args) {
            if (Page.IsValid) {
                try {
                    SqlCommand cmd = new SqlCommand("uspOwnerConcernsSet");
                    DateTime? submitDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsSubmitDateNew.Text);
                    if (submitDate.HasValue) {
                        cmd.Parameters.Add("@SubmitDate", SqlDbType.DateTime).Value = submitDate.Value;
                    }
                    cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = tbOwnerConcernsFirstNameNew.Text;
                    cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = tbOwnerConcernsLastNameNew.Text;
                    string ownerID = tbOwnerConcernsOwnerIDNew.Text.Trim();
                    if (Utils.isNothingNot(ownerID)) {
                        cmd.Parameters.Add("@OwnerID#", SqlDbType.NVarChar).Value = ownerID;
                    }
                    cmd.Parameters.Add("@OwnerPhone#", SqlDbType.NVarChar).Value = tbOwnerConcernsPhoneNbrNew.Text;
                    cmd.Parameters.Add("@DeptReferred1", SqlDbType.NVarChar).Value = ddlOwnerConcernsDeptReferred1New.SelectedValue;
                    cmd.Parameters.Add("@DeptReferred2", SqlDbType.NVarChar).Value = ddlOwnerConcernsDeptReferred2New.SelectedValue;
                    cmd.Parameters.Add("@Category", SqlDbType.NVarChar).Value = ddlOwnerConcernsCategoryNew.SelectedValue;
                    cmd.Parameters.Add("@Description", SqlDbType.NVarChar).Value = tbOwnerConcernsConcernDescriptionNew.Text;
                    cmd.Parameters.Add("@Resolution", SqlDbType.NVarChar).Value = tbOwnerConcernsConcernResolutionNew.Text;
                    cmd.Parameters.Add("@StartFormBy", SqlDbType.NVarChar).Value = tbOwnerConcernsStartedByNew.Text;
                    DateTime? resolutionDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsResolutionDateNew.Text);
                    if (resolutionDate.HasValue) {
                        cmd.Parameters.Add("@ResolutionDate", SqlDbType.DateTime).Value = resolutionDate;
                    }
                    cmd.Parameters.Add("@CloseFormBy", SqlDbType.NVarChar).Value = tbOwnerConcernsClosedByNew.Text;
                    cmd.Parameters.Add("@ApprovedBy", SqlDbType.NVarChar).Value = tbOwnerConcernsApprovedByNew.Text;
                    cmd.Parameters.Add("@NotifiedBy", SqlDbType.NVarChar).Value = tbOwnerConcernsNotifiedByNew.Text;
                    DateTime? notifyDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsNotifiedDateNew.Text);
                    if (notifyDate.HasValue) {
                        cmd.Parameters.Add("@NotifyDate", SqlDbType.DateTime).Value = notifyDate;
                    }
                    cmd.Parameters.Add("@SRAddress", SqlDbType.NVarChar).Value = tbOwnerConcernsSunriverAddressNew.Text;
                    cmd.Parameters.Add("@EmailAddr", SqlDbType.NVarChar).Value = tbOwnerConcernsEmailNew.Text;
                    int? pubWksWO = Utils.ObjectToIntNullable(tbOwnerConcernsPublicWorksWONbrNew.Text);
                    if (pubWksWO.HasValue) {
                        cmd.Parameters.Add("@PubWksWO#", SqlDbType.Int).Value = pubWksWO.Value;
                    }
                    SqlParameter newOCCase = new SqlParameter("@NewOCCase#", SqlDbType.Int);
                    newOCCase.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newOCCase);
                    Utils.executeNonQuery(cmd, ConnectionString);
                    performPostNewSuccessfulActions("Update successful", DataSetCacheKey, null, tbOwnerConcernsCaseNbrLU,newOCCase.Value.ToString());
                } catch (Exception ee) {
                    performPostNewFailedActions("Update failed. Msg: " + ee.Message);
                    isAddNewMemberOpen = true;
                    mpeNewOwnerConcerns.Show();
                    return;
                }
                isAddNewMemberOpen = false;
                mpeNewOwnerConcerns.Hide();
            } else {
                isAddNewMemberOpen = true;
                mpeNewOwnerConcerns.Show();
            }
        }
        protected void btnNewOwnerConcernsCancel_Click(object sender, EventArgs args) {
            isAddNewMemberOpen = false;
            mpeNewOwnerConcerns.Hide();
        }
        protected void lbNewOwnerConcerns_OnClick(object sender, EventArgs args) {
            isAddNewMemberOpen = true;
            mpeNewOwnerConcerns.Show();
        }
        private bool isAddNewMemberOpen {
            get {
                object obj = Session["isAddNewMemberOpen"];
                return obj == null ? false : (bool)obj;
            }
            set {
                Session["isAddNewMemberOpen"] = value;
            }
        }
    }
}