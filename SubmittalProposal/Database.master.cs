using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace SubmittalProposal {
    public partial class Database : System.Web.UI.MasterPage {
        public event SearchButtonPressedEventHandler SearchButtonPressed;
        public event UnlockCheckboxCheckedHandler UnlockCheckboxChecked;
        public delegate void SearchButtonPressedEventHandler(out string searchCriteria, out DataTable filteredData );
        public delegate void UnlockCheckboxCheckedHandler(bool isUnlocked);
        public AjaxControlToolkit.CollapsiblePanelExtender getCPEForm { get { return CPEForm; } }
        public AjaxControlToolkit.CollapsiblePanelExtender getCPEDataGrid { get { return CPEDataGrid; } }
        public Panel getPanelForm { get { return pnlForm; } }
        protected virtual void OnSearchButtonPressed(out string searchCriteria, out DataTable resultTable) {
            SearchButtonPressedEventHandler handler = SearchButtonPressed;
            if (handler != null) {
                handler(out searchCriteria, out resultTable);
            } else {
                searchCriteria = null;
                resultTable = null;
            }
        }
        protected virtual void OnUnlockCheckboxChecked(bool isUnlocked) {
            UnlockCheckboxCheckedHandler handler = UnlockCheckboxChecked;
            if (handler != null) {
                handler(isUnlocked);
            }
        }
        protected void Page_Load(object sender, EventArgs e) {
            if (Page.ToString().ToLower().IndexOf("ownerproperty") == -1) {
                lbDeschutesSearch.Visible = false;
            } else {
                lbDeschutesSearch.Visible = true;
            }
        }
        protected void Page_PreRender(object sender, EventArgs e) {
            if (Page.ToString().ToLower().IndexOf("ownerproperty") == -1 || Common.Utils.isNothing(Session["opSRPropIDBeingEdited"])) {
                lbPrintOwnerEnvelope.Visible = false;
            } else {
                lbPrintOwnerEnvelope.Visible = true;
            }
            if (Page.ToString().ToLower().IndexOf("citations") == -1 || Common.Utils.isNothing(Session["CitationsIDBeingEdited"])) {
                lbPrintViolatorsEnvelope.Visible = false;
            } else {
                lbPrintViolatorsEnvelope.Visible = true;
            }
            if (Page.ToString().ToLower().IndexOf("ballot") == -1 ) {
                lbBallotProcess.Visible = false;
            } else {
                lbBallotProcess.Visible = true;
            }
        }
        private bool ballotNumberExists() {
            SqlCommand cmd = new SqlCommand("uspBallotVerifyGet");
            cmd.Parameters.Add("@PropertyId", SqlDbType.NVarChar).Value = tbBallotNumber.Text;
            DataSet ds=Common.Utils.getDataSet(cmd, BallotVerify.ConnectionString);
            return Common.Utils.hasData(ds);
        }
        private bool alreadyVoted() {
            SqlCommand cmd = new SqlCommand("uspBallotVerifyGet");
            cmd.Parameters.Add("@PropertyId", SqlDbType.NVarChar).Value = tbBallotNumber.Text;
            DataSet ds = Common.Utils.getDataSet(cmd, BallotVerify.ConnectionString);
            return Common.Utils.isNothingNot(Common.Utils.ObjectToString(ds.Tables[0].Rows[0]["Voted"]));
        }
        protected void btnBallotOk_onClick(Object obj, EventArgs args) {
            try {
                if (Common.Utils.isNothingNot(tbBallotNumber.Text)) {
                    if (ballotNumberExists()) {

                        if (alreadyVoted()) {
                            lblBallotProcessingMessage.ForeColor = System.Drawing.Color.Red;
                            lblBallotProcessingMessage.Text = tbBallotNumber.Text + " already voted.";
                        } else {
                            SqlCommand cmd = new SqlCommand("uspBallotVerifySetVoted");
                            cmd.Parameters.Add("@PropertyId", SqlDbType.NVarChar).Value = tbBallotNumber.Text;
                            Common.Utils.executeNonQuery(cmd, BallotVerify.ConnectionString, CommandType.StoredProcedure);
                            lblBallotProcessingMessage.ForeColor = System.Drawing.Color.Green;
                            lblBallotProcessingMessage.Text = tbBallotNumber.Text + " marked as voted.";
                            tbBallotNumber.Text = "";
                            tbBallotNumber.Focus();
                        }
                    } else {
                        lblBallotProcessingMessage.ForeColor = System.Drawing.Color.Red;
                        lblBallotProcessingMessage.Text = tbBallotNumber.Text + " is not a valid ballot number.";
                    }
                } else {
                    lblBallotProcessingMessage.ForeColor = System.Drawing.Color.Red;
                    lblBallotProcessingMessage.Text = tbBallotNumber.Text + " Enter a ballot number.";
                }
            } catch (Exception e) {
                lblBallotProcessingMessage.ForeColor = System.Drawing.Color.Red;
                lblBallotProcessingMessage.Text = "Error: " + e.Message;
            }
            mpeBallotProcess.Show();
        }
        public void collapseCPESearch() {
            CPESearch.Collapsed=true;
            CPESearch.ClientState="true";
        }
        private void collapseCPEForm() {
            CPEForm.Collapsed = true;
            CPEForm.ClientState = "true";
        }
        public void expandCPESearch() {
            CPEForm.Collapsed = false;
            CPEForm.ClientState = "false";
        }
        private void expandCPEGrid() {
            CPEDataGrid.Collapsed = false;
            CPEDataGrid.ClientState = "false";
        }

        public Button getBtnGo() {
            return BtnGo;
        }

        protected void btnGo_Click(object sender, EventArgs e) {

            String results = String.Empty;
            DataTable dummyDataTable;
            OnSearchButtonPressed(out results, out dummyDataTable);
            collapseCPESearch();
            CPEDataGrid.CollapsedText = "";
            CPESearch.CollapsedText = results;
            expandCPEGrid();
            collapseCPEForm();
            /* this seems to cause sync problems            CPEForm.CollapsedText = "";*/
            /* this seems to cause sync problems        CPEForm.ExpandedText = ""; */
            /* this seems to cause sync problems         pnlForm.Visible = false;*/ 
        }
        public void doGo() {
            btnGo_Click(null, null);
        }

        public void setUnlockRecordCheckboxVisibility(bool isVisible) {
            if (isVisible) {
                cbUnlockRecord.Visible = true;
            } else {
                cbUnlockRecord.Visible = false;
            }
        }

        public void enableUnlockRecordCheckbox(bool enable) {
            cbUnlockRecord.Enabled = enable;
        }

         public void clearUnlockRecordCheckbox() {
            cbUnlockRecord.Checked = false;
            OnUnlockCheckboxChecked(false);
        }

        protected void cbUnlockRecord_CheckedChanged(object sender, EventArgs e) {
            if (cbUnlockRecord.Checked) {
                OnUnlockCheckboxChecked(true);
            } else {
                OnUnlockCheckboxChecked(false);
            }
        }

    }
}