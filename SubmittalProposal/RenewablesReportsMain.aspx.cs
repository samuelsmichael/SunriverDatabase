using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class RenewablesReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void lbHome_Click(object sender, EventArgs e) {
            Response.Redirect("~/Renewables_MJS.aspx");
        }

        protected void lbByProjectName_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RenewablesReport_ByProject.aspx");
        }
         
    }
}