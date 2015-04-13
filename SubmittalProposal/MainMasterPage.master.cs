using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data.SqlClient;
using System.Data;
using System.Runtime.Caching;
using System.Configuration;

namespace SubmittalProposal {
    public partial class MainMasterPage : System.Web.UI.MasterPage {

        protected void Page_Load(object sender, EventArgs e) {
        }

        protected void lbReports_Click(object sender, EventArgs e) {
            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("submittal")) {
                Response.Redirect("~/SubmittalReportsMain.aspx");
            } else {
                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("bpermit")) {
                    Response.Redirect("~/BPermitReportsMain.aspx");
                } else {
                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("compliancereview")) {
                        Response.Redirect("~/ComplianceReviewReportsMain.aspx");
                    }
                }
            }
        }
    }
}