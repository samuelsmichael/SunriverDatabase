using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class RVReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbSpaceInventory_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVSpaceReport.aspx");
        }
        protected void lbSpacesEmpty_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVSpacesEmpty.aspx");
        }
    }
}