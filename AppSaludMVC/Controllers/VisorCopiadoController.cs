
using Ext.Net;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service._FormularioNuevo;
using SoluccionSalud.Service.EpisodioAtencionService;
using SoluccionSalud.Service.EpisodioClinicoService;
using SoluccionSalud.Service.MiscelaneosService;
using SoluccionSalud.Service.ParametroService;
using SoluccionSalud.Service.SeguridadConceptoService;
using SoluccionSalud.Service.V_EpisodioAtencionesService;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Serilog;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Threading;
using SoluccionSalud.Service.AuditoriaService;
using Microsoft.Win32;
using WebGrease.Activities;


namespace AppSaludMVC.Controllers
{
    public class VisorCopiadoController : Controller
    {
        //
        // GET: /VisorCopiado/
        int IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult setSessionData(String ID)
        {
            Log.Information("VisorCopiadoController - setSessionData");
            Log.Debug("ID {A} ", ID);
            string[] data = ID.Split('|');
            String ioA = data[0].ToString();
            String linea = data[1].ToString();
            String unidadreplicacion = data[2].ToString();

            /* VALIDAR OA HC */
            ENTITY_GLOBAL.Instance.TipoCopiado = 2;
            ENTITY_GLOBAL.Instance.IdOrdenAtecionCopiado = ioA;
            ENTITY_GLOBAL.Instance.LineaCopiado = linea;
            ENTITY_GLOBAL.Instance.UnidadReplicacionCopiado = unidadreplicacion;

            SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
            epiAtencionSave.IdOrdenAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.IdOrdenAtecionCopiado);
            epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacionCopiado;
            epiAtencionSave.LineaOrdenAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.LineaCopiado);
            epiAtencionSave.IdPersonalSalud = null;
            epiAtencionSave.IdPaciente = IdPaciente;
            epiAtencionSave.TipoAtencion = 1;
            epiAtencionSave.Accion = "LISTAR";
            epiAtencionSave.EpisodioClinico = 0;
            epiAtencionSave.EpisodioAtencion = 0;
            epiAtencionSave.Estado = 2;
            List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);

            if (listaEpi.Count == 0)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }


            return Json(1, JsonRequestBehavior.AllowGet);
        }

        public JsonResult getEspecialidad()
        {
            Log.Information("VisorCopiadoController - getEspecialidad");
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            LocalEnty.ACCION = "COMBOSGENERICOS";
            LocalEnty.AplicacionCodigo = "CG";
            LocalEnty.ValorCodigo5 = "ENFEMER";
            LocalEnty.CodigoTabla = "ESPECIALI";
            return Json(Listar, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult JsonSend(SS_HC_EpisodioAtencion epiAtencionSave)
        {
            Log.Information("VisorCopiadoController - JsonSend");
            Log.Debug("SS_HC_EpisodioAtencion {A} ", epiAtencionSave);
            epiAtencionSave.IdPersonalSalud = null;
            epiAtencionSave.IdPaciente = IdPaciente;
            epiAtencionSave.TipoAtencion = 1;
            epiAtencionSave.Accion = "LISTAR";
            epiAtencionSave.EpisodioClinico = 0;
            epiAtencionSave.EpisodioAtencion = 0;
            epiAtencionSave.Estado = 2;

            if (ENTITY_GLOBAL.Instance.TipoCopiado == 2)
            {
                epiAtencionSave.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.IdOrdenAtecionCopiado);
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacionCopiado;
                epiAtencionSave.LineaOrdenAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.LineaCopiado);
            }

            List<SS_HC_EpisodioAtencion> listaJson = new List<SS_HC_EpisodioAtencion>();
            List<V_EpisodioAtenciones> listaresponse = new List<V_EpisodioAtenciones>();
            DataTable listarV_EpisodioAtencion = new DataTable();
            List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);

            listarV_EpisodioAtencion = rptV_EpisodioAtenciones("V_EpisodioAtenciones", (int)ENTITY_GLOBAL.Instance.PacienteID, Convert.ToInt32(ENTITY_GLOBAL.Instance.IdOrdenAtecionCopiado), Convert.ToInt32(ENTITY_GLOBAL.Instance.LineaCopiado));
            var convertedList = (from rw in listarV_EpisodioAtencion.AsEnumerable()
                                 select new V_EpisodioAtenciones()
                                 {
                                     IdPaciente = Convert.ToInt32(rw["IdPaciente"]),
                                     IdEpisodioAtencion = Convert.ToInt32(rw["IdEpisodioAtencion"]),
                                     EpisodioClinico = Convert.ToInt32(rw["EpisodioClinico"]),
                                     Formato_Codigo = Convert.ToString(rw["Formato_Codigo"]),
                                     UnidadReplicacion = Convert.ToString(rw["UnidadReplicacion"])
                                 }).ToList();

            var listaepi = convertedList.Where(x => x.EpisodioClinico == 224).ToList();
            var listaDiagnostico = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEP0F90").ToList();
            var lstEnfermedadActual = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF001").ToList();
            var lstfuncionesvitales = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF051").ToList();
            var lstexamenesclinicos = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF153").ToList();
            var lstreceta = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF101").ToList();
            var lstexamenesdeapoyo = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF150").ToList();
            var lista = lstreceta.Where(x => x.EpisodioClinico == 224).ToList();

            foreach (var item in listaEpi)
            {
                SS_HC_EpisodioAtencion obj = new SS_HC_EpisodioAtencion();
                SS_HC_Diagnostico_FE objDiag = new SS_HC_Diagnostico_FE();

                DateTime time = (DateTime)item.FechaAtencion;
                var hora = time.TimeOfDay;

                objDiag.UnidadReplicacion = item.UnidadReplicacion;
                objDiag.IdPaciente = item.IdPaciente;
                objDiag.IdEpisodioAtencion = item.IdEpisodioAtencion;
                objDiag.EpisodioClinico = item.EpisodioClinico;

                int countDiagnostico = listaDiagnostico.Count(t =>
                     t.UnidadReplicacion == item.UnidadReplicacion &&
                     t.IdPaciente == item.IdPaciente &&
                     t.IdEpisodioAtencion == item.IdEpisodioAtencion &&
                     t.EpisodioClinico == item.EpisodioClinico &&
                     t.UnidadReplicacion == item.UnidadReplicacion
                     );

                obj.flagDiagnosticoCount = countDiagnostico;

                //ANAMNESIS 

                int countEnfermedad = lstEnfermedadActual.Count(t =>
                t.UnidadReplicacion == item.UnidadReplicacion &&
                t.IdPaciente == item.IdPaciente &&
                t.IdEpisodioAtencion == item.IdEpisodioAtencion &&
                t.EpisodioClinico == item.EpisodioClinico &&
                t.UnidadReplicacion == item.UnidadReplicacion
                );

                int coutnexamenesclinicos = lstexamenesclinicos.Count(t =>
                     t.UnidadReplicacion == item.UnidadReplicacion &&
                     t.IdPaciente == item.IdPaciente &&
                     t.IdEpisodioAtencion == item.IdEpisodioAtencion &&
                     t.EpisodioClinico == item.EpisodioClinico &&
                     t.UnidadReplicacion == item.UnidadReplicacion
                     );

                int countFuncionesvitales = lstfuncionesvitales.Count(t =>
                   t.UnidadReplicacion == item.UnidadReplicacion &&
                   t.IdPaciente == item.IdPaciente &&
                   t.IdEpisodioAtencion == item.IdEpisodioAtencion &&
                   t.EpisodioClinico == item.EpisodioClinico &&
                   t.UnidadReplicacion == item.UnidadReplicacion
                   );


                if (countEnfermedad >= 1 || coutnexamenesclinicos >= 1 || countFuncionesvitales >= 1)
                {
                    obj.flagAnamnesisCount = 1;
                }
                else
                {
                    obj.flagAnamnesisCount = 0;
                }


                int coutnreceta = lstreceta.Count(t =>
                t.UnidadReplicacion == item.UnidadReplicacion &&
                t.IdPaciente == item.IdPaciente &&
                t.IdEpisodioAtencion == item.IdEpisodioAtencion &&
                t.EpisodioClinico == item.EpisodioClinico &&
                t.UnidadReplicacion == item.UnidadReplicacion
                );
                obj.flagRecetaCount = coutnreceta;

                int countplantrabajo = lstexamenesdeapoyo.Count(t =>
                  t.UnidadReplicacion == item.UnidadReplicacion &&
                  t.IdPaciente == item.IdPaciente &&
                  t.IdEpisodioAtencion == item.IdEpisodioAtencion &&
                  t.EpisodioClinico == item.EpisodioClinico &&
                  t.UnidadReplicacion == item.UnidadReplicacion
                  );
                obj.flagPlanTrabajoCount = countplantrabajo;

                var date = DateTime.Now.ToString("hh:mm");
                obj.UnidadReplicacion = item.UnidadReplicacion;
                obj.FechaRegistroString = time.ToString("dd/MM/yyyy");
                obj.HoraString = time.ToString("hh:mm");
                obj.CodigoOA = item.CodigoOA;
                obj.ObservacionFirma = item.ObservacionFirma;
                obj.ObservacionOrden = item.ObservacionOrden;
                obj.flag_valor_concatenado = item.IdOrdenAtencion + "|" + item.LineaOrdenAtencion + "|"
                    + item.CodigoOA + "|" + item.IdEpisodioAtencion + "|" + item.EpisodioClinico + "|" + obj.flagAnamnesisCount + "|" + obj.flagDiagnosticoCount + "|" + obj.flagRecetaCount + "|" + obj.flagPlanTrabajoCount;

                listaJson.Add(obj);
            }
            var query = listaJson.AsQueryable();
            return Json(new { data = listaJson });
        }

        public int getCountExist(String formato, SS_HC_Diagnostico_FE item)
        {
            Log.Information("VisorCopiadoController - getCountExist");
            Log.Debug("formato {A} , SS_HC_Diagnostico_FE {B}", formato, item);
            int returnIntValue = 0;

            if (formato == "ANAMNESIS")
            {

            }
            else if (formato == "DIAGNOSTICO")
            {
                //returnIntValue = SvcDiagnosticoFE.getCountDiagnostico(item);
            }
            else if (formato == "PLANTRABAJO")
            {

            }

            return returnIntValue;
        }

        public ActionResult Json()
        {
            Log.Information("VisorCopiadoController - Json");
            SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
            DataTable listarV_EpisodioAtencion = new DataTable();

            //epiAtencionSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
            epiAtencionSave.IdPersonalSalud = null;
            epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            epiAtencionSave.IdPaciente = IdPaciente;
            epiAtencionSave.CodigoOA = null;
            epiAtencionSave.TipoAtencion = 1;
            epiAtencionSave.Accion = "LISTAR";
            epiAtencionSave.EpisodioClinico = 0;
            epiAtencionSave.EpisodioAtencion = 0;
            epiAtencionSave.Estado = 2;

            if (ENTITY_GLOBAL.Instance.TipoCopiado == 2)
            {
                epiAtencionSave.IdOrdenAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.IdOrdenAtecionCopiado);
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacionCopiado;
                epiAtencionSave.LineaOrdenAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.LineaCopiado);
            }

            List<SS_HC_EpisodioAtencion> listaJson = new List<SS_HC_EpisodioAtencion>();
            List<V_EpisodioAtenciones> listaresponse = new List<V_EpisodioAtenciones>();
            List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);


            listarV_EpisodioAtencion = rptV_EpisodioAtenciones("V_EpisodioAtenciones", (int)ENTITY_GLOBAL.Instance.PacienteID, Convert.ToInt32(ENTITY_GLOBAL.Instance.IdOrdenAtecionCopiado), Convert.ToInt32(ENTITY_GLOBAL.Instance.LineaCopiado));

            var convertedList = (from rw in listarV_EpisodioAtencion.AsEnumerable()
                                 select new V_EpisodioAtenciones()
                                 {
                                     IdPaciente = Convert.ToInt32(rw["IdPaciente"]),
                                     IdEpisodioAtencion = Convert.ToInt32(rw["Episodio_Atencion"]),
                                     EpisodioClinico = Convert.ToInt32(rw["EpisodioClinico"]),
                                     Formato_Codigo = Convert.ToString(rw["Formato_Codigo"]),
                                     UnidadReplicacion = Convert.ToString(rw["UnidadReplicacion"]),
                                     IdOrdenAtencion = Convert.ToInt32(rw["IdOrdenAtencion"]),
                                     LineaOrdenAtencion = Convert.ToInt32(rw["LineaOrdenAtencion"]),
                                     Descripcion001 = Convert.ToString(rw["Descripcion001"])
                                 }
                                 ).ToList();

            var listaDiagnostico = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEP0F90").ToList();
            var lstEnfermedadActual = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF001").ToList();
            var lstfuncionesvitales = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF051").ToList();
            var lstexamenesclinicos = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF153").ToList();
            var lstreceta = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF101").ToList();
            var lstexamenesdeapoyo = convertedList.Where(x => x.Formato_Codigo.Trim() == "CCEPF150").ToList();

            foreach (var item in listaEpi)
            {
                SS_HC_EpisodioAtencion obj = new SS_HC_EpisodioAtencion();
                SS_HC_Diagnostico_FE objDiag = new SS_HC_Diagnostico_FE();

                DateTime time = (DateTime)item.FechaAtencion;
                var hora = time.TimeOfDay;

                objDiag.UnidadReplicacion = item.UnidadReplicacion;
                objDiag.IdPaciente = item.IdPaciente;
                objDiag.IdEpisodioAtencion = item.IdEpisodioAtencion;
                objDiag.EpisodioClinico = item.EpisodioClinico;

                ENTITY_GLOBAL.Instance.IdEpisodioAtencionCopiado = item.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.EpisodioClinicoCopiado = item.EpisodioClinico;

                int countDiagnostico = listaDiagnostico.Count(t =>
                     t.UnidadReplicacion == item.UnidadReplicacion && t.IdPaciente == item.IdPaciente &&
                     t.IdEpisodioAtencion == item.EpisodioAtencion && t.EpisodioClinico == item.EpisodioClinico
                     );

                obj.flagDiagnosticoCount = countDiagnostico;

                //ANAMNESIS
                int countEnfermedad = lstEnfermedadActual.Count(t =>
                t.UnidadReplicacion == item.UnidadReplicacion && t.IdPaciente == item.IdPaciente &&
                t.IdEpisodioAtencion == item.EpisodioAtencion && t.EpisodioClinico == item.EpisodioClinico
                );

                int coutnexamenesclinicos = lstexamenesclinicos.Count(t =>
                     t.UnidadReplicacion == item.UnidadReplicacion && t.IdPaciente == item.IdPaciente &&
                     t.IdEpisodioAtencion == item.EpisodioAtencion && t.EpisodioClinico == item.EpisodioClinico
                     );

                int countFuncionesvitales = lstfuncionesvitales.Count(t =>
                   t.UnidadReplicacion == item.UnidadReplicacion && t.IdPaciente == item.IdPaciente &&
                   t.IdEpisodioAtencion == item.EpisodioAtencion && t.EpisodioClinico == item.EpisodioClinico
                   );

                if (countEnfermedad >= 1 || coutnexamenesclinicos >= 1 || countFuncionesvitales >= 1)
                {
                    obj.flagAnamnesisCount = 1;
                }
                else
                {
                    obj.flagAnamnesisCount = 0;
                }

                int coutnreceta = lstreceta.Count(t =>
                t.UnidadReplicacion == item.UnidadReplicacion && t.IdPaciente == item.IdPaciente &&
                t.IdEpisodioAtencion == item.EpisodioAtencion && t.EpisodioClinico == item.EpisodioClinico
                );
                obj.flagRecetaCount = coutnreceta;

                int countplantrabajo = lstexamenesdeapoyo.Count(t =>
                  t.UnidadReplicacion == item.UnidadReplicacion && t.IdPaciente == item.IdPaciente &&
                  t.IdEpisodioAtencion == item.EpisodioAtencion && t.EpisodioClinico == item.EpisodioClinico
                  );

                obj.flagPlanTrabajoCount = countplantrabajo;

                var date = DateTime.Now.ToString("hh:mm");
                obj.UnidadReplicacion = item.UnidadReplicacion;
                obj.FechaRegistroString = time.ToString("dd/MM/yyyy");
                obj.HoraString = time.ToString("hh:mm");
                obj.CodigoOA = item.CodigoOA;
                obj.ObservacionFirma = item.ObservacionFirma;
                obj.ObservacionOrden = item.ObservacionOrden;
                obj.flag_valor_concatenado = item.IdOrdenAtencion + "|" + item.LineaOrdenAtencion + "|"
                    + item.CodigoOA + "|" + item.IdEpisodioAtencion + "|" + item.EpisodioClinico + "|" + obj.flagAnamnesisCount + "|" + obj.flagDiagnosticoCount + "|" + obj.flagRecetaCount + "|" + obj.flagPlanTrabajoCount;

                listaJson.Add(obj);
            }
            var query = listaJson.AsQueryable();
            return Json(new { data = listaJson });
        }

        public int validarSeleccion(List<SS_HC_EpisodioAtencion> lista, int PrimerOrden)
        {

            foreach (var item in lista)
            {
                if (item.IdOrdenAtencion != PrimerOrden)
                {
                    return 1;
                }
            }

            return 0;
        }

        public int validar(List<SS_HC_EpisodioAtencion> lista, int PrimerOrden)
        {
            foreach (var item in lista)
            {
                if (item.IdOrdenAtencion != PrimerOrden)
                {
                    return 1;
                }
            }

            return 0;
        }

        public int validarDiagnostico(List<SS_HC_EpisodioAtencion> lista, bool flatdiagnostico)
        {
            foreach (var item in lista)
            {
                if (item.flagDiagnostico)
                {
                    if (item.flagReceta == false)
                    {
                        return 1;
                    }

                    if (item.flagPlanTrabajo == false)
                    {
                        return 2;
                    }
                }
            }
            return 0;
        }

        public int validarReceta(List<SS_HC_EpisodioAtencion> lista, bool flatreceta)
        {
            //if (flatreceta)
            //{
            foreach (var item in lista)
            {
                if (item.flagReceta)
                {
                    if (item.flagDiagnostico == false)
                    {
                        return 1;
                    }

                    if (item.flagPlanTrabajo == false)
                    {
                        return 2;
                    }
                }
            }
            //}

            return 0;

        }

        public int validarPlanTrabajo(List<SS_HC_EpisodioAtencion> lista, bool flatplantra)
        {
            foreach (var item in lista)
            {
                if (item.flagPlanTrabajo)
                {
                    if (item.flagDiagnostico == false)
                    {
                        return 1;
                    }

                    if (item.flagReceta == false)
                    {
                        return 2;
                    }
                }
            }
            return 0;
        }

        public JsonResult ArmarJson(SS_HC_EpisodioAtencion data)
        {
            Log.Information("VisorCopiadoController - ArmarJson");
            Log.Debug("SS_HC_EpisodioAtencion {A} ", data);
            ENTITY_GLOBAL.Instance.intentosCopiadoVisor = 0;
            bool flagError = false;
            //ENTITY_GLOBAL.Instance.intentosCopiadoVisor= ENTITY_GLOBAL.Instance.intentosCopiadoVisor+1;
            ENTITY_GLOBAL.Instance.listaCopiados.Clear();
            String mensajeMostrar;
            String selectedItems = data.json;
            List<SS_HC_EpisodioAtencion> items = (new JavaScriptSerializer()).Deserialize<List<SS_HC_EpisodioAtencion>>(selectedItems);
            var listaOdden = items.OrderByDescending(x => x.flagFormato).ToList();
            V_EpisodioAtenciones copiados = new V_EpisodioAtenciones();

            bool flagAnamnesis = false;
            bool flagDiagnostico = false;
            bool flagPlanTrabajo = false;
            bool flagReceta = false;

            foreach (var item in listaOdden)
            {
                data.IdOrdenAtencion = item.IdOrdenAtencion;
                data.IdEpisodioAtencion = item.IdEpisodioAtencion;
                data.EpisodioClinico = item.EpisodioClinico;
                data.UnidadReplicacion = item.UnidadReplicacion;
                flagAnamnesis = item.flagAnamnesis;
                flagDiagnostico = item.flagDiagnostico;
                flagPlanTrabajo = item.flagPlanTrabajo;
                flagReceta = item.flagReceta;
            }

            int avv = 0;

            int Diag = 1;
            int Anam = 1;
            int Plan = 1;
            int Rece = 1;

            SS_HC_EpisodioAtencionFormato objFiltro = new SS_HC_EpisodioAtencionFormato();
            objFiltro.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objFiltro.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objFiltro.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
            objFiltro.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            objFiltro.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
            objFiltro.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            objFiltro.FechaCreacion = DateTime.Now;
            objFiltro.FechaModificacion = DateTime.Now;

            if (flagDiagnostico == true)
            {
                avv = SaveDiagnostico(data);

                //avv = 0;
                if (avv <= 0)
                {
                    flagError = true;
                    Diag = avv;
                    objFiltro.ConceptoFormulario = "CCEP0F90";
                    string msg = Newtonsoft.Json.JsonConvert.SerializeObject(objFiltro);
                    Boolean rrr = MirthIngresoMantenimiento("Formato/MantenimientoEpisodioAtencionFormato", msg);
                }
            }

            if (flagPlanTrabajo == true)
            {
                avv = SavePlanTrabajo(data);
                //avv = 0;
                if (avv <= 0)
                {
                    flagError = true;
                    Plan = avv;
                    objFiltro.ConceptoFormulario = "CCEPF150";
                    string msg = Newtonsoft.Json.JsonConvert.SerializeObject(objFiltro);
                    Boolean rrr = MirthIngresoMantenimiento("Formato/MantenimientoEpisodioAtencionFormato", msg);
                }
            }

            if (flagAnamnesis == true)
            {
                avv = SaveAnamnesis(data);
                //avv = 0;
                if (avv == 0)
                {
                    flagError = true;
                    Anam = avv;
                    string msg = "";
                    Boolean rrr = false;
                    objFiltro.ConceptoFormulario = "CCEPF001";
                    msg = Newtonsoft.Json.JsonConvert.SerializeObject(objFiltro);
                    rrr = MirthIngresoMantenimiento("Formato/MantenimientoEpisodioAtencionFormato", msg);
                }
            }

            if (flagReceta == true)
            {//validacion si se agrega el medicamento 
                avv = SaveReceta(data);
                //avv = 1;
                if (avv <= 0)
                {
                    flagError = true;
                    Rece = avv;
                    objFiltro.ConceptoFormulario = "CCEPF101";
                    string msg = Newtonsoft.Json.JsonConvert.SerializeObject(objFiltro);
                    Boolean rrr = MirthIngresoMantenimiento("Formato/MantenimientoEpisodioAtencionFormato", msg);
                }
            }

            mensajeMostrar = "";
            if (!flagError)
            {
                mensajeMostrar = "El copiado se realizó satisfactoriamente..";
                ENTITY_GLOBAL.Instance.intentosCopiadoVisor = 0;
                this.RedirectToAction("Index", "Login");
            }
            else
            {
                mensajeMostrar = "El copiado se realizó satisfactoriamente.., presione ACEPTAR para proceder con la migración, por favor espere:";
                if (Diag <= 0)
                {
                    //throw new Exception("No copió Diagnóstico");
                    //SS_HC_Diagnostico_FE obj = new SS_HC_Diagnostico_FE();
                    //avv = SaveDiagnosticoXXX(obj);
                    mensajeMostrar = mensajeMostrar + "\nDiagnóstico";
                }
                if (Plan <= 0)
                {

                    mensajeMostrar = mensajeMostrar + "\nPlan de Trabajo";
                }

                if (Anam <= 0)
                {

                    mensajeMostrar = mensajeMostrar + "\nAnamnesis";
                }

                if (Rece <= 0)
                {

                    mensajeMostrar = mensajeMostrar + "\nReceta";
                }
                if (ENTITY_GLOBAL.Instance.intentosCopiadoVisor == 3)
                {
                    mensajeMostrar = "El copiado se realizó satisfactoriamente..,Se acabó el número de intentos";
                    ENTITY_GLOBAL.Instance.intentosCopiadoVisor = 0;
                    this.RedirectToAction("Index", "Login");
                }
            }

            var response = new dataJsonArmado(mensajeMostrar, Diag, Anam, Plan, Rece);

            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public class dataJsonArmado
        {
            public dataJsonArmado()
            {
            }

            public dataJsonArmado(string mensajeMostrar, int? Diag, int? Anam, int? Plan, int? Rece)
            {
                this.mensajeMostrar = mensajeMostrar;
                this.Diag = Diag;
                this.Anam = Anam;
                this.Plan = Plan;
                this.Rece = Rece;
            }
            public string mensajeMostrar { get; set; }
            public int? Diag { get; set; }
            public int? Anam { get; set; }
            public int? Plan { get; set; }
            public int? Rece { get; set; }
            //public string json {  get; set; }
        }

        public JsonResult ArmarJsonErrorContinuar(dataJsonArmado data)
        {

                Log.Debug("VisorCopiado - ArmarJsonErrorContinuar - intento: {A}", ENTITY_GLOBAL.Instance.intentosCopiadoVisor + 1);
            Log.Debug("VisorCopiado - ArmarJsonErrorContinuar - Data: {A}", data);

            //leer data
            //String selectedItems = data.json;
            //dataJsonArmado item = (new JavaScriptSerializer()).Deserialize<dataJsonArmado>(data);
            //Se reintenta mandar
            ENTITY_GLOBAL.Instance.intentosCopiadoVisor = ENTITY_GLOBAL.Instance.intentosCopiadoVisor + 1;

            int Diagaux = 1;
            int Anamaux = 1;
            int Planaux = 1;
            int Receaux = 1;

            //varibales de mensajes
            var mensajeD = "";
            var mensajeA = "";
            var mensajeP = "";
            var mensajeR = "";

            var mensajeMostrar = "";

            if (data.Diag <= 0)
            {
                //throw new Exception("No copió Diagnóstico");
                //SS_HC_Diagnostico_FE obj = new SS_HC_Diagnostico_FE();
                var avv = SaveDiagnosticoXXX();
                if (avv <= 0)
                {
                    Diagaux = 0;
                    mensajeD = "Diagnóstico";
                }

            }
            if (data.Plan <= 0)
            {
                var avv = SavePlanTrabajoXXX();
                if (avv <= 0)
                {
                    Planaux = 0;
                    mensajeP = "Plan de Trabajo";
                }
            }

            if (data.Anam <= 0)
            {

                var avv = SaveAnamnesisXXX();
                if (avv <= 0)
                {
                    Anamaux = 0;
                    mensajeA = "Anamnesis";
                }
            }

            if (data.Rece <= 0)
            {
                var avv = SaveRecetaXXX();
                if (avv <= 0)
                {
                    Receaux = 0;
                    mensajeR = "Receta";
                }
            }

            if (ENTITY_GLOBAL.Instance.intentosCopiadoVisor == 3)
            {
                //mensajeMostrar = "No se pudo realizar la migración al spring.";

                //if (Receaux <= 0 || Planaux <= 0 || Diagaux <= 0 || Anamaux <= 0)
                //{
                //    mensajeMostrar = "No se pudo realizar la migración al spring: ";
                //    mensajeMostrar = mensajeMostrar + "\n" + mensajeD + "\n" + mensajeA +
                //        "\n" + mensajeP + "\n" + mensajeR;
                //}
                //else
                //{
                //    mensajeMostrar = "El copiado se realizó satisfactoriamente.";
                //    //ENTITY_GLOBAL.Instance.intentosCopiadoVisor = 0;
                   
                //    // this.RedirectToAction("Index", "Login");
                //}

                mensajeMostrar = "El copiado se realizó satisfactoriamente..,Se acabó el número de intentos";

                ENTITY_GLOBAL.Instance.intentosCopiadoVisor = 0;
                this.RedirectToAction("Index", "Login");
                var response02 = new dataJsonArmado(mensajeMostrar, Diagaux, Anamaux, Planaux, Receaux);
                return Json(response02, JsonRequestBehavior.AllowGet);
            }

            //verificamos si existe error o no para intentar de nuevo:

            if (Receaux <= 0 || Planaux <= 0 || Diagaux <= 0 || Anamaux <= 0)
            {
                mensajeMostrar = "El copiado se realizó satisfactoriamente.., oprima ACEPTAR para proceder con la migración, por favor espere:";
                mensajeMostrar = mensajeMostrar + "\n" + mensajeD + "\n" + mensajeA +
                    "\n" + mensajeP + "\n" + mensajeR;
            }
            else
            {
                mensajeMostrar = "El copiado se realizó satisfactoriamente..";
                ENTITY_GLOBAL.Instance.intentosCopiadoVisor = 0;
                this.RedirectToAction("Index", "Login");
            }

            var response = new dataJsonArmado(mensajeMostrar, Diagaux, Anamaux, Planaux, Receaux);


            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public int SaveAnamnesis(SS_HC_EpisodioAtencion data)
        {
            Log.Information("VisorCopiadoController - SaveAnamnesis");
            Log.Debug("SS_HC_EpisodioAtencion {A} ", data);
            var registroEnfermedad = 0;
            var registrofunciones = 0;
            var registro = 0;
            int rrr = 0;
            try
            {
                #region ListAndSaveEnfermedadActual
                /// AÑADIR ENFERMEDAD ACTUAL

                SS_HC_EnfermedadActual_FE request = new SS_HC_EnfermedadActual_FE();
                request.UnidadReplicacion = data.UnidadReplicacion;
                request.IdPaciente = IdPaciente;
                request.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? data.IdEpisodioAtencion : 1;
                request.EpisodioClinico = data.EpisodioClinico;
                var response = SvcFuncionesVitalesFEService.getDataEnfermedadActual(request);

                var lstdetresponse = SvcFuncionesVitalesFEService.getDataEnfermedadActualDetalle(request);
                if (response == null && lstdetresponse.Count > 0)
                {

                }
                else
                {
                    if (response != null)
                    {
                        response.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        response.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        response.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                        response.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        response.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        response.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        response.FechaCreacion = DateTime.Now;
                        response.FechaModificacion = DateTime.Now;
                        registroEnfermedad = SvcEnfermedadActualServiceFE.setMantenimientoCopia(response, lstdetresponse);
                    }
                }

                #endregion

                #region ListAndSaveFuncionesVitales
                /// AÑADIR FUNCIONES VITALES
                /// 
                SS_HC_FuncionesVitales_FE objSavefunciones = new SS_HC_FuncionesVitales_FE();
                objSavefunciones.UnidadReplicacion = data.UnidadReplicacion;
                objSavefunciones.IdPaciente = IdPaciente;
                objSavefunciones.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? data.IdEpisodioAtencion : 1;
                objSavefunciones.EpisodioClinico = data.EpisodioClinico;
                objSavefunciones = SvcFuncionesVitalesFEService.getdataFunciones(objSavefunciones);

                if (objSavefunciones != null)
                {
                    objSavefunciones.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objSavefunciones.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    objSavefunciones.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    objSavefunciones.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    objSavefunciones.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objSavefunciones.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objSavefunciones.FechaCreacion = DateTime.Now;
                    objSavefunciones.FechaModificacion = DateTime.Now;
                    registrofunciones = SvcFuncionesVitalesFEService.setMantenimientoCopia(objSavefunciones);
                }
                #endregion

                #region ListAndSaveExamenClincio
                /// AÑADIR EXAMEN CLINICO
                List<SS_HC_ExamenClinico_FE> listaExamenesClinicos = new List<SS_HC_ExamenClinico_FE>();
                SS_HC_ExamenClinico_FE LocalEnty = new SS_HC_ExamenClinico_FE();
                LocalEnty.IdPaciente = IdPaciente;
                LocalEnty.EpisodioClinico = data.EpisodioClinico;
                LocalEnty.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? data.IdEpisodioAtencion : 1;
                LocalEnty.UnidadReplicacion = data.UnidadReplicacion;

                listaExamenesClinicos = SvcExamenClinicoServiceFE.ExamenClinicoListar(LocalEnty).ToList();
                foreach (var item in listaExamenesClinicos)
                {
                    SS_HC_ExamenClinico_FE objSaveExamenClinico = new SS_HC_ExamenClinico_FE();
                    objSaveExamenClinico = item;
                    objSaveExamenClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objSaveExamenClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    objSaveExamenClinico.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    objSaveExamenClinico.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    objSaveExamenClinico.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objSaveExamenClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objSaveExamenClinico.FechaCreacion = DateTime.Now;
                    objSaveExamenClinico.FechaModificacion = DateTime.Now;
                    registro = SvcExamenClinicoServiceFE.setMantenimientoCopia(objSaveExamenClinico);
                }
                #endregion
                rrr = registro + registrofunciones + registroEnfermedad;
                if (rrr > 0)
                {
                    rrr = SaveAnamnesisXXX();
                }
                return Convert.ToInt32(rrr);
            }
            catch (Exception ex)
            {
                Log.Debug("SS_HC_EpisodioAtencion {A} ", Newtonsoft.Json.JsonConvert.SerializeObject(ex));
                return 0;
            }
        }

        public int SaveAnamnesisXXX()
        {
            #region ListHCE

            List<SS_HC_ExamenClinico_FE> listaExamenesClinicosHCE = new List<SS_HC_ExamenClinico_FE>();
            SS_HC_ExamenClinico_FE LocalHCE = new SS_HC_ExamenClinico_FE();
            LocalHCE.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            LocalHCE.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
            LocalHCE.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            LocalHCE.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            listaExamenesClinicosHCE = SvcExamenClinicoServiceFE.ExamenClinicoListar(LocalHCE).ToList();

            SS_HC_FuncionesVitales_FE objfuncionesHCE = new SS_HC_FuncionesVitales_FE();
            objfuncionesHCE.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objfuncionesHCE.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
            objfuncionesHCE.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            objfuncionesHCE.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objfuncionesHCE = SvcFuncionesVitalesFEService.getdataFunciones(objfuncionesHCE);

            var LocalEnfermedadAct = new SS_HC_EnfermedadActual_FE();
            var ListarEnfermedadAct = new List<SS_HC_EnfermedadActual_FE>();
            LocalEnfermedadAct.Accion = "LISTAR";
            LocalEnfermedadAct.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnfermedadAct.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            LocalEnfermedadAct.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            LocalEnfermedadAct.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            ListarEnfermedadAct = SvcEnfermedadActualServiceFE.ApoyoCabecera_Listar(LocalEnfermedadAct).ToList();


            #endregion

            int rest = 0;
            SS_IT_SaludAnamnesisIngreso EntyMIrth = new SS_IT_SaludAnamnesisIngreso();
            EntyMIrth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            EntyMIrth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
            EntyMIrth.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
            EntyMIrth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            EntyMIrth.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            EntyMIrth.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            EntyMIrth.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
            EntyMIrth.FechaCreacion = DateTime.Now;
            EntyMIrth.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            EntyMIrth.FechaModificacion = DateTime.Now;
            EntyMIrth.Estado = 2;
            if (objfuncionesHCE != null)
            {
                EntyMIrth.PresionArterialMSD1 = objfuncionesHCE.PresionArterialMSD1.ToString();
                EntyMIrth.PresionArterialMSD2 = objfuncionesHCE.PresionArterialMSD2;
                EntyMIrth.PresionArterialMSI1 = objfuncionesHCE.PresionArterialMSI.ToString();
                EntyMIrth.PresionArterialMSI2 = objfuncionesHCE.PresionArterialMS2.ToString();
                EntyMIrth.FrecuenciaCardiaca = objfuncionesHCE.FrecuenciaCardiaca.ToString();
                EntyMIrth.FrecuenciaRespiratoria = objfuncionesHCE.FrecuenciaRespiratoria;
                EntyMIrth.Temperatura = objfuncionesHCE.Temperatura.ToString();
                EntyMIrth.SaturacionOxigeno = objfuncionesHCE.SaturacionOxigeno;
                EntyMIrth.Peso = objfuncionesHCE.Peso.ToString();
                EntyMIrth.Talla = objfuncionesHCE.Talla.ToString();
                rest = 1;
            }

            if (ListarEnfermedadAct.Count > 0)
            {
                foreach (SS_HC_EnfermedadActual_FE ObjTraceEnfermedad in ListarEnfermedadAct)
                {                   
                    EntyMIrth.RelatoCronologico = ObjTraceEnfermedad.RelatoCronologico;

                    if (ObjTraceEnfermedad.TiempoEnfermedadUnidad == "1")
                    {
                        EntyMIrth.TiempoEnfermedadUnidad = "Horas";
                    }
                    if (ObjTraceEnfermedad.TiempoEnfermedadUnidad == "2")
                    {
                        EntyMIrth.TiempoEnfermedadUnidad = "Dias";
                    }
                    if (ObjTraceEnfermedad.TiempoEnfermedadUnidad == "3")
                    {
                        EntyMIrth.TiempoEnfermedadUnidad = "Semanas";
                    }
                    if (ObjTraceEnfermedad.TiempoEnfermedadUnidad == "4")
                    {
                        EntyMIrth.TiempoEnfermedadUnidad = "Meses";
                    }
                    if (ObjTraceEnfermedad.TiempoEnfermedadUnidad == "5")
                    {
                        EntyMIrth.TiempoEnfermedadUnidad = "Años";
                    }
                    EntyMIrth.TiempoEnfermedad = ObjTraceEnfermedad.TiempoEnfermedad.ToString() + " " + EntyMIrth.TiempoEnfermedadUnidad;
                    rest = 2;
                }
            }

            if (listaExamenesClinicosHCE.Count > 0)
            {
                foreach (SS_HC_ExamenClinico_FE ObjTraceExamenCli in listaExamenesClinicosHCE)
                {
                    EntyMIrth.EXAMENCLINICOOBS = ObjTraceExamenCli.Observacion;
                    rest = 3;
                }
            }
            Boolean rrr = false;
            if (rest > 0)
            {
                string msg = Newtonsoft.Json.JsonConvert.SerializeObject(EntyMIrth);
                rrr = MirthIngresoMantenimiento("Mirth/Mirth_SaludAnamnesisIngresoMantenimiento", msg);
            }
            return Convert.ToInt32(rrr);
        }

        public int SaveRecetaXXX()
        {
            List<SS_HC_Medicamento_FE> listaCopia = new List<SS_HC_Medicamento_FE>();

            List<SS_IT_SaludRecetaIngreso> ListaMirth = new List<SS_IT_SaludRecetaIngreso>();
            listaCopia = new List<SS_HC_Medicamento_FE>();
            SS_HC_Medicamento_FE objEnt = new SS_HC_Medicamento_FE();
            objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objEnt.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            objEnt.TipoMedicamento = 1;
            objEnt.Accion = "LISTAR";
            listaCopia = SvcMedicamentoFE.MedicamentoListar(objEnt);
            var objListaAnt3 = new List<SS_HC_Medicamento_FE>();
            objEnt.TipoMedicamento = 4;
            objListaAnt3 = SvcMedicamentoFE.MedicamentoListar(objEnt);

            listaCopia.AddRange(objListaAnt3);
            Log.Debug(DateTime.Now + " MedicamentoListar listaCopia Cantidad   ", listaCopia.Count);

            foreach (SS_HC_Medicamento_FE ObjTrace in listaCopia)
            {
                SS_IT_SaludRecetaIngreso EntyMIrth = new SS_IT_SaludRecetaIngreso();
                EntyMIrth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                EntyMIrth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                EntyMIrth.LineaOrdenAtencionConsulta = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                EntyMIrth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                EntyMIrth.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                EntyMIrth.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                EntyMIrth.TipoOrdenAtencion = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION;

                EntyMIrth.Secuencia = ObjTrace.Secuencia;
                EntyMIrth.Componente = ObjTrace.CodigoComponente;
                EntyMIrth.SubFamilia = ObjTrace.SubFamilia.Trim();
                EntyMIrth.Familia = ObjTrace.Familia.Trim();
                EntyMIrth.Linea = ObjTrace.Linea.Trim();
                EntyMIrth.UnidadMedida = ObjTrace.IdUnidadMedida;
                EntyMIrth.Cantidad = ObjTrace.Cantidad;
                EntyMIrth.Via = ObjTrace.IdVia.ToString();
                EntyMIrth.Dosis = ObjTrace.Dosis;
                if (!string.IsNullOrEmpty(ObjTrace.TipoComida.ToString()))
                {
                    if (ObjTrace.TipoComida == 64)
                    {
                        var calculo = Convert.ToDouble(ObjTrace.Periodo) * 0.042;
                        EntyMIrth.DiasTratamiento = calculo.ToString();
                    }
                    if (ObjTrace.TipoComida == 65)
                    {
                        var calculo = Convert.ToDecimal(ObjTrace.Periodo);
                        EntyMIrth.DiasTratamiento = calculo.ToString();
                    }
                    if (ObjTrace.TipoComida == 66)
                    {
                        var calculo = Convert.ToDecimal(ObjTrace.Periodo) * 7;
                        EntyMIrth.DiasTratamiento = calculo.ToString();
                    }
                    if (ObjTrace.TipoComida == 67)
                    {
                        var calculo = Convert.ToDecimal(ObjTrace.Periodo) * 30;
                        EntyMIrth.DiasTratamiento = calculo.ToString();
                    }
                }

                if (!string.IsNullOrEmpty(ObjTrace.UnidadTiempo.ToString()))
                {
                    if (ObjTrace.UnidadTiempo == 64)
                    {
                        var calculo = Convert.ToDouble(ObjTrace.Frecuencia);
                        EntyMIrth.Frecuencia = calculo.ToString();
                    }
                    if (ObjTrace.UnidadTiempo == 65)
                    {
                        var calculo = Convert.ToDecimal(ObjTrace.Frecuencia) * 24;
                        EntyMIrth.Frecuencia = calculo.ToString();
                    }
                    if (ObjTrace.UnidadTiempo == 66)
                    {
                        var calculo = Convert.ToDecimal(ObjTrace.Frecuencia) * 168;
                        EntyMIrth.Frecuencia = calculo.ToString();
                    }
                    if (ObjTrace.UnidadTiempo == 67)
                    {
                        var calculo = Convert.ToDecimal(ObjTrace.Frecuencia) * 720;
                        EntyMIrth.Frecuencia = calculo.ToString();
                    }
                }

                EntyMIrth.IndicadorEPS = ObjTrace.IndicadorEPS;
                EntyMIrth.TipoReceta = ObjTrace.TipoReceta;
                EntyMIrth.INDICACIONESPECIFICA = ObjTrace.Indicacion;
                EntyMIrth.SECUENCIALHCE = ObjTrace.SecuencialHCE;

                EntyMIrth.Estado = ObjTrace.Estado;
                EntyMIrth.UsuarioCreacion = ObjTrace.UsuarioCreacion;
                EntyMIrth.FechaCreacion = DateTime.Now;
                EntyMIrth.UsuarioModificacion = ObjTrace.UsuarioModificacion;
                EntyMIrth.FechaModificacion = DateTime.Now;
                ListaMirth.Add(EntyMIrth);
            }
            Log.Debug(DateTime.Now + " SaludRecetaIngresoMantenimiento ListaMirth Cantidad " + ListaMirth.Count);
            Boolean rrr = false;
            if (ListaMirth.Count > 0)
            {
                string msg = Newtonsoft.Json.JsonConvert.SerializeObject(ListaMirth);
                rrr = MirthIngresoMantenimiento("Mirth/SaludRecetaIngresoMantenimiento", msg);
                if (rrr == false)
                {
                    foreach (SS_HC_Medicamento_FE ObjTrace in listaCopia)
                    {
                        ObjTrace.Accion = "DELETEINDIV";
                        var IdSecuencia = SvcMedicamentoFE.setMantenimientoMedicamentosAuditoria(1, ObjTrace);
                    }
                }
            }
            return Convert.ToInt32(rrr);
        }

        public int SaveReceta(SS_HC_EpisodioAtencion items)
        {
            Log.Information("VisorCopiadoController - SaveReceta");
            Log.Debug("SS_HC_EpisodioAtencion {A} " + items);

            List<SS_HC_Medicamento_FE> listaCopia = new List<SS_HC_Medicamento_FE>();
            ENTITY_GLOBAL.Instance.INTERUPTOR_TEMP = 1;
            SS_HC_Medicamento_FE objAdd = new SS_HC_Medicamento_FE();
            var objLista = new List<BE_Medicamento_FE>();
            var objListaAnt = new List<SS_HC_Medicamento_FE>();
            var objListaAnt2 = new List<SS_HC_Medicamento_FE>();

            SS_HC_Medicamento_FE objEnt = new SS_HC_Medicamento_FE();
            objEnt.UnidadReplicacion = items.UnidadReplicacion;
            objEnt.IdPaciente = IdPaciente;
            objEnt.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? items.IdEpisodioAtencion : 1;
            objEnt.EpisodioClinico = items.EpisodioClinico;
            objEnt.TipoMedicamento = 1;// 
            objEnt.Accion = "LISTAR";
            objListaAnt = SvcMedicamentoFE.MedicamentoListar(objEnt);

            objEnt.TipoMedicamento = 4;
            objListaAnt2 = SvcMedicamentoFE.MedicamentoListar(objEnt);

            objListaAnt.AddRange(objListaAnt2);

            if (objListaAnt.Count > 0)
            {
                BE_Medicamento_FE obtemp;
                String[] cadArray;
                foreach (SS_HC_Medicamento_FE intobj in objListaAnt)
                {
                    obtemp = new BE_Medicamento_FE();
                    obtemp.Linea = intobj.Linea;
                    obtemp.Familia = intobj.Familia;
                    obtemp.SubFamilia = intobj.SubFamilia;
                    cadArray = intobj.Version.Trim().Split('|');
                    obtemp.LineaDescripcion = cadArray[0];
                    obtemp.FamiliaDescripcion = cadArray[1];
                    obtemp.SubFamiliaDescripcion = cadArray[2];
                    obtemp.MedicamentoDescripcion = cadArray[3];
                    obtemp.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    obtemp.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    obtemp.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    obtemp.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                    obtemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    obtemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    obtemp.Secuencia = intobj.Secuencia;
                    obtemp.IdUnidadMedida = intobj.IdUnidadMedida;
                    obtemp.Dosis = intobj.Dosis;
                    obtemp.IdVia = intobj.IdVia;
                    obtemp.Cantidad = intobj.Cantidad;
                    obtemp.Frecuencia = intobj.Frecuencia;
                    obtemp.DiasTratamiento = intobj.DiasTratamiento;
                    obtemp.TipoMedicamento = intobj.TipoMedicamento;
                    obtemp.GrupoMedicamento = intobj.GrupoMedicamento;
                    obtemp.Estado = intobj.Estado;
                    obtemp.CodigoComponente = intobj.CodigoComponente;
                    obtemp.Medicamento = intobj.CodigoComponente;
                    obtemp.Comentario = intobj.Comentario;
                    obtemp.CodAlmacen = intobj.CodAlmacen;
                    obtemp.GrupoMedicamento = intobj.GrupoMedicamento;
                    obtemp.TipoReceta = intobj.TipoReceta;
                    if (ENTITY_GLOBAL.Instance.GRUPOMEDICAMENTO < Convert.ToInt32(intobj.GrupoMedicamento))
                    {
                        ENTITY_GLOBAL.Instance.GRUPOMEDICAMENTO = Convert.ToInt32(intobj.GrupoMedicamento);
                    }
                    obtemp.Periodo = intobj.Periodo;
                    obtemp.UsuarioAuditoria = intobj.UsuarioAuditoria;
                    obtemp.UnidadTiempo = intobj.UnidadTiempo;
                    obtemp.TipoComida = intobj.TipoComida;
                    obtemp.Indicacion = intobj.Indicacion;
                    obtemp.TipoReceta = intobj.TipoReceta;
                    obtemp.IndicadorEPS = intobj.IndicadorEPS;
                    obtemp.Accion = "NUEVO";
                    listaCopia.Add(obtemp);
                }
            }
            var IdSecuencia = 0;
            foreach (SS_HC_Medicamento_FE ObjTrace in listaCopia)
            {
                IdSecuencia = SvcMedicamentoFE.setMantenimientoMedicamentosAuditoria(1, ObjTrace);

            }
            //var IdSecuencia = SvcMedicamentoFE.setMantenimientoGrupoCopia(new SS_HC_Medicamento_FE(), listaCopia, null, null, null);
            //Log.Debug(DateTime.Now + " setMantenimientoMedicamentosAuditoria VALIDA " + listaCopia.Count); 

            /**** INICIO INTEROPERABILIDAD MIRTH ***/
            int rrr = 0;
            if (IdSecuencia > 0)
            {
                rrr = SaveRecetaXXX();
            }
            return Convert.ToInt32(rrr);
        }

        public int SaveDiagnostico(SS_HC_EpisodioAtencion items)
        {
            List<SS_HC_Diagnostico_FE> listaCopia = new List<SS_HC_Diagnostico_FE>();
            List<SS_HC_Diagnostico_FE> lstDiagnostico = new List<SS_HC_Diagnostico_FE>();

            SS_HC_Diagnostico_FE obj = new SS_HC_Diagnostico_FE();
            obj.UnidadReplicacion = items.UnidadReplicacion;
            obj.IdPaciente = IdPaciente;
            obj.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? items.IdEpisodioAtencion : 1;
            obj.EpisodioClinico = items.EpisodioClinico;
            obj.Accion = "LISTAR";
            lstDiagnostico = SvcDiagnosticoFE.DiagnosticoListar(obj);

            foreach (SS_HC_Diagnostico_FE objFiltro in lstDiagnostico)
            {
                objFiltro.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objFiltro.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                objFiltro.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                objFiltro.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                objFiltro.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                objFiltro.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                objFiltro.FechaRegistro = DateTime.Now;
                objFiltro.FechaCreacion = DateTime.Now;
                objFiltro.FechaModificacion = DateTime.Now;
                objFiltro.Accion = "NUEVO";
                listaCopia.Add(objFiltro);
            }
            var registro = SvcDiagnosticoFE.setMantenimiento(new SS_HC_Diagnostico_FE(), null, listaCopia);

            int rrr = 0;
            if (registro > 0)
            {
                rrr = SaveDiagnosticoXXX();
            }
            return Convert.ToInt32(rrr);
        }

        public int SaveDiagnosticoXXX()
        {
            SS_HC_Diagnostico_FE Local = new SS_HC_Diagnostico_FE();
            List<SS_HC_Diagnostico_FE> Listar = new List<SS_HC_Diagnostico_FE>();
            Local.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            Local.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            Local.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            Local.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            Local.Accion = "LISTAR";
            Listar = SvcDiagnosticoFE.DiagnosticoListar(Local);
            List<SS_IT_SaludDiagnosticoIngreso> ListaMirth = new List<SS_IT_SaludDiagnosticoIngreso>();
            foreach (SS_HC_Diagnostico_FE objEntity in Listar)
            {
                SS_IT_SaludDiagnosticoIngreso EntyMIrth = new SS_IT_SaludDiagnosticoIngreso();
                EntyMIrth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                EntyMIrth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                EntyMIrth.LineaOrdenAtencionConsulta = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                EntyMIrth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                EntyMIrth.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                EntyMIrth.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                EntyMIrth.Secuencia = objEntity.Secuencia;
                EntyMIrth.IdDiagnostico = objEntity.IdDiagnostico;
                if (objEntity.DeterminacionDiagnostica.Trim() == "1")
                {
                    EntyMIrth.Determinacion = "P";
                }
                else
                {
                    EntyMIrth.Determinacion = "D";
                }
                EntyMIrth.TIPOORDENATENCION = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION;
                EntyMIrth.ObservacionDIAGNOSTICO = objEntity.Observacion;
                EntyMIrth.TIPOIT = "M";
                EntyMIrth.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                EntyMIrth.FechaCreacion = DateTime.Now;
                EntyMIrth.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                EntyMIrth.FechaModificacion = DateTime.Now;
                ListaMirth.Add(EntyMIrth);
            }

            Boolean rrr = false;
            if (ListaMirth.Count > 0)
            {
                string msg = Newtonsoft.Json.JsonConvert.SerializeObject(ListaMirth);
                rrr = MirthIngresoMantenimiento("Mirth/Mirth_DiagnosticoIngresoMantenimiento", msg);
            }
            return Convert.ToInt32(rrr);
        }


        public int SavePlanTrabajo(SS_HC_EpisodioAtencion items)
        {
            List<SS_HC_ExamenSolicitadoFE> listacopia = new List<SS_HC_ExamenSolicitadoFE>();
            var LocalEntyMD = new MA_MiscelaneosDetalle();
            var ListarMisc = new List<MA_MiscelaneosDetalle>();
            var ListarCab = new List<SS_HC_ExamenSolicitadoFE>();

            var LocalEnty = new SS_HC_ExamenSolicitadoFE();
            LocalEnty.UnidadReplicacion = items.UnidadReplicacion;
            LocalEnty.IdPaciente = IdPaciente;
            LocalEnty.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? items.IdEpisodioAtencion : 1;
            LocalEnty.EpisodioClinico = items.EpisodioClinico;
            LocalEnty.Accion = "LISTAR";
            ListarCab = SvcExamenSolicitadoServiceFE.Examen_Listar(LocalEnty).ToList();

            LocalEntyMD.ACCION = "EXAMENESLIST";
            LocalEntyMD.ValorCodigo1 = IdPaciente.ToString().Trim();
            LocalEntyMD.ValorCodigo2 = items.EpisodioClinico.ToString().Trim();
            LocalEntyMD.ValorCodigo3 = ENTITY_GLOBAL.Instance.IdEpisodioAtencionCopiado.ToString().Trim();
            LocalEntyMD.ValorCodigo4 = items.UnidadReplicacion.Trim();
            LocalEntyMD.ValorCodigo5 = "S";
            ListarMisc = SvcMiscelaneos.GetUpListadoServicios(LocalEntyMD).ToList();

            if (ListarCab.Count > 0)
            {
                foreach (var it in ListarCab)
                {
                    LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    LocalEnty.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    LocalEnty.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    LocalEnty.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                    LocalEnty.Resumen = it.Resumen;
                    LocalEnty.FechaModificacion = DateTime.Now;
                    LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    LocalEnty.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    LocalEnty.FechaCreacion = DateTime.Now;
                    LocalEnty.Accion = "NUEVO";
                }

                foreach (var objEntity in ListarMisc)
                {
                    SS_HC_ExamenSolicitadoFE ObjDet = new SS_HC_ExamenSolicitadoFE();
                    ObjDet.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    ObjDet.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    ObjDet.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    ObjDet.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    ObjDet.FechaModificacion = DateTime.Now;
                    ObjDet.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    ObjDet.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    ObjDet.FechaCreacion = DateTime.Now;
                    ObjDet.Accion = "DETALLE";
                    ObjDet.SecuenciaCab = int.Parse(objEntity.CodigoElemento);
                    if (objEntity.ValorCodigo3 != null)
                    {
                        ObjDet.IdEspecialidadCab = int.Parse(objEntity.ValorCodigo3);
                    }
                    ObjDet.IndicadorEPSCab = objEntity.ValorEntero7;
                    ObjDet.TipoCodigoCab = objEntity.ValorCodigo6;
                    ObjDet.CodigoSegusCab = objEntity.ValorCodigo7;
                    ObjDet.CodigoComponenteCab = objEntity.ValorCodigo7; //COrresponde al código CPT           
                    ObjDet.EspecificacionesCab = objEntity.DescripcionExtranjera;
                    ObjDet.CantidadCab = objEntity.ValorEntero6;
                    ObjDet.ObservacionCab = objEntity.ValorCodigo4;
                    ObjDet.FechaSolitadaCab = DateTime.Now;
                    listacopia.Add(ObjDet);
                }
            }
            var registro = SvcExamenSolicitadoServiceFE.setMantenimiento(LocalEnty, listacopia, null);

            int rrr = 0;
            if (registro > 0)
            {
                rrr = SavePlanTrabajoXXX();
            }
            return Convert.ToInt32(rrr);


        }

        public int SavePlanTrabajoXXX()
        {

            MA_MiscelaneosDetalle LocalEntyMD = new MA_MiscelaneosDetalle();
            var ListarMisc = new List<MA_MiscelaneosDetalle>();
            LocalEntyMD.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
            LocalEntyMD.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioClinico.ToString().Trim();
            LocalEntyMD.ValorCodigo3 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
            LocalEntyMD.ValorCodigo4 = ENTITY_GLOBAL.Instance.UnidadReplicacion.ToString().Trim();
            LocalEntyMD.ValorCodigo5 = "S";
            LocalEntyMD.ACCION = "EXAMENESLIST";

            List<SS_IT_SaludProcedimientoIngreso> ListaMirth = new List<SS_IT_SaludProcedimientoIngreso>();
            ListarMisc = SvcMiscelaneos.GetUpListadoServicios(LocalEntyMD).ToList();
            foreach (MA_MiscelaneosDetalle objEntity in ListarMisc)
            {
                SS_IT_SaludProcedimientoIngreso EntyMIrth = new SS_IT_SaludProcedimientoIngreso();
                EntyMIrth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                EntyMIrth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                EntyMIrth.LineaOrdenAtencionConsulta = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                EntyMIrth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                EntyMIrth.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                EntyMIrth.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                EntyMIrth.Secuencia = Convert.ToInt32(objEntity.CodigoElemento);
                EntyMIrth.Componente = objEntity.ValorCodigo7;
                EntyMIrth.idtipoordenatencion = objEntity.ValorEntero5;
                EntyMIrth.Cantidad = objEntity.ValorEntero6;
                EntyMIrth.IndicadorEPS = objEntity.ValorEntero7;
                if (!string.IsNullOrEmpty(ENTITY_GLOBAL.Instance.IdMedico.ToString())) EntyMIrth.IdMedico = (int)ENTITY_GLOBAL.Instance.IdMedico;
                if (!string.IsNullOrEmpty(objEntity.ValorCodigo3)) EntyMIrth.Especialidad = Convert.ToInt32(objEntity.ValorCodigo3);
                EntyMIrth.IdCita = 0;
                EntyMIrth.Observacion = objEntity.DescripcionExtranjera;
                EntyMIrth.SecuencialHCE = objEntity.ValorCodigo1;
                EntyMIrth.UsuarioCreacion = objEntity.UltimoUsuario;
                EntyMIrth.FechaCreacion = objEntity.ValorFecha;
                EntyMIrth.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                EntyMIrth.FechaModificacion = DateTime.Now;
                EntyMIrth.EstadoDocumento = 7;
                EntyMIrth.Estado = 2;
                ListaMirth.Add(EntyMIrth);
            }

            Boolean rrr = false;
            if (ListarMisc.Count > 0)
            {
                string msg = Newtonsoft.Json.JsonConvert.SerializeObject(ListaMirth);
                rrr = MirthIngresoMantenimiento("Mirth/Mirth_ProcedimientoIngresoMantenimiento", msg);
            }
            return Convert.ToInt32(rrr);
        }



        public Boolean MirthIngresoMantenimiento(String rutaRest, String msg)
        {
            Log.Debug(DateTime.Now + " COPIADO MirthIngresoMantenimiento {A}", msg);

            Boolean Rpta = false;

            SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
            ViewResponse LocalEnty = new ViewResponse();
            LocalEnty.valor = 1;
            LocalEnty.msg = msg;

            var URL_SERVER = ConfigurationManager.AppSettings.Get("ApiRest");
            HttpClient clienteHttp = new HttpClient();
            clienteHttp.BaseAddress = new Uri(URL_SERVER);
            Log.Debug(DateTime.Now + "URL_SERVER {A} , rutaRest {B}", URL_SERVER, rutaRest);

            var request = clienteHttp.PostAsync(rutaRest, LocalEnty, new JsonMediaTypeFormatter()).Result;
            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;
                ViewResponse Resultado = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(ViewResponse));
                if (Resultado.valor > 0)
                {
                    Rpta = true;
                    //registro = Convert.ToInt32(Resultado.valor);
                }
                else
                {
                    Thread.Sleep(2000);
                    Log.Debug(DateTime.Now + " DATO" + rutaRest + " VERSION I {A}", Newtonsoft.Json.JsonConvert.SerializeObject(msg));
                    Log.Debug(DateTime.Now + " ERROR" + rutaRest + " VERSION I {A}", Newtonsoft.Json.JsonConvert.SerializeObject(Resultado));
                    var requestV2 = clienteHttp.PostAsync(rutaRest, LocalEnty, new JsonMediaTypeFormatter()).Result;
                    if (requestV2.IsSuccessStatusCode)
                    {
                        var resultStringV2 = requestV2.Content.ReadAsStringAsync().Result;
                        ViewResponse ResultadoV2 = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultStringV2, typeof(ViewResponse));
                        objAudit.OldData = Newtonsoft.Json.JsonConvert.SerializeObject(ResultadoV2);
                        if (ResultadoV2.valor > 0)
                        {
                            Rpta = true;
                            // registro = Convert.ToInt32(ResultadoV3.valor);
                        }
                        else
                        {
                            Thread.Sleep(2000);
                            Log.Debug(DateTime.Now + " ERROR" + rutaRest + " VERSION II {A}", Newtonsoft.Json.JsonConvert.SerializeObject(ResultadoV2));
                            var requestV3 = clienteHttp.PostAsync(rutaRest, LocalEnty, new JsonMediaTypeFormatter()).Result;
                            if (requestV3.IsSuccessStatusCode)
                            {
                                var resultStringV3 = requestV3.Content.ReadAsStringAsync().Result;
                                ViewResponse ResultadoV3 = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultStringV3, typeof(ViewResponse));
                                objAudit.OldData = Newtonsoft.Json.JsonConvert.SerializeObject(ResultadoV3);
                                if (ResultadoV3.valor > 0)
                                {
                                    Rpta = true;
                                    //registro = Convert.ToInt32(ResultadoV3.valor);
                                }
                                else
                                {
                                    Log.Debug(DateTime.Now + " ERROR " + rutaRest + "  VERSION III {A}", Newtonsoft.Json.JsonConvert.SerializeObject(ResultadoV3));
                                }
                            }
                        }
                    }
                }
            }
            clienteHttp.Dispose();
            dynamic DataKey;
            DataKey = new
            {
                UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion,
                IdEpisodioAtencion = ENTITY_GLOBAL.Instance.IdEpisodioAtencion,
                EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico,
                IdPaciente = ENTITY_GLOBAL.Instance.PacienteID,
                IdMedico = ENTITY_GLOBAL.Instance.IdPersonalSalud
            };
            objAudit.PrimaryKeyData = Newtonsoft.Json.JsonConvert.SerializeObject(DataKey);
            objAudit.Aplicacion = ENTITY_GLOBAL.Instance.APPCODIGO;
            objAudit.Modulo = ENTITY_GLOBAL.Instance.MODULO;
            objAudit.Usuario = ENTITY_GLOBAL.Instance.USUARIO;
            objAudit.HostName = ENTITY_GLOBAL.Instance.HostName;
            objAudit.TableName = rutaRest;
            objAudit.UpdateDate = DateTime.Now;
            objAudit.Type = "U";
            objAudit.VistaData = Newtonsoft.Json.JsonConvert.SerializeObject(LocalEnty);
            objAudit.Accion = "INSERT";
            SvcAuditoria.setMantenimiento(objAudit);

            return Rpta;
        }

        public PartialViewResult LoadFormatos(string containerId, string text)
        {
            string WEBNUEVO = "";
            string WEBMODIFICAR = "";
            Log.Information("VisorCopiadoController - LoadFormatos");
            Log.Debug("containerId {A} , text {B}", containerId, text);

            ENTITY_GLOBAL.Instance.INDICA_FORM_COMPARTIDO = 0;
            ENTITY_GLOBAL.Instance.INDICA_FORM = 0;
            ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            ENTITY_GLOBAL.Instance.bitacora = 0;
            ENTITY_GLOBAL.Instance.INDICADOR_DOACEPTAR = 0;

            List<ParametrosMast> listaParam = new List<ParametrosMast>();
            ParametrosMast objParam = new ParametrosMast();
            objParam.Accion = "LISTAR";
            objParam.CompaniaCodigo = "999999";
            objParam.AplicacionCodigo = "WA";//obs
            objParam.ParametroClave = "DINAMICA";
            listaParam = SvcParametro.listarParametro(objParam, 0, 0);
            if (listaParam.Count > 0)
            {
                if ((listaParam[0].Texto + "").Trim() == "S")//USAR PARÁMETRO
                {
                    WEBNUEVO = (listaParam[0].DescripcionParametro + "").Trim();
                    WEBMODIFICAR = (listaParam[0].Explicacion + "").Trim();
                }
            }

            Session["indicaFavoritos"] = null;
            Session["DataFavoritosSelec"] = null;
            Session["DataDianosticoValoracionDelete"] = null;
            Session["containerId_ACTUAL"] = containerId;
            Session["textTree_ACTUAL"] = text;
            ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            var UrlFormato = "PanelCentralBlanco";
            var model = new SS_HC_EpisodioAtenciones();
            model.IdOpcion = text.Trim();
            //CONSTRUIR COD HCE
            //model.WORKFLAG = String.Format("{0:00000}", ENTITY_GLOBAL.Instance.EpisodioClinico) + "." + String.Format("{0:00000}", ENTITY_GLOBAL.Instance.EpisodioAtencion);
            model.DescansoMedico = UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                /*ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,*/ ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.EpisodioAtencionBeta, ENTITY_GLOBAL.Instance.PacienteID, "");

            var objVistaSeguridad = new SS_CHE_VistaSeguridad();
            objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
            objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            objVistaSeguridad.Accion = "DATOSFORMULARIO";
            if (text.Trim() != "root")
            {
                objVistaSeguridad.IdOpcion = Convert.ToInt32(text.Trim());
            }

            var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);
            if (resulListado.Count > 0)
            {
                ENTITY_GLOBAL.Instance.CodeForm = resulListado[0].CodigoFormato;
                switch (resulListado[0].TipoFormato)
                {
                    case 2: //ES FIJO
                        UrlFormato = "PanelCenter"; //resulListado[0].CodigoFormato;
                        model.CONCEPTO = resulListado[0].CodigoFormato.Trim() + "_View";
                        model.Accion = resulListado[0].CodigoFormato.Trim() + "_View";
                        if (resulListado[0].CodigoFormato.Trim() == "CCEP00F2")
                        {
                            ENTITY_GLOBAL.Instance.OPCION_STOCK_DEF = 0;
                        }
                        else { ENTITY_GLOBAL.Instance.OPCION_STOCK_DEF = 1; }

                        break;
                    case 3: //ES DINAMIC
                        string searchForThis = "weasis";
                        int firstCharacter = resulListado[0].UrlOpcion.Trim().IndexOf(searchForThis);
                        model.CONCEPTO = resulListado[0].UrlOpcion.Trim() + resulListado[0].IdFormatoDinamico.ToString().Trim();
                        model.Accion = resulListado[0].UrlOpcion.Trim() + resulListado[0].IdFormatoDinamico.ToString().Trim();
                        if (firstCharacter > 0)
                        {
                            model.Url = resulListado[0].UrlOpcion.Trim();
                            UrlFormato = "PanelCenterPACUrl";
                        }
                        else
                        {
                            UrlFormato = "PanelCenterUrl";
                            model.Url = resulListado[0].UrlOpcion.Trim() + "/" + WEBNUEVO;
                            model.Lectura = "0";
                            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA") model.Lectura = "1";
                            model.IdForm = resulListado[0].IdFormatoDinamico.ToString().Trim();
                            model.IdOpcion = text.Trim();
                            model.Usuario = ENTITY_GLOBAL.Instance.USUARIO;
                            model.TransID = "0";
                            model.URLFLAG = 0;
                            //////////////////OBTENER ID TRANSACCIONAL/////////////
                            SS_HC_EpisodioAtencion obj = new SS_HC_EpisodioAtencion();
                            obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                            obj.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                            /*obj.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                            obj.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim;*/

                            obj.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencionBeta);//ADD
                            obj.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;//ADD

                            obj.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                            obj.IdTipoInterConsulta = Convert.ToInt32(model.IdForm); //AUX
                            obj.IdTipoReferencia = Convert.ToInt32(model.IdOpcion); //AUX
                            obj.UsuarioCreacion = model.Usuario;
                            obj.Accion = "ATENCIONFORMATO";
                            List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(obj, 0, 0);
                            if (listaEpi != null)
                            {
                                if (listaEpi.Count > 0)
                                {
                                    if (listaEpi[0].IdProcedimiento != null)
                                    {
                                        model.URLFLAG = 1;
                                        model.TransID = "" + listaEpi[0].IdProcedimiento;
                                        model.Url = resulListado[0].UrlOpcion.Trim() + "/" + WEBMODIFICAR;
                                    }
                                }
                            }
                            /////////////////////
                            //SS_HC_EpisodioAtencionFormato ooo;
                        }
                        break;
                    case 4: //ES LINK
                        UrlFormato = "PanelCenter"; //resulListado[0].CodigoFormato;
                        model.CONCEPTO = resulListado[0].CodigoFormato.Trim() + "_View";
                        model.Accion = resulListado[0].CodigoFormato.Trim() + "_View";


                        ENTITY_GLOBAL.Instance.URLlink = (resulListado[0].UrlOpcion != null ? resulListado[0].UrlOpcion.Trim() : "");
                        break;
                    default:
                        if (resulListado[0].CodigoFormato != null)
                        {
                            model.CONCEPTO = resulListado[0].CodigoFormato.Trim() + "_View";
                        }
                        UrlFormato = "PanelCentralBlanco";
                        break;

                }

                //ADD
                ENTITY_GLOBAL.Instance.TIPOFORMATO = Convert.ToInt32(resulListado[0].TipoFormato);
                ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL = resulListado[0].IdOpcion;
                ENTITY_GLOBAL.Instance.IDOPCION_PADRE = resulListado[0].IdOpcionPadre;
                ENTITY_GLOBAL.Instance.MODULOBLIGATORIO = resulListado[0].Modulo;

                ENTITY_GLOBAL.Instance.INDICA_FORM_COMPARTIDO =
                    resulListado[0].IdObjetoAsociado != null ? (int)resulListado[0].IdObjetoAsociado : 0; //AUX PARA INDICAR SI ES COMPARTIDO
                if (resulListado[0].CodigoFormato == null)
                {
                    UrlFormato = "PanelCentralBlanco";
                }
                else
                {
                    model.DESCRIPCION = resulListado[0].NombreOpcion;
                    model.Version = resulListado[0].NombreOpcion;
                    model.GRUPO = "REG0000";
                    if (resulListado[0].NombreOpcion != null)
                    {
                        ENTITY_GLOBAL.Instance.CONCEPTO = (resulListado[0].CodigoFormato + "").Trim();
                        ENTITY_GLOBAL.Instance.IDFORMATO = resulListado[0].IdFormato;
                        ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION = resulListado[0].NombreOpcion.Trim();
                        //   ENTITY_GLOBAL.Instance.CODOPCION_GUARDADO = Convert.ToString(resulListado[0].IdOpcion);
                    }
                    objVistaSeguridad = new SS_CHE_VistaSeguridad();
                    objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                    objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                    objVistaSeguridad.Accion = "DATOSRECURSOS";

                    //esto se podria reemplazar creo pqero dejemosloahi se va tener que validar bien or todos lados
                    objVistaSeguridad.CodigoFormato = resulListado[0].CodigoFormato.Trim();
                    if (objVistaSeguridad.CodigoFormato == "CCEPF201_3")
                    {

                        if (text == "3805")
                        {
                            objVistaSeguridad.CodigoFormato = "CCEPF101";
                        }
                        else
                        {
                            objVistaSeguridad.CodigoFormato = "CCEP0F90";
                        }
                        //objVistaSeguridad.CodigoFormato = "CCEP0F90";
                    }
                    if (objVistaSeguridad.CodigoFormato == "CCEPF201_2")
                    {
                        objVistaSeguridad.CodigoFormato = "CCEPF101";
                    }
                    if (objVistaSeguridad.CodigoFormato == "CCEPF319")
                    {
                        if (text == "3567")
                        {
                            objVistaSeguridad.CodigoFormato = "CCEPF150";
                        }
                        else
                        {
                            objVistaSeguridad.CodigoFormato = "CCEP0F90";
                        }

                    }


                    if (objVistaSeguridad.CodigoFormato == "CCEPF323_1")
                    {
                        if (text == "3567")
                        {
                            objVistaSeguridad.CodigoFormato = "CCEPF150";
                        }
                        else
                        {
                            objVistaSeguridad.CodigoFormato = "CCEP0F90";
                        }

                    }




                    //objVistaSeguridad.CodigoFormato = ENTITY_GLOBAL.Instance.CODIGODEFORMATO_ACTUAL;

                    resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);
                    ENTITY_GLOBAL.Instance.GRUPO = "REG0000";
                    Session["RecursosActivos"] = resulListado;

                    //ADD APFRA BIENES Y SERV
                    Session["ESCOLLAPSED_BIENSERV"] = "S";
                    //POR DEFECTO COLAPSADO
                    Panel panelServ = X.GetCmp<Panel>("East1");
                    if (panelServ != null)
                    {
                        panelServ.Collapse();
                    }

                    if (resulListado.Count > 0)
                    {
                        ENTITY_GLOBAL.Instance.MENUREC_CODIGO = resulListado[0].Nombre;
                        ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = resulListado[0].DescripcionAgente;
                        //ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
                        ENTITY_GLOBAL.Instance.indicadorUI = false;
                        if (ENTITY_GLOBAL.Instance.MENUREC_CODIGO == "MM000")
                        {
                            // ENTITY_GLOBAL.Instance.indicadorAuxiliar = true;  //¿?
                            ENTITY_GLOBAL.Instance.indicadorUI = true;
                        }
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.MENUREC_CODIGO = "0000";
                        ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = "SIN RECURSOS";
                    }
                }
            }
            /////OBJ MODEL      
            Session["ESTADOANTERIOR"] = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            model.ESTADOFORMULARIO = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            model.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            model.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
            model.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
            model.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim;
            model.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
            model.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
            if (Session["NOMBREPACIENTE_ACTUAL"] != null)
            {
                model.ObservacionFirma = (String)Session["NOMBREPACIENTE_ACTUAL"];
            }
            if (ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo != null && ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo != 0)
            {
                model.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo;
                model.FlagFirma = ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo;
            }
            else
            {
                //model.Clinico = null;
                model.FlagFirma = null;
            }
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                // model.TIPODEOBJETO =  (String)Session["TIPOTRABAJADOR_ACTUAL"];
                model.TipoTrabajador = (String)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            //OBS
            UTILES_MENSAJES.setParametro_Form("EPI_CLINICO_CREADO", ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo);
            //VALIDAR EXISTENCIA DE EPI CLINICOS PARA CONTINUAR
            SS_HC_EpisodioClinico objEPiCLin = new SS_HC_EpisodioClinico();
            objEPiCLin.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objEPiCLin.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
            objEPiCLin.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion; //NO USADO
            objEPiCLin.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO; //NO USADO
            objEPiCLin.ACCION = "VALIDAR_EPICONTINUAR";
            //OBS: SE DIJO UNA OA NO PUEDE ESTAR EN OTRO EPI ClÍNICO....09/17
            int indica = SvcEpisodioClinico.setMantenimiento(objEPiCLin);
            if (indica > 0) //EXisten Epi clínicos para continuar
            {
                model.IdTipoInterConsulta = 1; //AUX PARA INDICAR (mostrar) BOTON CONTINUAR
            }
            else
            {
                model.IdTipoInterConsulta = 0; //AUX PARA INDICAR (ocultar) BOTON CONTINUAR
            }
            setCodigoFormatosPaginas("GENERAL", text);

            //CONFIG DECOPIAR FORM

            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_COPY = 0;
            if (getIndicaFormatosCopiar(ENTITY_GLOBAL.Instance.CONCEPTO))
            {
                if (ENTITY_GLOBAL.Instance.CONCEPTO == "CCEPF103")
                {
                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_COPY = 2;
                }
                else if (ENTITY_GLOBAL.Instance.CONCEPTO == "CCEPF200")
                {
                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_COPY = 3;
                }

                else if (ENTITY_GLOBAL.Instance.CONCEPTO == "CCEPF201_1")
                {
                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_COPY = 3;
                }

                else
                {
                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_COPY = 1;
                }

            }


            //CONFIG DE SEGURIDAD DE IMPRESION
            cargarPermisosFormato(true);

            return new PartialViewResult
            {
                ViewName = UrlFormato//
                //ContainerId = containerId,
                //Model = model,
                ////SingleControl = true,
                //ClearContainer = true,
                //WrapByScriptTag = true,
                //RenderMode = RenderMode.AddTo
            };
        }

        public Boolean setCodigoFormatosPaginas(String indicadorEtapa, String opcionView)
        {
            Boolean result = true;
            if (opcionView != null)
            {
                if (indicadorEtapa == "GENERAL")
                {
                    String temporal = ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_PREVIA = temporal;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL = opcionView;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_SGTE = null;

                }
            }
            return result;
        }

        public Boolean getIndicaFormatosCopiar(String codigoFormato)
        {
            Boolean result = false;
            if (codigoFormato != null)
            {
                //MEJORAR **
                if (codigoFormato == UTILES_MENSAJES.FORM_ANAMNESIS_EA_F1)
                {
                    result = false;//ESTE NOVA
                }
                else if (codigoFormato == UTILES_MENSAJES.FORM_DIAGNOSTICO_F1)
                {
                    result = true;
                }
                else if (codigoFormato == UTILES_MENSAJES.FORM_MEDICAMENTOS_F1)
                {
                    result = true;
                }
                else if (codigoFormato == UTILES_MENSAJES.FORM_DIETAS_MNUT_F1)
                {
                    result = true;
                }
                else if (codigoFormato == UTILES_MENSAJES.FORM_EVOL_OBJETIVA_F1)
                {
                    result = true;
                }
                else if (codigoFormato == UTILES_MENSAJES.FORM_DIAGNOSTICO_F2
                     || codigoFormato == UTILES_MENSAJES.FORM_EVOL_OBJETIVA_F2
                     || codigoFormato == UTILES_MENSAJES.FORM_NOTAENFERMERIA

                    || codigoFormato == UTILES_MENSAJES.FORM_MEDICAMENTOS_F2
                    || codigoFormato == UTILES_MENSAJES.FORM_MEDICAMENTOS_NO_FARMACOLOGICOS_F2
                    || codigoFormato == UTILES_MENSAJES.FORM_MED_EPICRISIS201_3_F2

                    || codigoFormato == UTILES_MENSAJES.FORM_MED_EPICRISIS201_1_F2
                    || codigoFormato == UTILES_MENSAJES.FORM_INFORMEALTA_TRATAMIENTO_F2
                    || codigoFormato == UTILES_MENSAJES.FORM_RECETAGRUPAL_F2


                    || codigoFormato == UTILES_MENSAJES.FORM_MED_INFORMEALTA_F2
                    || codigoFormato == UTILES_MENSAJES.FORM_DIETAS_MNUT_F2
                    || codigoFormato == UTILES_MENSAJES.FORM_EXAMENSOLICITADO_F2
                    )
                {
                    result = true;
                }

            }
            return result;
        }

        public bool cargarPermisosFormato(bool activo)
        {
            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = 0;
            if (Convert.ToInt32(ENTITY_GLOBAL.Instance.IdMedicoaudi) != 0)
            {

                if (activo)
                {
                    Session["RECURSOS_PERMISOSFORMATOS"] = null;
                    var CodFormato = ENTITY_GLOBAL.Instance.CONCEPTO;
                    var idFormato = ENTITY_GLOBAL.Instance.IDFORMATO;
                    var idOpcion = ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL;


                    List<SS_CHE_VistaSeguridad> serviceResuls = new List<SS_CHE_VistaSeguridad>();
                    SS_CHE_VistaSeguridad entidaLocal = new SS_CHE_VistaSeguridad();
                    entidaLocal.Accion = "LISTAROPCIONESCAGENTE";

                    entidaLocal.IdFormato = idFormato;
                    entidaLocal.IdOpcion = Convert.ToInt32(idOpcion);
                    entidaLocal.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE_AUDITORIA);
                    entidaLocal.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    entidaLocal.NivelOpcion = -2; //FORMATOS  - OPCIONES SIN PLANTILLA

                    int indAsignado = 0;
                    int indNuevo = 0;
                    int indModificar = 0;
                    int indEliminar = 0;
                    int indVisible = 0;
                    int indIngreso = 0;
                    int indAcceso = 0;
                    int indHabilitado = 0;
                    int indObligatorio = 0;
                    int indPrioridadAgOPcion = 0;
                    int indImpresion = 0;

                    serviceResuls = SvcSeguridadConcepto.ListarSeguridadOpcion(entidaLocal, 0, 0);
                    if (serviceResuls.Count > 0)
                    {
                        indAsignado = Convert.ToInt32(serviceResuls[0].IndicadorAsignacion);
                        indNuevo = Convert.ToInt32(serviceResuls[0].IndicadorNuevo);
                        indModificar = Convert.ToInt32(serviceResuls[0].IndicadorModificar);
                        indEliminar = Convert.ToInt32(serviceResuls[0].IndicadorEliminar);
                        indVisible = Convert.ToInt32(serviceResuls[0].IndicadorVisible);
                        indIngreso = Convert.ToInt32(serviceResuls[0].IndicadorIngreso);
                        indAcceso = Convert.ToInt32(serviceResuls[0].IndicadorAcceso);
                        indHabilitado = Convert.ToInt32(serviceResuls[0].IndicadorHabilitado);
                        indObligatorio = Convert.ToInt32(serviceResuls[0].IndicadorObligatorio);
                        indPrioridadAgOPcion = Convert.ToInt32(serviceResuls[0].IndicadorPrioridad);
                        indImpresion = Convert.ToInt32(serviceResuls[0].IndicadorImprimir);
                    }

                    List<ENTITY_GENERALHCE> listaPermisos = new List<ENTITY_GENERALHCE>();
                    ENTITY_GENERALHCE objPermiso = new ENTITY_GENERALHCE();
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "ASIGNACION", campoStr01 = "A", campoInt01 = indAsignado });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "NUEVO", campoStr01 = "N", campoInt01 = indNuevo });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "MODIFICAR", campoStr01 = "M", campoInt01 = indModificar });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "ELIMINAR", campoStr01 = "E", campoInt01 = indEliminar });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "VER", campoStr01 = "V", campoInt01 = indIngreso });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "INGRESO", campoStr01 = "I", campoInt01 = indIngreso });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "BUSCAR", campoStr01 = "B", campoInt01 = 2 });//HARD
                    ////////
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "ACCESO", campoStr01 = "S", campoInt01 = indAcceso });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "HABILITADO", campoStr01 = "H", campoInt01 = indHabilitado });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "OBLIGA", campoStr01 = "O", campoInt01 = indObligatorio });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "PRIORIDADAGOPCION", campoStr01 = "P", campoInt01 = indPrioridadAgOPcion });
                    ///ADD PRINT
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "IMPRIMIR", campoStr01 = "R", campoInt01 = indImpresion });

                    Session["RECURSOS_PERMISOSFORMATOS"] = listaPermisos;

                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = indImpresion;
                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_OBLIGATORIO = indObligatorio;
                }


            }
            else
            {
                if (activo)
                {
                    Session["RECURSOS_PERMISOSFORMATOS"] = null;
                    var CodFormato = ENTITY_GLOBAL.Instance.CONCEPTO;
                    var idFormato = ENTITY_GLOBAL.Instance.IDFORMATO;
                    var idOpcion = ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL;


                    List<SS_CHE_VistaSeguridad> serviceResuls = new List<SS_CHE_VistaSeguridad>();
                    SS_CHE_VistaSeguridad entidaLocal = new SS_CHE_VistaSeguridad();
                    entidaLocal.Accion = "LISTAROPCIONESCAGENTE";

                    entidaLocal.IdFormato = idFormato;
                    entidaLocal.IdOpcion = Convert.ToInt32(idOpcion);
                    entidaLocal.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                    entidaLocal.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    entidaLocal.NivelOpcion = -2; //FORMATOS  - OPCIONES SIN PLANTILLA

                    int indAsignado = 0;
                    int indNuevo = 0;
                    int indModificar = 0;
                    int indEliminar = 0;
                    int indVisible = 0;
                    int indIngreso = 0;
                    int indAcceso = 0;
                    int indHabilitado = 0;
                    int indObligatorio = 0;
                    int indPrioridadAgOPcion = 0;
                    int indImpresion = 0;

                    serviceResuls = SvcSeguridadConcepto.ListarSeguridadOpcion(entidaLocal, 0, 0);
                    if (serviceResuls.Count > 0)
                    {
                        indAsignado = Convert.ToInt32(serviceResuls[0].IndicadorAsignacion);
                        indNuevo = Convert.ToInt32(serviceResuls[0].IndicadorNuevo);
                        indModificar = Convert.ToInt32(serviceResuls[0].IndicadorModificar);
                        indEliminar = Convert.ToInt32(serviceResuls[0].IndicadorEliminar);
                        indVisible = Convert.ToInt32(serviceResuls[0].IndicadorVisible);
                        indIngreso = Convert.ToInt32(serviceResuls[0].IndicadorIngreso);
                        indAcceso = Convert.ToInt32(serviceResuls[0].IndicadorAcceso);
                        indHabilitado = Convert.ToInt32(serviceResuls[0].IndicadorHabilitado);
                        indObligatorio = Convert.ToInt32(serviceResuls[0].IndicadorObligatorio);
                        indPrioridadAgOPcion = Convert.ToInt32(serviceResuls[0].IndicadorPrioridad);
                        indImpresion = Convert.ToInt32(serviceResuls[0].IndicadorImprimir);
                    }

                    List<ENTITY_GENERALHCE> listaPermisos = new List<ENTITY_GENERALHCE>();
                    ENTITY_GENERALHCE objPermiso = new ENTITY_GENERALHCE();
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "ASIGNACION", campoStr01 = "A", campoInt01 = indAsignado });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "NUEVO", campoStr01 = "N", campoInt01 = indNuevo });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "MODIFICAR", campoStr01 = "M", campoInt01 = indModificar });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "ELIMINAR", campoStr01 = "E", campoInt01 = indEliminar });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "VER", campoStr01 = "V", campoInt01 = indIngreso });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "INGRESO", campoStr01 = "I", campoInt01 = indIngreso });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "BUSCAR", campoStr01 = "B", campoInt01 = 2 });//HARD
                    ////////
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "ACCESO", campoStr01 = "S", campoInt01 = indAcceso });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "HABILITADO", campoStr01 = "H", campoInt01 = indHabilitado });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "OBLIGA", campoStr01 = "O", campoInt01 = indObligatorio });
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "PRIORIDADAGOPCION", campoStr01 = "P", campoInt01 = indPrioridadAgOPcion });
                    ///ADD PRINT
                    listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "IMPRIMIR", campoStr01 = "R", campoInt01 = indImpresion });

                    Session["RECURSOS_PERMISOSFORMATOS"] = listaPermisos;

                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = indImpresion;
                    ENTITY_GLOBAL.Instance.INDICA_VISIBLE_OBLIGATORIO = indObligatorio;
                }



            }



            return true;
        }

        public static DataTable rptV_EpisodioAtenciones(string Reporte, int PacienteID, int IdOrdenAtencion, int Linea)
        {
            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                conx.Open();
                string sql = @"SELECT * FROM " + Reporte + "  where IdPaciente=" + PacienteID + " and  IdOrdenAtencion=" + IdOrdenAtencion + " and  LineaOrdenAtencion=" + Linea + " "; //ADD 05.06.2017 ORLANDO
                SqlDataAdapter adapter = new SqlDataAdapter(sql, conx);
                DataSet ds_Result = new DataSet();
                adapter.Fill(ds_Result, "Agrupador");
                if (ds_Result == null || ds_Result.Tables.Count == 0)
                {
                    return null;
                }
                return ds_Result.Tables[0];

            }
        }

    }

}
