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
using System.Text;

namespace SubmittalProposal {
    public partial class Citations : AbstractDatabase {
        public static string DataSetCacheKey = "CIDATASETCACHEKEY";
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["CitationsSQLConnectionString"].ConnectionString;
            }
        }
        public static DataSet CIDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = DataSetCacheKey;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspCitationsTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["CitationID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["ViolationID"] };
                ds.Tables[3].PrimaryKey = new DataColumn[] { ds.Tables[3].Columns["RuleID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }
        protected override System.Data.DataSet buildDataSet() {
            return CIDataSet();
        }
        private void bindDDLs() {
            DataTable dtFineStatus = CIDataSet().Tables[2].Copy();
            DataRow row=dtFineStatus.NewRow();
            row["FineStatus"] = "";
            dtFineStatus.Rows.InsertAt(row,0);
            ddlFineStatusLU.DataSource = dtFineStatus;
            ddlFineStatusLU.DataBind();
            DataTable dtSunriverStatus = CIDataSet().Tables[4].Copy();
            DataRow rowSunriverStatus = dtSunriverStatus.NewRow();
            rowSunriverStatus["SunriverStatus"] = "";
            dtSunriverStatus.Rows.InsertAt(rowSunriverStatus,0);
            ddlSunriverStatusUpdate.DataSource=dtSunriverStatus;
            ddlSunriverStatusUpdate.DataBind();
            ddlSunriverStatusNew.DataSource = dtSunriverStatus;
            ddlSunriverStatusNew.DataBind();
            ddlCitationsFineStatusUpdate.DataSource = dtFineStatus;
            ddlCitationsFineStatusUpdate.DataBind();
            ddlCitationsFineStatusNew.DataSource = dtFineStatus;
            ddlCitationsFineStatusNew.DataBind();
            DataTable dtRules = getRulesTable();
            ddlRulesNew.DataSource = dtRules;
            ddlRulesNew.SelectedIndex = -1;
            ddlRulesNew.DataBind();
            ddlRulesNewNewCit.DataSource = dtRules;
            ddlRulesNewNewCit.SelectedIndex = -1;
            ddlRulesNewNewCit.DataBind();


        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                bindDDLs();
                try { // In this framework, if UpdateRoleName throws an exception, then this means that the database isn't updatable (yet).
                    if (UpdateRoleName == "all" || HttpContext.Current.User.IsInRole(UpdateRoleName)) {
                        lbNewCitation.Visible = true;
                    } else {
                        lbNewCitation.Visible = false;
                    }
                } catch {
                    lbNewCitation.Visible = false;
                }
            }
            if (Common.Utils.isNothingNot(Session["ShowCitationsID"])) {
                tbCitationIDLU.Text = Utils.ObjectToString(Session["ShowCitationsID"]);
                tbCitationLastNameLU.Text = "";
                ddlFineStatusLU.SelectedIndex = -1;
                Session["ShowCitationsID"] = null;
                ((Database)Master).doGo();
                gvResults.SelectRow(0);
            }
        }
        protected override void clearAllNewFormInputFields() {
            ddlCitationsFineStatusNew.SelectedIndex = 0;
            ddlSunriverStatusNew.SelectedIndex = 0;
            tbCitationsLastNameNew.Text = "";
            tbCitingOfficerNew.Text = "";
            tbHearingDateNew.Text = "";
            tbCitationsFirstNameNew.Text = "";
            tbCitationsAddress1New.Text = "";
            tbCitationsAddress2New.Text = "";
            tbCitationsCityNew.Text = "";
            tbCitationsStateNew.Text = "";
            tbCitationsZipNew.Text = "";
            tbCitationsViolationsDateNew.Text = "";
            tbCitationsViolationsLocationNew.Text = "";
            tbMagistrateFineNew.Text = "";
            tbToAccountingNew.Text = "";
            tbJudicialFineNew.Text = "";
            tbWriteoffAmountNew.Text = "";
            tbAssessedFineNew.Text = "";
            tbMagistrateNotesNew.Text = "";
            tbCitationNbrNew.Text = "";
            ddlRulesNewNewCit.SelectedIndex = -1;
            tbScheduleFineNewNewCit.Text = "";
            tbORSNumberNewNewCit.Text = "";
            cbIssueAsWarningNewNewCit.Checked = false;
            tbViolationNotesNewNewCit.Text = "";
            ddlCitationsFineStatusNew.SelectedIndex = 1;
        }
        protected override void clearAllSelectionInputFields() {
            tbCitationLastNameLU.Text = "";
            ddlFineStatusLU.SelectedIndex = 0;
            tbCitationIDLU.Text = "";
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return CIDataSet().Tables[0];
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override Label getNewResultsLabel() {
            return lblCitationNewMessage;
        }
        private int CitationsIDBeingEdited {
            get {
                object obj = Session["CitationsIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["CitationsIDBeingEdited"] = value;
            }
        }
        private DateTime? getViolationDate(DataRow dr) {
            try {
                return (DateTime?)dr["OffenseDate"];
            } catch {
                return (DateTime?)null;
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            try {
                GridViewRow row = gvResults.SelectedRow;
                CitationsIDBeingEdited = Convert.ToInt32(gvResults.DataKeys[row.RowIndex].Value);
                DataTable sourceTable = getGridViewDataTable();
                DataView view = new DataView(sourceTable);
                view.RowFilter = "CitationID=" + CitationsIDBeingEdited;
                DataTable tblFiltered = view.ToTable();
                Session["CitationsTblFiltered"] = tblFiltered;
                DataRow dr = tblFiltered.Rows[0];
                tbCitationsLastNameUpdate.Text = Utils.ObjectToString(dr["VLastName"]);
                tbCitationsFirstNameUpdate.Text = Utils.ObjectToString(dr["VFirstName"]);
                tbCitationsAddress1Update.Text = Utils.ObjectToString(dr["VMailAddr1"]);
                tbCitationsAddress2Update.Text = Utils.ObjectToString(dr["VMailAddr2"]);
                tbCitationsCityUpdate.Text = Utils.ObjectToString(dr["VCity"]);
                tbCitationsStateUpdate.Text = Utils.ObjectToString(dr["VState"]);
                tbCitationsZipUpdate.Text = Utils.ObjectToString(dr["VZip"]);
                tbCitingOfficerUpdate.Text = Utils.ObjectToString(dr["CitingOfficer"]);
                tbMagistrateFineUpdate.Text = Utils.ObjectToDecimal0IfNull(dr["MagistrateFine"]).ToString("c");
                tbToAccountingUpdate.Text = Utils.ObjectToDecimal0IfNull(dr["FineBalToAcctg"]).ToString("c");
                tbJudicialFineUpdate.Text = Utils.ObjectToDecimal0IfNull(dr["JudicialFine"]).ToString("c");
                tbWriteoffAmountUpdate.Text = Utils.ObjectToDecimal0IfNull(dr["WriteOff"]).ToString("c");
                tbAssessedFineUpdate.Text = Utils.ObjectToDecimal0IfNull(dr["AssessedFine"]).ToString("c");
                tbMagistrateNotesUpdate.Text = Utils.ObjectToString(dr["MagistrateNotes"]);
                DateTime? hearingDate = Utils.ObjectToDateTimeNullable(dr["HearingDate"]);
                tbHearingDateUpdate.Text = hearingDate.HasValue ? hearingDate.Value.ToString("d") : "";
                string sunriverStatus = Utils.ObjectToString(dr["VSunriverStatus"]);
                ddlSunriverStatusUpdate.SelectedValue = sunriverStatus;
                DateTime? violationDate = getViolationDate(dr);
                tbCitationsViolationsDateUpdate.Text = violationDate.HasValue ? violationDate.Value.ToString("MM/dd/yyyy") : "";
                tbCitationsViolationsLocationUpdate.Text = Utils.ObjectToString(dr["OffenseLocation"]);
                ddlCitationsFineStatusUpdate.SelectedValue = Utils.ObjectToString(dr["FineStatus"]);
                string citationNbr = Utils.ObjectToString(dr["Citation#"]);
                Session["Citation#Current"] = citationNbr;
                tbCitationNbrUpdate.Text = citationNbr.Trim();
                bind_gvViolations();
                // this statement must be after the bind_gvViolations() statement, above.
                tbTotalCitationFineUpdate.Text = YetAnotherSumFine.ToString("c");
                tbPrepayAmount.Text = Math.Round((YetAnotherSumFine / 2), 2).ToString("c");

                object dateFormPrinted = Utils.ObjectToString(dr["DateFormPrinted"]);
                if (Utils.isNothingNot(dateFormPrinted)) {
                    lblDatePrinted.Text = dateFormPrinted.ToString();
                }
                return "Last name: " + Utils.ObjectToString(dr["VLastName"]) + "nbsp;nbsp;nbsp;First name: " + Utils.ObjectToString(dr["VFirstName"]) + "     Citation#: " + citationNbr;
            } catch {
                return "";
            }
        }

        private DataTable CurrentViolationsTable {
            get {
                return (DataTable)Session["CurrentViolationsTable"];
            }
            set {
                Session["CurrentViolationsTable"] = value;
            }
        }
        private decimal YetAnotherSumFine {
            get {
                return Utils.ObjectToDecimal0IfNull(Session["YetAnotherSumFine"]);
            }
            set {
                Session["YetAnotherSumFine"] = value;
            }
        }
        private void bind_gvViolations() {
            DataTable sourceTableViolations = CIDataSet().Tables[1];
            DataView viewViolations = new DataView(sourceTableViolations);
            viewViolations.RowFilter = "fkCitationID=" + CitationsIDBeingEdited;
            CurrentViolationsTable = viewViolations.ToTable();
            gvViolations.DataSource = CurrentViolationsTable;
            gvViolations.DataBind();
            YetAnotherSumFine = 0;
            foreach (DataRow dr in CurrentViolationsTable.Rows) {
                YetAnotherSumFine += Utils.ObjectToDecimal0IfNull(dr["ScheduleFine"]);
            }
        }

        protected void btnPrintForm_OnClick(object sender, EventArgs args) {
            SqlCommand cmd = new SqlCommand("uspCitationsDateFormPrintedUpdate");
            cmd.Parameters.Add("@CitationID", SqlDbType.Int).Value = CitationsIDBeingEdited;
            Utils.executeNonQuery(cmd, ConnectionString);
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            lblDatePrinted.Text = DateTime.Now.ToString();
        }

        protected override Label getUpdateResultsLabel() {
            return lblCitationsUpdateResults;
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";

            if (Utils.isNothingNot(tbCitationLastNameLU.Text)) {
                sb.Append(prepend + "Last name: " + tbCitationLastNameLU.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbCitationLastNameLU.Text, "VLastName"));
                and = " and ";
            }

            if (Utils.isNothingNot(ddlFineStatusLU.SelectedValue) && ddlFineStatusLU.SelectedValue.ToLower() != "") {
                sb.Append(prepend + "Fine status: " + ddlFineStatusLU.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " FineStatus = '" + ddlFineStatusLU.SelectedValue + "'");
                and = " and ";
            }

            if (Utils.isNothingNot(tbCitationIDLU.Text)) {
                sb.Append(prepend + "Citation#: " + tbCitationIDLU.Text);
                prepend = "  ";
                sbFilter.Append(and + " [Citation#] = '" + tbCitationIDLU.Text + "'");
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }
        protected override void lockYourUpdateFields() {
            btnCitationsUpdate.Visible = false;
            tbCitationsLastNameUpdate.Enabled = false;
            tbCitationsFirstNameUpdate.Enabled = false;
            tbCitationsAddress1Update.Enabled = false;
            tbCitationsAddress2Update.Enabled = false;
            tbCitationsCityUpdate.Enabled = false;
            tbCitationsStateUpdate.Enabled = false;
            tbCitationsZipUpdate.Enabled = false;
            ddlSunriverStatusUpdate.Enabled = false;
            tbCitationsViolationsDateUpdate.Enabled=false;
            tbCitationsViolationsLocationUpdate.Enabled = false;
            ibCitationsViolationsDateUpdate.Enabled = false;
            gvViolations.Enabled = false;
            ddlCitationsFineStatusUpdate.Enabled = false;
            tbCitingOfficerUpdate.Enabled = false;
            tbHearingDateUpdate.Enabled = false;
            tbMagistrateFineUpdate.Enabled = false;
            tbToAccountingUpdate.Enabled = false;
            tbJudicialFineUpdate.Enabled = false;
            tbWriteoffAmountUpdate.Enabled = false;
            tbAssessedFineUpdate.Enabled = false;
            tbMagistrateNotesUpdate.Enabled = false;
            ibHearingDateUpdate.Enabled = false;
            lbNewViolation.Enabled = false;
            tbCitationNbrUpdate.Enabled = false;
        }

        protected override void unlockYourUpdateFields() {
            btnCitationsUpdate.Visible=true;
            tbCitationsLastNameUpdate.Enabled = true;
            tbCitationsFirstNameUpdate.Enabled = true;
            tbCitationsAddress1Update.Enabled = true;
            tbCitationsAddress2Update.Enabled = true;
            tbCitationsCityUpdate.Enabled = true;
            tbCitationsStateUpdate.Enabled = true;
            tbCitationsZipUpdate.Enabled = true;
            ddlSunriverStatusUpdate.Enabled = true;
            tbCitationsViolationsDateUpdate.Enabled = true;
            tbCitationsViolationsLocationUpdate.Enabled = true;
            ibCitationsViolationsDateUpdate.Enabled = true;
            gvViolations.Enabled = true;
            ddlCitationsFineStatusUpdate.Enabled = true;
            tbCitingOfficerUpdate.Enabled = true;
            tbHearingDateUpdate.Enabled = true;
            tbMagistrateFineUpdate.Enabled = true;
            tbToAccountingUpdate.Enabled = true;
            tbJudicialFineUpdate.Enabled = true;
            tbWriteoffAmountUpdate.Enabled = true;
            tbAssessedFineUpdate.Enabled = true;
            tbMagistrateNotesUpdate.Enabled = true;
            getUpdateResultsLabel().Text = "";
            ibHearingDateUpdate.Enabled = true;
            lbNewViolation.Enabled = true;
            tbCitationNbrUpdate.Enabled = true;
        }
        protected override string UpdateRoleName {
            get { return "canupdatecitations"; }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        protected void btnCitationsUpdateOkay_Click(object sender, EventArgs args) {
            try {
                if (Page.IsValid) {
                    SqlCommand cmd = new SqlCommand("uspCitationsUpdate");
                    cmd.Parameters.Add("@CitationID", SqlDbType.Int).Value = CitationsIDBeingEdited;
                    cmd.Parameters.Add("@VLastName", SqlDbType.NVarChar).Value = tbCitationsLastNameUpdate.Text;
                    cmd.Parameters.Add("@VFirstName", SqlDbType.NVarChar).Value = tbCitationsFirstNameUpdate.Text;
                    cmd.Parameters.Add("@VMailAddr1", SqlDbType.NVarChar).Value = tbCitationsAddress1Update.Text;
                    cmd.Parameters.Add("@VMailAddr2", SqlDbType.NVarChar).Value = tbCitationsAddress2Update.Text;
                    cmd.Parameters.Add("@VCity", SqlDbType.NVarChar).Value = tbCitationsCityUpdate.Text;
                    cmd.Parameters.Add("@VZip", SqlDbType.NVarChar).Value = tbCitationsZipUpdate.Text;
                    cmd.Parameters.Add("@VState", SqlDbType.NVarChar).Value = tbCitationsStateUpdate.Text;
                    cmd.Parameters.Add("@VSunriverStatus", SqlDbType.NVarChar).Value = ddlSunriverStatusUpdate.SelectedValue;
                    cmd.Parameters.Add("@Citation#", SqlDbType.NVarChar).Value = tbCitationNbrUpdate.Text;
                    DateTime? offenseDate = Utils.ObjectToDateTimeNullable(tbCitationsViolationsDateUpdate.Text);
                    if (offenseDate.HasValue) {
                        cmd.Parameters.Add("@OffenseDate", SqlDbType.DateTime).Value = offenseDate;
                    }
                    cmd.Parameters.Add("@OffenseLocation", SqlDbType.NVarChar).Value = tbCitationsViolationsLocationUpdate.Text;
                    cmd.Parameters.Add("@CitingOfficer", SqlDbType.NVarChar).Value = tbCitingOfficerUpdate.Text;
                    DateTime? hearingDate = Utils.ObjectToDateTimeNullable(tbHearingDateUpdate.Text);
                    if (hearingDate.HasValue) {
                        cmd.Parameters.Add("@HearingDate", SqlDbType.DateTime).Value = hearingDate;
                    }
                    decimal? magistrateFine = null;
                    try {
                        magistrateFine = Utils.ObjectToDecimal0IfNull(tbMagistrateFineUpdate.Text.Replace("$", ""));
                    } catch { }
                    if (magistrateFine.HasValue) {
                        cmd.Parameters.Add("@MagistrateFine", SqlDbType.Money).Value = magistrateFine.Value;
                    }
                    decimal? judicialFine = null;
                    try {
                        judicialFine = Utils.ObjectToDecimal0IfNull(tbJudicialFineUpdate.Text.Replace("$", ""));
                    } catch { }
                    if (judicialFine.HasValue) {
                        cmd.Parameters.Add("@JudicialFine", SqlDbType.Money).Value = judicialFine.Value;
                    }
                    decimal? assessedFine = null;
                    try {
                        assessedFine = Utils.ObjectToDecimal0IfNull(tbAssessedFineUpdate.Text.Replace("$", ""));
                    } catch { }
                    if (assessedFine.HasValue) {
                        cmd.Parameters.Add("@AssessedFine", SqlDbType.Money).Value = assessedFine.Value;
                    }
                    decimal? writeOff = null;
                    try {
                        writeOff = Utils.ObjectToDecimal0IfNull(tbWriteoffAmountUpdate.Text.Replace("$", ""));
                    } catch { }
                    if (writeOff.HasValue) {
                        cmd.Parameters.Add("@WriteOff", SqlDbType.Money).Value = writeOff.Value;
                    }
                    decimal? fineBalToAcctg = null;
                    try {
                        fineBalToAcctg = Utils.ObjectToDecimal0IfNull(tbToAccountingUpdate.Text.Replace("$", ""));
                    } catch { }
                    if (fineBalToAcctg.HasValue) {
                        cmd.Parameters.Add("@FineBalToAcctg", SqlDbType.Money).Value = fineBalToAcctg.Value;
                    }
                    cmd.Parameters.Add("@MagistrateNotes", SqlDbType.NVarChar).Value = tbMagistrateNotesUpdate.Text;
                    cmd.Parameters.Add("@FineStatus", SqlDbType.NVarChar).Value = ddlCitationsFineStatusUpdate.SelectedValue;
                    SqlParameter newCitationID = new SqlParameter("@NewCitationID", SqlDbType.Int);
                    newCitationID.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newCitationID);
                    Utils.executeNonQuery(cmd, ConnectionString);
                    performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
                }
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }

        protected void gvViolations_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvViolations.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            bind_gvViolations();
        }

        protected void gvViolations_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvViolations.Rows[e.RowIndex];
            try {
                int violationId = Convert.ToInt32(((Label)row.FindControl("lblViolationIdEdit")).Text);
                string ruleId = ((DropDownList)row.FindControl("ddlRulesUpdate")).SelectedValue;
                string fine = ((TextBox)row.FindControl("tbScheduleFineUpdate")).Text.Replace("$", "");
                bool isWarning = ((CheckBox)row.FindControl("cbIssueAsWarningUpdate")).Checked;
                string violationNotes = ((TextBox)row.Cells[6].Controls[0]).Text;
                string orsNbr = ((TextBox)row.Cells[7].Controls[0]).Text;
                SqlCommand cmd = new SqlCommand("uspViolationsUpdate");
                decimal scheduleFine = Utils.ObjectToDecimal0IfNull(fine);

                cmd.Parameters.Add("@ViolationID", SqlDbType.Int).Value = violationId;
                cmd.Parameters.Add("@fkCitationID", SqlDbType.Int).Value = CitationsIDBeingEdited;
                cmd.Parameters.Add("@fkRuleID", SqlDbType.NVarChar).Value = ruleId;
                cmd.Parameters.Add("@ScheduleFine", SqlDbType.Money).Value = scheduleFine;
                cmd.Parameters.Add("@IssueAsWarning", SqlDbType.Bit).Value = isWarning;
                cmd.Parameters.Add("@ViolationNotes", SqlDbType.NVarChar).Value = violationNotes;
                cmd.Parameters.Add("@ORSNumber", SqlDbType.NVarChar).Value = orsNbr;
                SqlParameter newid = new SqlParameter("@NewViolationID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, ConnectionString);
                performPostUpdateSuccessfulActions("Citation updated", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Citation not updated. Error msg: " + ee.Message);
            }
            //Reset the edit index.
            gvViolations.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvViolations();

        }

        protected void gvViolations_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvViolations.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvViolations();
        }

        private decimal sumFine=0;
        private int lastIndex = -1;
        protected void gvViolations_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                if (e.Row.RowIndex > lastIndex) { // because after an update, it sweeps through the rows twice.
                    lastIndex = e.Row.RowIndex;
                    String text = null;
                    object control = e.Row.FindControl("lblScheduleFineUpdate");
                    if (control != null) { // we're not in edit mode
                        text = ((Label)control).Text;
                    } else {
                        control = e.Row.FindControl("tbScheduleFineUpdate");
                        if (control != null) { // we're in edit mode
                            text = ((TextBox)control).Text;
                        }
                    }
                    sumFine += Utils.ObjectToDecimal0IfNull(text.Replace("$", ""));

                    Control controlRuleID = (Label)e.Row.FindControl("lblRuleIDEditUpdate");
                    if (controlRuleID != null) { // we're in Edit mode
                        DataTable dtRules = getRulesTable();
                        DropDownList controlRules = (DropDownList)e.Row.FindControl("ddlRulesUpdate");
                        controlRules.DataSource = dtRules;
                        controlRules.SelectedValue = ((Label)controlRuleID).Text;
                        controlRules.DataBind();
                        CheckBox cbIssueAsWarningUpdate = (CheckBox)e.Row.FindControl("cbIssueAsWarningUpdate");
                        cbIssueAsWarningUpdate.Checked = Utils.ObjectToBool(CurrentViolationsTable.Rows[e.Row.RowIndex]["IssueAsWarning"]);
                    } else {
                        Label lblIssueAsWarningUpdate = (Label)e.Row.FindControl("lblIssueAsWarningUpdate");
                        if (Utils.ObjectToBool(CurrentViolationsTable.Rows[e.Row.RowIndex]["IssueAsWarning"])) {
                            lblIssueAsWarningUpdate.BackColor = System.Drawing.Color.Red;
                            lblIssueAsWarningUpdate.ForeColor = System.Drawing.Color.White;
                        } else {
                            lblIssueAsWarningUpdate.BackColor = System.Drawing.Color.Transparent;
                        }
                    }

                }
            }
            if (e.Row.RowType == DataControlRowType.Footer) {
                Label lbl = (Label)e.Row.FindControl("lblSumFine");
                lbl.Text = sumFine.ToString("c");
            }
        }

        private DataTable getRulesTable() {
            DataTable dtRules = CIDataSet().Tables[3];
            DataRow drRule = dtRules.NewRow();
            drRule["RuleID"] = "bubba";
            drRule["RuleDescription"] = "";
            try {
                dtRules.Rows.InsertAt(drRule, 0);
            } catch { // already there
            }
            return dtRules;
        }

        protected void cvCitationNbr_ServerValidateUpdate(object source, ServerValidateEventArgs args) {
            if (Session["CitationNewPanelOpen"]!="Y") {
                args.IsValid = true;
                if (Utils.isNothing(args.Value)) {
                    args.IsValid = false;
                }
            }
        }
        protected void cvCitationNbr_ServerValidateNew(object source, ServerValidateEventArgs args) {
            if (Session["CitationNewPanelOpen"] == "Y") {
                args.IsValid = true;
                if (Utils.isNothing(args.Value)) {
                    args.IsValid = false;
                }
            }
        }
        protected void cvMagistrateFine_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            if (Utils.isNothing(args.Value)) {
                if (isAddCitationOpen) { tbMagistrateFineNew.Text = "$0.00"; } else { tbMagistrateFineUpdate.Text = "$0.00"; }
            } else {
                try {
                    Decimal magistrateFine = Convert.ToDecimal(args.Value.Replace("$","").Replace(",",""));
                } catch {
                    args.IsValid = false;
                }
            }
        }
        private bool isAddCitationOpen {
            get {
                object obj = Session["isAddCitationOpen"];
                return obj == null ? false : (bool)obj;
            }
            set {
                Session["isAddCitationOpen"] = value;
            }
        }
        protected void cvAssessedFine_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            if (Utils.isNothing(args.Value)) {
                if (isAddCitationOpen) { tbAssessedFineNew.Text = "$0.00"; } else { tbAssessedFineUpdate.Text = "$0.00"; }
            } else {
                try {
                    Decimal assessedFine = Convert.ToDecimal(args.Value.Replace("$", "").Replace(",", ""));
                } catch {
                    args.IsValid = false;
                }
            }
        }
        protected void cvToAccounting_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            if (Utils.isNothing(args.Value)) {
                if (isAddCitationOpen) { tbToAccountingNew.Text = "$0.00"; } else { tbToAccountingUpdate.Text = "$0.00"; }
            } else {
                try {
                    Decimal ToAccounting = Convert.ToDecimal(args.Value.Replace("$", "").Replace(",", ""));
                } catch {
                    args.IsValid = false;
                }
            }
        }
        protected void cvJudicialFine_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            if (Utils.isNothing(args.Value)) {
                if (isAddCitationOpen) { tbJudicialFineNew.Text = "$0.00"; } else { tbJudicialFineUpdate.Text = "$0.00"; }
            } else {
                try {
                    Decimal JudicialFine = Convert.ToDecimal(args.Value.Replace("$", "").Replace(",", ""));
                } catch {
                    args.IsValid = false;
                }
            }
        }
        protected void cvWriteoffAmount_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            if (Utils.isNothing(args.Value)) {
                if (isAddCitationOpen) { tbWriteoffAmountNew.Text = "$0.00"; } else { tbWriteoffAmountUpdate.Text = "$0.00"; }
            } else {
                try {
                    Decimal writeOffAmount = Convert.ToDecimal(args.Value.Replace("$", "").Replace(",", ""));
                } catch {
                    args.IsValid = false;
                }
            }
        }
        private bool checkNewViolationsPanel() {
            string crnl="";
            StringBuilder sb = new StringBuilder();
            if (ddlRulesNew.SelectedIndex == 0) {
                sb.Append("Must choose a rule");
                crnl = "\r\n";
            }
            if (Utils.isNothingNot(tbScheduleFineNew.Text)) {
                try {
                    decimal d = Convert.ToDecimal(tbScheduleFineNew.Text.Replace("$", "").Replace(",", ""));
                } catch {
                    sb.Append(crnl + "Fine must be an amount");
                }
            }
            lblNewViolationMessage.Text = sb.ToString();
            return
                sb.Length == 0;
        }
        private bool checkNewViolationsPanelNewCit() {
            string crnl = "";
            StringBuilder sb = new StringBuilder();
            if (Utils.isNothingNot(tbScheduleFineNewNewCit.Text)) {
                try {
                    decimal d = Convert.ToDecimal(tbScheduleFineNewNewCit.Text.Replace("$", "").Replace(",", ""));
                } catch {
                    sb.Append(crnl + "Fine must be an amount");
                }
            }
            lblCitationNewMessage.Text = sb.ToString();
            return
                sb.Length == 0;
        }
        protected void btnNewViolationOk_Click(object sender, EventArgs args) {
            if (checkNewViolationsPanel()) {
                try {
                    string ruleId = ddlRulesNew.SelectedValue;
                    string fine = tbScheduleFineNew.Text;                    
                    bool isWarning =  cbIssueAsWarningNew.Checked;
                    string violationNotes = tbViolationNotesNew.Text;
                    string orsNbr = tbORSNumberNew.Text;
                    SqlCommand cmd = new SqlCommand("uspViolationsUpdate");
                    decimal scheduleFine = Utils.ObjectToDecimal0IfNull(fine);

                    cmd.Parameters.Add("@fkCitationID", SqlDbType.Int).Value = CitationsIDBeingEdited;
                    cmd.Parameters.Add("@fkRuleID", SqlDbType.NVarChar).Value = ruleId;
                    cmd.Parameters.Add("@ScheduleFine", SqlDbType.Money).Value = scheduleFine;
                    cmd.Parameters.Add("@IssueAsWarning", SqlDbType.Bit).Value = isWarning;
                    cmd.Parameters.Add("@ViolationNotes", SqlDbType.NVarChar).Value = violationNotes;
                    cmd.Parameters.Add("@ORSNumber", SqlDbType.NVarChar).Value = orsNbr;
                    SqlParameter newid = new SqlParameter("@NewViolationID", SqlDbType.Int);
                    newid.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newid);
                    Utils.executeNonQuery(cmd, ConnectionString);
                    performPostUpdateSuccessfulActions("Violation updated", DataSetCacheKey, null);

                    performPostUpdateSuccessfulActions("Violation added", DataSetCacheKey, null);
                } catch (Exception ee) {
                    performPostUpdateFailedActions("Violation not updated. Error msg: " + ee.Message);
                }
                mpeNewViolation.Hide();
            } else {
                mpeNewViolation.Show();
            }
        }
        protected void btnNewViolationCancel_Click(object sender, EventArgs args) {
            mpeNewViolation.Hide();
            clearAllNewFormInputFields();
        }
        protected void lbNewViolation_OnClick(object sender, EventArgs args) {
            ddlRulesNew.SelectedIndex = -1;
            lblNewViolationMessage.Text = "";
            lblCitationNewMessage.Text = "";
            tbAssessedFineNew.Text = "";
            tbORSNumberNew.Text = "";
            cbIssueAsWarningNew.Checked = false;
            tbViolationNotesNew.Text = "";
            mpeNewViolation.Show();
        }

        protected void lbNewCitation_OnClick(object sender, EventArgs args) {
            isAddCitationOpen = true;
            Session["CitationNewPanelOpen"] = "Y";
            tbCitationsLastNameNew.Focus();
            ddlCitationsFineStatusNew.SelectedIndex = 1;
            mpeNewCitation.Show();
        }
        protected void btnNewCitationOk_Click(object sender, EventArgs args) {



            if (Page.IsValid) {
                try {
                    SqlCommand cmd = new SqlCommand("uspCitationsUpdate");
                    cmd.Parameters.Add("@VLastName", SqlDbType.NVarChar).Value = tbCitationsLastNameNew.Text;
                    cmd.Parameters.Add("@VFirstName", SqlDbType.NVarChar).Value = tbCitationsFirstNameNew.Text;
                    cmd.Parameters.Add("@VMailAddr1", SqlDbType.NVarChar).Value = tbCitationsAddress1New.Text;
                    cmd.Parameters.Add("@VMailAddr2", SqlDbType.NVarChar).Value = tbCitationsAddress2New.Text;
                    cmd.Parameters.Add("@VCity", SqlDbType.NVarChar).Value = tbCitationsCityNew.Text;
                    cmd.Parameters.Add("@VZip", SqlDbType.NVarChar).Value = tbCitationsZipNew.Text;
                    cmd.Parameters.Add("@VState", SqlDbType.NVarChar).Value = tbCitationsStateNew.Text;
                    cmd.Parameters.Add("@VSunriverStatus", SqlDbType.NVarChar).Value = ddlSunriverStatusNew.SelectedValue;
                    cmd.Parameters.Add("@Citation#", SqlDbType.NVarChar).Value = tbCitationNbrNew.Text;
                    DateTime? offenseDate = Utils.ObjectToDateTimeNullable(tbCitationsViolationsDateNew.Text);
                    if (offenseDate.HasValue) {
                        cmd.Parameters.Add("@OffenseDate", SqlDbType.DateTime).Value = offenseDate.Value;
                    }
                    cmd.Parameters.Add("@OffenseLocation", SqlDbType.NVarChar).Value = tbCitationsViolationsLocationNew.Text;
                    cmd.Parameters.Add("@CitingOfficer", SqlDbType.NVarChar).Value = tbCitingOfficerNew.Text;
                    DateTime? hearingDate = Utils.ObjectToDateTimeNullable(tbHearingDateNew.Text);
                    if (hearingDate.HasValue) {
                        cmd.Parameters.Add("@HearingDate", SqlDbType.DateTime).Value = hearingDate;
                    }
                    decimal? magistrateFine = null;
                    try {
                        magistrateFine = Utils.ObjectToDecimal0IfNull(tbMagistrateFineNew.Text.Replace("$", ""));
                    } catch { }
                    if (magistrateFine.HasValue) {
                        cmd.Parameters.Add("@MagistrateFine", SqlDbType.Money).Value = magistrateFine.Value;
                    }
                    decimal? judicialFine = null;
                    try {
                        judicialFine = Utils.ObjectToDecimal0IfNull(tbJudicialFineNew.Text.Replace("$", ""));
                    } catch { }
                    if (judicialFine.HasValue) {
                        cmd.Parameters.Add("@JudicialFine", SqlDbType.Money).Value = judicialFine.Value;
                    }
                    decimal? assessedFine = null;
                    try {
                        assessedFine = Utils.ObjectToDecimal0IfNull(tbAssessedFineNew.Text.Replace("$", ""));
                    } catch { }
                    if (assessedFine.HasValue) {
                        cmd.Parameters.Add("@AssessedFine", SqlDbType.Money).Value = assessedFine.Value;
                    }
                    decimal? writeOff = null;
                    try {
                        writeOff = Utils.ObjectToDecimal0IfNull(tbWriteoffAmountNew.Text.Replace("$", ""));
                    } catch { }
                    if (writeOff.HasValue) {
                        cmd.Parameters.Add("@WriteOff", SqlDbType.Money).Value = writeOff.Value;
                    }
                    decimal? fineBalToAcctg = null;
                    try {
                        fineBalToAcctg = Utils.ObjectToDecimal0IfNull(tbToAccountingNew.Text.Replace("$", ""));
                    } catch { }
                    if (fineBalToAcctg.HasValue) {
                        cmd.Parameters.Add("@FineBalToAcctg", SqlDbType.Money).Value = fineBalToAcctg.Value;
                    }
                    cmd.Parameters.Add("@MagistrateNotes", SqlDbType.NVarChar).Value = tbMagistrateNotesNew.Text;
                    cmd.Parameters.Add("@FineStatus", SqlDbType.NVarChar).Value = ddlCitationsFineStatusNew.SelectedValue;
                    SqlParameter newCitationID = new SqlParameter("@NewCitationID", SqlDbType.Int);
                    newCitationID.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newCitationID);


                    if (ddlRulesNewNewCit.SelectedIndex > 0) {


                        if (checkNewViolationsPanelNewCit()) {
                            Utils.executeNonQuery(cmd, ConnectionString);


                            string ruleId = ddlRulesNewNewCit.SelectedValue;
                            string fine = tbScheduleFineNewNewCit.Text;
                            bool isWarning = cbIssueAsWarningNewNewCit.Checked;
                            string violationNotes = tbViolationNotesNewNewCit.Text;
                            string orsNbr = tbORSNumberNewNewCit.Text;
                            cmd = new SqlCommand("uspViolationsUpdate");
                            decimal scheduleFine = Utils.ObjectToDecimal0IfNull(fine);

                            cmd.Parameters.Add("@fkCitationID", SqlDbType.Int).Value = (int)newCitationID.Value;
                            cmd.Parameters.Add("@fkRuleID", SqlDbType.NVarChar).Value = ruleId;
                            cmd.Parameters.Add("@ScheduleFine", SqlDbType.Money).Value = scheduleFine;
                            cmd.Parameters.Add("@IssueAsWarning", SqlDbType.Bit).Value = isWarning;
                            cmd.Parameters.Add("@ViolationNotes", SqlDbType.NVarChar).Value = violationNotes;
                            cmd.Parameters.Add("@ORSNumber", SqlDbType.NVarChar).Value = orsNbr;
                            SqlParameter newid = new SqlParameter("@NewViolationID", SqlDbType.Int);
                            newid.Direction = ParameterDirection.Output;
                            cmd.Parameters.Add(newid);
                            Utils.executeNonQuery(cmd, ConnectionString);

                        } else {
                            isAddCitationOpen = true;
                            Session["CitationNewPanelOpen"] = "Y";
                            mpeNewCitation.Show();
                            return;

                        }



                    } else {
                        Utils.executeNonQuery(cmd, ConnectionString);
                    }




                    performPostNewSuccessfulActions("Update successful", DataSetCacheKey, null, tbCitationIDLU, tbCitationNbrNew.Text);
                } catch (Exception ee) {
                    performPostNewFailedActions("Update failed. Msg: " + ee.Message);
                    isAddCitationOpen = true;
                    Session["CitationNewPanelOpen"] = "Y";
                    mpeNewCitation.Show();
                    return;
                }
                isAddCitationOpen = false;
                Session["CitationNewPanelOpen"] = "N";
                mpeNewCitation.Hide();
            } else {
                isAddCitationOpen = true;
                Session["CitationNewPanelOpen"] = "Y";
                mpeNewCitation.Show();
            }
        }
        protected void btnNewCitationCancel_Click(object sender, EventArgs args) {
            isAddCitationOpen = false;
            Session["CitationNewPanelOpen"] = "N";
            mpeNewCitation.Hide();
            clearAllNewFormInputFields();
        }
        public static string MyMenuName = "Citations";
        protected override string childMenuName {
            get { return MyMenuName; }
        }
    }
}