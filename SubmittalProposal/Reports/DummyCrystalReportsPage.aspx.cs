using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions;
using CrystalDecisions.CrystalReports;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;


namespace SubmittalProposal.Reports {
    public partial class DummyCrystalReportsPage : System.Web.UI.Page {
        private ReportDocument _RD;

        protected void Page_Load(object sender, EventArgs e) {
            CrystalReportViewer1.ReportSource = RD;
        }
        private ReportDocument RD {
            get {
                if (_RD == null) {
                    _RD = new SubmittalProposal.Reports.OwnerProperty.PropertyAllInfo2();
                }
                return _RD;
            }
        }
    }
}