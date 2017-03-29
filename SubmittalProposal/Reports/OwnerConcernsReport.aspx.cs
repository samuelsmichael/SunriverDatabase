using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using Common;
using System.Data;

namespace SubmittalProposal.Reports {
    public partial class OwnerConcernsReport : AbstractReport {
        protected override void child_Page_Load(object sender, EventArgs args) {
            if (!IsPostBack) {
                bindDepartmentReferredToDropdown();
            }
        }

        private void bindDepartmentReferredToDropdown() {
            DataTable department = SubmittalProposal.OwnerConcerns.OwnerConcernsDataSet().Tables[2].Copy();
            DataRow row = department.NewRow();
            row["Department"] = "";
            row["DeptSelector"] = "";
            department.Rows.InsertAt(row, 0);
            ddlDepartmentsParm.DataSource = department;
            ddlDepartmentsParm.DataBind();
        }
            
        protected override CrystalDecisions.CrystalReports.Engine.ReportDocument getReportDocument() {
            if (ddlReport.SelectedValue == "Concerns Open" || ddlReport.SelectedValue == "Concerns Closed" || ddlReport.SelectedValue=="All Concerns" ) {
                return new OwnerConcerns.OwnerConcernsOpenClosed();
            } else {
                if (ddlReport.SelectedValue == "Concern Categories") {
                    return new OwnerConcerns.OwnerConcernsCategoryOrder();
                } else {
                    if (ddlReport.SelectedValue == "Category Summary") {
                        return new OwnerConcerns.OwnerConcernsCategoryOrder();
                    } else {
                        throw new NotImplementedException();
                    }
                }
            }
        }

        protected override bool getIgnoreSubreportsWhenBuildingParameters() {
            return true;
        }

        protected override System.Collections.Hashtable getReportParams() {
            Hashtable reportParams = new Hashtable();
            DateTime? startDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsStartDate.Text);
            if (startDate.HasValue) {
                reportParams.Add("@StartDate", startDate.Value);
            }
            DateTime? endDate = Utils.ObjectToDateTimeNullable(tbOwnerConcernsEndDate.Text);
            if (endDate.HasValue) {
                reportParams.Add("@EndDate", endDate.Value);
            }

            if (Utils.isNothingNot(ddlDepartmentsParm.SelectedValue)) {
                reportParams.Add("@DeptReferred", ddlDepartmentsParm.SelectedValue);
            }
            if (ddlReport.SelectedValue == "Concerns Open") {
                reportParams.Add("@ButIncludeBothOpensAndClosedInTheDataSet", true);
                reportParams.Add("@ConcernsOpen222", true);
                reportParams.Add("@ReportTitle", (Utils.isNothingNot(ddlDepartmentsParm.SelectedValue) ? ddlDepartmentsParm.SelectedValue : "All SROA") + " - Owner Concerns Open");
            } else {
                if (ddlReport.SelectedValue == "Concerns Closed") {
                    reportParams.Add("@ButIncludeBothOpensAndClosedInTheDataSet", true);
                    reportParams.Add("@ConcernsOpen222", false);
                    reportParams.Add("@ReportTitle", (Utils.isNothingNot(ddlDepartmentsParm.SelectedValue) ? ddlDepartmentsParm.SelectedValue : "All SROA") + " - Owner Concerns Closed");
                } else {
                    if (ddlReport.SelectedValue == "All Concerns") {
                        reportParams.Add("@ReportTitle", (Utils.isNothingNot(ddlDepartmentsParm.SelectedValue) ? ddlDepartmentsParm.SelectedValue : "All SROA") + " - All Owner Concerns");
                    } else {
                        if (ddlReport.SelectedValue == "Concern Categories") {
                            reportParams.Add("@ReportTitle", (Utils.isNothingNot(ddlDepartmentsParm.SelectedValue) ? ddlDepartmentsParm.SelectedValue : "All SROA") + " - Owner Concerns Categories");
                            reportParams.Add("@ForceSortByCategory", true);
                        } else {
                            if (ddlReport.SelectedValue == "Category Summary") {
                                reportParams.Add("@ReportTitle", (Utils.isNothingNot(ddlDepartmentsParm.SelectedValue) ? ddlDepartmentsParm.SelectedValue : "All SROA") + " - Owner Concerns Categories");
                                reportParams.Add("@ForceSortByCategory", true);
                                reportParams.Add("@JustDoingCategorySummary", true);
                            } else {
                                throw new NotImplementedException();
                            }
                        }
                    }
                }
            }

            return reportParams;
        }

        protected override string ConnectionString {
            get { return System.Configuration.ConfigurationManager.ConnectionStrings["OwnerConcernsSQLConnectionString"].ConnectionString; }
        }
    }
}