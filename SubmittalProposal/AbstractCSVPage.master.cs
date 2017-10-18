using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

namespace SubmittalProposal {
    public partial class AbstractCSVPage : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {

        }
        public Button getButton() {
            return btnCreateCSVFile;
        }
        protected void btnCreateCSVFile_Click(object sender, EventArgs e) {
            string rootDir = Server.MapPath("~") + @"\App_Data\ContractorMailingLabels";
            Directory.CreateDirectory(rootDir);
            string randomFileSpec=rootDir+@"\"+Path.GetRandomFileName();
            var myExport = new Jitbit.Utils.CsvExport(",",false);
            foreach (DataRow dr in ((DataSet)Session["CSVFileDataSet"]).Tables[0].Rows) {
                myExport.AddRow();
                foreach (DataColumn dataColumn in ((DataSet)Session["CSVFileDataSet"]).Tables[0].Columns) {
                    myExport[dataColumn.ColumnName] = dr[dataColumn.ColumnName];
                }
            }
            File.WriteAllBytes(randomFileSpec, myExport.ExportToBytes());

//            string pdfPath = MapPath("mypdf.pdf");
            Response.ContentType = "text/csv";
            Response.AppendHeader("content-disposition",
                    "attachment; filename=\"ContractorsMailingLabels__Produced_" + DateTime.Now.ToString().Replace("/", "-").Replace(":", " ") + ".csv\"");
            Response.TransmitFile(randomFileSpec);
            Response.End();

        }
    }
}