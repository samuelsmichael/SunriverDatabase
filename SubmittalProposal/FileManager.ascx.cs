using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Diagnostics;
using Common;
using System.Net;

namespace SubmittalProposal {
    public partial class FileManager : System.Web.UI.UserControl {
        // Note: change this to false to enable Compliance Review to have multiple photos
        private string fileUri {
            get {
                return  Utils.ObjectToString(Session[Page.GetType().Name+"fileUri"]);
            }
            set {
                Session[Page.GetType().Name+"fileUri"] = value;
            }
        }
        private string localDirectory {
            get {
                return Utils.ObjectToString(Session[Page.GetType().Name+"localDirectory"]);
            }
            set {
                Session[Page.GetType().Name+"localDirectory"] = value;
            }
        }

        protected void Page_PreRender(object sender, EventArgs e) {
            RepeaterImagesJD.DataSource = new List<string>();
            RepeaterImagesJD.DataBind();
            string scriptText = "javascript:" + StatusLabel.ClientID + ".innerHTML='';         if (this.value != '') {" + btnSave.ClientID + ".click();}";

            FileUploadControl.Attributes["onchange"] = scriptText;
            //         string scriptText2 = FileUploadControl.ClientID + ".click();";
            //         btnChooseAFile.Attributes["onclick"] = scriptText2;
            if (Page is IHasPhotos) {
                if (((IHasPhotos)Page).CurrentItemKey != "0") {
                    string databaseDirectory = Page.GetType().Name.Replace("_aspx", "");
                    fileUri = "~/DocumentUploads/" + databaseDirectory + "/" + ((IHasPhotos)Page).CurrentItemKey;
                    localDirectory = Server.MapPath(fileUri);
                    if (Directory.Exists(localDirectory)) {
                        IEnumerable<string> files;
                        files = Directory.EnumerateFiles(localDirectory, "*.*", SearchOption.TopDirectoryOnly)
                                .Where(s => s.EndsWith(".png") || s.EndsWith(".jpg") || s.EndsWith(".gif") || s.EndsWith(".pdf") || s.EndsWith(".doc") || 
                                    s.EndsWith(".docx") || s.EndsWith("rtf") || s.EndsWith(".txt") || s.EndsWith("xls") || s.EndsWith("xlsx"));
                        List<String> images = new List<string>(files.Count());
                        foreach (string item in files) {
                            images.Add(String.Format(fileUri + "/{0}", System.IO.Path.GetFileName(item)));
                        }
                        RepeaterImagesJD.DataSource = images;
                        RepeaterImagesJD.DataBind();
                    }
                    if (RepeaterImagesJD.Items.Count > 0) {
                        btnOpen.Visible = true;
                    }
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e) {
            Page.Form.Attributes.Add("enctype", "multipart/form-data"); 
            Database database = (Database)Page.Master;
            database.UnlockCheckboxChecked +=new Database.UnlockCheckboxCheckedHandler(database_UnlockCheckboxChecked);
        }

        protected void UploadButton_Click(object sender, EventArgs e) {
            wgaph333.Visible = false;
            if (FileUploadControl.HasFile) {
                if (!Directory.Exists(localDirectory)) {
                    Directory.CreateDirectory(localDirectory);
                }
                try {
                    if (FileUploadControl.PostedFile.ContentType == "image/jpeg" || FileUploadControl.PostedFile.ContentType == "image/gif" || FileUploadControl.PostedFile.ContentType == "image/png" ||
                         FileUploadControl.PostedFile.ContentType == "application/vnd.openxmlformats-officedocument.wordprocessingml.document" ||
                         FileUploadControl.PostedFile.ContentType == "application/msword" ||
                         FileUploadControl.PostedFile.ContentType == "application/pdf" ||
                         FileUploadControl.PostedFile.ContentType == "application/rtf" ||
                         FileUploadControl.PostedFile.ContentType == "text/plain" ||
                         FileUploadControl.PostedFile.ContentType == "application/vnd.ms-excel" ||
                         FileUploadControl.PostedFile.ContentType == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                        ) {
                        string filename = Path.GetFileName(FileUploadControl.FileName);
                        FileUploadControl.SaveAs(localDirectory + @"\" + filename);
                        StatusLabel.Text = "Upload status: File uploaded!";
                    } else {
                        StatusLabel.Text = "Upload status: Only JPEG, PNG, and GIF, DOC, DOCX, XLS, XLSX, PDF, RTF, TXT files are accepted!";
                    }
                } catch (Exception ex) {
                    StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
            btnUnlink.Visible = true;
        }

        private bool WereUnlocked {
            get {
                object obj = Session["WereUnlocked"];
                return obj == null ? false : (bool)obj;
            }
            set {
                Session["WereUnlocked"] = value;
            }
        }
        void database_UnlockCheckboxChecked(bool isUnlocked) {
            if (isUnlocked) {
                WereUnlocked = true;
                if (RepeaterImagesJD.Items.Count == 0) {
                    pnlControl.Visible = true;
                }
                if (RepeaterImagesJD.Items.Count > 0) {
                    btnUnlink.Visible = true;
                    btnOpen.Visible = true;
                } else {
                    btnUnlink.Visible = false;
                    btnOpen.Visible = false;
                }
            } else {
                WereUnlocked = false;
                pnlControl.Visible = false;
                btnUnlink.Visible = false;
                if (RepeaterImagesJD.Items.Count > 0) {
                    btnOpen.Visible = true;
                } else {
                    btnOpen.Visible = false;
                }
            }
        }

        public Boolean IsLinkVisible {
            get {
                return WereUnlocked;
            }
        }
        
        protected void RepeaterImagesJD_ItemCommand1(object source, DataListCommandEventArgs e) {
            int x = 3;
            int y = x;
        }
        protected void btnOpen_Click(object sender, EventArgs args) {
            wgaph333.Visible = false;
            StatusLabel.Text = "";
            string url = HttpContext.Current.Request.Url.ToString();
            int index = url.LastIndexOf("/");
            string preUrl = url.Substring(0, index);
            foreach (DataListItem dli in RepeaterImagesJD.Items) {
                CheckBox cb = (CheckBox)dli.FindControl("cbSelect");
                if (cb.Checked) {
                    string uri = cb.CssClass;
                    string fileSpec = Server.MapPath(uri);
                    try {
                        string cmd="window.open('"+preUrl+uri.Replace("~","")+"', '_blank', 'toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=400,height=400');";
                        ScriptManager.RegisterStartupScript(this,GetType(), "jdOpenDocument", cmd, true);
   /*                     WebClient client = new WebClient();
                        Byte[] buffer = client.DownloadData(fileSpec);
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                        Response.AddHeader("content-length", buffer.Length.ToString());
                        Response.BinaryWrite(buffer);
*/
/*                        Process.Start(@"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", fileSpec);
                        using (System.Diagnostics.Process myProcess = new System.Diagnostics.Process()) {
                            myProcess.StartInfo.UseShellExecute = true;
                            // You can start any process, HelloWorld is a do-nothing example.
                            myProcess.StartInfo.FileName = fileSpec;
                            myProcess.StartInfo.CreateNoWindow = false;
                            myProcess.Start();
                            // This code assumes the process you are starting will terminate itself. 
                            // Given that is is started without a window so you cannot terminate it 
                            // on the desktop, it must terminate itself or you can do it programmatically
                            // from this application using the Kill method.
                            }*/
                    } catch (Exception e) {
                        int x = 3;
                        int y = x;

                    }
                }
            }
        }
        protected string jdGetFileName(string name) {
            return Path.GetFileName(name);
        }
        protected void btnUnlink_Click(object sender, EventArgs e) {
            wgaph333.Visible = false;
            StatusLabel.Text = "";

            int cnt = 0;
            string newFileSpecPath="";
            foreach (DataListItem dli in RepeaterImagesJD.Items) {
                CheckBox cb = (CheckBox)dli.FindControl("cbSelect");
                if (cb.Checked) {
                    string uri = cb.CssClass;
                    string fileSpec = Server.MapPath(uri);
                    string path= Path.GetDirectoryName(fileSpec);
                    if(!Directory.Exists(path+"\\Unlinked")) {
                        Directory.CreateDirectory(path+"\\Unlinked");
                    }
                    string fileName=Path.GetFileName(fileSpec);
                    newFileSpecPath=path+"\\Unlinked\\";
                    string newFileSpec=newFileSpecPath+fileName;
                    if (File.Exists(newFileSpec)) {
                        File.Delete(newFileSpec);
                    }
                    File.Move(fileSpec,newFileSpec);
                    cnt++;
                }
            }
            if (cnt > 0) {
                wgaph333.Visible = true;
                wgaph333.Text=(cnt>1?"Files have been moved to ":"Item has been moved to ") + newFileSpecPath;
            }
            if (RepeaterImagesJD.Items.Count == cnt) {
                btnOpen.Visible = false;
                btnUnlink.Visible = false;
            }
        }
    }
}