using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Caching;
using System.Drawing;
using Common;

namespace SubmittalProposal {
    public partial class ComRoster_Home : System.Web.UI.Page, HasMenuName {
        protected void Page_Load(object sender, EventArgs e) {
            ((SiteMaster)Master.Master).HomePageImOnSinceMenuItemClickDoesntWork = GetType().Name;
            if (!IsPostBack) {
                bindCommitteeGrid();
                string zUpdateRoleName = "canupdatecomroster";
                if (HttpContext.Current.User.IsInRole(zUpdateRoleName)) {
                    enableUnlockRecordCheckbox(true);
  //                  cbUnlockRecordLists.Enabled=true;
                } else {
                    enableUnlockRecordCheckbox(false);
    //                cbUnlockRecordLists.Enabled = false;
                }

                CPECommittees.Collapsed = false;
                CPECommittees.ClientState = "false";
            }
        }
        string GetName { get { return "Com Roster"; } }
        private void bindCommitteeGrid() {
            dgCommittees.DataSource = ComRosterDataSet().Tables[0];
            dgCommittees.DataBind();
        }
        private void bindMemberListAndCommitteeTermsGrid() {
            var query = from rosterMember in ComRosterDataSet().Tables[2].AsEnumerable()
                        join member in ComRosterDataSet().Tables[1].AsEnumerable() on rosterMember.Field<int>("MemberID") equals member.Field<int>("MemberID")
                        where (rosterMember.Field<int>("CommitteeID") == CommitteeIDBeingEdited)
                        select new {
                            MemberName = member.Field<string>("FullName"),
                            Title = rosterMember.Field<string>("MTitle"),
                            Appointed = rosterMember.Field<DateTime?>("TAppointed"),
                            Start = rosterMember.Field<DateTime?>("TStart"),
                            End = rosterMember.Field<DateTime?>("TEnd"),
                            Term = rosterMember.Field<string>("TTerm"),
                            MemberID = member.Field<int>("MemberID"),
                            RosterMemberID = rosterMember.Field<int>("RosterMemberID"),
                            MemberFirstName=member.Field<string>("FirstName"),
                            MemberLastName=member.Field<string>("LastName")
                        };
            gvMemberListAndCommitteeTerms.DataSource = query;
            gvMemberListAndCommitteeTerms.DataBind();
        }
        private void bindLiaisonsGrid() {
            var query = from committee in ComRosterDataSet().Tables[0].AsEnumerable()
                        join rosterLiaison in ComRosterDataSet().Tables[4].AsEnumerable() on committee.Field<int>("CommitteeID") equals rosterLiaison.Field<int>("CommitteeID")
                        join liaison in ComRosterDataSet().Tables[3].AsEnumerable() on rosterLiaison.Field<int>("LiaisonID") equals liaison.Field<int>("LiaisonID")
                        where (committee.Field<int>("CommitteeID") == CommitteeIDBeingEdited) && (rosterLiaison.Field<int>("LiaisonID") != 1)
                        select new {
                            LiaisonName = liaison.Field<string>("LiaisonName"),
                            LiaisonRepresents = liaison.Field<string>("LiaisonRepresents"),
                            LiaisonID = liaison.Field<int>("LiaisonID"),
                            RosterLiaisonID=rosterLiaison.Field<int>("RosterLiaisonID"),
                            LiaisonType=liaison.Field<string>("LiaisonType"),
                            LiaisonNameAndType=liaison.Field<string>("LiaisonNameAndType")
                        };

            //DataView viewQuery = query.AsDataView();
            gvLiaisonList.DataSource = query;
            gvLiaisonList.DataBind();

            /*
             * var query =
                from order in orders.AsEnumerable()
                join detail in details.AsEnumerable()
                on order.Field<int>("SalesOrderID") equals
                    detail.Field<int>("SalesOrderID")
                where order.Field<bool>("OnlineOrderFlag") == true
                && order.Field<DateTime>("OrderDate").Month == 8
                select new
                {
                    SalesOrderID =
                        order.Field<int>("SalesOrderID"),
                    SalesOrderDetailID =
                        detail.Field<int>("SalesOrderDetailID"),
                    OrderDate =
                        order.Field<DateTime>("OrderDate"),
                    ProductID =
                        detail.Field<int>("ProductID")
                };
            */
            //           var innerJoinQuery =
            //                from category in categories
            //              join prod in products on category.ID equals prod.CategoryID
            //            select new { ProductName = prod.Name, Category = category.Name }; //produces flat sequence

        }

        private static string DataSetCacheKey = "COMROSTERDATASETCACHEKEY";
        private static string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["ComRosterSQLConnectionString"].ConnectionString;
            }
        }
        public static DataSet ComRosterDataSet() {
            DataSet ds = null;
            MemoryCache cache = MemoryCache.Default;
            ds = (DataSet)cache[DataSetCacheKey];
            if (ds == null) {
                SqlCommand cmd = new SqlCommand("uspComRosterTablesGet");
                ds = Utils.getDataSet(cmd, ConnectionString);
                ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["CommitteeID"] };
                ds.Tables[1].PrimaryKey = new DataColumn[] { ds.Tables[1].Columns["MemberID"] };
                ds.Tables[2].PrimaryKey = new DataColumn[] { ds.Tables[2].Columns["RosterMemberID"] };
                ds.Tables[3].PrimaryKey = new DataColumn[] { ds.Tables[3].Columns["LiaisonID"] };
                ds.Tables[4].PrimaryKey = new DataColumn[] { ds.Tables[4].Columns["RosterLiaisonID"] };
                ds.Tables[5].PrimaryKey = new DataColumn[] { ds.Tables[5].Columns["RosterMemberID"] };
                CacheItemPolicy policy = new CacheItemPolicy();
                policy.SlidingExpiration = new TimeSpan(0, 60, 0);
                cache.Add(DataSetCacheKey, ds, policy);
            }
            return ds;
        }

        protected void dgCommittees_SelectedIndexChanged(object sender, EventArgs e) {
            CPECommittees.Collapsed = true;
            CPECommittees.ClientState = "true";
            CPECommitteeUpdate.Collapsed = false;
            CPECommitteeUpdate.ClientState = "false";
            CPELiaisonAndCommitteeLists.ClientState = "false";
            CPELiaisonAndCommitteeLists.Collapsed = false;
            GridViewRow row = dgCommittees.SelectedRow;
            CommitteeIDBeingEdited = Convert.ToInt32(row.Cells[4].Text);
            DataTable sourceTable = ComRosterDataSet().Tables[0];
            DataView view = new DataView(sourceTable);
            view.RowFilter = "CommitteeID=" + CommitteeIDBeingEdited;
            DataTable tblFiltered = view.ToTable();
            Session["ComRosterTblFiltered"] = tblFiltered;
            DataRow dr = tblFiltered.Rows[0];
            tbCommitteeNameUpdate.Text = Utils.ObjectToString(dr["CommitteeName"]);
            DateTime? charterDate = Utils.ObjectToDateTimeNullable(dr["CharterDate"]);
            if (charterDate.HasValue) {
                tbCharterDateUpdate.Text = charterDate.Value.ToString("d");
            } else {
                tbCharterDateUpdate.Text = "";
            }
            try {
                ddlCommitteeStatusUpdate.SelectedValue = Utils.ObjectToString(dr["Status"]);
            } catch {
                ddlCommitteeStatusUpdate.SelectedValue = "Active";
            }
            tbCommitteeNbrOfMembersUpdate.Text = Utils.ObjectToString(dr["#OfMembers"]);
            tbCommitteeNbrOfMembersNotesUpdate.Text = Utils.ObjectToString(dr["#OfMembersNote"]);
            tbCommitteeTermYearsUpdate.Text = Utils.ObjectToString(dr["Term"]);
            tbCommitteeNbrOfTermsLimitUpdate.Text = Utils.ObjectToString(dr["TermLimit"]);
            tbCommitteeTermNotesUpdate.Text= Utils.ObjectToString(dr["TermLimitNote"]);
            cbCommitteeAlternateMembersAllowed.Checked = Utils.ObjectToBool(dr["AlternateMembers"]);
            cbCommitteeAssociateMembersAllowed.Checked = Utils.ObjectToBool(dr["AssociateMembers"]);

            lblCommitteeNameForUpdatePanel.Text = Utils.ObjectToString(dr["CommitteeName"] + ", ID: " + CommitteeIDBeingEdited);
            // Now do Lists
            bindLiaisonsGrid();
            bindMemberListAndCommitteeTermsGrid();
        }
        private int CommitteeIDBeingEdited {
            get {
                object obj = Session["CommitteeIDBeingEdited"];
                return obj == null ? 0 : (int)obj;
            }
            set {
                Session["CommitteeIDBeingEdited"] = value;
            }
        }
        protected void cvCommitteeNbrOfMembersUpdate_ServerValidate(object source, ServerValidateEventArgs args) {
            args.IsValid = true;
            try {
                int nbrOfMembers = Convert.ToInt32(args.Value);
            } catch {
                args.IsValid = false;
            }
        }
        private void setUnlockRecordCheckboxVisibility(bool isVisible) {
            if (isVisible) {
                cbUnlockRecordCommittee.Visible = true;
                lockCommitteeFields(true);
     //           cbUnlockRecordLists.Visible = true;
            } else {
                cbUnlockRecordCommittee.Visible = false;
                lockCommitteeFields(false);

     //           cbUnlockRecordLists.Visible = false;
            }
        }
        private void enableUnlockRecordCheckbox(bool enable) {
            cbUnlockRecordCommittee.Enabled = enable;           
 //           cbUnlockRecordLists.Enabled = enable;
        }

        protected void cbUnlockRecordCommittee_CheckedChanged(object sender, EventArgs e) {
            if (cbUnlockRecordCommittee.Checked) {
                lockCommitteeFields(true);
            } else {
                lockCommitteeFields(false);
            }
        }
        protected void cbUnlockRecordLists_CheckedChanged(object sender, EventArgs e) {
            if (cbUnlockRecordCommittee.Checked) {
                lockListFields(true);
            } else {
                lockListFields(false);
            }
        }
        private void lockListFields(bool enabled) {
            pnlMemberListAndCommitteeTerms.Enabled = enabled;
            pnlLiaisonList.Enabled = enabled;
            lbLiaisonInCommitteeAdd.Visible = enabled;
            lbWorkWithMembers.Visible = enabled;
            lbWorkWithLiaisons.Visible = enabled;
            lbLiaisonInCommitteeAdd.Visible = enabled;
            lbMemberListAndCommitteeTermsAdd.Visible = enabled;
        }
        private void lockCommitteeFields(bool enable) {
            tbCommitteeNameUpdate.Enabled = enable;
            tbCharterDateUpdate.Enabled = enable;
            ibCharterDateUpdate.Enabled = enable;
            cvCharterDateUpdate.Enabled = enable;
            rvcvCharterDateUpdate.Enabled = enable;
            ddlCommitteeStatusUpdate.Enabled = enable;
            tbCommitteeNbrOfMembersUpdate.Enabled = enable;
            cvCommitteeNbrOfMembersUpdate.Enabled = enable;
            tbCommitteeNbrOfMembersNotesUpdate.Enabled = enable;
            tbCommitteeTermNotesUpdate.Enabled = enable;
            tbCommitteeTermYearsUpdate.Enabled = enable;
            cvCommitteeTermYearsUpdate.Enabled = enable;
            tbCommitteeNbrOfTermsLimitUpdate.Enabled = enable;
            cvCommitteeNbrOfTermsLimitUpdate.Enabled = enable;
            cbCommitteeAlternateMembersAllowed.Enabled = enable;
            cbCommitteeAssociateMembersAllowed.Enabled = enable;
            btnCommitteeUpdateSubmit.Visible = enable;
            pnlMemberListAndCommitteeTerms.Enabled = enable;
            pnlLiaisonList.Enabled = enable;
            lockListFields(enable);
        }

        protected void btnCommitteeUpdateSubmit_Click(object sender, EventArgs e) {
            try {
                lblCommitteeUpdateMessage.Text = "";
                SqlCommand cmd = new SqlCommand("uspComRosterCommitteeSet");
                cmd.Parameters.Add("@CommitteeID", SqlDbType.Int).Value = CommitteeIDBeingEdited;
                cmd.Parameters.Add("@CommitteeName", SqlDbType.NVarChar).Value = Utils.ObjectToString(tbCommitteeNameUpdate.Text);
                cmd.Parameters.Add("@#OfMembers", SqlDbType.NVarChar).Value = Utils.ObjectToString(tbCommitteeNbrOfMembersUpdate.Text);
                cmd.Parameters.Add("@#OfMembersNote", SqlDbType.NVarChar).Value = Utils.ObjectToString(tbCommitteeNbrOfMembersNotesUpdate.Text);
                cmd.Parameters.Add("@Term", SqlDbType.Int).Value = Utils.ObjectToInt(tbCommitteeTermYearsUpdate.Text);
                cmd.Parameters.Add("@TermLimit", SqlDbType.Int).Value = Utils.ObjectToInt(tbCommitteeNbrOfTermsLimitUpdate.Text);
                cmd.Parameters.Add("@TermLimitNote", SqlDbType.NVarChar).Value = Utils.ObjectToString(tbCommitteeTermNotesUpdate.Text);
                cmd.Parameters.Add("@AlternateMembers", SqlDbType.Bit).Value = Utils.ObjectToBool(cbCommitteeAlternateMembersAllowed.Checked);
                cmd.Parameters.Add("@AssociateMembers", SqlDbType.Bit).Value = Utils.ObjectToBool(cbCommitteeAssociateMembersAllowed.Checked);
                DateTime? charterDate = Utils.ObjectToDateTimeNullable(tbCharterDateUpdate.Text);
                if (charterDate.HasValue) {
                    cmd.Parameters.Add("@CharterDate", SqlDbType.DateTime).Value = charterDate;
                }
                cmd.Parameters.Add("@Status", SqlDbType.NVarChar).Value = Utils.ObjectToString(ddlCommitteeStatusUpdate.SelectedValue);
                SqlParameter dummy = new SqlParameter("@NewCommitteeID", SqlDbType.Int);
                dummy.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(dummy);
                Utils.executeNonQuery(cmd, ConnectionString);
                lblCommitteeUpdateMessage.ForeColor = Color.DarkGreen;
                lblCommitteeUpdateMessage.Text = "Update successful";
                MemoryCache cache = MemoryCache.Default;
                cache.Remove(DataSetCacheKey);
                bindCommitteeGrid();
            } catch (Exception ee) {
                lblCommitteeUpdateMessage.ForeColor = Color.Red;
                lblCommitteeUpdateMessage.Text = ee.Message;
            }
        }

        protected void lbWorkWithMembers_click(object sender, EventArgs e) {
            Response.Redirect("~/ComRoster_Members.aspx");
        }

        protected void lbLiaisonInCommitteeAdd_Click(object sender, EventArgs e) {
            ddlLiaisonNew.DataSource = ComRosterDataSet().Tables[3];
            ddlLiaisonNew.DataBind();
            mpeNewLiaison.Show();
        }

        protected void gvLiaisonList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvLiaisonList.EditIndex = -1;
            bindLiaisonsGrid();
        }

        protected void gvLiaisonList_RowEditing(object sender, GridViewEditEventArgs e) {
            gvLiaisonList.EditIndex = Utils.ObjectToInt(e.NewEditIndex);
            bindLiaisonsGrid();
        }
        protected void gvLiaisonList_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            string rosterLiaisonID = Utils.ObjectToString(gvLiaisonList.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("uspLiasonRemoveFromCommittee");
            cmd.Parameters.Add("@RosterLiaisonID", SqlDbType.Int).Value = rosterLiaisonID;
            Utils.executeNonQuery(cmd, ConnectionString);
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            bindLiaisonsGrid();
        }

        protected void gvLiaisonList_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvLiaisonList.Rows[e.RowIndex];
            int newLiasonID= Utils.ObjectToInt(((DropDownList)(row.Cells[1].Controls[1])).SelectedValue);
            string listType=Utils.ObjectToString(((DropDownList)(row.Cells[2].Controls[1])).SelectedValue);
            string rosterLiaisonID = Utils.ObjectToString(gvLiaisonList.DataKeys[e.RowIndex].Value);

            
            //Reset the edit index.
            gvLiaisonList.EditIndex = -1;
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            bindLiaisonsGrid();
        }

        protected void gvLiaisonList_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {

                if ((e.Row.RowState & DataControlRowState.Edit) > 0) {
                    DropDownList ddList = (DropDownList)e.Row.FindControl("ddlLiaisonListLiaisonName");
                    ddList.DataSource = ComRosterDataSet().Tables[3];
                    ddList.DataBind();
                    string mLiaisonID = Utils.ObjectToString(GetValueFromAnonymousType<int>(e.Row.DataItem, "LiaisonID"));
                    int index = ddList.Items.IndexOf(ddList.Items.FindByValue(mLiaisonID));// If you want to find text by TextField.
                    ddList.SelectedIndex = index;
                    DropDownList ddlLiaisonType = (DropDownList)e.Row.FindControl("ddlLiaisonListLiaisonType");
                    ddlLiaisonType.DataSource = ComRosterDataSet().Tables[8];
                    ddlLiaisonType.DataBind();
                    string mLiaisonType = Utils.ObjectToString(GetValueFromAnonymousType<string>(e.Row.DataItem, "LiaisonType"));
                    int index2 = ddlLiaisonType.Items.IndexOf(ddlLiaisonType.Items.FindByValue(mLiaisonType));// If you want to find text by TextField.
                    ddlLiaisonType.SelectedIndex = index2;
                } else {
                    if (((int)e.Row.RowState) == (int)DataControlRowState.Normal || ((int)e.Row.RowState) == (int)DataControlRowState.Alternate) {
                        LinkButton del = e.Row.Cells[4].Controls[0] as LinkButton;
                        del.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this liaison?');");
                    }
                }
                
            }
        }
        public static T GetValueFromAnonymousType<T>(object dataitem, string itemkey) {
            try {
                System.Type type = dataitem.GetType();
                T itemvalue = (T)type.GetProperty(itemkey).GetValue(dataitem, null);
                return itemvalue;
            } catch {
                return default(T);
            }
        }
        protected void btnNewLiaisonCancel_Click(object sender, EventArgs args) {
            mpeNewLiaison.Hide();
        }
        protected void btnNewLiaisonOk_Click(object sender, EventArgs args) {
            try {
                int newLiasonID = Utils.ObjectToInt( ddlLiaisonNew.SelectedValue);
                SqlCommand cmd = new SqlCommand("uspLiasonAddToCommittee");
                cmd.Parameters.Add("@CommitteeID", SqlDbType.Int).Value = CommitteeIDBeingEdited;
                cmd.Parameters.Add("@LiaisonID", SqlDbType.NVarChar).Value = newLiasonID;
                Utils.executeNonQuery(cmd, ConnectionString);
                MemoryCache cache = MemoryCache.Default;
                cache.Remove(DataSetCacheKey);
                bindLiaisonsGrid();
            } catch (Exception ee) {
                lblNewLiaisonMessage.Text="Liaison not updated. Error msg: " + ee.Message;
                mpeNewLiaison.Show();
            }
            mpeNewLiaison.Hide();
        }
        protected void gvMemberListAndCommitteeTerms_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvMemberListAndCommitteeTerms.EditIndex = -1;
            bindMemberListAndCommitteeTermsGrid();
        }
        protected void gvMemberListAndCommitteeTerms_RowEditing(object sender, GridViewEditEventArgs e) {
            gvMemberListAndCommitteeTerms.EditIndex = Utils.ObjectToInt(e.NewEditIndex);
            bindMemberListAndCommitteeTermsGrid();
        }
        protected void gvMemberListAndCommitteeTerms_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            string rosterMemberID = Utils.ObjectToString(gvMemberListAndCommitteeTerms.DataKeys[e.RowIndex].Values[0]);
            SqlCommand cmd = new SqlCommand("uspRemoveMemberFromCommittee");
            cmd.Parameters.Add("@RosterMemberID", SqlDbType.Int).Value = rosterMemberID;
            Utils.executeNonQuery(cmd, ConnectionString);
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            bindMemberListAndCommitteeTermsGrid();
        }
        protected void gvMemberListAndCommitteeTerms_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            GridViewRow row = gvMemberListAndCommitteeTerms.Rows[e.RowIndex];
            string memberID=Utils.ObjectToString(((DropDownList)(row.Cells[1].Controls[1])).SelectedItem.Value);
            string title = Utils.ObjectToString(((DropDownList)(row.Cells[2].Controls[1])).SelectedItem.Value);
            string appointed=Utils.ObjectToString(((TextBox)row.Cells[3].Controls[1]).Text);
            string start = Utils.ObjectToString(((TextBox)row.Cells[4].Controls[1]).Text);
            string end = Utils.ObjectToString(((TextBox)row.Cells[5].Controls[1]).Text);
            string term = Utils.ObjectToString(((DropDownList)(row.Cells[6].Controls[1])).SelectedValue);
            int rosterMemberID = Utils.ObjectToInt( gvMemberListAndCommitteeTerms.DataKeys[e.RowIndex].Values[0]);
            int oldMemberID = Utils.ObjectToInt(gvMemberListAndCommitteeTerms.DataKeys[e.RowIndex].Values[1]);
            SqlCommand cmd = new SqlCommand("uspRosterMemberSet");
            cmd.Parameters.Add("@RosterMemberID", SqlDbType.Int).Value = Utils.ObjectToInt(rosterMemberID);
            cmd.Parameters.Add("@CommitteeID",SqlDbType.Int).Value=CommitteeIDBeingEdited;
            cmd.Parameters.Add("@MemberID",SqlDbType.Int).Value=Utils.ObjectToInt(memberID);
            cmd.Parameters.Add("@MTitle",SqlDbType.NVarChar).Value=title;
            DateTime? tAppointed=Utils.ObjectToDateTimeNullable(appointed);
            if(tAppointed.HasValue) {
                cmd.Parameters.Add("@TAppointed",SqlDbType.DateTime).Value=tAppointed.Value;
            }
            DateTime? tEnd=Utils.ObjectToDateTimeNullable(end);
            if(tEnd.HasValue) {
                cmd.Parameters.Add("@TEnd",SqlDbType.DateTime).Value=tEnd.Value;
            }
            DateTime? tStart=Utils.ObjectToDateTimeNullable(start);
            if(tStart.HasValue) {
                cmd.Parameters.Add("@TStart",SqlDbType.DateTime).Value=tStart.Value;
            }
            cmd.Parameters.Add("@TTerm",SqlDbType.NVarChar).Value=term;
            SqlParameter newRosterMemberID=new SqlParameter("@NewRosterMemberID",SqlDbType.Int);
            newRosterMemberID.Direction=ParameterDirection.Output;
            cmd.Parameters.Add(newRosterMemberID);
            Utils.executeNonQuery(cmd,ConnectionString);
            //Reset the edit index.
            gvMemberListAndCommitteeTerms.EditIndex = -1;
            MemoryCache cache = MemoryCache.Default;
            cache.Remove(DataSetCacheKey);
            bindMemberListAndCommitteeTermsGrid();
        }
        protected void gvMemberListAndCommitteeTerms_RowDataBound(object sender, GridViewRowEventArgs e) {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0) {
                    TextBox tbMemberListAndCommitteeTermsStart = (TextBox)e.Row.FindControl("tbMemberListAndCommitteeTermsStart");
                    DateTime? dateTimeMemberListAndCommitteeTermsStart = Utils.ObjectToDateTimeNullable(GetValueFromAnonymousType<DateTime>(e.Row.DataItem, "Start"));
                    if (dateTimeMemberListAndCommitteeTermsStart.HasValue && dateTimeMemberListAndCommitteeTermsStart != Utils.SQL_MINIMUM_DATETIME) {
                        tbMemberListAndCommitteeTermsStart.Text=dateTimeMemberListAndCommitteeTermsStart.Value.ToString("MM/yyyy");
                    } else {
                        tbMemberListAndCommitteeTermsStart.Text = "";
                    }
                    TextBox tbMemberListAndCommitteeTermsEnd = (TextBox)e.Row.FindControl("tbMemberListAndCommitteeTermsEnd");
                    DateTime? dateTimeMemberListAndCommitteeTermsEnd = Utils.ObjectToDateTimeNullable(GetValueFromAnonymousType<DateTime>(e.Row.DataItem, "End"));
                    if (dateTimeMemberListAndCommitteeTermsEnd.HasValue && dateTimeMemberListAndCommitteeTermsStart != Utils.SQL_MINIMUM_DATETIME) {
                        tbMemberListAndCommitteeTermsEnd.Text=dateTimeMemberListAndCommitteeTermsEnd.Value.ToString("MM/yyyy");
                    } else {
                        tbMemberListAndCommitteeTermsEnd.Text = "";
                    }
                    DropDownList ddList = (DropDownList)e.Row.FindControl("ddlMemberListAndCommitteeTermsNames");
                    ddList.DataSource = ComRosterDataSet().Tables[1];
                    ddList.DataBind();
                    string mMemberID = Utils.ObjectToString(GetValueFromAnonymousType<int>(e.Row.DataItem, "MemberID"));
                    int index = ddList.Items.IndexOf(ddList.Items.FindByValue(mMemberID));
                    ddList.SelectedIndex = index;
                    DropDownList ddlTitle = (DropDownList)e.Row.FindControl("ddlMemberListAndCommitteeTermsTitles");
                    ddlTitle.DataSource = ComRosterDataSet().Tables[7];
                    ddlTitle.DataBind();
                    string mTitle = Utils.ObjectToString(GetValueFromAnonymousType<string>(e.Row.DataItem, "Title"));
                    int index2 = ddlTitle.Items.IndexOf(ddlTitle.Items.FindByText(mTitle));// If you want to find text by TextField.
                    ddlTitle.SelectedIndex = index2;
                    DropDownList ddlTerm = (DropDownList)e.Row.FindControl("ddlCommitteeMemberTerm");
                    string mTerm = Utils.ObjectToString(GetValueFromAnonymousType<string>(e.Row.DataItem, "Term"));
                    int index3 = ddlTerm.Items.IndexOf(ddlTerm.Items.FindByValue(mTerm));// If you want to find text by TextField.
                    ddlTerm.SelectedIndex = index3;
                } else {
                    if (((int)e.Row.RowState) == (int)DataControlRowState.Normal || ((int)e.Row.RowState) == (int)DataControlRowState.Alternate) {
                        LinkButton del = e.Row.Cells[7].Controls[0] as LinkButton;
                        del.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this committee member?');");
                        Label lblMemberListAndCommitteeTermsStart = (Label)e.Row.FindControl("lblMemberListAndCommitteeTermsStart");
                        DateTime? dateTimeMemberListAndCommitteeTermsStart = Utils.ObjectToDateTimeNullable(GetValueFromAnonymousType<DateTime>(e.Row.DataItem, "Start"));
                        if (dateTimeMemberListAndCommitteeTermsStart.HasValue && dateTimeMemberListAndCommitteeTermsStart != Utils.SQL_MINIMUM_DATETIME) {
                            lblMemberListAndCommitteeTermsStart.Text=dateTimeMemberListAndCommitteeTermsStart.Value.ToString("MM/yyyy");
                        } else {
                            lblMemberListAndCommitteeTermsStart.Text = "";
                        }
                        Label lblMemberListAndCommitteeTermsEnd = (Label)e.Row.FindControl("lblMemberListAndCommitteeTermsEnd");
                        DateTime? dateTimeMemberListAndCommitteeTermsEnd = Utils.ObjectToDateTimeNullable(GetValueFromAnonymousType<DateTime>(e.Row.DataItem, "End"));
                        if (dateTimeMemberListAndCommitteeTermsEnd.HasValue && dateTimeMemberListAndCommitteeTermsStart != Utils.SQL_MINIMUM_DATETIME) {
                            lblMemberListAndCommitteeTermsEnd.Text=dateTimeMemberListAndCommitteeTermsEnd.Value.ToString("MM/yyyy");
                        } else {
                            lblMemberListAndCommitteeTermsEnd.Text = "";
                        }
                    }
                }
            }
        }
        protected void lbMemberListAndCommitteeTermsAdd_Click(object sender, EventArgs e) {
            ddlMemberListAndCommitteeTermsNamesAdd.DataSource = ComRosterDataSet().Tables[1];
            ddlMemberListAndCommitteeTermsNamesAdd.DataBind();
            ddlMemberListAndCommitteeTermsTitlesAdd.DataSource = ComRosterDataSet().Tables[7];
            ddlMemberListAndCommitteeTermsTitlesAdd.DataBind();
            mpeNewCommitteeMember.Show();
        }
        protected void btnNewCommitteeMemberCancel_Click(object sender, EventArgs args) {
            mpeNewCommitteeMember.Hide();
        }
        protected void btnNewCommitteeMemberOk_Click(object sender, EventArgs args) {
            try {
                string memberID = ddlMemberListAndCommitteeTermsNamesAdd.SelectedItem.Value;
                string title = ddlMemberListAndCommitteeTermsTitlesAdd.SelectedValue;
                string appointed = tbCommitteeMemberAppointedNew.Text;
                string start = tbCommitteeMemberStartNew.Text;
                string end = tbCommitteeMemberEndNew.Text;
                string term = ddlCommitteeMemberTermAdd.SelectedValue;
                SqlCommand cmd = new SqlCommand("uspRosterMemberSet");
                cmd.Parameters.Add("@CommitteeID", SqlDbType.Int).Value = CommitteeIDBeingEdited;
                cmd.Parameters.Add("@MemberID", SqlDbType.Int).Value = Utils.ObjectToInt(memberID);
                cmd.Parameters.Add("@MTitle", SqlDbType.NVarChar).Value = title;
                DateTime? tAppointed = Utils.ObjectToDateTimeNullable(appointed);
                if (tAppointed.HasValue) {
                    cmd.Parameters.Add("@TAppointed", SqlDbType.DateTime).Value = tAppointed.Value;
                }
                DateTime? tEnd = Utils.ObjectToDateTimeNullable(end);
                if (tEnd.HasValue) {
                    cmd.Parameters.Add("@TEnd", SqlDbType.DateTime).Value = tEnd.Value;
                }
                DateTime? tStart = Utils.ObjectToDateTimeNullable(start);
                if (tStart.HasValue) {
                    cmd.Parameters.Add("@TStart", SqlDbType.DateTime).Value = tStart.Value;
                }
                cmd.Parameters.Add("@TTerm", SqlDbType.NVarChar).Value = term;
                SqlParameter newRosterMemberID = new SqlParameter("@NewRosterMemberID", SqlDbType.Int);
                newRosterMemberID.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(newRosterMemberID);
                Utils.executeNonQuery(cmd, ConnectionString);
                //Reset the edit index.
                gvMemberListAndCommitteeTerms.EditIndex = -1;
                MemoryCache cache = MemoryCache.Default;
                cache.Remove(DataSetCacheKey);
                bindMemberListAndCommitteeTermsGrid();
            } catch (Exception ee) {
                lblNewLiaisonMessage.Text = "Committee Member not updated. Error msg: " + ee.Message;
                mpeNewCommitteeMember.Show();
            }
            mpeNewCommitteeMember.Hide();
        }
        public static string MyMenuName = "Com Roster";
        public string MenuName {
            get { return MyMenuName; }
        }
    }
}

