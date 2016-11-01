using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace SubmittalProposal.Reports {
    public partial class ComRoster_HomeReport_ChairPersonList : AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                
            }
        }

        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new ComRoster.ChairPersonList();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        protected override System.Collections.Hashtable getReportParams() {
            return new Hashtable();
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["ComRosterSQLConnectionString"].ConnectionString; }
        }
    }
}