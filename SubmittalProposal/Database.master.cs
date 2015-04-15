using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SubmittalProposal {
    public partial class Database : System.Web.UI.MasterPage {
        public event SearchButtonPressedEventHandler SearchButtonPressed;
        public event UnlockCheckboxCheckedHandler UnlockCheckboxChecked;
        public delegate void SearchButtonPressedEventHandler(out string searchCriteria, out DataTable filteredData );
        public delegate void UnlockCheckboxCheckedHandler(bool isUnlocked);
        public AjaxControlToolkit.CollapsiblePanelExtender getCPEForm { get { return CPEForm; } }
        public AjaxControlToolkit.CollapsiblePanelExtender getCPEDataGrid { get { return CPEDataGrid; } }
        public Panel getPanelForm { get { return pnlForm; } }
        protected virtual void OnSearchButtonPressed(out string searchCriteria, out DataTable resultTable) {
            SearchButtonPressedEventHandler handler = SearchButtonPressed;
            if (handler != null) {
                handler(out searchCriteria, out resultTable);
            } else {
                searchCriteria = null;
                resultTable = null;
            }
        }
        protected virtual void OnUnlockCheckboxChecked(bool isUnlocked) {
            UnlockCheckboxCheckedHandler handler = UnlockCheckboxChecked;
            if (handler != null) {
                handler(isUnlocked);
            }
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

            String results = String.Empty;
            DataTable dummyDataTable;
            OnSearchButtonPressed(out results, out dummyDataTable);
            collapseCPESearch();
            CPEDataGrid.CollapsedText = "";
            CPESearch.CollapsedText = results;
            expandCPEGrid();
            collapseCPEForm();
            /* this seems to cause sync problems            CPEForm.CollapsedText = "";*/
            /* this seems to cause sync problems        CPEForm.ExpandedText = ""; */
            /* this seems to cause sync problems         pnlForm.Visible = false;*/ 
        }
        public void doGo() {
            btnGo_Click(null, null);
        }

        public void enableUnlockRecordCheckbox(bool enable) {
            cbUnlockRecord.Enabled = enable;
        }

        public void clearUnlockRecordCheckbox() {
            cbUnlockRecord.Checked = false;
            OnUnlockCheckboxChecked(false);
        }

        protected void cbUnlockRecord_CheckedChanged(object sender, EventArgs e) {
            if (cbUnlockRecord.Checked) {
                OnUnlockCheckboxChecked(true);
            } else {
                OnUnlockCheckboxChecked(false);
            }
        }
    }
}