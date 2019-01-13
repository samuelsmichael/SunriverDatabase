using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using System.Configuration;
using System.Globalization;

namespace SubmittalProposal {
    public partial class ComplianceReview : AbstractDatabase, ICanHavePDFs {
        public static string DataSetCacheKey = "CRDS";
        private int ReviewIDBeingUpdated {
            get {
                object obj = ViewState["ReviewIDBeingUpdated"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                ViewState["ReviewIDBeingUpdated"] = value;
            }
        }
        protected override void lockYourUpdateFields() {
            tbReviewDateUpdate.Enabled = false;
            tbCloseDateUpdate.Enabled = false;
            tbCommentsFormUpdate.Enabled = false;
            tbDesignRuleUpdate.Enabled = false;
            tbRequiredActionUpdate.Enabled = false;
            tbFollowUpUpdate.Enabled = false;
            btnComplianceUpdate.Enabled = false;
            fvComplianceLetter.Enabled = false;
            pnlComplianceLetterRepeater.Enabled = false;
            tbCRLotNameUpdate.Enabled = false;
            ddlCRLaneUpdate.Enabled = false;
            btnNewComplianceReview.Enabled = false;
            btnComplianceReviewNewLetter.Enabled = false;
            gvComplianceLetters.Enabled = false;
        }
        protected override void unlockYourUpdateFields() {
            tbReviewDateUpdate.Enabled = true;
            tbCloseDateUpdate.Enabled = true;
            tbCommentsFormUpdate.Enabled = true;
            tbDesignRuleUpdate.Enabled = true;
            tbRequiredActionUpdate.Enabled = true;
            tbFollowUpUpdate.Enabled = true;
            btnComplianceUpdate.Enabled = true;
            fvComplianceLetter.Enabled = true;
            pnlComplianceLetterRepeater.Enabled = true;
            tbCRLotNameUpdate.Enabled = true;
            ddlCRLaneUpdate.Enabled = true;
            btnNewComplianceReview.Enabled = true;
            btnComplianceReviewNewLetter.Enabled = true;
            gvComplianceLetters.Enabled = true;

        }
        protected override string UpdateRoleName {
            get { return "canupdatecompliancereviews"; }
        }
        public static DataSet CRDataSet() {
            DataSet ds = null;
            MemoryCache cache=MemoryCache.Default;
            string key = "CRDS";
            ds = (DataSet)cache[key];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspComplianceReviewTablesGet");
                ds = Utils.getDataSet(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["crReviewID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["crLTID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(key, ds, policy);
            }
            return ds;
        }
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString;
            }
        }
        protected override Label getUpdateResultsLabel() {
            return lblComplianceReviewUpdateResults;
        }
        protected override Label getNewResultsLabel() {
            return lblComplianceReviewNewResults;
        }
        protected void btnComplianceReviewUpdate_Click(object sender, EventArgs e) {
            SqlCommand cmd = new SqlCommand("uspComplianceReviewUpdate");
            cmd.Parameters.Add("@crReviewID", SqlDbType.Int).Value = ReviewIDBeingUpdated;
            cmd.Parameters.Add("@crDate", SqlDbType.DateTime).Value = tbReviewDateUpdate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbReviewDateUpdate.Text);
            cmd.Parameters.Add("@crLot", SqlDbType.NVarChar).Value = tbCRLotNameUpdate.Text.Trim();
            cmd.Parameters.Add("@crLane", SqlDbType.NVarChar).Value = ddlCRLaneUpdate.SelectedValue;
            cmd.Parameters.Add("@crComments", SqlDbType.NVarChar).Value = tbCommentsFormUpdate.Text.Trim(); ;
            cmd.Parameters.Add("@crCorrection", SqlDbType.NVarChar).Value = tbRequiredActionUpdate.Text.Trim();
            cmd.Parameters.Add("crRule", SqlDbType.NVarChar).Value = tbDesignRuleUpdate.Text.Trim();
            cmd.Parameters.Add("@CrFollowUp", SqlDbType.NVarChar).Value = tbFollowUpUpdate.Text.Trim();
            cmd.Parameters.Add("@crCloseDate", SqlDbType.DateTime).Value = tbCloseDateUpdate.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbCloseDateUpdate.Text);
            SqlParameter crReviewIDOut = new SqlParameter("@crReviewIDOut", SqlDbType.Int);
            crReviewIDOut.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(crReviewIDOut);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);

            // this gets the one being displayed
            bool continueOn = true;
            Label crLTID = null;
            int icrLTID = 0;
            try {
                crLTID = (Label)fvComplianceLetter.FindControl("lblcrLTIDUpdate");
            } catch { // no letters exist
                continueOn = false;
            }
            try {
                icrLTID = Convert.ToInt32(crLTID.Text);
            } catch {
                continueOn = false;
            }

            if (continueOn) {
                SaveComplianceLetterPageData ltrData = new SaveComplianceLetterPageData();
                Dictionary<int, SaveComplianceLetterPageData> theDictionary = dicSaveComplianceLetterPageData;
                icrLTID = Convert.ToInt32(crLTID.Text);
                try {
                    ltrData = theDictionary[icrLTID];
                } catch { }
                ltrData.crLTID = icrLTID;
                ltrData.fkcrReviewID = ReviewIDBeingUpdated;
                TextBox letterDate = (TextBox)fvComplianceLetter.FindControl("tbcrLtDateUpdate");
                ltrData.crLTDate = (letterDate.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(letterDate.Text.Trim());
                TextBox actionDate = (TextBox)fvComplianceLetter.FindControl("tbcrLTActionDateUpdate");
                ltrData.crLTActionDate = (actionDate.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(actionDate.Text.Trim());
                ltrData.crLTRecipient = ((TextBox)fvComplianceLetter.FindControl("tbcrLTRecipientUpdate")).Text;
                ltrData.crLTMailAddr = ((TextBox)fvComplianceLetter.FindControl("tbcrLTMailAddrUpdate")).Text;
                ltrData.crLTMailAddr2 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTMailAddr2Update")).Text;
                ltrData.crLTCityStateZip = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCityStateZipUpdate")).Text;
                ltrData.crLTCopy1 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCCopy1Update")).Text;
                ltrData.crLTCopy2 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCCopy2Update")).Text;
                ltrData.crLTCopy3 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCCopy3Update")).Text;
                ltrData.crLTSigner = ((DropDownList)fvComplianceLetter.FindControl("ddlCRFromSignatureUpdate")).SelectedValue;
                ltrData.crLTSignerTitle = ((DropDownList)fvComplianceLetter.FindControl("ddlCRFromTitleUpdate")).SelectedValue;
                ltrData.crLTAttachType = ((TextBox)fvComplianceLetter.FindControl("crLTAttachTypeUpdate")).Text;
                ltrData.crLTAttachDescription = ((TextBox)fvComplianceLetter.FindControl("tbcrLTAttachDescriptionUpdate")).Text;
                theDictionary[icrLTID] = ltrData;
                dicSaveComplianceLetterPageData = theDictionary;
                DataRow dr = CRDataSet().Tables[1].Rows.Find(icrLTID);
                updateCorrespondingRow(dr, ltrData);


                foreach (SaveComplianceLetterPageData pageData in dicSaveComplianceLetterPageData.Values) {
                    cmd = new SqlCommand("uspComplianceLetterUpdate");
                    cmd.Parameters.Add("@crLTID", SqlDbType.Int).Value =
                        pageData.crLTID;
                    cmd.Parameters.Add("@fkcrReviewID", SqlDbType.Int).Value = pageData.fkcrReviewID;
                    cmd.Parameters.Add("@crLTDate", SqlDbType.DateTime).Value = pageData.crLTDate;
                    cmd.Parameters.Add("@crLTActionDate", SqlDbType.DateTime).Value = pageData.crLTActionDate;
                    cmd.Parameters.Add("@crLTRecipient", SqlDbType.NVarChar).Value = pageData.crLTRecipient;
                    cmd.Parameters.Add("@crLTMailAddr", SqlDbType.NVarChar).Value = pageData.crLTMailAddr;
                    cmd.Parameters.Add("@crLTMailAddr2", SqlDbType.NVarChar).Value = pageData.crLTMailAddr2;
                    cmd.Parameters.Add("@crLTCityStateZip", SqlDbType.NVarChar).Value = pageData.crLTCityStateZip;
                    cmd.Parameters.Add("@crLTCCopy1", SqlDbType.NVarChar).Value = pageData.crLTCopy1;
                    cmd.Parameters.Add("@crLTCCopy2", SqlDbType.NVarChar).Value = pageData.crLTCopy2;
                    cmd.Parameters.Add("@crLTCCopy3", SqlDbType.NVarChar).Value = pageData.crLTCopy3;
                    cmd.Parameters.Add("@crLTSigner", SqlDbType.NVarChar).Value = pageData.crLTSigner;
                    cmd.Parameters.Add("@crLTSignerTitle", SqlDbType.NVarChar).Value = pageData.crLTSignerTitle;
                    cmd.Parameters.Add("@crLTAttachType", SqlDbType.NVarChar).Value = pageData.crLTAttachType;
                    cmd.Parameters.Add("@crLTAttachDescription", SqlDbType.NVarChar).Value = pageData.crLTAttachDescription;

                    SqlParameter crLTIDOut = new SqlParameter("@crLTIDOut", SqlDbType.Int);
                    crLTIDOut.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(crLTIDOut);
                    Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                }
                /*
                foreach (RepeaterItem item in rptrComplianceLetter.Items) {
                    cmd = new SqlCommand("uspComplianceLetterUpdate");
                    cmd.Parameters.Add("@crLTID", SqlDbType.Int).Value =
                        Convert.ToInt32(((Label)item.FindControl("lblcrLTIDUpdate")).Text);
                    cmd.Parameters.Add("@fkcrReviewID", SqlDbType.Int).Value = ReviewIDBeingUpdated;
                    letterDate = (TextBox)item.FindControl("tbcrLtDateUpdate");
                    cmd.Parameters.Add("@crLTDate",SqlDbType.DateTime).Value=(letterDate.Text.Trim()=="")?(DateTime?)null:Convert.ToDateTime(letterDate.Text.Trim());
                    actionDate = (TextBox)item.FindControl("tbcrLTActionDateUpdate");
                    cmd.Parameters.Add("@crLTActionDate", SqlDbType.DateTime).Value = (actionDate.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(actionDate.Text.Trim());
                    cmd.Parameters.Add("@crLTRecipient", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTRecipientUpdate")).Text;
                    cmd.Parameters.Add("@crLTMailAddr", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTMailAddrUpdate")).Text;
                    cmd.Parameters.Add("@crLTMailAddr2", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTMailAddr2Update")).Text;
                    cmd.Parameters.Add("@crLTCityStateZip", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTCityStateZipUpdate")).Text;
                    cmd.Parameters.Add("@crLTAttachType", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("crLTAttachTypeUpdate")).Text;
                    cmd.Parameters.Add("@crLTAttachDescription", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTAttachDescriptionUpdate")).Text;
                    cmd.Parameters.Add("@crLTCCopy1", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTCCopy1Update")).Text;
                    cmd.Parameters.Add("@crLTCCopy2", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTCCopy2Update")).Text;
                    cmd.Parameters.Add("@crLTCCopy3", SqlDbType.NVarChar).Value = ((TextBox)item.FindControl("tbcrLTCCopy3Update")).Text;
                    cmd.Parameters.Add("@crLTSigner", SqlDbType.NVarChar).Value = ((DropDownList)item.FindControl("ddlCRFromSignatureUpdate")).SelectedValue;
                    cmd.Parameters.Add("@crLTSignerTitle", SqlDbType.NVarChar).Value = ((DropDownList)item.FindControl("ddlCRFromTitleUpdate")).SelectedValue;
                    SqlParameter crLTIDOut = new SqlParameter("@crLTIDOut", SqlDbType.Int);
                    crLTIDOut.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(crLTIDOut);
                    Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
                }
                 * */
            }
            performPostUpdateSuccessfulActions("Update successful", "CRDS", null);
        }
        private int CurrentFormViewPageIndex {
            get {
                object obj = ViewState["CurrentFormViewPageIndex"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                ViewState["CurrentFormViewPageIndex"] = value;
            }
        }
        private class SaveComplianceLetterPageData {
            public int crLTID;
            public int fkcrReviewID;
            public DateTime? crLTDate;
            public DateTime? crLTActionDate;
            public string crLTRecipient;
            public string crLTMailAddr;
            public string crLTMailAddr2;
            public string crLTCityStateZip;
            public string crLTCopy1;
            public string crLTCopy2;
            public string crLTCopy3;
            public string crLTSigner;
            public string crLTSignerTitle;
            public string crLTAttachType;
            public string crLTAttachDescription;
        }
        private Dictionary<int, SaveComplianceLetterPageData> dicSaveComplianceLetterPageData {
            get {
                object dic = Session["SaveComplianceLetterPageData"];
                return dic == null ? new Dictionary<int, SaveComplianceLetterPageData>() : (Dictionary<int, SaveComplianceLetterPageData>)dic;
            }
            set {
                Session["SaveComplianceLetterPageData"] = value;
            }
        }
        private void updateCorrespondingRow(DataRow dr, SaveComplianceLetterPageData s) {
            if (s.crLTDate.HasValue) {
                dr["crLTDate"] = s.crLTDate.Value;
            } else {
                dr["crLTDate"] = DBNull.Value;
            }
            if (s.crLTActionDate.HasValue) {
                dr["crLTActionDate"] = s.crLTActionDate.Value;
            } else {
                dr["crLTActionDate"] = DBNull.Value;
            }
            dr["crLTRecipient"] = s.crLTRecipient;
            dr["crLTMailAddr"] = s.crLTMailAddr;
            dr["crLTMailAddr2"] = s.crLTMailAddr2;
            dr["crLTCity+State+Zip"] = s.crLTCityStateZip;
            dr["crLTCCopy1"] = s.crLTCopy1;
            dr["crLTCCopy2"] = s.crLTCopy2;
            dr["crLTCCopy3"] = s.crLTCopy3;
            dr["crLTSigner"] = s.crLTSigner;
            dr["crLTSignerTitle"] = s.crLTSignerTitle;
            dr["crLTAttachType"] = s.crLTAttachType;
            dr["crLTAttachDescription"] = s.crLTAttachDescription;
        }
        protected void fvComplianceLetter_PageIndexChanging(Object sender, FormViewPageEventArgs e) {
            // save this page's data
            SaveComplianceLetterPageData ltrData = new SaveComplianceLetterPageData();
            Label crLTID = (Label)fvComplianceLetter.FindControl("lblcrLTIDUpdate");
            int icrLTID=Convert.ToInt32(crLTID.Text);
            DataRow dr = CRDataSet().Tables[1].Rows.Find(icrLTID);
            Dictionary<int, SaveComplianceLetterPageData> theDictionary = dicSaveComplianceLetterPageData;
            try {
                ltrData = theDictionary[icrLTID];
            } catch { }
            ltrData.crLTID = icrLTID;
            ltrData.fkcrReviewID = ReviewIDBeingUpdated;
            TextBox letterDate = (TextBox)fvComplianceLetter.FindControl("tbcrLtDateUpdate");
            TextBox actionDate = (TextBox)fvComplianceLetter.FindControl("tbcrLTActionDateUpdate");

            ltrData.crLTDate = (letterDate.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(letterDate.Text.Trim());
            ltrData.crLTActionDate=(actionDate.Text.Trim() == "") ? (DateTime?)null : Convert.ToDateTime(actionDate.Text.Trim());
            ltrData.crLTRecipient = ((TextBox)fvComplianceLetter.FindControl("tbcrLTRecipientUpdate")).Text;
            ltrData.crLTMailAddr= ((TextBox)fvComplianceLetter.FindControl("tbcrLTMailAddrUpdate")).Text;
            ltrData.crLTMailAddr2 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTMailAddr2Update")).Text;
            ltrData.crLTCityStateZip = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCityStateZipUpdate")).Text;
            ltrData.crLTCopy1 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCCopy1Update")).Text;
            ltrData.crLTCopy2 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCCopy2Update")).Text;
            ltrData.crLTCopy3 = ((TextBox)fvComplianceLetter.FindControl("tbcrLTCCopy3Update")).Text;
            ltrData.crLTSigner = ((DropDownList)fvComplianceLetter.FindControl("ddlCRFromSignatureUpdate")).SelectedValue;
            ltrData.crLTSignerTitle = ((DropDownList)fvComplianceLetter.FindControl("ddlCRFromTitleUpdate")).SelectedValue;
            ltrData.crLTAttachType = ((TextBox)fvComplianceLetter.FindControl("crLTAttachTypeUpdate")).Text;
            ltrData.crLTAttachDescription = ((TextBox)fvComplianceLetter.FindControl("tbcrLTAttachDescriptionUpdate")).Text;
            theDictionary[icrLTID] = ltrData;
            updateCorrespondingRow(dr, ltrData);
            dicSaveComplianceLetterPageData = theDictionary;

            CurrentFormViewPageIndex = e.NewPageIndex;

            fvComplianceLetter.PageIndex = e.NewPageIndex;
            DataView dvComplianceLetters = CRDataSet().Tables[1].AsDataView();
            int currentReviewId = Convert.ToInt32(Session["currentfkcrReviewID"]);
            dvComplianceLetters.RowFilter = "fkcrReviewID=" + currentReviewId;
            DataTable dtComplianceLetters = dvComplianceLetters.ToTable();
            fvComplianceLetter.DataSource = dtComplianceLetters;
            fvComplianceLetter.DataBind();
        }



        protected override void childPageLoad(object sender, EventArgs e) {
            if (!IsPostBack) {
                ddlLane.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlLane.DataBind();
                ddlNewComplianceReviewLaneNew.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlNewComplianceReviewLaneNew.DataBind();
                ddlCRLaneUpdate.DataSource = ((SiteMaster)Master.Master.Master).dsLotLane;
                ddlCRLaneUpdate.DataBind();
                dicSaveComplianceLetterPageData = null;
            }
        }
        private int getInspectionNumber(GridViewRow row) {
            return  Convert.ToInt32(row.Cells[9].Text);
        }
        private string getLotLane(DataRow dr) {
            return "" + dr["crLOT"] + " \\ " + dr["crLANE"];
        }
        private DateTime? getReviewDate(DataRow dr) {
            try {
                return (DateTime?)dr["crDate"];
            } catch {
                return (DateTime?)null;
            }
        }
        private DateTime? getClosingDate(DataRow dr) {
            try {
                return Utils.ObjectToDateTimeNullable(dr["crCloseDate"]);
            } catch {
                return (DateTime?)null;
            }
        }
        private string getComments(DataRow dr) {
            return Utils.ObjectToString(dr["crComments"]);
        }
        private string getDesignRule(DataRow dr) {
            return  Utils.ObjectToString(dr["crRule"]);
        }
        private string getRequiredAction(DataRow dr) {
            return  Utils.ObjectToString(dr["crCorrection"]);
        }
        private string getFollowUp(DataRow dr) {
            return  Utils.ObjectToString(dr["crFollowUp"]);
        }
        private string getReviewLotName(DataRow dr) {
            return Utils.ObjectToString(dr["crLOT"]);
        }
        // What to do about bad data.
        private string getReviewLane(DataRow dr) {
            return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Utils.ObjectToString(dr["crLANE"]).ToLower());
        }
        private string getReviewSubmittalId(DataRow dr) {
            return Utils.ObjectToString(dr["crSubmittalId"]);
        }
        private int getReviewId(DataRow dr) {
            return Utils.ObjectToInt(dr["crReviewID"]);
        }
        protected override string gvResults_DoSelectedIndexChanged(object sender, EventArgs e) {

            GridViewRow row = gvResults.SelectedRow;
            int inspectionNbr = getInspectionNumber(row);
            DataRow dr = getGridViewDataTable().Rows.Find(inspectionNbr);
            DateTime? reviewDate = getReviewDate(dr);
            DateTime? closeDate = getClosingDate(dr);
            tbCloseDateUpdate.Text=closeDate.HasValue?closeDate.Value.ToString("MM/dd/yyyy"):"";
            tbReviewDateUpdate.Text=reviewDate.HasValue?reviewDate.Value.ToString("MM/dd/yyyy"):"";
            tbCommentsFormUpdate.Text = getComments(dr);
            tbDesignRuleUpdate.Text = getDesignRule(dr);
            tbRequiredActionUpdate.Text = getRequiredAction(dr);
            tbFollowUpUpdate.Text = getFollowUp(dr);
            tbCRLotNameUpdate.Text = getReviewLotName(dr);
            ddlCRLaneUpdate.SelectedValue = getReviewLane(dr);
            SetLaneLotForPDFs(ddlCRLaneUpdate.SelectedValue + " " + tbCRLotNameUpdate.Text);
            ReviewIDBeingUpdated = getReviewId(dr);
            Session["currentfkcrReviewID"] = getInspectionNumber(row);
            bind_gvComplianceLetters();

            return "Inspection Nbr: " + inspectionNbr + "    Lot\\Lane: " + getLotLane(dr) + "    Date: " + (reviewDate.HasValue?reviewDate.Value.ToString("MM/dd/yyyy"):"");
        }

        private void bind_gvComplianceLetters() {
            DataView dvComplianceLetters = CRDataSet().Tables[1].AsDataView();
            dvComplianceLetters.RowFilter = "fkcrReviewID=" + Session["currentfkcrReviewID"];
            DataTable dtComplianceLetters = dvComplianceLetters.ToTable();

            gvComplianceLetters.DataSource = dtComplianceLetters;
            gvComplianceLetters.DataBind();
            fvComplianceLetter.DataSource = dtComplianceLetters;
            fvComplianceLetter.DataBind();
            rptrComplianceLetter.DataSource = dtComplianceLetters;
            rptrComplianceLetter.DataBind();
        }


        protected void gvComplianceLetters_RowEditing(object sender, GridViewEditEventArgs e) {
            //Set the edit index.
            gvComplianceLetters.EditIndex = e.NewEditIndex;
            //Bind data to the GridView control.
            bind_gvComplianceLetters();
        }

        protected void gvComplianceLetters_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            Page.Validate();
            if (Page.IsValid) {
                GridViewRow row = gvComplianceLetters.Rows[e.RowIndex];
                try {
                    int complianceLetterID = Convert.ToInt32(((Label)row.FindControl("lblfkcrReviewIDEdit")).Text);
                    SqlCommand cmd2 = new SqlCommand("uspComplianceLetterUpdate");
                    cmd2.Parameters.Add("@crLTID", SqlDbType.Int).Value = complianceLetterID;
                    cmd2.Parameters.Add("@fkcrReviewID", SqlDbType.Int).Value = ReviewIDBeingUpdated;
                    TextBox tbLTDate = (TextBox)row.FindControl("tbLetterDateEditUpdate");
                    TextBox tbLTActionDate = (TextBox)row.FindControl("tbActionDeadlineEdit");


                    cmd2.Parameters.Add("@crLTDate", SqlDbType.DateTime).Value = tbLTDate.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbLTDate.Text);
                    cmd2.Parameters.Add("@crLTActionDate", SqlDbType.DateTime).Value =
                        tbLTActionDate.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbLTActionDate.Text);
                    SqlParameter crLTIDOut = new SqlParameter("@crLTIDOut", SqlDbType.Int);
                    crLTIDOut.Direction = ParameterDirection.Output;
                    cmd2.Parameters.Add(crLTIDOut);
                    // I put these here, just in case they ever want to put stuff back into the ComplianceLetter
                    cmd2.Parameters.Add("@crLTRecipient", SqlDbType.NVarChar).Value = ""; // tbcrLTRecipientNew.Text;
                    cmd2.Parameters.Add("@crLTMailAddr", SqlDbType.NVarChar).Value = ""; // tbcrLTMailAddrNew.Text;
                    cmd2.Parameters.Add("@crLTMailAddr2", SqlDbType.NVarChar).Value = ""; // tbcrLTMailAddr2New.Text;
                    cmd2.Parameters.Add("@crLTCityStateZip", SqlDbType.NVarChar).Value = ""; // tbcrLTCityStateZipNew.Text;
                    cmd2.Parameters.Add("@crLTCCopy1", SqlDbType.NVarChar).Value = ""; // tbcrLTCCopy1New.Text;
                    cmd2.Parameters.Add("@crLTCCopy2", SqlDbType.NVarChar).Value = ""; // tbcrLTCCopy2New.Text;
                    cmd2.Parameters.Add("@crLTCCopy3", SqlDbType.NVarChar).Value = ""; // tbcrLTCCopy3New.Text;
                    cmd2.Parameters.Add("@crLTSigner", SqlDbType.NVarChar).Value = ""; // ddlCRFromSignatureNew.SelectedValue;
                    cmd2.Parameters.Add("@crLTSignerTitle", SqlDbType.NVarChar).Value = ""; // ddlCRFromTitleNew.SelectedValue;
                    cmd2.Parameters.Add("@crLTAttachType", SqlDbType.NVarChar).Value = ""; // crLTAttachTypeNew.Text;
                    cmd2.Parameters.Add("@crLTAttachDescription", SqlDbType.NVarChar).Value = ""; // tbcrLTAttachDescriptionNew.Text;
                    Utils.executeNonQuery(cmd2, ConnectionString);
                    performPostUpdateSuccessfulActions("Compliance Letter updated", DataSetCacheKey, null);
                } catch (Exception ee) {
                    performPostUpdateFailedActions("Compliance Letter not updated. Error msg: " + ee.Message);
                }
                //Reset the edit index.
                gvComplianceLetters.EditIndex = -1;

                //Bind data to the GridView control.
                bind_gvComplianceLetters();
            }
        }

        protected void gvComplianceLetters_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            //Reset the edit index.
            gvComplianceLetters.EditIndex = -1;

            //Bind data to the GridView control.
            bind_gvComplianceLetters();
        }

        private decimal sumFine = 0;
        private int lastIndex = -1;
        protected void gvComplianceLetters_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                if (e.Row.RowIndex > lastIndex) { // because after an update, it sweeps through the rows twice.
                }
            }
        }




        protected override void performSubmittalButtonClick(out string searchCriteria, out string filterString) {
            StringBuilder sb = new StringBuilder();
            StringBuilder sbFilter = new StringBuilder();
            string prepend = "";
            string and = "";
            if (Utils.isNothingNot(tbLot.Text)) {
                sb.Append(prepend + "Lot: " + tbLot.Text);
                prepend = "  ";
                sbFilter.Append(and + " crLot = '" + tbLot.Text + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(ddlLane.SelectedValue) && ddlLane.SelectedValue.ToLower() != "choose lane") {
                sb.Append(prepend + "Lane: " + ddlLane.SelectedValue);
                prepend = "  ";
                sbFilter.Append(and + " crLane = '" + ddlLane.SelectedValue + "'");
                and = " and ";
            }
            if (Utils.isNothingNot(tbComments.Text)) {
                sb.Append(prepend + "Comments: " + tbComments.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbComments.Text, "crComments"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbRule.Text)) {
                sb.Append(prepend + "Rule: " + tbRule.Text);
                prepend = "  ";
                sbFilter.Append(and + Common.Utils.getDataViewQuery(tbRule.Text, "crRule"));
                and = " and ";
            }
            if (Utils.isNothingNot(tbReviewId.Text)) {
                sb.Append(prepend + "Review Id: " + tbReviewId.Text);
                prepend = "  ";
                sbFilter.Append(and + " crReviewId = " + tbReviewId.Text);
                and = " and ";
            }
            searchCriteria=sb.ToString();
            filterString=sbFilter.ToString();
        }
        protected override GridView getGridViewResults() {
            return gvResults;
        }
        protected override System.Data.DataSet buildDataSet() {
            return CRDataSet();
        }
        protected override System.Data.DataTable getGridViewDataTable() {
            return CRDataSet().Tables[0];
        }
        protected void fvComplianceLetter_OnModeChanging(object sender, EventArgs e) {
        }
        protected void fvComplianceLetter_OnDataBound(object sender, EventArgs e) {
            if (fvComplianceLetter.Row != null) {
                FormView fv = (FormView)sender;
                Label control = (Label)fv.FindControl("lblcrLTIDUpdate");
                DropDownList ddlCRFromSignature = (DropDownList)fv.FindControl("ddlCRFromSignatureUpdate");
                DropDownList ddlCRFromTitle = (DropDownList)fv.FindControl("ddlCRFromTitleUpdate");
                if (control != null) {
                    DataRow dr = CRDataSet().Tables[1].Rows.Find(control.Text);
                    string signer = Common.Utils.ObjectToString(dr["crLTSigner"]);
                    string signerTitle = Common.Utils.ObjectToString(dr["crLTSignerTitle"]);
                    if (Utils.isNothingNot(signer)) {
                        ddlCRFromSignature.SelectedValue = signer;
                    } else {
                        ddlCRFromSignature.SelectedValue = String.Empty;
                    }
                    if (Utils.isNothingNot(signerTitle)) {
                        ddlCRFromTitle.SelectedValue = signerTitle;
                    } else {
                        ddlCRFromTitle.SelectedValue = String.Empty;
                    }
                }
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e) {
            RepeaterItem o=e.Item;
            if (o != null) {
                DropDownList ddlCRFromSignature = (DropDownList)o.FindControl("ddlCRFromSignature");
                DropDownList ddlCRFromTitle = (DropDownList)o.FindControl("ddlCRFromTitle");
                Label control = (Label)o.FindControl("lblcrLTID");
                if (control != null) {
                    DataRow dr = CRDataSet().Tables[1].Rows.Find(control.Text);
                    string signer = Common.Utils.ObjectToString(dr["crLTSigner"]);
                    string signerTitle = Common.Utils.ObjectToString(dr["crLTSignerTitle"]);
                    if (Utils.isNothingNot(signer)) {
                        ddlCRFromSignature.SelectedValue = signer;
                    } else {
                        ddlCRFromSignature.SelectedValue = String.Empty;
                    }
                    if (Utils.isNothingNot(signerTitle)) {
                        ddlCRFromTitle.SelectedValue = signerTitle;
                    } else {
                        ddlCRFromTitle.SelectedValue = String.Empty;
                    }
                }
            }
        }

        protected void btnNewComplianceReviewOk_Click(object sender, EventArgs e) {
            SqlCommand cmd = new SqlCommand("uspComplianceReviewUpdate");
            cmd.Parameters.Add("@crDate", SqlDbType.DateTime).Value = tbReviewDateNew.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbReviewDateNew.Text);
            cmd.Parameters.Add("@crLot", SqlDbType.NVarChar).Value = tbComplianceReviewLotNew.Text.Trim();
            cmd.Parameters.Add("@crLane", SqlDbType.NVarChar).Value = ddlNewComplianceReviewLaneNew.SelectedValue;
            cmd.Parameters.Add("@crComments", SqlDbType.NVarChar).Value = tbCommentsFormNew.Text.Trim(); ;
            cmd.Parameters.Add("@crRule", SqlDbType.NVarChar).Value = tbDesignRuleNew.Text.Trim();
            cmd.Parameters.Add("@crCorrection", SqlDbType.NVarChar).Value = tbRequiredActionNew.Text.Trim();
            cmd.Parameters.Add("@CrFollowUp", SqlDbType.NVarChar).Value = tbFollowUpNew.Text.Trim();
            cmd.Parameters.Add("@crCloseDate", SqlDbType.DateTime).Value = tbCloseDateNew.Text.Trim() == "" ? (DateTime?)null : Convert.ToDateTime(tbCloseDateNew.Text);
            SqlParameter crReviewIDOut = new SqlParameter("@crReviewIDOut", SqlDbType.Int);
            crReviewIDOut.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(crReviewIDOut);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);

            SqlCommand cmd2 = new SqlCommand("uspComplianceLetterUpdate");
            cmd2.Parameters.Add("@fkcrReviewID", SqlDbType.Int).Value = crReviewIDOut.Value;
            cmd2.Parameters.Add("@crLTDate", SqlDbType.DateTime).Value = tbcrLtDateNewNewComplianceReview.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbcrLtDateNewNewComplianceReview.Text);
            cmd2.Parameters.Add("@crLTActionDate", SqlDbType.DateTime).Value =
                crLTActionDateNewNewComplianceReview.Text.Trim() == "" ? (
                tbcrLtDateNewNewComplianceReview.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbcrLtDateNewNewComplianceReview.Text).AddDays(30)) : Utils.ObjectToDateTime(crLTActionDateNewNewComplianceReview.Text)==new DateTime(1900,1,1)?(DateTime?)null:Utils.ObjectToDateTime(crLTActionDateNewNewComplianceReview.Text);
            SqlParameter crLTIDOut = new SqlParameter("@crLTIDOut", SqlDbType.Int);
            crLTIDOut.Direction = ParameterDirection.Output;
            cmd2.Parameters.Add(crLTIDOut);
// I put these here, just in case they ever want to put stuff back into the ComplianceLetter
            cmd2.Parameters.Add("@crLTRecipient", SqlDbType.NVarChar).Value = ""; // tbcrLTRecipientNew.Text;
            cmd2.Parameters.Add("@crLTMailAddr", SqlDbType.NVarChar).Value = ""; // tbcrLTMailAddrNew.Text;
            cmd2.Parameters.Add("@crLTMailAddr2", SqlDbType.NVarChar).Value = ""; // tbcrLTMailAddr2New.Text;
            cmd2.Parameters.Add("@crLTCityStateZip", SqlDbType.NVarChar).Value = ""; // tbcrLTCityStateZipNew.Text;
            cmd2.Parameters.Add("@crLTCCopy1", SqlDbType.NVarChar).Value = ""; // tbcrLTCCopy1New.Text;
            cmd2.Parameters.Add("@crLTCCopy2", SqlDbType.NVarChar).Value = ""; // tbcrLTCCopy2New.Text;
            cmd2.Parameters.Add("@crLTCCopy3", SqlDbType.NVarChar).Value = ""; // tbcrLTCCopy3New.Text;
            cmd2.Parameters.Add("@crLTSigner", SqlDbType.NVarChar).Value = ""; // ddlCRFromSignatureNew.SelectedValue;
            cmd2.Parameters.Add("@crLTSignerTitle", SqlDbType.NVarChar).Value = ""; // ddlCRFromTitleNew.SelectedValue;
            cmd2.Parameters.Add("@crLTAttachType", SqlDbType.NVarChar).Value = ""; // crLTAttachTypeNew.Text;
            cmd2.Parameters.Add("@crLTAttachDescription", SqlDbType.NVarChar).Value = ""; // tbcrLTAttachDescriptionNew.Text;
            

            Utils.executeNonQuery(cmd2, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);
            tbcrLtDateNewNewComplianceReview.Text = "";
            crLTActionDateNewNewComplianceReview.Text = "";

            performPostNewSuccessfulActions("Review added", "CRDS", null, tbReviewId,(int)crReviewIDOut.Value);

        }
        protected override void clearAllNewFormInputFields() {
            tbComplianceReviewLotNew.Text = "";
            ddlNewComplianceReviewLaneNew.SelectedIndex = 0;
            tbReviewDateNew.Text = "";
            tbCloseDateNew.Text = "";
            tbCommentsFormNew.Text = "";
            tbDesignRuleNew.Text = "";
            tbRequiredActionNew.Text = "";
            tbFollowUpNew.Text = "";
        }
        protected void btnNewComplianceReviewLetterOk_Click(object sender, EventArgs e) {
            SqlCommand cmd = new SqlCommand("uspComplianceLetterUpdate");
            cmd.Parameters.Add("@fkcrReviewID", SqlDbType.Int).Value = ReviewIDBeingUpdated;
            cmd.Parameters.Add("@crLTDate", SqlDbType.DateTime).Value = tbcrLtDateNew.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbcrLtDateNew.Text);


            cmd.Parameters.Add("@crLTActionDate", SqlDbType.DateTime).Value =
                crLTActionDateNew.Text.Trim() == "" ? (
                tbcrLtDateNew.Text.Trim() == "" ? (DateTime?)null : Utils.ObjectToDateTime(tbcrLtDateNew.Text).AddDays(30)) : Utils.ObjectToDateTime(crLTActionDateNew.Text) == new DateTime(1900, 1, 1) ? (DateTime?)null : Utils.ObjectToDateTime(crLTActionDateNewNewComplianceReview.Text);



            cmd.Parameters.Add("@crLTRecipient", SqlDbType.NVarChar).Value = tbcrLTRecipientNew.Text;
            cmd.Parameters.Add("@crLTMailAddr", SqlDbType.NVarChar).Value = tbcrLTMailAddrNew.Text;
            cmd.Parameters.Add("@crLTMailAddr2", SqlDbType.NVarChar).Value = tbcrLTMailAddr2New.Text;
            cmd.Parameters.Add("@crLTCityStateZip", SqlDbType.NVarChar).Value = tbcrLTCityStateZipNew.Text;
            cmd.Parameters.Add("@crLTCCopy1", SqlDbType.NVarChar).Value = tbcrLTCCopy1New.Text;
            cmd.Parameters.Add("@crLTCCopy2", SqlDbType.NVarChar).Value = tbcrLTCCopy2New.Text;
            cmd.Parameters.Add("@crLTCCopy3", SqlDbType.NVarChar).Value = tbcrLTCCopy3New.Text;
            cmd.Parameters.Add("@crLTSigner", SqlDbType.NVarChar).Value = ddlCRFromSignatureNew.SelectedValue;
            cmd.Parameters.Add("@crLTSignerTitle", SqlDbType.NVarChar).Value = ddlCRFromTitleNew.SelectedValue;
            cmd.Parameters.Add("@crLTAttachType", SqlDbType.NVarChar).Value = crLTAttachTypeNew.Text;
            cmd.Parameters.Add("@crLTAttachDescription", SqlDbType.NVarChar).Value = tbcrLTAttachDescriptionNew.Text;

            SqlParameter crLTIDOut = new SqlParameter("@crLTIDOut", SqlDbType.Int);
            crLTIDOut.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(crLTIDOut);
            Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["SRPropertySQLConnectionString"].ConnectionString);

            tbcrLtDateNew.Text = "";
            crLTActionDateNew.Text = "";
            tbcrLTRecipientNew.Text = "";
            tbcrLTMailAddrNew.Text = "";
            tbcrLTMailAddr2New.Text = "";
            tbcrLTCityStateZipNew.Text = "";
            tbcrLTCCopy1New.Text = "";
            tbcrLTCCopy2New.Text = "";
            tbcrLTCCopy3New.Text = "";
            crLTAttachTypeNew.Text = "";
            tbcrLTAttachDescriptionNew.Text = "";

            performPostUpdateSuccessfulActions("Letter added", "CRDS", null);
        }
        protected override void clearAllSelectionInputFields() {
            tbLot.Text = "";
            ddlLane.SelectedIndex = 0;
            tbComments.Text = "";
            tbRule.Text = "";
        }
        protected override void weveComeHereForTheFirstTimeThisSession() {
            expandCPESearch();
        }
        public static string MyMenuName="Compliance Reviews";
        protected override string childMenuName {
            get { return MyMenuName; }
        }

        public bool HasPropertyAvailable {
            get { return Utils.isNothingNot(ReviewIDBeingUpdated); }
        }

        public void SetLaneLotForPDFs(string lanelot) {
            LaneLotForPDFs = lanelot;
        }
    }
}