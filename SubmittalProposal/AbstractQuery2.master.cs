using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class AbstractQuery2 : System.Web.UI.MasterPage {
        public GridView getGridView() {
            return GridView2;
        }
        public Label getTitleLabel() {
            return lblQueryName;
        }
        protected void btnReturnFromQueryPage_OnClick(object sender, EventArgs arges) {
            Response.Redirect(Session["GoBackTo"].ToString());
        }
    }
}