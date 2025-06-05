using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SoluccionSalud.Entidades.Entidades;

namespace AppSaludMVC.Controllers
{
    public class ErrorController : Controller
    {
        //
        // GET: /Error/

        public ActionResult Index()
        {
            if (sisSesion.ErrorManualNumero != null && sisSesion.ErrorManualNumero == "0")
            {

                return RedirectToAction("Index", "Login");
            }

            String strErrMessage="";
            String strErrManual = sisSesion.GetErrorManual(sisSesion.ErrorManualNumero + "@");
            
            String ERRORcount = sisSesion.ErrorManualDescripcion.ToString();

            if (strErrManual.Length > 0 & sisSesion.ErrorManualDescripcion != null && ERRORcount.Length > 0)
            { 
                strErrManual += " - ";
                strErrMessage = strErrManual + sisSesion.ErrorManualDescripcion;

            }
            var objModel = new HandleErrorInfo(new Exception(strErrMessage), sisSesion.VSD(sisSesion.ErrorManualController),
                                            sisSesion.VSD(sisSesion.ErrorManualAction));


            return View("Error", objModel);
        }

    }
}
