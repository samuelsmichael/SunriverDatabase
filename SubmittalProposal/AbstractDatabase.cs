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
    public abstract class AbstractDatabase : System.Web.UI.Page, HasMenuName {
        /// <summary>
        /// This method is called by the framework when this database is called the first time in the session.
        /// I do "expandCPESearch()", which will make sure that the Search accordion panel is opened for the user to
        /// enter search values inl
        /// </summary>
        protected abstract void weveComeHereForTheFirstTimeThisSession();
        /// <summary>
        /// The framework is going to ask you to provide it with a DataSet that represents this databases data.
        /// This is where you do this.
        /// </summary>
        /// <returns>A DataSet that consists of all of the tables for this "database"</returns>
        protected abstract DataSet buildDataSet();
        protected abstract string gvResults_DoSelectedIndexChanged(object sender, EventArgs e);
        protected abstract void performSubmittalButtonClick(out string searchCriteria, out string filterString);
        protected abstract GridView getGridViewResults();
        protected abstract DataTable getGridViewDataTable();
        protected abstract Label getUpdateResultsLabel();
        protected abstract Label getNewResultsLabel();
        protected abstract void unlockYourUpdateFields();
        protected abstract void lockYourUpdateFields();
        protected abstract void clearAllSelectionInputFields();
        protected abstract void clearAllNewFormInputFields();
        protected abstract string childMenuName { get; }
        /// <summary>
        /// If this database doesn't allow updating, then throw an exception in here. Otherwise,
        /// return the role you've created for updating this database.  ALL LOWERCASE!
        /// </summary>
        protected abstract string UpdateRoleName { get; }
        /// <summary>
        /// the framework will call this method while it’s in the middle of handling the Page_Load hook.  
        /// So, do your own database-specific “page load” things.  What do you do in a Page_Load? 
        /// First of all, always make this method’s structure look like this:
        /*
                protected override void childPageLoad(object sender, EventArgs e) {
                    if (!IsPostBack) {
                        // Do stuff that you need to do only once when the page is accessed.
                        // For example:  Initialize static dropdown's.
                    } else {
                        // Here is where you do things that you need to do when
                        // a "postback" occurs.  What's a "postback"?  It's when
                        // the user has clicked a button, or does something else
                        // that causes the system to post back to the server.
                    }
                    // Do anything here that needs to be done every time the client 
                    // accesses this page.
                }
        */

        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected abstract void childPageLoad(object sender, EventArgs e);

        public string MenuName { get { return childMenuName; } }

        protected void Page_Load(object sender, EventArgs e) {
            Database database = (Database)Master;
            database.SearchButtonPressed += new Database.SearchButtonPressedEventHandler(database_SearchButtonPressed);
            database.UnlockCheckboxChecked += new Database.UnlockCheckboxCheckedHandler(database_UnlockCheckboxChecked);
            if (Session[GetType().Name] == null) {
                Session[GetType().Name] = "didit";
                weveComeHereForTheFirstTimeThisSession();
            }
            childPageLoad(sender, e);
            ((SiteMaster)Master.Master.Master).HomePageImOnSinceMenuItemClickDoesntWork = GetType().Name;
            try { // In this framework, if UpdateRoleName throws an exception, then this means that the database isn't updatable (yet).
                string zUpdateRoleName = UpdateRoleName;
                if (UpdateRoleName == "all" || HttpContext.Current.User.IsInRole(UpdateRoleName)) {
                    ((Database)Master).enableUnlockRecordCheckbox(true);
                } else {
                    ((Database)Master).enableUnlockRecordCheckbox(false);
                }
            } catch {
                ((Database)Master).setUnlockRecordCheckboxVisibility(false);
                lockYourUpdateFields();
            }
        }

        void database_UnlockCheckboxChecked(bool isUnlocked) {
            if (isUnlocked) {
                unlockYourUpdateFields();
            } else {
                lockYourUpdateFields();
            }
        }

        public void performPostUpdateSuccessfulActions(string status, string cacheKey, string cacheKey2) {
            MemoryCache.Default.Remove(cacheKey);
            if (cacheKey2 != null) {
                MemoryCache.Default.Remove(cacheKey2);
            }
            /* the following statements cause the view to be re-displayed, but with updated data */
            try {
                ((Database)Master).doGo();
            } catch {
                int x = 3;
                int u = x;
            }
            try {
                do_gvResults_SelectedIndexChanged();
            } catch {
                int u = 7;
                int l = 8;
            }
            getUpdateResultsLabel().ForeColor = System.Drawing.Color.DarkGreen;
            getUpdateResultsLabel().Text = status;
            ((Database)Master).getCPEForm.Collapsed = false;
            ((Database)Master).getCPEForm.ClientState = "false";
            ((Database)Master).getCPEDataGrid.Collapsed = true;
            ((Database)Master).getCPEDataGrid.ClientState = "true";
            ((Database)Master).getPanelForm.Visible = true;

        }
        protected void expandCPESearch() {
            ((Database)Master).expandCPESearch();
        }

        protected void performPostUpdateFailedActions(string status) {
            getUpdateResultsLabel().ForeColor = System.Drawing.Color.Red;
            getUpdateResultsLabel().Text = status;
        }
        protected void performPostNewFailedActions(string status) {
            getNewResultsLabel().ForeColor = System.Drawing.Color.Red;
            getNewResultsLabel().Text = status;
        }
        protected void performPostNewSuccessfulActions(string status, string cacheKey, string cacheKey2, TextBox tbHavingKeyField, object key) {
            MemoryCache.Default.Remove(cacheKey);
            if (cacheKey2 != null) {
                MemoryCache.Default.Remove(cacheKey2);
            }
            /* the following statements cause the view to be re-displayed, but with updated data */
            clearAllSelectionInputFields();
            clearAllNewFormInputFields();
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

        protected string LaneLotForPDFs {
            get {
                return Utils.ObjectToString(Session["LaneLotForPDFs"]);
            }
            set {
                Session["LaneLotForPDFs"] = value;
            }
        }


        protected void gvResults_SelectedIndexChanged(object sender, EventArgs e) {
            ((Database)Master).getFetchErrorMessageControl().Visible = false;
            ((Database)Master).clearUnlockRecordCheckbox();
            string expandedText = null;
            try {
                expandedText = gvResults_DoSelectedIndexChanged(sender, e);
            } catch (Exception ee) {
                ((Database)Master).getFetchErrorMessageControl().Text="Problems fetching the data. The data on the Form screen is probably incorrect.  Msg: '"+ee.Message;
                ((Database)Master).getFetchErrorMessageControl().Visible = true;
                return;
            }
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