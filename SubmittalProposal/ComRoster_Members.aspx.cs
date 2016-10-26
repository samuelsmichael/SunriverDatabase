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
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            throw new NotImplementedException();
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
                sbFilter.Append(and + Common.Utils.getDataViewQuery(ddlComRosterMembersCommitteeLU.SelectedValue, "Committees"));
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
            throw new NotImplementedException();
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            throw new NotImplementedException();
        }

        protected override void lockYourUpdateFields() {
            throw new NotImplementedException();
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
    }
}