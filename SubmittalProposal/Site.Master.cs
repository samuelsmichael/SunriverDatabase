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

namespace SubmittalProposal
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
            }
        }
        public string getPropIDForLotLane(string lot, string lane) {
            try {
                DataSet ds = Utils.getDataSetFromQuery("SELECT SRPropID FROM [tblLotLane_Master] WHERE SRLot='" + lot + "' AND SRLane='" + lane + "'", System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                return (string)ds.Tables[0].Rows[0]["SRPropID"];
            } catch {
                return null;
            }
        }
        public DataSet dsLotLane {
            get {
                MemoryCache cache = MemoryCache.Default;
                string key = "LLDS";
                DataSet ds = (DataSet)cache[key];
                if (ds == null) {
                    CacheItemPolicy policy = new CacheItemPolicy();
                    policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                    try {
                        ds = Utils.getDataSetFromQuery("SELECT distinct SRLane Lane FROM [tblLotLane_Master] ORDER BY [Lane]", System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                        cache.Add(key, ds, policy);
                    } catch {
                        try {
                            ds = Utils.getDataSetFromQuery("SELECT distinct SRLane Lane FROM [SRAddConvert] ORDER BY [Lane]", System.Configuration.ConfigurationManager.ConnectionStrings["SROAddConvertConnectionString"].ConnectionString);
                            cache.Add(key, ds, policy);
                        } catch {
                            ds = Utils.getDataSetFromQuery("SELECT distinct Lane FROM [tblLotLane] ORDER BY [Lane]", System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                            cache.Add(key, ds, policy);
                        }
                    }
                }
                return ds;
            }
        }
        public string ReportPageImOnSinceMenuItemClickDoesntWork {
            get {
                object item = Session["ReportPageImOnSinceMenuItemClickDoesntWork"];
                return item == null ? "Submittal" : (string)item;
            }
            set {
                Session["ReportPageImOnSinceMenuItemClickDoesntWork"] = value;
            }
        }
        public string HomePageImOnSinceMenuItemClickDoesntWork {
            get {
                object item = Session["HomePageImOnSinceMenuItemClickDoesntWork"];
                return item == null ? "About" : (string)item;
            }
            set {
                Session["HomePageImOnSinceMenuItemClickDoesntWork"] = value;
            }
        }
    }
}
