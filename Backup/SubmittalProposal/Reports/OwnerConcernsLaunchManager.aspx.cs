using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Common;
using System.Web.UI.WebControls;

namespace SubmittalProposal.Reports {
    public partial class OwnerConcernsLaunchManager : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Utils.isNothingNot(Request.QueryString["CaseID"])) {
                //"5,192.00"
                int caseId = Utils.ObjectToInt(Request.QueryString["CaseID"].Replace(",", "").Replace(".00", ""));
                Session["CaseID"] = caseId;
            }
            Response.Redirect("~/OwnerConcerns.aspx");
        }
    }
}