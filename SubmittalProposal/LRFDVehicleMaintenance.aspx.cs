using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Runtime.Caching;
using System.Data.SqlClient;


namespace SubmittalProposal {
    public partial class LRFDVehicleMaintenance : AbstractDatabase {
        private static string LRFD_VEHICLE_MAINTENANCE_CACHE_KEY = "LRFD_CACHE_KEY";
        private static string LRFD_SurchargeRate_CACHE_KEY = "LRFD_SurchargeRate_CACHE_KEY";
        public static DataSet LRFDVehicalMaintenance_DataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = LRFD_VEHICLE_MAINTENANCE_CACHE_KEY;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspLRFDVehicleMaintenanceTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                ds.Tables[0].TableName = "VWOData";
                ds.Tables[1].TableName = "VWOLabor";
                ds.Tables[2].TableName = "VWOParts";
                ds.Tables[3].TableName = "VWOServices";
                ds.Tables[4].TableName = "LRFDDepartment";
                ds.Tables[5].TableName = "LRFDMechanicInfo";
                ds.Tables[6].TableName = "LRFDVehicelList";
                ds.Tables[0].PrimaryKey = new DataColumn[1] { ds.Tables[0].Columns["VWOID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[1] { ds.Tables[1].Columns["VWOLaborId"] };
                ds.Tables[2].PrimaryKey = new DataColumn[1] { ds.Tables[2].Columns["VWOPartID"] };
                ds.Tables[3].PrimaryKey = new DataColumn[1] { ds.Tables[3].Columns["VWOCtrServID"] };
                ds.Tables[4].PrimaryKey = new DataColumn[1] { ds.Tables[4].Columns["DepartmentID"] };
                ds.Tables[5].PrimaryKey = new DataColumn[1] { ds.Tables[5].Columns["MechID"] };
                ds.Tables[6].PrimaryKey = new DataColumn[1] { ds.Tables[6].Columns["Number"] };
                ds.Tables[6].Columns.Add(new DataColumn("VechicleNameForDDLs", typeof(String)));
                foreach (DataRow dr in ds.Tables[6].Rows) {
                    dr["VechicleNameForDDLs"] = "" + dr["Number"] + " - " + Utils.ObjectToString(dr["Description"]);
                }
                ds.Tables["VWOData"].Columns.Add(new DataColumn("VehicleName", typeof(String)));
                foreach (DataRow dr in ds.Tables["VWOData"].Rows) {
                    String vehicleName = "";
                    try {
                        vehicleName = Utils.ObjectToString(ds.Tables["LRFDVehicelList"].Rows.Find(dr["fkNumber"])["Description"]);
                        dr["VehicleName"] = vehicleName;
                    } catch { }
                }

                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            VMOIDBeingEdited = row.Cells[1].Text;
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "VWOID='" + VMOIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            lblRFDUpdateWOI.Text = VMOIDBeingEdited;
            ddlRFDUpdateVehicleNumber.SelectedValue = Utils.ObjectToString(dr["fkNumber"]);
            tbRFDUpdateVehicleDescription.Text = Utils.ObjectToString(dr["Request Nature"]);
            string estimate = Utils.ObjectToString(dr["Estimate"]);
            ddlYesNoBlankEstimateUpdate.SelectedValue = (estimate == "" ? "" : estimate == "True" ? "Yes" : "No");
            tbRFDUpdateDataEntryBy.Text = Utils.ObjectToString(dr["Data Entry By"]);
            DateTime? entryDate = Utils.ObjectToDateTimeNullable(dr["Data Entry Date"]);
            tbLRFDUpdateDataEntryDate.Text = entryDate.HasValue ? entryDate.Value.ToString("d") : "";
            DateTime? requestDateIn = Utils.ObjectToDateTimeNullable(dr["Date In"]);
            tbLRFDUpdateRequestDateIn.Text = requestDateIn.HasValue ? requestDateIn.Value.ToString("d") : "";
            tbRFDUpdateRequestedBy.Text = Utils.ObjectToString(dr["Request By"]);
            tbLRFDUpdateOdometerReading.Text = Utils.ObjectToString(dr["Odometer"]);
            tbLRFDUpdateHourReading.Text = Utils.ObjectToString(dr["hour Meter"]);
            DataTable vehicleTable = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
            DataView vehicleView = new DataView(vehicleTable);
            vehicleView.RowFilter = "Number='" + dr["fkNumber"] + "'";
            DataTable vehicleViewFiltered = vehicleView.ToTable();
            DataRow drZVehicle = vehicleViewFiltered.Rows[0];

            DataTable deptTable = LRFDVehicalMaintenance_DataSet().Tables["LRFDDepartment"];
            DataView deptView = new DataView(deptTable);
            deptView.RowFilter = "DepartmentID=" + drZVehicle["fkDeptID"];
            DataTable deptViewFiltered = deptView.ToTable();
            DataRow drZDept = deptViewFiltered.Rows[0];
            bindPartsTable();
            bindLaborTable();
            bindServiceTable();

            lblRFDUpdateDepartmentId.Text = "" + drZDept["DepartmentID"] + " - " + drZDept["Department"];
            lblRFDUpdateDepartmentAdminCharges.Text = "" + (Convert.ToDouble(drZDept["AdministrationRate"])).ToString("P");
            DateTime? dateOut = Utils.ObjectToDateTimeNullable(dr["Date Out"]);
            tbRFDUpdateVehicleDateOut.Text = dateOut.HasValue ? dateOut.Value.ToString("d") : "";
            tbRFDUpdateProcedurePerformed.Text = Utils.ObjectToString(dr["Proceedure 1"]);
            tbRFDUpdateComments.Text = Utils.ObjectToString(dr["Comments"]);
            lblTotalWorkOrderCost.Text = getTotalWorkOrderCost();

            return "Work Order #: " + VMOIDBeingEdited + " Vehicle ID: " + Utils.ObjectToString(dr["fkNumber"]) + " Vehicle description: " + Utils.ObjectToString(dr["VehicleName"]);
        }
        private void bindPartsTable() {
            DataTable partsTable = LRFDVehicalMaintenance_DataSet().Tables["VWOParts"];
            DataView partsView = new DataView(partsTable);
            partsView.RowFilter = "fkVWOP_ID='" + VMOIDBeingEdited + "'";
            DataTable partsViewFiltered = partsView.ToTable();
            gvRFDUpdateParts.DataSource = partsViewFiltered;
            gvRFDUpdateParts.DataBind();
        }
        private void bindLaborTable() {
            DataTable laborTable = LRFDVehicalMaintenance_DataSet().Tables["VWOLabor"];
            DataView laborView = new DataView(laborTable);
            laborView.RowFilter = "fkVWOL_ID='" + VMOIDBeingEdited + "'";
            DataTable laborViewFiltered = laborView.ToTable();
            gvRFDUpdateLabor.DataSource = laborViewFiltered;
            gvRFDUpdateLabor.DataBind();
        }
        private void bindServiceTable() {
            DataTable ServiceTable = LRFDVehicalMaintenance_DataSet().Tables["VWOServices"];
            DataView ServiceView = new DataView(ServiceTable);
            ServiceView.RowFilter = "fkVWOS_ID='" + VMOIDBeingEdited + "'";
            DataTable ServiceViewFiltered = ServiceView.ToTable();
            gvRFDUpdateService.DataSource = ServiceViewFiltered;
            gvRFDUpdateService.DataBind();
        }
        private string VMOIDBeingEdited {
            get {
                return Utils.ObjectToString(Session["VMOIDBeingEdited"]);
            }
            set {
                Session["VMOIDBeingEdited"] = value;
            }
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(ddlVehicle_Search.SelectedItem.Text)) {
                sb.Append(prepend + "Vehicle Number: " + ddlVehicle_Search.SelectedItem.Text);
                prepend = "  ";
                sbFilter.Append(and + " fkNumber = '" + ddlVehicle_Search.SelectedValue + "'");
                and = " and ";
            }

            if (Utils.isNothingNot(tbWorkOrder_Search.Text) && tbWorkOrder_Search.Text.ToLower() != "lrfd-") {
                sb.Append(prepend + "Work Order ID: " + tbWorkOrder_Search.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbWorkOrder_Search.Text, "VWOID"));
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }

        protected override GridView getGridViewResults() {
            return gvResults; ;
        }

        protected override System.Data.DataSet buildDataSet() {
            return LRFDVehicalMaintenance_DataSet();
        }

        protected override System.Data.DataTable getGridViewDataTable() {
            return LRFDVehicalMaintenance_DataSet().Tables["VWOData"];
        }

        protected override Label getUpdateResultsLabel() {
            return lblRFDUpdateResults;
        }

        protected void btnRFDUpdate_Click(Object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspLRFDVehicleMaintenanceUpdate");
                cmd.Parameters.Add("@VWOID",SqlDbType.NVarChar).Value=VMOIDBeingEdited;
                cmd.Parameters.Add("@fkNumber", SqlDbType.NVarChar).Value = ddlRFDUpdateVehicleNumber.SelectedValue;
                cmd.Parameters.Add("@Estimate",SqlDbType.Bit).Value=ddlYesNoBlankEstimateUpdate.SelectedValue=="Yes"?true:false;
                cmd.Parameters.Add("@RequestBy",SqlDbType.NVarChar).Value=tbRFDUpdateRequestedBy.Text.Trim();
                cmd.Parameters.Add("@RequestNature",SqlDbType.NVarChar).Value=tbRFDUpdateVehicleDescription.Text.Trim();
                DateTime? dateIn =
                    tbLRFDUpdateRequestDateIn.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbLRFDUpdateRequestDateIn.Text.Trim());
                cmd.Parameters.Add("@DateIn", SqlDbType.DateTime).Value = dateIn;
                DateTime? dateOut =
                    tbRFDUpdateVehicleDateOut.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbRFDUpdateVehicleDateOut.Text.Trim());
                cmd.Parameters.Add("@DateOut", SqlDbType.DateTime).Value = dateOut;
                DateTime? dataEntryDate =
                    tbLRFDUpdateDataEntryDate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbLRFDUpdateDataEntryDate.Text.Trim());
                cmd.Parameters.Add("@DataEntryDate", SqlDbType.DateTime).Value = dataEntryDate;

                cmd.Parameters.Add("@DataEntryBy",SqlDbType.NVarChar).Value=tbRFDUpdateDataEntryBy.Text.Trim();
                cmd.Parameters.Add("@Odometer", SqlDbType.Real).Value = Utils.ObjectToDouble(tbLRFDUpdateOdometerReading.Text);     
                cmd.Parameters.Add("@HourMeter",SqlDbType.Real).Value=tbLRFDUpdateHourReading.Text.Trim();
                cmd.Parameters.Add("@Proceedure1",SqlDbType.NVarChar).Value=tbRFDUpdateProcedurePerformed.Text.Trim();
                cmd.Parameters.Add("@Comments",SqlDbType.NVarChar).Value=tbRFDUpdateComments.Text.Trim();
                cmd.Parameters.Add("@AdminRate", SqlDbType.Real).Value = Math.Round((Utils.ObjectToDouble(lblRFDUpdateDepartmentAdminCharges.Text.Trim().Replace(",","").Replace("%",""))/100),4);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);

                performPostUpdateSuccessfulActions("Update successful", LRFD_VEHICLE_MAINTENANCE_CACHE_KEY, LRFD_SurchargeRate_CACHE_KEY);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }

        protected override Label getNewResultsLabel() {
            return lblRFDNewResults;
        }

        protected override void unlockYourUpdateFields() {
            ddlRFDUpdateVehicleNumber.Enabled = true;
            btnRFDUpdate.Visible = true;
            tbLRFDUpdateDataEntryDate.Enabled = true;
            tbRFDUpdateDataEntryBy.Enabled = true;
            tbRFDUpdateVehicleDescription.Enabled = true;
            ddlYesNoBlankEstimateUpdate.Enabled = true;
            ibtbLRFDUpdateDataEntryDate.Visible = true;
            ibtbLRFDUpdateRequestDateIn.Visible = true;
            ibtbRFDUpdateVehicleDateOut.Visible = true;
            tbLRFDUpdateRequestDateIn.Enabled = true;
            tbRFDUpdateRequestedBy.Enabled = true;
            tbLRFDUpdateOdometerReading.Enabled = true;
            tbLRFDUpdateHourReading.Enabled = true;
            tbRFDUpdateVehicleDateOut.Enabled = true;
            tbRFDUpdateProcedurePerformed.Enabled = true;
            tbRFDUpdateComments.Enabled = true;
            gvRFDUpdateLabor.Enabled = true;
            gvRFDUpdateParts.Enabled = true;
            gvRFDUpdateService.Enabled = true;
            lbLRFDNewPart.Visible = true;
            lbLRFDNewLabor.Visible = true;
            lbLRFDNewService.Visible = true;
        }


        protected void gvUpdateParts_RowEditing(object sender, GridViewEditEventArgs e) {
            gvRFDUpdateParts.EditIndex = e.NewEditIndex;
            bindPartsTable();
        }

        protected void gvUpdateParts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvRFDUpdateParts.EditIndex = -1;
            bindPartsTable();
        }

        protected void gvUpdateParts_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvRFDUpdateParts.Rows[e.RowIndex];
            try {
                string description = ((TextBox)row.Cells[1].Controls[1]).Text.Trim();
                string number = ((TextBox)row.Cells[2].Controls[1]).Text.Trim();
                decimal rate = Utils.ObjectToDecimal(((TextBox)row.Cells[3].Controls[1]).Text.Trim().Replace("$", "").Replace(",", ""));
                double quantity = Utils.ObjectToDouble(((TextBox)row.Cells[4].Controls[1]).Text.Trim());
                int partId = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspLRFDPartsUpdate");
                cmd.Parameters.Add("@VWOPartID", SqlDbType.Int).Value = partId;
                cmd.Parameters.Add("@fkVWOP_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@ptDescription", SqlDbType.NVarChar).Value = description;
                cmd.Parameters.Add("@ptNumber", SqlDbType.NVarChar).Value = number;
                cmd.Parameters.Add("@ptRate", SqlDbType.Money).Value = rate;
                cmd.Parameters.Add("@ptQuan", SqlDbType.Real).Value = quantity;
                SqlParameter newid = new SqlParameter("@NewVWOPartID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Part updated", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Part not updated. Error msg: " + ee.Message);
            }
            gvRFDUpdateParts.EditIndex = -1;
            bindPartsTable();
        }
        protected void gvUpdateLabor_RowEditing(object sender, GridViewEditEventArgs e) {
            gvRFDUpdateLabor.EditIndex = e.NewEditIndex;
            bindLaborTable();
        }

        protected void gvUpdateLabor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvRFDUpdateLabor.EditIndex = -1;
            bindLaborTable();
        }

        protected void gvUpdateLabor_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvRFDUpdateLabor.Rows[e.RowIndex];
            try {

                int VWOLaborID = Utils.ObjectToInt(e.Keys[0]);
                string MechName = ((DropDownList)row.Cells[1].Controls[1]).SelectedItem.Text;
                decimal MechRate = Utils.ObjectToDecimal0IfNull(((TextBox)row.Cells[2].Controls[1]).Text.Trim().Replace("$", "").Replace(",", ""));
                double MechHours = Utils.ObjectToDouble(((TextBox)row.Cells[3].Controls[1]).Text.Trim());
                SqlCommand cmd = new SqlCommand("uspLRFDLaborUpdate");
                cmd.Parameters.Add("@VWOLaborID", SqlDbType.Int).Value = VWOLaborID;
                cmd.Parameters.Add("@fkVWOL_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@MechName", SqlDbType.NVarChar).Value = MechName;
                cmd.Parameters.Add("@MechHours", SqlDbType.Real).Value = MechHours;
                cmd.Parameters.Add("@MechRate", SqlDbType.Money).Value = MechRate;
                SqlParameter newid = new SqlParameter("@VWOLaborIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Labor updated", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Labor not updated. Error msg: " + ee.Message);
            }
            gvRFDUpdateLabor.EditIndex = -1;
            bindLaborTable();
        }
        protected void gvUpdateService_RowEditing(object sender, GridViewEditEventArgs e) {
            gvRFDUpdateService.EditIndex = e.NewEditIndex;
            bindServiceTable();
        }

        protected void gvUpdateService_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvRFDUpdateService.EditIndex = -1;
            bindServiceTable();
        }

        protected void gvUpdateParts_RowDeleting (Object sender, GridViewDeleteEventArgs e) {
            try {
                int VWOPartID = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspLRFDPartsDelete");
                cmd.Parameters.Add("@VWOPartID", SqlDbType.Int).Value = VWOPartID;
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Part deleted", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Part not deleted. Error msg: " + ee.Message);
            }
            bindPartsTable();
        }
        protected void gvUpdateParts_OnRowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                foreach (Object button in e.Row.Cells[0].Controls) {
                    if (button.GetType().Name == "DataControlLinkButton") {
                        if (((LinkButton)button).CommandName == "Delete") {
                            string item = ((Label)e.Row.Cells[1].Controls[1]).Text.Trim();
                            ((LinkButton)button).Attributes["onclick"] = "if(!confirm('Do you want to delete " + item + "?')){ return false; };";
                        }
                    }
                }
            }
        }

        protected void gvUpdateService_OnRowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                foreach (Object button in e.Row.Cells[0].Controls) {
                    if (button.GetType().Name == "DataControlLinkButton") {
                        if (((LinkButton)button).CommandName == "Delete") {
                            string item = ((Label)e.Row.Cells[1].Controls[1]).Text.Trim();
                            ((LinkButton)button).Attributes["onclick"] = "if(!confirm('Do you want to delete " + item + "?')){ return false; };";
                        }
                    }
                }
            }
        }

        protected void gvUpdateService_RowDeleting(Object sender, GridViewDeleteEventArgs e) {
            try {
                int VWOServiceID = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspLRFDServiceDelete");
                cmd.Parameters.Add("@VWOServiceID", SqlDbType.Int).Value = VWOServiceID;
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Service deleted", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Service not deleted. Error msg: " + ee.Message);
            }
            bindServiceTable();
        }

        protected void gvUpdateService_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvRFDUpdateService.Rows[e.RowIndex];
            try {
                string description = ((TextBox)row.Cells[1].Controls[1]).Text.Trim();
                string vendor = ((TextBox)row.Cells[2].Controls[1]).Text.Trim();
                decimal cost = Utils.ObjectToDecimal(((TextBox)row.Cells[3].Controls[1]).Text.Trim().Replace("$", "").Replace(",", ""));
                int id = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspLRFDServiceUpdate");
                cmd.Parameters.Add("@VWOCtrServID", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@fkVWOS_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@CSDescription", SqlDbType.NVarChar).Value = description;
                cmd.Parameters.Add("@CSVendor", SqlDbType.NVarChar).Value = vendor;
                cmd.Parameters.Add("@CSCost", SqlDbType.Money).Value = cost;
                SqlParameter newid = new SqlParameter("@VWOCtrServIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Part updated", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Part not updated. Error msg: " + ee.Message);
            }
            gvRFDUpdateService.EditIndex = -1;
            bindServiceTable();
        }


        protected override void lockYourUpdateFields() {
            lbLRFDNewPart.Visible = false;
            lbLRFDNewLabor.Visible = false;
            lbLRFDNewService.Visible = false;
            gvRFDUpdateLabor.Enabled = false;
            gvRFDUpdateParts.Enabled = false;
            gvRFDUpdateService.Enabled = false;
            tbRFDUpdateComments.Enabled = false;
            tbRFDUpdateVehicleDateOut.Enabled = false;
            tbRFDUpdateProcedurePerformed.Enabled = false;
            tbLRFDUpdateOdometerReading.Enabled = false;
            tbLRFDUpdateHourReading.Enabled = false;
            tbLRFDUpdateRequestDateIn.Enabled = false;
            tbRFDUpdateRequestedBy.Enabled = false;
            ibtbLRFDUpdateDataEntryDate.Visible = false;
            ibtbLRFDUpdateRequestDateIn.Visible = false;
            ibtbRFDUpdateVehicleDateOut.Visible = false;
            tbLRFDUpdateDataEntryDate.Enabled = false;
            ddlRFDUpdateVehicleNumber.Enabled = false;
            btnRFDUpdate.Visible = false;
            tbRFDUpdateVehicleDescription.Enabled = false;
            tbRFDUpdateDataEntryBy.Enabled = false;
            ddlYesNoBlankEstimateUpdate.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            ddlVehicle_Search.SelectedIndex = 0;
            tbWorkOrder_Search.Text = "LRFD-";
        }

        protected override void clearAllNewFormInputFields() {
            tbRFDNewDataEntryBy.Text = "";
            tbLRFDNewDataEntryDate.Text = "";
            ddlRFDNewVehicleNumber.SelectedIndex = 0;
            tbRFDNewRequestedBy.Text = "";
            tbLRFDNewRequestDateIn.Text = "";
            tbRFDNewVehicleDescription.Text = "";
            tbLRFDNewOdometerReading.Text = "";
            tbLRFDNewHourReading.Text = "";
            ddlYesNoBlankEstimateNew.SelectedIndex = 0;
            tbRFDNewProcedurePerformed.Text = "";
            tbRFDNewVehicleDateOut.Text = "";
            tbRFDNewComments.Text = "";
        }

        protected override string UpdateRoleName {
            get { return "canupdatelrfdvehiclemaintenance"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                if (UpdateRoleName == "all" || HttpContext.Current.User.IsInRole(UpdateRoleName)) {
                    lbLRFDVehicleMaintenanceNew.Visible = true;
                }
                DataTable dt = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"].Copy();
                DataRow newRow = dt.NewRow();
                newRow["Number"] = -1;
                newRow["VechicleNameForDDLs"] = "";
                dt.Rows.InsertAt(newRow, 0);
                ddlVehicle_Search.DataSource = dt;
                ddlVehicle_Search.DataBind();
                ddlRFDUpdateVehicleNumber.DataSource = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
                ddlRFDUpdateVehicleNumber.DataBind();
                ddlRFDNewLaborMechName.DataSource = LRFDVehicalMaintenance_DataSet().Tables["LRFDMechanicInfo"];
                ddlRFDNewLaborMechName.DataBind();
                ddlRFDNewVehicleNumber.DataSource = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
                ddlRFDNewVehicleNumber.DataBind();
            }
        }
        protected string getCost(object quan, object rate) {
            return
                (Utils.ObjectToDouble(quan) * Utils.ObjectToDouble(rate)).ToString("c");
        }
        protected string getSurchargeRateAsPercentage() {
            return getSurchargeRate().ToString("P");
        }
        private double getSurchargeRateFromDictionary(Dictionary<string, double> surchargeDictionary, string fkNumber) {
            double surchargeRate = .05d;
            try {
                surchargeRate = surchargeDictionary[fkNumber];
            } catch {
                DataTable sourceTableVehicle = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
                DataView viewVehicle = new DataView(sourceTableVehicle);
                viewVehicle.RowFilter = "Number='" + fkNumber + "'";
                DataTable tblFilteredVehicle = viewVehicle.ToTable();
                DataRow drVehicle = tblFilteredVehicle.Rows[0];
                int deptId = Utils.ObjectToInt(drVehicle["fkDeptID"]);
                DataTable sourceTableDept = LRFDVehicalMaintenance_DataSet().Tables["LRFDDepartment"];
                DataView viewDept = new DataView(sourceTableDept);
                viewDept.RowFilter = "DepartmentID=" + deptId;
                DataTable tblFilteredDepartment = viewDept.ToTable();
                DataRow drDept = tblFilteredDepartment.Rows[0];
                surchargeRate = Utils.ObjectToDouble(drDept["PartMarkUpRate"]);
                surchargeDictionary[fkNumber] = surchargeRate;
            }
            return surchargeRate;
        }
        private double getCacheSurchargeRateForVehicle(string fkNumber) {
            MemoryCache cache = MemoryCache.Default;
            string key = LRFD_SurchargeRate_CACHE_KEY;
            Dictionary<string, double> surchargeDictionary = (Dictionary<string, double>)cache[key];
            if (surchargeDictionary == null) {
                surchargeDictionary = new Dictionary<string, double>();
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, surchargeDictionary, policy);
            }
            double SurchargeRate = getSurchargeRateFromDictionary(surchargeDictionary, fkNumber);
            return SurchargeRate;
        }
        private double getSurchargeRate() {
            /* I've got the vehicle (fkNumber), and find the departmentid (fkDeptID), and find the PartMarkUpRate. */
            DataTable sourceTable = LRFDVehicalMaintenance_DataSet().Tables["VWOData"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "VWOID='" + VMOIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            string fkNumber = Utils.ObjectToString(dr["fkNumber"]);
            return getCacheSurchargeRateForVehicle(fkNumber);
        }
        protected string getSurcharge(object quan, object rate) {
            double charge = Utils.ObjectToInt(quan) * Utils.ObjectToDouble(rate);
            return (charge * getSurchargeRate()).ToString("c");
        }
        protected string getItemCost(object quan, object rate) {
            double charge = Utils.ObjectToInt(quan) * Utils.ObjectToDouble(rate);
            charge += charge * getSurchargeRate();
            return charge.ToString("c");
        }
        private double getTotalPartsCost() {
            DataTable sourceTable = LRFDVehicalMaintenance_DataSet().Tables["VWOParts"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "fkVWOP_ID='" + VMOIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            double totalCost = 0d;
            foreach (DataRow dr in tblFiltered.Rows) {
                double cost = Utils.ObjectToDouble(dr["PtRate"]) * Utils.ObjectToInt(dr["PtQuan"]);
                cost += (cost * getSurchargeRate());
                totalCost += cost;
            }
            return totalCost;
        }
        protected string getTotalPartsCostString() {
            return getTotalPartsCost().ToString("c");
        }
        private double getTotalLaborCost() {
            DataTable sourceTable = LRFDVehicalMaintenance_DataSet().Tables["VWOLabor"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "fkVWOL_ID='" + VMOIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            double totalCost = 0d;
            foreach (DataRow dr in tblFiltered.Rows) {
                double cost = Utils.ObjectToDouble(dr["MechRate"]) * Utils.ObjectToDouble(dr["MechHours"]);
                totalCost += cost;
            }
            return totalCost;
        }
        protected string getTotalLaborCostString() {
            return getTotalLaborCost().ToString("c");
        }
        private double getTotalServicesCost() {
            DataTable sourceTable = LRFDVehicalMaintenance_DataSet().Tables["VWOServices"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "fkVWOS_ID='" + VMOIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            double totalCost = 0d;
            foreach (DataRow dr in tblFiltered.Rows) {
                double cost = Utils.ObjectToDouble(dr["CSCost"]);
                totalCost += cost;
            }
            return totalCost;
        }
        protected string getTotalServicesCostString() {
            return getTotalServicesCost().ToString("c");
        }
        protected string getTotalWorkOrderCost() {
            return (getTotalLaborCost() + getTotalPartsCost() + getTotalServicesCost()).ToString("c");
        }
        protected void btnNewLRFDServiceOk_Click(Object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspLRFDServiceUpdate");
                cmd.Parameters.Add("@fkVWOS_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@CSDescription", SqlDbType.NVarChar).Value = tbServiceDescriptionNew.Text;
                cmd.Parameters.Add("@CSVendor", SqlDbType.NVarChar).Value = tbServiceVendorNew.Text;
                decimal cost = Utils.ObjectToDecimal(tbLRFDServiceCostNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@CSCost", SqlDbType.Money).Value = cost;
                SqlParameter newid = new SqlParameter("@VWOCtrServIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                tbServiceDescriptionNew.Text = "";
                tbServiceVendorNew.Text = "";
                tbLRFDServiceCostNew.Text = "";
                performPostUpdateSuccessfulActions("Labor added", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Labor not added. Error msg: " + ee.Message);
            }
        }
        protected void btnNewLRFDLaborOk_Click(Object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspLRFDLaborUpdate");
                cmd.Parameters.Add("@MechName", SqlDbType.NVarChar).Value = ddlRFDNewLaborMechName.SelectedItem.Text;
                cmd.Parameters.Add("@fkVWOL_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                decimal rate = Utils.ObjectToDecimal(tbLRFDLaborRateNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@MechRate", SqlDbType.Money).Value = rate;
                double hours = Utils.ObjectToDouble(tbLRFDLaborHoursNew.Text.Trim());
                cmd.Parameters.Add("@MechHours", SqlDbType.Real).Value = hours;
                SqlParameter newid = new SqlParameter("@VWOLaborIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                ddlRFDNewLaborMechName.SelectedIndex = -1;
                tbLRFDLaborRateNew.Text = "";
                tbLRFDLaborHoursNew.Text = "";

                performPostUpdateSuccessfulActions("Labor added", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Labor not added. Error msg: " + ee.Message);
            }
        }
        protected void lbLRFDNewService_OnClick(object sender, EventArgs args) {
            mpeLRFDNewService.Show();
        }
        protected void lbLRFDNewLabor_OnClick(object sender, EventArgs args) {
            tbLRFDLaborRateNew.Text = Utils.ObjectToDecimal(LRFDVehicalMaintenance_DataSet().Tables["LRFDMechanicInfo"].Rows[0]["MechRate"]).ToString("c");
            mpeLRFDNewLabor.Show();
        }
        protected void gvUpdateLabor_RowDeleting(Object sender, GridViewDeleteEventArgs e) {
            try {
                int VWOLaborID = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspLRFDLaborDelete");
                cmd.Parameters.Add("@VWOLaborID", SqlDbType.Int).Value = VWOLaborID;
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Labor deleted", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Labor not deleted. Error msg: " + ee.Message);
            }
            bindLaborTable();
        }
        protected void gvUpdateLabor_OnRowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {

                foreach (Object button in e.Row.Cells[0].Controls) {
                    if (button.GetType().Name == "DataControlLinkButton") {
                        if (((LinkButton)button).CommandName == "Delete") {
                            string item = ((Label)e.Row.Cells[1].Controls[1]).Text.Trim();
                            ((LinkButton)button).Attributes["onclick"] = "if(!confirm('Do you want to delete " + item + "?')){ return false; };";
                        }
                    }
                }


                //Find the DropDownList in the Row
                DropDownList ddlLaborMechanics = (e.Row.FindControl("ddlRFDUpdateLaborMechName") as DropDownList);
                if (ddlLaborMechanics != null) {
                    ddlLaborMechanics.DataSource = LRFDVehicalMaintenance_DataSet().Tables["LRFDMechanicInfo"];
                    ddlLaborMechanics.DataBind();

                    //Select the Mechanic in DropDownList
                    string mechanic = (e.Row.FindControl("lblRFDUpdateLaborMechName") as Label).Text;
                    ddlLaborMechanics.Items.FindByText(mechanic).Selected = true;
                }
            }
        }
        protected void ddlRFDNewLaborMechName_OnSelectedIndexChanged(object sender, EventArgs args) {
            DataTable sourceTable = LRFDVehicalMaintenance_DataSet().Tables["LRFDMechanicInfo"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "MechID=" + ddlRFDNewLaborMechName.SelectedValue;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            tbLRFDLaborRateNew.Text = Utils.ObjectToDecimal(dr["MechRate"]).ToString("c");
            mpeLRFDNewLabor.Show();
        }
        protected void lblLRFDNewPart_OnClick(object sender, EventArgs args) {
            mpeLRFDNewPart.Show();
        }
        protected void btnNewLRFDPartOk_Click(object sender, EventArgs args) {
            try {
                string description = tbPartDescriptionNew.Text.Trim();
                string number = tbPartNumberNew.Text.Trim();
                decimal rate = Utils.ObjectToDecimal(tbLRFDPartRateNew.Text.Trim().Replace("$", "").Replace(",", ""));
                double quantity = Utils.ObjectToDouble(tbRFDNewPartsPTQuantity.Text.Trim());
                SqlCommand cmd = new SqlCommand("uspLRFDPartsUpdate");
                cmd.Parameters.Add("@fkVWOP_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@ptDescription", SqlDbType.NVarChar).Value = description;
                cmd.Parameters.Add("@ptNumber", SqlDbType.NVarChar).Value = number;
                cmd.Parameters.Add("@ptRate", SqlDbType.Money).Value = rate;
                cmd.Parameters.Add("@ptQuan", SqlDbType.Real).Value = quantity;
                SqlParameter newid = new SqlParameter("@NewVWOPartID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                tbPartDescriptionNew.Text = "";
                tbPartNumberNew.Text = "";
                tbLRFDPartRateNew.Text = "";
                tbRFDNewPartsPTQuantity.Text = "";
                performPostUpdateSuccessfulActions("Labor added", "LRFD_CACHE_KEY", "LRFD_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Labor not added. Error msg: " + ee.Message);
            }
        }
        protected void ddlRFDNewVehicleNumber_OnSelectedIndexChanged(object sender, EventArgs args) {
            DataTable vehicleTable = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
            DataView vehicleView = new DataView(vehicleTable);
            vehicleView.RowFilter = "Number='" + ddlRFDNewVehicleNumber.SelectedValue + "'";
            DataTable vehicleViewFiltered = vehicleView.ToTable();
            DataRow drZVehicle = vehicleViewFiltered.Rows[0];

            DataTable deptTable = LRFDVehicalMaintenance_DataSet().Tables["LRFDDepartment"];
            DataView deptView = new DataView(deptTable);
            deptView.RowFilter = "DepartmentID=" + drZVehicle["fkDeptID"];
            DataTable deptViewFiltered = deptView.ToTable();
            DataRow drZDept = deptViewFiltered.Rows[0];

            lblRFDNewDepartmentId.Text = Utils.ObjectToString(drZDept["DepartmentID"]);
            lblRFDNewDepartmentAdminCharges.Text = ((Utils.ObjectToDecimal(drZDept["AdministrationRate"]))).ToString("P");
            mpeLRFDVehicleMaintenance.Show();
        }
        protected void lbLRFDVehicleMaintenanceNew_OnClick(Object sender, EventArgs args) {
            SqlCommand cmd=new SqlCommand("uspLRFDFindHighestWordOrderNumber");
            SqlParameter parm = new SqlParameter("@HighestWorkOrderIntergerComponent", SqlDbType.Int);
            parm.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parm);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
            tbNewWorkOrderNbr.Text = "LRFD-" + (Utils.ObjectToInt(parm.Value) + 1);
            tbRFDNewDataEntryBy.Text = HttpContext.Current.User.Identity.Name;
            tbLRFDNewDataEntryDate.Text = DateTime.Now.ToShortDateString();
            tbRFDNewRequestedBy.Text = "LRFD";
            ddlRFDNewVehicleNumber_OnSelectedIndexChanged(null, null);
        }
        protected void btnNewLRFDVehicleMaintenanceOk_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspLRFDVehicleMaintenanceUpdate");
                cmd.Parameters.Add("@VWOID_new", SqlDbType.NVarChar).Value = tbNewWorkOrderNbr.Text;
                cmd.Parameters.Add("@fkNumber", SqlDbType.NVarChar).Value = ddlRFDNewVehicleNumber.SelectedValue;
                cmd.Parameters.Add("@Estimate", SqlDbType.Bit).Value = ddlYesNoBlankEstimateNew.SelectedValue == "Yes" ? true : false;
                cmd.Parameters.Add("@RequestBy", SqlDbType.NVarChar).Value = tbRFDNewRequestedBy.Text.Trim();
                cmd.Parameters.Add("@RequestNature", SqlDbType.NVarChar).Value = tbRFDNewVehicleDescription.Text.Trim();
                DateTime? dateIn =
                    tbLRFDNewRequestDateIn.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbLRFDNewRequestDateIn.Text.Trim());
                cmd.Parameters.Add("@DateIn", SqlDbType.DateTime).Value = dateIn;
                DateTime? dateOut =
                    tbRFDNewVehicleDateOut.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbRFDNewVehicleDateOut.Text.Trim());
                cmd.Parameters.Add("@DateOut", SqlDbType.DateTime).Value = dateOut;
                DateTime? dataEntryDate =
                    tbLRFDNewDataEntryDate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbLRFDNewDataEntryDate.Text.Trim());
                cmd.Parameters.Add("@DataEntryDate", SqlDbType.DateTime).Value = dataEntryDate;

                cmd.Parameters.Add("@DataEntryBy", SqlDbType.NVarChar).Value = tbRFDNewDataEntryBy.Text.Trim();
                cmd.Parameters.Add("@Odometer", SqlDbType.Real).Value = Utils.ObjectToDouble(tbLRFDNewOdometerReading.Text);
                cmd.Parameters.Add("@HourMeter", SqlDbType.Real).Value = tbLRFDNewHourReading.Text.Trim();
                cmd.Parameters.Add("@Proceedure1", SqlDbType.NVarChar).Value = tbRFDNewProcedurePerformed.Text.Trim();
                cmd.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = tbRFDNewComments.Text.Trim();
                cmd.Parameters.Add("@AdminRate", SqlDbType.Real).Value = Math.Round((Utils.ObjectToDouble(lblRFDNewDepartmentAdminCharges.Text.Trim().Replace(",", "").Replace("%", "")) / 100), 4);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["LRFDVehicleMainenanceConnectionString"].ConnectionString);
                performPostNewSuccessfulActions("Vehicle Maintenance added successfully", LRFD_VEHICLE_MAINTENANCE_CACHE_KEY, LRFD_SurchargeRate_CACHE_KEY, tbWorkOrder_Search, tbNewWorkOrderNbr.Text);

                mpeLRFDVehicleMaintenance.Hide();
            } catch (Exception e) {
                performPostNewFailedActions("New Vehicle Maintenance not added. Msg: " + e.Message);
            }
        }
        protected void btnNewSLRFDVehicleMaintenanceCancel_Click(object sender, EventArgs args) {
        }
    }
}