using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;

namespace SubmittalProposal.Reports {
    public partial class CitationsLaunchManager : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Utils.isNothingNot(Request.QueryString["ShowCitationsID"])) {
                //"5,192.00"
                int citationsId = Utils.ObjectToInt(Request.QueryString["ShowCitationsID"].Replace(",", "").Replace(".00", ""));
                Session["ShowCitationsID"] = citationsId;
            }
            Response.Redirect("~/Citations.aspx");

        }
    }
}