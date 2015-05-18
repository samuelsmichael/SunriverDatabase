using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class ContractorReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbContractorsByCategory_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/ContractorByCategory.aspx");
        }
        protected void lbContractorsAllData_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/ContractorAllData.aspx");
        } 
        protected void lbContractorsList_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/ContractorList.aspx");
        }
        protected void lbCategoryList_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/CategoryList.aspx");
        }
        protected void lbContractorEnvelope_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/ContractorEnvelope.aspx");
        }
        protected void ContractorMailingLabels_Click(object sender, EventArgs args) {
            Response.Redirect("~/Reports/ContractorMailingLabels.aspx");
        }
    }
}