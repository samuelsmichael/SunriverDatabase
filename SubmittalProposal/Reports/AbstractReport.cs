﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CrystalDecisions;
using CrystalDecisions.CrystalReports;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.ReportAppServer;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using Common;

namespace SubmittalProposal.Reports {
    public abstract class AbstractReport : System.Web.UI.Page {
        protected abstract void child_Page_Load(object sender, EventArgs args);
        protected abstract ReportDocument getReportDocument();
        protected abstract bool getIgnoreSubreportsWhenBuildingParameters();
        protected abstract Hashtable getReportParams();
        protected abstract string ConnectionString { get; }
        private string _DatabaseName;
        private string _UserName;
        private string _Password;
        private string _ServerName;
        private ReportDocument _RD;


        protected void Page_Init(object sender, EventArgs e) {
            if (IsPostBack) {
                if (Session[RDName] != null) {
                    // cast the report from object to ReportClass so it can be set as the CrystalReportViewer ReportSource
                    // (All Crystal Reports inherit from ReportClass, so it serves as an acceptable data type through polymorphism)
                    ((Reports)Master).getCrystalReportView().ReportSource = (ReportClass)Session[RDName];
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                Session["GoBackTo"] = Request.UrlReferrer;
            }
            child_Page_Load(sender, e);
            if (Master != null) { // in case class isn't using Report.Master
                ((Reports)Master).getSubmitButton().Click += new EventHandler(AbstractReport_Click);
            }
        }

        protected void publicBuildReport() {
            buildReport(getReportParams());
        }

        protected virtual void AbstractReport_Click(object sender, EventArgs e) {
            buildReport(getReportParams());
        }

        public AbstractReport() {
            ConnectionStringParser csp = new ConnectionStringParser(ConnectionString);
            _DatabaseName = csp.Database;
            _UserName = csp.UserId;
            _Password = csp.Password;
            _ServerName = csp.Server;
        }
        private string deriveName(string crystalReportsName) {
            string retValue;
            int index = crystalReportsName.IndexOf(";");
            if (index >= 0) {
                retValue = crystalReportsName.Substring(0, index);
            } else {
                retValue = crystalReportsName;
            }
            return retValue;
        }
        public void buildReport(Hashtable reportParams) {
            _RD = null;
            ConnectionInfo connectionInfo = new ConnectionInfo();
            connectionInfo.DatabaseName = _DatabaseName;
            connectionInfo.UserID = _UserName;
            connectionInfo.Password = _Password;
            connectionInfo.ServerName = _ServerName;
            if (RD.Subreports.Count>0) {
                for (int c = 0; c < RD.Subreports.Count; c++) {
                    CrystalDecisions.CrystalReports.Engine.Table table = RD.Subreports[c].Database.Tables[0];
                    SqlCommand cmd = new SqlCommand(deriveName(table.Location));
                    foreach (string parmName in getReportParams().Keys) {
                        cmd.Parameters.Add(new SqlParameter(parmName, getReportParams()[parmName]));
                    }
                    DataSet ds = Utils.getDataSet(cmd, ConnectionString);
                    table.SetDataSource(ds.Tables[0]);
                }


                /*
                CrystalDecisions.CrystalReports.Engine.ReportClass rep;
                ReportClientDocumentWrapper doc = (ReportClientDocumentWrapper)RD.ReportClientDocument;
                CrystalDecisions.ReportAppServer.ReportDefModel.Section sec = doc.ReportDefController.ReportDefinition.ReportHeaderArea.Sections[0];
                doc.SubreportController.ImportSubreport("SubReport", csr.ReportFileName, sec);
                rep.OpenSubreport("SubReport").SetDataSource(csr.ds.Tables[0]);
                */
                int herehere = 1;
            }
            //////RD.ReportClientDocument
            //////////////RD.ReportClientDocument
            if (RD.Database.Tables.Count > 0) {
                SqlCommand cmd = new SqlCommand(deriveName(RD.Database.Tables[0].Location));
                foreach (string parmName in getReportParams().Keys) {
                    cmd.Parameters.Add(new SqlParameter(parmName, getReportParams()[parmName]));
                }
/*                if (this.GetType().Name.ToLower().IndexOf("ownerconcersreport")!=-1) { // kludge because Crystal Reports won't let me fix up the rpt
                    cmd.Parameters.Add(new SqlParameter("@BaseDirForPhotos",getReportParams()["@BaseDirForPhotos"]));
                }*/
                DataSet ds = Utils.getDataSet(cmd, ConnectionString);
                RD.SetDataSource(ds.Tables[0]);
            }
            
/*

            SetDBLogonForReport(connectionInfo, RD);

            ParameterFieldDefinitions parameterFieldDefinitions = RD.DataDefinition.ParameterFields;
            foreach (ParameterFieldDefinition pfd in parameterFieldDefinitions) {
                if (!getIgnoreSubreportsWhenBuildingParameters() || String.IsNullOrWhiteSpace(pfd.ReportName)) { // It appears that if the pfd.ReportName="" then it's not a subreport
                    ParameterValues currentParameterValues = new ParameterValues();
                    ParameterDiscreteValue parameterDiscreteValue = new ParameterDiscreteValue();
                    try {
                        if (reportParams[pfd.Name]==null) {
                            parameterDiscreteValue.Value = null;
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
*/             
            ((Reports)Master).getCrystalReportView().ReportSource = _RD;
            Session[RDName] = _RD;
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
        private string RDName {
            get {
                return RD.GetType().Name;
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