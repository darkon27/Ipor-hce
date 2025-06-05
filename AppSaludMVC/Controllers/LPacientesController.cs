using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ext.Net;
using Ext.Net.MVC;
using Serilog;
 

using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service.SeguridadService;
using SoluccionSalud.Service.DiccionarioService;
 
namespace AppSaludMVC.Controllers
{
    using AppSaludMVC.Models;
    using SoluccionSalud.Service.PersonaMastService;
    using SvcDiccionario = SoluccionSalud.Service.DiccionarioService.SvcDiccionario;
    using SvcSeguridad = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto;
    using SvcVw_Personapaciente = SoluccionSalud.Service.VW_PERSONAPACIENTEService.SvcVw_Personapaciente;
    using SvcVw_AtencionPaciente = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente; 

    public class LPacientesController : System.Web.Mvc.Controller
    {

        // GET: /LPacientes/
        public System.Web.Mvc.ActionResult Index()
        {
            Log.Information("LPacientesController - Index - Entrar");
            // reciever();
            // InitConsumer();

            //inicializa();
            ENTITY_GLOBAL.Instance.PacienteID = null;

            return View();
        }
       
       
         
        public System.Web.Mvc.ActionResult SelectPaciente(String selection)
        {
            Log.Information("LPacientesController - SelectPaciente - Entrar");
            ENTITY_GLOBAL.Instance.EpisodioClinico = null;
            ENTITY_GLOBAL.Instance.EpisodioAtencion = null;
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = null;

            List<PERSONAMAST> ObjListar = (List<PERSONAMAST>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<PERSONAMAST>));
            ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].Persona;
            if (ObjListar[0].IndicadorFallecido > 0) {
                ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].IndicadorFallecido;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].IndicadorSinCorreo;
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
            } 
            return this.Direct();
        }
         
        public System.Web.Mvc.ActionResult Salvador()
        {
            Log.Information("LPacientesController - Salvador - Entrar");
            return this.Direct();
        }
        
        
        public System.Web.Mvc.ActionResult ActivaModuloHCE(string containerId)
        {
            Log.Information("LPacientesController - ActivaModuloHCE - Entrar");
            if (ENTITY_GLOBAL.Instance.PacienteID != null)
            {
               
                return this.RedirectToAction("Index", "HClinica");
            }
            else {
                X.Msg.Alert("Mensage", "Seleccione a un Paciente", new MessageBoxButtonsConfig
                {
                    Yes = new MessageBoxButtonConfig
                    {
                        //Handler = "CompanyX.MessageBox_Basic.DoYes()",
                        Text = "Aceptar"
                    } 
                }).Show();
            }

            return this.Direct();
        }

        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientes(int start, int limit, string txtHC,
            string txtFecha1, string txtFecha2, string txtHCA, string txtCodigoOA, string txtPaciente,
            string tipoConsulta)
        {
            Log.Information("LPacientesController - GrillaListadoAtencionPacientes - Entrar");
            Log.Debug("LPacientesController - GrillaListadoAtencionPacientes - start {A}, limit {B}, txtHC {C}, txtFecha1 {D} ,txtFecha2 {E}, txtHCA {F}" +
                                        ",txtCodigoOA {G}, txtPaciente {H},tipoConsulta {I}"
                                    , start,  limit,  txtHC,txtFecha1,  txtFecha2,  txtHCA,  txtCodigoOA,  txtPaciente,tipoConsulta);

            ENTITY_GLOBAL.Instance.GRUPO = "";
            //ConsultaCita();
            //var field = X.GetCmp<TextField>("txtPaciente");             
            var Listar = new List<VW_ATENCIONPACIENTE>();
            var LocalEnty = new VW_ATENCIONPACIENTE();            
            int ini = (start == 0 ? start : start + 1);
            int fin = start + limit;
            ////////////////            
            if (tipoConsulta != null)
            {
                if (tipoConsulta == "null")
                {
                    tipoConsulta = null;
                }
                else if (tipoConsulta.Trim().Length == 0)
                {
                    tipoConsulta = null;
                }            
            }
            if (txtFecha1!=null)
            {
                if (txtFecha1 == "null")
                {
                    txtFecha1 = null;
                }
                else if (txtFecha1.Trim().Length == 0)
                {
                    txtFecha1 = null;
                }  
            }
            if (txtFecha1!=null)
            {                
                txtFecha1 = txtFecha1.Replace("\"", "");
                LocalEnty.FecIniDiscamec = Convert.ToDateTime(txtFecha1);
            }
            if (txtFecha2 != null)
            {
                if (txtFecha2 == "null")
                {
                    txtFecha2 = null;
                }
                else if (txtFecha2.Trim().Length == 0)
                {
                    txtFecha2 = null;
                }
            }
            if (txtFecha2 != null)
            {
                //DateTime jj = new DateTime();                
                txtFecha2 = txtFecha2.Replace("\"", "");                
                LocalEnty.FecFinDiscamec = Convert.ToDateTime(txtFecha2);
            }
            LocalEnty.CodigoHC = ((txtHC + "").Trim().Length == 0 ? null : txtHC);
            LocalEnty.CodigoHCAnterior = ((txtHCA + "").Trim().Length == 0 ? null : txtHCA);
            LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
            LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente); 
            LocalEnty.Servicio = tipoConsulta;
            LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
            LocalEnty.Accion = "CONTARLISTAPAGSELEC";
            int cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {                
                LocalEnty.Accion = "LISTARPAGSELECPACIENTE";
                Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty,ini,fin);
            }
            //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
            //Session["ENTITY_PACIENTE"] = Listar;  
              
            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult GrillaListadoPacientes(int start, int limit, string txtHC,
            string txtFecha1,string txtFecha2,string txtHCA,string txtCodigoOA,string txtPaciente,
            string tipoConsulta)
        {
            Log.Information("LPacientesController - GrillaListadoPacientes - Entrar");
            Log.Debug("LPacientesController - GrillaListadoPacientes - start {A}, limit {B}, txtHC {C}, txtFecha1 {D} ,txtFecha2 {E}, txtHCA {F}" +
                                        ",txtCodigoOA {G}, txtPaciente {H},tipoConsulta {I}"
                                    , start, limit, txtHC, txtFecha1, txtFecha2, txtHCA, txtCodigoOA, txtPaciente, tipoConsulta);
            ENTITY_GLOBAL.Instance.GRUPO = "";
            //ConsultaCita();
            var field = X.GetCmp<TextField>("txtPaciente");
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            LocalEnty.ACCION = "LISTAR";
            LocalEnty.Estado = "";
            //LocalEnty.codi
            //LocalEnty.FecIniDiscamec = txtFecha1;


            if (ENTITY_GLOBAL.Instance.GRUPO.Length > 0) {
                var llego = "";
            } 
           // LocalEnty.NombreCompleto = txtPaciente.Trim();
            Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
           // Listar = SvcPersonaMast.GetSelectPersonaCitas(LocalEnty).ToList();
            //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
            Session["ENTITY_PACIENTE"] = Listar;
            return this.Store(Listar);
        }

        public System.Web.Mvc.ActionResult GrillaListadoPacientesActualiza()
        {
            Log.Information("LPacientesController - GrillaListadoPacientesActualiza - Entrar");

            var field = X.GetCmp<TextField>("txtPaciente");
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            LocalEnty.ACCION = "LISTAR";
            LocalEnty.Estado = "";

            // LocalEnty.NombreCompleto = txtPaciente.Trim();
            Listar = SvcPersonaMast.GetSelectPersonaCitas(LocalEnty).ToList();
            //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
            Session["ENTITY_PACIENTE"] = Listar;
            return this.Store(Listar);
        }
        public System.Web.Mvc.ActionResult PanelPacientes()
        {
            Log.Information("LPacientesController - PanelPacientes - Entrar");
            return View();
        }
    
        public static void inicializa()
        {
            Log.Information("LPacientesController - inicializa - Entrar");
            ENTITY_GLOBAL.Instance.PacienteID = null;
            var chHC = X.GetCmp<Checkbox>("chHC");
            chHC.Checked = true;
            var txtHC = X.GetCmp<TextField>("txtHC");
            txtHC.Disabled = true;
        }
        public PartialViewResult PanelNorth(string containerId)
        {
            Log.Information("LPacientesController - PanelNorth - Entrar");
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
                Model=obj
            };
        }
        public PartialViewResult PanelWest(string containerId)
        {
            Log.Information("LPacientesController - PanelWest - Entrar");
            return new PartialViewResult
            {
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }
        public PartialViewResult PanelCenter(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelCenter",
                WrapByScriptTag = false,
                ClearContainer = true,
                RenderMode = RenderMode.AddTo
            };
        }
   

        public PartialViewResult PanelCentralPacientes(string containerId)
        {
            Log.Information("LPacientesController - PanelCentralPacientes - Entrar");
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelCentralPacientes",
                WrapByScriptTag = false
            };
        }
        

        public PartialViewResult PanelEast(string containerId)
        {
            Log.Information("LPacientesController - PanelEast - Entrar");
            return new PartialViewResult
            {
                Model = ENTITY_GLOBAL.Instance,
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }

    }
}
