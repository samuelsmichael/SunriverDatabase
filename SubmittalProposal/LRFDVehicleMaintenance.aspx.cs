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
                ds.Tables[4].PrimaryKey = new DataColumn[1] {ds.Tables[4].Columns["DepartmentID"] };
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
            VMOIDBeingEdited=row.Cells[1].Text;
            DataTable sourceTable = getGridViewDataTable();
            DataView view = new DataView(sourceTable);
            view.RowFilter = "VWOID='" + VMOIDBeingEdited + "'";
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];
            lblRFDUpdateWOI.Text = VMOIDBeingEdited;
            ddlRFDUpdateVehicleNumber.SelectedValue = Utils.ObjectToString(dr["fkNumber"]);
            tbRFDUpdateVehicleDescription.Text = Utils.ObjectToString(dr["Request Nature"]);
            string estimate = Utils.ObjectToString(dr["Estimate"]);
            ddlYesNoBlankEstimateUpdate.SelectedValue = (estimate==""?"":estimate=="True"?"Yes":"No");
            tbRFDUpdateDataEntryBy.Text = Utils.ObjectToString(dr["Data Entry By"]);
            DateTime? entryDate=Utils.ObjectToDateTimeNullable(dr["Data Entry Date"]);
            tbLRFDUpdateDataEntryDate.Text = entryDate.HasValue ? entryDate.Value.ToString("d") : "";
            DateTime? requestDateIn = Utils.ObjectToDateTimeNullable(dr["Date In"]);
            tbLRFDUpdateRequestDateIn.Text = requestDateIn.HasValue ? requestDateIn.Value.ToString("d") : "";
            tbRFDUpdateRequestedBy.Text = Utils.ObjectToString(dr["Request By"]);
            tbLRFDUpdateOdometerReading.Text = Utils.ObjectToString(dr["Odometer"]);
            tbLRFDUpdateHourReading.Text = Utils.ObjectToString(dr["hour Meter"]);
            DataTable vehicleTable=LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
            DataView vehicleView  = new DataView(vehicleTable);
            vehicleView.RowFilter="Number='"+ dr["fkNumber"] +"'";
            DataTable vehicleViewFiltered=vehicleView.ToTable();
            DataRow drZVehicle=vehicleViewFiltered.Rows[0];

            DataTable deptTable= LRFDVehicalMaintenance_DataSet().Tables["LRFDDepartment"];
            DataView deptView=new DataView(deptTable);
            deptView.RowFilter="DepartmentID="+drZVehicle["fkDeptID"];
            DataTable deptViewFiltered=deptView.ToTable();
            DataRow drZDept=deptViewFiltered.Rows[0];

            DataTable partsTable = LRFDVehicalMaintenance_DataSet().Tables["VWOParts"];
            DataView partsView = new DataView(partsTable);
            partsView.RowFilter = "fkVWOP_ID='" + VMOIDBeingEdited + "'";
            DataTable partsViewFiltered = partsView.ToTable();
            gvRFDUpdateParts.DataSource = partsViewFiltered;
            gvRFDUpdateParts.DataBind();


            lblRFDUpdateDepartmentId.Text = ""+drZDept["DepartmentID"]+" - "+ drZDept["Department"];
            lblRFDUpdateDepartmentAdminCharges.Text = "" + (Convert.ToDouble(drZDept["AdministrationRate"]) * 100).ToString("#0.##") + "%";
            DateTime? dateOut = Utils.ObjectToDateTimeNullable(dr["Date Out"]);
            tbRFDUpdateVehicleDateOut.Text = dateOut.HasValue ? dateOut.Value.ToString("d") : "";
            tbRFDUpdateProcedurePerformed.Text = Utils.ObjectToString(dr["Proceedure 1"]);
            tbRFDUpdateComments.Text = Utils.ObjectToString(dr["Comments"]);

            return "Work Order #: " + VMOIDBeingEdited + " Vehicle ID: " + Utils.ObjectToString(dr["fkNumber"]) + " Vehicle description: " + Utils.ObjectToString(dr["VehicleName"]);
        }
        private string VMOIDBeingEdited {
            get {
                return Utils.ObjectToString(Session["VMOIDBeingEdited"]);
            }
            set {
                Session["VMOIDBeingEdited"]=value;
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

            if (Utils.isNothingNot(tbWorkOrder_Search.Text) && tbWorkOrder_Search.Text.ToLower()!="lrfd-") {
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
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            ddlRFDUpdateVehicleNumber.Enabled = true;
            btnRFDUpdate.Visible = true;
            tbLRFDUpdateDataEntryDate.Enabled = true;
            tbRFDUpdateDataEntryBy.Enabled = true;
            tbRFDUpdateVehicleDescription.Enabled = true;
            ddlYesNoBlankEstimateUpdate.Enabled = true;
            ibtbLRFDUpdateDataEntryDate.Enabled = true;
            tbLRFDUpdateRequestDateIn.Enabled = true;
            ibtbLRFDUpdateRequestDateIn.Enabled = true;
            tbRFDUpdateRequestedBy.Enabled = true;
            tbLRFDUpdateOdometerReading.Enabled=true;
            tbLRFDUpdateHourReading.Enabled = true;
            tbRFDUpdateVehicleDateOut.Enabled = true;
            tbRFDUpdateProcedurePerformed.Enabled = true;
            tbRFDUpdateComments.Enabled = true;
        }


        protected void gvUpdateParts_RowEditing(object sender, GridViewEditEventArgs e) {
        }

        protected void gvUpdateParts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
        }

        protected void gvUpdateParts_RowUpdating(object sender, GridViewUpdateEventArgs e) {

        }


        protected override void lockYourUpdateFields() {
            tbRFDUpdateComments.Enabled = false;
            tbRFDUpdateVehicleDateOut.Enabled = false;
            tbRFDUpdateProcedurePerformed.Enabled = false;
            tbLRFDUpdateOdometerReading.Enabled = false;
            tbLRFDUpdateHourReading.Enabled = false;
            tbLRFDUpdateRequestDateIn.Enabled = false;
            ibtbLRFDUpdateRequestDateIn.Enabled = false;
            tbRFDUpdateRequestedBy.Enabled = false;
            ibtbLRFDUpdateDataEntryDate.Enabled = false;
            tbLRFDUpdateDataEntryDate.Enabled = false;
            ddlRFDUpdateVehicleNumber.Enabled = false;
            btnRFDUpdate.Visible = false;
            tbRFDUpdateVehicleDescription.Enabled = false;
            tbRFDUpdateDataEntryBy.Enabled = false;
            ddlYesNoBlankEstimateUpdate.Enabled = false;
        }

        protected override void clearAllSelectionInputFields() {
            throw new NotImplementedException();
        }

        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }

        protected override string UpdateRoleName {
            get { return "canupdatelrfdvehiclemaintenance"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                DataTable dt = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"].Copy();
                DataRow newRow = dt.NewRow();
                newRow["Number"] = -1;
                newRow["VechicleNameForDDLs"] = "";
                dt.Rows.InsertAt(newRow, 0);
                ddlVehicle_Search.DataSource = dt;
                ddlVehicle_Search.DataBind();
                ddlRFDUpdateVehicleNumber.DataSource = LRFDVehicalMaintenance_DataSet().Tables["LRFDVehicelList"];
                ddlRFDUpdateVehicleNumber.DataBind();
            }
        }
    }
}