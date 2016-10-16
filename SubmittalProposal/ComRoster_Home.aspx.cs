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

            lblCommitteeNameForUpdatePanel.Text = Utils.ObjectToString(dr["CommitteeName"]);
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
            } else {
            }
        }
        protected void cbUnlockRecordLists_CheckedChanged(object sender, EventArgs e) {
            if (cbUnlockRecordLists.Checked) {
            } else {
            }
        }
    }
}