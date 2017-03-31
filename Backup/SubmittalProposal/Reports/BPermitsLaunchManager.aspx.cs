using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;

namespace SubmittalProposal.Reports {
    public partial class BPermitsLaunchManager : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Utils.isNothingNot(Request.QueryString["ShowBPermitID"])) {
                //"5,192.00"
                int bPermitId = Utils.ObjectToInt(Request.QueryString["ShowBPermitID"].Replace(",","").Replace(".00",""));
                Session["ShowBPermitID"] = bPermitId;
            }
            Response.Redirect("~/BPermit.aspx");
        }
    }
}