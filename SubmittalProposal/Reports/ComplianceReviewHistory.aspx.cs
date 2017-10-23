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
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master).dsLotLane;
                ddlLane.DataBind();

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
            if (Common.Utils.isNothingNot(tbLot.Text)) {
                reportParams.Add("@Lot", tbLot.Text);
            }
            if (Common.Utils.isNothingNot(ddlLane.SelectedValue)) {
                reportParams.Add("@Lane", ddlLane.SelectedValue);
            }
            return reportParams;
            
        }
    }
}