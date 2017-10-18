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
                MenuItem miSubmittals = new MenuItem(Submittal2.MyMenuName, "Submittal", null, "~/Submittal2.aspx");
                MenuItem miBPermit = new MenuItem(BPermit.MyMenuName, "BPermits", null, "~/BPermit.aspx");
                MenuItem miComplianceReview = new MenuItem(ComplianceReview.MyMenuName, "Compliance Reviews", null, "~/ComplianceReview.aspx");
                MenuItem miContractors = new MenuItem(Contractor.MyMenuName, "Contractors", null, "~/Contractor.aspx");
                MenuItem miCardManagement = new MenuItem(IDCardManagement.MyMenuName, "IDCardManagement", null, "~/IDCardManagement.aspx");
                MenuItem miSellCheck = new MenuItem(SellCheck.MyMenuName, "SellCheck", null, "~/SellCheck.aspx");
                MenuItem miRVStorage = new MenuItem(RVStorage.MyMenuName, "RVStorage", null, "~/RVStorage.aspx");
                MenuItem miLRFDVehicleMaintenance = new MenuItem(LRFDVehicleMaintenance.MyMenuName, "LRFDVehicle", null, "~/LRFDVehicleMaintenance.aspx");
                MenuItem miOwnerProperty = new MenuItem(OwnerProperty.MyMenuName, "OwnProp", null, "~/OwnerProperty.aspx");
                MenuItem miItAdmin = new MenuItem("IT Admin", "ITAdmin", null, "~/ItAdmin.aspx");
                MenuItem miCitations = new MenuItem(Citations.MyMenuName, "Citations", null, "~/Citations.aspx");
                MenuItem miBallotVerify = new MenuItem(BallotVerify.MyMenuName, "BallotVerify", null, "~/BallotVerify.aspx");
                MenuItem miComRoster = new MenuItem(ComRoster_Home.MyMenuName, "ComRoster", null, "~/ComRoster_Home.aspx");
                MenuItem miOwnerConcerns = new MenuItem(OwnerConcerns.MyMenuName, "OwnerConcerns", null, "~/OwnerConcerns.aspx");
                MenuItem miSROAVehicleMaintenanceConcerns = new MenuItem(SROAVehicleMaintenance.MyMenuName, "SROAVehicle", null, "~/SROAVehicleMaintenance.aspx");
                if (HttpContext.Current.User.IsInRole("canviewsroavehiclemaintenance")) {
                    NavigationMenu.Items.AddAt(1, miSROAVehicleMaintenanceConcerns);
                }
                if (HttpContext.Current.User.IsInRole("canviewownerconcerns")) {
                    NavigationMenu.Items.AddAt(1, miOwnerConcerns);
                }
                if (HttpContext.Current.User.IsInRole("canviewcomroster")) {
                    NavigationMenu.Items.AddAt(1, miComRoster);
                }
                if (HttpContext.Current.User.IsInRole("canviewballotverify")) {
                    NavigationMenu.Items.AddAt(1, miBallotVerify);
                }
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
                if (HttpContext.Current.User.IsInRole("itadmin")) {
                    NavigationMenu.Items.AddAt(1, miItAdmin);
                }
                if (HttpContext.Current.User.IsInRole("canviewcitations")) {
                    NavigationMenu.Items.AddAt(1, miCitations);
                }
                lbPDFs.Visible=false;
                if (HttpContext.Current.User.IsInRole("canviewpdfs")) {
                    lbPDFs.Visible = true;
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
                                    lbReports.Text = "Reports/CSVs";
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
                                            } else {
                                                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("citation")) {
                                                    if (HttpContext.Current.User.IsInRole("candoreportscitations")) {
                                                        lbReports.Text = "Reports";
                                                        lbReports.Visible = true;
                                                    }
                                                } else {
                                                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("ballot")) {
                                                        if (HttpContext.Current.User.IsInRole("candoreportsballotverify")) {
                                                            lbReports.Text = "Reports";
                                                            lbReports.Visible = true;
                                                        }
                                                    } else {
                                                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("comroster_home")) {
                                                            if (HttpContext.Current.User.IsInRole("candoreportscomroster")) {
                                                                lbReports.Text = "Reports";
                                                                lbReports.Visible = true;
                                                            }
                                                        } else {
                                                            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("comroster_members")) {
                                                                if (HttpContext.Current.User.IsInRole("candoreportscommembers")) {
                                                                    /*  There are no members reports     lbReports.Text = "Reports";
                                                                           lbReports.Visible = true;*/
                                                                }
                                                            } else {
                                                                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("comroster_liaisons")) {
                                                                    if (HttpContext.Current.User.IsInRole("candoreportscomliaisons")) {
                                                                        /* there are no liaisons reports     lbReports.Text = "Reports";
                                                                             lbReports.Visible = true; */
                                                                    }
                                                                } else {
                                                                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("ownerconcerns")) {
                                                                        if (HttpContext.Current.User.IsInRole("candoreportsownerconcerns")) {
                                                                            lbReports.Text = "Reports";
                                                                            lbReports.Visible = true;
                                                                        }
                                                                    } else {
                                                                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("sroavehicle")) {
                                                                            if (HttpContext.Current.User.IsInRole("candoreportssroavehiclemaintenance")) {
                                                                                lbReports.Text = "Reports";
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
                                }
                            }
                        }
                    }
                }
            }
        }
        protected void lbPDFs_Click(object sender, EventArgs e) {
            Response.Redirect("~/PDFsPage.aspx?Type=all");
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
                                        } else {
                                            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("citation")) {
                                                Response.Redirect("~/CitationsReportsMain.aspx");
                                            } else {
                                                if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("ballot")) {
                                                    Response.Redirect("~/BallotVerifyReportsMain.aspx");
                                                } else {
                                                    if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("comroster_home")) {
                                                        Response.Redirect("~/ComRoster_HomeReportsMain.aspx");
                                                    } else {
                                                        if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("ownerconcerns")) {
                                                            Response.Redirect("~/OwnerConcernsReportsMain.aspx");
                                                        } else {
                                                            if (((SiteMaster)Master).HomePageImOnSinceMenuItemClickDoesntWork.ToLower().Contains("sroavehicle")) {
                                                                Response.Redirect("~/SROAVehicleMaintenanceReportsMain.aspx");
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
                }
            }
        }
    }
}
