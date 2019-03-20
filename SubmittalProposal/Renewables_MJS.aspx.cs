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
    public partial class Renewables_MJS : AbstractDatabase {
        public static string MyMenuName = "Renewables";

        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["RenewablesSQLConnectionString"].ConnectionString;
            }
        }
        public static string DataSetCacheKey = "RENEWABLESDATASETCACHEKEY";
        public static DataSet getRenewablesDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = DataSetCacheKey;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspRenewablesTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        /// <summary>
        /// Updates the fields in the Form Panel
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// <returns>A string that will display for the user the record being updated on the Form Panel bar</returns>
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            try {
                // .Net gives us the selected row
                GridViewRow row = GridView1.SelectedRow;
                // In GridView1, we defined DataKeyNames="renewID". Thanks to this, we can ascertain the renewID of the selected row.
                RenewablesIDBeingEdited = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                // Grab the table of all the Renewables data...
                DataTable sourceTable = getGridViewDataTable();
                // and create a DataView so that we can filter ...
                DataView view = new DataView(sourceTable);
                view.RowFilter = "renewID=" + RenewablesIDBeingEdited;
                DataTable tblFiltered = view.ToTable();
                // (remember the filtered table (for later))
                Session["RenewablesTblFiltered"] = tblFiltered;
                // and lastly, isolate the DataRow that represents our item.
                DataRow dr = tblFiltered.Rows[0];
                // Now we simply format the appropriate Text fields.
                
                tbRenewablesBusinessNameUpdate.Text = Utils.ObjectToString(dr["Business"]);
                tbRenewablesProjectNameUpdate.Text = Utils.ObjectToString(dr["ProjectName"]);
                tbRenewablesBusinessAddressUpdate.Text = Utils.ObjectToString(dr["BusinessAddress"]);
                tbRenewablesBusinessPhoneUpdate.Text = Utils.ObjectToString(dr["BusinessPhone"]);
                tbRenewablesBusinessContactNameUpdate.Text = Utils.ObjectToString(dr["BusinessContactName"]);
                tbRenewableDateEndUpdate.Text=Utils.formatForTextBoxWithDate(dr["RenewableEndDate"]);
                tbRenewableDateReviewUpdate.Text = Utils.formatForTextBoxWithDate(dr["RenewableReviewDate"]);
                tbRenewableDateStartUpdate.Text = Utils.formatForTextBoxWithDate(dr["RenewableStartDate"]);
                tbRenewableDateTermUpdate.Text = Utils.formatForTextBoxWithDate(dr["RenewableTermDate"]);
                tbNotesUpdate.Text = Utils.ObjectToString(dr["Notes"]);
                tbPaymentTypeUpdate.Text = Utils.ObjectToString(dr["PaymentType"]);
                string ddlTypeUpdateSelectedValue=Utils.ObjectToString(Utils.returnTheValueOfFieldXInTableWhoseFieldYEqualsZ("ID",
                    getRenewablesDataSet().Tables[1],"DocName",Utils.ObjectToString(dr["RenewableType"])));
                if (Utils.isNothing(ddlTypeUpdateSelectedValue)) {
                    ddlTypeUpdate.SelectedIndex = 0;
                } else {
                    ddlTypeUpdate.SelectedValue = ddlTypeUpdateSelectedValue;
                }
                ddlDepartmentUpdate.SelectedValue = Utils.ObjectToString(dr["SROADepartment"]);
                string ddlTermUpdateSelectedValue = Utils.ObjectToString(Utils.returnTheValueOfFieldXInTableWhoseFieldYEqualsZ("ID",
                    getRenewablesDataSet().Tables[3], "TermOfRenewable", Utils.ObjectToString(dr["TermOfRenewable"])));
                if (Utils.isNothing(ddlTermUpdateSelectedValue)) {
                    ddlTermUpdate.SelectedIndex = 0;
                } else {
                    ddlTermUpdate.SelectedValue = ddlTypeUpdateSelectedValue;
                }
                ddlAutoRenewalUpdate.SelectedValue = Utils.isNothing(dr["AutoRenewal"])?"": Utils.ObjectToBool(dr["AutoRenewal"]) ? "Yes" : "No";
                tbCostUpdate.Text = Utils.ObjectToString(dr["TermCost"]);
                // The framework expects some identifying verbiage to show the user what record is being viewed.
                return "Business Name: " + Utils.ObjectToString(dr["Business"]) + "  Project Name: " + Utils.ObjectToString(dr["ProjectName"]) + "     renewID: " + RenewablesIDBeingEdited;
            } catch (Exception exc) {
/* this didn't work, so throw an exception, and I modified AbstractDatabase.cs to display a message.
 *              string mf = "alert('Problems fetching the data from RenewID: " + RenewablesIDBeingEdited + ". The data on the screen is probably incorrect.  Msg: " + exc.Message.Replace("'","") + "');";
                ScriptManager.RegisterClientScriptBlock(ddlDepartmentUpdate, ddlDepartmentUpdate.GetType(), "myScriptName", mf, true);
*/
                throw exc;

            }
        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";

            if (Utils.isNothingNot(tbProjectName.Text)) {
                sb.Append(prepend + "Project name: " + tbProjectName.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbProjectName.Text, "ProjectName"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbBusinessName.Text)) {
                sb.Append(prepend + "Business name: " + tbBusinessName.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbBusinessName.Text, "Business"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbRenewableID.Text)) {
                sb.Append(prepend + "RenewID: " + tbRenewableID.Text);
                prepend = "  ";
                sbFilter.Append(and + "RenewID="+tbRenewableID.Text);
                and = " and ";
            }
            if(ddlDepartmentContactSearch.SelectedIndex>0) {
                sb.Append(prepend + "Contact: " + ddlDepartmentContactSearch.SelectedValue);
                prepend=" ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(ddlDepartmentContactSearch.SelectedValue,"EmailContactName1","EmailContactName2"));
            }
            
            if (ddlDepartmentSearch.SelectedIndex > 0) {
                sb.Append(prepend + "Department: " + ddlDepartmentSearch.SelectedValue);
                prepend = " ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(ddlDepartmentSearch.SelectedValue, "Department"));
            }

            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }

        protected override GridView getGridViewResults() {
            return GridView1;
        }

        protected override System.Data.DataSet buildDataSet() {
            throw new NotImplementedException();
        }

        protected override System.Data.DataTable getGridViewDataTable() {
            return getRenewablesDataSet().Tables[2];
        }

        protected override Label getUpdateResultsLabel() {
            return lblRenewablesResults;
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            tbRenewablesProjectNameUpdate.Enabled = true;
            tbRenewablesBusinessNameUpdate.Enabled = true;
            tbRenewablesBusinessAddressUpdate.Enabled = true;
            tbRenewablesBusinessPhoneUpdate.Enabled = true;
            tbRenewablesBusinessContactNameUpdate.Enabled = true;
            tbRenewableDateEndUpdate.Enabled = true;
            tbRenewableDateReviewUpdate.Enabled = true;
            tbRenewableDateStartUpdate.Enabled = true;
            tbRenewableDateTermUpdate.Enabled = true;
            ddlDepartmentUpdate.Enabled = true;
            tbNotesUpdate.Enabled = true;
            ddlTypeUpdate.Enabled = true;
            ddlDepartmentUpdate.Enabled = true;
            btnRenewablesUpdate.Enabled = true;
            btnNewRenewable.Enabled = true;
            ddlTermUpdate.Enabled = true;
            ddlAutoRenewalUpdate.Enabled = true;
        }

        protected override void lockYourUpdateFields() {
            tbRenewablesProjectNameUpdate.Enabled = false;
            tbRenewablesBusinessNameUpdate.Enabled = false;
            tbRenewablesBusinessAddressUpdate.Enabled = false;
            tbRenewablesBusinessPhoneUpdate.Enabled = false;
            tbRenewablesBusinessContactNameUpdate.Enabled = false;
            tbRenewableDateEndUpdate.Enabled = false;
            tbRenewableDateReviewUpdate.Enabled = false;
            tbRenewableDateStartUpdate.Enabled = false;
            tbRenewableDateTermUpdate.Enabled = false;
            ddlDepartmentUpdate.Enabled = false;
            tbNotesUpdate.Enabled = false;
            ddlTypeUpdate.Enabled = false;
            ddlDepartmentUpdate.Enabled = false;
            btnNewRenewable.Enabled = false;
            ddlTermUpdate.Enabled = false;
            ddlAutoRenewalUpdate.Enabled = false;
            btnRenewablesUpdate.Enabled = false;

        }

        protected override void clearAllSelectionInputFields() {
            tbBusinessName.Text = "";
            tbProjectName.Text = "";
            tbRenewableID.Text = "";
            ddlDepartmentSearch.SelectedIndex = 0;
            ddlDepartmentContactSearch.SelectedIndex = 0;
        }

        protected override void clearAllNewFormInputFields() {
            tbRenewablesBusinessNameNew.Text = "";
            tbRenewablesProjectNameNew.Text = "";
        }

        protected override string childMenuName {
            get { return MyMenuName; }
        }

        protected override string UpdateRoleName {
            get { return "canupdaterenewables"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }


        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                // Do stuff that you need to do only once when the page is accessed.
                // For example:  Initialize static dropdown's.
                DataTable dt1 = getRenewablesDataSet().Tables[0].Copy();
                DataRow dr1 = dt1.NewRow();
                dr1["Department"] = "";
                dr1["EmailContactName1"] = "";
                dt1.Rows.InsertAt(dr1, 0);
                ddlDepartmentSearch.DataSource = dt1;
                ddlDepartmentSearch.DataBind();
                ddlDepartmentUpdate.DataSource = dt1;
                ddlDepartmentUpdate.DataBind();

                DataSet ds = Common.Utils.getDataSetFromQuery("SELECT DISTINCT EmailContactName1 FROM OwnerConcerns.dbo.[tblDepartment{LU}] WHERE EmailContactName1 IS NOT NULL order by EmailContactName1 ", ConnectionString);
                DataTable dt2 = ds.Tables[0];
                DataRow dr2 = dt2.NewRow();
                dr2["EmailContactName1"] = "";
                dt2.Rows.InsertAt(dr2, 0);
                ddlDepartmentContactSearch.DataSource = dt2;
                ddlDepartmentContactSearch.DataBind();


                DataTable dtType = getRenewablesDataSet().Tables[1].Copy();
                DataRow drType = dtType.NewRow();
                drType["ID"] = -1;
                drType["DocName"] = "";
                dtType.Rows.InsertAt(drType, 0);
                ddlTypeUpdate.DataSource = dtType;
                ddlTypeUpdate.DataBind();

                DataTable dtTerm = getRenewablesDataSet().Tables[3].Copy();
                DataRow drTerm = dtTerm.NewRow();
                drTerm["ID"] = -1;
                drTerm["TermOfRenewable"] = "";
                dtTerm.Rows.InsertAt(drTerm, 0);
                ddlTermUpdate.DataSource = dtTerm;
                ddlTermUpdate.DataBind();
            } else {
                // Here is where you do things that you need to do when
                // a "postback" occurs.  What's a "postback"?  It's whenF
                // the user has clicked a button, or does something else
                // that causes the system to post back to the server.
            }
            // Do anything here that needs to be done every time the client 
            // accesses this page.
        }

        protected void btnRenewablesUpdateSubmit_Click(object sender, EventArgs args) {
            try {
                if (Page.IsValid) {

//Your update code here
                    SqlCommand cmd = new SqlCommand("uspRenewablesUpdate");
                    cmd.Parameters.Add("@renewID", SqlDbType.Int).Value = RenewablesIDBeingEdited;
                    cmd.Parameters.Add("@BusinessName", SqlDbType.NVarChar).Value = tbRenewablesBusinessNameUpdate.Text;
                    cmd.Parameters.Add("@ProjectName", SqlDbType.NVarChar).Value = tbRenewablesProjectNameUpdate.Text; 
                    cmd.Parameters.Add("@BusinessAddress", SqlDbType.NVarChar).Value = tbRenewablesBusinessAddressUpdate.Text;
                    cmd.Parameters.Add("@BusinessPhone", SqlDbType.NVarChar).Value = tbRenewablesBusinessPhoneUpdate.Text;
                    cmd.Parameters.Add("@BusinessContactName", SqlDbType.NVarChar).Value = tbRenewablesBusinessContactNameUpdate.Text;
                    cmd.Parameters.Add("@TermofRenewable", SqlDbType.NVarChar).Value = ddlTermUpdate.SelectedItem.ToString();
                    cmd.Parameters.Add("@RenewableType", SqlDbType.NVarChar).Value = ddlTypeUpdate.SelectedItem.ToString();
                    cmd.Parameters.Add("@SROADepartment", SqlDbType.NVarChar).Value = ddlDepartmentUpdate.SelectedItem.ToString();
                    cmd.Parameters.Add("@Notes", SqlDbType.NVarChar).Value = tbNotesUpdate.Text;
                    cmd.Parameters.Add("@PaymentType", SqlDbType.NVarChar).Value = tbPaymentTypeUpdate.Text;
                    bool? bnAutoRenewUpdate = null;
                    if (Utils.isNothingNot(ddlAutoRenewalUpdate.SelectedValue)) {
                        bnAutoRenewUpdate = Utils.ObjectToBool(ddlAutoRenewalUpdate.SelectedValue);
                        cmd.Parameters.Add("@AutoRenewal", SqlDbType.Bit).Value = bnAutoRenewUpdate.Value;
                    }
                    DateTime? aDate = Utils.ObjectToDateTimeNullable(tbRenewableDateReviewUpdate.Text);
                    if (aDate.HasValue) {
                        cmd.Parameters.Add("@RenewableReviewDate", SqlDbType.DateTime).Value = aDate;
                    }
                    aDate = Utils.ObjectToDateTimeNullable(tbRenewableDateStartUpdate.Text);
                    if (aDate.HasValue) {
                        cmd.Parameters.Add("@RenewableStartDate", SqlDbType.DateTime).Value = aDate;
                    }
                    aDate = Utils.ObjectToDateTimeNullable(tbRenewableDateEndUpdate.Text);
                    if (aDate.HasValue) {
                        cmd.Parameters.Add("@RenewableEndDate", SqlDbType.DateTime).Value = aDate;
                    }
                    aDate = Utils.ObjectToDateTimeNullable(tbRenewableDateTermUpdate.Text);
                    if (aDate.HasValue) {
                        cmd.Parameters.Add("@RenewableTermDate", SqlDbType.DateTime).Value = aDate;
                    }
                    cmd.Parameters.Add("@TermCost", SqlDbType.NVarChar).Value = tbCostUpdate.Text;

                    SqlParameter renewIDOut = new SqlParameter("@renewIDOut", SqlDbType.Int);
                    renewIDOut.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(renewIDOut);
                    Utils.executeNonQuery(cmd, ConnectionString);
                    //End Your update code

                    performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
                }
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }
        private int RenewablesIDBeingEdited {
            get {
                object obj = Session["RenewablesIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["RenewablesIDBeingEdited"] = value;
            }
        }
        protected void btnNewRenewable_OnClick(object sender, EventArgs args) {
            mpeNewRenewable.Show();
        }
        protected void btnNewRenewablesCancel_Click(object sender, EventArgs args) {
            mpeNewRenewable.Hide();
            clearAllNewFormInputFields();
        }

        protected void btnNewRenewablesOk_Click(object sender, EventArgs args) {
            try {
                // Run stored procedure uspRenewablesUpdate.
                SqlCommand cmd = new SqlCommand("uspRenewablesUpdate");
                cmd.Parameters.Add("@BusinessName", SqlDbType.NVarChar, 50).Value = tbRenewablesBusinessNameNew.Text;
                cmd.Parameters.Add("@ProjectName", SqlDbType.NVarChar, 100).Value = tbRenewablesProjectNameNew.Text;
                    // add an "out" parameter which will return the new renewid;
                SqlParameter newRenewID = new SqlParameter("@renewIDOut", SqlDbType.Int);
                newRenewID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newRenewID);
                Utils.executeNonQuery(cmd, ConnectionString);

                /*
                 * The framework needs the cache key(s) here, as well as the search textbox for the RenewableID, and the id (RenewID) of the new Renewable.
                */
                performPostNewSuccessfulActions("Update successful", DataSetCacheKey, null, tbRenewableID, newRenewID.Value);
            } catch (Exception ee) {
                    performPostNewFailedActions("Update failed. Msg: " + ee.Message);
                    mpeNewRenewable.Show();
                    return;
            }
            mpeNewRenewable.Hide();
        }

    }
}