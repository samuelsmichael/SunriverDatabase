using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using System.Data.SqlClient;
using System.Data;
using System.Runtime.Caching;
using System.Configuration;
using System.Web.Security;
using System.Security.Principal;

namespace SubmittalProposal {
    public partial class MainMasterPage : System.Web.UI.MasterPage {

        public Menu getNavigationMenu() {
            return NavigationMenu;
        }

        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                MenuItem miSubmittals = new MenuItem("Submittal", "Submittal", null, "~/Submittal2.aspx");
                MenuItem miBPermit = new MenuItem("BPermits", "BPermits", null, "~/BPermit.aspx");
                MenuItem miComplianceReview = new MenuItem("Compliance Reviews", "Compliance Reviews", null, "~/ComplianceReview.aspx");
                MenuItem miContractors = new MenuItem("Contractors", "Contractors", null, "~/Contractor.aspx");
                MenuItem miCardManagement = new MenuItem("ID Card", "IDCardManagement", null, "~/IDCardManagement.aspx");
                MenuItem miSellCheck = new MenuItem("Sell Check", "SellCheck", null, "~/SellCheck.aspx");
                MenuItem miRVStorage = new MenuItem("RV Storage", "RVStorage", null, "~/RVStorage.aspx");
                MenuItem miLRFDVehicleMaintenance = new MenuItem("LRFD Vehicle", "LRFDVehicle", null, "~/LRFDVehicleMaintenance.aspx");
                MenuItem miOwnerProperty = new MenuItem("Owner/Property", "OwnProp", null, "~/OwnerProperty.aspx");
                if (HttpContext.Current.User.IsInRole("canviewcontractors")) {
                    NavigationMenu.Items.AddAt(1, miContractors);
                }
                if (HttpContext.Current.User.IsInRole("canviewcompliancereviews")) {
                    NavigationMenu.Items.AddAt(1, miComplianceReview);
                }
                if (HttpContext.Current.User.IsInRole("canviewbpermits")) {
                    NavigationMenu.Items.AddAt(1, miBPermit);
                }
                if (HttpContext.Current.User.IsInRole("canviewsubmittals")) {
                    NavigationMenu.Items.AddAt(1, miSubmittals);
                }
                if (HttpContext.Current.User.IsInRole("canviewidcard")) {
                    NavigationMenu.Items.AddAt(1, miCardManagement);
                }
                if (HttpContext.Current.User.IsInRole("canviewsellcheck")) {
                    NavigationMenu.Items.AddAt(1, miSellCheck);
                }
                if (HttpContext.Current.User.IsInRole("canviewrvstorage")) {
                    NavigationMenu.Items.AddAt(1, miRVStorage);
                }
                if (HttpContext.Current.User.IsInRole("canviewlrfdvehiclemaintenance")) {
                    NavigationMenu.Items.AddAt(1, miLRFDVehicleMaintenance);
                }
                if (HttpContext.Current.User.IsInRole("canviewownerproperty")) {
                    NavigationMenu.Items.AddAt(1, miOwnerProperty);
                }


                lbReports.Visible = false;
                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("submittal")) {
                    if (HttpContext.Current.User.IsInRole("candoreportssubmittals")) {
                        lbReports.Visible = true;
                    }
                } else {
                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("bpermit")) {
                        if (HttpContext.Current.User.IsInRole("candoreportsbpermits")) {
                            lbReports.Visible = true;
                        }
                    } else {
                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("compliance")) {
                            if (HttpContext.Current.User.IsInRole("candoreportscompliancereviews")) {
                                lbReports.Visible = true;
                            }
                        } else {
                            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("contractor")) {
                                if (HttpContext.Current.User.IsInRole("candoreportscontractors")) {
                                    lbReports.Visible = true;
                                }
                            } else {
                                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("sellcheck")) {
                                    if (HttpContext.Current.User.IsInRole("candoreportssellcheck")) {
                                        lbReports.Visible = true;
                                    }
                                } else {
                                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("rvstorage")) {
                                        if (HttpContext.Current.User.IsInRole("candoreportsrvstorage")) {
                                            lbReports.Text = "Reports/Procedures";
                                            lbReports.Visible = true;
                                        }
                                    } else {
                                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("lrfd")) {
                                            if (HttpContext.Current.User.IsInRole("candoreportslrfdvehiclemaintenance")) {
                                                lbReports.Text = "Reports/Forms";
                                                lbReports.Visible = true;
                                            }
                                        } else {
                                            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("card")) {
                                                if (HttpContext.Current.User.IsInRole("candoreportsidcard")) {
                                                    lbReports.Text = "Procedures";
                                                    lbReports.Visible = true;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void lbReports_Click(object sender, EventArgs e) {
            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("submittal")) {
                Response.Redirect("~/SubmittalReportsMain.aspx");
            } else {
                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("bpermit")) {
                    Response.Redirect("~/BPermitReportsMain.aspx");
                } else {
                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("compliancereview")) {
                        Response.Redirect("~/ComplianceReviewReportsMain.aspx");
                    } else {
                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("contractor")) {
                            Response.Redirect("~/ContractorReportsMain.aspx");
                        } else {
                            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("sellcheck")) {
                                Response.Redirect("~/SellCheckReportsMain.aspx");
                            } else {
                                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("rv")) {
                                    Response.Redirect("~/RVReportsMain.aspx");
                                } else {
                                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("lrfd")) {
                                        Response.Redirect("~/LRFDVehicleMaintenanceReportsMain.aspx");
                                    } else {
                                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("card")) {
                                            Response.Redirect("~/IDCardManagementReportsMain.aspx");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}