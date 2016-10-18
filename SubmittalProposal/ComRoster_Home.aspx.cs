using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using Common;

namespace SubmittalProposal {
    public partial class ComRoster_Home : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                bindCommitteeGrid();
                string zUpdateRoleName = "canupdatecomroster";
                if (HttpContext.Current.User.IsInRole(zUpdateRoleName)) {
                    enableUnlockRecordCheckbox(true);
                } else {
                    enableUnlockRecordCheckbox(false);
                }
            }
        }
        private void bindCommitteeGrid() {
            dgCommittees.DataSource = ComRosterDataSet().Tables[0];
            dgCommittees.DataBind();
        }
        private static string DataSetCacheKey = "COMROSTERDATASETCACHEKEY";
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["ComRosterSQLConnectionString"].ConnectionString;
            }
        }
        public static DataSet ComRosterDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            ds = (DataSet)cache[DataSetCacheKey];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspComRosterTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["CommitteeID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["MemberID"] };
                ds.Tables[2].PrimaryKey = new DataColumn[] { ds.Tables[2].Columns["RosterMemberID"] };
                ds.Tables[3].PrimaryKey = new DataColumn[] { ds.Tables[3].Columns["LiaisonID"] };
                ds.Tables[4].PrimaryKey = new DataColumn[] { ds.Tables[4].Columns["RosterLiaisonID"] };
                ds.Tables[5].PrimaryKey = new DataColumn[] { ds.Tables[5].Columns["RosterMemberID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(DataSetCacheKey, ds, policy);
            }
            return ds;
        }

        protected void dgCommittees_SelectedIndexChanged(object sender, EventArgs e) {
            CPECommittees.Collapsed = true;
            CPECommittees.ClientState = "true";
            CPECommitteeUpdate.Collapsed = false;
            CPECommitteeUpdate.ClientState = "false";
            GridViewRow row = dgCommittees.SelectedRow;
            CommitteeIDBeingEdited = Convert.ToInt32(row.Cells[4].Text);
            DataTable sourceTable = ComRosterDataSet().Tables[0];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "CommitteeID=" + CommitteeIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            Session["ComRosterTblFiltered"] = tblFiltered;
            DataRow dr = tblFiltered.Rows[0];
            tbCommitteeNameUpdate.Text = Utils.ObjectToString(dr["CommitteeName"]);
            DateTime? charterDate = Utils.ObjectToDateTimeNullable(dr["CharterDate"]);
            if (charterDate.HasValue) {
                tbCharterDateUpdate.Text = charterDate.Value.ToString("d");
            } else {
                tbCharterDateUpdate.Text = "";
            }
            try {
                ddlCommitteeStatusUpdate.SelectedValue = Utils.ObjectToString(dr["Status"]);
            } catch {
                ddlCommitteeStatusUpdate.SelectedValue = "Active";
            }
            tbCommitteeNbrOfMembersUpdate.Text = Utils.ObjectToString(dr["#OfMembers"]);
            tbCommitteeNbrOfMembersNotesUpdate.Text = Utils.ObjectToString(dr["#OfMembersNote"]);
            tbCommitteeTermYearsUpdate.Text = Utils.ObjectToString(dr["Term"]);
            tbCommitteeNbrOfTermsLimitUpdate.Text = Utils.ObjectToString(dr["TermLimit"]);
            tbCommitteeTermNotesUpdate.Text= Utils.ObjectToString(dr["TermLimitNote"]);
            cbCommitteeAlternateMembersAllowed.Checked = Utils.ObjectToBool(dr["AlternateMembers"]);
            cbCommitteeAssociateMembersAllowed.Checked = Utils.ObjectToBool(dr["AssociateMembers"]);

            lblCommitteeNameForUpdatePanel.Text = Utils.ObjectToString(dr["CommitteeName"] + ", ID: " + CommitteeIDBeingEdited);
        }
        private int CommitteeIDBeingEdited {
            get {
                object obj = Session["CommitteeIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["CommitteeIDBeingEdited"] = value;
            }
        }
        protected void cvCommitteeNbrOfMembersUpdate_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            try {
                int nbrOfMembers = Convert.ToInt32(args.Value);
            } catch {
                args.IsValid = false;
            }
        }
        private void setUnlockRecordCheckboxVisibility(bool isVisible) {
            if (isVisible) {
                cbUnlockRecordCommittee.Visible = true;
                cbUnlockRecordLists.Visible = true;
            } else {
                cbUnlockRecordCommittee.Visible = false;
                cbUnlockRecordLists.Visible = false;
            }
        }
        private void enableUnlockRecordCheckbox(bool enable) {
            cbUnlockRecordCommittee.Enabled = enable;
            cbUnlockRecordLists.Enabled = enable;
        }

        protected void cbUnlockRecordCommittee_CheckedChanged(object sender, EventArgs e) {
            if (cbUnlockRecordCommittee.Checked) {
                lockCommitteeFields(true);
            } else {
                lockCommitteeFields(false);
            }
        }
        protected void cbUnlockRecordLists_CheckedChanged(object sender, EventArgs e) {
            if (cbUnlockRecordLists.Checked) {
            } else {
            }
        }
        private void lockCommitteeFields(bool enable) {
            tbCommitteeNameUpdate.Enabled = enable;
            tbCharterDateUpdate.Enabled = enable;
            ibCharterDateUpdate.Enabled = enable;
            cvCharterDateUpdate.Enabled = enable;
            rvcvCharterDateUpdate.Enabled = enable;
            ddlCommitteeStatusUpdate.Enabled = enable;
            tbCommitteeNbrOfMembersUpdate.Enabled = enable;
            cvCommitteeNbrOfMembersUpdate.Enabled = enable;
            tbCommitteeNbrOfMembersNotesUpdate.Enabled = enable;
            tbCommitteeTermNotesUpdate.Enabled = enable;
            tbCommitteeTermYearsUpdate.Enabled = enable;
            cvCommitteeTermYearsUpdate.Enabled = enable;
            tbCommitteeNbrOfTermsLimitUpdate.Enabled = enable;
            cvCommitteeNbrOfTermsLimitUpdate.Enabled = enable;
            cbCommitteeAlternateMembersAllowed.Enabled = enable;
            cbCommitteeAssociateMembersAllowed.Enabled = enable;
        }
    }
}