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
    public partial class SROAVehicles : AbstractReport {

        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
            }
        }

        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new SROAVehicleMaintenance.SROAVehiclesReport();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        protected override Hashtable getReportParams() {
            return new Hashtable();
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString; }
        }
    }
}