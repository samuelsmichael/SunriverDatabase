using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Runtime.Caching;

namespace SubmittalProposal {
    public abstract class AbstractDatabase : System.Web.UI.Page {
        protected abstract string gvResults_DoSelectedIndexChanged(object sender, EventArgs e);
        protected abstract void performSubmittalButtonClick(out string searchCriteria, out string filterString);
        protected abstract GridView getGridViewResults();
        protected abstract DataSet buildDataSet();
        protected abstract DataTable getGridViewDataTable();
        protected abstract Label getUpdateResultsLabel();
        protected abstract Label getNewResultsLabel();
        protected abstract void unlockYourUpdateFields();
        protected abstract void lockYourUpdateFields();
        protected abstract void clearAllSelectionInputFields();
        protected abstract string UpdateRoleName { get; }
        
        protected abstract void childPageLoad(object sender, EventArgs e);

        protected void Page_Load(object sender, EventArgs e) {
            Database database = (Database)Master;
            database.SearchButtonPressed += new Database.SearchButtonPressedEventHandler(database_SearchButtonPressed);
            database.UnlockCheckboxChecked += new Database.UnlockCheckboxCheckedHandler(database_UnlockCheckboxChecked);
            childPageLoad(sender, e);
            ((SiteMaster)Master.Master.Master).HomePageImOnSinceMenuItemClickDoesntWork = GetType().Name;
            if (HttpContext.Current.User.IsInRole(UpdateRoleName)) {
                ((Database)Master).enableUnlockRecordCheckbox(true);
            } else {
                ((Database)Master).enableUnlockRecordCheckbox(false);
            }
        }

        void database_UnlockCheckboxChecked(bool isUnlocked) {
            if (isUnlocked) {
                unlockYourUpdateFields();
            } else {
                lockYourUpdateFields();
            }
        }

        protected void performPostUpdateSuccessfulActions(string status, string cacheKey, string cacheKey2) {
            MemoryCache.Default.Remove(cacheKey);
            if (cacheKey2 != null) {
                MemoryCache.Default.Remove(cacheKey2);
            }
            /* the following statements cause the view to be re-displayed, but with updated data */
            ((Database)Master).doGo();
            do_gvResults_SelectedIndexChanged();
            getUpdateResultsLabel().ForeColor = System.Drawing.Color.DarkGreen;
            getUpdateResultsLabel().Text = status;
            ((Database)Master).getCPEForm.Collapsed = false;
            ((Database)Master).getCPEForm.ClientState = "false";
            ((Database)Master).getCPEDataGrid.Collapsed = true;
            ((Database)Master).getCPEDataGrid.ClientState = "true";
            ((Database)Master).getPanelForm.Visible = true;

        }
        protected void performPostUpdateFailedActions(string status) {
            getUpdateResultsLabel().ForeColor = System.Drawing.Color.Red;
            getUpdateResultsLabel().Text = status;
        }
        protected void performPostNewFailedActions(string status) {
            getNewResultsLabel().ForeColor = System.Drawing.Color.Red;
            getNewResultsLabel().Text = status;
        }
        protected void performPostNewSuccessfulActions(string status, string cacheKey, string cacheKey2, TextBox tbHavingKeyField, int key) {
            MemoryCache.Default.Remove(cacheKey);
            if (cacheKey2 != null) {
                MemoryCache.Default.Remove(cacheKey2);
            }
            /* the following statements cause the view to be re-displayed, but with updated data */
            clearAllSelectionInputFields();
            tbHavingKeyField.Text = "" + key;
            ((Database)Master).doGo();
            getGridViewResults().SelectedIndex = 0;
            do_gvResults_SelectedIndexChanged();
            getUpdateResultsLabel().ForeColor = System.Drawing.Color.DarkGreen;
            getUpdateResultsLabel().Text = status;
            ((Database)Master).getCPEForm.Collapsed = false;
            ((Database)Master).getCPEForm.ClientState = "false";
            ((Database)Master).getCPEDataGrid.Collapsed = true;
            ((Database)Master).getCPEDataGrid.ClientState = "true";
            ((Database)Master).getPanelForm.Visible = true;
        }

        protected void gvResults_SelectedIndexChanged(object sender, EventArgs e) {
            ((Database)Master).clearUnlockRecordCheckbox();
            string expandedText = gvResults_DoSelectedIndexChanged(sender, e);
            ((Database)Master).getCPEForm.ExpandedText = expandedText;
            ((Database)Master).getCPEForm.CollapsedText = expandedText;
            ((Database)Master).getCPEForm.Collapsed = false;
            ((Database)Master).getCPEForm.ClientState = "false";
            ((Database)Master).getCPEDataGrid.Collapsed = true;
            ((Database)Master).getCPEDataGrid.ClientState = "true";
            ((Database)Master).getPanelForm.Visible = true;
            getUpdateResultsLabel().Text = "";
        }

        public void do_gvResults_SelectedIndexChanged() {
            gvResults_SelectedIndexChanged(null, null);
        }

        protected void database_SearchButtonPressed(out string searchCriteria, out DataTable filteredData) {
/* this seems to cause sync problems            getGridViewResults().SelectedIndex = -1;*/
            searchCriteria=String.Empty;
            string filterString=String.Empty;
            DataTable tblFiltered = null;
            performSubmittalButtonClick(out searchCriteria, out filterString);
            if (Utils.isNothingNot(filterString)) {
                DataTable sourceTable = getGridViewDataTable();
                DataView view = new DataView(sourceTable);
                view.RowFilter = filterString;
                tblFiltered = view.ToTable();
                getGridViewResults().DataSource = tblFiltered;
                getGridViewResults().DataBind();
            } else {
                tblFiltered=getGridViewDataTable();
                getGridViewResults().DataSource = tblFiltered;
                getGridViewResults().DataBind();
            }
            filteredData = tblFiltered;
        }
        protected void gvResults_PageIndexChanging(object sender, GridViewPageEventArgs e) {
            getGridViewResults().PageIndex = e.NewPageIndex;
            string searchCriteria;
            DataTable filteredData;
            database_SearchButtonPressed(out searchCriteria, out filteredData);
            if (ViewState["sortExpression"] != null) {
                DataView dv = filteredData.AsDataView();
                dv.Sort = (string)ViewState["sortExpression"];
                filteredData = dv.ToTable();
            }
            getGridViewResults().DataSource = filteredData;
            getGridViewResults().DataBind();
        }
        protected void gvResults_Sorting(object sender, GridViewSortEventArgs e) {
            DataTable sourceTable=null;
            string dummySearchCriteria=null;
            database_SearchButtonPressed(out dummySearchCriteria, out sourceTable);
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