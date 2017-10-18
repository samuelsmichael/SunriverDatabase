using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using Common;

namespace SubmittalProposal.Reports {
    public partial class ContractorMailingLabelsCSV : AbstractQueryPage {


        protected override SqlCommand MSqlCommand {
            get {

                // If you had had parameters, then you do this (See ITAdmin.aspx.cs to see how the Session variable got loaded):
                //
                //    SqlCommand cmd = new SqlCommand("uspSomeQueryName");
                //    cmd.Parameters.Add("@SomeParameterName", SqlDbType.VarChar /*Choose the type that best fits your parameter*/).Value = Session["AnyName"];
                // 
                SqlCommand cmd = new SqlCommand("uspRptContractorMailLabelsForCSVFile");
                DateTime? startDate = Utils.ObjectToDateTimeNullable(tbRegistrationStartDate.Text);
                if (startDate.HasValue) {
                    cmd.Parameters.Add("@RegistrationStartDate", SqlDbType.DateTime).Value = startDate;
                }
                DateTime? endDate = Utils.ObjectToDateTimeNullable(tbRegistrationEndDate.Text);
                if (endDate.HasValue) {
                    cmd.Parameters.Add("@RegistrationEndDate", SqlDbType.DateTime).Value = endDate;
                }
                return cmd;
            }
        }


        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["ContractorRegSQLConnectionString"].ConnectionString; }
        }
        protected override string PageTitle {
            get { return "Contractor Mailing Labels"; }
        }
        protected override void ChildPagePreRender() {
        }
        protected override void queryHasBeenRun(DataSet ds) {
            if (Utils.hasData(ds)) {
                ((AbstractCSVPage)Master).getButton().Visible = true;
                Session["CSVFileDataSet"] = ds;
            } else {
                Session["CSVFileDataSet"] = null;
            }
        }
    }
}