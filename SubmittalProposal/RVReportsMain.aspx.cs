using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Common;

namespace SubmittalProposal {
    public partial class RVReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
            if (!IsPostBack) {
                lblStatus.Text = "";
            }
        }
        protected void lbSpaceInventory_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVSpaceReport.aspx");
        }
        protected void lbSpacesEmpty_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVSpacesEmpty.aspx");
        }
        protected void lbMailingLabels_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVMailingLabels.aspx");
        }
        protected void lbPastDue_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVPastDue.aspx");
        }
        protected void lbRenewNow_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVRenewNow2.aspx");
        }
        protected void lbBillingInfo_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVBillingInfo.aspx");
        }
        protected void lbCrossReference_Click(object sender, EventArgs args) {
            Response.Redirect("~/Query_CrossReference3.aspx");
        }

        protected void lbUpdateAllLeasePaidToNo_Click(object sender, EventArgs args) {
            SqlCommand cmd=null;
            SqlConnection conn=null;
            cmd = new SqlCommand("uspUpdateAllNon-CancelledLeasesToPaidNO",  conn);
            Utils.executeNonQuery(cmd,System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
            lblStatus.Text = "Successful";
        }
        protected void lbHome_Click(Object sender, EventArgs args) {
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
                            if (((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("rv")) {
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