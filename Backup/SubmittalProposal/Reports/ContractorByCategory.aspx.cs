using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace SubmittalProposal.Reports {
    public partial class ContractorByCategory :AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new Contractor.ContractorByCategory();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@RegistrationStartDate", Common.Utils.ObjectToDateTime(tbRegistrationStartDate.Text));
            reportParams.Add("@ListRevisionDate", Common.Utils.ObjectToDateTime(tbListRevisionDate.Text));
            reportParams.Add("@ListYear", Common.Utils.ObjectToString(tbListYear.Text));
            return reportParams;
        }
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["ContractorRegSQLConnectionString"].ConnectionString; }
        }
    }
}