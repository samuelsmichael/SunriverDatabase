using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data.SqlClient;

namespace SubmittalProposal.Reports{
    public partial class SubmittalAdministrativeApprovals : AbstractReport  {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                Hashtable reportParams = new Hashtable();
                reportParams.Add("StartDate",Common.Utils.ObjectToDateTime(tbFromDate));
                reportParams.Add("EndDate",Common.Utils.ObjectToDateTime(tbToDate));
                reportParams.Add("ReportHeading",tbReportHeading.Text);
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new RptSubmittalAdministrativeApprovals();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
 	        return true;
        }
    }
}