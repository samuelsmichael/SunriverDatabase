using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Runtime.Caching;
using Common;

namespace SubmittalProposal {
    /// <summary>
    /// Summary description for GetPageInfo
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class GetPageInfo : System.Web.Services.WebService {

        [WebMethod]
        private bool checkingForMatch(object obj, out string hereitisthing, string whatAmIComparing) {
            string zObject = ((String)obj).ToLower();
            if (whatAmIComparing != null) whatAmIComparing = whatAmIComparing.ToLower();
            if (obj != null) {
                int indexOfColon = zObject.IndexOf(":");
                if (indexOfColon >= 0) {
                    hereitisthing = zObject.Substring(indexOfColon + 1);
                    return (Utils.isNothingNot(hereitisthing));
                }
            }
            hereitisthing = null;
            return false;
        }
        public void HeresYourData(List<String> data) {
            if (data != null) {
                if (data[0] != null) {
                    if (data.Count > 0) {
                        try {
                            string hereitis = null;
                            if (data.Count > 0) {
                                if (checkingForMatch(data[0], out hereitis, "PropertyID")) {
                                    Session["HereCommaHaveAPropertyID"] = hereitis;
                                }
                            }
                        } catch { }
                    }
                }

                if (data.Count > 1) {
                    if (data[1] != null) {
                        string hereitis2 = null;
                        try {
                            if (checkingForMatch(data[1], out hereitis2, "ClientID")) {
                                Session["HereCommaHaveAClientID"] = hereitis2;
                            }
                        } catch { }
                    }
                }
            }
        }
    }
}
