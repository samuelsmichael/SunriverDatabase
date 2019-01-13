using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Runtime.Caching;
using System.Data.SqlClient;

namespace SubmittalProposal {
    public partial class BPermit : AbstractDatabase, ICanHavePDFs {
        static DataTable dtBPayment = null;

        public static string BPERMIT_CACHE_KEY = "BPermitDS";
        public static string BPERMIT_CACHE_GRID_KEY = "BPermitDSGridView";
        protected override string UpdateRoleName {
            get { return "canupdatebpermits"; }
        }
        protected override Label getUpdateResultsLabel() {
            return lblBPermitUpdateResults;
        }

        private bool weveAlreadyGotABPermitId() {
            return Utils.isNothingNot(BPermitIDBeingEdited);
        }
        private bool thisBPermitNbrAlreadyExistsAndItsNotMe(string bPermitNbr) {
            string filter = " [BPermit#] ='" + bPermitNbr + "'";
            if (weveAlreadyGotABPermitId()) {
                filter += " AND BPermitId <> " + BPermitIDBeingEdited;
            }
            DataTable sourceTable = BPermit.BPermitDataSet().Tables["BPData"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = filter;
            DataTable tab = view.ToTable();
            return tab.Rows != null && tab.Rows.Count > 0;
        }
        private void doBPermitUpdate() {
            if (thisBPermitNbrAlreadyExistsAndItsNotMe(tbBPermitNbrUpdate.Text)) {
                throw new Exception("This bPermit# already exists in another BPermit.");
            }
            SqlCommand cmd = new SqlCommand("uspProjectAndSubmittalUpdate");
            cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameUpdate.Text;
            cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameUpdate.Text;
            cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneUpdate.SelectedValue;
            cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameUpdate.Text;
            cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorUpdate.Text;
            cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeUpdate.SelectedValue;
            int? contractorId = ddlContractorUpdate.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlContractorUpdate.SelectedValue);
            cmd.Parameters.Add("@fkSRContrRegID", SqlDbType.Int).Value = contractorId;
            cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectUpdate.Text;
            cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = BPermitIDBeingEdited;
            cmd.Parameters.Add("@BPermitReqd", SqlDbType.Bit).Value = rbListPermitRequiredUpdate.SelectedValue == "Yes" ? true : false;
            DateTime? issuedDate =
                tbIssuedUpdate.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbIssuedUpdate.Text);
            cmd.Parameters.Add("@BPIssueDate", SqlDbType.DateTime).Value = issuedDate;
            DateTime? closeDate =
                tbClosedUpdate.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbClosedUpdate.Text);
            cmd.Parameters.Add("@BPClosed", SqlDbType.DateTime).Value = closeDate;
            cmd.Parameters.Add("@BPDelay", SqlDbType.NVarChar).Value = tbDelayUpdate.Text;
            cmd.Parameters.Add("@SubmittalId", SqlDbType.Int).Value = SubmittalIDBeingEdited;
            cmd.Parameters.Add("@BPermit#", SqlDbType.NVarChar).Value = tbBPermitNbrUpdate.Text;
            SqlParameter newBPermitId = new SqlParameter("@NewBPermitID", SqlDbType.Int);
            newBPermitId.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(newBPermitId);
            SqlParameter newSubmittalId = new SqlParameter("@NewSubmittalID", SqlDbType.Int);
            newSubmittalId.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(newSubmittalId);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);

        }
        protected void btnBPermitUpdate_Click(object sender, EventArgs e) {
            bool jdPageIsValid=true;
/* this seems to make it so the Submit button has to be clicked twice            foreach (BaseValidator validator in Page.Validators) {
                if (validator.Enabled && !validator.IsValid) {
                    // Put a breakpoint here
                    string clientID = validator.ClientID;
                    if(clientID.IndexOf("cvBPermitNbrUpdate")!=-1) {
                        jdPageIsValid=false;
                    }
                }
            }
 */
            if (jdPageIsValid) {
                try {
                    doBPermitUpdate();
                    performPostUpdateSuccessfulActions("Update successful", BPERMIT_CACHE_KEY, BPERMIT_CACHE_GRID_KEY);
                } catch (Exception ee) {
                    performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
                }
            }
        }

        protected void cvBPermitNbr_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            if (Utils.isNothing(args.Value)) {
                args.IsValid = false;
            }
        }
        protected override Label getNewResultsLabel() {
            return lblBPermitNewResults;
        }

        public static DataSet BPermitDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = BPERMIT_CACHE_KEY;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspBPermitTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                ds.Tables[0].TableName = "BPData";
                ds.Tables[1].TableName = "BPPayment";
                dtBPayment = ds.Tables[1];
                ds.Tables[2].TableName = "BPReviews";
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
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
            DataTable sourceTableReviews = BPermitDataSet().Tables["BPReviews"];
            DataView viewReviews = new DataView(sourceTableReviews);
            viewReviews.RowFilter = "fkBPermitID_PR=" + bPermitId;
            DataTable tblFilteredReviews = viewReviews.ToTable();
            gvReviews.DataSource = tblFilteredReviews;
            gvReviews.DataBind();

        }
        private void bind_gvPayments(int bPermitId) {
            DataTable sourceTablePayments = BPermitDataSet().Tables["BPPayment"];
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
        private int BPermitIDBeingEdited {
            get {
                object obj = ViewState["BPermitIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                ViewState["BPermitIDBeingEdited"] = value;
            }
        }
        private int? SubmittalIDBeingEdited {
            get {
                object obj = ViewState["SubmittalIDBeingEdited"];
                return obj == null ? (int?)null : (int)obj;
            }
            set {
                ViewState["SubmittalIDBeingEdited"] = value;
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            BPermitIDBeingEdited = Convert.ToInt32(gvResults.DataKeys[row.RowIndex].Value);
            bind_gvPayments(BPermitIDBeingEdited);

            DataTable sourceTable = getGridViewDataTable();
            
            DataView view = new DataView(sourceTable);

            view.RowFilter = "BPermitId=" + BPermitIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];

            tbDelayUpdate.Text = Utils.ObjectToString(dr["BPDelay"]);
            DateTime? issueDate = Utils.ObjectToDateTimeNullable(dr["BPIssueDate"]);
            tbIssuedUpdate.Text = issueDate.HasValue ? issueDate.Value.ToString("MM/dd/yyyy") : "";
            Object expires=dr["BPExpires"];
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
            tbClosedUpdate.Text = closed.HasValue?closed.Value.ToString("MM/dd/yyyy"):"";
            if (Utils.ObjectToBool(dr["BPermitReqd"])) {
                rbListPermitRequiredUpdate.SelectedValue = "Yes";
            } else {
                rbListPermitRequiredUpdate.SelectedValue = "No";
            }
            tbApplicantNameUpdate.Text = Utils.ObjectToString(dr["Applicant"]);
            tbOwnersNameUpdate.Text = Utils.ObjectToString(dr["OwnersName"]);
            tbContractorUpdate.Text = Utils.ObjectToString(dr["Contractor"]);
            ddlProjectTypeUpdate.SelectedValue = Utils.ObjectToString(dr["ProjectType"]);
            tbProjectUpdate.Text = Utils.ObjectToString(dr["Project"]);
            tbLotNameUpdate.Text = Utils.ObjectToString(dr["Lot"]);
            if (ddlLaneUpdate.Items.FindByText(Utils.ObjectToString(dr["Lane"])) == null) {
                ddlLaneUpdate.Items.Add(new ListItem(Utils.ObjectToString(dr["Lane"]), Utils.ObjectToString(dr["Lane"])));
            }
            ddlLaneUpdate.SelectedValue = Utils.ObjectToString(dr["Lane"]);
            SetLaneLotForPDFs(ddlLaneUpdate.SelectedValue + " " + tbLotNameUpdate.Text);

            ddlContractorUpdate.SelectedValue = Utils.ObjectToString(Utils.ObjectToInt(dr["fkSRContrRegID"]));

            bind_gvReviews(BPermitIDBeingEdited);
            int? submittalId = getSubmittalId(dr);
            SubmittalIDBeingEdited = submittalId;
            tbBPermitNbrUpdate.Text = Utils.ObjectToString(dr["BPermit#"]);
            return "Lot\\Lane: " + getLotLane(dr) + "  Submittal Id: " + (submittalId.HasValue?Convert.ToString(submittalId.Value):"") + "  BPermit# :" + tbBPermitNbrUpdate.Text + " Owner: " + getOwner(dr);

        }
        public System.Drawing.Color getForeColorForExpireDate(Object BPExpiresObject) {
            string color="Black";
            try {
                if (DateTime.Today > Convert.ToDateTime(BPExpiresObject)) {
                    color = "Red";
                }
            } catch {}
            return System.Drawing.Color.FromName(color);
        }

        private int? getSubmittalId(DataRow dr) {
            return Utils.ObjectToIntNullable(dr["fkSubmittalID_PD"]);
        }
        private int getBPermitId(DataRow dr) {
            return (int)dr["fkBPermitID_PR"];
        }
        private string getLotLane(DataRow dr) {
            return Utils.ObjectToString(dr["Lot"]) + "\\" + Utils.ObjectToString(dr["Lane"]);
        }
        private string getOwner(DataRow dr) {
            return Utils.ObjectToString(dr["OwnersName"]);
        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbOwner.Text)) {
                sb.Append(prepend + "Owner: " + tbOwner.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbOwner.Text,"OwnersName"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbApplicant.Text)) {
                sb.Append(prepend + "Applicant: " + tbApplicant.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbApplicant.Text,"Applicant"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " Lot = '" + tbLot.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " Lane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbSubmittalId.Text)) {
                sb.Append(prepend + "Submittal Id: " + tbSubmittalId.Text);
                prepend = "  ";
                sbFilter.Append(and + " fkSubmittalID_PD = " + tbSubmittalId.Text);
                and = " and ";
            }

            if (Utils.isNothingNot(tbBPermitId.Text)) {
                sb.Append(prepend + "BPermitId Id: " + tbBPermitId.Text);
                prepend = "  ";
                sbFilter.Append(and + " BPermitId = " + tbBPermitId.Text);
                and = " and ";
            }
            if (Utils.isNothingNot(tbBPermitNbr.Text)) {
                sb.Append(prepend + "BPermit#: " + tbBPermitNbr.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbBPermitNbr.Text, "[BPermit#]"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbDelaySearch.Text)) {
                sb.Append(prepend + "Delay: " + tbDelaySearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbDelaySearch.Text,"BPDelay"));
                and = " and ";
            }

            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();

        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override System.Data.DataSet buildDataSet() {
            return BPermitDataSet();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            hfAutoShowPopupNew.Value = "n";
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
                ddlLaneUpdate.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneUpdate.DataBind();
                ddlLaneNew.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneNew.DataBind();
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
 //           Response.Write("Session[\"ShowBPermitID\"]" + "\n");
   //         Response.Write(Session["ShowBPermitID"] + "\n");
            if (Common.Utils.isNothingNot(Session["ShowBPermitID"])) {
                tbOwner.Text = "";
                tbApplicant.Text = "";
                tbLot.Text = "";
                tbSubmittalId.Text = "";
                ddlLane.SelectedIndex = 0;
                tbDelaySearch.Text = "";
                
                tbBPermitId.Text = Utils.ObjectToString(Session["ShowBPermitID"]);
                Session["ShowBPermitID"] = null;
                ((Database)Master).doGo();
                gvResults.SelectRow(0);
            } else {
                String gotoSubmittalId = Utils.ObjectToString(Session["ShowSubmittalID"]);
                if (Common.Utils.isNothingNot(gotoSubmittalId)) {
                    Session["ShowSubmittalID"] = null;
                    hfAutoShowPopupNew.Value = "y";
                    DataSet ds = Submittal2.SunriverDataSet();
                    DataTable sourceTable = ds.Tables[0];
                    DataView view = new DataView(sourceTable);
                    view.RowFilter = "SubmittalId=" + gotoSubmittalId;
                    DataTable tblFiltered = view.ToTable();
                    DataRow dr = tblFiltered.Rows[0];
                    clearAllSelectionInputFields();
                    tbSubmittalIdNew.Text = Utils.ObjectToString(dr["SubmittalId"]);
                    tbSubmittalIdNew.Enabled = false;
                    tbLotNameNew.Text = Utils.ObjectToString(dr["Lot"]);
                    ddlLaneNew.SelectedValue = Utils.ObjectToString(dr["Lane"]);
                    tbOwnersNameNew.Text = Utils.ObjectToString(dr["Own_Name"]);
                    tbApplicantNameNew.Text = Utils.ObjectToString(dr["Applicant"]);

                    tbContractorNew.Text = Utils.ObjectToString(dr["Contractor"]);
                    ddlProjectTypeNew.SelectedValue = Utils.ObjectToString(dr["ProjectType"]);
                    tbProjectNew.Text = Utils.ObjectToString(dr["Project"]);
                    
                }
            }
        }
        protected override void clearAllSelectionInputFields() {
            tbOwner.Text = "";
            tbApplicant.Text = "";
            tbLot.Text = "";
            ddlLane.SelectedIndex = 0;
            tbSubmittalId.Text = "";
            tbBPermitNbr.Text = "";
            tbDelaySearch.Text = "";
        }
        protected override void clearAllNewFormInputFields() {
            tbProjectNew.Text = "";
            tbContractorNew.Text = "";
            tbDelayNew.Text = "";
            tbIssuedNew.Text = "";
            tbSubmittalIdNew.Text = "";
            tbLotNameNew.Text = "";
            ddlLaneNew.SelectedIndex = 0;
            tbOwnersNameNew.Text = "";
            tbApplicantNameNew.Text = "";
            tbBPPaymentFeeNewNewPermit.Text = "";
            tbBPPaymentMonthsNewNewPermit.Text = "";
            tbBPermitReviewDateNewNewPermit.Text = "";
            tbBPermitActionDateNewNewPermit.Text = "";
            tbBPermitLetterDateNewNewPermit.Text = "";
            tbBPRLetterRefNewNewPermit.Text = "";
            tbBPRCommentsNewNewPermit.Text = ""; ;


        }
        public static DataTable BPermitsGetGridViewDataTable() {
            return new BPermit().getGridViewDataTable();
        }
        protected override DataTable getGridViewDataTable() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = BPERMIT_CACHE_GRID_KEY;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspBPermitDataGridViewDataGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds.Tables[0];
        }
        protected void btnNewBPermitOk_Click(object sender, EventArgs e) {
            bool jdPageIsValid=true;
            /* causes submit button to be clicked twice? foreach (BaseValidator validator in Page.Validators) {
                if (validator.Enabled && !validator.IsValid) {
                    // Put a breakpoint here
                    string clientID = validator.ClientID;
                    if (clientID.IndexOf("cvBPermitNbrNew") != -1) {
                        jdPageIsValid = false;
                    }
                }
            }*/
            if (jdPageIsValid) {
                try {
                    if (thisBPermitNbrAlreadyExistsAndItsNotMe(tbBPermitNbrNew.Text)) {
                        throw new Exception("This bPermit# already exists in another BPermit.");
                    }

                    SqlCommand cmd = new SqlCommand("uspProjectAndSubmittalUpdate");
                    cmd.Parameters.Add("@Own_Name", SqlDbType.NVarChar).Value = tbOwnersNameNew.Text;
                    cmd.Parameters.Add("@Lot", SqlDbType.NVarChar).Value = tbLotNameNew.Text;
                    cmd.Parameters.Add("@Lane", SqlDbType.NVarChar).Value = ddlLaneNew.SelectedValue;
                    cmd.Parameters.Add("@Applicant", SqlDbType.NVarChar).Value = tbApplicantNameNew.Text;
                    cmd.Parameters.Add("@Contractor", SqlDbType.NVarChar).Value = tbContractorNew.Text;
                    cmd.Parameters.Add("@ProjectType", SqlDbType.NVarChar).Value = ddlProjectTypeNew.SelectedValue;
                    cmd.Parameters.Add("@Project", SqlDbType.NVarChar).Value = tbProjectNew.Text;
                    cmd.Parameters.Add("@BPermitReqd", SqlDbType.Bit).Value = rbListPermitRequiredNew.SelectedValue == "Yes" ? true : false;
                    DateTime? issuedDate =
                        tbIssuedNew.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbIssuedNew.Text);
                    cmd.Parameters.Add("@BPIssueDate", SqlDbType.DateTime).Value = issuedDate;
                    DateTime? closeDate =
                        tbClosedNew.Text == "" ? (DateTime?)null : Convert.ToDateTime(tbClosedNew.Text);
                    cmd.Parameters.Add("@BPClosed", SqlDbType.DateTime).Value = closeDate;
                    cmd.Parameters.Add("@BPDelay", SqlDbType.NVarChar).Value = tbDelayNew.Text;
                    cmd.Parameters.Add("@SubmittalId", SqlDbType.Int).Value = tbSubmittalIdNew.Text;
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
                        if (Utils.isNothingNot(tbBPermitReviewDateNewNewPermit.Text)) {
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




                    performPostNewSuccessfulActions("BPermit added successfully", BPERMIT_CACHE_KEY, BPERMIT_CACHE_GRID_KEY, tbBPermitNbr, tbBPermitNbrNew.Text);
                    mpeNewBPermit.Hide();
                } catch (Exception e2) {
                    performPostNewFailedActions("BPermit not added. Msg: " + e2.Message);
                }
            } else {
                mpeNewBPermit.Show();
            }
        }
        protected void btnNewBPermitCancel_Click(object sender, EventArgs e) {
            hfAutoShowPopupNew.Value = "n";
            mpeBPermitNewPayment.Hide();
            clearAllSelectionInputFields();
            clearAllNewFormInputFields();
        }
        protected void btnNewBPermitPaymentOk_Click(object sender, EventArgs e) {
            try {
                doBPermitUpdate();
                SqlCommand cmd = new SqlCommand("uspPaymentsUpdate");
                cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = BPermitIDBeingEdited;
                int? months = tbBPPaymentMonthsNew.Text.Trim() == "" ? (int?)null : Utils.ObjectToInt(tbBPPaymentMonthsNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@BPMonths", SqlDbType.Int).Value = months;
                decimal? fee = tbBPPaymentFeeNew.Text.Trim() == "" ? (decimal?)null : Utils.ObjectToDecimal(tbBPPaymentFeeNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@BPFee", SqlDbType.Money).Value = fee;
                SqlParameter newid = new SqlParameter("@NewBPPaymentID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Payment added", "BPermitDS", "BPermitDSGridView");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Payment not added. Error msg: " + ee.Message);
            }
        }
        protected void btnNewBPermitReviewOk_Click(object sender, EventArgs args) {
            try {
                doBPermitUpdate();
                SqlCommand cmd = new SqlCommand("uspReviewsUpdate");
                cmd.Parameters.Add("@BPermitId", SqlDbType.Int).Value = BPermitIDBeingEdited;
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
            } catch (Exception ee) {
                performPostUpdateFailedActions("Review not added. Error msg: " + ee.Message);
            }
        }

        protected void gvPayments_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvPayments.EditIndex= e.NewEditIndex;
            //Bind data to the GridView control.
            bind_gvPayments(BPermitIDBeingEdited);
        }

        protected void gvPayments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvPayments.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvPayments(BPermitIDBeingEdited);
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


                performPostUpdateSuccessfulActions("Payment updated", LRFDVehicleMaintenance.LRFD_VEHICLE_MAINTENANCE_CACHE_KEY, LRFDVehicleMaintenance.LRFD_SurchargeRate_CACHE_KEY);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Payment not updated. Error msg: " + ee.Message);
            }
            //Reset the edit index.
            gvPayments.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvPayments(BPermitIDBeingEdited);
        }

        protected void gvReviews_RowEditing(object sender, GridViewEditEventArgs e) {
            gvReviews.EditIndex = e.NewEditIndex;
            bind_gvReviews(BPermitIDBeingEdited);

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
                } catch (Exception ee) {
                    performPostUpdateFailedActions("Review not updated. Error msg: " + ee.Message);
                }

            gvReviews.EditIndex = -1;
            bind_gvReviews(BPermitIDBeingEdited);
        }

        protected void gvReviews_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvReviews.EditIndex = -1;
            bind_gvReviews(BPermitIDBeingEdited);
        }
        
        protected override void lockYourUpdateFields() {
            tbDelayUpdate.Enabled = false;
            tbIssuedUpdate.Enabled = false;
            tbClosedUpdate.Enabled = false;
            rbListPermitRequiredUpdate.Enabled = false;
            tbLotNameUpdate.Enabled = false;
            ddlLaneUpdate.Enabled = false;
            tbOwnersNameUpdate.Enabled = false;
            tbApplicantNameUpdate.Enabled = false;
            tbContractorUpdate.Enabled = false;
            tbProjectUpdate.Enabled = false;
            ddlProjectTypeUpdate.Enabled = false;
            btnBPermitUpdate.Enabled = false;
            gvPayments.Enabled = false;
            gvReviews.Enabled = false;
            ibIssuedUpdate.Enabled = false;
            ibClosedUpdate.Enabled = false;
            lbBPermitNewPayment.Enabled = false;
            lbBPermitNewReview2.Enabled = false;
            ddlContractorUpdate.Enabled = false;
            tbBPermitNbrUpdate.Enabled = false;
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
        protected override void unlockYourUpdateFields() {
            tbDelayUpdate.Enabled = true;
            tbIssuedUpdate.Enabled = true;
            tbClosedUpdate.Enabled = true;
            rbListPermitRequiredUpdate.Enabled = true;
            tbLotNameUpdate.Enabled = true;
            ddlLaneUpdate.Enabled = true;
            tbOwnersNameUpdate.Enabled = true;
            tbApplicantNameUpdate.Enabled = true;
            tbContractorUpdate.Enabled = true;
            tbProjectUpdate.Enabled = true;
            ddlProjectTypeUpdate.Enabled = true;
            btnBPermitUpdate.Enabled = true;
            gvPayments.Enabled = true;
            gvReviews.Enabled = true;
            ibIssuedUpdate.Enabled = true;
            ibClosedUpdate.Enabled = true;
            lbBPermitNewPayment.Enabled = true;
            lbBPermitNewReview2.Enabled = true;
            ddlContractorUpdate.Enabled = true;
            tbBPermitNbrUpdate.Enabled = true;
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        public static string MyMenuName = "BPermit";
        protected override string childMenuName {
            get { return MyMenuName; }
        }

        public bool HasPropertyAvailable {
            get { return Utils.isNothingNot(BPermitIDBeingEdited); }
        }

        public void SetLaneLotForPDFs(string lanelot) {
            LaneLotForPDFs = lanelot;
        }

    }
    public static class CustomLINQtoDataSetMethods {
        public static DataTable CopyToDataTable<T>(this IEnumerable<T> source) {
            return new ObjectShredder<T>().Shred(source, null, null);
        }

        public static DataTable CopyToDataTable<T>(this IEnumerable<T> source,
                                                    DataTable table, LoadOption? options) {
            return new ObjectShredder<T>().Shred(source, table, options);
        }
    }
}