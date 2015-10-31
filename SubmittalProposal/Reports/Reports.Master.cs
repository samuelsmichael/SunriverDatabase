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

        protected void lbHome_Click(object sender, EventArgs e) {
            if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("submittal")) {
                Response.Redirect("~/Submittal2.aspx");
            } else {
                if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("bpermit")) {
                    Response.Redirect("~/BPermit.aspx");
                } else {
                    if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("compliancereview")) {
                        Response.Redirect("~/ComplianceReview.aspx");
                    } else {
                        if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("sellcheck")) {
                            Response.Redirect("~/SellCheck.aspx");
                        } else {
                            if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("rvstorage")) {
                                Response.Redirect("~/RVStorage.aspx");
                            } else {
                                if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("contractor")) {
                                    Response.Redirect("~/Contractor.aspx");
                                } else {
                                    if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("cardmanage")) {
                                        Response.Redirect("~/IDCardManagement.aspx");
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Response.Redirect("~/Submittal2.aspx");
        }
    }
}