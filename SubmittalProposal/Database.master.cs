using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubmittalProposal {
    public partial class Database : System.Web.UI.MasterPage {
        public event SearchButtonPressedEventHandler SearchButtonPressed;
        public delegate string SearchButtonPressedEventHandler();
        public AjaxControlToolkit.CollapsiblePanelExtender getCPEForm { get { return CPEForm; } }
        public AjaxControlToolkit.CollapsiblePanelExtender getCPEDataGrid { get { return CPEDataGrid; } }
        public Panel getPanelForm { get { return pnlForm; } }
        protected virtual string OnSearchButtonPressed() {
            string results="";
            SearchButtonPressedEventHandler handler = SearchButtonPressed;
            if (handler != null) {
                results=handler();
            }
            return results;
        }

        protected void Page_Load(object sender, EventArgs e) {

        }
        private void collapseCPESearch() {
            CPESearch.Collapsed=true;
            CPESearch.ClientState="true";
        }
        private void collapseCPEForm() {
            CPEForm.Collapsed = true;
            CPEForm.ClientState = "true";
        }
        private void expandCPEGrid() {
            CPEDataGrid.Collapsed = false;
            CPEDataGrid.ClientState = "false";
        }

        protected void btnGo_Click(object sender, EventArgs e) {
            String results = OnSearchButtonPressed();
            collapseCPESearch();
            CPEDataGrid.CollapsedText = "";
            CPESearch.CollapsedText = results;
            expandCPEGrid();
            collapseCPEForm();
            /* this seems to cause sync problems            CPEForm.CollapsedText = "";*/
            /* this seems to cause sync problems        CPEForm.ExpandedText = ""; */
            /* this seems to cause sync problems         pnlForm.Visible = false;*/ 
        }
    }
}