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
    public partial class BallotVerify : AbstractDatabase {
        public static string DataSetCacheKey = "BVDATASETCACHEKEY";
        private int BallotVerifyIdSelected {
            get {
                object obj = Session["BallotVerifyIdSelected"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["BallotVerifyIdSelected"] = value;
            }
        }
        public static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["BallotVerifySQLConnectionString"].ConnectionString;
            }
        }
        public static DataSet CIDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = DataSetCacheKey;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspBallotVerifyTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        protected void btnBallotVerifyUpdateOkay_Click(object sender, EventArgs e) {
            try {
                SqlCommand cmd = new SqlCommand("uspBallotVerifyUpdate");
                cmd.Parameters.Add("@BallotVerifyID", SqlDbType.Int).Value = BallotVerifyIdSelected;
                cmd.Parameters.Add("@Voted", SqlDbType.Bit).Value = cbVotedUpdate.Checked;
                Utils.executeNonQuery(cmd, ConnectionString);
                performPostUpdateSuccessfulActions("Update successful", DataSetCacheKey, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }

        public void postUpdateBallotFunction() {
            try {
                if (!((Database)Master).getCPEDataGrid.Collapsed) {
                    System.Runtime.Caching.MemoryCache.Default.Remove(BallotVerify.DataSetCacheKey);
                    ((Database)Master).doGo();
                }
            } catch { }
        }

        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            BallotVerifyIdSelected =(int)getGridViewResults().DataKeys[gvResults.SelectedRow.RowIndex].Value;
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "BallotVerifyId=" + BallotVerifyIdSelected;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            tbPropertyIdUpdate.Text = Utils.ObjectToString(dr["PropID"]);
            tbCustomrIdUpdate.Text= Utils.ObjectToString(dr["CustID"]);
            tbGroupCodeUpdate.Text=Utils.ObjectToString(dr["GroupCode"]);
            cbVotedUpdate.Checked=Utils.ObjectToBool(dr["Voted"]);
            tbOwnerNameUpdate.Text = Utils.ObjectToString(dr["OwnerName"]);
            tbCustAddr1Update.Text = Utils.ObjectToString(dr["tblArCust_Addr1"]);
            tbCustAddr2Update.Text = Utils.ObjectToString(dr["Addr2"]);
            tbContactUpate.Text = Utils.ObjectToString(dr["Contact"]);
            tbSunriverAddrUpdate.Text = Utils.ObjectToString(dr["tblArShipTo_Addr1"]);
            tbPostalCodeUpdate.Text = Utils.ObjectToString(dr["PostalCode"]);

            return "Name: " +  Utils.ObjectToString(dr["OwnerName"]) + "PropertyId: "+Utils.ObjectToString(dr["PropID"]) + "CustId: "+Utils.ObjectToString(dr["CustID"]);
        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbCustdIdSearch.Text)) {
                sb.Append(prepend + "Customer ID: " + tbCustdIdSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + " CustId = '" + tbCustdIdSearch.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbPropertyIdSearch.Text)) {
                sb.Append(prepend + "Property ID: " + tbPropertyIdSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + " PropID = '" + tbPropertyIdSearch.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLaneSearch.SelectedValue) && ddlLaneSearch.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLaneSearch.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(ddlLaneSearch.SelectedValue, "tblArShipTo_Addr1"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbLotSearch.Text)) {
                sb.Append(prepend + "Lot: " + tbLotSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbLotSearch.Text, "tblArShipTo_Addr1"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbNameSearch.Text)) {
                sb.Append(prepend + "Owner Name: " + tbNameSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbNameSearch.Text, "OwnerName"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbAddressSearch.Text)) {
                sb.Append(prepend + "Owner Address: " + tbAddressSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbAddressSearch.Text, "tblArCust_Addr1"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbPostalCodeSearch.Text)) {
                sb.Append(prepend + "Postal Code: " + tbPostalCodeSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbPostalCodeSearch.Text, "PostalCode"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlVotedSearch.SelectedValue)) {
                sb.Append(prepend + "Voted: " + ddlVotedSearch.SelectedValue);
                prepend = "  ";
                if (ddlVotedSearch.SelectedValue == "Yes") {
                    sbFilter.Append(and + " Voted = 'X'");
                } else {
                    sbFilter.Append(and + " (Voted is null or Voted <> 'X')");
                }
                and = " and ";
            }

            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }

        protected string getVoted(object value) {
            return Utils.ObjectToString(value);
        }


        protected override GridView getGridViewResults() {
            return gvResults;
        }

        protected override System.Data.DataSet buildDataSet() {
            return CIDataSet();
        }

        protected override System.Data.DataTable getGridViewDataTable() {
            DataSet ds = buildDataSet();
            return ds.Tables[0];
        }

        protected override Label getUpdateResultsLabel() {
            return BallotVerifyUpdateResultsId;
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            cbVotedUpdate.Enabled = true;
            btnBallotVerifyUpdate.Visible = true;
        }

        protected override void lockYourUpdateFields() {
            cbVotedUpdate.Enabled = false;
            btnBallotVerifyUpdate.Visible = false;
        }

        protected override void clearAllSelectionInputFields() {
            tbLotSearch.Text = "";
            tbNameSearch.Text = "";
            ddlLaneSearch.SelectedIndex = 0;
            tbCustdIdSearch.Text = "";
            tbPropertyIdSearch.Text = "";
            tbAddressSearch.Text = "";
            tbPostalCodeSearch.Text = "";
            ddlVotedSearch.SelectedIndex = 0;
        }

        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }

        protected override string UpdateRoleName {
            get { return "canupdateballotverify"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            MemoryCache cache = MemoryCache.Default;
            cache.Remove("BVDATASETCACHEKEY");
            expandCPESearch();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLaneSearch.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLaneSearch.DataBind();
            }
        }
        public static string MyMenuName = "Ballot Verify";
        protected override string childMenuName {
            get { return MyMenuName; }
        }
    }
}