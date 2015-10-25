using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using System.Text;

namespace SubmittalProposal {
    public partial class OwnerPropertyFinder : AbstractDatabase {
        private string CustomerIDBeingEdited {
            get {
                return Utils.ObjectToString(Session["CustomerIDBeingEdited"]);
            }
            set {
                Session["CustomerIDBeingEdited"] = value;
            }
        }
        private string rvSRPropIDBeingEdited {
            get {
                return Utils.ObjectToString(Session["rvSRPropIDBeingEdited"]);
            }
            set {
                Session["rvSRPropIDBeingEdited"]=value;
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            DataSet ds = null;
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            rvSRPropIDBeingEdited = Utils.ObjectToString(row.Cells[4].Text);
            CustomerIDBeingEdited = Utils.ObjectToString(row.Cells[5].Text);

            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "SRPropID='" + rvSRPropIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            #region Owner Information
            tbName.Text = Common.Utils.ObjectToString(dr["PrimaryOwner"]);
            tbOwnerId.Text = Common.Utils.ObjectToString(dr["OwnerID"]);
            tbContact.Text = Common.Utils.ObjectToString(dr["Contact"]);
            tbSunriverPhone.Text = Common.Utils.ObjectToString(dr["Phone"]);
            tbEmail.Text = Common.Utils.ObjectToString(dr["Email"]);
            return "Propery Id: " + rvSRPropIDBeingEdited + "    Owner Id: " + dr["OwnerID"] + "  Name:" + dr["PrimaryOwner"];
            #endregion
        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbNameSearch.Text)) {
                sb.Append(prepend + "Name: " + tbNameSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbNameSearch.Text, "PrimaryOwner"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " SRLot = '" + tbLot.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbPropertyID.Text)) {
                sb.Append(prepend + "Property ID: " + tbPropertyID.Text);
                prepend = "  ";
                sbFilter.Append(and + " SRPropID = '" + tbPropertyID.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " SRLane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }

        protected override GridView getGridViewResults() {
            return gvResults;
        }

        protected override System.Data.DataSet buildDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "CacheOwnerProperty";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspRVOwnersPropertyGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["SRPropID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        protected override System.Data.DataTable getGridViewDataTable() {
            return buildDataSet().Tables[0];
        }

        protected override Label getUpdateResultsLabel() {
            return lblDumbo;
        }
        /// <summary>
        /// I'm a web service
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSelect_Click(object sender, EventArgs e) {
            GetPageInfo gpi = new GetPageInfo();
            List<string> ls = new List<string>();
            ls.Add("PropertyID:"+rvSRPropIDBeingEdited);
            ls.Add("ClientID:"+CustomerIDBeingEdited);
            gpi.HeresYourData(ls);
            ClientScript.RegisterStartupScript(typeof(Page), "closePage", "window.close();", true);

        }
        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
           // Ne touchez rien ici dans ce method!
            btnSelect.Enabled = true;
        }

        protected override void lockYourUpdateFields() {
            tbContact.Enabled = false;
            tbEmail.Enabled = false;
            tbName.Enabled = false;
            tbSunriverPhone.Enabled = false;
            tbOwnerId.Enabled = false;
            btnSelect.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            tbLot.Text = "";
            tbNameSearch.Text = "";
            ddlLane.SelectedIndex = 0;
        }

        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }

        protected override string UpdateRoleName {
            get { return "all"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
            }
       }
    }
}