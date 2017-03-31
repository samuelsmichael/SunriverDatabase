using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace SubmittalProposal {
    public partial class Query_CrossReference3 : AbstractQueryPage {

        protected override string PageTitle {
            get { return "Cross Reference"; }
        }
        protected override SqlCommand MSqlCommand {
            get {
                
                 // If you had had parameters, then you do this (See ITAdmin.aspx.cs to see how the Session variable got loaded):
                 //
                 //    SqlCommand cmd = new SqlCommand("uspSomeQueryName");
                 //    cmd.Parameters.Add("@SomeParameterName", SqlDbType.VarChar /*Choose the type that best fits your parameter*/).Value = Session["AnyName"];
                 // 
                
                return new SqlCommand("uspCrossReferenceLeaseIdASpace");
            }
        }
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString; }
        }
        protected override void ChildPagePreRender() {
        }
    }
}