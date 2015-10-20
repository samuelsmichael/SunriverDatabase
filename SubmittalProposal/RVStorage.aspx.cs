using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using System.Text;

namespace SubmittalProposal {
    public partial class RVStorage : AbstractDatabase {
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {
            throw new NotImplementedException();
        }

        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbLastNameSearch.Text)) {
                sb.Append(prepend + "LastName: " + tbLastNameSearch.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbLastNameSearch.Text, "LastName"));
                and = " and ";
            }
            if (Utils.isNothingNot(ddlSpaceInfoSearch.SelectedValue)) {
                sb.Append(prepend + "Space: " + ddlSpaceInfoSearch.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " tRVDSpace = '" + ddlSpaceInfoSearch.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbRVLeaseId.Text)) {
                int rvLeaseId = -999;
                try {
                    rvLeaseId = Convert.ToInt32(tbRVLeaseId.Text);
                    sb.Append(prepend + "RV Lease ID: " + tbRVLeaseId.Text);
                    prepend = "  ";
                    sbFilter.Append(and + Common.Utils.getDataViewQuery("," + rvLeaseId + ",", "RVLeaseID"))
                        ;
                    and = " and ";
                } catch { 
                }
            }
            searchCriteria = sb.ToString();
            filterString = sbFilter.ToString();
        }

        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected string getLeaseCancelled(object value) {
            string retValue = "";
            try {
                if (Convert.ToBoolean(value)) {
                    retValue = "True";
                }
            } catch { }
            return retValue;
        }

        protected override System.Data.DataSet buildDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            string key = "RVDataSet";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspRVStorageTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["RVLeaseID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["tSISpace"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;

        }

        protected override System.Data.DataTable getGridViewDataTable() {
            DataSet ds = buildDataSet();
            return ds.Tables[0];
        }

        protected override Label getUpdateResultsLabel() {
            throw new NotImplementedException();
        }

        protected override Label getNewResultsLabel() {
            throw new NotImplementedException();
        }

        protected override void unlockYourUpdateFields() {
            throw new NotImplementedException();
        }

        protected override void lockYourUpdateFields() {
            throw new NotImplementedException();
        }

        protected override void clearAllSelectionInputFields() {
            throw new NotImplementedException();
        }

        protected override void clearAllNewFormInputFields() {
            throw new NotImplementedException();
        }

        protected override string UpdateRoleName {
            get { return "canupdateRVStorage"; }
        }

        protected override void weveComeHereForTheFirstTimeThisSession() {
            MemoryCache cache = MemoryCache.Default;
            cache.Remove("RVDataSet");
            expandCPESearch();
        }

        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsCallback) {
                ddlSpaceInfoSearch.DataSource = buildDataSet().Tables[1];
                ddlSpaceInfoSearch.DataBind();
                ddlSpaceInfoSearch.Items.Insert(0, new ListItem("", ""));
                ddlSpaceInfoSearch.SelectedIndex = 0;
            }
        }
    }
}