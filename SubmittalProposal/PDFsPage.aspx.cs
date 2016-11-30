using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;

namespace SubmittalProposal {
    public partial class PDFsPage : System.Web.UI.Page {
        protected void Page_PreRender(object sender, EventArgs e) {
            if (!IsPostBack) {
                if (Request.QueryString["Type"] != null && Request.QueryString["Type"].ToLower() == "all") {
                    List<PDFFileModel> pdfFiles = new List<PDFFileModel>();
                    string[] filespecs = Directory.GetFiles(System.Configuration.ConfigurationManager.AppSettings["PDFDirectory"], "*.pdf");
                    foreach (string filespec in filespecs) {
                        pdfFiles.Add(new PDFFileModel(filespec, null, null));
                    }
                    RepeaterPDFs.DataSource = pdfFiles;
                    RepeaterPDFs.DataBind();
                    lblPDFsPageHeading.Text = "All PDFs";
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e) {
            hfRootDirectory.Value = System.Configuration.ConfigurationManager.AppSettings["PDFDirectory"];
            
        }

        protected void RepeaterPDFs_ItemDataBound(object sender, RepeaterItemEventArgs e) {
            PDFFileModel model=(PDFFileModel)e.Item.DataItem;
            LinkButton lb = (LinkButton)e.Item.FindControl("lbPDFFile");
            lb.Text = Path.GetFileName(model.mfilespec);     
        }
        protected void lbPDFFile_OnClick(Object sender, EventArgs args) {
            WebClient client = new WebClient();
            Byte[] buffer = client.DownloadData(System.Configuration.ConfigurationManager.AppSettings["PDFDirectory"]+"\\" + ((LinkButton)sender).Text);
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-length", buffer.Length.ToString());
            Response.BinaryWrite(buffer);
        }
    }
}