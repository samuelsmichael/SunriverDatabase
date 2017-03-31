using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SubmittalProposal.getpageinforeference;

namespace SubmittalProposal {
    public partial class WebForm1 : System.Web.UI.Page {

        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void bbb(object sender, EventArgs e) {
            GetPageInfo gpi = new GetPageInfo();
            List<string> ls = new List<string>();
            ls.Add("jack");
            ls.Add("jones");
            gpi.HeresYourData(ls);
            ClientScript.RegisterStartupScript(typeof(Page), "closePage", "window.close();", true);
        }
 
        protected void Button1_Click(object sender, EventArgs e) {

        }
    }
}
