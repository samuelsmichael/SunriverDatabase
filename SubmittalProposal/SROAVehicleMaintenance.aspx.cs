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
    public partial class SROAVehicleMaintenance : AbstractDatabase {
        public static string SROA_VEHICLE_MAINTENANCE_CACHE_KEY = "SROA_CACHE_KEY";
        public static string SROA_SurchargeRate_CACHE_KEY = "SROA_SurchargeRate_CACHE_KEY";
        public static DataSet SROAVehicalMaintenance_DataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = SROA_VEHICLE_MAINTENANCE_CACHE_KEY;
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspSROAVehicleMaintenanceTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                ds.Tables[0].TableName = "VWOData";
                ds.Tables[1].TableName = "VWOLabor";
                ds.Tables[2].TableName = "VWOParts";
                ds.Tables[3].TableName = "VWOServices";
                ds.Tables[4].TableName = "SROADepartment";
                ds.Tables[5].TableName = "SROAMechanicInfo";
                ds.Tables[6].TableName = "SROAVehicelList";
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
                        vehicleName = Utils.ObjectToString(ds.Tables["SROAVehicelList"].Rows.Find(dr["fkNumber"])["Description"]);
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
            lbSROAUpdateWOI.Text = VMOIDBeingEdited;
            ddSROAUpdateVehicleNumber.SelectedValue = Utils.ObjectToString(dr["fkNumber"]);
            tbSROAUpdateVehicleDescription.Text = Utils.ObjectToString(dr["Request Nature"]);
            string estimate = Utils.ObjectToString(dr["Estimate"]);
            ddlYesNoBlankEstimateUpdate.SelectedValue = (estimate == "" ? "" : estimate == "True" ? "Yes" : "No");
            tbSROAUpdateDataEntryBy.Text = Utils.ObjectToString(dr["Data Entry By"]);
            DateTime? entryDate = Utils.ObjectToDateTimeNullable(dr["Data Entry Date"]);
            tbSROAUpdateDataEntryDate.Text = entryDate.HasValue ? entryDate.Value.ToString("d") : "";
            DateTime? requestDateIn = Utils.ObjectToDateTimeNullable(dr["Date In"]);
            tbSROAUpdateRequestDateIn.Text = requestDateIn.HasValue ? requestDateIn.Value.ToString("d") : "";
            tbSROAUpdateRequestedBy.Text = Utils.ObjectToString(dr["Request By"]);
            tbSROAUpdateOdometerReading.Text = Utils.ObjectToString(dr["Odometer"]);
            tbSROAUpdateHourReading.Text = Utils.ObjectToString(dr["hour Meter"]);
            DataTable vehicleTable = SROAVehicalMaintenance_DataSet().Tables["SROAVehicelList"];
            DataView vehicleView = new DataView(vehicleTable);
            vehicleView.RowFilter = "Number='" + dr["fkNumber"] + "'";
            DataTable vehicleViewFiltered = vehicleView.ToTable();
            DataRow drZVehicle = vehicleViewFiltered.Rows[0];

            DataTable deptTable = SROAVehicalMaintenance_DataSet().Tables["SROADepartment"];
            DataView deptView = new DataView(deptTable);
            deptView.RowFilter = "DepartmentID=" + drZVehicle["fkDeptID"];
            DataTable deptViewFiltered = deptView.ToTable();
            DataRow drZDept = deptViewFiltered.Rows[0];
            bindPartsTable();
            bindLaborTable();
            bindServiceTable();

            lbSROAUpdateDepartmentId.Text = "" + drZDept["DepartmentID"] + " - " + drZDept["Department"];
            lbSROAUpdateDepartmentAdminCharges.Text = "" + (Convert.ToDouble(drZDept["AdministrationRate"])).ToString("P");
            DateTime? dateOut = Utils.ObjectToDateTimeNullable(dr["Date Out"]);
            tbSROAUpdateVehicleDateOut.Text = dateOut.HasValue ? dateOut.Value.ToString("d") : "";
            tbSROAUpdateProcedurePerformed.Text = Utils.ObjectToString(dr["Proceedure 1"]);
            tbSROAUpdateComments.Text = Utils.ObjectToString(dr["Comments"]);
            lblTotalWorkOrderCost.Text = getTotalWorkOrderCost();

            return "Work Order #: " + VMOIDBeingEdited + " Vehicle ID: " + Utils.ObjectToString(dr["fkNumber"]) + " Vehicle description: " + Utils.ObjectToString(dr["VehicleName"]);
        }
        private void bindPartsTable() {
            DataTable partsTable = SROAVehicalMaintenance_DataSet().Tables["VWOParts"];
            DataView partsView = new DataView(partsTable);
            partsView.RowFilter = "fkVWOP_ID='" + VMOIDBeingEdited + "'";
            DataTable partsViewFiltered = partsView.ToTable();
            gvSROAUpdateParts.DataSource = partsViewFiltered;
            gvSROAUpdateParts.DataBind();
        }
        private void bindLaborTable() {
            DataTable laborTable = SROAVehicalMaintenance_DataSet().Tables["VWOLabor"];
            DataView laborView = new DataView(laborTable);
            laborView.RowFilter = "fkVWOL_ID='" + VMOIDBeingEdited + "'";
            DataTable laborViewFiltered = laborView.ToTable();
            gvSROAUpdateLabor.DataSource = laborViewFiltered;
            gvSROAUpdateLabor.DataBind();
        }
        private void bindServiceTable() {
            DataTable ServiceTable = SROAVehicalMaintenance_DataSet().Tables["VWOServices"];
            DataView ServiceView = new DataView(ServiceTable);
            ServiceView.RowFilter = "fkVWOS_ID='" + VMOIDBeingEdited + "'";
            DataTable ServiceViewFiltered = ServiceView.ToTable();
            gvSROAUpdateService.DataSource = ServiceViewFiltered;
            gvSROAUpdateService.DataBind();
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

            if (Utils.isNothingNot(tbWorkOrder_Search.Text) && tbWorkOrder_Search.Text.ToLower() != "sroa-") {
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
            return SROAVehicalMaintenance_DataSet();
        }

        protected override System.Data.DataTable getGridViewDataTable() {
            return SROAVehicalMaintenance_DataSet().Tables["VWOData"];
        }

        protected override Label getUpdateResultsLabel() {
            return lbSROAUpdateResults;
        }

        protected void btnSROAUpdate_Click(Object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspSROAVehicleMaintenanceUpdate");
                cmd.Parameters.Add("@VWOID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@fkNumber", SqlDbType.NVarChar).Value = ddSROAUpdateVehicleNumber.SelectedValue;
                cmd.Parameters.Add("@Estimate", SqlDbType.Bit).Value = ddlYesNoBlankEstimateUpdate.SelectedValue == "Yes" ? true : false;
                cmd.Parameters.Add("@RequestBy", SqlDbType.NVarChar).Value = tbSROAUpdateRequestedBy.Text.Trim();
                cmd.Parameters.Add("@RequestNature", SqlDbType.NVarChar).Value = tbSROAUpdateVehicleDescription.Text.Trim();
                DateTime? dateIn =
                    tbSROAUpdateRequestDateIn.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbSROAUpdateRequestDateIn.Text.Trim());
                cmd.Parameters.Add("@DateIn", SqlDbType.DateTime).Value = dateIn;
                DateTime? dateOut =
                    tbSROAUpdateVehicleDateOut.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbSROAUpdateVehicleDateOut.Text.Trim());
                cmd.Parameters.Add("@DateOut", SqlDbType.DateTime).Value = dateOut;
                DateTime? dataEntryDate =
                    tbSROAUpdateDataEntryDate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbSROAUpdateDataEntryDate.Text.Trim());
                cmd.Parameters.Add("@DataEntryDate", SqlDbType.DateTime).Value = dataEntryDate;

                cmd.Parameters.Add("@DataEntryBy", SqlDbType.NVarChar).Value = tbSROAUpdateDataEntryBy.Text.Trim();
                cmd.Parameters.Add("@Odometer", SqlDbType.Real).Value = Utils.ObjectToDouble(tbSROAUpdateOdometerReading.Text);
                cmd.Parameters.Add("@HourMeter", SqlDbType.Real).Value = tbSROAUpdateHourReading.Text.Trim();
                cmd.Parameters.Add("@Proceedure1", SqlDbType.NVarChar).Value = tbSROAUpdateProcedurePerformed.Text.Trim();
                cmd.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = tbSROAUpdateComments.Text.Trim();
                cmd.Parameters.Add("@AdminRate", SqlDbType.Real).Value = Math.Round((Utils.ObjectToDouble(lbSROAUpdateDepartmentAdminCharges.Text.Trim().Replace(",", "").Replace("%", "")) / 100), 4);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);

                performPostUpdateSuccessfulActions("Update successful", SROA_VEHICLE_MAINTENANCE_CACHE_KEY, SROA_SurchargeRate_CACHE_KEY);
            } catch (Exception ee) {
                performPostUpdateFailedActions("Update failed. Msg: " + ee.Message);
            }
        }

        protected override Label getNewResultsLabel() {
            return lbSROANewResults;
        }

        protected override void unlockYourUpdateFields() {
            ddSROAUpdateVehicleNumber.Enabled = true;
            btnSROAUpdate.Visible = true;
            tbSROAUpdateDataEntryDate.Enabled = true;
            tbSROAUpdateDataEntryBy.Enabled = true;
            tbSROAUpdateVehicleDescription.Enabled = true;
            ddlYesNoBlankEstimateUpdate.Enabled = true;
            ibtbSROAUpdateDataEntryDate.Visible = true;
            ibtbSROAUpdateRequestDateIn.Visible = true;
            ibtbSROAUpdateVehicleDateOut.Visible = true;
            tbSROAUpdateRequestDateIn.Enabled = true;
            tbSROAUpdateRequestedBy.Enabled = true;
            tbSROAUpdateOdometerReading.Enabled = true;
            tbSROAUpdateHourReading.Enabled = true;
            tbSROAUpdateVehicleDateOut.Enabled = true;
            tbSROAUpdateProcedurePerformed.Enabled = true;
            tbSROAUpdateComments.Enabled = true;
            gvSROAUpdateLabor.Enabled = true;
            gvSROAUpdateParts.Enabled = true;
            gvSROAUpdateService.Enabled = true;
            lbSROANewPart.Visible = true;
            lbSROANewLabor.Visible = true;
            lbSROANewService.Visible = true;
        }


        protected void gvUpdateParts_RowEditing(object sender, GridViewEditEventArgs e) {
            gvSROAUpdateParts.EditIndex = e.NewEditIndex;
            bindPartsTable();
        }

        protected void gvUpdateParts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvSROAUpdateParts.EditIndex = -1;
            bindPartsTable();
        }

        protected void gvUpdateParts_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvSROAUpdateParts.Rows[e.RowIndex];
            try {
                string description = ((TextBox)row.Cells[1].Controls[1]).Text.Trim();
                string number = ((TextBox)row.Cells[2].Controls[1]).Text.Trim();
                decimal rate = Utils.ObjectToDecimal(((TextBox)row.Cells[3].Controls[1]).Text.Trim().Replace("$", "").Replace(",", ""));
                double quantity = Utils.ObjectToDouble(((TextBox)row.Cells[4].Controls[1]).Text.Trim());
                int partId = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspSROAPartsUpdate");
                cmd.Parameters.Add("@VWOPartID", SqlDbType.Int).Value = partId;
                cmd.Parameters.Add("@fkVWOP_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@ptDescription", SqlDbType.NVarChar).Value = description;
                cmd.Parameters.Add("@ptNumber", SqlDbType.NVarChar).Value = number;
                cmd.Parameters.Add("@ptRate", SqlDbType.Money).Value = rate;
                cmd.Parameters.Add("@ptQuan", SqlDbType.Real).Value = quantity;
                SqlParameter newid = new SqlParameter("@NewVWOPartID", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Part updated", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Part not updated. Error msg: " + ee.Message);
            }
            gvSROAUpdateParts.EditIndex = -1;
            bindPartsTable();
        }
        protected void gvUpdateLabor_RowEditing(object sender, GridViewEditEventArgs e) {
            gvSROAUpdateLabor.EditIndex = e.NewEditIndex;
            bindLaborTable();
        }

        protected void gvUpdateLabor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvSROAUpdateLabor.EditIndex = -1;
            bindLaborTable();
        }

        protected void gvUpdateLabor_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvSROAUpdateLabor.Rows[e.RowIndex];
            try {

                int VWOLaborID = Utils.ObjectToInt(e.Keys[0]);
                string MechName = ((DropDownList)row.Cells[1].Controls[1]).SelectedItem.Text;
                decimal MechRate = Utils.ObjectToDecimal0IfNull(((TextBox)row.Cells[2].Controls[1]).Text.Trim().Replace("$", "").Replace(",", ""));
                double MechHours = Utils.ObjectToDouble(((TextBox)row.Cells[3].Controls[1]).Text.Trim());
                SqlCommand cmd = new SqlCommand("uspSROALaborUpdate");
                cmd.Parameters.Add("@VWOLaborID", SqlDbType.Int).Value = VWOLaborID;
                cmd.Parameters.Add("@fkVWOL_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@MechName", SqlDbType.NVarChar).Value = MechName;
                cmd.Parameters.Add("@MechHours", SqlDbType.Real).Value = MechHours;
                cmd.Parameters.Add("@MechRate", SqlDbType.Money).Value = MechRate;
                SqlParameter newid = new SqlParameter("@VWOLaborIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Labor updated", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Labor not updated. Error msg: " + ee.Message);
            }
            gvSROAUpdateLabor.EditIndex = -1;
            bindLaborTable();
        }
        protected void gvUpdateService_RowEditing(object sender, GridViewEditEventArgs e) {
            gvSROAUpdateService.EditIndex = e.NewEditIndex;
            bindServiceTable();
        }

        protected void gvUpdateService_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvSROAUpdateService.EditIndex = -1;
            bindServiceTable();
        }

        protected void gvUpdateParts_RowDeleting (Object sender, GridViewDeleteEventArgs e) {
            try {
                int VWOPartID = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspSROAPartsDelete");
                cmd.Parameters.Add("@VWOPartID", SqlDbType.Int).Value = VWOPartID;
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Part deleted", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
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
                SqlCommand cmd = new SqlCommand("uspSROAServiceDelete");
                cmd.Parameters.Add("@VWOServiceID", SqlDbType.Int).Value = VWOServiceID;
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Service deleted", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Service not deleted. Error msg: " + ee.Message);
            }
            bindServiceTable();
        }

        protected void gvUpdateService_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvSROAUpdateService.Rows[e.RowIndex];
            try {
                string description = ((TextBox)row.Cells[1].Controls[1]).Text.Trim();
                string vendor = ((TextBox)row.Cells[2].Controls[1]).Text.Trim();
                decimal cost = Utils.ObjectToDecimal(((TextBox)row.Cells[3].Controls[1]).Text.Trim().Replace("$", "").Replace(",", ""));
                int id = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspSROAServiceUpdate");
                cmd.Parameters.Add("@VWOCtrServID", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@fkVWOS_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@CSDescription", SqlDbType.NVarChar).Value = description;
                cmd.Parameters.Add("@CSVendor", SqlDbType.NVarChar).Value = vendor;
                cmd.Parameters.Add("@CSCost", SqlDbType.Money).Value = cost;
                SqlParameter newid = new SqlParameter("@VWOCtrServIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Part updated", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Part not updated. Error msg: " + ee.Message);
            }
            gvSROAUpdateService.EditIndex = -1;
            bindServiceTable();
        }


        protected override void lockYourUpdateFields() {
            lbSROANewPart.Visible = false;
            lbSROANewLabor.Visible = false;
            lbSROANewService.Visible = false;
            gvSROAUpdateLabor.Enabled = false;
            gvSROAUpdateParts.Enabled = false;
            gvSROAUpdateService.Enabled = false;
            tbSROAUpdateComments.Enabled = false;
            tbSROAUpdateVehicleDateOut.Enabled = false;
            tbSROAUpdateProcedurePerformed.Enabled = false;
            tbSROAUpdateOdometerReading.Enabled = false;
            tbSROAUpdateHourReading.Enabled = false;
            tbSROAUpdateRequestDateIn.Enabled = false;
            tbSROAUpdateRequestedBy.Enabled = false;
            ibtbSROAUpdateDataEntryDate.Visible = false;
            ibtbSROAUpdateRequestDateIn.Visible = false;
            ibtbSROAUpdateVehicleDateOut.Visible = false;
            tbSROAUpdateDataEntryDate.Enabled = false;
            ddSROAUpdateVehicleNumber.Enabled = false;
            btnSROAUpdate.Visible = false;
            tbSROAUpdateVehicleDescription.Enabled = false;
            tbSROAUpdateDataEntryBy.Enabled = false;
            ddlYesNoBlankEstimateUpdate.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            ddlVehicle_Search.SelectedIndex = 0;
            tbWorkOrder_Search.Text = "SROA-";
        }

        protected override void clearAllNewFormInputFields() {
            tbSROANewDataEntryBy.Text = "";
            tbSROANewDataEntryDate.Text = "";
            ddSROANewVehicleNumber.SelectedIndex = 0;
            tbSROANewRequestedBy.Text = "";
            tbSROANewRequestDateIn.Text = "";
            tbSROANewVehicleDescription.Text = "";
            tbSROANewOdometerReading.Text = "";
            tbSROANewHourReading.Text = "";
            ddlYesNoBlankEstimateNew.SelectedIndex = 0;
            tbSROANewProcedurePerformed.Text = "";
            tbSROANewVehicleDateOut.Text = "";
            tbSROANewComments.Text = "";
        }

        protected override string UpdateRoleName {
            get { return "canupdateSROAvehiclemaintenance"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                if (UpdateRoleName == "all" || HttpContext.Current.User.IsInRole(UpdateRoleName)) {
                    lbSROAVehicleMaintenanceNew.Visible = true;
                }
                DataTable dt = SROAVehicalMaintenance_DataSet().Tables["SROAVehicelList"].Copy();
                DataRow newRow = dt.NewRow();
                newRow["Number"] = -1;
                newRow["VechicleNameForDDLs"] = "";
                dt.Rows.InsertAt(newRow, 0);
                ddlVehicle_Search.DataSource = dt;
                ddlVehicle_Search.DataBind();
                ddSROAUpdateVehicleNumber.DataSource = SROAVehicalMaintenance_DataSet().Tables["SROAVehicelList"];
                ddSROAUpdateVehicleNumber.DataBind();
                ddSROANewLaborMechName.DataSource = SROAVehicalMaintenance_DataSet().Tables["SROAMechanicInfo"];
                ddSROANewLaborMechName.DataBind();
                ddSROANewVehicleNumber.DataSource = SROAVehicalMaintenance_DataSet().Tables["SROAVehicelList"];
                ddSROANewVehicleNumber.DataBind();
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
                DataTable sourceTableVehicle = SROAVehicalMaintenance_DataSet().Tables["SROAVehicelList"];
                DataView viewVehicle = new DataView(sourceTableVehicle);
                viewVehicle.RowFilter = "Number='" + fkNumber + "'";
                DataTable tblFilteredVehicle = viewVehicle.ToTable();
                DataRow drVehicle = tblFilteredVehicle.Rows[0];
                int deptId = Utils.ObjectToInt(drVehicle["fkDeptID"]);
                DataTable sourceTableDept = SROAVehicalMaintenance_DataSet().Tables["SROADepartment"];
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
            string key = SROA_SurchargeRate_CACHE_KEY;
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
            DataTable sourceTable = SROAVehicalMaintenance_DataSet().Tables["VWOData"];
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
            DataTable sourceTable = SROAVehicalMaintenance_DataSet().Tables["VWOParts"];
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
            DataTable sourceTable = SROAVehicalMaintenance_DataSet().Tables["VWOLabor"];
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
            DataTable sourceTable = SROAVehicalMaintenance_DataSet().Tables["VWOServices"];
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
        protected void btnNewSROAServiceOk_Click(Object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspSROAServiceUpdate");
                cmd.Parameters.Add("@fkVWOS_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                cmd.Parameters.Add("@CSDescription", SqlDbType.NVarChar).Value = tbServiceDescriptionNew.Text;
                cmd.Parameters.Add("@CSVendor", SqlDbType.NVarChar).Value = tbServiceVendorNew.Text;
                decimal cost = Utils.ObjectToDecimal(tbSROAServiceCostNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@CSCost", SqlDbType.Money).Value = cost;
                SqlParameter newid = new SqlParameter("@VWOCtrServIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                tbServiceDescriptionNew.Text = "";
                tbServiceVendorNew.Text = "";
                tbSROAServiceCostNew.Text = "";
                performPostUpdateSuccessfulActions("Service added", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Service not added. Error msg: " + ee.Message);
            }
        }
        protected void btnNewSROALaborOk_Click(Object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspSROALaborUpdate");
                cmd.Parameters.Add("@MechName", SqlDbType.NVarChar).Value = ddSROANewLaborMechName.SelectedItem.Text;
                cmd.Parameters.Add("@fkVWOL_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                decimal rate = Utils.ObjectToDecimal(tbSROALaborRateNew.Text.Trim().Replace("$", "").Replace(",", ""));
                cmd.Parameters.Add("@MechRate", SqlDbType.Money).Value = rate;
                double hours = Utils.ObjectToDouble(tbSROALaborHoursNew.Text.Trim());
                cmd.Parameters.Add("@MechHours", SqlDbType.Real).Value = hours;
                SqlParameter newid = new SqlParameter("@VWOLaborIDOut", SqlDbType.Int);
                newid.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newid);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                ddSROANewLaborMechName.SelectedIndex = -1;
                tbSROALaborRateNew.Text = "";
                tbSROALaborHoursNew.Text = "";

                performPostUpdateSuccessfulActions("Labor added", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
            } catch (Exception ee) {
                performPostUpdateFailedActions("Labor not added. Error msg: " + ee.Message);
            }
        }
        protected void lbSROANewService_OnClick(object sender, EventArgs args) {
            mpeSROANewService.Show();
        }
        protected void lbSROANewLabor_OnClick(object sender, EventArgs args) {
            tbSROALaborRateNew.Text = Utils.ObjectToDecimal(SROAVehicalMaintenance_DataSet().Tables["SROAMechanicInfo"].Rows[0]["MechRate"]).ToString("c");
            mpeSROANewLabor.Show();
        }
        protected void gvUpdateLabor_RowDeleting(Object sender, GridViewDeleteEventArgs e) {
            try {
                int VWOLaborID = Utils.ObjectToInt(e.Keys[0]);
                SqlCommand cmd = new SqlCommand("uspSROALaborDelete");
                cmd.Parameters.Add("@VWOLaborID", SqlDbType.Int).Value = VWOLaborID;
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                performPostUpdateSuccessfulActions("Labor deleted", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
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
                DropDownList ddlLaborMechanics = (e.Row.FindControl("ddSROAUpdateLaborMechName") as DropDownList);
                if (ddlLaborMechanics != null) {
                    ddlLaborMechanics.DataSource = SROAVehicalMaintenance_DataSet().Tables["SROAMechanicInfo"];
                    ddlLaborMechanics.DataBind();

                    //Select the Mechanic in DropDownList
                    string mechanic = (e.Row.FindControl("lbSROAUpdateLaborMechName") as Label).Text;
                    ddlLaborMechanics.Items.FindByText(mechanic).Selected = true;
                }
            }
        }
        protected void ddSROANewLaborMechName_OnSelectedIndexChanged(object sender, EventArgs args) {
            DataTable sourceTable = SROAVehicalMaintenance_DataSet().Tables["SROAMechanicInfo"];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "MechID=" + ddSROANewLaborMechName.SelectedValue;
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            tbSROALaborRateNew.Text = Utils.ObjectToDecimal(dr["MechRate"]).ToString("c");
            mpeSROANewLabor.Show();
        }
        protected void lblSROANewPart_OnClick(object sender, EventArgs args) {
            mpeSROANewPart.Show();
        }
        protected void btnNewSROAPartOk_Click(object sender, EventArgs args) {
            if (IsValid) {
                try {
                    string description = tbPartDescriptionNew.Text.Trim();
                    string number = tbPartNumberNew.Text.Trim();
                    decimal rate = Utils.ObjectToDecimal(tbSROAPartRateNew.Text.Trim().Replace("$", "").Replace(",", ""));
                    double quantity = Utils.ObjectToDouble(tbSROANewPartsPTQuantity.Text.Trim());
                    SqlCommand cmd = new SqlCommand("uspSROAPartsUpdate");
                    cmd.Parameters.Add("@fkVWOP_ID", SqlDbType.NVarChar).Value = VMOIDBeingEdited;
                    cmd.Parameters.Add("@ptDescription", SqlDbType.NVarChar).Value = description;
                    cmd.Parameters.Add("@ptNumber", SqlDbType.NVarChar).Value = number;
                    cmd.Parameters.Add("@ptRate", SqlDbType.Money).Value = rate;
                    cmd.Parameters.Add("@ptQuan", SqlDbType.Real).Value = quantity;
                    SqlParameter newid = new SqlParameter("@NewVWOPartID", SqlDbType.Int);
                    newid.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(newid);
                    Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                    tbPartDescriptionNew.Text = "";
                    tbPartNumberNew.Text = "";
                    tbSROAPartRateNew.Text = "";
                    tbSROANewPartsPTQuantity.Text = "";
                    performPostUpdateSuccessfulActions("Part added", "SROA_CACHE_KEY", "SROA_SurchargeRate_CACHE_KEY");
                } catch (Exception ee) {
                    performPostUpdateFailedActions("Part not added. Error msg: " + ee.Message);
                }
            } else {
                mpeSROANewPart.Show();
            }
        }
        protected void ddSROANewVehicleNumber_OnSelectedIndexChanged(object sender, EventArgs args) {
            DataTable vehicleTable = SROAVehicalMaintenance_DataSet().Tables["SROAVehicelList"];
            DataView vehicleView = new DataView(vehicleTable);
            vehicleView.RowFilter = "Number='" + ddSROANewVehicleNumber.SelectedValue + "'";
            DataTable vehicleViewFiltered = vehicleView.ToTable();
            DataRow drZVehicle = vehicleViewFiltered.Rows[0];

            DataTable deptTable = SROAVehicalMaintenance_DataSet().Tables["SROADepartment"];
            DataView deptView = new DataView(deptTable);
            deptView.RowFilter = "DepartmentID=" + drZVehicle["fkDeptID"];
            DataTable deptViewFiltered = deptView.ToTable();
            DataRow drZDept = deptViewFiltered.Rows[0];

            lbSROANewDepartmentId.Text = Utils.ObjectToString(drZDept["DepartmentID"]);
            lbSROANewDepartmentAdminCharges.Text = ((Utils.ObjectToDecimal(drZDept["AdministrationRate"]))).ToString("P");
            mpeSROAVehicleMaintenance.Show();
        }
        protected void lbSROAVehicleMaintenanceNew_OnClick(Object sender, EventArgs args) {
            SqlCommand cmd=new SqlCommand("uspSROAFindHighestWordOrderNumber");
            SqlParameter parm = new SqlParameter("@HighestWorkOrderIntergerComponent", SqlDbType.Int);
            parm.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parm);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
            tbNewWorkOrderNbr.Text = "SROA-" + (Utils.ObjectToInt(parm.Value) + 1);
            tbSROANewDataEntryBy.Text = HttpContext.Current.User.Identity.Name;
            tbSROANewDataEntryDate.Text = DateTime.Now.ToShortDateString();
            tbSROANewRequestedBy.Text = "SROA";
            ddSROANewVehicleNumber_OnSelectedIndexChanged(null, null);
        }
        protected void btnNewSROAVehicleMaintenanceOk_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspSROAVehicleMaintenanceUpdate");
                cmd.Parameters.Add("@VWOID_new", SqlDbType.NVarChar).Value = tbNewWorkOrderNbr.Text;
                cmd.Parameters.Add("@fkNumber", SqlDbType.NVarChar).Value = ddSROANewVehicleNumber.SelectedValue;
                cmd.Parameters.Add("@Estimate", SqlDbType.Bit).Value = ddlYesNoBlankEstimateNew.SelectedValue == "Yes" ? true : false;
                cmd.Parameters.Add("@RequestBy", SqlDbType.NVarChar).Value = tbSROANewRequestedBy.Text.Trim();
                cmd.Parameters.Add("@RequestNature", SqlDbType.NVarChar).Value = tbSROANewVehicleDescription.Text.Trim();
                DateTime? dateIn =
                    tbSROANewRequestDateIn.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbSROANewRequestDateIn.Text.Trim());
                cmd.Parameters.Add("@DateIn", SqlDbType.DateTime).Value = dateIn;
                DateTime? dateOut =
                    tbSROANewVehicleDateOut.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbSROANewVehicleDateOut.Text.Trim());
                cmd.Parameters.Add("@DateOut", SqlDbType.DateTime).Value = dateOut;
                DateTime? dataEntryDate =
                    tbSROANewDataEntryDate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbSROANewDataEntryDate.Text.Trim());
                cmd.Parameters.Add("@DataEntryDate", SqlDbType.DateTime).Value = dataEntryDate;

                cmd.Parameters.Add("@DataEntryBy", SqlDbType.NVarChar).Value = tbSROANewDataEntryBy.Text.Trim();
                cmd.Parameters.Add("@Odometer", SqlDbType.Real).Value = Utils.ObjectToDouble(tbSROANewOdometerReading.Text);
                cmd.Parameters.Add("@HourMeter", SqlDbType.Real).Value = tbSROANewHourReading.Text.Trim();
                cmd.Parameters.Add("@Proceedure1", SqlDbType.NVarChar).Value = tbSROANewProcedurePerformed.Text.Trim();
                cmd.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = tbSROANewComments.Text.Trim();
                cmd.Parameters.Add("@AdminRate", SqlDbType.Real).Value = Math.Round((Utils.ObjectToDouble(lbSROANewDepartmentAdminCharges.Text.Trim().Replace(",", "").Replace("%", "")) / 100), 4);
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SROAVehicleMainenanceConnectionString"].ConnectionString);
                performPostNewSuccessfulActions("Vehicle Maintenance added successfully", SROA_VEHICLE_MAINTENANCE_CACHE_KEY, SROA_SurchargeRate_CACHE_KEY, tbWorkOrder_Search, tbNewWorkOrderNbr.Text);

                mpeSROAVehicleMaintenance.Hide();
            } catch (Exception e) {
                performPostNewFailedActions("New Vehicle Maintenance not added. Msg: " + e.Message);
            }
        }
        protected void btnNewSSROAVehicleMaintenanceCancel_Click(object sender, EventArgs args) {
        }
        protected void Quantity_OnValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            try {
                int i = int.Parse(args.Value);
            } catch {
                args.IsValid = false;
            }
        }
        public static string MyMenuName = "SROA Vehicle";
        protected override string childMenuName {
            get { return MyMenuName; }
        }
    }
}