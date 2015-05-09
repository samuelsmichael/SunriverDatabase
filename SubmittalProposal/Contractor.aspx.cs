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
    public partial class Contractor : AbstractDatabase {
        public static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["ContractorRegSQLConnectionString"].ConnectionString;
            }
        }
        public static DataSet CRDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "CONDS";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspContractorTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["Category"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["SRContrRegID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbCompanyName.Text)) {
                sb.Append(prepend + "Company: " + tbCompanyName.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbCompanyName.Text, "Company"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbContactName.Text)) {
                sb.Append(prepend + "Contact: " + tbContactName.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbContactName.Text, "Contact"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbLicenseNumber.Text)) {
                sb.Append(prepend + "License #: " + tbLicenseNumber.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbLicenseNumber.Text, "Lic_Number"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbCategory.Text)) {
                sb.Append(prepend + "Category: " + tbCategory.Text);
                prepend = "  ";
                sbFilter.Append(and + " (");
                sbFilter.Append(Common.Utils.getDataViewQuery(tbCategory.Text, "CAT_1"));
                sbFilter.Append(" OR ");
                sbFilter.Append(Common.Utils.getDataViewQuery(tbCategory.Text, "CAT_2"));
                sbFilter.Append(" OR ");
                sbFilter.Append(Common.Utils.getDataViewQuery(tbCategory.Text, "CAT_3"));
                sbFilter.Append(" OR ");
                sbFilter.Append(Common.Utils.getDataViewQuery(tbCategory.Text, "CAT_4"));
                sbFilter.Append(")");
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }
        protected override System.Data.DataSet buildDataSet() {
            return CRDataSet();
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                DataTable dt = CRDataSet().Tables[0];
                DataRow dr=dt.NewRow();
                dr["Category"]="";
                try { // it might already exist
                    dt.Rows.InsertAt(dr, 0);
                } catch { }
                ddlCategory1Update.DataSource = dt;
                ddlCategory1Update.DataBind();
                ddlCategory2Update.DataSource = dt;
                ddlCategory2Update.DataBind();
                ddlCategory3Update.DataSource = dt;
                ddlCategory3Update.DataBind();
                ddlCategory4Update.DataSource = dt;
                ddlCategory4Update.DataBind();
            }
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return CRDataSet().Tables[1];
        }
        protected override void clearAllSelectionInputFields() {
            tbCompanyName.Text = "";
            tbContactName.Text = "";
            tbLicenseNumber.Text = "";
            tbCategory.Text = "";
        }
        private int SRContrRegID {
            get {
                object obj = ViewState["SRContrRegID"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                ViewState["SRContrRegID"] = value;
            }
        }
        private int getSRContrRegID(GridViewRow dr) {
            return Convert.ToInt32(dr.Cells[8].Text);
        }
        private string getCompany(DataRow dr) {
            return Utils.ObjectToString(dr["Company"]);
        }
        private string getContact(DataRow dr) {
            return Utils.ObjectToString(dr["Contact"]);
        }
        private DateTime? getLicXDate(DataRow dr) {
            try {
                return (DateTime?)dr["Lic_X_Date"];
            } catch {
                return (DateTime?)null;
            }
        }
        private DateTime? getRegDate(DataRow dr) {
            try {
                return (DateTime?)dr["Reg_Date"];
            } catch {
                return (DateTime?)null;
            }
        }
        private string getLicenseNumber(DataRow dr) {
            return Utils.ObjectToString(dr["Lic_Number"]);
        }
        private string getAddr1(DataRow dr) {
            return Utils.ObjectToString(dr["MailAddr1"]);
        }
        private string getAddr2(DataRow dr) {
            return Utils.ObjectToString(dr["MailAddr2"]);
        }
        private string getCity(DataRow dr) {
            return Utils.ObjectToString(dr["City"]);
        }
        private string getState(DataRow dr) {
            return Utils.ObjectToString(dr["State"]);
        }
        private string getZip(DataRow dr) {
            return Utils.ObjectToString(dr["Zip"]);
        }
        private string getPhone1(DataRow dr) {
            return Utils.ObjectToString(dr["Phone_1"]);
        }
        private string getPhone2(DataRow dr) {
            return Utils.ObjectToString(dr["Phone_2"]);
        }
        private string getFax(DataRow dr) {
            return Utils.ObjectToString(dr["Fax"]);
        }
        private string getEmail(DataRow dr) {
            return Utils.ObjectToString(dr["Email"]);
        }
        private string getActive(DataRow dr) {
            return Utils.ObjectToString(dr["Active"]);
        }
        private string getCategory1(DataRow dr) {
            return Utils.ObjectToString(dr["CAT_1"]);
        }
        private string getCategory2(DataRow dr) {
            return Utils.ObjectToString(dr["CAT_2"]);
        }
        private string getCategory3(DataRow dr) {
            return Utils.ObjectToString(dr["CAT_3"]);
        }
        private string getCategory4(DataRow dr) {
            return Utils.ObjectToString(dr["CAT_4"]);
        }
        private string getComment(DataRow dr) {
            return Utils.ObjectToString(dr["Comment"]);
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            SRContrRegID = getSRContrRegID(row);
            DataRow dr = getGridViewDataTable().Rows.Find(SRContrRegID);
            DateTime? lic_x_date = getLicXDate(dr);
            DateTime? reg_date = getRegDate(dr);

            tbCompanyUpdate.Text = getCompany(dr);
            tbContactUpdate.Text = getContact(dr);
            tbMailAddr1Update.Text = getAddr1(dr);
            tbMailAddr2Update.Text = getAddr2(dr);
            tbCityUpdate.Text = getCity(dr);
            tbStateUpdate.Text = getState(dr);
            tbZipUpdate.Text = getZip(dr);
            tbPhone1Update.Text = getPhone1(dr);
            tbPhone2Update.Text = getPhone2(dr);
            tbFaxUpdate.Text = getFax(dr);
            tbEmailUpdate.Text = getEmail(dr);
            tbActiveUpdate.Text = getActive(dr);

            tbLic_X_DateUpdate.Text = lic_x_date.HasValue ? lic_x_date.Value.ToString("MM/dd/yyyy") : "";
            tbLic_NumberUpdate.Text = getLicenseNumber(dr);
            tbReg_DateUpdate.Text = reg_date.HasValue ? reg_date.Value.ToString("MM/dd/yyyy") : "";
            string category1 = getCategory1(dr);
            ddlCategory1Update.SelectedValue = category1==null?"":category1;
            string category2 = getCategory2(dr);
            ddlCategory2Update.SelectedValue = category2 == null ? "" : category2;
            string category3 = getCategory3(dr);
            ddlCategory3Update.SelectedValue = category3 == null ? "" : category3;
            string category4 = getCategory4(dr);
            ddlCategory4Update.SelectedValue = category4 == null ? "" : category4;

            tbCommentUpdate.Text = getComment(dr);

            return "SRContrRegID: " + SRContrRegID + "     Company: " + getCompany(dr) + "     Contact: " + getContact(dr);
        }
        protected void btnContractorUpdate_Click(object sender, EventArgs e) {
        }
        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }
        protected override Label getUpdateResultsLabel() {
            return lblContactUpdateResults;
        }
        protected override void lockYourUpdateFields() {
            tbCompanyUpdate.Enabled = false;
            tbContactUpdate.Enabled = false;
            btnContactUpdate.Enabled = false;
        }
        protected override void unlockYourUpdateFields() {
            tbCompanyUpdate.Enabled = true;
            tbContactUpdate.Enabled = true;
            btnContactUpdate.Enabled = true;
        }
        protected override string UpdateRoleName {
            get { return "canupdatecontractors"; }
        }
    }
}