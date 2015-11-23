using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace SubmittalProposal.Reports {
    public partial class LapineRFDInvoices : AbstractReport {

        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
            }
        }

        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new LRFDVehicleMaintenance.LapineRFDInvoicesReport();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        protected override System.Collections.Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@StartDate", tbFromDate.Text);
            reportParams.Add("@EndDate", tbToDate.Text);
            return reportParams;
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString; }
        }
    }
}