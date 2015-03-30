using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Runtime.Caching;
using System.Data.SqlClient;

namespace SubmittalProposal {
    public partial class BPermit : AbstractDatabase {
        static DataTable dtBPayment = null;

        protected override Label getUpdateResultsLabel() {
            return lblBPermitUpdateResults;
        }
        protected void btnBPermitUpdate_Click(object sender, EventArgs e) {
           
        }

        public static DataSet BPermitDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "BPermitDS";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspBPermitTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                ds.Tables[0].TableName = "BPData";
                ds.Tables[1].TableName = "BPPayment";
                dtBPayment = ds.Tables[1];
                ds.Tables[2].TableName = "BPReviews";
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        decimal feeTotal = 0;
        int monthsTotal = 0;
        public int getBPMonthsTotal() {
            return monthsTotal;
        }
        public string getBPFeeTotal() {
            return feeTotal.ToString("c");
        }
        private void bind_gvReviews(int bPermitId) {
            DataTable sourceTableReviews = BPermitDataSet().Tables["BPReviews"];
            DataView viewReviews = new DataView(sourceTableReviews);
            viewReviews.RowFilter = "fkBPermitID_PR=" + bPermitId;
            DataTable tblFilteredReviews = viewReviews.ToTable();
            gvReviews.DataSource = tblFilteredReviews;
            gvReviews.DataBind();

        }
        private void bind_gvPayments(int bPermitId) {
            DataTable sourceTablePayments = BPermitDataSet().Tables["BPPayment"];
            DataView viewPayments = new DataView(sourceTablePayments);
            viewPayments.RowFilter = "BPermitID =" + bPermitId;
            DataTable tblFilteredPayments = viewPayments.ToTable();

            feeTotal = 0;
            monthsTotal = 0;
            foreach (DataRow dr1 in tblFilteredPayments.Rows) {
                try {
                    feeTotal += Utils.ObjectToDecimal0IfNull(dr1["BPFee$"]);
                } catch { };
                try {
                    monthsTotal += Utils.ObjectToInt(dr1["BPMonths"]);
                } catch { }
            }

            gvPayments.DataSource = tblFilteredPayments;
            gvPayments.DataBind();
        }
        private int BPermitIDBeingEdited {
            get {
                object obj = ViewState["BPermitIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                ViewState["BPermitIDBeingEdited"] = value;
            }
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;
            BPermitIDBeingEdited = getBPermitId(row);
            bind_gvPayments(BPermitIDBeingEdited);


            DataTable sourceTable = getGridViewDataTable();
            
            DataView view = new DataView(sourceTable);
            view.RowFilter = "BPermitId=" + getBPermitId(row);
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];

            tbDelay.Text = Utils.ObjectToString(dr["BPDelay"]);
            DateTime? issueDate = Utils.ObjectToDateTimeNullable(dr["BPIssueDate"]);
            tbIssued.Text = issueDate.HasValue ? issueDate.Value.ToString("MM/dd/yyyy") : "";
            Object expires=dr["BPExpires"];
            if (expires is DBNull) {
                lblExpired.Text = "";
            } else {
                lblExpired.Text = Utils.ObjectToDateTime(expires).ToString("MM/dd/yyyy");
            }
            lblExpired.BackColor = System.Drawing.Color.FromName("White");
            lblExpired.ForeColor = System.Drawing.Color.FromName("Black");
            try {
                if (Convert.ToDateTime(lblExpired.Text) < DateTime.Today) {
                    lblExpired.BackColor = System.Drawing.Color.FromName("Red");
                    lblExpired.ForeColor = System.Drawing.Color.FromName("White");
                }
            } catch { }
            DateTime? closed = Utils.ObjectToDateTimeNullable(dr["BPClosed"]);
            tbClosed.Text = closed.HasValue?closed.Value.ToString("MM/dd/yyyy"):"";
            if (Utils.ObjectToBool(dr["BPermitReqd"])) {
                rbListPermitRequired.SelectedValue = "Yes";
            } else {
                rbListPermitRequired.SelectedValue = "No";
            }
            tbApplicantName2.Text = Utils.ObjectToString(dr["Applicant"]);
            tbOwnersName.Text=Utils.ObjectToString(dr["OwnersName"]);
            tbContractorBB.Text = Utils.ObjectToString(dr["Contractor"]);
            ddlProjectType.SelectedValue = Utils.ObjectToString(dr["ProjectType"]);
            tbProject.Text = Utils.ObjectToString(dr["Project"]);
            tbLotName2.Text = Utils.ObjectToString(dr["Lot"]);
            if (ddlLane2.Items.FindByText(Utils.ObjectToString(dr["Lane"])) == null) {
                ddlLane2.Items.Add(new ListItem(Utils.ObjectToString(dr["Lane"]), Utils.ObjectToString(dr["Lane"])));
            } 
            ddlLane2.SelectedValue = Utils.ObjectToString(dr["Lane"]);

            bind_gvReviews(getBPermitId(row));
            int? submittalId = getSubmittalId(dr);
            return "Lot\\Lane: " + getLotLane(dr) + "  Submittal Id: " + (submittalId.HasValue?Convert.ToString(submittalId.Value):"") + "  BPermitId :" + getBPermitId(dr) + " Owner: " + getOwner(dr);

        }
        public System.Drawing.Color getForeColorForExpireDate(Object BPExpiresObject) {
            string color="Black";
            try {
                if (DateTime.Today > Convert.ToDateTime(BPExpiresObject)) {
                    color = "Red";
                }
            } catch {}
            return System.Drawing.Color.FromName(color);
        }

        private int? getSubmittalId(DataRow dr) {
            return Utils.ObjectToIntNullable(dr["fkSubmittalID_PD"]);
        }
        private int getBPermitId(DataRow dr) {
            return (int)dr["fkBPermitID_PR"];
        }
        private string getLotLane(DataRow dr) {
            return Utils.ObjectToString(dr["Lot"]) + "\\" + Utils.ObjectToString(dr["Lane"]);
        }
        private string getOwner(DataRow dr) {
            return Utils.ObjectToString(dr["OwnersName"]);
        }
        private int getBPermitId(GridViewRow dr) {
            return Convert.ToInt32(dr.Cells[4].Text);
        }
        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbOwner.Text)) {
                sb.Append(prepend + "Owner: " + tbOwner.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbOwner.Text,"OwnersName"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbApplicant.Text)) {
                sb.Append(prepend + "Applicant: " + tbApplicant.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbApplicant.Text,"Applicant"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " Lot = '" + tbLot.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " Lane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbSubmittalId.Text)) {
                sb.Append(prepend + "Submittal Id: " + tbSubmittalId.Text);
                prepend = "  ";
                sbFilter.Append(and + " fkSubmittalID_PD = " + tbSubmittalId.Text);
                and = " and ";
            }

            if (Utils.isNothingNot(tbBPermitId.Text)) {
                sb.Append(prepend + "BPermit Id: " + tbBPermitId.Text);
                prepend = "  ";
                sbFilter.Append(and + " BPermitId =" + tbBPermitId.Text);
                and = " and ";
            }
            if (Utils.isNothingNot(tbDelaySearch.Text)) {
                sb.Append(prepend + "Delay: " + tbDelaySearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbDelaySearch.Text,"BPDelay"));
                and = " and ";
            }

            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();

        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override System.Data.DataSet buildDataSet() {
            return BPermitDataSet();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            string gotoBPermitId=null;
            if (!IsPostBack) {
                gotoBPermitId = Request.QueryString["BPermitId"];
                ddlLane.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
                ddlLane.DataBind();
                ddlLane2.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
                ddlLane2.DataBind();
                ddlNewBPermitLane.DataSource = ((MainMasterPage)Master.Master).dsLotLane;
                ddlNewBPermitLane.DataBind();

            }
            if (Common.Utils.isNothingNot(gotoBPermitId)) {
                tbBPermitId.Text = Request.QueryString["BPermitId"];
                ((Database)Master).doGo();
                gvResults.SelectRow(0);
            }
        }
        protected override DataTable getGridViewDataTable() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "BPermitDSGridView";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspBPermitDataGridViewDataGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds.Tables[0];
        }
        protected void btnNewBPermitOk_Click(object sender, EventArgs e) {
            int bkher = 3;
        }
        protected void btnNewBPermitPaymentOk_Click(object sender, EventArgs e) {
            int bkher = 3;
        }
        protected void btnNewBPermitReviewOk_Click(object sender, EventArgs args) {
        }

        protected void gvPayments_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvPayments.EditIndex= e.NewEditIndex;
            //Bind data to the GridView control.
            bind_gvPayments(BPermitIDBeingEdited);
        }

        protected void gvPayments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvPayments.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvPayments(BPermitIDBeingEdited);
        }

        protected void gvPayments_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            //Retrieve the table from the session object.
//            DataTable dt = (DataTable)Session["TaskTable"];

            //Update the values.
/*
            GridViewRow row = gvPayments.Rows[e.RowIndex];
            dt.Rows[row.DataItemIndex]["Id"] = ((TextBox)(row.Cells[1].Controls[0])).Text;
            dt.Rows[row.DataItemIndex]["Description"] = ((TextBox)(row.Cells[2].Controls[0])).Text;
            dt.Rows[row.DataItemIndex]["IsComplete"] = ((CheckBox)(row.Cells[3].Controls[0])).Checked;
*/
            //Reset the edit index.
            gvPayments.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvPayments(BPermitIDBeingEdited);
        }

        protected void gvReviews_RowEditing(object sender, GridViewEditEventArgs e) {
            gvReviews.EditIndex = e.NewEditIndex;
            bind_gvReviews(BPermitIDBeingEdited);

        }

        protected void gvReviews_RowUpdating(object sender, GridViewUpdateEventArgs e) {
/*            //Retrieve the table from the session object.
            //            DataTable dt = (DataTable)Session["TaskTable"];

            //Update the values.
                        GridViewRow row = gvPayments.Rows[e.RowIndex];
                        dt.Rows[row.DataItemIndex]["Id"] = ((TextBox)(row.Cells[1].Controls[0])).Text;
                        dt.Rows[row.DataItemIndex]["Description"] = ((TextBox)(row.Cells[2].Controls[0])).Text;
                        dt.Rows[row.DataItemIndex]["IsComplete"] = ((CheckBox)(row.Cells[3].Controls[0])).Checked;
            */
            gvReviews.EditIndex = -1;
            bind_gvReviews(BPermitIDBeingEdited);
        }

        protected void gvReviews_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvReviews.EditIndex = -1;
            bind_gvReviews(BPermitIDBeingEdited);
        }
    }
    public static class CustomLINQtoDataSetMethods {
        public static DataTable CopyToDataTable<T>(this IEnumerable<T> source) {
            return new ObjectShredder<T>().Shred(source, null, null);
        }

        public static DataTable CopyToDataTable<T>(this IEnumerable<T> source,
                                                    DataTable table, LoadOption? options) {
            return new ObjectShredder<T>().Shred(source, table, options);
        }

    }
}