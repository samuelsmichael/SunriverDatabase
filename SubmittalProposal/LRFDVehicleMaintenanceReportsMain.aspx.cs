using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class LRFDVehicleMaintenanceReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbVehicleMaintenanceHistory_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/VehicleMaintenanceHistory.aspx");
        }
        protected void lbShopActivity_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/VehicleShopActivity.aspx");
        }
        protected void lbMechanicActivity_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/VehicleMechanicActivity.aspx");
        }
        protected void lbLapineRFDVehicles_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/LapineRFDVehicles.aspx");
        }
        protected void lbLapineRFDInvoices_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/LapineRFDInvoices.aspx");
        }
        protected void lbPrintBlankWO_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/LRFDVehicleMaintenance/BlankWorkOrder.aspx");
        }
    }
}