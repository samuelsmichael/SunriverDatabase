using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;

namespace SubmittalProposal.Reports {
    public partial class SubmittalHistoryLotLane : AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                SqlCommand cmd = new SqlCommand("uspSubmittalHistoryLotLaneDropdown");
                DataSet ds = Common.Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                ddlSubmittalHistoryLotLane.DataSource = ds;
                ddlSubmittalHistoryLotLane.DataBind();
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new Submittal.RptSubmittalHistoryLotLane();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@Lot", deriveLotFromDropdownValue(ddlSubmittalHistoryLotLane.SelectedValue));
            reportParams.Add("@Lane", deriveLaneFromDropdownValue(ddlSubmittalHistoryLotLane.SelectedValue));
            return reportParams;
        }
        private string deriveLotFromDropdownValue(string value) {
            return value.Split(new char[] { '|' })[0];
        }
        private string deriveLaneFromDropdownValue(string value) {
            return value.Split(new char[] { '|' })[1];
        }

    }
}