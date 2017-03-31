using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data;
using System.Data.SqlClient;

namespace SubmittalProposal {
    public partial class IDCardManagementReportsMain : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
            }
            ((SiteMaster)Master).ReportPageImOnSinceMenuItemClickDoesntWork = GetType().Name;
        }
        protected void lbHome_Click(Object sender, EventArgs args) {
            Response.Redirect("~/IDCardManagement.aspx");
        }
   }
}