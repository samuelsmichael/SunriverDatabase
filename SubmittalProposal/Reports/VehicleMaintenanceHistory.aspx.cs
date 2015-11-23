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
    public partial class VehicleMaintenanceHistory : AbstractReport {
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString; }
        }

        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                ddlVehicle_Search.DataSource = SubmittalProposal.LRFDVehicleMaintenance.LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
                ddlVehicle_Search.DataBind();
            }
        }

        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new LRFDVehicleMaintenance.VehicleMaintenanceHistory();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        private string getVehicleNameFor(string vehicleNumber) {
            DataTable vehicleTable = SubmittalProposal.LRFDVehicleMaintenance.LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
            DataView vehicleView = new DataView(vehicleTable);
            vehicleView.RowFilter = "Number='" + vehicleNumber + "'";
            DataTable vehicleViewFiltered = vehicleView.ToTable();
            DataRow drZVehicle = vehicleViewFiltered.Rows[0];
            return Common.Utils.ObjectToString(drZVehicle["Description"]);
        }

        protected override System.Collections.Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@Number", ddlVehicle_Search.SelectedValue);
            reportParams.Add("@FromDate",tbFromDate.Text);
            reportParams.Add("@ToDate", tbToDate.Text);
            reportParams.Add("@VehicleName",getVehicleNameFor(ddlVehicle_Search.SelectedValue));
            return reportParams;
        }
    }
}