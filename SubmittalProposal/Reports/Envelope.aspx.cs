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
                    DataTable tblFiltered = (DataTable)Session["OwnerPropertyTblFiltered"];
                    lblPrintEnvelopeFor.Text = Utils.ObjectToString(tblFiltered.Rows[0]["PrimaryOwner"]);
                    if (Utils.isNothingNot(Utils.ObjectToString(Session["opSRPropIDBeingEdited"]))) {
                        rbListTypeOfAddress.Visible=true;
                    }
                } else {
                    if (Utils.isNothingNot(Request.QueryString["Database"]) && Request.QueryString["Database"] == "Citations") {
                        DataTable tblFiltered = (DataTable)Session["CitationsTblFiltered"];
                        string vFirstName = Utils.ObjectToString(tblFiltered.Rows[0]["VFirstName"]);
                        string vLastName = Utils.ObjectToString(tblFiltered.Rows[0]["VLastName"]);
                        lblPrintEnvelopeFor.Text =
                            vFirstName +
                            (Utils.isNothingNot(vFirstName) ? " " : "") +
                            vLastName
                            ;

                        rbListTypeOfAddress.Visible = false;
                    }
                }
            }
        }
        protected override string ConnectionString {
            get {
                // Any connection string will do here, as all fields are parameter driver.  The framework, however, requires a valid connection string.
                return System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString;
            } 
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new OwnerProperty.Envelope();
        }
        protected override System.Collections.Hashtable getReportParams() {
            System.Collections.Hashtable ht = new System.Collections.Hashtable();
            if (Utils.isNothingNot(Request.QueryString["Database"]) && Request.QueryString["Database"] == "OwnerProperty") {
                DataTable tblFiltered = (DataTable)Session["OwnerPropertyTblFiltered"];
                ht["@Name"] = Utils.ObjectToString(tblFiltered.Rows[0]["PrimaryOwner"]);
                if (rbListTypeOfAddress.SelectedValue == "sunriver") {
                    ht["@Address1"] = Utils.ObjectToString(tblFiltered.Rows[0]["DC_Address"]);
                    ht["@Address2"] = "";
                    ht["@City"] = "Sunriver";
                    ht["@State"] = "OR";
                    ht["@Zip"] = "97707";
                } else {
                    ht["@Address1"] = Utils.ObjectToString(tblFiltered.Rows[0]["Addr1"]);
                    ht["@Address2"] = Utils.ObjectToString(tblFiltered.Rows[0]["Addr2"]);
                    ht["@City"] = Utils.ObjectToString(tblFiltered.Rows[0]["City"]);
                    ht["@State"] = Utils.ObjectToString(tblFiltered.Rows[0]["Region"]);
                    ht["@Zip"] = Utils.ObjectToString(tblFiltered.Rows[0]["PostalCode"]);
                }
            } else {
                if (Utils.isNothingNot(Request.QueryString["Database"]) && Request.QueryString["Database"] == "Citations") {
                    DataTable tblFiltered = (DataTable)Session["CitationsTblFiltered"];
                    string vFirstName=Utils.ObjectToString(tblFiltered.Rows[0]["VFirstName"]);
                    string vLastName=Utils.ObjectToString(tblFiltered.Rows[0]["VLastName"]);
                    ht["@Name"] = 
                        vFirstName+
                        (Utils.isNothingNot(vFirstName)?" ":"")+
                        vLastName
                        ;
                    ht["@Address1"] = Utils.ObjectToString(tblFiltered.Rows[0]["VMailAddr1"]);
                    ht["@Address2"] = Utils.ObjectToString(tblFiltered.Rows[0]["VMailAddr2"]);
                    ht["@City"] = Utils.ObjectToString(tblFiltered.Rows[0]["VCity"]);
                    ht["@State"] = Utils.ObjectToString(tblFiltered.Rows[0]["VState"]);
                    ht["@Zip"] = Utils.ObjectToString(tblFiltered.Rows[0]["VZip"]);
                } else {
                    throw new Exception("Incorrect database");
                }
            }
            ht["@ReturnAddressName"] = tbReturnAddressName.Text;
            ht["@ReturnAddressAddress"] = tbReturnAddressAddress.Text;
            ht["@ReturnAddressCity"] = tbReturnAddressCity.Text;
            ht["@ReturnAddressState"] = tbReturnAddressState.Text;
            ht["@ReturnAddressZip"] = tbReturnAddressZip.Text;
            return ht;
        }
    }
}