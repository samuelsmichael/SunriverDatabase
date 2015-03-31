﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data.SqlClient;
using System.Data;
using System.Runtime.Caching;
using System.Configuration;

namespace SubmittalProposal {
    public partial class MainMasterPage : System.Web.UI.MasterPage {
        public string PageImOnSinceMenuItemClickDoesntWork {
            get {
                object item = ViewState["PageImOnSinceMenuItemClickDoesntWork"];
                return item == null ? "Submittal" : (string)item;
            }
            set {
                ViewState["PageImOnSinceMenuItemClickDoesntWork"] = value;
            }
        }
        public DataSet dsLotLane {
            get {
                MemoryCache cache = MemoryCache.Default;
                string key = "LLDS";
                DataSet ds = (DataSet)cache[key];
                if (ds == null) {
                    ds = Utils.getDataSetFromQuery("SELECT distinct [Lane] FROM [tblLotLane] ORDER BY [Lane]", System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                    CacheItemPolicy policy = new CacheItemPolicy();
                    policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                    cache.Add(key, ds, policy);
                }
                return ds;
            }
        }
        protected void Page_Load(object sender, EventArgs e) {
        }

        protected void lbReports_Click(object sender, EventArgs e) {
           // for now if (PageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("submittal")) {
                Response.Redirect("~/SubmittalReportsMain.aspx");
            //}
        }
    }
}