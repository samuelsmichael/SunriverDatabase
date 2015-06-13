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
                int maxLenLotLane=0;
                foreach(DataRow dr in dt.Rows) {
                    int len=((string)dr["SRLotLane"]).Length;
                    if(len>maxLenLotLane) {
                        maxLenLotLane=len;
                    }
                }
                foreach(DataRow dr2 in dt.Rows) {
                    dr2["SrLotLaneOwner"]=Utils.PadString((string)dr2["SRLotLane"],Utils.PAD_DIRECTION.RIGHT,maxLenLotLane+2,'\xA0')+dr2["CustName"];
                }
                DataRow dr3 = dt.NewRow();
                dr3["SRLotLane"] = "";
                dr3["CustName"] = "";
                dr3["LotSortValue"] = 0;
                dr3["PropIDBarCustId"] = "";
                dr3["SrLotLaneOwner"]="";
                dt.Rows.InsertAt(dr3, 0);
 
                dt.TableName = "CRDSTopDropdownFindByLotNumberOrder";
                dt.PrimaryKey = new DataColumn[]{ dt.Columns["SRLotLane"]};
                String fordebugging = dt.Rows[0]["PropIDBarCustId"].ToString();
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
                dr3["CardID"] = 0;
                dr3["PropIDBarCustId"] = "";
                dr3["NameSRLotLane"] = "";
                dt2.Rows.InsertAt(dr3, 0);


                dt2.TableName = "CRDSBottomDropdownFindByNameOrder";
                String fordebugging = dt2.Rows[0]["PropIDBarCustId"].ToString();
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, dt2, policy);
            }
            dt2.DataSet.Tables.Remove(dt2);
            dsTii.Tables.Add(dt2);

            /*
             * We're going to have a DataSet that has each of our important queries in separate cached DataTables
             * */

            return dsTii;
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            MemoryCache cache = MemoryCache.Default;
            cache.Remove("CRDSTopDropdownFindByLotNumberOrder");
            cache.Remove("CRDSBottomDropdownFindByNameOrder");
        }
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLotLaneOrder.DataSource = CRDataSet().Tables[0];
                ddlLotLaneOrder.DataBind();
                ddlNameOrder.DataSource = CRDataSet().Tables[1];
                ddlNameOrder.DataBind();
            }
        }
        private void setResultsContent(String propId, String custId) {
            Session["PropdIdBeingEdited"] = propId;
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
            throw new NotImplementedException();
        }
        protected override void clearAllSelectionInputFields() {
            throw new NotImplementedException();
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
            throw new NotImplementedException();
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            throw new NotImplementedException();
        }
        protected override void lockYourUpdateFields() {
            throw new NotImplementedException();
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            throw new NotImplementedException();
        }
        protected override void unlockYourUpdateFields() {
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
        protected void gvCardholders_RowUpdating(object sender, GridViewUpdateEventArgs e) {

            GridViewRow row = gvCardholders.Rows[e.RowIndex];
            try {
                /*
                string strfee = ((TextBox)row.Cells[2].Controls[1]).Text.Trim().Replace("$", "").Replace(",", "");
                decimal? fee = strfee == "" ? (decimal?)null : Utils.ObjectToDecimal(strfee);
                string strmonths = ((TextBox)row.Cells[3].Controls[1]).Text.Trim().Replace("$", "").Replace(",", "");
                int? months = strmonths == "" ? (int?)null : Utils.ObjectToInt(strmonths);
                int paymentid = Utils.ObjectToInt(gvPayments.DataKeys[e.RowIndex].Value);

                SqlCommand cmd = new SqlCommand("uspPaymentsUpdate");
                cmd.Parameters.Add("@BPPaymentId", SqlDbType.Int).Value = paymentid;
                cmd.Parameters.Add("@BPMonths", SqlDbType.Int).Value = months;
                cmd.Parameters.Add("@BPFee", SqlDbType.Money).Value = fee;
                SqlParameter newid = new SqlParameter("@NewBPPaymentID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);

                */
                performPostUpdateSuccessfulActions("ID Card updated", null, null);
            } catch (Exception ee) {
                performPostUpdateFailedActions("ID Card not updated. Error msg: " + ee.Message);
            }
            //Reset the edit index.
            gvCardholders.EditIndex = -1;

            //Bind data to the GridView control.
            bindGvCardholders((string)Session["PropdIdBeingEdited"]);
        }

        protected void ddlLotLaneOrder_SelectedIndexChanged(object sender, EventArgs e) {
            String propIdBarCustId = ((DropDownList)sender).SelectedValue;
            String[] sa = propIdBarCustId.Split(new char[] { '|' });
            string propId = sa[0];
            String custId = sa[1];
            setResultsContent(propId, custId);
        }

        protected void ddlNameOrder_SelectedIndexChanged(object sender, EventArgs e) {
            String propIdBarCustId = ((DropDownList)sender).SelectedValue;
            String[] sa = propIdBarCustId.Split(new char[] { '|' });
            string propId = sa[0];
            String custId = sa[1];
            setResultsContent(propId, custId);
        }       
    }
}