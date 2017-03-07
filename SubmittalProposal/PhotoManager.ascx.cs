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
            RepeaterImages.DataSource=new List<string>();
            RepeaterImages.DataBind();
            string scriptText = "javascript:"+StatusLabel.ClientID+".innerHTML='';         if (this.value != '') {" + btnSave.ClientID + ".click();}";

            FileUploadControl.Attributes["onchange"] = scriptText;
   //         string scriptText2 = FileUploadControl.ClientID + ".click();";
   //         btnChooseAFile.Attributes["onclick"] = scriptText2;
            if (Page is IHasPhotos) {
                if (((IHasPhotos)Page).CurrentItemKey != "0") {
                    string databaseDirectory = Page.GetType().Name.Replace("_aspx", "");
                    fileUri = "~/Images/" + databaseDirectory + "/" + ((IHasPhotos)Page).CurrentItemKey;
                    localDirectory = Server.MapPath(fileUri);
                    if (Directory.Exists(localDirectory)) {

                        var files=Directory.EnumerateFiles(localDirectory, "*.*", SearchOption.AllDirectories)
                             .Where(s => s.EndsWith(".png") || s.EndsWith(".jpg") || s.EndsWith(".gif"));

                        List<String> images = new List<string>(files.Count());
                        foreach (string item in files) {
                            images.Add(String.Format(fileUri + "/{0}", System.IO.Path.GetFileName(item)));
                        }
                        RepeaterImages.DataSource = images;
                        RepeaterImages.DataBind();
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
        }


        void database_UnlockCheckboxChecked(bool isUnlocked) {
            if (isUnlocked) {
                pnlControl.Visible = true;
            } else {
                pnlControl.Visible = false;
            }
        }
    }
}