using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Common;
using System.Runtime.Caching;

namespace SubmittalProposal {
    public partial class ITAdmin : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                lblRunSomeProcedureStatus.Text = "";
            }
        }

        protected void lbRunSomeProcedure_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = null;
                SqlConnection conn = null;
                cmd = new SqlCommand("somestoredprocedure", conn);
                /*
                 * If you had parameters, then for each one you would do this:
                 * cmd.Parameters.Add("@AParameter", SqlDbType.VarChar).Value = ATextBox.Text;
                */
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["RVStorageQLConnectionString"].ConnectionString);
                lblRunSomeProcedureStatus.Text = "Successful";
            } catch (Exception e) {
                lblRunSomeProcedureStatus.Text = "Failed. Msg: " + e.Message;
            }
        }
        protected void lbInitializeBallotVerify_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspBallotVerifyInitialize");
                Utils.executeNonQuery(cmd, BallotVerify.ConnectionString);
                
                lblInitializeBallotVerifyCommentsResult.ForeColor = System.Drawing.Color.Green;
                lblInitializeBallotVerifyCommentsResult.Text = "Ballot Verify table has been initialized";
            } catch (Exception e) {
                lblInitializeBallotVerifyCommentsResult.ForeColor = System.Drawing.Color.Red;
                lblInitializeBallotVerifyCommentsResult.Text = "Error. Msg: "+e.Message;
            }
        }
        protected void lbCardMaintenanceClearComments_Click(object sender, EventArgs args) {
            try {
                SqlCommand cmd = new SqlCommand("uspClearComments");
                Utils.executeNonQuery(cmd, System.Configuration.ConfigurationManager.ConnectionStrings["IDCardManagementSQLConnectionString"].ConnectionString);
                lblIdCardMaintenanceClearCommentsResult.ForeColor = System.Drawing.Color.Green;
                lblInitializeBallotVerifyCommentsResult.Text = "The Ballot Verify table has been initialized";
            } catch (Exception e) {
                lblIdCardMaintenanceClearCommentsResult.ForeColor = System.Drawing.Color.Red;
                lblIdCardMaintenanceClearCommentsResult.Text = "Error. Msg: " + e.Message;
            }
        }
        protected void lbPastDue_Click(object sender, EventArgs e) {
            Response.Redirect("~/Reports/RVPastDue.aspx");
        }
        protected void lbCrossReference_Click(object sender, EventArgs args) {
            /*
             * If you had parameters then you could store them is the Session variable before 
             * the Response.Redirect.  Example:  Session["AnyName"]=ATextBox.Text.  See
            */
            Response.Redirect("~/Query_CrossReference3.aspx");
        }
        protected void lbSecurityMaintenance_Click(object sender, EventArgs args) {
            Response.Redirect("~/SecurityMaintenance.aspx");
        }

        protected void btnClearCache_Click(object sender, EventArgs e) {
            MemoryCache.Default.Dispose();
            /*
            using (MemoryCache mc=MemoryCache.Default) {
                mc.Remove(BallotVerify.DataSetCacheKey);
                mc.Remove(BPermit.BPERMIT_CACHE_GRID_KEY);
                mc.Remove(BPermit.BPERMIT_CACHE_KEY);
                mc.Remove(LRFDVehicleMaintenance.LRFD_SurchargeRate_CACHE_KEY);
                mc.Remove(LRFDVehicleMaintenance.LRFD_VEHICLE_MAINTENANCE_CACHE_KEY);
                mc.Remove(Citations.DataSetCacheKey);
                mc.Remove(ComplianceReview.DataSetCacheKey);
                mc.Remove(ComRoster_Liaisons.DataSetCacheKey);
                mc.Remove(ComRoster_Members.DataSetCacheKey);
                mc.Remove(Contractor.DataSetCacheKey);
                mc.Remove(OwnerConcerns.DataSetCacheKey);
                mc.Remove(RVStorage.DataSetCacheKey);
                mc.Remove(SellCheck.DataSetCacheKey);
                mc.Remove(SROAVehicleMaintenance.SROA_SurchargeRate_CACHE_KEY);
                mc.Remove(SROAVehicleMaintenance.SROA_VEHICLE_MAINTENANCE_CACHE_KEY);
                mc.Remove(Submittal2.SUBMITTAL_CACHE_KEY);
                mc.Remove();
                mc.Remove();
                mc.Remove();
            }
             */
        }
    }
}