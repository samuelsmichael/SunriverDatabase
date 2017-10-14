using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;

namespace SubmittalProposal {
    public partial class ComRoster_Liaisons : AbstractDatabase {
        public static string DataSetCacheKey = "COMROSTERDATASETCACHEKEY";
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["ComRosterSQLConnectionString"].ConnectionString;
            }
        }
        private int LiaisonIDBeingEdited {
            get {
                object obj = Session["ComRosterLiaisonsLiaisonIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["ComRosterLiaisonsLiaisonIDBeingEdited"] = value;
            }
        }

        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            LiaisonIDBeingEdited = Utils.ObjectToInt(gvResults.DataKeys[row.RowIndex].Value);
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "LiaisonID=" + LiaisonIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            Session["LiaisonsTblFiltered"] = tblFiltered;
            DataRow dr = tblFiltered.Rows[0];

            tbComRosterLiaisonNameUpdate.Text = Utils.ObjectToString(dr["LiaisonName"]);
            dllComRosterLiaisonLiaisonTypeUpdate.SelectedValue = Utils.ObjectToString(dr["LiaisonType"]);
            tbComRosterLiaisonsSRMailAddr1Update.Text = Utils.ObjectToString(dr["LiaisonSRMail1"]);
            tbComRosterLiaisonsSRMailAddr2Update.Text = Utils.ObjectToString(dr["LiaisonSRMail2"]);
            tbComRosterLiaisonsEmailUpdate.Text = Utils.ObjectToString(dr["LiaisonEmail"]);
            tbComRosterLiaisonsSRPhoneUpdate.Text = Utils.ObjectToString(dr["LiaisonSRPhone"]);
            tbComRosterLiaisonsRepresentsUpdate.Text = Utils.ObjectToString(dr["LiaisonRepresents"]);
            tbComRosterLiaisonsNRMailAddrUpdate.Text = Utils.ObjectToString(dr["LiaisonNRMail"]);
            tbComRosterLiaisonsNRPhoneUpdate.Text = Utils.ObjectToString(dr["LiaisonNRPhone"]);

            return "Name: " + Utils.ObjectToString(dr["LiaisonName"]) + "&nbsp;&nbsp;&nbsp;Type: " + Utils.ObjectToString(dr["LiaisonType"]) + "     LiaisonID: " + LiaisonIDBeingEdited;

        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbComRosterLiaisonsNameLU.Text)) {
                sb.Append(prepend + "Name: " + tbComRosterLiaisonsNameLU.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbComRosterLiaisonsNameLU.Text, "LiaisonName"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlComRosterLiaisonTypeLU.SelectedValue) && ddlComRosterLiaisonTypeLU.SelectedValue != "") {
                sb.Append(prepend + "Liaison Type: " + ddlComRosterLiaisonTypeLU.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(ddlComRosterLiaisonTypeLU.SelectedValue, "LiaisonType"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlComRosterLiaisonsCommitteeLU.SelectedValue) && ddlComRosterLiaisonsCommitteeLU.SelectedValue != "0") {
                sb.Append(prepend + "Committee: " + ddlComRosterLiaisonsCommitteeLU.SelectedItem);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery("|" + ddlComRosterLiaisonsCommitteeLU.SelectedValue + "|", "Committees"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbComRosterLiaisonIDLU.Text)) {
                sb.Append(prepend + "LiaisonId: " + tbComRosterLiaisonIDLU.Text);
                prepend = "  ";
                sbFilter.Append(and + " LiaisonID = '" + tbComRosterLiaisonIDLU.Text + "'");
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
            return buildDataSet().Tables[3];
        }

        protected override Label getUpdateResultsLabel() {
            return lblComRosterLiaisonUpdateResults;
        }

        protected override Label getNewResultsLabel() {
            return lblComRosterLiaisonNewMessage;
        }

        protected override void unlockYourUpdateFields() {
            tbComRosterLiaisonNameUpdate.Enabled = true;
            dllComRosterLiaisonLiaisonTypeUpdate.Enabled = true;
            tbComRosterLiaisonsSRMailAddr1Update.Enabled = true;
            tbComRosterLiaisonsSRMailAddr2Update.Enabled = true;
            tbComRosterLiaisonsEmailUpdate.Enabled = true;
            tbComRosterLiaisonsSRPhoneUpdate.Enabled = true;
            tbComRosterLiaisonsRepresentsUpdate.Enabled = true;
            tbComRosterLiaisonsNRMailAddrUpdate.Enabled = true;
            tbComRosterLiaisonsNRPhoneUpdate.Enabled = true;
            btnComRosterLiaisonUpdate.Visible = true;
        }

        protected override void lockYourUpdateFields() {            
            tbComRosterLiaisonNameUpdate.Enabled=false;
            dllComRosterLiaisonLiaisonTypeUpdate.Enabled=false;
            tbComRosterLiaisonsSRMailAddr1Update.Enabled=false;
            tbComRosterLiaisonsSRMailAddr2Update.Enabled=false;
            tbComRosterLiaisonsEmailUpdate.Enabled=false;
            tbComRosterLiaisonsSRPhoneUpdate.Enabled=false;
            tbComRosterLiaisonsRepresentsUpdate.Enabled=false;
            tbComRosterLiaisonsNRMailAddrUpdate.Enabled=false;
            tbComRosterLiaisonsNRPhoneUpdate.Enabled=false;
            btnComRosterLiaisonUpdate.Visible = false;
        }

        protected override void clearAllSelectionInputFields() {
            tbComRosterLiaisonIDLU.Text = "";
            tbComRosterLiaisonsNameLU.Text = "";
            ddlComRosterLiaisonTypeLU.SelectedIndex=0;
            ddlComRosterLiaisonsCommitteeLU.SelectedIndex = 0;
        }

        protected override void clearAllNewFormInputFields() {
            tbComRosterLiaisonNameNew.Text="";
            dllComRosterLiaisonLiaisonTypeNew.SelectedIndex = 0;
            tbComRosterLiaisonsSRMailAddr1New.Text="";
            tbComRosterLiaisonsSRMailAddr2New.Text="";
            tbComRosterLiaisonsEmailNew.Text="";
            tbComRosterLiaisonsSRPhoneNew.Text="";
            tbComRosterLiaisonsRepresentsNew.Text="";
            tbComRosterLiaisonsNRMailAddrNew.Text="";
            tbComRosterLiaisonsNRPhoneNew.Text="";
        }

        public static string MyMenuName = "Com Liasons";

        protected override string childMenuName {
            get { return MyMenuName; }
        }

        protected override string UpdateRoleName {
            get { return "canupdatecomliaisons"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                bindCommitteeDropDown();
                bindLiaisonType();
            }
        }
        private void bindCommitteeDropDown() {
            DataTable committee = ComRoster_Home.ComRosterDataSet().Tables[0].Copy();
            DataRow row = committee.NewRow();
            row["CommitteeID"] = 0;
            row["CommitteeName"] = "";
            committee.Rows.InsertAt(row, 0);
            ddlComRosterLiaisonsCommitteeLU.DataSource = committee;
            ddlComRosterLiaisonsCommitteeLU.DataBind();
        }
        private void bindLiaisonType() {
            DataTable liaisonType = ComRoster_Home.ComRosterDataSet().Tables[8].Copy();
            DataRow row = liaisonType.NewRow();
            row["LiaisonType"] = "";
            liaisonType.Rows.InsertAt(row, 0);
            ddlComRosterLiaisonTypeLU.DataSource = liaisonType;
            ddlComRosterLiaisonTypeLU.DataBind();
            dllComRosterLiaisonLiaisonTypeUpdate.DataSource = liaisonType;
            dllComRosterLiaisonLiaisonTypeUpdate.DataBind();
            dllComRosterLiaisonLiaisonTypeNew.DataSource = liaisonType;
            dllComRosterLiaisonLiaisonTypeNew.DataBind();
        }
        protected void btnComRosterLiaisonUpdateOkay_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspComRosterLiaisonSet");
                cmd.Parameters.Add("@LiaisonID", SqlDbType.Int).Value = LiaisonIDBeingEdited;
                cmd.Parameters.Add("@LiaisonName", SqlDbType.NVarChar).Value = tbComRosterLiaisonNameUpdate.Text;
                cmd.Parameters.Add("@LiaisonType", SqlDbType.NVarChar).Value = dllComRosterLiaisonLiaisonTypeUpdate.SelectedValue;
                cmd.Parameters.Add("@LiaisonSRMail1", SqlDbType.NVarChar).Value = tbComRosterLiaisonsSRMailAddr1Update.Text;
                cmd.Parameters.Add("@LiaisonSRMail2", SqlDbType.NVarChar).Value = tbComRosterLiaisonsSRMailAddr2Update.Text;
                cmd.Parameters.Add("@LiaisonEmail", SqlDbType.NVarChar).Value = tbComRosterLiaisonsEmailUpdate.Text;
                cmd.Parameters.Add("@LiaisonSRPhone", SqlDbType.NVarChar).Value = tbComRosterLiaisonsSRPhoneUpdate.Text;
                cmd.Parameters.Add("@LiaisonRepresents", SqlDbType.NVarChar).Value = tbComRosterLiaisonsRepresentsUpdate.Text;
                cmd.Parameters.Add("@LiaisonNRMail", SqlDbType.NVarChar).Value = tbComRosterLiaisonsNRMailAddrUpdate.Text;
                cmd.Parameters.Add("@LiaisonNRPhone", SqlDbType.NVarChar).Value = tbComRosterLiaisonsNRPhoneUpdate.Text;
                cmd.Parameters.Add("@HonorLiaisonIDRestrictions", SqlDbType.Bit).Value = true;
                SqlParameter newLiaisonID = new SqlParameter("@NewLiaisonID", SqlDbType.Int);
                newLiaisonID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newLiaisonID);
                Utils.executeNonQuery(cmd, ConnectionString);
                performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }
        protected void lbNewComRosterLiaison_OnClick(object sender, EventArgs args) {
            isAddNewLiaisonOpen = true;
            mpeNewComRosterLiaison.Show();
        }
        private bool isAddNewLiaisonOpen {
            get {
                object obj = Session["isAddNewLiaisonOpen"];
                return obj == null ? false : (bool)obj;
            }
            set {
                Session["isAddNewLiaisonOpen"] = value;
            }
        }
        protected void btnNewComRosterLiaisonCancel_Click(object sender, EventArgs args) {
            isAddNewLiaisonOpen = false;
            mpeNewComRosterLiaison.Hide();
        }
        protected void btnNewComRosterLiaisonOk_Click(object sender, EventArgs args) {
            if (Page.IsValid) {
                try {
                    SqlCommand cmd = new SqlCommand("uspComRosterLiaisonSet");
                    cmd.Parameters.Add("@LiaisonName", SqlDbType.NVarChar).Value = tbComRosterLiaisonNameNew.Text;
                    cmd.Parameters.Add("@LiaisonType", SqlDbType.NVarChar).Value = dllComRosterLiaisonLiaisonTypeNew.SelectedValue;
                    cmd.Parameters.Add("@LiaisonSRMail1", SqlDbType.NVarChar).Value = tbComRosterLiaisonsSRMailAddr1New.Text;
                    cmd.Parameters.Add("@LiaisonSRMail2", SqlDbType.NVarChar).Value = tbComRosterLiaisonsSRMailAddr2New.Text;
                    cmd.Parameters.Add("@LiaisonEmail", SqlDbType.NVarChar).Value = tbComRosterLiaisonsEmailNew.Text;
                    cmd.Parameters.Add("@LiaisonSRPhone", SqlDbType.NVarChar).Value = tbComRosterLiaisonsSRPhoneNew.Text;
                    cmd.Parameters.Add("@LiaisonRepresents", SqlDbType.NVarChar).Value = tbComRosterLiaisonsRepresentsNew.Text;
                    cmd.Parameters.Add("@LiaisonNRMail", SqlDbType.NVarChar).Value = tbComRosterLiaisonsNRMailAddrNew.Text;
                    cmd.Parameters.Add("@LiaisonNRPhone", SqlDbType.NVarChar).Value = tbComRosterLiaisonsNRPhoneNew.Text;
                    cmd.Parameters.Add("@HonorLiaisonIDRestrictions", SqlDbType.Bit).Value = true;
                    SqlParameter newLiaisonID = new SqlParameter("@NewLiaisonID", SqlDbType.Int);
                    newLiaisonID.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newLiaisonID);
                    Utils.executeNonQuery(cmd, ConnectionString);
                    clearAllSelectionInputFields();
                    performPostNewSuccessfulActions("Update successful", DataSetCacheKey, null, tbComRosterLiaisonIDLU, newLiaisonID.Value);

                } catch (Exception ee) {
                    performPostNewFailedActions("Update failed. Msg: " + ee.Message);
                    isAddNewLiaisonOpen = true;
                    mpeNewComRosterLiaison.Show();
                    return;
                }
                isAddNewLiaisonOpen = false;
                mpeNewComRosterLiaison.Hide();
            } else {
                isAddNewLiaisonOpen = true;
                mpeNewComRosterLiaison.Show();
            }
        }
    }
}