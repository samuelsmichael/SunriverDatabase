using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SubmittalProposal {
    /// <summary>
    /// This class exists in order to implement the "go back" mechanism.
    /// All Query pages must inherit from this page; and they should also have as a MasterPage AbstractQuery2.master
    /// </summary>
    public abstract class AbstractQueryPage : System.Web.UI.Page {
        protected abstract string PageTitle { get; }
        protected abstract SqlCommand MSqlCommand { get; }
        protected abstract string ConnectionString { get; }
        protected void Page_Load(object sender, EventArgs e) {
            if ( !IsPostBack) {
                Session["GoBackTo"] = Request.UrlReferrer;
                DataSet ds = Common.Utils.getDataSet(MSqlCommand, ConnectionString);
                ((AbstractQuery2)Master).getGridView().DataSource = ds;
                ((AbstractQuery2)Master).getGridView().DataBind();
                ((AbstractQuery2)Master).getTitleLabel().Text = PageTitle;
            }
        }
    }
}