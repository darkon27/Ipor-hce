using System.Web.Mvc;
using Ext.Net;
using Ext.Net.MVC;


namespace AppSaludMVC.Controllers
{
    public class ExtNetController : Controller
    {
        public ActionResult Index()
        {


            return null;
        }

        public ActionResult SampleAction(string message)
        {
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