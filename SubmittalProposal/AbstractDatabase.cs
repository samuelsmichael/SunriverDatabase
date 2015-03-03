using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;

namespace SubmittalProposal {
    public abstract class AbstractDatabase : System.Web.UI.Page {
        protected abstract string gvResults_DoSelectedIndexChanged(object sender, EventArgs e);
        protected abstract string performSubmittalButtonClick();
        protected abstract GridView getGridViewResults();
        protected abstract DataSet buildDataSet();
        protected abstract DataTable getGridViewDataTable();
        protected abstract void childPageLoad(object sender, EventArgs e);

        protected void Page_Load(object sender, EventArgs e) {
            Database database = (Database)Master;
            database.SearchButtonPressed += new Database.SearchButtonPressedEventHandler(database_SearchButtonPressed);
            childPageLoad(sender, e);
        }
        protected void gvResults_SelectedIndexChanged(object sender, EventArgs e) {
            string expandedText = gvResults_DoSelectedIndexChanged(sender, e);
            ((Database)Master).getCPEForm.ExpandedText = expandedText;
            ((Database)Master).getCPEForm.CollapsedText = expandedText;
            ((Database)Master).getCPEForm.Collapsed = false;
            ((Database)Master).getCPEForm.ClientState = "false";
            ((Database)Master).getCPEDataGrid.Collapsed = true;
            ((Database)Master).getCPEDataGrid.ClientState = "true";
            ((Database)Master).getPanelForm.Visible = true;
        }

        protected string database_SearchButtonPressed() {
/* this seems to cause sync problems            getGridViewResults().SelectedIndex = -1;*/
            return performSubmittalButtonClick();
            
        }
        protected void gvResults_Sorting(object sender, GridViewSortEventArgs e) {
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            if (ViewState["sortExpression"] == null) {
                ViewState["sortExpression"] = e.SortExpression + " desc";
            }
            string[] sortData = ViewState["sortExpression"].ToString().Trim().Split(' ');
            if (e.SortExpression == sortData[0]) {
                if (sortData[1] == "ASC") {
                    view.Sort = e.SortExpression + " " + "DESC";
                    this.ViewState["sortExpression"] = e.SortExpression + " " + "DESC";
                } else {
                    view.Sort = e.SortExpression + " " + "ASC";
                    this.ViewState["sortExpression"] = e.SortExpression + " " + "ASC";
                }
            } else {
                view.Sort = e.SortExpression + " " + "ASC";
                this.ViewState["sortExpression"] = e.SortExpression + " " + "ASC";
            }
            DataTable tblOrdered = view.ToTable();
            ((GridView)sender).DataSource = tblOrdered;
            ((GridView)sender).DataBind();
        }
    }
}