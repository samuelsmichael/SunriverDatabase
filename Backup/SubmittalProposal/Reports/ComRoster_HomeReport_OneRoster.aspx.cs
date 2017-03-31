using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;

namespace SubmittalProposal.Reports {
    public partial class ComRoster_HomeReport_OneRoster : AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                DataTable committee = ComRoster_Home.ComRosterDataSet().Tables[0].Copy();
                ddlComRoster_HomeReport_OneRosterCommitteeLU.DataSource = committee;
                ddlComRoster_HomeReport_OneRosterCommitteeLU.DataBind();
            }
        }

        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new ComRoster.CommitteeRoster();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return false;
        }

        protected override System.Collections.Hashtable getReportParams() {
            Hashtable ht = new Hashtable();
            ht.Add("@CommitteeID",ddlComRoster_HomeReport_OneRosterCommitteeLU.SelectedValue);
            return ht;
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["ComRosterSQLConnectionString"].ConnectionString; }
        }
    }
}