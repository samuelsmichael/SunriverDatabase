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

namespace SubmittalProposal {
    public partial class BPermit : AbstractDatabase {

        public static DataSet BPermitDataSet() {
            DataSet ds=null;
            MemoryCache cache=MemoryCache.Default;
            string key = "BPDS";
            ds = (DataSet)cache[key];
            if (ds == null) {
                ds = new DataSet();
                #region BPData
                DataTable dtBPData = new DataTable("BPData");
                dtBPData.Columns.Add(new DataColumn("BPermitId"));
                dtBPData.Columns.Add(new DataColumn("SubmittalId"));
                dtBPData.Columns.Add(new DataColumn("BPIssueDate"));
                dtBPData.Columns.Add(new DataColumn("BPClosed"));
                dtBPData.Columns.Add(new DataColumn("BPermitReqd"));
                dtBPData.Columns.Add(new DataColumn("BPDelay"));
                ds.Tables.Add(dtBPData);
                DataRow dr = dtBPData.NewRow();
                dr["BPermitId"] = "8956";
                dr["SubmittalId"] = "98956";
                dr["BPIssueDate"] = "12/14/2014";
                dr["BPClosed"] = "02/27/2015";
                dr["BPermitReqd"] = "false";
                dr["BPDelay"] = "w";

                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "9327";
                dr["SubmittalId"] = "99327";
                dr["BPIssueDate"] = "03/11/2014";
                dr["BPClosed"] = "02/27/2015";
                dr["BPermitReqd"] = "true";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3719";
                dr["SubmittalId"] = "93719";
                dr["BPIssueDate"] = "12/14/2014";
                dr["BPClosed"] = "02/27/2015";
                dr["BPermitReqd"] = "false";
                dr["BPDelay"] = "w";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3720";
                dr["SubmittalId"] = "93720";
                dr["BPIssueDate"] = "12/14/2014";
                dr["BPClosed"] = "02/27/2015";
                dr["BPermitReqd"] = "true";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3721";
                dr["SubmittalId"] = "93721";
                dr["BPIssueDate"] = "12/14/2014";
                dr["BPClosed"] = "02/27/2015";
                dr["BPermitReqd"] = "true";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3726";
                dr["SubmittalId"] = "93726";
                dr["BPIssueDate"] = "12/14/2014";
                dr["BPClosed"] = "";
                dr["BPermitReqd"] = "false";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3727";
                dr["SubmittalId"] = "93727";
                dr["BPIssueDate"] = "11/14/2014";
                dr["BPClosed"] = "";
                dr["BPermitReqd"] = "true";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3728";
                dr["SubmittalId"] = "93728";
                dr["BPIssueDate"] = "03/01/2014";
                dr["BPClosed"] = "09/03/2014";
                dr["BPermitReqd"] = "false";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3729";
                dr["SubmittalId"] = "93729";
                dr["BPIssueDate"] = "11/14/2014";
                dr["BPClosed"] = "";
                dr["BPermitReqd"] = "true";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3730";
                dr["SubmittalId"] = "93730";
                dr["BPIssueDate"] = "06/14/2014";
                dr["BPClosed"] = "";
                dr["BPermitReqd"] = "false";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "73";
                dr["SubmittalId"] = "973";
                dr["BPIssueDate"] = "08/14/2014";
                dr["BPClosed"] = "";
                dr["BPermitReqd"] = "false";
                dr["BPDelay"] = "w";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "3732";
                dr["SubmittalId"] = "93732";
                dr["BPIssueDate"] = "01/14/2014";
                dr["BPClosed"] = "";
                dr["BPermitReqd"] = "true";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                dr = dtBPData.NewRow();
                dr["BPermitId"] = "4013";
                dr["SubmittalId"] = "94013";
                dr["BPIssueDate"] = "11/14/2014";
                dr["BPClosed"] = "";
                dr["BPermitReqd"] = "true";
                dr["BPDelay"] = "";
                dtBPData.Rows.Add(dr);
                #endregion
                #region BPPayment
                DataTable dtBPayment = new DataTable("BPPayment");
                dtBPayment.Columns.Add(new DataColumn("BPPaymentId"));
                dtBPayment.Columns.Add(new DataColumn("BPermitId"));
                dtBPayment.Columns.Add(new DataColumn("BPMonths"));
                dtBPayment.Columns.Add(new DataColumn("BPFee$"));
                dtBPayment.Columns.Add(new DataColumn("BPPayType"));
                dtBPayment.Columns.Add(new DataColumn("BPPmt"));
                ds.Tables.Add(dtBPayment);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "1";
                dr["BPermitId"] = "8956";
                dr["BPMonths"] = "3";
                dr["BPFee$"] = "$5.00";
                dr["BPPayType"] = "9687";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "2";
                dr["BPermitId"] = "8956";
                dr["BPMonths"] = "2";
                dr["BPFee$"] = "$15.00";
                dr["BPPayType"] = "2849";
                dr["BPPmt"] = "2";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "3";
                dr["BPermitId"] = "9327";
                dr["BPMonths"] = "12";
                dr["BPFee$"] = "$4.00";
                dr["BPPayType"] = "2849";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "4";
                dr["BPermitId"] = "3720";
                dr["BPMonths"] = "2";
                dr["BPFee$"] = "$11.00";
                dr["BPPayType"] = "18521";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "5";
                dr["BPermitId"] = "3721";
                dr["BPMonths"] = "1";
                dr["BPFee$"] = "$111.00";
                dr["BPPayType"] = "800";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "6";
                dr["BPermitId"] = "3721";
                dr["BPMonths"] = "3";
                dr["BPFee$"] = "$5.00";
                dr["BPPayType"] = "1913";
                dr["BPPmt"] = "2";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "7";
                dr["BPermitId"] = "3726";
                dr["BPMonths"] = "3";
                dr["BPFee$"] = "$14.00";
                dr["BPPayType"] = "";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "8";
                dr["BPermitId"] = "3726";
                dr["BPMonths"] = "4";
                dr["BPFee$"] = "$19.00";
                dr["BPPayType"] = "331";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "9";
                dr["BPermitId"] = "3727";
                dr["BPMonths"] = "4";
                dr["BPFee$"] = "$15.00";
                dr["BPPayType"] = "331";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                dr = dtBPayment.NewRow();
                dr["BPPaymentId"] = "10";
                dr["BPermitId"] = "73";
                dr["BPMonths"] = "4";
                dr["BPFee$"] = "$18.00";
                dr["BPPayType"] = "2849";
                dr["BPPmt"] = "1";
                dtBPayment.Rows.Add(dr);
                #endregion
                #region BPReviews
                DataTable dtReviews = new DataTable("BPReviews");
                dtReviews.Columns.Add(new DataColumn("BPReviewId"));
                dtReviews.Columns.Add(new DataColumn("BPermitId"));
                dtReviews.Columns.Add(new DataColumn("BP1stInspect"));
                dtReviews.Columns.Add(new DataColumn("BPRActionDate"));
                dtReviews.Columns.Add(new DataColumn("BPRLetterDate"));
                dtReviews.Columns.Add(new DataColumn("BPRLetterRef"));
                dtReviews.Columns.Add(new DataColumn("BPRComments"));
                dtReviews.Columns.Add(new DataColumn("BPRevw"));
                ds.Tables.Add(dtReviews);
                dr = dtReviews.NewRow();
                dr["BPReviewId"] = "1";
                dr["BPermitId"] = "8956";
                dr["BP1stInspect"] = "04/19/2010";
                dr["BPRActionDate"] = "08/12/2010";
                dr["BPRComments"] = "Hot tub wall";
                dr["BPRLetterDate"] = "05/19/2010";
                dr["BPRLetterRef"] = "expnot";
                dr["BPRevw"] = "1";
                dtReviews.Rows.Add(dr);
                dr = dtReviews.NewRow();
                dr["BPReviewId"] = "2";
                dr["BPermitId"] = "8956";
                dr["BP1stInspect"] = "02/19/2011";
                dr["BPRActionDate"] = "03/12/2010";
                dr["BPRLetterDate"] = "06/11/2010";
                dr["BPRComments"] = "Screen wall incomplete";
                dr["BPRLetterRef"] = "expnot";
                dr["BPRevw"] = "2";
                dtReviews.Rows.Add(dr);
                dr = dtReviews.NewRow();
                dr["BPReviewId"] = "3";
                dr["BPermitId"] = "9327";
                dr["BP1stInspect"] = "12/19/2014";
                dr["BPRActionDate"] = "12/30/2014";
                dr["BPRComments"] = "Filter not approved";
                dr["BPRLetterRef"] = "expnot";
                dr["BPRLetterDate"] = "03/21/2011";
                dr["BPRevw"] = "1";
                dtReviews.Rows.Add(dr);
                #endregion
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.AbsoluteExpiration =
                    DateTimeOffset.Now.AddHours(1.0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }

        int getMonthsTotal(string bPermitId) {
            DataTable sourceTablePayments = BPermitDataSet().Tables["BPPayment"];
            DataView viewPayments = new DataView(sourceTablePayments);
            viewPayments.RowFilter = "BPermitId=" + bPermitId;
            DataTable tblFilteredPayments = viewPayments.ToTable();
            monthsTotal = 0;
            foreach (DataRow dr1 in tblFilteredPayments.Rows) {
                try {
                    monthsTotal += Convert.ToInt32(dr1["BPMonths"]);
                } catch { }
            }
            return monthsTotal;
        }

        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;


            DataTable sourceTablePayments = BPermitDataSet().Tables["BPPayment"];
            DataView viewPayments = new DataView(sourceTablePayments);
            viewPayments.RowFilter = "BPermitId=" + getBPermitId(row);
            DataTable tblFilteredPayments = viewPayments.ToTable();
            feeTotal = 0;
            monthsTotal = 0;
            foreach (DataRow dr1 in tblFilteredPayments.Rows) {
                try {
                    feeTotal += Convert.ToDecimal(((string)dr1["BPFee$"]).Replace("$", ""));
                } catch { };
                try {
                    monthsTotal += Convert.ToInt32(dr1["BPMonths"]);
                } catch { }
            }
            gvPayments.DataSource = tblFilteredPayments;
            gvPayments.DataBind();



            DataTable sourceTable = getGridViewDataTable();
            
            DataView view = new DataView(sourceTable);
            view.RowFilter = "BPermitId=" + getBPermitId(row);
            DataTable tblFiltered = view.ToTable();
            DataRow dr = tblFiltered.Rows[0];

            tbDelay.Text = (string)dr["BPDelay"];
            tbIssued.Text = (string)dr["BPIssueDate"];
            lblExpired.Text = (string)getExpires(dr["BPermitID"], dr["BPIssueDate"]);
            lblExpired.BackColor = System.Drawing.Color.FromName("White");
            lblExpired.ForeColor = System.Drawing.Color.FromName("Black");
            try {
                if (Convert.ToDateTime(lblExpired.Text) < DateTime.Today) {
                    lblExpired.BackColor = System.Drawing.Color.FromName("Red");
                    lblExpired.ForeColor = System.Drawing.Color.FromName("White");
                }
            } catch { }
            tbClosed.Text = (string)dr["BPClosed"];
            if (((string)dr["BPermitReqd"]).ToLower() == "true") {
                rbListPermitRequired.SelectedValue = "Yes";
            } else {
                rbListPermitRequired.SelectedValue = "No";
            }
            tbApplicantName2.Text = (string)dr["Applicant"];
            tbOwnersName.Text=(string)dr["OwnersName"];
            tbContractorBB.Text = (string)dr["Contractor"];
            ddlProjectType.SelectedValue = (string)dr["ProjectType"];
            tbProject.Text = (string)dr["Project"];
            tbLotName2.Text = (string)dr["Lot"];
            ddlLane2.SelectedValue = (string)dr["Lane"];

            DataTable sourceTableReviews = BPermitDataSet().Tables["BPReviews"];
            DataView viewReviews = new DataView(sourceTableReviews);
            viewReviews.RowFilter = "BPermitId=" + getBPermitId(row);
            DataTable tblFilteredReviews = viewReviews.ToTable();
            gvReviews.DataSource = tblFilteredReviews;
            gvReviews.DataBind();
            return "Lot\\Lane: " + getLotLane(dr) + "  Submittal Id: " + getSubmittalId(dr) + "  BPermitId :" + getBPermitId(dr) + " Owner: " + getOwner(dr);

        }
        decimal feeTotal = 0;
        int monthsTotal = 0;
        public System.Drawing.Color getForeColorForExpireDate(Object bPermitIdObject, Object BPIssueDateObject) {
            string color="Black";
            try {
                if (DateTime.Today > Convert.ToDateTime(getExpires(bPermitIdObject, BPIssueDateObject))) {
                    color = "Red";
                }
            } catch {}
            return System.Drawing.Color.FromName(color);
        }
        public string getExpires(Object bPermitIdObject, Object BPIssueDate) {
            int monthsTotal=getMonthsTotal((string)bPermitIdObject);
            string expires = String.Empty;
            if (monthsTotal > 0) {
                try {
                    DateTime dtIssueDate = Convert.ToDateTime(BPIssueDate);

                    dtIssueDate = dtIssueDate.AddMonths(monthsTotal);
                    expires = dtIssueDate.ToString("d");
                } catch { }
            }
            return expires;
        }

        public string getBPMonthsTotal() {
            return monthsTotal.ToString();
        }
        public string getBPFeeTotal() {
            return feeTotal.ToString("c");
        }
        private string getSubmittalId(DataRow dr) {
            return (string)dr["SubmittalId"];
        }
        private string getBPermitId(DataRow dr) {
            return (string)dr["BPermitId"];
        }
        private string getLotLane(DataRow dr) {
            return ((string)dr["Lot"]) + "\\" + (string)dr["Lane"];
        }
        private string getOwner(DataRow dr) {
            return (string)dr["OwnersName"];
        }
        private string getBPermitId(GridViewRow dr) {
            return dr.Cells[4].Text;
        }
        protected override string performSubmittalButtonClick() {
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
                sbFilter.Append(and + " Lot like '*" + tbLot.Text + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " Lane like '*" + ddlLane.SelectedValue + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbSubmittalId.Text)) {
                sb.Append(prepend + "Submittal Id: " + tbSubmittalId.Text);
                prepend = "  ";
                sbFilter.Append(and + " SubmittalId like '*" + tbSubmittalId.Text + "*'");
                and = " and ";
            }

            if (Utils.isNothingNot(tbBPermitId.Text)) {
                sb.Append(prepend + "BPermit Id: " + tbBPermitId.Text);
                prepend = "  ";
                sbFilter.Append(and + " BPermitId like '*" + tbBPermitId.Text + "*'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbDelaySearch.Text)) {
                sb.Append(prepend + "Delay: " + tbDelaySearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbDelaySearch.Text,"BPDelay"));
                and = " and ";
            }

            /*
            if (Utils.isNothingNot(tbApplicant.Text)) {
                sb.Append(prepend + "Applicant: " + tbApplicant.Text);
                prepend = "  ";
                sbFilter.Append(and + " Applicant like '*" + tbApplicant.Text + "*'");
                and = " and ";
            }
            */
            if (sbFilter.Length > 0) {
                DataTable sourceTable = getGridViewDataTable();
                DataView view = new DataView(sourceTable);
                view.RowFilter = sbFilter.ToString();
                DataTable tblFiltered = view.ToTable();
                gvResults.DataSource = tblFiltered;
                gvResults.DataBind();
            } else {
                gvResults.DataSource = getGridViewDataTable();
                gvResults.DataBind();
            }
            return sb.ToString();

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
            }
            if (Common.Utils.isNothingNot(gotoBPermitId)) {
                tbBPermitId.Text = Request.QueryString["BPermitId"];
                ((Database)Master).doGo();
                gvResults.SelectRow(0);
            } else {                
                getGridViewResults().DataSource = getGridViewDataTable();
                getGridViewResults().DataBind();
            }
        }
        protected override DataTable getGridViewDataTable() {
            DataTable bPermits = BPermitDataSet().Tables["BPData"];
            DataTable submittals = Submittal2.SunriverDataSet().Tables["Submittals"];

            var query = 
                from p in bPermits.AsEnumerable()
                join s in submittals.AsEnumerable()
                on p.Field<string>("SubmittalId") equals
                    s.Field<string>("SubmittalId")
                select new {
                    BPermitId =
                        p.Field<string>("BPermitId"),
                    SubmittalId =
                        p.Field<string>("SubmittalId"),
                    PermitId =
                        p.Field<string>("BPermitId"),
                    Lot =
                        s.Field<string>("Lot"),
                    Lane =
                        s.Field<string>("Lane"),
                    BPIssueDate = p.Field<string>("BPIssueDate"),
                    BPClosed=p.Field<string>("BPClosed"),
                    OwnersName = s.Field<string>("OwnersName"),
                    Applicant = s.Field<string>("Applicant"),
                    Contractor = s.Field<string>("Contractor"),
                    BPermitReqd = p.Field<string>("BPermitReqd"),
                    ProjectType=s.Field<string>("ProjectType"),
                    Project=s.Field<string>("Project"),
                    BPDelay=p.Field<string>("BPDelay")
                };

            return query.CopyToDataTable() ;
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