using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace SubmittalProposal.Reports {

    public partial class SellCheckHistory : AbstractReport {
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["SRSellCheckSQLConnectionString"].ConnectionString; }
        }
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master).dsLotLane;
                ddlLane.DataBind();
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new SellCheck.SellCheckHistory();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@Lot", Common.Utils.ObjectToString(tbLot.Text));
            reportParams.Add("@Lane", Common.Utils.ObjectToString(ddlLane.SelectedValue));
            return reportParams;
        }
    }
}