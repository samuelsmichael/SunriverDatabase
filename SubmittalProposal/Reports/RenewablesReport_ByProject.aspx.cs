using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Common;
using System.Collections;

namespace SubmittalProposal.Reports {
    public partial class RenewablesReport_ByProject : AbstractReport {

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["RenewablesSQLConnectionString"].ConnectionString; }
        }
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            return new Renewables_MJS.RenewablesByProject();
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        // Create a Hashtable with key of param name and value as the value from the control
        protected override Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            reportParams.Add("@ProjectName", Common.Utils.ObjectToDateTime(ddlProject.SelectedValue));
            return reportParams;
        }
        /// <summary>
        /// In child_Page_Load we’ll load up the DropDownList.  Note that we only do this when !IsPostBack … 
        /// since it only has to be done at the time the page is first shown.)
        /// I’m going to create a stored procedure that does a SELECT DISTINCT ProjectName from tblRenewables.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="args"></param>
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                SqlCommand cmd = new SqlCommand("uspGetDistinctProjectNames");
                DataSet ds = Utils.getDataSet(cmd, ConnectionString);
                foreach (DataRow dr in ds.Tables[0].Rows) {
                    ddlProject.Items.Add(new ListItem((string)dr["ProjectName"],(string)dr["ProjectName"]));
                }
            }
        }

    }
}