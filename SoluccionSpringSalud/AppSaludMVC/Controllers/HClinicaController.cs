using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
 
using Ext.Net;
using Ext.Net.MVC;
using SoluccionSalud.Entidades.Entidades;



namespace AppSaludMVC.Controllers
{
    using AppSaludMVC.Models;
    
    using SvcDiccionario = SoluccionSalud.Service.DiccionarioService.SvcDiccionario;
    using SvcSeguridad = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto;
    using SvcPersonaMast = SoluccionSalud.Service.PersonaMastService.SvcPersonaMast;
    using SvcEnfermedadActual = SoluccionSalud.Service.Formularios.SvcEnfermedadActual;
    using SvcMiscelaneos = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos;
    using SvcFormularios = SoluccionSalud.Service.FormulariosService.SvcFormularios;
    using SvcFormularioAnamnesisAP = SoluccionSalud.Service.FormulariosService.SvcFormularioAnamnesisAP;
    using SvcAnamnesisEAService = SoluccionSalud.Service.FormulariosService.SvcAnamnesisEAService;

    using SvcDiagnosticoService = SoluccionSalud.Service.FormulariosService.SvcDiagnosticoService;
    using SvcExamenFisicoTriajeService = SoluccionSalud.Service.FormulariosService.SvcExamenFisicoTriajeService;
    using SvcAnamnesisAFService = SoluccionSalud.Service.FormulariosService.SvcAnamnesisAFService;
    using SvcProblemasService = SoluccionSalud.Service.FormulariosService.SvcProblemasService;
    using SvcExamenSolicitadoService = SoluccionSalud.Service.FormulariosService.SvcExamenSolicitadoService;
    using SvcMedicamentoService = SoluccionSalud.Service.FormulariosService.SvcMedicamentoService;
    
    
using SoluccionSalud.Service.FormulariosService;
    using System.Collections;
    
    public class HClinicaController : System.Web.Mvc.Controller
    {
     
        // GET: /HClinica/
      
        public HClinicaController()
        {
        }
        #region ActioResult_Formulario_Examenes
        public System.Web.Mvc.ActionResult CCEP0306_View()
        {
            return View();
        }
        public System.Web.Mvc.ActionResult Save_Examen(SS_HC_ExamenSolicitado objAnamEA, String selectionArray1, string text)
        {
            List<MA_MiscelaneosDetalle> ObjListarActivo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray1, typeof(List<MA_MiscelaneosDetalle>));
            
            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();

            }
            else
            {
                SS_HC_ExamenSolicitado objEnt;
                string mensage = "";
                string cadenas = "";
                String[] cadArray;
                int IdEpisodioAtencionID = 0;
                foreach (MA_MiscelaneosDetalle objEntity in ObjListarActivo)
                {
                    objEnt = new SS_HC_ExamenSolicitado();
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "NUEVO") objEnt.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    objEnt.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                    objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    if (IdEpisodioAtencionID > 0) objEnt.IdEpisodioAtencion = IdEpisodioAtencionID;
                    objEnt.Fecha = objEntity.ValorFecha;
                    cadArray = objEntity.ValorCodigo2.Trim().Split('|');
                    cadenas = cadArray[1].Replace("[", "");
                    cadenas = cadenas.Replace("]", "").Trim();
                    objEnt.IdProcedimiento = Convert.ToInt32(cadenas);
                    objEnt.Observacion = objEntity.ValorCodigo3.Trim();
                    IdEpisodioAtencionID = SvcExamenSolicitadoService.setMantenimiento(objEnt);
                }
                
                if (IdEpisodioAtencionID > 0)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                    else mensage = " actualizó ";
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = (int)IdEpisodioAtencionID;
                    X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + IdEpisodioAtencionID.ToString().Trim()).Show();
                    ActivaDescativaButtonSave(true);
                }
            }
            //int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult CCEP0306_EXAMENES()
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "EXAMENES";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
        public System.Web.Mvc.ActionResult CCEP0304_MEDICAMENTOS(string VALOR)
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "EXAMENES";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo3 = "A";
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
        public System.Web.Mvc.ActionResult CCEP0307_View()
        {
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP0308_View()
        {
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP0309_View()
        {
            return View();
        }
        #endregion
        
        #region ActioResult_Formulario_ServiciosVarios
        public System.Web.Mvc.ActionResult ServiciosVarios()
        {
            //Ext.EventObject.F2
            //var  x =Ext.Net.even
            return View();
        }
        #endregion
        #region ActioResult_Formulario_Dianost_Diagnostico
        public System.Web.Mvc.ActionResult CCEP0310_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        #endregion
        #region ActioResult_Formulario_Dianost_Diagnostico
        public System.Web.Mvc.ActionResult CCEP0311_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        #endregion
        #region ActioResult_Formulario_Dianost_Valoracion
        public System.Web.Mvc.ActionResult CCEP0252_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        public System.Web.Mvc.ActionResult Save_DianosticoValoracion(String selection, string text)
        {
            List<MA_MiscelaneosDetalle> ObjListar = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<MA_MiscelaneosDetalle>));
            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();

            }
            else
            {
                int registro = -1;
                var Envio = new List<MA_MiscelaneosDetalle>();
                MA_MiscelaneosDetalle Entity;
                string cadenas = "";
                String[] cadArray;
                foreach (MA_MiscelaneosDetalle objEntity in ObjListar)
                {
                    Entity = new MA_MiscelaneosDetalle();
                    Entity = objEntity;
                    Entity.ACCION = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                    Entity.CodigoElemento = "DIAGNOSTICO";
                    Entity.CodigoTabla = ENTITY_GLOBAL.Instance.CONCEPTO.Trim();
                    Entity.AplicacionCodigo = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    Entity.ValorEntero1 = ENTITY_GLOBAL.Instance.PacienteID;
                    Entity.ValorEntero2 = ENTITY_GLOBAL.Instance.EpisodioClinico;
                    cadArray = objEntity.ValorCodigo2.Trim().Split('|');
                    cadenas = cadArray[1].Replace("[","");
                    cadenas = cadenas.Replace("]","").Trim();
                    Entity.ValorEntero4 = Convert.ToInt32(cadenas);
                    Entity.ValorEntero5 = Convert.ToInt32(objEntity.ValorCodigo3.Trim());
                    Entity.DescripcionLocal = objEntity.ValorCodigo4.Trim();

                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "NUEVO") Entity.ValorEntero3 = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    string mensage = "";
                    registro = SvcMiscelaneos.setMantenimiento(Entity);
                    if (registro > 0)
                    {
                        if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                        else mensage = " actualizó ";
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                        ENTITY_GLOBAL.Instance.FORMULARIOREGISTRO_ID = registro;
                        X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + registro.ToString().Trim()).Show();
                        ActivaDescativaButtonSave(true);
                    }

                }
             
            }
            // int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            return this.Direct();
        }
        #endregion
        #region ActioResult_Formulario_Dianost_Dianostico
        public System.Web.Mvc.ActionResult CCEP0253_DIAGNOSTICO()
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "DIAGNOSTICO";
                LocalEnty.ValorCodigo1 =  ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
       
        public System.Web.Mvc.ActionResult CCEP0253_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        #endregion
        #region ActioResult_Formulario_Problema_Dianosti_Agudo
        public System.Web.Mvc.ActionResult CCEP0202_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        public System.Web.Mvc.ActionResult Save_Problemas(SS_HC_Anamnesis_AF objAnamEA, String selectionArray1, String selectionArray2, string text)
        {
            List<MA_MiscelaneosDetalle> ObjListarActivo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray1, typeof(List<MA_MiscelaneosDetalle>));
            List<MA_MiscelaneosDetalle> ObjListarInacActivo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray2, typeof(List<MA_MiscelaneosDetalle>));
            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();

            }
            else
            {
                SS_HC_Problema objEnt;
                string mensage = "";
                string cadenas = "";
                String[] cadArray;
                int IdEpisodioAtencionID=0;
                foreach (MA_MiscelaneosDetalle objEntity in ObjListarActivo)
                {
                    objEnt = new SS_HC_Problema();
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "NUEVO") objEnt.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    objEnt.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                    objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    if (IdEpisodioAtencionID > 0) objEnt.IdEpisodioAtencion = IdEpisodioAtencionID;
                    objEnt.Fecha = objEntity.ValorFecha;
                    objEnt.TipoProblema = "A";
                    objEnt.IdTipoProblemaDiag = Convert.ToInt32(objEntity.ValorCodigo2.Trim());
                    cadArray = objEntity.ValorCodigo3.Trim().Split('|');
                    cadenas = cadArray[1].Replace("[", "");
                    cadenas = cadenas.Replace("]", "").Trim();
                    objEnt.IdDiagnostico = Convert.ToInt32(cadenas);
                    objEnt.IdControlado = Convert.ToInt32(objEntity.ValorCodigo4.Trim());
                    objEnt.Observacion = objEntity.ValorCodigo5.Trim();
                    IdEpisodioAtencionID = SvcProblemasService.setMantenimiento(objEnt);
                }
                foreach (MA_MiscelaneosDetalle objEntity in ObjListarInacActivo)
                {
                    objEnt = new SS_HC_Problema();
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "NUEVO") objEnt.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    objEnt.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                    objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    if (IdEpisodioAtencionID > 0) objEnt.IdEpisodioAtencion = IdEpisodioAtencionID;
                    objEnt.Fecha = objEntity.ValorFecha;
                    objEnt.TipoProblema = "C";
                    objEnt.IdTipoProblemaDiag = Convert.ToInt32(objEntity.ValorCodigo2.Trim());
                    cadArray = objEntity.ValorCodigo3.Trim().Split('|');
                    cadenas = cadArray[1].Replace("[", "");
                    cadenas = cadenas.Replace("]", "").Trim();
                    objEnt.IdDiagnostico = Convert.ToInt32(cadenas);
                    objEnt.IdControlado = Convert.ToInt32(objEntity.ValorCodigo4.Trim());
                    objEnt.Observacion = objEntity.ValorCodigo5.Trim();
                    IdEpisodioAtencionID = SvcProblemasService.setMantenimiento(objEnt);
                }
                if (IdEpisodioAtencionID > 0)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                    else mensage = " actualizó ";
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = (int)IdEpisodioAtencionID;
                    X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + IdEpisodioAtencionID.ToString().Trim()).Show();
                    ActivaDescativaButtonSave(true);
                } 
            }
            //int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult CCEP0202_PROBLEMASACTIVOS(string VALOR)
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "PROBLEMAS";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo3 = "A";
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
        public System.Web.Mvc.ActionResult CCEP0202_PROBLEMASINACTIVOS(string VALOR)
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "PROBLEMAS";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo3 = "C";
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
        #endregion
        #region ActioResult_Anamnesis_Triage
        public System.Web.Mvc.ActionResult Save_ExamenFisico_Triaje(SS_HC_ExamenFisico_Triaje objExamenFisicoTriaje)
        {
            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();

            }
            else
            {
                int registro = -1;
                objExamenFisicoTriaje.UnidadReplicacion = "01";
                objExamenFisicoTriaje.IdEpisodioAtencion = -1;
                objExamenFisicoTriaje.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                objExamenFisicoTriaje.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                objExamenFisicoTriaje.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                objExamenFisicoTriaje.Version = ENTITY_GLOBAL.Instance.CONCEPTO.Trim();
                if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") objExamenFisicoTriaje.IdEpisodioAtencion = -1;
                else objExamenFisicoTriaje.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                string mensage = "";
                registro = SvcExamenFisicoTriajeService.setMantenimiento(objExamenFisicoTriaje);
                if (registro > 0)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                    else mensage = " actualizó ";
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    ENTITY_GLOBAL.Instance.FORMULARIOREGISTRO_ID = registro;
                    X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + registro.ToString().Trim()).Show();
                    ActivaDescativaButtonSave(true);
                }
            }
            // int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult CCEP0102_View() //Formulario Triaje
        {
            var LocalEnty = new SS_HC_ExamenFisico_Triaje();
            var Listar = new List<SS_HC_ExamenFisico_Triaje>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.Accion = "LISTAR";
                LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcExamenFisicoTriajeService.ExamenFisicoTriajeListar(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
                if (Listar.Count > 0)
                {
                    foreach (SS_HC_ExamenFisico_Triaje objEntity in Listar)
                    {
                        LocalEnty = objEntity;
                    }
                }
            }
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View("", "", LocalEnty);
        }
        public System.Web.Mvc.ActionResult CCEP0104_View()
        {
            return View();
        }
        #endregion
        #region ActioResult_Anamnesis_AFamiliares
        public System.Web.Mvc.ActionResult CCEP0005_ANTEC_FAMILIARES()
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "ANTEC_FAMILIARES";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
        public System.Web.Mvc.ActionResult CCEP0005_View()
        {
            var LocalEnty = new SS_HC_Anamnesis_AF();
            var Listar = new List<SS_HC_Anamnesis_AF>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.Accion = "LISTAR";
                LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcAnamnesisAFService.AnamnesisAFListar(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
                if (Listar.Count > 0)
                {
                    foreach (SS_HC_Anamnesis_AF objEntity in Listar)
                    {
                        LocalEnty = objEntity;
                    }
                }
            }
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View("", "", LocalEnty);

        }
        public System.Web.Mvc.ActionResult Save_Antic_Familiares(SS_HC_Anamnesis_AF objAnamEA, String selection, string text)
        {
            List<MA_MiscelaneosDetalle> ObjListar = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<MA_MiscelaneosDetalle>));
            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();

            }
            else
            {
                
                SS_HC_Anamnesis_AF objEnt = new SS_HC_Anamnesis_AF();
                if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "NUEVO") objEnt.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                string mensage = "";
                objEnt.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objEnt.IdPaciente = (int) ENTITY_GLOBAL.Instance.PacienteID;
                objEnt.EpisodioClinico = (int) ENTITY_GLOBAL.Instance.EpisodioClinico;
                objEnt.IdTipoParentesco = ObjListar[0].ValorEntero5;
                objEnt.Edad =  ObjListar[0].ValorEntero6;
                objEnt.IdVivo = ObjListar[0].ValorEntero7;
                objEnt.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                objEnt.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                long IdEpisodioAtencionID = -1;
                IdEpisodioAtencionID = SvcAnamnesisAFService.setMantAnamnesisAF(objEnt);
                var Envio = new List<MA_MiscelaneosDetalle>();
                MA_MiscelaneosDetalle Entity;
                string cadenas = "";
                String[] cadArray;
                foreach (MA_MiscelaneosDetalle objEntity in ObjListar)
                {
                    Entity = new MA_MiscelaneosDetalle();
                    Entity = objEntity;
                    Entity.AplicacionCodigo = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    Entity.CodigoTabla = ENTITY_GLOBAL.Instance.CONCEPTO.Trim();
                    Entity.Compania = "";
                    Entity.CodigoElemento = "ANTEC_FAMILIARES";
                    Entity.ValorEntero1 = ENTITY_GLOBAL.Instance.PacienteID;
                    Entity.ValorEntero2 = ENTITY_GLOBAL.Instance.EpisodioClinico;
                    Entity.ValorEntero3 = (int) IdEpisodioAtencionID;
                    cadArray = objEntity.ValorCodigo2.Trim().Split('|');
                    cadenas = cadArray[1].Replace("[", "");
                    cadenas = cadenas.Replace("]", "").Trim();
                    Entity.ValorEntero5 = Convert.ToInt32(cadenas);
                    Entity.DescripcionLocal = objEntity.ValorCodigo3.Trim();
                    Entity.ACCION = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                    int registro;
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "NUEVO") Entity.ValorEntero3 = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    registro = SvcMiscelaneos.setMantenimiento(Entity);
                   
                }
                if (IdEpisodioAtencionID > 0)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                    else mensage = " actualizó ";
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    ENTITY_GLOBAL.Instance.FORMULARIOREGISTRO_ID = (int) IdEpisodioAtencionID;
                    X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + IdEpisodioAtencionID.ToString().Trim()).Show();
                    ActivaDescativaButtonSave(true);
                }
            }
            // int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            return this.Direct();
        }
        #endregion
        #region ActioResult_Anamnesis_AP
        public System.Web.Mvc.ActionResult CCEP0004_View()
            {
                //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
                return View();

            }
           #endregion
        #region Formulario_Anamnesis_AP_Botones
                public System.Web.Mvc.ActionResult Next_Click(int index)
                        {
                            if ((index + 1) < 8)
                            {
                                this.GetCmp<Panel>("WizardPanel").ActiveIndex = index + 1;
                                this.CheckButtons(index + 1);
                            }
                            else
                                this.CheckButtons(index);
                            return this.Direct();
                        }
                public System.Web.Mvc.ActionResult Prev_Click(int index)
                        {
                            if ((index - 1) >= 0)
                            {
                                this.GetCmp<Panel>("WizardPanel").ActiveIndex = index - 1;

                                this.CheckButtons(index - 1);
                            }
                            else
                                this.CheckButtons(index);

                            return this.Direct();
                        }
                private void CheckButtons(int index)
                        {
                            this.GetCmp<Button>("btnNext").Disabled = index == 7;
                            this.GetCmp<Button>("btnPrev").Disabled = index == 0;
                            index = index + 1;
                            this.GetCmp<Button>("txtLabel").Text = "Paginas de " + index.ToString().Trim() + " a 8"; 
                        }
                public System.Web.Mvc.ActionResult Save_SS_HC_Anamnesis_AP(SS_HC_Anamnesis_AP objAnamnesis_AP)
                {
                    if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
                    {
                        X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();

                    }
                    else
                    {
                        int registro = -1;
                        objAnamnesis_AP.UnidadReplicacion = "01";
                        objAnamnesis_AP.IdEpisodioAtencion = -1;
                        objAnamnesis_AP.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        objAnamnesis_AP.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                        string mensage = "";
                        registro = SvcFormularioAnamnesisAP.setMantAnamnesisAP(objAnamnesis_AP);
                        if (registro > 0)
                        {
                            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                            else mensage = " actualizó ";
                            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                            ENTITY_GLOBAL.Instance.FORMULARIOREGISTRO_ID = registro;
                            X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + registro.ToString().Trim()).Show();
                            ActivaDescativaButtonSave(true);
                        }
                    }
                    // int reg= svc
                    //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                    return this.Direct();
                }
                private void ActivaDescativaButtonSave(bool estado) {
                    this.GetCmp<Button>("cmdGuardar").Disabled = estado;
                }
                 #endregion
        #region ActioResult_Formulario_Medicamentos
        public System.Web.Mvc.ActionResult CCEP0304_View()
        {
           //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
          return View();
        }
        public System.Web.Mvc.ActionResult CCEP0304_MEDICAMENTO(string VALOR)
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "MEDICAMENTO";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo3 = "A";
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
        public System.Web.Mvc.ActionResult Save_Medicamentos(SS_HC_Medicamento objAnamEA, String selectionArray1, string text)
        {
            List<MA_MiscelaneosDetalle> ObjListarActivo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray1, typeof(List<MA_MiscelaneosDetalle>));
            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();
            }
            else
            {
                SS_HC_Medicamento objEnt;
                string mensage = "";
                string cadenas = "";
                String[] cadArray;
                int IdEpisodioAtencionID = 0;
                foreach (MA_MiscelaneosDetalle objEntity in ObjListarActivo)
                {
                    objEnt = new SS_HC_Medicamento();
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "NUEVO") objEnt.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    objEnt.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                    objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    if (IdEpisodioAtencionID > 0) objEnt.IdEpisodioAtencion = IdEpisodioAtencionID;
                    //objEnt.Fecha = objEntity.ValorFecha;
                    cadArray = objEntity.ValorCodigo2.Trim().Split('|');
                    cadenas = cadArray[1].Replace("[", "");
                    cadenas = cadenas.Replace("]", "").Trim();
                    objEnt.CodigoMedicamento = cadenas;
                    objEnt.IdUnidadMedida = Convert.ToInt32(objEntity.ValorCodigo3.Trim());
                    objEnt.Frecuencia   = objEntity.ValorCodigo4.Trim();
                    objEnt.IdUnidadTiempo = Convert.ToInt32(objEntity.ValorCodigo5.Trim());
                    objEnt.Cantidad = (decimal) objEntity.ValorNumerico;
                    objEnt.Tiempo = (int)objEntity.ValorEntero5;
                    IdEpisodioAtencionID = SvcMedicamentoService.setMantenimiento(objEnt);
                }
                if (IdEpisodioAtencionID > 0)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                    else mensage = " actualizó ";
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = (int)IdEpisodioAtencionID;
                    X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + IdEpisodioAtencionID.ToString().Trim()).Show();
                    ActivaDescativaButtonSave(true);
                }
            }
            //int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            return this.Direct();
        }
        #endregion
        // enfe
        #region ActioResult_Anamesis_EnfermedadActual
        public System.Web.Mvc.ActionResult CCEP0003_ENFER_ACTUAL()
        {
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
            {
                LocalEnty.ACCION = "ENFERMEDADACTUAL";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            }

            return this.Store(Listar.ToList());
        }
        #endregion
        public System.Web.Mvc.ActionResult CCEP0312_View()
       {
           return View();
       }       
        public System.Web.Mvc.ActionResult CCEP0313_View()
        {
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP0314_View()
        {
            return View();
        }
       
        public System.Web.Mvc.ActionResult DobleClicGrilla(String Name, String selection, String Mode)
        {
            SelectedRowCollection src = JSON.Deserialize<SelectedRowCollection>(selection);
            List<int> omitIds = new List<int>();
            foreach (SelectedRow row in src)
            {
                omitIds.Add(Convert.ToInt32(row.RecordID));
            }
            var values = new System.Web.Routing.RouteValueDictionary();
            values.Add("id", omitIds[0]);
            string url = string.Format("/HClinica/Index?idCodigo={0}", omitIds[0]);

            return this.PartialExtView(
                  viewName: "CCEP1051_View",
                  containerId: "dd",
                 // model: this.Session["card"],
                  mode: RenderMode.AddTo,
                  clearContainer: true
              );
          //  return this.Direct();
        }
         public System.Web.Mvc.ActionResult SelectPaciente(string selection)
         {
             ENTITY_GLOBAL.Instance.PacienteID = Convert.ToInt32(selection.Trim());
             return this.Direct();
         }
         public System.Web.Mvc.ActionResult EstadoClinico(string selection, string accion)
         {
             if (accion == "Continuar"){
                 if (ENTITY_GLOBAL.Instance.EpisodioClinico == null)
                 {
                     X.Msg.Alert("Mensajes ", "Seleccione Episodio Clínico").Show();
                 }else {
                     ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                 }
             }
             else if (accion == "Nuevo") {
                 int registro = -1;
                 SS_HC_Anamnesis_AP objAnamnesis_AP = new SS_HC_Anamnesis_AP();
                 objAnamnesis_AP.UnidadReplicacion = "01";
                 objAnamnesis_AP.IdEpisodioAtencion = -1;
                 objAnamnesis_AP.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                 objAnamnesis_AP.EpisodioClinico = 1;
                 objAnamnesis_AP.Accion = "EPISODIOCLINICO";
                 string mensage = "";
                 registro = SvcFormularioAnamnesisAP.setMantAnamnesisAP(objAnamnesis_AP);
                 if (registro > 0)
                 {
                     ENTITY_GLOBAL.Instance.EpisodioClinico = registro;
                     ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                     X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Episodio Clínico : " + registro.ToString().Trim()).Show();
                 } 
             }
             return this.Direct();
         }
         public System.Web.Mvc.ActionResult SelectClinico(string selection)
         {
             ENTITY_GLOBAL.Instance.EpisodioClinico = Convert.ToInt32(selection.Trim());
             return this.Direct();
         }
        public System.Web.Mvc.ActionResult Save_SS_HC_Anamnesis_EA(SS_HC_Anamnesis_EA objAnamnesis_EA)
        {

            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();
            }
            else {
                int registro = -1;
                objAnamnesis_EA.UnidadReplicacion = "01";
                objAnamnesis_EA.IdEpisodioAtencion = -1;
                objAnamnesis_EA.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                objAnamnesis_EA.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                objAnamnesis_EA.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                registro = SvcFormularios.setMantenimiento(objAnamnesis_EA);
                string mensage = "";
                // int reg= svc
                if (registro > 0)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                    else mensage = " actualizó ";

                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    ENTITY_GLOBAL.Instance.FORMULARIOREGISTRO_ID = registro;
                    X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + registro.ToString().Trim()).Show();
                    ActivaDescativaButtonSave(true);
                } 
            }
   

            return this.Direct();
        }

        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaaC(string valor)
        {
            this.GetCmp<GridPanel>("grillaContacto").Hidden = false;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillabC(string valor)
        {
            this.GetCmp<GridPanel>("grillaContacto").Hidden = true;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaA(string valor)
        {
           this.GetCmp<GridPanel>("grillaMed").Hidden = false;
           return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaB(string valor)
        {       
            this.GetCmp<GridPanel>("grillaMed").Hidden = true;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaAA(string valor)
        {
            this.GetCmp<GridPanel>("grillaMedRegular").Hidden = false;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaBB(string valor)
        {
            this.GetCmp<GridPanel>("grillaMedRegular").Hidden = true;
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult ActiontxtPA()
        {
            X.Msg.Notify("The Server Time is: ", DateTime.Now.ToLongTimeString()).Show();
            return this.Direct();
        }

        [DirectMethod]
        public System.Web.Mvc.ActionResult setTree()
        {

            var p = this.GetCmp<TreePanel>("TreeEast");
            p.Refresh();
            p.ClearContent();
            p.RemoveAll();
            //p.LoadContent(Url.Action("View1"));
        
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult GrillaCIE10(int start, int limit, string descript)
        {
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            LocalEnty.ACCION = "LISTARCIE10INGRESO";
            LocalEnty.Estado = "";
            LocalEnty.NombreCompleto = descript;
            return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
        }

        public System.Web.Mvc.ActionResult CCEP1051Read()
        {
            var lista = new List<MA_MiscelaneosDetalle>();
            return this.Store(lista.ToList());
        }
        public System.Web.Mvc.ActionResult CCEP0003_View()
        {
            var LocalEnty = new SS_HC_Anamnesis_EA();
            var Listar = new List<SS_HC_Anamnesis_EA>();
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE") {
                LocalEnty.Accion = "LISTAR";
                LocalEnty.IdPaciente = (int) ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                Listar = SvcAnamnesisEAService.Anamnesis_EA_Listar(LocalEnty).ToList();
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
                if (Listar.Count > 0)
                {
                    foreach (SS_HC_Anamnesis_EA objEntity in Listar)
                    {
                        LocalEnty = objEntity;
                    }
                }
            }
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View("", "", LocalEnty);
        }
  
        public System.Web.Mvc.ActionResult CCEP0302_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP0303_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }

        public System.Web.Mvc.ActionResult CCEP0305_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }

        public System.Web.Mvc.ActionResult ListadoPacienteEpisodio(int start, int limit, String Name, String selection, String Mode)
        {
              
            var field = X.GetCmp<TextField>("txtBuscar");
            var vtxtBuscar = this.GetCmp<TextField>("txtBuscar");
            var xdtDeste = this.GetCmp<DateField>("dtDeste");

            var dtDeste = this.GetCmp<DateField>("dtDeste").Text;
            var dtHasta = this.GetCmp<Button>("dtHasta").Text;


            var personaPaciente = new PERSONAMAST();
            personaPaciente.Persona = (int) ENTITY_GLOBAL.Instance.PacienteID;
            personaPaciente.ACCION = "LISTARDIAGNOSTICO";
            var list = SvcPersonaMast.GetSelectPersonaMast(personaPaciente).ToList();
            return this.Store(SvcPersonaMast.GetSelectPersonaMast(personaPaciente).ToList());
        }
        public System.Web.Mvc.ActionResult CCEP1008_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            TreePanel p = X.GetCmp<TreePanel>("TreeEast");
            p.Refresh();
            p.ClearContent();
            p.RemoveAll();
            //p.LoadContent(Url.Action("View1"));
             this.Direct();
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP1007_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP1003_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP1004_View()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        public System.Web.Mvc.ActionResult Index()
        {
            ENTITY_GLOBAL.Instance.EpisodioClinico = null;
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = null;

            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            return View();
        }
        public System.Web.Mvc.ActionResult FormView()
        {
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            var html = "Html.TextBox("+ "'Textbox1'"+", "+"'val'"+")";
            ViewBag.RenderedHtml = html;
            System.Text.StringBuilder htmlOutput = new System.Text.StringBuilder();
           
 
            RegistraPagina();

            return View("FormViewCaptura"); 
        }
        public PartialViewResult PanelWest(string containerId)
        {
            return new PartialViewResult
            {
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }
        public PartialViewResult PanelEast(string containerId)
        {
            return new PartialViewResult
            {
                Model = ENTITY_GLOBAL.Instance,
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }

        public PartialViewResult PanelNorth(string containerId)
        {
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            var objDatos = new PERSONAMAST();
            LocalEnty.ACCION = "LISTARPACIENTE";
            //LocalEnty.Estado = "";
            LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
            Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
            //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            if (Listar.Count > 0)
            {
                foreach (PERSONAMAST objPersona in Listar)
                {
                    objDatos = objPersona;
                }
            }

            return new PartialViewResult
            {
                Model = objDatos,
                ContainerId = containerId,
                ViewName = "PanelNorth",
                WrapByScriptTag = false
            };
        }

        public PartialViewResult PanelSouth(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelSouth",
                WrapByScriptTag = false
            };
        }

      
        [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
        public System.Web.Mvc.ActionResult LoadView1()
        {
            TreePanel p = X.GetCmp<TreePanel>("TreeEast");
            p.Refresh();
            //p.LoadContent(Url.Action("View1"));
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult FilterPanel(string recipienteID)
        {
            PartialViewResult pr = new PartialViewResult(recipienteID);
            pr.RenderMode = RenderMode.AddTo;
            pr.SingleControl = true;
            pr.WrapByScriptTag = true;
            return pr;
        }

        [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
        public System.Web.Mvc.ActionResult RefreshMenu()
        {
            return this.Direct(BuildTree());
        }
        public static Ext.Net.Node BuildTree()
        {
            Ext.Net.Node root = new Ext.Net.Node();
            root.Text = "Root";
            root.Expanded = true;
            string prefix = DateTime.Now.Second + "_";

            for (int i = 0; i < 1; i++)
            {
                Ext.Net.Node node = new Ext.Net.Node();
                node.Text = prefix + i;
                node.Leaf = true;
                root.Children.Add(node);
            }

            return root;
        }
        public PartialViewResult ShowProperties(SEGURIDADCONCEPTO model, String containerId)
        {
            Ext.Net.MVC.PartialViewResult partialViewResult = new Ext.Net.MVC.PartialViewResult(containerId);
            partialViewResult.RenderMode = RenderMode.AddTo;
            partialViewResult.SingleControl = true;
            partialViewResult.ContainerId = containerId;
            partialViewResult.Model = model;
            return partialViewResult;
        }
        public PartialViewResult LoadCentral(string containerId, string text)
        {
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new SEGURIDADCONCEPTO();
            string estado = "PanelCentralBlanco"; 
            objMiscl.ACCION = "TITULO_FORM";
            objMiscl.AplicacionCodigo = "CG";
            objMiscl.CodigoTabla = text.Trim();
             var resulObjMiscl = new MA_MiscelaneosDetalle();
            var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
            if (resulMiscelaneosTitulo.Count>0) {
                estado = "PanelCenter";  
                foreach ( MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo){
                    ENTITY_GLOBAL.Instance.MENUREC_CODIGO = obMa_Mis.ValorCodigo1;
                    ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = obMa_Mis.DescripcionExtranjera;
                    ENTITY_GLOBAL.Instance.GRUPO = "REG0000";
                    ENTITY_GLOBAL.Instance.NIVEL = 1;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                    ENTITY_GLOBAL.Instance.CONCEPTO = obMa_Mis.CodigoTabla;
                    model.CONCEPTO = obMa_Mis.CodigoTabla.Trim() + "_View";
                    model.DESCRIPCION = obMa_Mis.DescripcionLocal;
                    model.GRUPO = "REG0000";
                }
            }
            return new PartialViewResult
            {
                    ViewName = estado,
                    ContainerId = containerId,
                    Model = model,
                    //SingleControl = true,
                    ClearContainer = true,
                    WrapByScriptTag = true,
                    RenderMode = RenderMode.AddTo
            };
        }
        public PartialViewResult EditCentral(string selection, string text)
        {
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new SEGURIDADCONCEPTO();
            string estado = "PanelCentralBlanco";
            if (selection.Length == 0)
            {
                X.Msg.Alert("Mensage", "Seleccione registro episodio", new MessageBoxButtonsConfig
                {
                    Yes = new MessageBoxButtonConfig
                    {
                        //Handler = "CompanyX.MessageBox_Basic.DoYes()",
                        Text = "Aceptar"
                    }
                }).Show();
            }
            else
            {
                /*SelectedRowCollection src = JSON.Deserialize<SelectedRowCollection>(selection);
                List<int> omitIds = new List<int>();
                foreach (SelectedRow row in src)
                {
                    omitIds.Add(Convert.ToInt32(row.RecordID));
                }*/
                ENTITY_GLOBAL.Instance.EpisodioAtencion =  Convert.ToInt32(selection.Trim());
                objMiscl.ACCION = "CODIGO_FORM";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.ValorCodigo1 = text.Trim();
                objMiscl.ValorCodigo2 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                objMiscl.CodigoTabla = text.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    estado = "PanelCenter";
                    foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                    {
                        ENTITY_GLOBAL.Instance.MENUREC_CODIGO = obMa_Mis.ValorCodigo1;
                        ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = obMa_Mis.DescripcionExtranjera;
                        ENTITY_GLOBAL.Instance.GRUPO = "REG0000";
                        ENTITY_GLOBAL.Instance.NIVEL = 1;
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                        ENTITY_GLOBAL.Instance.CONCEPTO = obMa_Mis.CodigoTabla;
                        model.CONCEPTO = obMa_Mis.CodigoTabla.Trim() + "_View";
                        model.DESCRIPCION = obMa_Mis.DescripcionLocal;
                        model.GRUPO = "REG0000";
                    }
                }

            }
                return new PartialViewResult
                {
                    ViewName = estado,
                    ContainerId = "Center1",
                    Model = model,
                    //SingleControl = true,
                    ClearContainer = true,
                    WrapByScriptTag = true,
                    RenderMode = RenderMode.AddTo
                };

           
        }
        public class MultipleViewResult : System.Web.Mvc.ActionResult
        {
            public const string ChunkSeparator = "---|||---";
            public IList<PartialViewResult> PartialViewResults { get; private set; }
            public MultipleViewResult(params PartialViewResult[] views)
            {
                if (PartialViewResults == null)
                    PartialViewResults = new List<PartialViewResult>();
                foreach (var v in views)
                    PartialViewResults.Add(v);
            }

            public override void ExecuteResult(System.Web.Mvc.ControllerContext context)
            {
                if (context == null)
                    throw new ArgumentNullException("context");
                var total = PartialViewResults.Count;
                for (var index = 0; index < total; index++)
                {
                    var pv = PartialViewResults[index];
                    pv.ExecuteResult(context);
                    if (index < total - 1)
                        context.HttpContext.Response.Output.Write(ChunkSeparator);
                }
            }
        }

         
              /*  ClearContainer = true,
                 WrapByScriptTag = true,*/
        public System.Web.Mvc.ActionResult GetTreeView()
        {
            Node root1 = new Node();
            root1.Text = "ds";
            bool submit = true;
            for (int i = 0; i < 10; i++)
            {
                Node node = new Node();
                node.NodeID = (i + 1).ToString();
                node.Text = "Node" + (i + 1);
                node.Leaf = false;
                node.Expandable = true;
                node.Checked = true;
                node.CustomAttributes.Add(new ConfigItem("submit", JSON.Serialize(submit), ParameterMode.Raw));
                for (int j = 0; j < 3; j++)
                {
                    Node childNode = new Node();
                    childNode.NodeID = (j + 1).ToString();
                    childNode.Text = "Node" + (j + 1);
                    childNode.Leaf = true;
                    childNode.Checked = true;
                    childNode.CustomAttributes.Add(new ConfigItem("submit", JSON.Serialize(submit), ParameterMode.Raw));
                    node.Children.Add(childNode);
                    submit = !submit;
                }
                root1.Children.Add(node);
            }
            List<Ext.Net.Node> lstNode = new List<Node>();
            lstNode.Add(root1);
            return View(lstNode);
        }
        public StoreResult GetTreeChild(string node)
        {
            
            //List<Task> duetasks = service.GetAllDueTasks();

            return this.Store(null);
            /*
            Seguridad sp_stores = new Seguridad();
            List<SP_SEGURIDADCONCEPTOResult> objConcepto = new List<SP_SEGURIDADCONCEPTOResult>();
            objConcepto = sp_stores
            NodeCollection nodes = new Ext.Net.NodeCollection();
            foreach(SEGURIDADCONCEPTO conceptos in objConcepto){
                Node asyncNode = new Node();
                asyncNode.Text = conceptos.DESCRIPCION;
                asyncNode.NodeID = conceptos.CONCEPTOPADRE;
                asyncNode.Leaf = Convert.ToInt32(conceptos.TIPODEDETALLE.ToString().Trim()) == 1 ? true : false;
                nodes.Add(asyncNode);
            }
    
            return this.Store(nodes);*/
        }
        public StoreResult GetTreeViewChildRitgh(string node)
        {
            NodeCollection nodes = new Ext.Net.NodeCollection();
            var objMiscelaneos = new MA_MiscelaneosDetalle();
            if (ENTITY_GLOBAL.Instance.NIVEL == 1)
            {
                objMiscelaneos.AplicacionCodigo = "CG";
                objMiscelaneos.CodigoTabla = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;
                objMiscelaneos.CodigoElemento = ENTITY_GLOBAL.Instance.CONCEPTO;
                objMiscelaneos.ValorCodigo1 = ENTITY_GLOBAL.Instance.CONCEPTO;
                objMiscelaneos.ACCION = "NIVEL1";
                var resulListado = SvcMiscelaneos.GetUpListadoServicios(objMiscelaneos);
                foreach (var resulenti in resulListado)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = resulenti.DescripcionLocal;
                    asyncNode.NodeID = resulenti.CodigoElemento;
                    nodes.Add(asyncNode);
                }
                ENTITY_GLOBAL.Instance.NIVEL = 2;
            }
            else {
                 var p = this.GetCmp<TreePanel>("treepanel");
                 
                objMiscelaneos.AplicacionCodigo = "CG";
                objMiscelaneos.CodigoTabla = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;
                objMiscelaneos.CodigoElemento = node.Trim();
                //objMiscelaneos
                objMiscelaneos.ValorCodigo1 = ENTITY_GLOBAL.Instance.CONCEPTO;
                objMiscelaneos.ACCION = "NIVEL2";
                var resulListado = SvcMiscelaneos.GetUpListadoServicios(objMiscelaneos);
                foreach (var resulenti in resulListado)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = resulenti.DescripcionLocal;
                    asyncNode.NodeID = resulenti.CodigoElemento;
                    asyncNode.Href = "javascript:myFunction('" + resulenti.DescripcionLocal + "')";
                    asyncNode.Leaf = resulenti.ValorNumerico == 1 ? true : false;
                    nodes.Add(asyncNode);
                }
                ENTITY_GLOBAL.Instance.NIVEL = 2;
            }
      
            /*

            
            
            if (node == "0") node = ENTITY_GLOBAL.Instance.CONCEPTO;
            
            if (node == "WA")
            {
                var entidaLocal = new SEGURIDADGRUPO();
                entidaLocal.ACCION = "GRUPO";
                entidaLocal.APLICACIONCODIGO = node;
                var serviceResul = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSeguridadGrupo(entidaLocal);
                foreach (var resulenti in serviceResul)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = resulenti.DESCRIPCION;
                    asyncNode.NodeID = resulenti.GRUPO;
                    nodes.Add(asyncNode);
                }
            }
            else
            {
                var entidaLocal = new SEGURIDADCONCEPTO();
                if (node.Trim().Substring(0, 2) == "GR")
                {
                    entidaLocal.ACCION = "CONCEPTO";
                    entidaLocal.GRUPO = node.Trim();
                    var serviceResul = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSP(entidaLocal);
                    foreach (var resulenti in serviceResul)
                    {
                        Node asyncNode = new Node();
                        asyncNode.Text = resulenti.DESCRIPCION;
                        asyncNode.NodeID = resulenti.CONCEPTO;
                        
                        nodes.Add(asyncNode);
                    }
                }
                else
                {
                    if (node.Trim().Substring(0, 2) == "CC")
                        entidaLocal.ACCION = "CONCEPTOPADREHCERIGTH";
                        entidaLocal.CONCEPTOPADRE = node.Trim();
                        entidaLocal.GRUPO = ENTITY_GLOBAL.Instance.GRUPO;
                        var serviceResuls = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSP(entidaLocal);
                        foreach (var resulenti in serviceResuls)
                        {
                            Node asyncNode = new Node();
                            asyncNode.Text = resulenti.DESCRIPCION;
                            asyncNode.NodeID = resulenti.CONCEPTO;
                            asyncNode.Href = "javascript:myFunction('" + resulenti.DESCRIPCION  + "')";
                            entidaLocal.GRUPO = ENTITY_GLOBAL.Instance.GRUPO;
                            asyncNode.Leaf = Convert.ToInt32(resulenti.TIPODEOBJETO.ToString().Trim()) == 1 ? true : false;

                            nodes.Add(asyncNode);
                        }
                }
            }

            //if (ENTITY_GLOBAL.Instance.INTERUPTOR == 1)
            //{
            //    Node asyncNode = new Node();
            //    asyncNode.Text = ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION;
            //    asyncNode.NodeID = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;
            //    nodes.Add(asyncNode);
            //    ENTITY_GLOBAL.Instance.INTERUPTOR = 0;
            //}
            //else
            //{ 
            //}
            */
            return this.Store(nodes);
        }
        public StoreResult GetTreeViewChild(string node)
        {
            NodeCollection nodes = new Ext.Net.NodeCollection();
            if (node == "WA")
            {
                var entidaLocal = new SEGURIDADGRUPO();
                entidaLocal.ACCION = "GRUPO";
                entidaLocal.APLICACIONCODIGO = node;
                var serviceResul = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSeguridadGrupo(entidaLocal);
                foreach (var resulenti in serviceResul)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = resulenti.DESCRIPCION;
                    asyncNode.NodeID = resulenti.GRUPO;
                    nodes.Add(asyncNode);
                }
            }
            else
            {
                var entidaLocal = new SEGURIDADCONCEPTO();
                if (node.Trim().Substring(0, 2) == "GR")
                {
                    entidaLocal.ACCION = "CONCEPTO";
                    entidaLocal.GRUPO = node.Trim();
                    var serviceResul = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSP(entidaLocal);
                    foreach (var resulenti in serviceResul)
                    {
                        Node asyncNode = new Node();
                        asyncNode.Text = resulenti.DESCRIPCION;
                        asyncNode.NodeID = resulenti.CONCEPTO;
                        nodes.Add(asyncNode);
                    }
                }
                else
                {
                    if (node.Trim().Substring(0, 2) == "CC")
                        entidaLocal.ACCION = "CONCEPTOPADREHCE";
                    entidaLocal.CONCEPTOPADRE = node.Trim();
                    var serviceResuls = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSP(entidaLocal);
                    foreach (var resulenti in serviceResuls)
                    {
                        Node asyncNode = new Node();
                        asyncNode.Text = resulenti.DESCRIPCION;
                        asyncNode.NodeID = resulenti.CONCEPTO;
                        asyncNode.Leaf = Convert.ToInt32(resulenti.TIPODEOBJETO.ToString().Trim()) == 1 ? true : false;
                        nodes.Add(asyncNode);
                    }
                }
            }

 
            return this.Store(nodes);
        }
     
        [DirectMethod]
        public string CreateGridPanel(string path)
        {
            return "yes";
        }

        private void RegistraPagina() {

            //var path = Path.Combine(Server.MapPath("~/Views/HClinica"), "");
            //file.SaveAs(path);
            String comillas=@"""";
            System.Text.StringBuilder htmlOutput = new System.Text.StringBuilder();
            htmlOutput.Append("@model  SPRING_SALUD.Models.FormPanelEmployee|");
            htmlOutput.Append("@{|");
            htmlOutput.Append("ViewBag.Title = " + comillas + "FormEdit" + comillas + ";|");
            htmlOutput.Append("Layout = " + comillas + "~/Views/Shared/_BaseLayout.cshtml" + comillas + ";|");
            htmlOutput.Append("}|");
            htmlOutput.Append("@section cuerpo|");
            htmlOutput.Append("{|");
            htmlOutput.Append("<h1>Grid with batch saving</h1>|");
            htmlOutput.Append("@Html.Raw(ViewBag.HtmlOutput)|");
            htmlOutput.Append("}|");

            string[] Cadenas = htmlOutput.ToString().Split('|');

            var path = Path.Combine(Server.MapPath("~/Views/HClinica"), "FormViewCaptura.cshtml");
            //if (!System.IO.File.Exists(path))
            //{
                // Create a file to write to. 
                using (StreamWriter sw = System.IO.File.CreateText(path))
                {
                    foreach (var scrip in Cadenas)
                        sw.WriteLine(scrip);

                }
            //}

 
        }
        
    }
}
