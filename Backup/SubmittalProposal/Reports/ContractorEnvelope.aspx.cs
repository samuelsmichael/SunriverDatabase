using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;

namespace SubmittalProposal.Reports {
    public partial class ContractorEnvelope :AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                DataTable contractor = SubmittalProposal.Contractor.CRDataSet().Tables[1];
                DataTable contractorNoBlanks = contractor.Clone();
                foreach (DataRow dr in contractor.Rows) {
                    if(Common.Utils.isNothingNot(dr["Company"])) {
                        contractorNoBlanks.ImportRow(dr);
                    }
                }
                ddlContractor.DataSource = contractorNoBlanks;
                ddlContractor.DataBind();
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new Contractor.ContractorEnvelope();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@SRContrRegID", Common.Utils.ObjectToInt(ddlContractor.SelectedValue));
            return reportParams;
        }
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["ContractorRegSQLConnectionString"].ConnectionString; }
        }
    }
}