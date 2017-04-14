using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using Common;

namespace SubmittalProposal.Reports {
    public partial class CitationsReport_CitationData : AbstractReport {
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["CitationsSQLConnectionString"].ConnectionString; }
        }
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                if (Utils.isNothingNot(Session["Citation#Current"])) {
                    tbCitationNbr.Text = Utils.ObjectToString(Session["Citation#Current"]);
                }
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new Citations.Citations_CitationData();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@Citation#", tbCitationNbr.Text);
            return reportParams;
        }
    }
}