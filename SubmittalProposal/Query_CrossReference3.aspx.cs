using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace SubmittalProposal {
    public partial class Query_CrossReference3 : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            SqlCommand cmd = new SqlCommand("uspCrossReferenceLeaseIdASpace");
            DataSet ds = Common.Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
            ((AbstractQuery2)Master).getGridView().DataSource = ds;
            ((AbstractQuery2)Master).getGridView().DataBind();
            ((AbstractQuery2)Master).getTitleLabel().Text = "Cross Reference";
        }
    }
}