using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using Common;
using System.Text;

namespace SubmittalProposal {

    public partial class OwnerProperty : AbstractDatabase, ICanHavePDFs {
        public static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString;
            }
        }
        private string CustomerIDBeingEdited {
            get {
                return Utils.ObjectToString(Session["opCustomerIDBeingEdited"]);
            }
            set {
                Session["opCustomerIDBeingEdited"] = value;
            }
        }
        private string SRPropIDBeingEdited {
            get {
                return Utils.ObjectToString(Session["opSRPropIDBeingEdited"]);
            }
            set {
                Session["opSRPropIDBeingEdited"] = value;
            }
        }
        protected override System.Data.DataSet buildDataSet() {
            return OPDataSet();
        }

        public static DataSet OPDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "OWPRDS";
            ds = (DataSet)cache[key];
            if (ds == null) {
                ds = Utils.getDataSetFromQuery("SELECT * FROM qryLotLaneWithOwners_Master", ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["SRPropID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        protected override void clearAllSelectionInputFields() {
            tbLot.Text = "";
            tbNameSearch.Text = "";
            ddlLane.SelectedIndex = 0;
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
            if (Utils.isNothingNot(tbDCAddress.Text)) {
                sb.Append(prepend + "DC Address: " + tbDCAddress.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbDCAddress.Text, "DC_Address"));
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            DataSet ds = null;
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            SRPropIDBeingEdited = Utils.ObjectToString(row.Cells[5].Text.Trim());
            CustomerIDBeingEdited = Utils.ObjectToString(row.Cells[6].Text.Trim());
            SetLaneLotForPDFs(Utils.ObjectToString(row.Cells[2].Text) + " " + Utils.ObjectToString(row.Cells[1].Text));

            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "SRPropID='" + SRPropIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            Session["OwnerPropertyTblFiltered"] = tblFiltered;
            DataRow dr = tblFiltered.Rows[0];
            #region Owner Information
            tbNameUpdate.Text = Common.Utils.ObjectToString(dr["PrimaryOwner"]);
            tbOwnerIdUpdate.Text = Common.Utils.ObjectToString(dr["CustId"]);
            tbContactUpdate.Text = Common.Utils.ObjectToString(dr["Contact"]);
            tbSunriverPhoneUpdate.Text = Common.Utils.ObjectToString(dr["Phone"]);
            tbEmailUpdate.Text = Common.Utils.ObjectToString(dr["Email"]);
            tbMailAddr1Update.Text = Common.Utils.ObjectToString(dr["Addr1"]);
            tbMailAddr2Update.Text = Common.Utils.ObjectToString(dr["Addr2"]);
            tbMailCityUpdate.Text = Common.Utils.ObjectToString(dr["City"]);
            tbMailStateUpdate.Text = Common.Utils.ObjectToString(dr["Region"]);
            tbMailCountryUpdate.Text = Common.Utils.ObjectToString(dr["Country"]);
            tbMailZipUpdate.Text = Common.Utils.ObjectToString(dr["PostalCode"]);
            tbFaxUpdate.Text=Common.Utils.ObjectToString(dr["Fax"]);
            tbInternetUpdate.Text=Common.Utils.ObjectToString(dr["Internet"]);
            tbDCTaxLotIDUpdate.Text = Common.Utils.ObjectToString(dr["DC_TaxLotID"]);
            tbPropIDUpdate.Text = SRPropIDBeingEdited;
            tbPropertyAddrUpdate.Text=Common.Utils.ObjectToString(dr["LotLane"]);
            tbPurchaseDateUpdate.Text = Utils.ObjectToDateTime(dr["LastSaleDate"]).ToString("d");
            tbDCAddressUpdate.Text = Utils.ObjectToString(dr["DC_Address"]);
            return "Propery Id: " + SRPropIDBeingEdited + "    Owner Id: " + dr["CustId"] + "  Name: " + dr["PrimaryOwner"];
            #endregion
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override Label getUpdateResultsLabel() {
            return lblDumbo;
        }
        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }
        protected override void unlockYourUpdateFields() {
        }
        protected override void lockYourUpdateFields() {
            tbContactUpdate.Enabled=false;
            tbEmailUpdate.Enabled = false;
            btnSubmitUpdate.Visible = false;
            tbSunriverPhoneUpdate.Enabled = false;
            tbNameUpdate.Enabled = false;
            tbOwnerIdUpdate.Enabled = false;
            tbMailZipUpdate.Enabled = false;
            tbMailCountryUpdate.Enabled = false;
            tbMailStateUpdate.Enabled = false;
            tbMailCityUpdate.Enabled = false;
            tbMailAddr2Update.Enabled = false;
            tbMailAddr1Update.Enabled = false;
            tbFaxUpdate.Enabled = false;
            tbInternetUpdate.Enabled = false;
            tbPropIDUpdate.Enabled = false;
            tbDCTaxLotIDUpdate.Enabled = false;
            tbPropertyAddrUpdate.Enabled = false;
            tbPurchaseDateUpdate.Enabled = false;
            tbDCAddressUpdate.Enabled = false;
        }
        protected override string UpdateRoleName {
            // This role doesn't currently exist.  But, just in case we some day make the Owner+Property database updatable, here it is.
            get {
                throw new Exception("Database isn't updatable");
            }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return buildDataSet().Tables[0];
        }
        protected void btnSubmitUpdate_Click(object sender, EventArgs e) {
        }
        public static string MyMenuName = "Owner/Property";
        protected override string childMenuName {
            get { return MyMenuName; }
        }
        public bool HasPropertyAvailable {
            get { return Utils.isNothingNot(SRPropIDBeingEdited); }
        }

        public void SetLaneLotForPDFs(string lanelot) {
            LaneLotForPDFs = lanelot;
        }
    }
}