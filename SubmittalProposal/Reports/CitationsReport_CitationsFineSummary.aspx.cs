﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace SubmittalProposal.Reports {
    public partial class CitationsReport_CitationsFineSummary : AbstractReport {
        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["CitationsSQLConnectionString"].ConnectionString; }
        }
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
            }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new Citations.Citations_FineSummary();
        }
        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@StartDate", tbStartDate.Text);
            reportParams.Add("@EndDate", tbEndDate.Text);
            reportParams.Add("@WhereFineStatus", "Issued as a Warning");
            reportParams.Add("@EqualvsNotEqual", 0);
            return reportParams;
        }

    }
}