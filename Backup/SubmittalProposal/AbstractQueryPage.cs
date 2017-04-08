using System;
using System.Collections.Generic;
using Common;
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
        protected abstract void ChildPagePreRender();
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                Session["GoBackTo"] = Request.UrlReferrer;
            }
            ((AbstractQuery2)Master).getSubmitButton().Click += new EventHandler(AbstractQuery_Click);
        }
        protected void Page_PreRender(object sender, EventArgs args) {
            ChildPagePreRender();
        }
        protected virtual void AbstractQuery_Click(object sender, EventArgs e) {
            DataSet ds = Common.Utils.getDataSet(MSqlCommand, ConnectionString);
            if (Utils.hasData(ds)) {
                DataTable dt = ds.Tables[0];
                Session["aqpTaskTable"] = dt;
                ((AbstractQuery2)Master).getGridView().DataSource = dt;
                ((AbstractQuery2)Master).getGridView().DataBind();
                ((AbstractQuery2)Master).getTitleLabel().Text = PageTitle;
            }
        }
    }
}