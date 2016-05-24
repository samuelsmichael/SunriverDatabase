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

        protected void lbCitationsOpen_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/CitationsReport_CitationsOpen.aspx");
        }
        protected void lbCitationsClosed_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/CitationsReport_CitationsClosed.aspx");
        }
        protected void lbFineWriteoff_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/CitationsReport_CitationsFineWriteoff.aspx");
        }
        protected void lbBalancesToAcctg_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/CitationsReport_CitationsFineBalancesToAcctg.aspx");
        }
        protected void lbFineSummary_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/CitationsReport_CitationsFineSummary.aspx");
        }
        protected void lbRuleSummary_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/CitationsReport_RuleSummary.aspx");
        }
        protected void lbDesignSummary_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/CitationsReport_DesignSummary.aspx");
        }
        protected void lbVegetation_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/CitationsReport_Vegetation.aspx");
        }
        protected void lbViolatorHistory_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/CitationsReport_ViolatorHistory.aspx");
        }
        protected void lbORSViolationSummary_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/CitationsReport_ORSViolationSummary.aspx");
        }
        protected void lbORSWarningSummary_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/CitationsReport_ORSWarningSummary.aspx");
        }
        
    }
}