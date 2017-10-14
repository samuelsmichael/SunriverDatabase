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
        public static string DataSetCacheKey = "CONDS";

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
            if (Utils.isNothingNot(tbSRContrRegID.Text)) {
                sb.Append(prepend + "SRContrRegID Id: " + tbSRContrRegID.Text);
                prepend = "  ";
                sbFilter.Append(and + " SRContrRegID = " + tbSRContrRegID.Text);
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
                ddlCategory1New.DataSource = dt;
                ddlCategory1New.DataBind();
                ddlCategory2New.DataSource = dt;
                ddlCategory2New.DataBind();
                ddlCategory3New.DataSource = dt;
                ddlCategory3New.DataBind();
                ddlCategory4New.DataSource = dt;
                ddlCategory4New.DataBind();

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
            SqlCommand cmd = new SqlCommand("uspContractorUpdate");
	        cmd.Parameters.Add("@SRContrRegID", SqlDbType.Int).Value=SRContrRegID;
	        cmd.Parameters.Add("@Reg_Date", SqlDbType.DateTime).Value= tbReg_DateUpdate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbReg_DateUpdate.Text);
            cmd.Parameters.Add("@Company",SqlDbType.NVarChar).Value=tbCompanyUpdate.Text;
            cmd.Parameters.Add("@Contact",SqlDbType.NVarChar).Value=tbContactUpdate.Text;
            cmd.Parameters.Add("@MailAddr1",SqlDbType.NVarChar).Value=tbMailAddr1Update.Text;
            cmd.Parameters.Add("@MailAddr2",SqlDbType.NVarChar).Value=tbMailAddr2Update.Text;
            cmd.Parameters.Add("@City",SqlDbType.NVarChar).Value=tbCityUpdate.Text;
            cmd.Parameters.Add("@State",SqlDbType.NVarChar).Value=tbStateUpdate.Text;
            cmd.Parameters.Add("@ZIP",SqlDbType.NVarChar).Value=tbZipUpdate.Text;
            cmd.Parameters.Add("@Phone_1",SqlDbType.NVarChar).Value=tbPhone1Update.Text;
            cmd.Parameters.Add("@Phone_2",SqlDbType.NVarChar).Value=tbPhone2Update.Text;
            cmd.Parameters.Add("@Fax",SqlDbType.NVarChar).Value=tbFaxUpdate.Text;
            cmd.Parameters.Add("@Email",SqlDbType.NVarChar).Value=tbEmailUpdate.Text;
            cmd.Parameters.Add("@Active",SqlDbType.NVarChar).Value=tbActiveUpdate.Text;
            cmd.Parameters.Add("@Lic_Number", SqlDbType.NVarChar).Value = tbLic_NumberUpdate.Text;
            cmd.Parameters.Add("@Lic_X_Date",SqlDbType.NVarChar).Value= tbLic_X_DateUpdate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbLic_X_DateUpdate.Text);;
            cmd.Parameters.Add("@CAT_1",SqlDbType.NVarChar).Value=ddlCategory1Update.SelectedValue;
            cmd.Parameters.Add("@CAT_2",SqlDbType.NVarChar).Value=ddlCategory2Update.SelectedValue;
            cmd.Parameters.Add("@CAT_3",SqlDbType.NVarChar).Value=ddlCategory3Update.SelectedValue;
            cmd.Parameters.Add("@CAT_4",SqlDbType.NVarChar).Value=ddlCategory4Update.SelectedValue;
            cmd.Parameters.Add("@Comment",SqlDbType.NVarChar).Value=tbCommentUpdate.Text;
            SqlParameter prmSRContrRegIDOut=new SqlParameter("@SRContrRegIDOut",SqlDbType.Int);
            prmSRContrRegIDOut.Direction=ParameterDirection.Output;
            cmd.Parameters.Add(prmSRContrRegIDOut);
            Utils.executeNonQuery(cmd, ConnectionString);
            performPostUpdateSuccessfulActions("Update successful", "CONDS", null);
        }
        protected void btnNewContractorOk_Click(object sender, EventArgs e) {
            SqlCommand cmd = new SqlCommand("uspContractorUpdate");
            cmd.Parameters.Add("@Reg_Date", SqlDbType.DateTime).Value = tbReg_DateNew.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbReg_DateNew.Text);
            cmd.Parameters.Add("@Company", SqlDbType.NVarChar).Value = tbCompanyNew.Text;
            cmd.Parameters.Add("@Contact", SqlDbType.NVarChar).Value = tbContactNew.Text;
            cmd.Parameters.Add("@MailAddr1", SqlDbType.NVarChar).Value = tbMailAddr1New.Text;
            cmd.Parameters.Add("@MailAddr2", SqlDbType.NVarChar).Value = tbMailAddr2New.Text;
            cmd.Parameters.Add("@City", SqlDbType.NVarChar).Value = tbCityNew.Text;
            cmd.Parameters.Add("@State", SqlDbType.NVarChar).Value = tbStateNew.Text;
            cmd.Parameters.Add("@ZIP", SqlDbType.NVarChar).Value = tbZipNew.Text;
            cmd.Parameters.Add("@Phone_1", SqlDbType.NVarChar).Value = tbPhone1New.Text;
            cmd.Parameters.Add("@Phone_2", SqlDbType.NVarChar).Value = tbPhone2New.Text;
            cmd.Parameters.Add("@Fax", SqlDbType.NVarChar).Value = tbFaxNew.Text;
            cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = tbEmailNew.Text;
            cmd.Parameters.Add("@Active", SqlDbType.NVarChar).Value = tbActiveNew.Text;
            cmd.Parameters.Add("@Lic_Number", SqlDbType.NVarChar).Value = tbLic_NumberNew.Text;
            cmd.Parameters.Add("@Lic_X_Date", SqlDbType.NVarChar).Value = tbLic_X_DateNew.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbLic_X_DateNew.Text); ;
            cmd.Parameters.Add("@CAT_1", SqlDbType.NVarChar).Value = ddlCategory1New.SelectedValue;
            cmd.Parameters.Add("@CAT_2", SqlDbType.NVarChar).Value = ddlCategory2New.SelectedValue;
            cmd.Parameters.Add("@CAT_3", SqlDbType.NVarChar).Value = ddlCategory3New.SelectedValue;
            cmd.Parameters.Add("@CAT_4", SqlDbType.NVarChar).Value = ddlCategory4New.SelectedValue;
            cmd.Parameters.Add("@Comment", SqlDbType.NVarChar).Value = tbCommentNew.Text;
            SqlParameter prmSRContrRegIDOut = new SqlParameter("@SRContrRegIDOut", SqlDbType.Int);
            prmSRContrRegIDOut.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(prmSRContrRegIDOut);
            Utils.executeNonQuery(cmd, ConnectionString);
            performPostNewSuccessfulActions("Contractor added", "CONDS", null, tbSRContrRegID, (int)prmSRContrRegIDOut.Value);
        }
        protected override void clearAllNewFormInputFields() {
            tbReg_DateNew.Text = "";
            tbCompanyNew.Text = "";
            tbContactNew.Text = "";
            tbMailAddr1New.Text = "";
            tbMailAddr2New.Text = "";
            tbCityNew.Text = "";
            tbStateNew.Text = "";
            tbZipNew.Text = "";
            tbPhone1New.Text = "";
            tbPhone2New.Text = "";
            tbFaxNew.Text = "";
            tbEmailNew.Text = "";
            tbActiveNew.Text = "";
            tbLic_NumberNew.Text = "";
            ddlCategory1New.SelectedIndex = 0;
            ddlCategory2New.SelectedIndex = 0;
            ddlCategory3New.SelectedIndex = 0;
            ddlCategory4New.SelectedIndex = 0;
            tbCommentNew.Text = "";
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
            tbMailAddr1Update.Enabled = false;
            tbMailAddr2Update.Enabled = false;
            tbCityUpdate.Enabled = false;
            tbStateUpdate.Enabled = false;
            tbZipUpdate.Enabled = false;
            tbLic_NumberUpdate.Enabled = false;
            tbLic_X_DateUpdate.Enabled = false;
            tbLic_X_DateUpdate.Enabled = false;
            tbActiveUpdate.Enabled = false;
            tbPhone1Update.Enabled = false;
            tbPhone2Update.Enabled = false;
            tbFaxUpdate.Enabled = false;
            tbEmailUpdate.Enabled = false;
            ddlCategory1Update.Enabled = false;
            ddlCategory2Update.Enabled = false;
            ddlCategory3Update.Enabled = false;
            ddlCategory4Update.Enabled = false;
            tbReg_DateUpdate.Enabled = false;
            tbCommentUpdate.Enabled = false;
            lbNewContractor.Enabled = false;
        }
        protected override void unlockYourUpdateFields() {
            tbCompanyUpdate.Enabled = true;
            tbContactUpdate.Enabled = true;
            btnContactUpdate.Enabled = true;
            tbMailAddr1Update.Enabled = true;
            tbMailAddr2Update.Enabled = true;
            tbCityUpdate.Enabled = true;
            tbStateUpdate.Enabled = true;
            tbZipUpdate.Enabled = true;
            tbLic_NumberUpdate.Enabled = true;
            tbLic_X_DateUpdate.Enabled = true;
            tbLic_X_DateUpdate.Enabled = true;
            tbActiveUpdate.Enabled = true;
            tbPhone1Update.Enabled = true;
            tbPhone2Update.Enabled = true;
            tbFaxUpdate.Enabled = true;
            tbEmailUpdate.Enabled = true;
            ddlCategory1Update.Enabled = true;
            ddlCategory2Update.Enabled = true;
            ddlCategory3Update.Enabled = true;
            ddlCategory4Update.Enabled = true;
            tbReg_DateUpdate.Enabled = true;
            tbCommentUpdate.Enabled = true;
            lbNewContractor.Enabled = true;
        }
        protected override string UpdateRoleName {
            get { return "canupdatecontractors"; }
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        public static string MyMenuName = "Contractor";
        protected override string childMenuName {
            get { return MyMenuName; }
        }
    }
}