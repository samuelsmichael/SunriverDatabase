using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Common;

namespace SubmittalProposal {
    public partial class PhotoManager : System.Web.UI.UserControl {
        // Note: change this to false to enable Compliance Review to have multiple photos
        bool WEREONLYALLOWING1PHOTOWITHCOMPLIANCEREVIEW = true;
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
                    fileUri = "~/Images/" + databaseDirectory + "/" + ((IHasPhotos)Page).CurrentItemKey;
                    localDirectory = Server.MapPath(fileUri);
                    if (Directory.Exists(localDirectory)) {

                        var files = Directory.EnumerateFiles(localDirectory, "*.*", SearchOption.TopDirectoryOnly)
                             .Where(s => s.EndsWith(".png") || s.EndsWith(".jpg") || s.EndsWith(".gif"));

                        List<String> images = new List<string>(files.Count());
                        foreach (string item in files) {
                            images.Add(String.Format(fileUri + "/{0}", System.IO.Path.GetFileName(item)));
                        }
                        RepeaterImagesJD.DataSource = images;
                        RepeaterImagesJD.DataBind();
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
                    if (FileUploadControl.PostedFile.ContentType == "image/jpeg" || FileUploadControl.PostedFile.ContentType == "image/gif" || FileUploadControl.PostedFile.ContentType == "image/png") {
                        string filename = Path.GetFileName(FileUploadControl.FileName);
                        FileUploadControl.SaveAs(localDirectory + @"\"+ filename);
                        StatusLabel.Text = "Upload status: File uploaded!";
                    } else
                        StatusLabel.Text = "Upload status: Only JPEG, PNG, and GIF files are accepted!";
                } catch (Exception ex) {
                    StatusLabel.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }
            if (WEREONLYALLOWING1PHOTOWITHCOMPLIANCEREVIEW && Page.GetType().FullName.ToLower().IndexOf("compliancereview") != -1) { // if compliance review, and we just added a photo (had 0) then turn off ability to upload
                if (RepeaterImagesJD.Items.Count==0) {
                    pnlControl.Visible = false;
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
                if ((!WEREONLYALLOWING1PHOTOWITHCOMPLIANCEREVIEW || (Page.GetType().FullName.ToLower().IndexOf("compliancereview") != -1 && RepeaterImagesJD.Items.Count == 0)) || Page.GetType().FullName.ToLower().IndexOf("compliancereview") == -1) {
                    pnlControl.Visible = true;
                }
                if (RepeaterImagesJD.Items.Count > 0) {
                    btnUnlink.Visible = true;
                }
            } else {
                WereUnlocked = false;
                pnlControl.Visible = false;
                btnUnlink.Visible = false;
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
            if (!WEREONLYALLOWING1PHOTOWITHCOMPLIANCEREVIEW || (Page.GetType().FullName.ToLower().IndexOf("compliancereview") != -1 && RepeaterImagesJD.Items.Count == 1)) { // if compliance review, and we just deleted a photo (had 1) then turn on ability to upload
                pnlControl.Visible = true;
            }
        }
    }
}