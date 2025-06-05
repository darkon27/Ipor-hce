using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppSaludMVC.Controllers
{
    using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
    using Microsoft.Practices.EnterpriseLibrary.Logging;
    using Serilog;
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            Log.Information("HomeController - Index");
            ViewBag.Message = "Modify this template to jump-start your ASP.NET MVC application.";

            return View();
        }

        public ActionResult About()
        {
            Log.Information("HomeController - About");
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            Log.Information("HomeController - Contact");
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}
