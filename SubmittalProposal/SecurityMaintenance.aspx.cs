using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Common;
using System.Web.Security;

namespace SubmittalProposal {
    public partial class SecurityMaintenance : System.Web.UI.Page {
        private static int UPDATEUSERNAMECOLUMN = 4;
        private static int UPDATEEMAILCOLUMN = 5;
        private string ConnectionString {
            get {
                return System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            }
        }
        protected void Page_Load(object sender, EventArgs e) {
            if(!IsPostBack) {
                bindUserGrid();
                bindRollGrid();
            }
        }
        private void bindUserGrid() {
            DataSet ds = Utils.getDataSetFromQuery("SELECT * FROM aspnet_Users u inner join aspnet_Membership m on u.UserId=m.UserId ORDER BY UserName", ConnectionString);
            gvUsers.DataSource = ds;
            gvUsers.DataBind();
        }
        private void bindRollGrid() {
            DataSet ds = Utils.getDataSetFromQuery("SELECT * FROM aspnet_Roles ORDER BY RoleName",ConnectionString);
            gvRolls.DataSource = ds;
            gvRolls.DataBind();
        }
        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) {
            gvUsers.EditIndex = -1;
            bindUserGrid();
            lbAddUser.Visible = true;
            pnlListRoles.Visible = false;
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e) {
            lblSecurityUserResults.Text = "";
            gvUsers.EditIndex = e.NewEditIndex;
            bindUserGrid();
            lbAddUser.Visible = false;

            String[] roles=Roles.GetAllRoles();
            cbListRoles.DataSource = roles;
            cbListRoles.DataBind();
            GridViewRow row = gvUsers.Rows[e.NewEditIndex];
            string userName = ((TextBox)(row.Cells[UPDATEUSERNAMECOLUMN].Controls[0])).Text;

            foreach (string roleName in Roles.GetRolesForUser(userName)) {
                foreach (ListItem role in cbListRoles.Items) {
                    if (role.Value == roleName) {
                        role.Selected = true;
                    }
                }
            }
            pnlListRoles.Visible = true;
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            Guid user = (Guid)e.Keys[0];
            MembershipUser u = Membership.GetUser(user);
            deleteUser(user,u.UserName);
            bindUserGrid();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e) {
            Guid user=(Guid)e.Keys[0];
            if (updateUser(user, e.RowIndex) == 0) {
                gvUsers.EditIndex = -1;
                bindUserGrid();
                lbAddUser.Visible = true;
            }
            pnlListRoles.Visible = false;
        }
        protected int updateUser(Guid key, int rowNbr) {
            GridViewRow row = gvUsers.Rows[rowNbr];
            string userName = ((TextBox)(row.Cells[UPDATEUSERNAMECOLUMN].Controls[0])).Text;
            string userEmail = ((TextBox)(row.Cells[UPDATEEMAILCOLUMN].Controls[0])).Text;
            MembershipUser u1 = Membership.GetUser(userName);
            if (u1!=null && !u1.ProviderUserKey.Equals(key)) {
                lblSecurityUserResults.ForeColor = System.Drawing.Color.Red;
                lblSecurityUserResults.Text = "This user name "+userName+" already exists";
                return 1;
            }

            SqlCommand cmd = new SqlCommand("UPDATE aspnet_Users SET UserName=@UserName, LoweredUserName=@LoweredUserName, LastActivityDate=@LastActivityDate where UserId=@UserId");
            cmd.Parameters.Add("@UserId",SqlDbType.UniqueIdentifier).Value=key;
            cmd.Parameters.Add("@UserName",SqlDbType.NVarChar,255).Value=userName;
            cmd.Parameters.Add("@LoweredUserName", SqlDbType.NVarChar, 255).Value = userName.ToLower();
            cmd.Parameters.Add("@LastActivityDate", SqlDbType.DateTime).Value = DateTime.Now;
            Utils.executeNonQuery(cmd, ConnectionString,CommandType.Text);

            MembershipUser u = Membership.GetUser(key);
            u.Email = userEmail;
            Membership.Provider.UpdateUser(u);
            foreach (string role in getArrayOfAllRoles()) {
                try {
                    Roles.RemoveUserFromRole(u.UserName, role);
                } catch { }
            }
            foreach (string role in getArrayOfSelectedRoles()) {
            Roles.AddUserToRole(u.UserName,role);
            }
            return 0;
        }
        private string[] getArrayOfSelectedRoles() {
            List<string> roles = new List<string>();
            foreach (ListItem liRole in cbListRoles.Items) {
                if (liRole.Selected) {
                    roles.Add((string)liRole.Value);
                }
            }
            return (string[])roles.ToArray<string>();
        }
        private string[] getArrayOfAllRoles() {
            List<string> roles = new List<string>();
            foreach (ListItem liRole in cbListRoles.Items) {
                roles.Add((string)liRole.Value);
            }
            return (string[])roles.ToArray<string>();
        }
        protected void deleteUser(Guid key, string userName) {
            SqlCommand cmd = new SqlCommand("DELETE FROM aspnet_UsersInRoles WHERE UserId=@UserId");
            cmd.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier, 16).Value = key;
            Utils.executeNonQuery(cmd, ConnectionString, CommandType.Text);
            cmd = new SqlCommand("DELETE FROM aspnet_Membership WHERE UserId=@UserId");
            cmd.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier, 16).Value = key;
            Utils.executeNonQuery(cmd, ConnectionString, CommandType.Text);
            cmd = new SqlCommand("DELETE FROM aspnet_Users WHERE UserId=@UserId");
            cmd.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier, 16).Value = key;
            Utils.executeNonQuery(cmd, ConnectionString, CommandType.Text);
            lblSecurityUserResults.ForeColor = System.Drawing.Color.Green;
            lblSecurityUserResults.Text = "Successfully deleted user " + userName;
            bindUserGrid();
        }

        protected void lbAddUser_Click(object sender, EventArgs e) {
            lblSecurityUserResults.Text = "";
            mpeNewSecurityUser.Show();
        }
        protected void btnNewSecurityUserOk_Click(object sender, EventArgs args) {
            MembershipCreateStatus mcs;
            try {
                Membership.Provider.CreateUser(
                    tbSecurityNewUserName.Text.Trim(),
	                tbSecurityNewUserPassword.Text.Trim(),
                    tbSecurityNewUserEmail.Text.Trim(),
	                null,
                	null,
                	true,//bool isApproved,
	                null,//Object providerUserKey,
	                out mcs
                );
                if (mcs == MembershipCreateStatus.Success) {
                    lblSecurityUserResults.ForeColor = System.Drawing.Color.Green;
                    lblSecurityUserResults.Text = "User "+tbSecurityNewUserName.Text+" added.";
                    bindUserGrid();
                    tbSecurityNewUserEmail.Text = "";
                    tbSecurityNewUserName.Text = "";
                    tbSecurityNewUserPassword.Text = "";
                    mpeNewSecurityUser.Hide();
                } else {
                    throw new Exception("Failed creating user: " + mcs.ToString());
                }
            } catch (Exception e) {
                lblSecurityNewUserResults.Text = "Error.  Msg: " + e.Message;
                mpeNewSecurityUser.Show();
            }
        }
        protected void btnNewSecurityUserCancel_Click(object sender, EventArgs args) {
            tbSecurityNewUserEmail.Text = "";
            tbSecurityNewUserName.Text = "";
            tbSecurityNewUserPassword.Text = "";
            mpeNewSecurityUser.Hide();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e) {
            lblSecurityUserResults.Text = "";
            if (e.CommandName == "ChangePassword") {
                GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                int RowIndex = gvr.RowIndex;
                Guid guid=(Guid)gvUsers.DataKeys[RowIndex].Value;
                Session["GuidOfUserWhosePasswordWereChanging"] = guid;
                MembershipUser u = Membership.GetUser(guid);
                lblNameOfUserWhosePasswordWereChanging.Text = u.UserName;
                mpeChangePassword.Show();
            }
        }
        protected void btnNewPasswordOkay_Click(object sender, EventArgs args) {
            try {
                string newPassword = tbNewPassword.Text;
                MembershipUser u2 = Membership.GetUser(Session["GuidOfUserWhosePasswordWereChanging"]);
                u2.ChangePassword(u2.ResetPassword(), newPassword);
                tbNewPassword.Text = "";
                lblNewPasswordMessage.Text = "";
                lblSecurityUserResults.ForeColor = System.Drawing.Color.Green;
                lblSecurityUserResults.Text = u2.UserName + "'s password changed successfully";
                lblNameOfUserWhosePasswordWereChanging.Text = "";
                mpeChangePassword.Hide();
                
            } catch (Exception e) {
               
                lblNewPasswordMessage.Text = "Error. Msg: " + e.Message;
                mpeChangePassword.Show();
            }
        }
        protected void btnNewPasswordCancel_Click(object sender, EventArgs args) {
            tbNewPassword.Text = "";
            lblNewPasswordMessage.Text = "";
            lblNameOfUserWhosePasswordWereChanging.Text = "";
            mpeChangePassword.Hide();
        }
        protected void gvRolls_RowDeleting(object sender, GridViewDeleteEventArgs e) {
            String roleName = Utils.ObjectToString(e.Keys[0]);
            try {                
                string[] usersInRoll=Roles.GetUsersInRole(roleName);
                if (usersInRoll.Length > 0) {
                    throw new Exception("Cannot delete a roll that has users assigned (" + Utils.arrayToString(usersInRoll) + ")");
                }
                Roles.DeleteRole(roleName);
                lblSecurityRoleResults.ForeColor = System.Drawing.Color.Green;
                lblSecurityRoleResults.Text = "Role "+roleName+" deleted";
                bindRollGrid();
            } catch (Exception ex) {
                lblSecurityRoleResults.ForeColor = System.Drawing.Color.Red;
                lblSecurityRoleResults.Text = "Role "+roleName+" not deleted. Msg: " + ex.Message;
            }
        }

        protected void lbAddRoll_Click(object sender, EventArgs args) {
            lblSecurityRoleResults.Text = "";
            mpeNewSecurityRole.Show();
        }
        protected void btnNewSecurityRoleOk_Click(object sender, EventArgs e) {
            string newRoleName = tbSecurityNewRoleName.Text.Trim();

            if (!Roles.RoleExists(newRoleName)) {
                Roles.CreateRole(newRoleName);
            }
            tbSecurityNewRoleName.Text = string.Empty;
            bindRollGrid();
            lblSecurityRoleResults.ForeColor = System.Drawing.Color.Green;
            lblSecurityRoleResults.Text = "Role "+newRoleName+" Added";
        }
        protected void btnNewSecurityRoleCancel_Click(object sender, EventArgs e) {
            tbSecurityNewRoleName.Text = "";
            mpeNewSecurityRole.Hide();
        }

        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e) {
            gvUsers.PageIndex = e.NewPageIndex;
            bindUserGrid(); 
        }

    }
}