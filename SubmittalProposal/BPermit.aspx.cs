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
        public static DataSet BPermitDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "BPermitDS";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspBPermitTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                ds.Tables[0].TableName = "BPData";
                ds.Tables[0].Columns.Add(new DataColumn("BPExpires", typeof(DateTime?)));
                ds.Tables[1].TableName = "BPPayment";
                ds.Tables[2].TableName = "BPReviews";
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            //compute expires
            foreach (DataRow dr3 in ds.Tables[0].Rows) {
                dr3["BPExpires"] = getExpires(dr3["BPermitId"], dr3["BPIssueDate"]);
            }
            return ds;
        }

        private static int getMonthsTotal(int bPermitId) {
            int monthsTotal = 0;
            DataTable sourceTablePayments = dtBPayment;
            DataView viewPayments = new DataView(sourceTablePayments);
            viewPayments.RowFilter = "fkBPermitID_PP=" + bPermitId;
            DataTable tblFilteredPayments = viewPayments.ToTable();
            monthsTotal = 0;
            foreach (DataRow dr1 in tblFilteredPayments.Rows) {
                try {
                    monthsTotal += Utils.ObjectToInt(dr1["BPMonths"]);
                } catch { }
            }
            return monthsTotal;
        }

        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            GridViewRow row = gvResults.SelectedRow;
            Object obj = row.Cells;


            DataTable sourceTablePayments = BPermitDataSet().Tables["BPPayment"];
            DataView viewPayments = new DataView(sourceTablePayments);
            viewPayments.RowFilter = "fkBPermitID_PP =" + getBPermitId(row);
            DataTable tblFilteredPayments = viewPayments.ToTable();
            feeTotal = 0;
            monthsTotal = 0;
            foreach (DataRow dr1 in tblFilteredPayments.Rows) {
                try {
                    feeTotal +=  Utils.ObjectToDecimal0IfNull(dr1["BPFee$"]);
                } catch { };
                try {
                    monthsTotal += Utils.ObjectToInt(dr1["BPMonths"]);
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
            DateTime? issueDate = Utils.ObjectToDateTimeNullable(dr["BPIssueDate"]);
            tbIssued.Text = issueDate.HasValue ? issueDate.Value.ToString("MM/dd/yyyy") : "";
            DateTime? expires=(DateTime?)dr["BPExpires"];
            lblExpired.Text = expires.HasValue?expires.Value.ToString("MM/dd/yyyy"):"";
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
            tbApplicantName2.Text = (string)dr["Applicant"];
            tbOwnersName.Text=(string)dr["OwnersName"];
            tbContractorBB.Text = (string)dr["Contractor"];
            ddlProjectType.SelectedValue = (string)dr["ProjectType"];
            tbProject.Text = (string)dr["Project"];
            tbLotName2.Text = (string)dr["Lot"];
            ddlLane2.SelectedValue = (string)dr["Lane"];

            DataTable sourceTableReviews = BPermitDataSet().Tables["BPReviews"];
            DataView viewReviews = new DataView(sourceTableReviews);
            viewReviews.RowFilter = "fkBPermitID_PR=" + getBPermitId(row);
            DataTable tblFilteredReviews = viewReviews.ToTable();
            gvReviews.DataSource = tblFilteredReviews;
            gvReviews.DataBind();
            int? submittalId = getSubmittalId(dr);
            return "Lot\\Lane: " + getLotLane(dr) + "  Submittal Id: " + (submittalId.HasValue?Convert.ToString(submittalId.Value):"") + "  BPermitId :" + getBPermitId(dr) + " Owner: " + getOwner(dr);

        }
        decimal feeTotal = 0;
        int monthsTotal = 0;
        public System.Drawing.Color getForeColorForExpireDate(Object BPExpiresObject) {
            string color="Black";
            try {
                if (DateTime.Today > Convert.ToDateTime(BPExpiresObject)) {
                    color = "Red";
                }
            } catch {}
            return System.Drawing.Color.FromName(color);
        }
        public static DateTime? getExpires(Object bPermitIdObject, Object BPIssueDate) {
            int monthsTotal=getMonthsTotal((int)bPermitIdObject);
            DateTime? expires = null;
            if (monthsTotal > 0) {
                try {
                    DateTime dtIssueDate = Convert.ToDateTime(BPIssueDate);

                    dtIssueDate = dtIssueDate.AddMonths(monthsTotal);
                    expires = dtIssueDate;
                } catch { }
            }
            return expires;
        }

        public int getBPMonthsTotal() {
            return monthsTotal;
        }
        public string getBPFeeTotal() {
            return feeTotal.ToString("c");
        }
        private int? getSubmittalId(DataRow dr) {
            return Utils.ObjectToIntNullable(dr["fkSubmittalID_PD"]);
        }
        private int getBPermitId(DataRow dr) {
            return (int)dr["fkBPermitID_PR"];
        }
        private string getLotLane(DataRow dr) {
            return ((string)dr["Lot"]) + "\\" + (string)dr["Lane"];
        }
        private string getOwner(DataRow dr) {
            return (string)dr["OwnersName"];
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
            DataTable bPData = BPermitDataSet().Tables["BPData"];
            DataTable submittals = Submittal2.SunriverDataSet().Tables["Submittals"];

            var query = 
                from p in bPData.AsEnumerable()
                join s in submittals.AsEnumerable()
                on p.Field<int>("fkSubmittalID_PD") equals
                    s.Field<int>("SubmittalId")
                select new {
                    BPermitId =
                        p.Field<int>("BPermitId"),
                    SubmittalId =
                        p.Field<int>("fkSubmittalID_PD"),
                    PermitId =
                        p.Field<int>("BPermitId"),
                    Lot =
                        s.Field<string>("Lot"),
                    Lane =
                        s.Field<string>("Lane"),
                    BPIssueDate = p.Field<DateTime>("BPIssueDate"),
                    BPExpires=p.Field<DateTime?>("BPExpires"),
                    BPClosed=p.Field<DateTime>("BPClosed"),
                    OwnersName = s.Field<string>("OwnersName"),
                    Applicant = s.Field<string>("Applicant"),
                    Contractor = s.Field<string>("Contractor"),
                    BPermitReqd = p.Field<bool>("BPermitReqd"),
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