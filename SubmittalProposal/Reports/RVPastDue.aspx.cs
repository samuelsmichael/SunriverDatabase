using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace SubmittalProposal.Reports.RVLease {
    public partial class RVPastDue : AbstractReport {

        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
            }
        }

        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new RVLease.rptRVPastDue();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        protected override void AbstractReport_Click(object sender, EventArgs e) {
            int month = 1;
            try {
                month = Common.Utils.ObjectToInt(tbPastDueMonth.Text);
            } catch {
                lbError.Text="Month must be numeric";
                return;
            }
            if (month <= 0 || month > 12) {
                lbError.Text="Month must be between 1 and 12";
                return;
            }
            base.AbstractReport_Click(sender, e);
        }

        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@Month",Common.Utils.ObjectToInt(tbPastDueMonth.Text) );
            reportParams.Add("@IsPastDueReport", true);
            reportParams.Add("ReportHeading","Past Due RV Storage Accounts");
            reportParams.Add("SideBarHeading", "Past Due Cutoff Date");
            return reportParams;
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString; }
        }
    }
}