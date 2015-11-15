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
                    dr["VechicleNameForDDLs"] = "" + dr["Number"] + "-" + Utils.ObjectToString(dr["Description"]);
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
            throw new NotImplementedException();
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
            throw new NotImplementedException();
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            throw new NotImplementedException();
        }

        protected override void lockYourUpdateFields() {
            throw new NotImplementedException();
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
            }
        }
    }
}