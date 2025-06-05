using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SoluccionSalud.Entidades.Entidades;
using System.Web.Mvc;
using Ext.Net;

namespace AppSaludMVC.Controllers
{
    using SvcReglasServicios = SoluccionSalud.Service.ReglasServicios.SvcReglasServicios;
    public class LoginController : Controller
    {
        //
        // GET: /Login/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Login(string txtUsername, string txtPassword)
        {
             var BE_Global = new ENTITY_GLOBAL();
             Session["ENTITY_GLOBAL"] = BE_Global;
            ENTITY_GLOBAL.Instance.APLICATIVOID = 1;
            ENTITY_GLOBAL.Instance.USUARIO = txtUsername.Trim();
            ENTITY_GLOBAL.Instance.UnidadReplicacion = "01";
            ENTITY_GLOBAL.Instance.NIVEL = 0;
            ENTITY_GLOBAL.Instance.MODULO = "HCE";
            ENTITY_GLOBAL objENTITY_GLOBAL = ENTITY_GLOBAL.Instance;
            // Do some Authentication...
            // Then user send to application    
            ComboBox p = X.GetCmp<ComboBox>("cbModulos");
            //ModelCliente obj = new ModelCliente();
            //obj.setTotalPrice(40);
            //string valor = SvcReglasServicios.getReglas(obj);
            string irmodulo ;
            if (p.Value.ToString().Trim() == "HCE") irmodulo = "LPacientes";
            else irmodulo = "Gestion";
                //p.LoadContent(Url.Action("View1"));
                //return this.Direct();
            
            return this.RedirectToAction("Index", irmodulo);
           // return this.RedirectToAction("Index", "HClinica");
        }
    }
}
