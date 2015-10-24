using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Runtime.Caching;

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
        public void HeresYourData(List<string> data) {
            foreach (string datum in data) {
                string datumx = datum;
                Session["valueselectedbyfind"] = datumx;
                Session["byebye"] = "yes";
            }
        }
    }
}
