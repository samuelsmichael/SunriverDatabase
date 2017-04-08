using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal.Reports.SROAVehicleMaintenance {
    public partial class BlankWorkOrderSROA : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }
        protected void btnGoBack_OnClick(object sender, EventArgs args) {
            Response.Redirect("~/SROAVehicleMaintenanceReportsMain.aspx");
        }
    }
}