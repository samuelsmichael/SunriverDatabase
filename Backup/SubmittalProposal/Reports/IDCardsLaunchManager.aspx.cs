using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;

namespace SubmittalProposal.Reports {
    public partial class IDCardsLaunchManager : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Utils.isNothingNot(Request.QueryString["ShowIDCardsID"])) {
                //"5,192.00"
                string customerID = Utils.ObjectToString(Request.QueryString["ShowIDCardsID"].Replace(",", "").Replace(".00", ""));
                Session["ShowIDCardsID"] = customerID;
            }
            Response.Redirect("~/IDCardManagement.aspx");
        }
    }
}