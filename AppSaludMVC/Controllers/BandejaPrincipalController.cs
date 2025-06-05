using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ext.Net;
using Ext.Net.MVC;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service.SeguridadService;
using SoluccionSalud.Service.DiccionarioService;
using Serilog;

namespace AppSaludMVC.Controllers
{
    using SvcVw_Personapaciente = SoluccionSalud.Service.VW_PERSONAPACIENTEService.SvcVw_Personapaciente;
    public class BandejaPrincipalController : System.Web.Mvc.Controller
    {
        //
        // GET: /BandejaPrincipal/

        public System.Web.Mvc.ActionResult Index()
        {
            Log.Information("Entra BandejaPrincipalController - Index ");

            return View();
        }

        public PartialViewResult PanelNorth(string containerId)
        {
            Log.Information("Entra BandejaPrincipalController - PanelNorth ");
            Log.Debug("BandejaPrincipalController - PanelNorth - containerId {A}", containerId);
            ////OBTENER DATOS DE LA PERSONA-MEDICO-USUARIO
            List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            obj.ACCION = "LISTARPORID";
            lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, 0, 0);
            if (lista.Count == 1)
            {
                foreach (var result in lista)
                {
                    obj = result;
                }
            }
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelNorth",
                WrapByScriptTag = false,
                Model = obj
            };
        }

        public PartialViewResult PanelWest(string containerId)
        {
            Log.Information("Entra BandejaPrincipalController - PanelWest ");
            Log.Debug("BandejaPrincipalController - PanelWest - containerId {A}", containerId);

            ////OBTENER DATOS DE LA PERSONA-MEDICO-USUARIO
            List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            obj.ACCION = "LISTARPORID";
            lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, 0, 0);
            if (lista.Count == 1)
            {
                foreach (var result in lista)
                {
                    obj = result;
                }
            }
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelWest",
                WrapByScriptTag = false,
                Model = obj
            };
        }
        
    }
}
