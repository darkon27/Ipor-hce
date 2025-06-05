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
    public class TemporalController : Controller
    {
        //
        // GET: /Temporal/

        public ActionResult Index()
        {
            Log.Information("TemporalController - Index");
            return View();
        }

    }
}
