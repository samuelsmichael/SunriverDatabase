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
    public partial class ComplianceReviewHistory : AbstractReport {
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString; }
        }
        protected override void child_Page_Load(object sender, EventArgs args) {
            if ( !IsPostBack) {
                SqlCommand cmd = new SqlCommand("uspComplianceHistoryLotLaneDropdown");
                DataSet ds = Common.Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                ddlComplianceHistoryLotLane.DataSource = ds;
                ddlComplianceHistoryLotLane.DataBind();
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new ComplianceReview.ComplianceHistory();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        private string deriveLotFromDropdownValue(string value) {
            return value.Split(new char[] { '|' })[0];
        }
        private string deriveLaneFromDropdownValue(string value) {
            return value.Split(new char[] { '|' })[1];
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@Lot",deriveLotFromDropdownValue(ddlComplianceHistoryLotLane.SelectedValue));
            reportParams.Add("@Lane", deriveLaneFromDropdownValue(ddlComplianceHistoryLotLane.SelectedValue));
            return reportParams;
        }
    }
}