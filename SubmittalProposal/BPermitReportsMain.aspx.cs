using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class BPermitReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbBPermitsIssued_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BPermitsBuildingPermitsIssued.aspx");
        }
        protected void lbBPermitsClosed_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BPermitsClosed.aspx");
        }
        protected void lbBPermitsOpen_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BPermitsOpen.aspx");
        }
        protected void lbBPermitsExpired_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BPermitsExpired.aspx");
        }
    }
}