using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class SellCheckReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbFeesDue_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/SellCheckUnPaidFees.aspx");
        }
        protected void lbSellCheckLetter_Click(object sender, EventArgs e) {
            throw new NotImplementedException();
        }
        protected void lbSellCheckHistory_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/SellCheckHistory.aspx");
        }
        protected void lbSellCheck_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/SellCheckSummary.aspx");
        }
        protected void lbSellCheckList_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/SellCheckList.aspx");
        }
    }
}