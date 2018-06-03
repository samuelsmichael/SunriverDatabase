using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;

namespace SubmittalProposal
{
    public partial class Submittal2 : AbstractDatabase, ICanHavePDFs
    {
        public static string SUBMITTAL_CACHE_KEY = "SubmittalDS";

        protected override string UpdateRoleName {
            get { return "canupdatesubmittals"; }
        }
         protected override GridView getGridViewResults() {
            return gvResults;
        }
         public static DataSet SunriverDataSet() {
             DataSet ds = null;
             MemoryCache cache = MemoryCache.Default;
             string key = SUBMITTAL_CACHE_KEY;
             ds = (DataSet)cache[key];
             if (ds == null) {
                 SqlCommand cmd = new SqlCommand("uspSubmittalsGetLogical");
                 ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                 ds.Tables[0].TableName = "Submittals";
                 CacheItemPolicy policy = new CacheItemPolicy();
                 policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                 cache.Add(key, ds, policy);
             }
             return ds;
         }
        protected override DataSet buildDataSet() {
            return SunriverDataSet();
        }

        protected override Label getUpdateResultsLabel() {
            return lblSubmitalUpdateResults;
        }
        protected override Label getNewResultsLabel() {
            return lblSubmitalNewResults;
        }

        private bool weveAlreadyGotABPermitId() {
            return Utils.isNothingNot(CurrentBPermitIdReally);
        }
        private bool wereCurrentlyDoingANewBPermit() {
            return pnlNewBPermitContent.Visible;
        }
        private bool thisBPermitNbrAlreadyExistsAndItsNotMe(string bPermitNbr) {
            string filter=" [BPermit#] ='" + bPermitNbr + "'";
            if(weveAlreadyGotABPermitId()) {
                filter += " AND BPermitId <> " +  CurrentBPermitIdReally;
            }
            DataTable sourceTable = BPermit.BPermitDataSet().Tables["BPData"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = filter;
            DataTable tab=view.ToTable();
            return tab.Rows!=null && tab.Rows.Count>0;
        }
        private bool itLooksLikeTheyveGotABPermit(bool isNew) {
            if (isNew) {
                return
                    Utils.isNothingNot(tbBPermitNbrNew.Text) ||
                    Utils.isNothingNot(tbDelayNew.Text) ||
                    Utils.isNothingNot(tbIssuedNew.Text) ||
                    Utils.isNothingNot(tbClosedNew.Text) ||
                    rbListPermitRequiredNew.SelectedIndex > -1 ||
                    ddlContractorNew.SelectedValue!="0";
            } else {
                return 
                    Utils.isNothingNot(tbBPermitNbrUpdate.Text) ||
                    Utils.isNothingNot(tbDelayUpdate.Text) ||
                    Utils.isNothingNot(tbIssuedUpdate.Text) ||
                    Utils.isNothingNot(tbClosedUpdate.Text) ||
                    rbListPermitRequiredUpdate.SelectedIndex > -1 ||
                    ddlContractorUpdate.SelectedValue!="0";
            }
        }
        protected void btnSubmitalUpdate_Click(object sender, EventArgs args) {
            lblSubmitalUpdateResults.Text = "";
            try {
                bool gottaWorryAboutDuplicateBPermitNbrs=false;
                string theBPermitNbrToWorryAbout=null;
                if(wereCurrentlyDoingANewBPermit()) {
                    gottaWorryAboutDuplicateBPermitNbrs=Utils.isNothingNot(tbBPermitNbrNew.Text);
                    theBPermitNbrToWorryAbout=tbBPermitNbrNew.Text;
                } else {
                    gottaWorryAboutDuplicateBPermitNbrs=Utils.isNothingNot(tbBPermitNbrUpdate.Text);
                    theBPermitNbrToWorryAbout=tbBPermitNbrUpdate.Text;
                }
                if (gottaWorryAboutDuplicateBPermitNbrs) {
                    if (thisBPermitNbrAlreadyExistsAndItsNotMe(theBPermitNbrToWorryAbout)) {
                        TabContainer1.ActiveTabIndex = 2;
                        throw new Exception("This BPermit# already is used.");
                    }
                }
                SqlCommand cmd = new SqlCommand(
                    "uspSubmittalUpdate"
                );
                cmd.Parameters.Add("@SubmittalId", SqlDbType.Int).Value = CurrentSubmittalId;
                cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneUpdate.SelectedValue;
                cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameUpdate.Text.Trim();
                cmd.Parameters.Add("@Contractor",SqlDbType.NVarChar).Value=tbContractorUpdate.Text.Trim();
                cmd.Parameters.Add("@Mtg_Date",SqlDbType.DateTime).Value=(tbMeetingDateUpdate.Text.Trim()=="")?(DateTime?)null:Convert.ToDateTime(tbMeetingDateUpdate.Text.Trim());
                cmd.Parameters.Add("@ProjectType",SqlDbType.NVarChar).Value=ddlProjectTypeUpdate.SelectedValue;
                cmd.Parameters.Add("@ProjectDecision",SqlDbType.NVarChar).Value=ddlProjectDecisionUpdate.SelectedValue;
                cmd.Parameters.Add("@IsCommercial",SqlDbType.Bit).Value=cbIsCommercialUpdate.Checked;
                cmd.Parameters.Add("@Project",SqlDbType.NVarChar).Value=tbProjectUpdate.Text.Trim();
                cmd.Parameters.Add("@Submittal",SqlDbType.NVarChar).Value=tbSubmittalUpdate.Text.Trim();
                cmd.Parameters.Add("@Conditions", SqlDbType.NVarChar).Value = tbConditionsUpdate.Text.Trim();
                SqlParameter dummy = new SqlParameter("@NewSubmittalId", SqlDbType.Int);
                dummy.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(dummy);
                Utils.executeNonQuery(cmd,
                    System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                if (itLooksLikeTheyveGotABPermit(pnlNewBPermitContent.Visible)) {
                    if (pnlNewBPermitContent.Visible) {
                        doNewBPermitOk();

                    } else {
                        doBPermitUpdate();
                    }
                }
                TabContainer1.ActiveTabIndex = 0; // this is necessary because the bppanel depends on formatting done here
                MemoryCache.Default.Remove(BPermit.BPERMIT_CACHE_GRID_KEY);
                performPostUpdateSuccessfulActions("Update successful", SUBMITTAL_CACHE_KEY, BPermit.BPERMIT_CACHE_KEY);
            } catch (Exception e) {
                performPostUpdateFailedActions("Update failed. Msg: " + e.Message);
            }
        }
        private int? CurrentSubmittalId {
            get {
                object obj = ViewState["CurrentSubmittalId"];
                return obj == null ? null : (int?)obj;
            }
            set {
                ViewState["CurrentSubmittalId"] = value;
            }
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend="";
            string and = "";
            if (Utils.isNothingNot(tbOwner.Text)) {
                sb.Append(prepend+"Owner: " + tbOwner.Text);
                prepend="  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbOwner.Text,"Own_Name"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbApplicant.Text)) {
                sb.Append(prepend + "Applicant: " + tbApplicant.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbApplicant.Text,"Applicant"));
                and = " and ";
            }
            if(Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " Lot = '" + tbLot.Text+"'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower()!="choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " Lane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbSubmittalId.Text)) {
                sb.Append(prepend + "Submittal Id: " + tbSubmittalId.Text);
                prepend = "  ";
                sbFilter.Append(and + " SubmittalId = " + tbSubmittalId.Text);
                and = " and ";
            }
            if (Utils.isNothingNot(tbBPermitId.Text)) {
                sb.Append(prepend + "BPermit#: " + tbBPermitId.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbBPermitId.Text, "[BPermit#]"));
                and = " and ";
            }
            if (ddlIsCommercial.SelectedValue != "Null") {
                sb.Append(prepend + " Is Commercial: " + ddlIsCommercial.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " IsCommercial = " + ddlIsCommercial.SelectedValue);
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }
        private int getSubmittalId(GridViewRow dr) {
            CurrentSubmittalId = Convert.ToInt32(dr.Cells[6].Text);
            return CurrentSubmittalId.Value;
        }
        private string getBPermitIdFromGridView(GridViewRow dr) {
            CurrentBPermitId = dr.Cells[7].Text;
            return CurrentBPermitId;
        }
        private string getOwner(DataRow dr) {
            return Utils.ObjectToString(dr["Own_Name"]);
        }
        private DateTime? getMeetingDate(DataRow dr) {
            return Utils.ObjectToDateTimeNullable(dr["Mtg_Date"]);
        }
        private string getBPermitId(DataRow dr) {
            return Utils.ObjectToString(dr["BPermit#"]);
        }
        private int getBPermitIdReally(DataRow dr) {
            return Utils.ObjectToIntNULLINTIfNull(dr["BPermitID"]);
        }
        private string getLotLane(DataRow dr) {
            return (Utils.ObjectToString(dr["Lot"])) + "\\" + Utils.ObjectToString(dr["Lane"]);
        }

        protected override void lockYourUpdateFields() {
            btnSubmitalUpdate.Enabled = false;
            tbOwnersNameUpdate.Enabled = false;
            tbLotNameUpdate.Enabled = false;
            tbApplicantNameUpdate.Enabled = false;
            tbContractorUpdate.Enabled = false;
            tbMeetingDateUpdate.Enabled = false;
            ddlProjectTypeUpdate.Enabled = false;
            ddlProjectDecisionUpdate.Enabled = false;
            cbIsCommercialUpdate.Enabled = false;
            tbProjectUpdate.Enabled = false;
            tbSubmittalUpdate.Enabled = false;
            tbConditionsUpdate.Enabled = false;
            ddlLaneUpdate.Enabled = false;
            ImgCopyProjectToSubmittal.Enabled = false;
            lockYourUpdateFieldsBPermit();
        }
        protected override void unlockYourUpdateFields() {
            btnSubmitalUpdate.Enabled = true;
            tbOwnersNameUpdate.Enabled = true;
            tbLotNameUpdate.Enabled = true;
            tbApplicantNameUpdate.Enabled = true;
            tbContractorUpdate.Enabled = true;
            tbMeetingDateUpdate.Enabled = true;
            ddlProjectTypeUpdate.Enabled = true;
            ddlProjectDecisionUpdate.Enabled = true;
            cbIsCommercialUpdate.Enabled = true;
            tbProjectUpdate.Enabled = true;
            tbSubmittalUpdate.Enabled = true;
            tbConditionsUpdate.Enabled = true;
            ddlLaneUpdate.Enabled = true;
            ImgCopyProjectToSubmittal.Enabled = true;
            unlockYourUpdateFieldsBPermit();
        }

        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            clearAllNewFormInputFieldsBP();
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;

            DataSet ds = buildDataSet();
            DataTable sourceTable = ds.Tables[0];
            DataView view = new DataView(sourceTable);
            string rowFilter = "SubmittalId=" + getSubmittalId(row);
            string strBPId = getBPermitIdFromGridView(row);
            if (strBPId!=null && strBPId!="&nbsp;") {
                rowFilter += (" AND [BPermit#] ='" + strBPId + "'");
            }
            view.RowFilter = rowFilter;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            tbConditionsUpdate.Text = Utils.ObjectToString(dr["Conditions"]);
            tbOwnersNameUpdate.Text = Utils.ObjectToString(dr["Own_Name"]);
            tbLotNameUpdate.Text = Utils.ObjectToString(dr["Lot"]);
            if(ddlLaneUpdate.Items.FindByText(Utils.ObjectToString(dr["Lane"]))==null) {
                ddlLaneUpdate.Items.Add(new ListItem(Utils.ObjectToString(dr["Lane"]),Utils.ObjectToString(dr["Lane"])));
            }
            ddlLaneUpdate.SelectedValue = Utils.ObjectToString(dr["Lane"]);
            SetLaneLotForPDFs(ddlLaneUpdate.SelectedValue + " " + tbLotNameUpdate.Text);
            tbApplicantNameUpdate.Text = Utils.ObjectToString(dr["Applicant"]);
            tbContractorUpdate.Text = Utils.ObjectToString(dr["Contractor"]);
            DateTime? meetingDate = Utils.ObjectToDateTimeNullable(dr["Mtg_Date"]);
            tbMeetingDateUpdate.Text = meetingDate.HasValue?meetingDate.Value.ToString("MM/dd/yyyy"):"";
            DateTime? feePaidDate = Utils.ObjectToDateTimeNullable(dr["FeeDate"]);
            ddlProjectTypeUpdate.SelectedValue = Utils.ObjectToString(dr["ProjectType"]);
            if (ddlProjectDecisionUpdate.Items.FindByText(Utils.ObjectToString(dr["ProjectDecision"])) == null) {
                ddlProjectDecisionUpdate.Items.Add(new ListItem(Utils.ObjectToString(dr["ProjectDecision"]), Utils.ObjectToString(dr["ProjectDecision"])));
            }
            ddlProjectDecisionUpdate.SelectedValue = Utils.ObjectToString(dr["ProjectDecision"]);
   // v2.09        if (ddlProjectDecisionUpdate.SelectedValue == "A" || ddlProjectDecisionUpdate.SelectedValue == "AWC") {
                lbGoToPermit.Visible = true;
     //       } else {
       //         lbGoToPermit.Visible = false;
         //   }
            tbProjectUpdate.Text = Utils.ObjectToString(dr["Project"]);
            tbSubmittalUpdate.Text = Utils.ObjectToString(dr["Submittal"]);
            cbIsCommercialUpdate.Checked=Convert.ToBoolean(dr["IsCommercial"]);
            string permitid = getBPermitId(dr);
            CurrentBPermitId =permitid; // This is the Permit#
            CurrentBPermitIdReally = getBPermitIdReally(dr); // This is the PermitID
            if (Utils.isNothing(CurrentBPermitIdReally)) {
                pnlNewBPermitContent.Visible = true;
                pnlUpdateBPermitContent.Visible = false;
            } else {
                pnlNewBPermitContent.Visible = false;
                pnlUpdateBPermitContent.Visible = true;
            }

            TabContainer1.ActiveTabIndex = 0;
            loadBPermitPage();
            return "Lot\\Lane: " + getLotLane(dr) + "  Submittal Id: " + getSubmittalId(row) + "  BPermit# :" + permitid + "  Meeting Date: " + getMeetingDate(dr) + " Owner: " + getOwner(dr);
        }
        /// <summary>
        /// This is the BPermit#
        /// </summary>
        string CurrentBPermitId { get { return (string)Session["CurrentBPermitId"]; } set { Session["CurrentBPermitId"] = value; } }
        /// <summary>
        /// This is the BPermitID
        /// </summary>
        int CurrentBPermitIdReally { get { if (Utils.isNothing(Session["CurrentBPermitIdReally"])) { return Utils.NULL_INT; } else { return (int)Session["CurrentBPermitIdReally"]; } } 
            set { Session["CurrentBPermitIdReally"] = value; } }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                Session["LastActiveTabIndex"] = 0;
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
                ddlLaneUpdate.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneUpdate.DataBind();
                ddlLaneUpdateBP.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneUpdateBP.DataBind();
                ddlLaneNew.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneNew.DataBind();
                ddlLaneNewBP.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneNewBP.DataBind();
                /*
                if (!this.ClientScript.IsStartupScriptRegistered("startupBB")) {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<script type='text/javascript'>");
                    sb.Append("Sys.Application.add_load(modalSetup);");
                    sb.Append("function modalSetup() {");
                    sb.Append(String.Format("var modalPopup = $find('{0}');", MPE.BehaviorID));
                    sb.Append("modalPopup.add_shown(shown); }");
                    sb.Append("</script>");
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "startupBB", sb.ToString());
                }
                 */
                DataTable contractor = Contractor.CRDataSet().Tables[1];
                DataRow dr = contractor.NewRow();
                dr["Contact"] = "";
                dr["SRContrRegID"] = 0;
                try { // it might already be there
                    contractor.Rows.InsertAt(dr, 0);
                } catch { }
                ddlContractorUpdate.DataSource = contractor;
                ddlContractorUpdate.DataBind();
                ddlContractorNew.DataSource = contractor;
                ddlContractorNew.DataBind();
            }
        }
        protected override DataTable getGridViewDataTable() {
            return buildDataSet().Tables[0];
        }

        protected void lbNewPermitFromUpdatePermit_OnClick(object sender, EventArgs args) {

            pnlNewBPermitContent.Visible = true;
            pnlUpdateBPermitContent.Visible = false;

        }

        protected void lbSubmittalNew_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspFindHighestSubmittalId");
            DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
            int maxSubmittalId = Convert.ToInt32(ds.Tables[0].Rows[0]["SubmittalId"]);
            maxSubmittalId++;
            lblAutoSubmittalId.Text = "" + maxSubmittalId;
            mpeNewSubmittal.Show();

        }


        protected void lbGoToPermit_Click(object sender, EventArgs args) {
            Session["ShowBPermitID"] = CurrentBPermitIdReally;
            Session["ShowSubmittalID"] = CurrentSubmittalId;
            Response.Redirect("~/BPermit.aspx");
        }

        protected void btnNewSubmittalCancel_Click(object sender, EventArgs args) {
            clearAllSelectionInputFields();
        }

        protected void btnNewSubmittalOk_Click(object sender, EventArgs args) {

            lblRequiredMeetingDate.Text = "";
            if (tbMeetingDateNew.Text.Trim() == "") {
                lblRequiredMeetingDate.Text = "Meeting Date is a required field.";
                mpeNewSubmittal.Show();
            } else {
                lblSubmitalUpdateResults.Text = "";
                try {
                    SqlCommand cmd = new SqlCommand(
                        "uspSubmittalUpdate"
                    );
                    cmd.Parameters.Add("@Own_Name", SqlDbType.VarChar).Value = tbOwnersNameNew.Text.Trim();
                    cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameNew.Text.Trim();
                    cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneNew.SelectedValue;
                    cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameNew.Text.Trim();
                    cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorNew.Text.Trim();
                    cmd.Parameters.Add("@Mtg_Date", SqlDbType.DateTime).Value = (tbMeetingDateNew.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(tbMeetingDateNew.Text.Trim());
                    cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeNew.SelectedValue;
                    cmd.Parameters.Add("@ProjectDecision", SqlDbType.NVarChar).Value = ddlProjectDecisionNew.SelectedValue;
                    cmd.Parameters.Add("@IsCommercial", SqlDbType.Bit).Value = cbIsCommercialNew.Checked;
                    cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectNew.Text.Trim();
                    cmd.Parameters.Add("@Submittal", SqlDbType.NVarChar).Value = tbSubmittalNew.Text.Trim();
                    cmd.Parameters.Add("@Conditions", SqlDbType.NVarChar).Value = tbConditionsNew.Text.Trim();
                    SqlParameter newSubmittalId = new SqlParameter("@NewSubmittalId", SqlDbType.Int);
                    newSubmittalId.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newSubmittalId);
                    Utils.executeNonQuery(cmd,
                        System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                    MemoryCache.Default.Remove(BPermit.BPERMIT_CACHE_GRID_KEY);
                    performPostNewSuccessfulActions("Submittal added successfully", SUBMITTAL_CACHE_KEY, BPermit.BPERMIT_CACHE_KEY, tbSubmittalId, Convert.ToInt32(newSubmittalId.Value));
                    mpeNewSubmittal.Hide();
                    TabContainer1.ActiveTabIndex = 0; // again, necessary because bpermit panel formlated with this data;
                } catch (Exception e) {
                    performPostNewFailedActions("Submittal not added. Msg: " + e.Message);
                }
            }
        }
        protected override void clearAllSelectionInputFields() {
            tbOwner.Text = "";
            tbApplicant.Text = "";
            tbLot.Text = "";
            ddlLane.SelectedIndex = 0;
            tbSubmittalId.Text = "";
            tbBPermitId.Text = "";
            ddlIsCommercial.SelectedIndex = 0;
        }
        protected override void clearAllNewFormInputFields() {
            tbOwnersNameNew.Text = "";
            tbLotNameNew.Text = "";
            ddlLaneNew.SelectedIndex = 0;
            tbApplicantNameNew.Text = "";
            tbContractorNew.Text = "";
            ddlProjectDecisionNew.SelectedIndex = 0;
            cbIsCommercialNew.Checked = false;
            tbProjectNew.Text = "";
            tbSubmittalNew.Text = "";
            tbConditionsNew.Text = "";
            tbMeetingDateNew.Text = "";
            clearAllNewFormInputFieldsBP();
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        public static string MyMenuName = "Submittal";
        protected override string childMenuName {
            get { return MyMenuName; }
        }

        public bool HasPropertyAvailable {
            get { return Utils.isNothingNot(CurrentSubmittalId); }
        }

        public void SetLaneLotForPDFs(string lanelot) {
            LaneLotForPDFs = lanelot;
        }


        /* ---------------------------------------- BPermit tab ------------------------------------------------------------ */
        private void doBPermitUpdate() {
            SqlCommand cmd = new SqlCommand("uspProjectAndSubmittalUpdate");
            if (((int)Session["LastActiveTabIndex"]) == 2) {
                cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameUpdateBP.Text;
                cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameUpdateBP.Text;
                cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneUpdateBP.SelectedValue;
                cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameUpdateBP.Text;
                cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorUpdateBP.Text;
                cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeUpdateBP.SelectedValue;
                cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectUpdateBP.Text;
            } else {
                cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameUpdate.Text;
                cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameUpdate.Text;
                cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneUpdate.SelectedValue;
                cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameUpdate.Text;
                cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorUpdate.Text;
                cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeUpdate.SelectedValue;
                cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectUpdate.Text;
            }
            int? contractorId = ddlContractorUpdate.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlContractorUpdate.SelectedValue);
            cmd.Parameters.Add("@fkSRContrRegID", SqlDbType.Int).Value = contractorId;
            cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = this.CurrentBPermitIdReally;
            cmd.Parameters.Add("@BPermitReqd", SqlDbType.Bit).Value = rbListPermitRequiredUpdate.SelectedValue == "Yes" ? true : false;
            DateTime? issuedDate =
                tbIssuedUpdate.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbIssuedUpdate.Text);
            cmd.Parameters.Add("@BPIssueDate", SqlDbType.DateTime).Value = issuedDate;
            DateTime? closeDate =
                tbClosedUpdate.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbClosedUpdate.Text);
            cmd.Parameters.Add("@BPClosed", SqlDbType.DateTime).Value = closeDate;
            cmd.Parameters.Add("@BPDelay", SqlDbType.NVarChar).Value = tbDelayUpdate.Text;
            cmd.Parameters.Add("@SubmittalId", SqlDbType.Int).Value = this.CurrentSubmittalId;
            cmd.Parameters.Add("@BPermit#", SqlDbType.NVarChar).Value = tbBPermitNbrUpdate.Text;
            SqlParameter newBPermitId = new SqlParameter("@NewBPermitID", SqlDbType.Int);
            newBPermitId.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(newBPermitId);
            SqlParameter newSubmittalId = new SqlParameter("@NewSubmittalID", SqlDbType.Int);
            newSubmittalId.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(newSubmittalId);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
        }

        decimal feeTotal = 0;
        int monthsTotal = 0;
        public int getBPMonthsTotal() {
            return monthsTotal;
        }
        public string getBPFeeTotal() {
            return feeTotal.ToString("c");
        }
        private void bind_gvReviews(int bPermitId) {
            DataTable sourceTableReviews = BPermit.BPermitDataSet().Tables["BPReviews"];
            DataView viewReviews = new DataView(sourceTableReviews);
            viewReviews.RowFilter = "fkBPermitID_PR=" + bPermitId;
            DataTable tblFilteredReviews = viewReviews.ToTable();
            gvReviews.DataSource = tblFilteredReviews;
            gvReviews.DataBind();

        }
        private void bind_gvPayments(int bPermitId) {
            DataTable sourceTablePayments = BPermit.BPermitDataSet().Tables["BPPayment"];
            DataView viewPayments = new DataView(sourceTablePayments);
            viewPayments.RowFilter = "BPermitID =" + bPermitId;
            DataTable tblFilteredPayments = viewPayments.ToTable();

            feeTotal = 0;
            monthsTotal = 0;
            foreach (DataRow dr1 in tblFilteredPayments.Rows) {
                try {
                    feeTotal += Utils.ObjectToDecimal0IfNull(dr1["BPFee$"]);
                } catch { };
                try {
                    monthsTotal += Utils.ObjectToInt(dr1["BPMonths"]);
                } catch { }
            }

            gvPayments.DataSource = tblFilteredPayments;
            gvPayments.DataBind();
        }

        protected void rblListOfPermits_OnSelectedIndexChanged(object sender, EventArgs e) {
            doBPermitUpdate();
            ListItem li = rblListOfPermits.SelectedItem;
            CurrentBPermitId = li.Text;
            CurrentBPermitIdReally = Convert.ToInt32(li.Value);
            loadBPermitPage();
        }


        private void loadBPermitPage() {
            if (Utils.isNothingNot(CurrentBPermitIdReally)) {
                DataTable sourceTable = BPermit.BPermitsGetGridViewDataTable();
                DataView view = new DataView(sourceTable);

                // bind rblListOfPermits
                rblListOfPermits.Items.Clear();
                view.RowFilter = "SubmittalId=" + CurrentSubmittalId;
                DataTable tblFiltered = view.ToTable();
                foreach(DataRow dr2 in tblFiltered.Rows) {
                    ListItem li=new ListItem((string)dr2["BPermit#"],dr2["BPermitId"].ToString());
                    if(((string)dr2["BPermit#"])==CurrentBPermitId) {
                        li.Selected=true;
                    }
                    rblListOfPermits.Items.Add(li);
                }

                bind_gvPayments(Utils.ObjectToInt(CurrentBPermitIdReally));

                view.RowFilter = "BPermitId=" + CurrentBPermitIdReally;
                tblFiltered = view.ToTable();
                DataRow dr = tblFiltered.Rows[0];

                tbDelayUpdate.Text = Utils.ObjectToString(dr["BPDelay"]);
                DateTime? issueDate = Utils.ObjectToDateTimeNullable(dr["BPIssueDate"]);
                tbIssuedUpdate.Text = issueDate.HasValue ? issueDate.Value.ToString("MM/dd/yyyy") : "";
                Object expires = dr["BPExpires"];
                if (expires is DBNull) {
                    lblExpired.Text = "";
                } else {
                    lblExpired.Text = Utils.ObjectToDateTime(expires).ToString("MM/dd/yyyy");
                }
                lblExpired.BackColor = System.Drawing.Color.FromName("White");
                lblExpired.ForeColor = System.Drawing.Color.FromName("Black");
                try {
                    if (Convert.ToDateTime(lblExpired.Text) < DateTime.Today) {
                        lblExpired.BackColor = System.Drawing.Color.FromName("Red");
                        lblExpired.ForeColor = System.Drawing.Color.FromName("White");
                    }
                } catch { }
                DateTime? closed = Utils.ObjectToDateTimeNullable(dr["BPClosed"]);
                tbClosedUpdate.Text = closed.HasValue ? closed.Value.ToString("MM/dd/yyyy") : "";
                if (Utils.ObjectToBool(dr["BPermitReqd"])) {
                    rbListPermitRequiredUpdate.SelectedValue = "Yes";
                } else {
                    rbListPermitRequiredUpdate.SelectedValue = "No";
                }
                tbApplicantNameUpdateBP.Text = Utils.ObjectToString(dr["Applicant"]);
                tbOwnersNameUpdateBP.Text = Utils.ObjectToString(dr["OwnersName"]);
                tbContractorUpdateBP.Text = Utils.ObjectToString(dr["Contractor"]);
                ddlProjectTypeUpdateBP.SelectedValue = Utils.ObjectToString(dr["ProjectType"]);
                tbProjectUpdateBP.Text = Utils.ObjectToString(dr["Project"]);
                tbLotNameUpdateBP.Text = Utils.ObjectToString(dr["Lot"]);
                if (ddlLaneUpdateBP.Items.FindByText(Utils.ObjectToString(dr["Lane"])) == null) {
                    ddlLaneUpdateBP.Items.Add(new ListItem(Utils.ObjectToString(dr["Lane"]), Utils.ObjectToString(dr["Lane"])));
                }
                ddlLaneUpdateBP.SelectedValue = Utils.ObjectToString(dr["Lane"]);
                SetLaneLotForPDFs(ddlLaneUpdateBP.SelectedValue + " " + tbLotNameUpdateBP.Text);

                ddlContractorUpdate.SelectedValue = Utils.ObjectToString(Utils.ObjectToInt(dr["fkSRContrRegID"]));

                bind_gvReviews(Utils.ObjectToInt(CurrentBPermitIdReally));
                tbBPermitNbrUpdate.Text = Utils.ObjectToString(CurrentBPermitId);
            }
        }
        protected void doNewBPermitOk() {
            SqlCommand cmd = new SqlCommand("uspProjectAndSubmittalUpdate");
            if (((int)Session["LastActiveTabIndex"]) == 2) {

                cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameNewBP.Text;
                cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameNewBP.Text;
                cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneNewBP.SelectedValue;
                cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameNewBP.Text;
                cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorNewBP.Text;
                cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeNewBP.SelectedValue;
                cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectNewBP.Text;
            } else {
                cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameUpdate.Text;
                cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameUpdate.Text;
                cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneUpdate.SelectedValue;
                cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameUpdate.Text;
                cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorUpdate.Text;
                cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeUpdate.SelectedValue;
                cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectUpdate.Text;
            }
            cmd.Parameters.Add("@BPermitReqd", SqlDbType.Bit).Value = rbListPermitRequiredNew.SelectedValue == "Yes" ? true : false;
            DateTime? issuedDate =
                tbIssuedNew.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbIssuedNew.Text);
            cmd.Parameters.Add("@BPIssueDate", SqlDbType.DateTime).Value = issuedDate;
            DateTime? closeDate =
                tbClosedNew.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbClosedNew.Text);
            cmd.Parameters.Add("@BPClosed", SqlDbType.DateTime).Value = closeDate;
            cmd.Parameters.Add("@BPDelay", SqlDbType.NVarChar).Value = tbDelayNew.Text;
            cmd.Parameters.Add("@SubmittalId", SqlDbType.Int).Value = this.CurrentSubmittalId;
            cmd.Parameters.Add("@BPermit#", SqlDbType.NVarChar).Value = tbBPermitNbrNew.Text;
            SqlParameter newBPermitId = new SqlParameter("@NewBPermitID", SqlDbType.Int);
            newBPermitId.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(newBPermitId);
            int? contractorId = ddlContractorNew.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlContractorNew.SelectedValue);
            cmd.Parameters.Add("@fkSRContrRegID", SqlDbType.Int).Value = contractorId;
            SqlParameter newSubmittalId = new SqlParameter("@NewSubmittalID", SqlDbType.Int);
            newSubmittalId.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(newSubmittalId);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
            int newBuildingPermitId = Utils.ObjectToInt(newBPermitId.Value);
            if (newBuildingPermitId != 0) {
                if (Utils.isNothingNot(tbBPPaymentFeeNewNewPermit.Text) && Utils.isNothingNot(tbBPPaymentMonthsNewNewPermit.Text)) {
                    cmd = new SqlCommand("uspPaymentsUpdate");
                    cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = newBuildingPermitId;
                    int? months = tbBPPaymentMonthsNewNewPermit.Text.Trim() == "" ? (int?)null : Utils.ObjectToInt(tbBPPaymentMonthsNewNewPermit.Text.Trim().Replace("$", "").Replace(",", ""));
                    cmd.Parameters.Add("@BPMonths", SqlDbType.Int).Value = months;
                    decimal? fee = tbBPPaymentFeeNewNewPermit.Text.Trim() == "" ? (decimal?)null : Utils.ObjectToDecimal(tbBPPaymentFeeNewNewPermit.Text.Trim().Replace("$", "").Replace(",", ""));
                    cmd.Parameters.Add("@BPFee", SqlDbType.Money).Value = fee;
                    SqlParameter newid = new SqlParameter("@NewBPPaymentID", SqlDbType.Int);
                    newid.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newid);
                    Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                }
                if(Utils.isNothingNot(tbBPermitReviewDateNewNewPermit.Text)) {
                    cmd = new SqlCommand("uspReviewsUpdate");
                    cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = newBuildingPermitId;
                    DateTime? review = tbBPermitReviewDateNewNewPermit.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbBPermitReviewDateNewNewPermit.Text.Trim());
                    cmd.Parameters.Add("@BPReviewDate", SqlDbType.DateTime).Value = review;
                    DateTime? action = tbBPermitActionDateNewNewPermit.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbBPermitActionDateNewNewPermit.Text.Trim());
                    cmd.Parameters.Add("@BPRActionDate", SqlDbType.DateTime).Value = action;
                    DateTime? letter = tbBPermitLetterDateNewNewPermit.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbBPermitLetterDateNewNewPermit.Text.Trim());
                    cmd.Parameters.Add("@BPRLetterDate", SqlDbType.DateTime).Value = letter;
                    cmd.Parameters.Add("@BPRLetterRef", SqlDbType.NVarChar).Value = tbBPRLetterRefNewNewPermit.Text.Trim();
                    cmd.Parameters.Add("@BPRComments", SqlDbType.NVarChar).Value = tbBPRCommentsNewNewPermit.Text.Trim();
                    SqlParameter newid = new SqlParameter("@NewBPReviewID", SqlDbType.Int);
                    newid.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newid);
                    Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                }
            }
        }
        protected void btnNewBPermitPaymentOk_Click(object sender, EventArgs e) {
            try {
                doBPermitUpdate();
                SqlCommand cmd = new SqlCommand("uspPaymentsUpdate");
                cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = CurrentBPermitIdReally;
                int? months = tbBPPaymentMonthsNew.Text.Trim() == "" ? (int?)null : Utils.ObjectToInt(tbBPPaymentMonthsNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@BPMonths", SqlDbType.Int).Value = months;
                decimal? fee = tbBPPaymentFeeNew.Text.Trim() == "" ? (decimal?)null : Utils.ObjectToDecimal(tbBPPaymentFeeNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@BPFee", SqlDbType.Money).Value = fee;
                SqlParameter newid = new SqlParameter("@NewBPPaymentID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Payment added", "BPermitDS", "BPermitDSGridView");
                TabContainer1.ActiveTabIndex = 2;
            } catch (Exception ee) {
                performPostUpdateFailedActions("Payment not added. Error msg: " + ee.Message);
                TabContainer1.ActiveTabIndex = 2;
            }
                                                                                  
        }
        protected void btnNewBPermitReviewOk_Click(object sender, EventArgs args) {
            try {
                doBPermitUpdate();
                SqlCommand cmd = new SqlCommand("uspReviewsUpdate");
                cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = CurrentBPermitIdReally;
                DateTime? review = tbBPermitReviewDateNew.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbBPermitReviewDateNew.Text.Trim());
                cmd.Parameters.Add("@BPReviewDate", SqlDbType.DateTime).Value = review;
                DateTime? action = tbBPermitActionDateNew.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbBPermitActionDateNew.Text.Trim());
                cmd.Parameters.Add("@BPRActionDate", SqlDbType.DateTime).Value = action;
                DateTime? letter = tbBPermitLetterDateNew.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbBPermitLetterDateNew.Text.Trim());
                cmd.Parameters.Add("@BPRLetterDate", SqlDbType.DateTime).Value = letter;
                cmd.Parameters.Add("@BPRLetterRef", SqlDbType.NVarChar).Value = tbBPRLetterRefNew.Text.Trim();
                cmd.Parameters.Add("@BPRComments", SqlDbType.NVarChar).Value = tbBPRCommentsNew.Text.Trim();

                SqlParameter newid = new SqlParameter("@NewBPReviewID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Review added", "BPermitDS", "BPermitDSGridView");
                TabContainer1.ActiveTabIndex = 2;
            } catch (Exception ee) {
                performPostUpdateFailedActions("Review not added. Error msg: " + ee.Message);
                TabContainer1.ActiveTabIndex = 2;
            }
                                                                                    
        }

        protected void gvPayments_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvPayments.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            bind_gvPayments(Utils.ObjectToInt(CurrentBPermitIdReally));
        }

        protected void gvPayments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvPayments.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvPayments(Utils.ObjectToInt(this.CurrentBPermitIdReally));
        }

        protected void gvPayments_RowUpdating(object sender, GridViewUpdateEventArgs e) {

            GridViewRow row = gvPayments.Rows[e.RowIndex];
            try {
                string strfee = ((TextBox)row.Cells[2].Controls[1]).Text.Trim().Replace("$", "").Replace(",", "");
                decimal? fee = strfee == "" ? (decimal?)null : Utils.ObjectToDecimal(strfee);
                string strmonths = ((TextBox)row.Cells[3].Controls[1]).Text.Trim().Replace("$", "").Replace(",", "");
                int? months = strmonths == "" ? (int?)null : Utils.ObjectToInt(strmonths);
                int paymentid = Utils.ObjectToInt(gvPayments.DataKeys[e.RowIndex].Value);

                SqlCommand cmd = new SqlCommand("uspPaymentsUpdate");
                cmd.Parameters.Add("@BPPaymentId", SqlDbType.Int).Value = paymentid;
                cmd.Parameters.Add("@BPMonths", SqlDbType.Int).Value = months;
                cmd.Parameters.Add("@BPFee", SqlDbType.Money).Value = fee;
                SqlParameter newid = new SqlParameter("@NewBPPaymentID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);


                performPostUpdateSuccessfulActions("Payment updated", "BPermitDS", "BPermitDSGridView");
                TabContainer1.ActiveTabIndex = 2;
            } catch (Exception ee) {
                performPostUpdateFailedActions("Payment not updated. Error msg: " + ee.Message);
                TabContainer1.ActiveTabIndex = 2;
            }
            //Reset the edit index.
            gvPayments.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvPayments(Utils.ObjectToInt(CurrentBPermitIdReally));
        }

        protected void gvReviews_RowEditing(object sender, GridViewEditEventArgs e) {
            gvReviews.EditIndex = e.NewEditIndex;
            bind_gvReviews(Utils.ObjectToInt(CurrentBPermitIdReally));

        }

        protected void gvReviews_RowUpdating(object sender, GridViewUpdateEventArgs e) {

            GridViewRow row = gvReviews.Rows[e.RowIndex];
            try {
                string strreview = ((TextBox)row.Cells[2].Controls[1]).Text.Trim();
                DateTime? review = strreview == "" ? (DateTime?)null : Utils.ObjectToDateTime(strreview);
                string straction = ((TextBox)row.Cells[3].Controls[1]).Text.Trim();
                DateTime? action = straction == "" ? (DateTime?)null : Utils.ObjectToDateTime(straction);
                string strletter = ((TextBox)row.Cells[4].Controls[1]).Text.Trim();
                DateTime? letter = strletter == "" ? (DateTime?)null : Utils.ObjectToDateTime(strletter);

                SqlCommand cmd = new SqlCommand("uspReviewsUpdate");
                cmd.Parameters.Add("@BPReviewID", SqlDbType.Int).Value = gvReviews.DataKeys[e.RowIndex].Value;
                cmd.Parameters.Add("@BPReviewDate", SqlDbType.DateTime).Value = review;
                cmd.Parameters.Add("@BPRActionDate", SqlDbType.DateTime).Value = action;
                cmd.Parameters.Add("@BPRLetterDate", SqlDbType.DateTime).Value = letter;
                cmd.Parameters.Add("@BPRLetterRef", SqlDbType.NVarChar).Value = ((TextBox)row.Cells[5].Controls[1]).Text.Trim(); ;
                cmd.Parameters.Add("@BPRComments", SqlDbType.NVarChar).Value = ((TextBox)row.Cells[6].Controls[1]).Text.Trim();

                SqlParameter newid = new SqlParameter("@NewBPReviewID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Review updated", "BPermitDS", "BPermitDSGridView");
                TabContainer1.ActiveTabIndex = 2;
            } catch (Exception ee) {
                performPostUpdateFailedActions("Review not updated. Error msg: " + ee.Message);
                TabContainer1.ActiveTabIndex = 2;
            }

            gvReviews.EditIndex = -1;
            bind_gvReviews(Utils.ObjectToInt(CurrentBPermitIdReally));
        }

        protected void gvReviews_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvReviews.EditIndex = -1;
            bind_gvReviews(Utils.ObjectToInt(Utils.ObjectToInt(CurrentBPermitIdReally)));
        }

        private void lockYourUpdateFieldsBPermit() {
            tbDelayUpdate.Enabled = false;
            tbIssuedUpdate.Enabled = false;
            tbClosedUpdate.Enabled = false;
            rbListPermitRequiredUpdate.Enabled = false;
            tbLotNameUpdateBP.Enabled = false;
            ddlLaneUpdateBP.Enabled = false;
            tbOwnersNameUpdateBP.Enabled = false;
            tbApplicantNameUpdateBP.Enabled = false;
            tbContractorUpdateBP.Enabled = false;
            tbProjectUpdateBP.Enabled = false;
            ddlProjectTypeUpdateBP.Enabled = false;
            gvPayments.Enabled = false;
            gvReviews.Enabled = false;
            ibIssuedUpdate.Enabled = false;
            ibClosedUpdate.Enabled = false;
            lbBPermitNewPayment.Enabled = false;
            lbBPermitNewReview2.Enabled = false;
            ddlContractorUpdate.Enabled = false;
            tbBPermitNbrUpdate.Enabled = false;
            lbNewPermitFromUpdatePermit.Enabled = false;



            tbBPermitNbrNew.Enabled = false;
            tbDelayNew.Enabled = false;
            tbIssuedNew.Enabled = false;
            ibIssuedNew.Enabled = false;
            tbClosedNew.Enabled = false;
            ibClosedNew.Enabled = false;
            rbListPermitRequiredNew.Enabled = false;
            ddlContractorNew.Enabled = false;
            tbLotNameNewBP.Enabled = false;
            ddlLaneNewBP.Enabled = false;
            tbOwnersNameNewBP.Enabled = false;
            tbApplicantNameNewBP.Enabled = false;
            tbContractorNewBP.Enabled = false;
            tbProjectNewBP.Enabled = false;
            ddlProjectTypeNewBP.Enabled = false;

            tbBPPaymentFeeNewNewPermit.Enabled = false;
            revtbBPPaymentFeeNewNewPermit.Enabled = false;
            tbBPPaymentMonthsNewNewPermit.Enabled = false;
            revBPPaymentMonthsNewNewPermit.Enabled = false;
            tbBPermitReviewDateNewNewPermit.Enabled = false;
            ceBPermitReviewDateNewNewPermit.Enabled = false;
            revBPermitReviewDateNewNewPermit.Enabled = false;
            tbBPermitActionDateNewNewPermit.Enabled = false;
            ceBPermitActionDateNewNewPermit.Enabled = false;
            revBPermitActionDateNewNewPermit.Enabled = false;
            tbBPermitLetterDateNewNewPermit.Enabled = false;
            ceBPermitLetterDateNewNewPermit.Enabled = false;
            revBPermitLetterDateNewNewPermit.Enabled = false;
            tbBPRLetterRefNewNewPermit.Enabled = false;
            tbBPRCommentsNewNewPermit.Enabled = false;

        }
        private void unlockYourUpdateFieldsBPermit() {
            tbDelayUpdate.Enabled = true;
            tbIssuedUpdate.Enabled = true;
            tbClosedUpdate.Enabled = true;
            rbListPermitRequiredUpdate.Enabled = true;
            tbLotNameUpdateBP.Enabled = true;
            ddlLaneUpdateBP.Enabled = true;
            tbOwnersNameUpdateBP.Enabled = true;
            tbApplicantNameUpdateBP.Enabled = true;
            tbContractorUpdateBP.Enabled = true;
            tbProjectUpdateBP.Enabled = true;
            ddlProjectTypeUpdateBP.Enabled = true;
            gvPayments.Enabled = true;
            gvReviews.Enabled = true;
            ibIssuedUpdate.Enabled = true;
            ibClosedUpdate.Enabled = true;
            lbBPermitNewPayment.Enabled = true;
            lbBPermitNewReview2.Enabled = true;
            ddlContractorUpdate.Enabled = true;
            tbBPermitNbrUpdate.Enabled = true;
            tbBPermitNbrNew.Enabled = true;
            tbDelayNew.Enabled = true;
            tbIssuedNew.Enabled = true;
            ibIssuedNew.Enabled = true;
            tbClosedNew.Enabled = true;
            ibClosedNew.Enabled = true;
            rbListPermitRequiredNew.Enabled = true;
            ddlContractorNew.Enabled = true;
            tbLotNameNewBP.Enabled = true;
            ddlLaneNewBP.Enabled = true;
            tbOwnersNameNewBP.Enabled = true;
            tbApplicantNameNewBP.Enabled = true;
            tbContractorNewBP.Enabled = true;
            tbProjectNewBP.Enabled = true;
            ddlProjectTypeNewBP.Enabled = true;
            lbNewPermitFromUpdatePermit.Enabled = true;

            tbBPPaymentFeeNewNewPermit.Enabled = true;
            revtbBPPaymentFeeNewNewPermit.Enabled = true;
            tbBPPaymentMonthsNewNewPermit.Enabled = true;
            revBPPaymentMonthsNewNewPermit.Enabled = true;
            tbBPermitReviewDateNewNewPermit.Enabled = true;
            ceBPermitReviewDateNewNewPermit.Enabled = true;
            revBPermitReviewDateNewNewPermit.Enabled = true;
            tbBPermitActionDateNewNewPermit.Enabled = true;
            ceBPermitActionDateNewNewPermit.Enabled = true;
            revBPermitActionDateNewNewPermit.Enabled = true;
            tbBPermitLetterDateNewNewPermit.Enabled = true;
            ceBPermitLetterDateNewNewPermit.Enabled = true;
            revBPermitLetterDateNewNewPermit.Enabled = true;
            tbBPRLetterRefNewNewPermit.Enabled = true;
            tbBPRCommentsNewNewPermit.Enabled = true;

        }
        private void clearAllNewFormInputFieldsBP() {
            tbProjectNewBP.Text = "";
            tbContractorNewBP.Text = "";
            tbDelayNew.Text = "";
            tbIssuedNew.Text = "";
            tbClosedNew.Text = "";
            tbLotNameNewBP.Text = "";
            ddlLaneNewBP.SelectedIndex = 0;
            tbOwnersNameNewBP.Text = "";
            tbApplicantNameNewBP.Text = "";
            rbListPermitRequiredNew.SelectedIndex = -1;
            ddlContractorNew.SelectedIndex = -1;
            tbBPermitNbrNew.Text = "";
            tbBPPaymentFeeNewNewPermit.Text="";
            tbBPPaymentMonthsNewNewPermit.Text="";
            tbBPermitReviewDateNewNewPermit.Text="";
            tbBPermitActionDateNewNewPermit.Text="";
            tbBPermitLetterDateNewNewPermit.Text="";
            tbBPRLetterRefNewNewPermit.Text="";
            tbBPRCommentsNewNewPermit.Text = ""; ;

        }

        protected void lbBPermitNewPayment_Click(object sender, EventArgs args) {
            tbBPPaymentFeeNew.Text = "";
            tbBPPaymentMonthsNew.Text = "";
            mpeBPermitNewPayment.Show();
        }
        protected void lbBPermitNewReview_Click(object sender, EventArgs args) {
            tbBPermitReviewDateNew.Text = "";
            tbBPermitActionDateNew.Text = "";
            tbBPermitLetterDateNew.Text = "";
            tbBPRLetterRefNew.Text = "";
            tbBPRCommentsNew.Text = "";
            mpeBPermitNewReview.Show();
        }
        protected void btnProjectConditionsTrigger_Click(object sender, EventArgs args) {
            if (Utils.isNothing(Session["LastActiveTabIndex"])) {
                Session["LastActiveTabIndex"] = 0;
            }
            if (((int)Session["LastActiveTabIndex"]) == 2) {
                if (pnlNewBPermitContent.Visible) {
                    tbContractorUpdate.Text = tbContractorNewBP.Text;
                    tbApplicantNameUpdate.Text = tbApplicantNameNewBP.Text;
                    tbOwnersNameUpdate.Text = tbOwnersNameNewBP.Text;
                    tbLotNameUpdate.Text = tbLotNameNewBP.Text;
                    ddlLaneUpdate.SelectedIndex = ddlLaneNewBP.SelectedIndex;
                    ddlProjectTypeUpdate.SelectedIndex = ddlProjectTypeNewBP.SelectedIndex;
                    tbProjectUpdate.Text = tbProjectNewBP.Text;
                } else {
                    tbContractorUpdate.Text = tbContractorUpdateBP.Text;
                    tbApplicantNameUpdate.Text = tbApplicantNameUpdateBP.Text;
                    tbOwnersNameUpdate.Text = tbOwnersNameUpdateBP.Text;
                    tbLotNameUpdate.Text = tbLotNameUpdateBP.Text;
                    ddlLaneUpdate.SelectedIndex = ddlLaneUpdateBP.SelectedIndex;
                    ddlProjectTypeUpdate.SelectedIndex = ddlProjectTypeUpdateBP.SelectedIndex;
                    tbProjectUpdate.Text = tbProjectUpdateBP.Text;
                }
            } else {
                if (((int)Session["LastActiveTabIndex"]) == 0) {
                    tbContractorUpdateBP.Text = tbContractorUpdate.Text;
                    tbApplicantNameUpdateBP.Text = tbApplicantNameUpdate.Text;
                    tbOwnersNameUpdateBP.Text = tbOwnersNameUpdate.Text;
                    tbLotNameUpdateBP.Text = tbLotNameUpdate.Text;
                    ddlLaneUpdateBP.SelectedIndex = ddlLaneUpdate.SelectedIndex;
                    ddlProjectTypeUpdateBP.SelectedIndex = ddlProjectTypeUpdate.SelectedIndex;
                    tbProjectUpdateBP.Text = tbProjectUpdate.Text;
                    tbContractorNewBP.Text = tbContractorUpdate.Text;
                    tbApplicantNameNewBP.Text = tbApplicantNameUpdate.Text;
                    tbOwnersNameNewBP.Text = tbOwnersNameUpdate.Text;
                    tbLotNameNewBP.Text = tbLotNameUpdate.Text;
                    ddlLaneNewBP.SelectedIndex = ddlLaneUpdate.SelectedIndex;
                    ddlProjectTypeNewBP.SelectedIndex = ddlProjectTypeUpdate.SelectedIndex;
                    tbProjectNewBP.Text = tbProjectUpdate.Text;
                }
            }
            TabContainer1.ActiveTabIndex = 1;
        }
        protected void btnBPTabTrigger_Click(object sender, EventArgs args) {
            tbContractorUpdateBP.Text = tbContractorUpdate.Text;
            tbApplicantNameUpdateBP.Text = tbApplicantNameUpdate.Text;
            tbOwnersNameUpdateBP.Text = tbOwnersNameUpdate.Text;
            tbLotNameUpdateBP.Text = tbLotNameUpdate.Text;
            ddlLaneUpdateBP.SelectedIndex = ddlLaneUpdate.SelectedIndex;
            ddlProjectTypeUpdateBP.SelectedIndex = ddlProjectTypeUpdate.SelectedIndex;
            tbProjectUpdateBP.Text = tbProjectUpdate.Text;
            tbContractorNewBP.Text = tbContractorUpdate.Text;
            tbApplicantNameNewBP.Text = tbApplicantNameUpdate.Text;
            tbOwnersNameNewBP.Text = tbOwnersNameUpdate.Text;
            tbLotNameNewBP.Text = tbLotNameUpdate.Text;
            ddlLaneNewBP.SelectedIndex = ddlLaneUpdate.SelectedIndex;
            ddlProjectTypeNewBP.SelectedIndex = ddlProjectTypeUpdate.SelectedIndex;
            tbProjectNewBP.Text = tbProjectUpdate.Text;
            Session["LastActiveTabIndex"] = 2;
            TabContainer1.ActiveTabIndex = 2;
            if (Utils.isNothing(CurrentBPermitIdReally)) {
                pnlNewBPermitContent.Visible = true;
                pnlUpdateBPermitContent.Visible = false;
            } else {
                pnlNewBPermitContent.Visible = false;
                pnlUpdateBPermitContent.Visible = true;
            }

        }
        protected void btnMainTabTrigger_Click(object sender, EventArgs args) {
            if (pnlNewBPermitContent.Visible) {
                tbContractorUpdate.Text = tbContractorNewBP.Text;
                tbApplicantNameUpdate.Text = tbApplicantNameNewBP.Text;
                tbOwnersNameUpdate.Text = tbOwnersNameNewBP.Text;
                tbLotNameUpdate.Text = tbLotNameNewBP.Text;
                ddlLaneUpdate.SelectedIndex = ddlLaneNewBP.SelectedIndex;
                ddlProjectTypeUpdate.SelectedIndex = ddlProjectTypeNewBP.SelectedIndex;
                tbProjectUpdate.Text = tbProjectNewBP.Text;
            } else {
                tbContractorUpdate.Text = tbContractorUpdateBP.Text;
                tbApplicantNameUpdate.Text = tbApplicantNameUpdateBP.Text;
                tbOwnersNameUpdate.Text = tbOwnersNameUpdateBP.Text;
                tbLotNameUpdate.Text = tbLotNameUpdateBP.Text;
                ddlLaneUpdate.SelectedIndex = ddlLaneUpdateBP.SelectedIndex;
                ddlProjectTypeUpdate.SelectedIndex = ddlProjectTypeUpdateBP.SelectedIndex;
                tbProjectUpdate.Text = tbProjectUpdateBP.Text;
            }
            TabContainer1.ActiveTabIndex = 0;
            Session["LastActiveTabIndex"] = 0;
        }
        
    }
}