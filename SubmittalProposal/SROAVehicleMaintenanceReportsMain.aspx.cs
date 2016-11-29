using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class SROAVehicleMaintenanceReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbVehicleMaintenanceHistory_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/VehicleMaintenanceHistorySROA.aspx");
        }
        protected void lbShopActivity_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/VehicleShopActivitySROA.aspx");
        }
        protected void lbMechanicActivity_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/VehicleMechanicActivitySROA.aspx");
        }
        protected void lbLapineRFDVehicles_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/SROAVehicles.aspx");
        }
        protected void lbLapineRFDInvoices_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/SROAInvoices.aspx");
        }
        protected void lbPrintBlankWO_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/SROAVehicleMaintenance/BlankWorkOrderSROA.aspx");
        }
    }
}