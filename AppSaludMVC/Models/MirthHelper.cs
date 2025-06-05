using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;
using System.Text.RegularExpressions;
using AppSaludMVC.Controllers;
using Microsoft.Win32;
using Newtonsoft.Json;
using Serilog;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service._FormularioNuevo;
using SoluccionSalud.Service.AuditoriaService;
using SoluccionSalud.Service.MiscelaneosService;
using System.Threading.Tasks;

public class MirthHelper
{


    static List<string> listaConsultaTodos = new List<string>()
                {
                   UTILES_MENSAJES.MIRTH_ANAMNESIS, UTILES_MENSAJES.MIRTH_RECETA, UTILES_MENSAJES.MIRTH_DIAGNOSTICO,
                   UTILES_MENSAJES.MIRTH_PLANTRABAJO, UTILES_MENSAJES.MIRTH_OFTALMOLOGICO, UTILES_MENSAJES.MIRTH_DESCANSOMEDICO,
                   UTILES_MENSAJES.MIRTH_SALUDINFORME
                };

    public static Dictionary<string, Func<int>> diccMetodosXFormato = new Dictionary<string, Func<int>>()
            {
                { UTILES_MENSAJES.MIRTH_ANAMNESIS, MirthHelper.SaveAnamnesisXXX },
                { UTILES_MENSAJES.MIRTH_RECETA, MirthHelper.SaveRecetaXXX },
                { UTILES_MENSAJES.MIRTH_DIAGNOSTICO, MirthHelper.SaveDiagnosticoXXX },
                { UTILES_MENSAJES.MIRTH_PLANTRABAJO, MirthHelper.SavePlanTrabajoXXX },
                { UTILES_MENSAJES.MIRTH_OFTALMOLOGICO, MirthHelper.SaveOftalmologicoXXX },
                { UTILES_MENSAJES.MIRTH_DESCANSOMEDICO, MirthHelper.SaveDescansoMedicoXXX },
                { UTILES_MENSAJES.MIRTH_SALUDINFORME, MirthHelper.SaveSaludInformePROCXXXX }
            };



    private static List<string> DefinirLista(string input, int especialidad)
    {
        List<string> ret;

        if (input.Equals("Default"))
        {
            ret = listaConsultaTodos;
            ret.Remove(especialidad == 22 ? UTILES_MENSAJES.MIRTH_ANAMNESIS : UTILES_MENSAJES.MIRTH_OFTALMOLOGICO);
        }
        else
        {
            ret = new List<string>(input.Split('-'));
            ret.Remove("ERROR");
            ret.Remove("");
        }
        return ret;
    }

    public static List<string> ejecutarMetodos(string input, int especialidadMedico, List<string> listaDevueltos = null)
    {
        bool flagError = false;
        List<string> listaConsulta;
        List<string> listaRetorno = new List<string>() { "CREADO" };

        listaConsulta = DefinirLista(input, especialidadMedico);

        int i = 0;
        foreach (string metodoPorEjecutar in listaConsulta)
        {
            //int resultado = (i++ % 2 == 0) ? 1 : 0;
            int resultado = diccMetodosXFormato[metodoPorEjecutar]();

            if (resultado < 1)
            {
                flagError = true;
                listaRetorno.Add(metodoPorEjecutar);
            }
        }

        listaRetorno[0] = flagError ? "ERROR" : "VALIDADOS";

        return listaRetorno;
    }

    public static bool MirthIngresoMantenimiento(string rutaRest, string msg)
    {
        bool Rpta = false;
        int maxRetries = ENTITY_GLOBAL.Instance.MIRTENVIO;
        int retryCount = 0;
        int delay = ENTITY_GLOBAL.Instance.MIRTHDELAY;

        SS_HC_AuditRoyal objAudit = new SS_HC_AuditRoyal();
        ViewResponse LocalEnty = new ViewResponse();
        LocalEnty.valor = 1;
        LocalEnty.msg = msg;

        var URL_SERVER = ConfigurationManager.AppSettings.Get("ApiRest");

        Log.Debug(DateTime.Now + "URL_SERVER {A} , rutaRest {B}", URL_SERVER, rutaRest);
        Log.Debug(DateTime.Now + " MirthIngresoMantenimiento {A}", rutaRest + " | " + msg);
        while (retryCount < maxRetries && !Rpta)
        {
            using (HttpClient clienteHttp = new HttpClient())
            {
                clienteHttp.BaseAddress = new Uri(URL_SERVER);
                try
                {
                    var request = clienteHttp.PostAsync(rutaRest, LocalEnty, new JsonMediaTypeFormatter()).Result;
                    if (request.IsSuccessStatusCode)
                    {
                        var resultString = request.Content.ReadAsStringAsync().Result;
                        ViewResponse Resultado = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(ViewResponse));
                        if (Resultado.valor > 0)
                        {
                            Rpta = true;
                        }
                    }
                    else
                    {
                        Log.Error(DateTime.Now + " Error en la solicitud: " + request.StatusCode);
                    }
                }
                catch (Exception ex)
                {
                    Log.Error(DateTime.Now + " Excepción: " + ex.Message);
                }
            }

            if (!Rpta)
            {
                retryCount++;
                Log.Debug(DateTime.Now + " Reintento " + retryCount + " de " + maxRetries);

                if (retryCount < maxRetries)
                {
                    Log.Debug(DateTime.Now + " Esperando " + delay / 1000 + " segundos antes del próximo intento.");
                    Task.Delay(delay).Wait();
                }
            }
        }

        return Rpta;
    }

    public static int SaveAnamnesisXXX()
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
                EntyMIrth.TiempoEnfermedad = ObjTraceEnfermedad.TiempoEnfermedad.ToString();
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

    public static int SaveRecetaXXX()
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
        SS_HC_Medicamento_FE objEnty;
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

            objEnty = ObjTrace;
        }


        SS_IT_SaludRecetaIndicacionesGENIngreso EntyMIrth2 = new SS_IT_SaludRecetaIndicacionesGENIngreso();
        foreach (SS_HC_Medicamento_FE ObjTrace in listaCopia)
        {
            EntyMIrth2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            EntyMIrth2.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
            EntyMIrth2.LineaOrdenAtencionConsulta = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
            EntyMIrth2.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            EntyMIrth2.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            EntyMIrth2.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            EntyMIrth2.Secuencia = ObjTrace.Secuencia;
            EntyMIrth2.TipoIndicacion = 2;
            EntyMIrth2.Descripcion = ObjTrace.Comentario;
            EntyMIrth2.UsuarioCreacion = ObjTrace.UsuarioCreacion;
            EntyMIrth2.FechaCreacion = ObjTrace.FechaCreacion;
            EntyMIrth2.UsuarioModificacion = ObjTrace.UsuarioModificacion;
            EntyMIrth2.FechaModificacion = ObjTrace.FechaModificacion;
            EntyMIrth2.Estado = ObjTrace.Estado;
        }


        int result = 0;

        if (ListaMirth.Count < 1) return 1;

        /*
                ViewResponse LocalEnty = new ViewResponse();
                LocalEnty.valor = 1;
                LocalEnty.msg = Newtonsoft.Json.JsonConvert.SerializeObject(EntyMIrth2);
                var URL_SERVER = ConfigurationManager.AppSettings.Get("ApiRest");
                HttpClient clienteHttp = new HttpClient();
                clienteHttp.BaseAddress = new Uri(URL_SERVER);


                var request = clienteHttp.PostAsync("Mirth/SaludRecetaIndicacionesGENIngresoMantenimiento", LocalEnty, new JsonMediaTypeFormatter()).Result;
                if (request.IsSuccessStatusCode)
                {
                    var resultString = request.Content.ReadAsStringAsync().Result;
                    ViewResponse Resultado = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(ViewResponse));
                    LocalEnty.valor = Resultado.valor;
                    if (Resultado.valor > 0)
                    {
                        result += 1;
                    }
                } 


                Log.Debug(DateTime.Now + " SaludRecetaIngresoMantenimiento ListaMirth Cantidad " + ListaMirth.Count);
                */
        Boolean rrr = false;
        if (ListaMirth.Count > 0)
        {
            /**/
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

            result += Convert.ToInt32(rrr);
            //return Convert.ToInt32(rrr);
        }

        return result;
    }

    public static int SaveDiagnosticoXXX()
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
            return Convert.ToInt32(rrr);
        }
        else
        {
            return 1;
        }
    }

    public static int SavePlanTrabajoXXX()
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
            return Convert.ToInt32(rrr);
        }
        else
        {
            return 1;
        }
    }

    public static int SaveDescansoMedicoXXX()
    {
        SS_HC_DescansoMedico_FE localEnty = new SS_HC_DescansoMedico_FE();
        localEnty.Accion = "LISTAR";

        localEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
        localEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
        localEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
        localEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;

        var Listar = new List<SS_HC_DescansoMedico_FE>();
        Listar = SvcDescansoMedicoServiceFE.DescansoMedicoListar(localEnty);

        if (Listar.Count == 0)
        {
            return 1;
        }

        List<VW_SS_HCE_VisorDescansoMedico> ListaMirth = new List<VW_SS_HCE_VisorDescansoMedico>();
        foreach (SS_HC_DescansoMedico_FE objEntity in Listar)
        {
            VW_SS_HCE_VisorDescansoMedico EntyMIrth = new VW_SS_HCE_VisorDescansoMedico();
            EntyMIrth.Sucursal = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            EntyMIrth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
            EntyMIrth.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
            EntyMIrth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            EntyMIrth.FechaInicio = objEntity.FechaInicioDescanso;
            EntyMIrth.FechaFinal = objEntity.FechaFinDescanso;
            EntyMIrth.Observaciones = objEntity.Observacion;
            EntyMIrth.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
            EntyMIrth.FechaCreacion = DateTime.Now;
            EntyMIrth.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            EntyMIrth.FechaModificacion = DateTime.Now;
            EntyMIrth.Estado = objEntity.Estado;
            ListaMirth.Add(EntyMIrth);
        }

        ViewResponse LocalEnty = new ViewResponse();
        LocalEnty.valor = 1;
        LocalEnty.msg = Newtonsoft.Json.JsonConvert.SerializeObject(ListaMirth);
        var URL_SERVER = ConfigurationManager.AppSettings.Get("ApiRest");
        HttpClient clienteHttp = new HttpClient();
        clienteHttp.BaseAddress = new Uri(URL_SERVER);

        int rpta = 0;
        var request = clienteHttp.PostAsync("Mirth/Mirth_SaludDescansoMedicoMantenimiento", LocalEnty, new JsonMediaTypeFormatter()).Result;
        if (request.IsSuccessStatusCode)
        {
            var resultString = request.Content.ReadAsStringAsync().Result;
            ViewResponse Resultado = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(ViewResponse));
            if (Resultado.valor > 0)
            {
                rpta = 1;
            }
        }
        clienteHttp.Dispose();

        return rpta;
    }

    public static int SaveSaludInformePROCXXXX()
    {
        var obj = new SS_HC_ApoyoDiagnostico_FE();
        var listar = new List<SS_HC_ApoyoDiagnostico_FE>();

        obj.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
        obj.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
        obj.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
        obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

        //Busqueda:
        listar = SvcApoyoDiagnosticoFE.ApoyoCabecera_Listar(obj).ToList();

        // si no encuentra se excluye
        if (listar.Count() < 1) { return 1; }

        //Preparacion:
        SS_IT_SaludInformePROCIngreso objDetalleMirth = new SS_IT_SaludInformePROCIngreso();

        foreach (SS_HC_ApoyoDiagnostico_FE listado in listar)
        {
            objDetalleMirth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
            objDetalleMirth.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
            objDetalleMirth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            objDetalleMirth.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            objDetalleMirth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objDetalleMirth.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objDetalleMirth.Informe = listado.Observacion;
            objDetalleMirth.Estado = 2;
            objDetalleMirth.UsuarioCreacion = listado.UsuarioModificacion;
            objDetalleMirth.UsuarioModificacion = listado.UsuarioModificacion;
            objDetalleMirth.FechaCreacion = DateTime.Now;
            objDetalleMirth.FechaModificacion = DateTime.Now;
        }

        //Envio
        ViewResponse localEnviado = new ViewResponse();
        localEnviado.valor = 1;
        localEnviado.msg = Newtonsoft.Json.JsonConvert.SerializeObject(objDetalleMirth);

        var URL_SERVER = ConfigurationManager.AppSettings.Get("ApiRest");
        HttpClient clienteHttp = new HttpClient();
        clienteHttp.BaseAddress = new Uri(URL_SERVER);

        int result = 0;
        var request = clienteHttp.PostAsync("Mirth/SaludInformePROCIngresoMantenimiento", localEnviado, new JsonMediaTypeFormatter()).Result;
        if (request.IsSuccessStatusCode)
        {
            var resultString = request.Content.ReadAsStringAsync().Result;
            ViewResponse resultado = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(ViewResponse));
            localEnviado.valor = resultado.valor;
            if (resultado.valor > 0)
            {
                result += 1;
            }
        }
        clienteHttp.Dispose();

        //preparar segundo envio
        List<SS_IT_SaludInformeRutaIngreso> ListaMirth = new List<SS_IT_SaludInformeRutaIngreso>();
        foreach (SS_HC_ApoyoDiagnostico_FE listado in listar)
        {
            SS_IT_SaludInformeRutaIngreso EntyMIrth = new SS_IT_SaludInformeRutaIngreso();
            EntyMIrth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            EntyMIrth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
            EntyMIrth.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
            EntyMIrth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            EntyMIrth.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            EntyMIrth.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            EntyMIrth.RutaInforme = listado.RutaInforme;
            EntyMIrth.Observacion = listado.Nombre;
            //EntyMIrth.Estado = objEntity.Estado;
            EntyMIrth.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
            EntyMIrth.FechaCreacion = DateTime.Now;
            EntyMIrth.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            EntyMIrth.FechaModificacion = DateTime.Now;
            EntyMIrth.Estado = 2;
            ListaMirth.Add(EntyMIrth);
        }

        ViewResponse MirthEnty = new ViewResponse();
        MirthEnty.valor = 1;
        MirthEnty.msg = Newtonsoft.Json.JsonConvert.SerializeObject(ListaMirth);

        var URL_SERVER02 = ConfigurationManager.AppSettings.Get("ApiRest");
        HttpClient clienteHttp02 = new HttpClient();
        clienteHttp02.BaseAddress = new Uri(URL_SERVER02);

        var request02 = clienteHttp02.PostAsync("Mirth/SaludInformeRutaIngresoMantenimiento", MirthEnty, new JsonMediaTypeFormatter()).Result;
        if (request02.IsSuccessStatusCode)
        {
            var resultString02 = request02.Content.ReadAsStringAsync().Result;
            ViewResponse resultado2 = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString02, typeof(ViewResponse));
            if (resultado2.valor > 0)
            {
                result += 1;
            }
        }
        clienteHttp02.Dispose();

        return result;
    }

    #region OFTALMOLOGICO

    public static int SaveOftalmologicoXXX()
    {
        try
        {
            //LISTAR VALORES
            SS_HC_Oftalmologico_FE recuperado = new SS_HC_Oftalmologico_FE();
            List<SS_HC_Oftalmologico_FE> listaRecuperados = new List<SS_HC_Oftalmologico_FE>();

            recuperado.Accion = "LISTAR";

            bool hallado = false;
            recuperado.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            recuperado.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            recuperado.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            recuperado.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

            listaRecuperados = SvcOftalmologicoFEService.OftalmologicoListar(recuperado);

            if (listaRecuperados.Count < 1)
            {
                //no existe registro... 
                return 1;
            }
            // ------Migración Rest---------

            SS_IT_SaludOFTALMOLOGICOIngreso ListaMirth = new SS_IT_SaludOFTALMOLOGICOIngreso();


            var LocalEnfermedadAct = new SS_HC_EnfermedadActual_FE();
            var ListarEnfermedadAct = new List<SS_HC_EnfermedadActual_FE>();
            LocalEnfermedadAct.Accion = "LISTAR";
            LocalEnfermedadAct.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnfermedadAct.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            LocalEnfermedadAct.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            LocalEnfermedadAct.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            ListarEnfermedadAct = SvcEnfermedadActualServiceFE.ApoyoCabecera_Listar(LocalEnfermedadAct).ToList();

            foreach (SS_HC_EnfermedadActual_FE ObjTraceEnfermedad in ListarEnfermedadAct)
            {
                ListaMirth.ENFACTUAL = ObjTraceEnfermedad.RelatoCronologico;
            }

            foreach (SS_HC_Oftalmologico_FE objEntity in listaRecuperados)
            {
                ListaMirth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                ListaMirth.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                ListaMirth.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                ListaMirth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                ListaMirth.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                ListaMirth.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ListaMirth.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                ListaMirth.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                //ListaMirth.Secuencia = ENTITY_GLOBAL.Instance.SECUENCIAL_HCE;
                //ListaMirth.ENFACTUAL = objSave.ScicloPejiaOIzqEsfera;

                ListaMirth.AvCCOD = objEntity.AVccODerecho;
                ListaMirth.AVscOD = objEntity.AVscODerecho;
                ListaMirth.CERCAVAD = objEntity.CercaODerecho;

                ListaMirth.AVCCOI = objEntity.AVccOIzquierdo;
                ListaMirth.AVSCOI = objEntity.AVscOIzquierdo;
                ListaMirth.CERCAVAOI = objEntity.CercaOIzquierdo;
                ListaMirth.AEAVODPIN = objEntity.PinHoldODerecho;
                ListaMirth.AEAVOIDPIN = objEntity.PinHoldOIzquierdo;

                ListaMirth.SPHodREFRA = objEntity.RefraODerechoEsfera;
                ListaMirth.CILodREFA = objEntity.RefraODerechoCilindro;
                ListaMirth.EJEodREFRA = objEntity.RefraODerechoEje;
                ListaMirth.AVodREFRA = objEntity.RefracODerechoAV;
                ListaMirth.ADDodREFRA = objEntity.RefracODerechoADD;
                ListaMirth.DIPodREFRA = objEntity.RefracODerechoDIP;
                ListaMirth.SPHoiSCICLO = objEntity.ScicloPejiaOIzqEsfera;
                ListaMirth.CILoiSCICLO = objEntity.ScicloPejiaOIzqCilindro;
                ListaMirth.EJEoiSCICLO = objEntity.ScicloPejiaOIzqEje;
                ListaMirth.AVoiSCICLO = objEntity.CciclopejiaOIzqAV;
                ListaMirth.ADDoiSCICLO = objEntity.CciclopejiaOIzqADD;
                ListaMirth.DIPoiSCICLO = objEntity.CciclopejiaOIzqDIP;
                ListaMirth.PAPARPADOSANEXOS = objEntity.Parpados_anexos;
                ListaMirth.CORNEACRISTESCLERA = objEntity.Cornea_Cristalino_Esclera;
                ListaMirth.IRISPUPILA = objEntity.Iris_Pupila;
                ListaMirth.TonoOD = objEntity.TonODerecho;
                ListaMirth.TonoOI = objEntity.TonOIzquierdo;
                ListaMirth.MMHHTonShiotz = objEntity.TonShiotz + "/" + objEntity.TonAplanacion + "/" + objEntity.TonOtra;
                ListaMirth.FONDOJOyG = objEntity.FondOjo_GoniosCopia;
                ListaMirth.Estado = 2;
                ListaMirth.UsuarioCreacion = objEntity.UsuarioCreacion;
                ListaMirth.FechaCreacion = objEntity.FechaCreacion;
                ListaMirth.UsuarioModificacion = objEntity.UsuarioModificacion;
                ListaMirth.FechaModificacion = objEntity.FechaModificacion;
            }

            var serializa = Newtonsoft.Json.JsonConvert.SerializeObject(ListaMirth);

            int registro = 0;

            ViewResponse LocalEnty = new ViewResponse();
            LocalEnty.valor = 1;
            LocalEnty.msg = serializa;

            var URL_SERVER = ConfigurationManager.AppSettings.Get("ApiRest");
            HttpClient clienteHttp = new HttpClient();
            clienteHttp.BaseAddress = new Uri(URL_SERVER);

            var request = clienteHttp.PostAsync("Mirth/Mirth_OftalmologicoIngresoMantenimiento", LocalEnty, new JsonMediaTypeFormatter()).Result;
            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;
                ViewResponse Resultado = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(ViewResponse));

                if (Resultado.valor <= 0) // || Resultado.valor == null)
                {
                    return 0;
                }

                registro = Convert.ToInt32(Resultado.valor);

            }
            else
            {
                Log.Debug(DateTime.Now + " Mirth_OftalmologicoIngresoMantenimiento ", LocalEnty);
                registro = 0;
            }
            clienteHttp.Dispose();

            // -----------------------------

            //        if (Session["containerIdTemp"] != null && Session["textTemp"] != null)
            //        {
            //            string containertemp = (string)Session["containerIdTemp"];
            //            string txttemp = (string)Session["textTemp"];

            //            LoadFormatos(containertemp, txttemp);
            //            return showMensajeNotify("Mensaje", mensaje, "INFO");
            //        }
            //        else
            //        {

            //            return showMensajeNotify("Mensaje", mensaje, "INFO");
            //        }
            //    }
            //    else
            //    {
            //        eventoPostFormulario(false, "");
            //        return showMensajeNotifyData("Error", "Sucedio un error inesperado en F153", "ERROR", false);
            //    }
            //}
            //else
            //{
            //    eventoPostFormulario(false, "");
            //    return showMensajeNotifyData("Error", "No se pudo obtener el registro actual en F153", "ERROR", false);
            //}

            return registro;
        }
        catch (Exception e)
        {
            return 0;
        }

    }

    #endregion

}
