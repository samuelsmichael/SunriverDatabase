using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class CitationsReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void lbHome_Click(object sender, EventArgs e) {
            Response.Redirect("~/Citations.aspx");
        }

        protected void lbHearingCalendar_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/CitationsReport_HearingCalendar.aspx");
        }
    }
}