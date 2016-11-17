using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace SubmittalProposal {
    public partial class BallotVerify_CBBlockVotes_SRResort_Query : AbstractQueryPage {

        protected override string PageTitle {
            get { return "SR Resort"; }
        }
        protected override SqlCommand MSqlCommand {
            get {
                
                 // If you had had parameters, then you do this (See ITAdmin.aspx.cs to see how the Session variable got loaded):
                 //
                 //    SqlCommand cmd = new SqlCommand("uspSomeQueryName");
                 //    cmd.Parameters.Add("@SomeParameterName", SqlDbType.VarChar /*Choose the type that best fits your parameter*/).Value = Session["AnyName"];
                 // 

                return new SqlCommand("uspBallotVerifyQuerySRResort");
            }
        }
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["BallotVerifySQLConnectionString"].ConnectionString; }
        }
        protected override void ChildPagePreRender() {
            
        }
    }
}