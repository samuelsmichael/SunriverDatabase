using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class SubmittalReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }
        protected void lbAdministrativeApproval_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/SubmittalAdministrativeApprovals.aspx");
        }
    }
}