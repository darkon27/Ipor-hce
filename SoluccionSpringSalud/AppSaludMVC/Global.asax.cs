using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Newtonsoft.Json;

namespace AppSaludMVC
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void sRegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

            routes.MapRoute(
              "AllInvoices", // Route name
              "{controller}/{action}/{id}", // URL with parameters
              new { controller = "AllInvoices", action = "Index", id = UrlParameter.Optional } // Parameter defaults
          );

            routes.MapRoute(
            "Invoices", // Route name
            "{controller}/{action}/{id}", // URL with parameters
            new { controller = "Invoice", action = "Index", id = UrlParameter.Optional } // Parameter defaults
        );
        }
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{exclude}/{extnet}/ext.axd");

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Login", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );
            //routes.MapRoute(
            //           "LPacientes", // Route name
            //           "{controller}/{action}/{id}", // URL with parameters
            //           new { controller = "LPacientes", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            //  );

            //routes.MapRoute(
            //      "HClinica", // Route name
            //      "{controller}/{action}/{id}", // URL with parameters
            //      new { controller = "HClinica", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            //  );

  
        }

        protected void Application_Start()
        {
           
            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);

            var config = GlobalConfiguration.Configuration;
            config.Formatters.XmlFormatter.SupportedMediaTypes.Clear();

            config.IncludeErrorDetailPolicy = IncludeErrorDetailPolicy.Always;

            config.Formatters.JsonFormatter.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Serialize;
            config.Formatters.JsonFormatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;


        }
        protected void temporal_starss()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth();


        }
    }
}