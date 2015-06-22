using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using System.Configuration;
using System.Globalization;

namespace SubmittalProposal {
    public partial class IDCardManagement : AbstractDatabase {
        public static DataSet CRDataSet() {
            DataSet dsTii = new DataSet();
            SqlCommand cmd = null;
            MemoryCache cache = MemoryCache.Default;
            /* Top Dropdown -- Find by Lot Number Order */
            string key = "CRDSTopDropdownFindByLotNumberOrder";
            DataTable dt = (DataTable)cache[key];
            if (dt == null) {
                cmd = new SqlCommand("uspCustomerInfoByLotLaneGet");
                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                dt = ds.Tables[0];
                dt.Columns.Add(new DataColumn("SrLotLaneOwner"));
                int maxLenLotLane = 0;
                foreach (DataRow dr in dt.Rows) {
                    int len = ((string)dr["SRLotLane"]).Length;
                    if (len > maxLenLotLane) {
                        maxLenLotLane = len;
                    }
                }
                foreach (DataRow dr2 in dt.Rows) {
                    dr2["SrLotLaneOwner"] = Utils.PadString((string)dr2["SRLotLane"], Utils.PAD_DIRECTION.RIGHT, maxLenLotLane + 2, '\xA0') + dr2["CustName"];
                }
                DataRow dr3 = dt.NewRow();
                dr3["SRLotLane"] = "";
                dr3["CustName"] = "";
                dr3["LotSortValue"] = 0;
                dr3["PropIDBarCustId"] = "";
                dr3["SrLotLaneOwner"] = "";
                dt.Rows.InsertAt(dr3, 0);

                dt.TableName = "CRDSTopDropdownFindByLotNumberOrder";
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, dt, policy);
            }
            dt.DataSet.Tables.Remove(dt);
            dsTii.Tables.Add(dt);
            /* Bottom Dropdown -- Find by Name Order */
            key = "CRDSBottomDropdownFindByNameOrder";
            DataTable dt2 = (DataTable)cache[key];
            if (dt2 == null) {
                cmd = new SqlCommand("uspCustomerInfoByCardholderNameGet");
                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                dt2 = ds.Tables[0];

                dt2.Columns.Add(new DataColumn("NameSRLotLane"));
                int maxLenLotLane = 0;
                foreach (DataRow dr in dt2.Rows) {
                    int len = ((string)dr["Name"]).Length;
                    if (len > maxLenLotLane) {
                        maxLenLotLane = len;
                    }
                }
                foreach (DataRow dr2 in dt2.Rows) {
                    dr2["NameSRLotLane"] = Utils.PadString((string)dr2["Name"], Utils.PAD_DIRECTION.RIGHT, maxLenLotLane + 2, '\xA0') + dr2["SRLotLane"];
                }
                DataRow dr3 = dt2.NewRow();
                dr3["SRLotLane"] = "";
                dr3["Name"] = "";
                dr3["propIdBarCustId"] = "";
                dr3["NameSRLotLane"] = "";
                dt2.Rows.InsertAt(dr3, 0);


                dt2.TableName = "CRDSBottomDropdownFindByNameOrder";
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, dt2, policy);
            }
            dt2.DataSet.Tables.Remove(dt2);
            dsTii.Tables.Add(dt2);

            /* Card Class values */
            key = "CRDSCardClass";
            DataTable dt3 = (DataTable)cache[key];
            if (dt3 == null) {
                cmd = new SqlCommand("uspCardClassGet");
                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                dt3 = ds.Tables[0];
                dt3.TableName = "CRDSCardClass";
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, dt3, policy);
            }
            dt3.DataSet.Tables.Remove(dt3);
            dsTii.Tables.Add(dt3);

            key = "CRDSCardStatus";
            DataTable dt4 = (DataTable)cache[key];
            if (dt4 == null) {
                cmd = new SqlCommand("uspCardStatusGet");
                DataSet ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                dt4 = ds.Tables[0];
                dt4.TableName = "CRDSCardStatus";
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, dt4, policy);
            }
            dt4.DataSet.Tables.Remove(dt4);
            dsTii.Tables.Add(dt4);

            key = "CRDSYesNo";
            DataTable dtYesNo = (DataTable)cache[key];
            if (dtYesNo == null) {
                DataSet dsYesNo = new DataSet("dsYesNo");
                dtYesNo = new DataTable("CRDSYesNo");
                dsYesNo.Tables.Add(dtYesNo);
                dtYesNo.Columns.Add(new DataColumn("cdYesNo"));
                DataRow drYesNo_Blank = dtYesNo.NewRow();
                drYesNo_Blank["cdYesNo"] = "";
                DataRow drYesNo_Yes = dtYesNo.NewRow();
                drYesNo_Yes["cdYesNo"] = "Yes";
                DataRow drYesNo_No = dtYesNo.NewRow();
                drYesNo_No["cdYesNo"] = "No";
                dtYesNo.Rows.Add(drYesNo_Blank);
                dtYesNo.Rows.Add(drYesNo_Yes);
                dtYesNo.Rows.Add(drYesNo_No);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(1, 60, 0);
                cache.Add(key, dtYesNo, policy);
            }
            dtYesNo.DataSet.Tables.Remove(dtYesNo);
            dsTii.Tables.Add(dtYesNo);


            return dsTii;
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            MemoryCache cache = MemoryCache.Default;
            cache.Remove("CRDSTopDropdownFindByLotNumberOrder");
            cache.Remove("CRDSBottomDropdownFindByNameOrder");
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ((Database)Master).getBtnGo().Visible = false;
                if (imUnlockedForEdit) {
                    unlockYourUpdateFields();
                } else {
                    lockYourUpdateFields();
                }
            }
        }
        private void setResultsContent(String propId, String custId) {
            Session["PropdIdBeingEdited"] = propId;
            Session["CustIdBeingEdited"] = custId;
            SqlCommand cmd = new SqlCommand("uspOwnerGet");
            cmd.Parameters.Add("@CustId", SqlDbType.NVarChar).Value = custId;
            DataSet dsOwner = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
            lbOwnerName.Text = Utils.ObjectToString(dsOwner.Tables[0].Rows[0]["CustName"]);
            lbOwnerAddressStreet.Text = Utils.ObjectToString(dsOwner.Tables[0].Rows[0]["Addr1"]);
            lbOwnerCityStateZip.Text =
                    Utils.ObjectToString(dsOwner.Tables[0].Rows[0]["City"]) + ", " +
                    Utils.ObjectToString(dsOwner.Tables[0].Rows[0]["Region"]) + " " +
                    Utils.ObjectToString(dsOwner.Tables[0].Rows[0]["PostalCode"]);
            lbOwnerPhone.Text = Utils.ObjectToString(dsOwner.Tables[0].Rows[0]["Phone"]);
            cmd = new SqlCommand("uspAddressGet");
            cmd.Parameters.Add("@PropId", SqlDbType.NVarChar).Value = propId;
            DataSet dsAddress = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
            lbPropertyLotLane.Text = Utils.ObjectToString(dsAddress.Tables[0].Rows[0]["srLotLane"]);
            lbPropertyCountyAddress.Text = Utils.ObjectToString(dsAddress.Tables[0].Rows[0]["dc_address"]);
            lbPropertyPropertyId.Text = Utils.ObjectToString(dsAddress.Tables[0].Rows[0]["SRPropID"]);
            bindGvCardholders(propId);
            ((Database)Master).getCPEForm.Collapsed = false;
            ((Database)Master).getCPEForm.ClientState = "false";
            ((Database)Master).getCPEDataGrid.Collapsed = false;
            ((Database)Master).getCPEDataGrid.ClientState = "false";
            ((Database)Master).getPanelForm.Visible = true;
            ((Database)Master).collapseCPESearch();
            txtContactsSearch.Text = "";
            txtLotLaneSearch.Text = "";
        }
        private void bindGvCardholders(string propId) {
            SqlCommand cmd = new SqlCommand("uspCardGet");
            cmd.Parameters.Add("@PropId", SqlDbType.NVarChar).Value = propId;
            DataSet dsCards = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
            gvCardholders.DataSource = dsCards;
            gvCardholders.DataBind();
        }

        protected override DataSet buildDataSet() {
            throw new NotImplementedException();
        }
        protected override void clearAllNewFormInputFields() {
            tbcdFirstNameNew.Text = "";
            tbcdLastNameNew.Text = "";
            ddlcdCardStatusNew.SelectedIndex = 0;
            tbcdDateOfBirthNew.Text = "";
            tbIssueDateNew.Text = ""; ;
            tbFeePaidNew.Text = "";
            ddlIssuedIdCardNew.SelectedIndex = 0;
            ddlIssuedRecPassNew.SelectedIndex = 0;
            tbCommentsNew.Text = "";
        }
        protected void lbIDCardNew_OnClick(object sender, EventArgs args) {
            DataTable dt = CRDataSet().Tables["CRDSCardClass"];
            ddlcdClassNew.DataSource = dt;
            ddlcdClassNew.DataBind();
            DataTable dt2 = CRDataSet().Tables["CRDSCardStatus"];
            ddlcdCardStatusNew.DataSource = dt2;
            ddlcdCardStatusNew.DataBind();

            DataTable dt3 = CRDataSet().Tables["CRDSYesNo"];
            ddlIssuedIdCardNew.DataSource = dt3;
            ddlIssuedIdCardNew.DataBind();
            DataTable dt4 = CRDataSet().Tables["CRDSYesNo"];
            ddlIssuedRecPassNew.DataSource = dt4;
            ddlIssuedRecPassNew.DataBind();


            mpeNewIDCard.Show();

        }
        protected void btnNewIDCardOk_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspCardPut");
                string firstName = tbcdFirstNameNew.Text;
                cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = firstName;
                string lastName = tbcdLastNameNew.Text;
                cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = lastName;
                string cardClass = ddlcdClassNew.SelectedValue;
                cmd.Parameters.Add("@Class", SqlDbType.NVarChar).Value = cardClass;
                DateTime? birthDate = Utils.ObjectToDateTimeNullable(tbcdDateOfBirthNew.Text);
                if (birthDate.HasValue) {
                    cmd.Parameters.Add("@DOB", SqlDbType.DateTime).Value = birthDate.Value;
                }
                string status = ddlcdCardStatusNew.SelectedValue;
                DateTime? issueDate = Utils.ObjectToDateTimeNullable(tbIssueDateNew.Text);
                if (issueDate.HasValue) {
                    cmd.Parameters.Add("@IssueDate", SqlDbType.DateTime).Value = issueDate.Value;
                }
                decimal? feePaid = null;
                try {
                    feePaid = Utils.ObjectToDecimal0IfNull(tbFeePaidNew.Text.Replace("$", ""));
                } catch { }
                if (feePaid.HasValue) {
                    cmd.Parameters.Add("@FeePaid", SqlDbType.Money).Value = feePaid.Value;
                }
                string idCardIssued = ddlIssuedIdCardNew.SelectedValue;
                cmd.Parameters.Add("@IDCardIssued", SqlDbType.NVarChar).Value = idCardIssued;
                string recPassIssued = ddlIssuedRecPassNew.SelectedValue;
                cmd.Parameters.Add("@RecPassIssued", SqlDbType.NVarChar).Value = recPassIssued;
                string comments = (tbCommentsNew).Text;
                cmd.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = comments;
                cmd.Parameters.Add("@fkISPropID", SqlDbType.NVarChar).Value = Session["PropdIdBeingEdited"];
                SqlParameter newid = new SqlParameter("@NewCardId", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                getUpdateResultsLabel().ForeColor = System.Drawing.Color.DarkGreen;
                getUpdateResultsLabel().Text = "ID Card created";
                setResultsContent((string)Session["PropdIdBeingEdited"], (string)Session["CustIdBeingEdited"]);

            } catch (Exception ee) {
                getUpdateResultsLabel().ForeColor = System.Drawing.Color.Red;
                getUpdateResultsLabel().Text = ee.Message;
            }
            clearAllSelectionInputFields();
        }
        protected void btnNewIDCardCancel_Click(object sender, EventArgs args) {
            clearAllSelectionInputFields();
        }

        protected override void clearAllSelectionInputFields() {

        }
        protected override DataTable getGridViewDataTable() {
            throw new NotImplementedException();
        }
        protected override GridView getGridViewResults() {
            throw new NotImplementedException();
        }
        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }
        protected override Label getUpdateResultsLabel() {
            return lblIDCardManagementUpdateResults;
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            throw new NotImplementedException();
        }

        private bool imUnlockedForEdit {
            get {
                object imunlocked = Session["ImUnlockedForEditIDCardManagement"];
                return imunlocked == null ? false : (bool)imunlocked;
            }
            set {
                Session["ImUnlockedForEditIDCardManagement"] = value;
            }
        }
        public object FormatCardIssued(object value) {
            if (Utils.isNothing(value)) {
                return "";
            }
            string jdValue = value.ToString().ToLower();
            if (jdValue == "yes" || jdValue == "1") {
                return "Yes";
            }
            if (jdValue == "no" || jdValue == "0") {
                return "No";
            }
            return "";
        }
        public object FormatAge(object value) {
            if (Utils.isNothing(value)) {
                return "";
            }
            try {
                DateTime zeroTime = new DateTime(1, 1, 1);

                DateTime b = DateTime.Today;
                DateTime a = Utils.ObjectToDateTime(value);

                TimeSpan span = b - a;
                // because we start at year 1 for the Gregorian 
                // calendar, we must subtract a year here.
                int years = (zeroTime + span).Year - 1;
                return years.ToString();
            } catch {
                return "";
            }
        }
        protected override void unlockYourUpdateFields() {
            gvCardholders.Columns[0].Visible = true;
        }
        protected override void lockYourUpdateFields() {
            gvCardholders.Columns[0].Visible = false;
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            throw new NotImplementedException();
        }
        protected override string UpdateRoleName {
            get { return "canupdateIDCard"; }
        }
        protected void gvCardholders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvCardholders.EditIndex = -1;

            //Bind data to the GridView control.
            bindGvCardholders((string)Session["PropdIdBeingEdited"]);
        }
        protected void gvCardholders_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvCardholders.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            bindGvCardholders((string)Session["PropdIdBeingEdited"]);
        }
        protected void gv_RowDataBound(object sender, GridViewRowEventArgs e) {
            if ((e.Row.RowState & DataControlRowState.Edit) > 0) {
                DropDownList ddList = (DropDownList)e.Row.FindControl("ddlcdClassUpdate");
                //bind dropdownlist
                DataTable dt = CRDataSet().Tables["CRDSCardClass"];
                ddList.DataSource = dt;
                ddList.DataBind();
                DataRowView dr = e.Row.DataItem as DataRowView;
                ddList.SelectedValue = dr["cdClass"].ToString();

                DropDownList ddList2 = (DropDownList)e.Row.FindControl("ddlcdCardStatusUpdate");
                //bind dropdownlist
                DataTable dt2 = CRDataSet().Tables["CRDSCardStatus"];
                ddList2.DataSource = dt2;
                ddList2.DataBind();
                ddList2.SelectedValue = dr["cdStatus"].ToString();

                DropDownList ddList3 = (DropDownList)e.Row.FindControl("ddlcdIdCardIssuedUpdate");
                DataTable dt3 = CRDataSet().Tables["CRDSYesNo"];
                ddList3.DataSource = dt3;
                ddList3.DataBind();
                ddList3.SelectedValue = (String)FormatCardIssued(dr["cdIDCardIssued"]);
                DropDownList ddList4 = (DropDownList)e.Row.FindControl("ddlcdRecPassIssuedUpdate");
                DataTable dt4 = CRDataSet().Tables["CRDSYesNo"];
                ddList4.DataSource = dt4;
                ddList4.DataBind();
                ddList4.SelectedValue = (String)FormatCardIssued(dr["cdRecPassIssued"]);
            } else {
                if (e.Row.RowType.Equals(DataControlRowType.DataRow)) {
                    Label lblRecPassIssued = (Label)e.Row.FindControl("lblRecPassIssued");
                    lblRecPassIssued.BackColor = System.Drawing.Color.White;
                    if (lblRecPassIssued != null && lblRecPassIssued.Text == "Yes") {
                        lblRecPassIssued.BackColor = System.Drawing.Color.FromArgb(153, 204, 255);
                    }
                    Label lblCardIssued = (Label)e.Row.FindControl("lblCardIssued");
                    lblCardIssued.BackColor = System.Drawing.Color.White;
                    if (lblCardIssued != null && lblCardIssued.Text == "Yes") {
                        lblCardIssued.BackColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
        protected void gvCardholders_RowUpdating(object sender, GridViewUpdateEventArgs e) {

            GridViewRow row = gvCardholders.Rows[e.RowIndex];
            try {
                SqlCommand cmd = new SqlCommand("uspCardPut");
                int cardId = Utils.ObjectToInt(((Label)row.Cells[1].Controls[1]).Text);
                cmd.Parameters.Add("@CardId", SqlDbType.Int).Value = cardId;
                string firstName = ((TextBox)row.Cells[2].Controls[1]).Text;
                cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = firstName;
                string lastName = ((TextBox)row.Cells[3].Controls[1]).Text;
                cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = lastName;
                string cardClass = ((DropDownList)row.Cells[4].Controls[1]).SelectedValue;
                cmd.Parameters.Add("@Class", SqlDbType.NVarChar).Value = cardClass;
                DateTime? birthDate = Utils.ObjectToDateTimeNullable(((TextBox)row.Cells[5].Controls[1]).Text);
                if (birthDate.HasValue) {
                    cmd.Parameters.Add("@DOB", SqlDbType.DateTime).Value = birthDate.Value;
                }
                string status = ((DropDownList)row.Cells[7].Controls[1]).SelectedValue;
                cmd.Parameters.Add("@Status", SqlDbType.NVarChar).Value = status;
                DateTime? issueDate = Utils.ObjectToDateTimeNullable(((TextBox)row.Cells[8].Controls[1]).Text);
                if (issueDate.HasValue) {
                    cmd.Parameters.Add("@IssueDate", SqlDbType.DateTime).Value = issueDate.Value;
                }
                decimal? feePaid = null;
                try {
                    feePaid = Utils.ObjectToDecimal0IfNull(((TextBox)row.Cells[9].Controls[1]).Text.Replace("$", ""));
                } catch { }
                if (feePaid.HasValue) {
                    cmd.Parameters.Add("@FeePaid", SqlDbType.Money).Value = feePaid.Value;
                }
                string idCardIssued = ((DropDownList)row.Cells[10].Controls[1]).SelectedValue;
                cmd.Parameters.Add("@IDCardIssued", SqlDbType.NVarChar).Value = idCardIssued;
                string recPassIssued = ((DropDownList)row.Cells[11].Controls[1]).SelectedValue;
                cmd.Parameters.Add("@RecPassIssued", SqlDbType.NVarChar).Value = recPassIssued;
                string comments = ((TextBox)row.Cells[12].Controls[1]).Text;
                cmd.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = comments;
                SqlParameter newid = new SqlParameter("@NewCardId", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                /*
                 * alter PROCEDURE uspCardPut (
	@CardId int = null,
	@fkISInputID int = null,
	@FirstName nvarchar(20) = null,
	@LastName nvarchar(20) = null,
	@Class nvarchar(20)=null,
	@DOB datetime=null,
	@Status nvarchar(15)=null,
	@IssueDate datetime=null,
	@FeePaid money=null,
	@IDCardIssued nvarchar(3)=null,
	@RecPassIssued nvarchar(3)=null,
	@Comments ntext=null,
	@Photo1 nvarchar(80)=null,
	@ISAddress nvarchar(50)=null,
	@ISSort nvarchar(50)=null,
	@fkISPropID nvarchar(50)=null,
	@RenewalDate datetime=null,
	@ExpirationDate datetime=null
                 * 
                */
                getUpdateResultsLabel().ForeColor = System.Drawing.Color.DarkGreen;
                getUpdateResultsLabel().Text = "ID Card updated";

                //setResultsContent(propId, custId);
                //                performPostUpdateSuccessfulActions("ID Card updated", null, null);
            } catch (Exception ee) {
                getUpdateResultsLabel().ForeColor = System.Drawing.Color.Red;
                getUpdateResultsLabel().Text = ee.Message;
            }
            //Reset the edit index.
            gvCardholders.EditIndex = -1;

            //Bind data to the GridView control.
            bindGvCardholders((string)Session["PropdIdBeingEdited"]);
        }

        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchByLotLane(string prefixText, int count) {
            DataView dv = new DataView(CRDataSet().Tables["CRDSTopDropdownFindByLotNumberOrder"]);
            dv.RowFilter = "SRLotLane like '*" + prefixText + "*'";
            __ListForAutoComplete = new List<FindByListItem>();
            List<string> zList = new List<string>();
            DataTable dt = dv.ToTable();
            foreach (DataRow dr in dt.Rows) {
                __ListForAutoComplete.Add(new FindByListItem((string)dr["SrLotLaneOwner"], (string)dr["PropIdBarCustId"]));
                zList.Add((string)dr["SrLotLaneOwner"]);
            }
            return zList;
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e) {
            string zText = ((TextBox)sender).Text;
            foreach (FindByListItem item in __ListForAutoComplete) {
                if (item._Name == zText) {
                    String[] sa = item._Key.Split(new char[] { '|' });
                    string propId = sa[0];
                    String custId = sa[1];
                    setResultsContent(propId, custId);
                }
            }
        }
        private static List<FindByListItem> __ListForAutoComplete;
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchByName(string prefixText, int count) {
            DataView dv = new DataView(CRDataSet().Tables["CRDSBottomDropdownFindByNameOrder"]);
            dv.RowFilter = "Name like '*" + prefixText + "*'";
            __ListForAutoComplete = new List<FindByListItem>();
            List<string> zList = new List<string>();
            DataTable dt = dv.ToTable();
            foreach (DataRow dr in dt.Rows) {
                __ListForAutoComplete.Add(new FindByListItem((string)dr["NameSRLotLane"], (string)dr["PropIdBarCustId"]));
                zList.Add((string)dr["NameSRLotLane"]);
            }
            return zList;
        }

        class FindByListItem {
            public string _Name;
            public string _Key;
            public FindByListItem(String name, string key) {
                _Name = name;
                _Key = key;
            }
            public override string ToString() {
                return _Name;
            }
        }
    }
}