using Serilog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppSaludMVC.Controllers
{
    public class CrystalImageHandlerController : Controller
    {
        //
        // GET: /Reports/CrystalImageHandler.aspx

        public ActionResult Index()
        {
            Log.Information("CrystalImageHandlerController - Index - Entrar");
            return Content("");
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            Log.Information("CrystalImageHandlerController - IndeOnActionExecutedx - Entrar");
            var handler = new CrystalDecisions.Web.CrystalImageHandler();
            var app = (HttpApplication)filterContext.RequestContext.HttpContext.GetService(typeof(HttpApplication));
            if (app == null) return;

            handler.ProcessRequest(app.Context);

        }
    }
}
