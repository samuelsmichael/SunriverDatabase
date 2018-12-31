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
                // The framework expects some identifying verbiage to show the user what record is being viewed.
                return "Business Name: " + Utils.ObjectToString(dr["Business"]) + "nbsp;nbsp;nbsp;Project Name: " + Utils.ObjectToString(dr["ProjectName"]) + "     renewID: " + RenewablesIDBeingEdited;
            } catch {
                return "";
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
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbProjectName.Text, "Project"));
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
        }

        protected override void lockYourUpdateFields() {
            tbRenewablesProjectNameUpdate.Enabled = false;
            tbRenewablesBusinessNameUpdate.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            tbBusinessName.Text = "";
            tbProjectName.Text = "";
            tbRenewableID.Text = "";
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
            } else {
                // Here is where you do things that you need to do when
                // a "postback" occurs.  What's a "postback"?  It's when
                // the user has clicked a button, or does something else
                // that causes the system to post back to the server.
            }
            // Do anything here that needs to be done every time the client 
            // accesses this page.
        }

        protected void btnRenewablesUpdateOkay_Click(object sender, EventArgs args) {
            try {
                if (Page.IsValid) {

//Your update code here
                    SqlCommand cmd = new SqlCommand("uspRenewablesUpdate");
                    cmd.Parameters.Add("@renewID", SqlDbType.Int).Value = RenewablesIDBeingEdited;
                    cmd.Parameters.Add("@BusinessName", SqlDbType.NVarChar).Value = tbRenewablesBusinessNameUpdate.Text;
                    cmd.Parameters.Add("@ProjectName", SqlDbType.NVarChar).Value = tbRenewablesProjectNameUpdate.Text;
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
        protected void lbNewRenewable_OnClick(object sender, EventArgs args) {
            mpeNewRenewable.Show();
        }
        protected void btnNewRenewablesCancel_Click(object sender, EventArgs args) {
            mpeNewRenewable.Hide();
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