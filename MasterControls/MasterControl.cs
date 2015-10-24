using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterControls {
    public abstract class ChildUserControl : System.Web.UI.UserControl {
        Control master;

        public abstract string MasterControlVirtualPath { get; }

        protected override void OnInit(EventArgs e) {
            master = LoadControl(MasterControlVirtualPath);
            Controls.Add(master);

            base.OnInit(e);
        }

        protected override void Render(HtmlTextWriter writer) {
            master.RenderControl(writer);
        }
    }
    public class ControlContentPlaceHolder : Control {
        protected override void Render(HtmlTextWriter writer) {
            ControlContent found = null;

            foreach (Control c in NamingContainer.NamingContainer.Controls) {
                ControlContent search;
                search = c as ControlContent;
                if (search != null && search.ControlContentPlaceHolderID.Equals(ID)) {
                    found = search;
                    break;
                }
            }

            if (found != null) {
                //write content of the ContentControl
                found.RenderControl(writer);
            } else {
                //use default content
                base.Render(writer);
            }
        }
    }
    public class ControlContent : Control {
        public string ControlContentPlaceHolderID { get; set; }
    }

}
