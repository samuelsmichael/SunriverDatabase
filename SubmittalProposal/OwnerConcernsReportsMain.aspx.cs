using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Common;

namespace SubmittalProposal {
    public partial class OwnerConcernsReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbOwnerConcernReports_Click(object sender, EventArgs e) {
            //Response.Redirect("~/Reports/RVSpaceReport.aspx");
        }
        protected void lbOwnerConcernQueries_Click(object sender, EventArgs args) {
            Response.Redirect("~/Query_OwnerConcernsQueries.aspx");
        }
        protected void lbHome_Click(Object sender, EventArgs args) {
            Response.Redirect("~/OwnerConcerns.aspx");
        }
    }
}