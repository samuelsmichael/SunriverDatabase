using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class AbstractQuery2 : System.Web.UI.MasterPage {
        public GridView getGridView() {
            return GridView2;
        }
        public Label getTitleLabel() {
            return lblQueryName;
        }
        protected void btnReturnFromQueryPage_OnClick(object sender, EventArgs arges) {
            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("submittal")) {
                Response.Redirect("~/SubmittalReportsMain.aspx");
            } else {
                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("bpermit")) {
                    Response.Redirect("~/BPermitReportsMain.aspx");
                } else {
                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("compliancereview")) {
                        Response.Redirect("~/ComplianceReviewReportsMain.aspx");
                    } else {
                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("contractor")) {
                            Response.Redirect("~/ContractorReportsMain.aspx");
                        } else {
                            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("sellcheck")) {
                                Response.Redirect("~/SellCheckReportsMain.aspx");
                            } else {
                                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("rv")) {
                                    Response.Redirect("~/RVReportsMain.aspx");
                                }
                            }
                        }
                    }
                }
            }
        }

    }
}