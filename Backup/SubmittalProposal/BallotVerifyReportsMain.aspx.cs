using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class BallotVerifyReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
        }
        protected void lbHome_Click(object sender, EventArgs e) {
            Response.Redirect("~/BallotVerify.aspx");
        }

        protected void lbCBBlockVotes_SRResort_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BallotVerify_Query.aspx?Type=SRResort");
        }

        protected void lbCBBlockVotes_Ridge_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BallotVerify_Query.aspx?Type=Ridge");
        }

        protected void lbThePines_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BallotVerify_Query.aspx?Type=Pines");
        }

        protected void lbSortedByZip_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/BallotVerify_Query.aspx?Type=None");
        }
    }
}