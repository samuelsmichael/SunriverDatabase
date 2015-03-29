using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CrystalDecisions;
using CrystalDecisions.CrystalReports;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Collections;
using System.Data;
using Common;

namespace SubmittalProposal.Reports {
    public abstract class AbstractReport : System.Web.UI.Page {
        protected abstract void child_Page_Load(object sender, EventArgs args);
        protected abstract ReportDocument getReportDocument();
        protected abstract bool getIgnoreSubreportsWhenBuildingParameters();
        private string _DatabaseName;
        private string _UserName;
        private string _Password;
        private string _ServerName;
        private ReportDocument _RD;

        protected void Page_Load(object sender, EventArgs e) {
            child_Page_Load(sender, e);
        }

        public AbstractReport() {
            ConnectionStringParser csp = new ConnectionStringParser(System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
            _DatabaseName = csp.Database;
            _UserName = csp.UserId;
            _Password = csp.Password;
            _ServerName = csp.Server;
        }
        public void buildReport(Hashtable reportParams) {
            _RD = null;
            ConnectionInfo connectionInfo = new ConnectionInfo();
            connectionInfo.DatabaseName = _DatabaseName;
            connectionInfo.UserID = _UserName;
            connectionInfo.Password = _Password;
            connectionInfo.ServerName = _ServerName;
            SetDBLogonForReport(connectionInfo, RD);

            ParameterFieldDefinitions parameterFieldDefinitions = RD.DataDefinition.ParameterFields;
            foreach (ParameterFieldDefinition pfd in parameterFieldDefinitions) {
                if (!getIgnoreSubreportsWhenBuildingParameters() || String.IsNullOrWhiteSpace(pfd.ReportName)) { // It appears that if the pfd.ReportName="" then it's not a subreport
                    ParameterValues currentParameterValues = new ParameterValues();
                    ParameterDiscreteValue parameterDiscreteValue = new ParameterDiscreteValue();
                    try {
                        if (String.IsNullOrWhiteSpace((string)reportParams[pfd.Name])) {
                            parameterDiscreteValue.Value = String.Empty;
                        } else {
                            parameterDiscreteValue.Value = reportParams[pfd.Name];
                        }
                    } catch {
                        continue;
                    }
                    currentParameterValues.Add(parameterDiscreteValue);
                    pfd.ApplyCurrentValues(currentParameterValues);
                }
            }
            ((Reports)Master).getCrystalReportView().ReportSource = _RD;
        }
        private void SetDBLogonForReport(ConnectionInfo connectionInfo, ReportDocument reportDocument) {
            Tables tables = reportDocument.Database.Tables;
            foreach (CrystalDecisions.CrystalReports.Engine.Table table in tables) {
                TableLogOnInfo tableLogonInfo = table.LogOnInfo;
                tableLogonInfo.ConnectionInfo = connectionInfo;
                int tries = 3;
                while (tries-- > 0) {
                    try {
                        table.ApplyLogOnInfo(tableLogonInfo);
                        break;
                    } catch { }
                }
            }
            for (int c = 0; c < reportDocument.Subreports.Count; c++) {
                if (reportDocument.Subreports[c].Database.Tables.Count > 0) {
                    CrystalDecisions.CrystalReports.Engine.Table table = reportDocument.Subreports[c].Database.Tables[0];
                    TableLogOnInfo tableLogonInfo = table.LogOnInfo;
                    tableLogonInfo.ConnectionInfo = connectionInfo;
                    table.ApplyLogOnInfo(tableLogonInfo);
                } else {
                }
            }
        }
        private ReportDocument RD {
            get {
                if (_RD == null) {
                    _RD = getReportDocument();
               }
                return _RD;
            }
        }

    
    }
}