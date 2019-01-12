using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using System.Data;
using Common;

namespace SubmittalProposal.Reports {
    public partial class OwnerPropertyReport_Envelope : AbstractReport {
        protected override string ConnectionString {
            get {
                // Any connection string will do here, as all fields in the Envelope report are parameter driver.  The framework, however, requires a valid connection string.
                return System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString;
            }
        }
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                if (!IsPostBack) {
                    ddlLane.DataSource = ((SiteMaster)Master.Master).dsLotLane;
                    ddlLane.DataBind();
                }
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new OwnerProperty.Envelope();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        protected override void AbstractReport_Click(object sender, EventArgs e) {

            DataTable tblFiltered = null;
            string searchCriteria;
            string filterString;
            ((Reports)Master).getCrystalReportView().Visible = false;


            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbNameSearch.Text)) {
                sb.Append(prepend + "Name: " + tbNameSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbNameSearch.Text, "PrimaryOwner"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " SRLot = '" + tbLot.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbPropertyID.Text)) {
                sb.Append(prepend + "Property ID: " + tbPropertyID.Text);
                prepend = "  ";
                sbFilter.Append(and + " SRPropID = '" + tbPropertyID.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " SRLane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbDCAddress.Text)) {
                sb.Append(prepend + "DC Address: " + tbDCAddress.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbDCAddress.Text, "DC_Address"));
                and = " and ";
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();

            
            
            if (Utils.isNothingNot(filterString)) {
                DataTable sourceTable = SubmittalProposal.OwnerProperty.OPDataSet().Tables[0];
                DataView view = new DataView(sourceTable);
                view.RowFilter = filterString;
                tblFiltered = view.ToTable();
                gvResults.DataSource = tblFiltered;
                gvResults.DataBind();
            } else {
                tblFiltered = SubmittalProposal.OwnerProperty.OPDataSet().Tables[0];
                gvResults.DataSource = tblFiltered;
                gvResults.DataBind();
            }
            pnlResults.Visible = false;
            if (tblFiltered.Rows.Count == 0) {
                pnlResultsHeading.InnerText = "Your search resulted in no items. Please do another search.";
                pnlResults.Visible = true;
            } else {
                if (tblFiltered.Rows.Count > 1) {
                    pnlResults.Visible = true;
                    pnlResultsHeading.InnerText = "Your search resulted in more than 1 item. Please select from the list below.";
                } else {
                }
            }
            Session["OwnerPropertyReport_Envelope_FilteredData"] = tblFiltered;
            if (tblFiltered.Rows.Count == 1) {
                buildReport(getReportParams());
            }

        }
        protected void gvResults_SelectedIndexChanged(object sender, EventArgs e) {
            DataSet ds = null;
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;

            DataTable sourceTable = SubmittalProposal.OwnerProperty.OPDataSet().Tables[0];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "SRPropID='" + Utils.ObjectToString(row.Cells[5].Text.Trim()) +"'";
            DataTable tblFiltered = view.ToTable();
            Session["OwnerPropertyReport_Envelope_FilteredData"] = tblFiltered;
            buildReport(getReportParams());
        }

        protected void gvResults_Sorting(object sender, GridViewSortEventArgs e) {
            AbstractReport_Click(sender,null);
            DataView view = new DataView((DataTable)Session["OwnerPropertyReport_Envelope_FilteredData"]);
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
        }

        protected override Hashtable getReportParams() {
            Hashtable ht = new Hashtable();
            DataTable tblFiltered = (DataTable)Session["OwnerPropertyReport_Envelope_FilteredData"];
            ht["@Name"] = Utils.ObjectToString(tblFiltered.Rows[0]["PrimaryOwner"]);
            ht["@Address1"] = Utils.ObjectToString(tblFiltered.Rows[0]["DC_Address"]);
            ht["@Address2"] = "";
            ht["@City"] = "Sunriver";
            ht["@State"] = "OR";
            ht["@Zip"] = "97707";
            ht["@ReturnAddressName"] = tbReturnAddressName.Text;
            ht["@ReturnAddressAddress"] = tbReturnAddressAddress.Text;
            ht["@ReturnAddressCity"] = tbReturnAddressCity.Text;
            ht["@ReturnAddressState"] = tbReturnAddressState.Text;
            ht["@ReturnAddressZip"] = tbReturnAddressZip.Text;
            ((Reports)Master).getCrystalReportView().Visible = true;
            return ht;
        }

    }
}