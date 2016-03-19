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
    public partial class ITAdmin : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                lblRunSomeProcedureStatus.Text = "";
            }
        }

        protected void lbRunSomeProcedure_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = null;
                SqlConnection conn = null;
                cmd = new SqlCommand("somestoredprocedure", conn);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SomeConnectionString"].ConnectionString);
                lblRunSomeProcedureStatus.Text = "Successful";
            } catch (Exception e) {
                lblRunSomeProcedureStatus.Text = "Failed. Msg: " + e.Message;
            }
        }
        protected void lbPastDue_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVPastDue.aspx");
        }
        protected void lbCrossReference_Click(object sender, EventArgs args) {
            Response.Redirect("~/Query_CrossReference3.aspx");
        }
    }
}