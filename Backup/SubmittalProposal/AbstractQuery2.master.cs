using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SubmittalProposal {
    public partial class AbstractQuery2 : System.Web.UI.MasterPage {
        public GridView getGridView() {
            return GridView2;
        }
        public Label getTitleLabel() {
            return lblQueryName;
        }
        protected void lbBack_Click(object sender, EventArgs arges) {
            Response.Redirect(Session["GoBackTo"].ToString());
        }

        protected void lbHome_Click(object sender, EventArgs e) {
            Response.Redirect("~/Default.aspx");
        }

        public Button getSubmitButton() {
            return btnSubmitReport;
        }

        protected void GridView2_Sorting(object sender, GridViewSortEventArgs e) {
            //Retrieve the table from the session object.
            DataTable dt = Session["aqpTaskTable"] as DataTable;

            if (dt != null) {

                //Sort the data.
                dt.DefaultView.Sort = e.SortExpression + " " + GetSortDirection(e.SortExpression);
                getGridView().DataSource = dt;
                getGridView().DataBind();
            }
        }

        private string GetSortDirection(string column) {

            // By default, set the sort direction to ascending.
            string sortDirection = "ASC";

            // Retrieve the last column that was sorted.
            string sortExpression = ViewState["SortExpression"] as string;

            if (sortExpression != null) {
                // Check if the same column is being sorted.
                // Otherwise, the default value can be returned.
                if (sortExpression == column) {
                    string lastDirection = ViewState["SortDirection"] as string;
                    if ((lastDirection != null) && (lastDirection == "ASC")) {
                        sortDirection = "DESC";
                    }
                }
            }

            // Save new values in ViewState.
            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = column;

            return sortDirection;
        }
    }
}