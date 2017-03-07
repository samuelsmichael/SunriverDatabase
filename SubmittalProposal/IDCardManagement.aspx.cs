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
    public partial class IDCardManagement : AbstractDatabase, ICanHavePDFs {
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
                if(Utils.isNothingNot(Session["ShowIDCardsID"])) {
                    setResultsContent(Utils.ObjectToString(Session["opSRPropIDBeingEdited"]), Utils.ObjectToString(Session["ShowIDCardsID"]));
                    Session["ShowIDCardsID"]=null;
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
            Session["lbPropertyLotLane"] = lbPropertyLotLane.Text;
            SetLaneLotForPDFs((string)Session["lbPropertyLotLane"]);
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
            Session["DataKeysBeingShown"] = gvCardholders.DataKeys;

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
            tbPermanentNoteNew.Text = "";
            ddlcdClassNew.SelectedValue = "Owner";

        }
  
        protected void lbIDCardNew_OnClick(object sender, EventArgs args) {
            DataTable dt = CRDataSet().Tables["CRDSCardClass"];
            ddlcdClassNew.DataSource = dt;
            ddlcdClassNew.DataBind();
            ddlcdClassNew.SelectedValue = "Owner";
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
        protected void lbUpdatePrevious_OnClick(object sender, EventArgs args) {
            if (Page.IsValid) {
                btnUpdateIDCardOk_Click(null, null);
                Edit(gvCardholders.Rows[Utils.ObjectToInt(Session["IndexOfDataKeysCurrentlyBeingShown"]) - 1].Cells[0].Controls[1], null);
            }
        }
        protected void lbUpdateNext_OnClick(object sender, EventArgs args) {
            if (Page.IsValid) {
                btnUpdateIDCardOk_Click(null, null);
                Edit(gvCardholders.Rows[Utils.ObjectToInt(Session["IndexOfDataKeysCurrentlyBeingShown"]) + 1].Cells[0].Controls[1], null);
            }
        }
        protected void ddlcdClassNew_SelectedIndexChanged(object sender, EventArgs args) {
            if (((DropDownList)sender).SelectedValue == "Dependent") {
           //     rfvtbcdDateOfBirthNew.Enabled = true;
            } else {
             //   rfvtbcdDateOfBirthNew.Enabled = false;
            }
            mpeNewIDCard.Show();
        }

        protected void DateOfBirth_OnValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            try {
                if (ddlcdClassNew.SelectedValue == "Dependent") {
                    if (args.Value.ToString().Trim() == String.Empty) {
                        args.IsValid = false;
                    }
                }
            } catch (Exception ex) {
                args.IsValid = false;
            }
            if (!args.IsValid) {
                mpeNewIDCard.Show();
            }
        }
        protected void DateOfBirth_OnValidateUpdate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            try {
                if (ddlcdClassUpdate.SelectedValue == "Dependent") {
                    if (args.Value.ToString().Trim() == String.Empty) {
                        args.IsValid = false;
                    }
                }
            } catch (Exception ex) {
                args.IsValid = false;
            }
            if (!args.IsValid) {
                mpeUpdateIDCard.Show();
            }
        }

        protected void btnNewIDCardOk_Click(object sender, EventArgs args) {
            if (Page.IsValid) {
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
                    cmd.Parameters.Add("@status", SqlDbType.NVarChar).Value = status;
                    cmd.Parameters.Add("@Photo1", SqlDbType.NVarChar).Value = deriveNewPhoto1Value(lastName);
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
                    string permanentNote = tbPermanentNoteNew.Text;
                    cmd.Parameters.Add("@PermanentNote", SqlDbType.NVarChar).Value = permanentNote;
                    cmd.Parameters.Add("@fkISPropID", SqlDbType.NVarChar).Value = Session["PropdIdBeingEdited"];
                    cmd.Parameters.Add("@ISAddress", SqlDbType.NVarChar).Value = Session["lbPropertyLotLane"];
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
                clearAllNewFormInputFields();
            }
        }

        private String deriveNewPhoto1Value(string lastName) {
            for (int i=30;i>=1;i--) {
                if(doDeriveNewPhotoValueForNumber(lastName,""+i)) {
                    return ""+i;
                }
            } 
            return "";
        }
        private bool doDeriveNewPhotoValueForNumber(string lastName, string number) {
            int index = lastName.ToLower().IndexOf(number+" of ");
            return index >= 0;
        }
        protected void btnNewIDCardCancel_Click(object sender, EventArgs args) {
            clearAllNewFormInputFields();
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
        protected void tbcdDateOfBirthNew_OnTextChanged(object sender, EventArgs args) {
            lblAgeNew.Text = Utils.ObjectToString(FormatAge(((TextBox)sender).Text));
            mpeNewIDCard.Show();
            ddlcdClassNew.Attributes["onfocus"] = "javascript:try {this.select();} catch (e) {}";
            ddlcdClassNew.Focus();

        }
        protected void tbIssueDateUpdate_OnTextChanged(object sender, EventArgs args) {
            TextBox tb = (TextBox)sender;
            if (tb.Text.Length >= 3 && tb.Text.Length<7) {
                if (tb.Text.IndexOf("/") != -1) {
                    tb.Text += "/" + DateTime.Today.Year;
                }
            }
            mpeUpdateIDCard.Show();
            ddlIssuedIdCardUpdate.Attributes["onfocus"] = "javascript:try {this.select();} catch(e2) {}";
            ddlIssuedIdCardUpdate.Focus();

        }
        private string captializeAllWords(string str) {
            if (str == null) {
                return "";
            }
            string[] sa=str.Trim().Split(new char[] {' '});
            StringBuilder sb = new StringBuilder();
            string space="";
            foreach (string st in sa) {
                if (st.Length == 0) {
                    sb.Append("");
                } else {
                    sb.Append(space+st[0].ToString().ToUpperInvariant()+st.Substring(1));
                }
                space=" ";
            }
            return sb.ToString();
        }
        protected void tbcdLastNameNew_OnTextChanged(object sender, EventArgs args) {
            tbcdLastNameNew.Text = captializeAllWords(tbcdLastNameNew.Text);
            mpeNewIDCard.Show();
            tbcdDateOfBirthNew.Attributes["onfocus"] = "javascript:try {this.select();} catch(e2) {}";
            tbcdDateOfBirthNew.Focus();
        }
        protected void tbcdLastNameUpdate_OnTextChanged(object sender, EventArgs args) {
            tbcdLastNameUpdate.Text = captializeAllWords(tbcdLastNameUpdate.Text);
            mpeUpdateIDCard.Show();
            tbcdDateOfBirthUpdate.Attributes["onfocus"] = "javascript:try {this.select();} catch(e2) {}";
            tbcdDateOfBirthUpdate.Focus();
        }
        protected void tbcdFirstNameUpdate_OnTextChanged(object sender, EventArgs args) {
            tbcdFirstNameUpdate.Text = captializeAllWords(tbcdFirstNameUpdate.Text);
            mpeUpdateIDCard.Show();
            tbcdLastNameUpdate.Attributes["onfocus"] = "javascript:try {this.select();} catch(e2) {}";
            tbcdLastNameUpdate.Focus();
        }
        protected void tbcdFirstNameNew_OnTextChanged(object sender, EventArgs args) {
            tbcdFirstNameNew.Text = captializeAllWords(tbcdFirstNameNew.Text);
            mpeNewIDCard.Show();
            tbcdLastNameNew.Attributes["onfocus"] = "javascript:try {this.select();} catch(e2) {}";
            tbcdLastNameNew.Focus();
        }
        protected void tbIssueDateNew_OnTextChanged(object sender, EventArgs args) {
            TextBox tb = (TextBox)sender;
            if (tb.Text.Length >= 3 && tb.Text.Length < 7) {
                if (tb.Text.IndexOf("/") != -1) {
                    tb.Text += "/" + DateTime.Today.Year;
                }
            }
            mpeNewIDCard.Show();
            ddlIssuedIdCardNew.Attributes["onfocus"] = "javascript:try {this.select();} catch(e2) {}";
            ddlIssuedIdCardNew.Focus();
        }

        protected void tbcdDateOfBirthUpdate_OnTextChanged(object sender, EventArgs args) {
            lblAgeUpdate.Text = Utils.ObjectToString(FormatAge(((TextBox)sender).Text));
            mpeUpdateIDCard.Show();
            ddlcdClassUpdate.Attributes["onfocus"] = "javascript:try {this.select();} catch(e2) {}";
            ddlcdClassUpdate.Focus();
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

        protected void Edit(object sender, EventArgs e) {
            
            using (GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent)
            {
                Session["CardIDBeingUpdated"]=Utils.ObjectToInt(((Label)row.Cells[1].Controls[1]).Text);
                // find the index of the row selected
                for (int i = 0; i < ((DataKeyArray)Session["DataKeysBeingShown"]).Count; i++) {
                    if (Utils.ObjectToInt(((DataKeyArray)Session["DataKeysBeingShown"])[i].Value) == (int)Session["CardIDBeingUpdated"]) {
                        Session["IndexOfDataKeysCurrentlyBeingShown"] = i;
                        break;
                    }
                }
                string firstName = ((Label)row.Cells[2].Controls[1]).Text;
                string lastName = ((Label)row.Cells[3].Controls[1]).Text;
                string cardClass = ((Label)row.Cells[4].Controls[1]).Text;
                string birthDate = ((Label)row.Cells[5].Controls[1]).Text;
                string cardStatus = ((Label)row.Cells[7].Controls[1]).Text;
                string issueDate = ((Label)row.Cells[8].Controls[1]).Text;
                string feePaid = ((Label)row.Cells[9].Controls[1]).Text;
                string idCard = ((Label)row.Cells[10].Controls[1]).Text;
                string recPass = ((Label)row.Cells[11].Controls[1]).Text;
                string comments = ((Label)row.Cells[12].Controls[1]).Text;
                string permanentNote=((Label)row.Cells[13].Controls[1]).Text;


                lblAgeUpdate.Text = Utils.ObjectToString(FormatAge(birthDate));


                tbcdFirstNameUpdate.Text = firstName;
                tbcdLastNameUpdate.Text = lastName;
                tbcdDateOfBirthUpdate.Text = birthDate;
                tbFeePaidUpdate.Text = feePaid.Replace("$", "");
                tbIssueDateUpdate.Text = issueDate;
                tbCommentsUpdate.Text = comments;
                tbPermanentNoteUpdate.Text = permanentNote;

                DataTable dt = CRDataSet().Tables["CRDSCardClass"];
                ddlcdClassUpdate.DataSource = dt;
                ddlcdClassUpdate.DataBind();
                ddlcdClassUpdate.SelectedValue = cardClass;

                DataTable dt2 = CRDataSet().Tables["CRDSCardStatus"];
                ddlcdCardStatusUpdate.DataSource=dt2;
                ddlcdCardStatusUpdate.DataBind();
                ddlcdCardStatusUpdate.SelectedValue = cardStatus;

                DataTable dt3 = CRDataSet().Tables["CRDSYesNo"];
                ddlIssuedIdCardUpdate.DataSource=dt3;
                ddlIssuedIdCardUpdate.DataBind();
                ddlIssuedIdCardUpdate.SelectedValue = idCard;

                DataTable dt4 = CRDataSet().Tables["CRDSYesNo"];
                ddlIssuedRecPassUpdate.DataSource=dt4;
                ddlIssuedRecPassUpdate.DataBind();
                ddlIssuedRecPassUpdate.SelectedValue = recPass;

                if( ((int)Session["IndexOfDataKeysCurrentlyBeingShown"])==0 ) {
                    lbUpdatePrevious.Visible=false;
                } else {
                    lbUpdatePrevious.Visible=true;
                }
                if( ((int)Session["IndexOfDataKeysCurrentlyBeingShown"])== ( ((DataKeyArray)Session["DataKeysBeingShown"]).Count ) - 1 ) {
                    lbUpdateNext.Visible=false;
                } else {
                    lbUpdateNext.Visible=true;
                }

                mpeUpdateIDCard.Show();
            }           
        }

        protected void btnUpdateIDCardCancel_Click(object sender, EventArgs args) {
    // no need        mpeUpdateIDCard.Hide();
        }

        protected void gv_RowDataBound(object sender, GridViewRowEventArgs e) {
            if ((e.Row.RowState & DataControlRowState.Edit) > 0) {

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

        protected void btnUpdateIDCardOk_Click(object sender, EventArgs e) {
            if (Page.IsValid) {

                try {
                    SqlCommand cmd = new SqlCommand("uspCardPut");
                    int cardId = Utils.ObjectToInt(Session["CardIDBeingUpdated"]);
                    cmd.Parameters.Add("@CardId", SqlDbType.Int).Value = cardId;
                    string firstName = tbcdFirstNameUpdate.Text;
                    cmd.Parameters.Add("@FirstName", SqlDbType.NVarChar).Value = firstName;
                    string lastName = tbcdLastNameUpdate.Text;
                    cmd.Parameters.Add("@LastName", SqlDbType.NVarChar).Value = lastName;
                    string cardClass = ddlcdClassUpdate.SelectedValue;
                    cmd.Parameters.Add("@Class", SqlDbType.NVarChar).Value = cardClass;
                    DateTime? birthDate = Utils.ObjectToDateTimeNullable(tbcdDateOfBirthUpdate.Text);
                    if (birthDate.HasValue) {
                        cmd.Parameters.Add("@DOB", SqlDbType.DateTime).Value = birthDate.Value;
                    }
                    string status = ddlcdCardStatusUpdate.SelectedValue;
                    cmd.Parameters.Add("@Status", SqlDbType.NVarChar).Value = status;
                    DateTime? issueDate = Utils.ObjectToDateTimeNullable(tbIssueDateUpdate.Text);
                    if (issueDate.HasValue) {
                        cmd.Parameters.Add("@IssueDate", SqlDbType.DateTime).Value = issueDate.Value;
                    }
                    decimal? feePaid = null;
                    try {
                        feePaid = Utils.ObjectToDecimal0IfNull(tbFeePaidUpdate.Text.Replace("$", ""));
                    } catch { }
                    if (feePaid.HasValue) {
                        cmd.Parameters.Add("@FeePaid", SqlDbType.Money).Value = feePaid.Value;
                    }
                    string idCardIssued = ddlIssuedIdCardUpdate.SelectedValue;
                    cmd.Parameters.Add("@IDCardIssued", SqlDbType.NVarChar).Value = idCardIssued;
                    string recPassIssued = ddlIssuedRecPassUpdate.SelectedValue;
                    cmd.Parameters.Add("@RecPassIssued", SqlDbType.NVarChar).Value = recPassIssued;
                    string comments = tbCommentsUpdate.Text;
                    cmd.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = comments;
                    string permanentNote = tbPermanentNoteUpdate.Text;
                    cmd.Parameters.Add("@PermanentNote", SqlDbType.NVarChar).Value = permanentNote;
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
                } catch (Exception ee) {
                    getUpdateResultsLabel().ForeColor = System.Drawing.Color.Red;
                    getUpdateResultsLabel().Text = ee.Message;
                }
                //Reset the edit index.
                gvCardholders.SelectedIndex = -1;

                //Bind data to the GridView control.
                bindGvCardholders((string)Session["PropdIdBeingEdited"]);
            }
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
        protected void gvCardholders_Sorting(object sender, GridViewSortEventArgs e) {
            SqlCommand cmd = new SqlCommand("uspCardGet");
            cmd.Parameters.Add("@PropId", SqlDbType.NVarChar).Value = Session["PropdIdBeingEdited"];
            DataSet dsCards = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);


            if (dsCards.Tables != null && dsCards.Tables.Count > 0) {
                DataTable sourceTable = dsCards.Tables[0];
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
                Session["DataKeysBeingShown"] = gvCardholders.DataKeys;
            }
        }
        public static string MyMenuName = "ID Card";
        protected override string childMenuName {
            get { return MyMenuName; }
        }

        public bool HasPropertyAvailable {
            get { return Utils.isNothingNot(Session["lbPropertyLotLane"]); }
        }

        /// <summary>
        /// This comes in as 3 Acer Lane.  I have to remove the "Lane", and swap the lane and the lot.
        /// </summary>
        /// <param name="lanelot"></param>
        public void SetLaneLotForPDFs(string lanelot) {
            string str = lanelot.ToLower().Replace("lane", "").Trim();
            int indexoffirstspace = str.IndexOf(" ");
            string realLaneLot =
               str.Substring(indexoffirstspace).Trim() + " " + str.Substring(0, indexoffirstspace);
            LaneLotForPDFs = realLaneLot;
        }
    }
}