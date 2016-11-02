using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using Common;

namespace SubmittalProposal.Reports {
    public partial class ComRoster_HomeReport_CommitteeListAll : AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
            }
        }

        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new ComRoster.CommitteesWithMembersAndLiasons();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        protected override System.Collections.Hashtable getReportParams() {
            Hashtable ht = new Hashtable();
            ht.Add("@ReportDate",Utils.ObjectToDateTime(tbReportDate.Text));
            return ht;
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["ComRosterSQLConnectionString"].ConnectionString; }
        }
    }
}