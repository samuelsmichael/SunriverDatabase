using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions;
using CrystalDecisions.CrystalReports;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Data;
using System.Data.SqlClient;
using Common;


namespace SubmittalProposal.Reports {
    public partial class AllInfoCrystalReportsPage : AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master).dsLotLane;
                ddlLane.DataBind();
                SqlCommand cmd = new SqlCommand("uspAddressGet");
                cmd.Parameters.Add("@PropId", SqlDbType.NVarChar).Value = Utils.ObjectToString(Session["opSRPropIDBeingEdited"]);
                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                ddlLane.SelectedValue = Utils.ObjectToString(ds.Tables[0].Rows[0]["SRLane"]);
                tbLot.Text = Utils.ObjectToString(ds.Tables[0].Rows[0]["SRLot"]);
            }
        }

        protected override ReportDocument getReportDocument() {
            return new SubmittalProposal.Reports.OwnerProperty.PropertyAllInfo();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return false;
        }

        protected override System.Collections.Hashtable getReportParams() {
            System.Collections.Hashtable _reportParams = new System.Collections.Hashtable();
            _reportParams.Add("@Lot", tbLot.Text);
            _reportParams.Add("@Lane", ddlLane.SelectedValue);
            _reportParams.Add("@ReportHeading", tbLot.Text + " " + ddlLane.SelectedValue);
            _reportParams.Add("@PropID",Utils.ObjectToString(Session["opSRPropIDBeingEdited"]));
            return _reportParams;
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString; }
        }
    }
}