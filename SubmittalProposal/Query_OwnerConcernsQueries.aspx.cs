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
    public partial class Query_OwnerConcernsQueries : AbstractQueryPage {
        protected override void queryHasBeenRun(DataSet ds) {
        }

        protected override string PageTitle {
            get { return "Owner Concerns"; }
        }
        protected override SqlCommand MSqlCommand {
            get {
                
                 // If you had had parameters, then you do this (See ITAdmin.aspx.cs to see how the Session variable got loaded):
                 //
                 //    SqlCommand cmd = new SqlCommand("uspSomeQueryName");
                 //    cmd.Parameters.Add("@SomeParameterName", SqlDbType.VarChar /*Choose the type that best fits your parameter*/).Value = Session["AnyName"];
                 // 
                SqlCommand cmd = new SqlCommand("uspOwnerConcernsQueries");
                DateTime? startDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsStartDate.Text);
                if (startDate.HasValue) {
                    cmd.Parameters.Add("@StartDate", SqlDbType.DateTime).Value = startDate;
                }
                DateTime? endDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsEndDate.Text);
                if (endDate.HasValue) {
                    cmd.Parameters.Add("@EndDate", SqlDbType.DateTime).Value = endDate;
                }
                if (Utils.isNothingNot(ddlCategoryParm.SelectedValue)) {
                    cmd.Parameters.Add("@Category", SqlDbType.NVarChar).Value = ddlCategoryParm.SelectedValue;
                }
                if (Utils.isNothingNot(ddlDepartmentsParm.SelectedValue)) {
                    cmd.Parameters.Add("@DeptReferred", SqlDbType.NVarChar).Value = ddlDepartmentsParm.SelectedValue;
                }
                if (Utils.isNothingNot(ddlOpensCloseds.SelectedValue)) {
                    cmd.Parameters.Add("@ConcernsOpen", SqlDbType.Bit).Value = Utils.ObjectToBool(ddlOpensCloseds.SelectedValue);
                }
                return cmd;
            }
        }
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["OwnerConcernsSQLConnectionString"].ConnectionString; }
        }
        protected override void ChildPagePreRender() {
            if (!IsPostBack) {
                DataTable department = OwnerConcerns.OwnerConcernsDataSet().Tables[2].Copy();
                DataRow row = department.NewRow();
                row["Department"] = "";
                row["DeptSelector"] = "";
                department.Rows.InsertAt(row, 0);
                ddlDepartmentsParm.DataSource = department;
                ddlDepartmentsParm.DataBind();
                DataTable category =OwnerConcerns.OwnerConcernsDataSet().Tables[1].Copy();
                DataRow rowC = category.NewRow();
                rowC["Category"] = "";
                category.Rows.InsertAt(rowC, 0);
                ddlCategoryParm.DataSource = category;
                ddlCategoryParm.DataBind();
            }
        }
    }
}