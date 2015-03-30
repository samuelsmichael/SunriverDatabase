using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using System.Configuration;

namespace SubmittalProposal {
    public partial class ComplianceReview : AbstractDatabase {
        public static DataSet CRDataSet() {
            DataSet ds = null;
            MemoryCache cache=MemoryCache.Default;
            string key = "CRDS";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspComplianceReviewTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["crReviewID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["crLTID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        protected override Label getUpdateResultsLabel() {
            return lblComplianceReviewUpdateResults;
        }
        protected void btnComplianceReviewUpdate_Click(object sender, EventArgs e) {
            
        }        
        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
                ddlLane.DataBind();
                ddlNewComplianceReviewLane.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
                ddlNewComplianceReviewLane.DataBind();
            }
        }
        private int getInspectionNumber(GridViewRow row) {
            return  Convert.ToInt32(row.Cells[9].Text);
        }
        private string getLotLane(DataRow dr) {
            return "" + dr["crLOT"] + " \\ " + dr["crLANE"];
        }
        private DateTime? getReviewDate(DataRow dr) {
            return (DateTime?)dr["crDate"];
        }
        private DateTime? getClosingDate(DataRow dr) {
            return Utils.ObjectToDateTimeNullable( dr["crCloseDate"]);
        }
        private string getComments(DataRow dr) {
            return Utils.ObjectToString(dr["crComments"]);
        }
        private string getDesignRule(DataRow dr) {
            return  Utils.ObjectToString(dr["crRule"]);
        }
        private string getRequiredAction(DataRow dr) {
            return  Utils.ObjectToString(dr["crCorrection"]);
        }
        private string getFollowUp(DataRow dr) {
            return  Utils.ObjectToString(dr["crFollowUp"]);
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            int inspectionNbr = getInspectionNumber(row);
            DataRow dr = getGridViewDataTable().Rows.Find(inspectionNbr);
            DateTime? reviewDate = getReviewDate(dr);
            DateTime? closeDate = getClosingDate(dr);
            tbCloseDate.Text=closeDate.HasValue?closeDate.Value.ToString("MM/dd/yyyy"):"";
            tbReviewDate.Text=reviewDate.HasValue?reviewDate.Value.ToString("MM/dd/yyyy"):"";
            tbCommentsForm.Text = getComments(dr);
            tbDesignRule.Text = getDesignRule(dr);
            tbRequiredAction.Text = getRequiredAction(dr);
            tbFollowUp.Text = getFollowUp(dr);

            
            DataView    dvComplianceLetters = CRDataSet().Tables[1].AsDataView();
            Session["currentfkcrReviewID"] = getInspectionNumber(row);
            dvComplianceLetters.RowFilter = "fkcrReviewID=" + Session["currentfkcrReviewID"];
            DataTable dtComplianceLetters = dvComplianceLetters.ToTable();
            fvComplianceLetter.DataSource = dtComplianceLetters;
            fvComplianceLetter.DataBind();
            Repeater1.DataSource = dtComplianceLetters;
            Repeater1.DataBind();

            return "Inspection Nbr: " + inspectionNbr + "    Lot\\Lane: " + getLotLane(dr) + "    Date: " + (reviewDate.HasValue?reviewDate.Value.ToString("MM/dd/yyyy"):"");
        }
        
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " crLot = '" + tbLot.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " crLane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbComments.Text)) {
                sb.Append(prepend + "Comments: " + tbComments.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbComments.Text, "crComments"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbRule.Text)) {
                sb.Append(prepend + "Rule: " + tbRule.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbRule.Text, "crRule"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbReviewId.Text)) {
                sb.Append(prepend + "Review Id: " + tbReviewId.Text);
                prepend = "  ";
                sbFilter.Append(and + " crReviewId = " + tbReviewId.Text);
                and = " and ";
            }
            searchCriteria=sb.ToString();
            filterString=sbFilter.ToString();
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override System.Data.DataSet buildDataSet() {
            return CRDataSet();
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return CRDataSet().Tables[0];
        }
        protected void fvComplianceLetter_OnModeChanging(object sender, EventArgs e) {
        }
        protected void fvComplianceLetter_OnDataBound(object sender, EventArgs e) {
            if (fvComplianceLetter.Row != null) {
                FormView fv = (FormView)sender;
                Label control = (Label)fv.FindControl("lblcrLTID");
                DropDownList ddlCRFromSignature = (DropDownList)fv.FindControl("ddlCRFromSignature");
                DropDownList ddlCRFromTitle = (DropDownList)fv.FindControl("ddlCRFromTitle");
                if (control != null) {
                    DataRow dr = CRDataSet().Tables[1].Rows.Find(control.Text);
                    string signer = Common.Utils.ObjectToString(dr["crLTSigner"]);
                    string signerTitle = Common.Utils.ObjectToString(dr["crLTSignerTitle"]);
                    if (Utils.isNothingNot(signer)) {
                        ddlCRFromSignature.SelectedValue = signer;
                    } else {
                        ddlCRFromSignature.SelectedValue = String.Empty;
                    }
                    if (Utils.isNothingNot(signerTitle)) {
                        ddlCRFromTitle.SelectedValue = signerTitle;
                    } else {
                        ddlCRFromTitle.SelectedValue = String.Empty;
                    }
                }
            }
        }

        protected void fvComplianceLetter_PageIndexChanging(Object sender, FormViewPageEventArgs e) {
            fvComplianceLetter.PageIndex = e.NewPageIndex;
            DataView dvComplianceLetters = CRDataSet().Tables[1].AsDataView();
            dvComplianceLetters.RowFilter = "fkcrReviewID=" + Session["currentfkcrReviewID"];
            DataTable dtComplianceLetters = dvComplianceLetters.ToTable();
            fvComplianceLetter.DataSource = dtComplianceLetters;
            fvComplianceLetter.DataBind();
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e) {
            RepeaterItem o=e.Item;
            if (o != null) {
                DropDownList ddlCRFromSignature = (DropDownList)o.FindControl("ddlCRFromSignature");
                DropDownList ddlCRFromTitle = (DropDownList)o.FindControl("ddlCRFromTitle");
                Label control = (Label)o.FindControl("lblcrLTID");
                if (control != null) {
                    DataRow dr = CRDataSet().Tables[1].Rows.Find(control.Text);
                    string signer = Common.Utils.ObjectToString(dr["crLTSigner"]);
                    string signerTitle = Common.Utils.ObjectToString(dr["crLTSignerTitle"]);
                    if (Utils.isNothingNot(signer)) {
                        ddlCRFromSignature.SelectedValue = signer;
                    } else {
                        ddlCRFromSignature.SelectedValue = String.Empty;
                    }
                    if (Utils.isNothingNot(signerTitle)) {
                        ddlCRFromTitle.SelectedValue = signerTitle;
                    } else {
                        ddlCRFromTitle.SelectedValue = String.Empty;
                    }
                }
            }
        }

        protected void btnNewComplianceReviewOk_Click(object sender, EventArgs e) {

        }
    }
}