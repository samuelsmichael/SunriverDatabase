using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class ComRoster_HomeReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            
        }
        protected void lbHome_Click(object sender, EventArgs e) {
            Response.Redirect("~/ComRoster_Home.aspx");
        }
        protected void lbCommitteeData_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/ComRoster_HomeReport_CommitteeData.aspx");
        }
        protected void lbChairPersonList_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/ComRoster_HomeReport_ChairPersonList.aspx");
        }
        protected void lbCommitteeRosters_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/ComRoster_HomeReport_CommitteeRoster.aspx");
        }
        protected void lbOneRoster_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/ComRoster_HomeReport_OneRoster.aspx");
        }
        protected void lbExpiringTerms_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/ComRoster_HomeReport_ExpiringTerms.aspx");
        }
        protected void lbCommitteeListAll_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/ComRoster_HomeReport_CommitteeListAll.aspx");
        }
    }
}