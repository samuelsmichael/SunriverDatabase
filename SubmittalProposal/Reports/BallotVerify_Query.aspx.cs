using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace SubmittalProposal.Reports {
    public partial class BallotVerify_Query : AbstractReport {
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["CitationsSQLConnectionString"].ConnectionString; }
        }
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                if (Request.QueryString["Type"]=="None") {
                    pnlType.Visible = true;
                } else {
                    pnlType.Visible = false;
                }
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new BallotVerify.BallotVerifyGeneric();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@Type", deriveType());
            reportParams.Add("@Voted", rblVoted.SelectedValue);
            return reportParams;
        }
        private string deriveType() {
            if(Common.Utils.isNothingNot(Request.QueryString["Type"])) {
                return (string)Request.QueryString["Type"];
            } else {
                return ddlArea.SelectedValue;
            }
        }
    }
}