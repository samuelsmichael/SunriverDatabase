using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Common;

namespace SubmittalProposal {
    public partial class ComRoster_Members : AbstractDatabase {
        private static string DataSetCacheKey = "COMROSTERDATASETCACHEKEY";
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["ComRosterSQLConnectionString"].ConnectionString;
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            MemberIDBeingEdited = Convert.ToInt32(row.Cells[9].Text);
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "MemberID=" + MemberIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            Session["MembersTblFiltered"] = tblFiltered;
            DataRow dr = tblFiltered.Rows[0];
            tbComRosterMembersFirstNameUpdate.Text = Utils.ObjectToString(dr["FirstName"]);
            tbComRosterMembersLastNameUpdate.Text = Utils.ObjectToString(dr["LastName"]);
            tbComRosterMembersSRMailAddr1Update.Text=Utils.ObjectToString(dr["SRMailAddr1"]);
            tbComRosterMembersSRMailAddr2Update.Text = Utils.ObjectToString(dr["SRMailAddr2"]);
            tbComRosterMembersSRPhoneUpdate.Text = Utils.ObjectToString(dr["SRPhone"]);
            tbComRosterMembersFAXUpdate.Text = Utils.ObjectToString(dr["SRFax"]);
            tbComRosterMembersEmailUpdate.Text = Utils.ObjectToString(dr["Email"]);
            tbComRosterMembersNRMailAddrUpdate.Text=Utils.ObjectToString(dr["NRMailAddr"]);
            tbComRosterMembersNRPhoneUpdate.Text=Utils.ObjectToString(dr["NRPhone"]);
            tbComRosterMembersCommentsUpdate.Text=Utils.ObjectToString(dr["Comments"]);

            return "Last name: " + Utils.ObjectToString(dr["LastName"]) + "nbsp;nbsp;nbsp;First name: " + Utils.ObjectToString(dr["FirstName"]) + "     MemberID: " + MemberIDBeingEdited;
        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbComRosterMembersNameLU.Text)) {
                sb.Append(prepend + "Name: " + tbComRosterMembersNameLU.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbComRosterMembersNameLU.Text, "FullName"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlComRosterMembersCommitteeLU.SelectedValue) && ddlComRosterMembersCommitteeLU.SelectedValue!="0") {
                sb.Append(prepend + "Committee: " + ddlComRosterMembersCommitteeLU.SelectedItem);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery("|"+ddlComRosterMembersCommitteeLU.SelectedValue+"|", "Committees"));
                and = " and ";
            }
            if (Utils.isNothingNot( tbComRosterMemberIDLU.Text)) {
                sb.Append(prepend + "MemberId: " + tbComRosterMemberIDLU.Text);
                prepend = "  ";
                sbFilter.Append(and + " MemberID = '" + tbComRosterMemberIDLU.Text + "'");
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();

        }

        protected override GridView getGridViewResults() {
            return gvResults;
        }

        protected override System.Data.DataSet buildDataSet() {
            return ComRoster_Home.ComRosterDataSet();
        }

        protected override System.Data.DataTable getGridViewDataTable() {
            return buildDataSet().Tables[1];
        }

        protected override Label getUpdateResultsLabel() {
            return lblComRosterMemberUpdateResults;
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            tbComRosterMembersCommentsUpdate.Enabled = false;
            tbComRosterMembersEmailUpdate.Enabled = false;
            tbComRosterMembersFAXUpdate.Enabled = false;
            tbComRosterMembersFirstNameUpdate.Enabled = false;
            tbComRosterMembersLastNameUpdate.Enabled = false;
            tbComRosterMembersNRMailAddrUpdate.Enabled = false;
            tbComRosterMembersNRPhoneUpdate.Enabled = false;
            tbComRosterMembersSRMailAddr1Update.Enabled = false;
            tbComRosterMembersSRMailAddr2Update.Enabled = false;
            tbComRosterMembersSRPhoneUpdate.Enabled = false;
            btnComRosterMemberUpdate.Visible = false;
        }

        protected override void lockYourUpdateFields() {
            tbComRosterMembersCommentsUpdate.Enabled = true;
            tbComRosterMembersEmailUpdate.Enabled = true;
            tbComRosterMembersFAXUpdate.Enabled = true;
            tbComRosterMembersFirstNameUpdate.Enabled = true;
            tbComRosterMembersLastNameUpdate.Enabled = true;
            tbComRosterMembersNRMailAddrUpdate.Enabled = true;
            tbComRosterMembersNRPhoneUpdate.Enabled = true;
            tbComRosterMembersSRMailAddr1Update.Enabled = true;
            tbComRosterMembersSRMailAddr2Update.Enabled = true;
            tbComRosterMembersSRPhoneUpdate.Enabled = true;
            btnComRosterMemberUpdate.Visible = true;
        }

        protected override void clearAllSelectionInputFields() {
            tbComRosterMemberIDLU.Text = "";
            tbComRosterMembersNameLU.Text = "";
            ddlComRosterMembersCommitteeLU.SelectedIndex = 0;
        }

        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }

        protected override string UpdateRoleName {
            get { return "canupdatecommembers"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                bindCommitteeDropDown();
            }
        }
        public static string MyMenuName = "Com Members";
        protected override string childMenuName {
            get { return MyMenuName; }
        }
        public void bindCommitteeDropDown() {
            DataTable committee = ComRoster_Home.ComRosterDataSet().Tables[0].Copy();
            DataRow row = committee.NewRow();
            row["CommitteeID"]=0;
            row["CommitteeName"] = "";
            committee.Rows.InsertAt(row, 0);
            ddlComRosterMembersCommitteeLU.DataSource = committee;
            ddlComRosterMembersCommitteeLU.DataBind();
        }
        private int MemberIDBeingEdited {
            get {
                object obj = Session["ComRosterMembersMemberIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["ComRosterMembersMemberIDBeingEdited"] = value;
            }
        }

        protected void btnComRosterMemberUpdateOkay_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspComRosterMemberSet");
                cmd.Parameters.Add("@MemberID", SqlDbType.Int).Value = MemberIDBeingEdited;
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
                Utils.executeNonQuery(cmd, ConnectionString);
                performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }

    }
}