using System.Web.Mvc;
using Ext.Net;
using Ext.Net.MVC;


namespace AppSaludMVC.Controllers
{
    using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
    using Microsoft.Practices.EnterpriseLibrary.Logging;
    using Serilog;

    public class ExtNetController : Controller
    {
        public ActionResult Index()
        {
            Log.Information("ExtNetController - Index");

            return null;
        }

        public ActionResult SampleAction(string message)
        {
            Log.Information("ExtNetController - SampleAction");
            X.Msg.Notify(new NotificationConfig
            {
                Icon = Icon.Accept,
                Title = "Working",
                Html = message
            }).Show();

            return this.Direct();
        }
    }
}