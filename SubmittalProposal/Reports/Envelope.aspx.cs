using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data;

namespace SubmittalProposal.Reports {
    public partial class Envelope : AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                if (Utils.isNothingNot(Request.QueryString["Database"]) && Request.QueryString["Database"] == "OwnerProperty") {
                    /*
                     * We came from the OwnerProperty database, so we can used its cached data to get the information that we want
                    */
                    if (Utils.isNothingNot(Utils.ObjectToString(Session["opSRPropIDBeingEdited"]))) {
                        DataTable sourceTable = SubmittalProposal.OwnerProperty.OPDataSet().Tables[0];
                        DataView view = new DataView(sourceTable);
                        view.RowFilter = " SRPropID = '" + Utils.ObjectToString(Utils.ObjectToString(Session["opSRPropIDBeingEdited"])) + "'";
                        Session["tblFiltered"] = view.ToTable();
                        lblPrintEnvelopeFor.Text= Utils.ObjectToString(((DataTable)Session["tblFiltered"]).Rows[0]["PrimaryOwner"]);
                    }
                }
            }
        }
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString; } 
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new OwnerProperty.Envelope();
        }
        protected override System.Collections.Hashtable getReportParams() {
            System.Collections.Hashtable ht = new System.Collections.Hashtable();
            DataTable tblFiltered = (DataTable)Session["tblFiltered"];
            ht["Name"] = Utils.ObjectToString(tblFiltered.Rows[0]["PrimaryOwner"]);
            if (rbListTypeOfAddress.SelectedValue == "sunriver") {
                ht["Address1"] = Utils.ObjectToString(tblFiltered.Rows[0]["DC_Address"]);
                ht["Address2"] = "";
                ht["City"] = "Sunriver";
                ht["State"] = "OR";
                ht["Zip"] = "97707";
            } else {
                ht["Address1"] = Utils.ObjectToString(tblFiltered.Rows[0]["Addr1"]);
                ht["Address2"] = Utils.ObjectToString(tblFiltered.Rows[0]["Addr2"]);
                ht["City"] = Utils.ObjectToString(tblFiltered.Rows[0]["City"]);
                ht["State"] = Utils.ObjectToString(tblFiltered.Rows[0]["Region"]);
                ht["Zip"] = Utils.ObjectToString(tblFiltered.Rows[0]["PostalCode"]);
            }
            return ht;
        }
    }
}