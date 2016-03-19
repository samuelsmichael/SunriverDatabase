using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal.Reports {
    public partial class Reports : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {

        }
        public CrystalDecisions.Web.CrystalReportViewer getCrystalReportView() {
            return CrystalReportViewer1;
        }

        public Button getSubmitButton() {
            return btnSubmitReport;
        }

        protected void lbBack_Click(object sender, EventArgs e) {
            Response.Redirect(Session["GoBackTo"].ToString());
        }
        protected void lbHome_Click(object sender, EventArgs e) {
            Response.Redirect("~/Default.aspx");
        }
    }
}