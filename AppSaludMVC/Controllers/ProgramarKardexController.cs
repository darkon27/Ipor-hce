using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using Ext.Net;
using Ext.Net.MVC;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryReport;
using Ext.Net.Utilities;

namespace AppSaludMVC.Controllers
{
    using SoluccionSalud.Service._FormularioNuevo;

    using SvcAuditoriaImpresion = SoluccionSalud.Service.AuditoriaImpresionService.SvcAuditoriaImpresion;
    using SvcDiccionario = SoluccionSalud.Service.DiccionarioService.SvcDiccionario;
    using SvcSeguridad = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto;
    using SvcSeguridadConcepto = SoluccionSalud.Service.SeguridadConceptoService.SvcSeguridadConcepto;
    using SvcPersonaMast = SoluccionSalud.Service.PersonaMastService.SvcPersonaMast;
    using SvcEnfermedadActual = SoluccionSalud.Service.Formularios.SvcEnfermedadActual;
    using SvcMiscelaneos = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos;
    using SvcFormularios = SoluccionSalud.Service.FormulariosService.SvcFormularios;
    using SvcFormularioAnamnesisAP = SoluccionSalud.Service.FormulariosService.SvcFormularioAnamnesisAP;
    using SvcAnamnesisEAService = SoluccionSalud.Service.FormulariosService.SvcAnamnesisEAService;
    using SvcMiscelaneoFormularioCrono = SoluccionSalud.Service.MiscelaneoFormularioService.SvcMiscelaneoFormularioCrono;
    using SvcRegistroAcompanante = SoluccionSalud.Service.RegistrarAcompananteService.SvcRegistroAcompanante;
    using SvcDiagnosticoService = SoluccionSalud.Service.FormulariosService.SvcDiagnosticoService;
    using SvcExamenFisicoTriajeService = SoluccionSalud.Service.FormulariosService.SvcExamenFisicoTriajeService;
    using SvcAnamnesisAFService = SoluccionSalud.Service.FormulariosService.SvcAnamnesisAFService;
    using SvcProblemasService = SoluccionSalud.Service.FormulariosService.SvcProblemasService;
    using SvcExamenSolicitadoService = SoluccionSalud.Service.FormulariosService.SvcExamenSolicitadoService;
    using SvcMedicamentoService = SoluccionSalud.Service.FormulariosService.SvcMedicamentoService;
    using SvcProximaAtencionService = SoluccionSalud.Service.FormulariosService.SvcProximaAtencionService;
    using SvcDescansoMedicoService = SoluccionSalud.Service.FormulariosService.SvcDescansoMedicoService;
    using SvcVw_Personapaciente = SoluccionSalud.Service.VW_PERSONAPACIENTEService.SvcVw_Personapaciente;
    using SvcV_EpisodioAtenciones = SoluccionSalud.Service.V_EpisodioAtencionesService.SvcV_EpisodioAtenciones;
    //using SvcCuidadoPreventivo = SoluccionSalud.Service.CuidadoPreventivoService.SvcCuidadoPreventivo;
    using SvcSeguimientoRiesgoDetalle = SoluccionSalud.Service.SeguimientoRiesgoDetalleService.SvcSeguimientoRiesgoDetalle;
    using SvcSeguimientoRiesgo = SoluccionSalud.Service.SeguimientoRiesgoService.SvcSeguimientoRiesgo;
    using SvcFavoritoDetalle = SoluccionSalud.Service.FavoritoDetalleService.SvcFavoritoDetalle;
    using SvcFavoritoNumero = SoluccionSalud.Service.FavoritoNumeroService.SvcFavoritoNumero;

    using SvcOrdAtenPreexistencia = SoluccionSalud.Service.OrdAtenPreexistenciaService.SvcOrdAtenPreexistencia;
    using SvcVw_Favoritos = SoluccionSalud.Service.WH_FavoritosService.SvcVW_FavoritosService;
    using SvcFavoritoCodigoId = SoluccionSalud.Service.FavoritoCodigoService.SvcFavoritoCodigo;
    using SvcEpisodioAtencion = SoluccionSalud.Service.EpisodioAtencionService.SvcEpisodioAtencion;
    using SvcProcedimientoEjecucion = SoluccionSalud.Service.ProcedimientoEjecucionService.SvcProcedimientoEjecucion;
    using SvcProcedimientoInforme = SoluccionSalud.Service.ProcedimientoInformeService.SvcProcedimientoInforme;
    using SvcParametro = SoluccionSalud.Service.ParametroService.SvcParametro;
    using SvcEpisodioClinico = SoluccionSalud.Service.EpisodioClinicoService.SvcEpisodioClinico;
    using SvcVw_AtencionPaciente = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente;
    using SvcVWEspecialidadMedico = SoluccionSalud.Service.VWEspecialidadMedicoService.SvcVWEspecialidadMedico;
    using SvcSS_CC_Horario = SoluccionSalud.Service.HorarioService.SvcSS_CC_Horario;
    using SvcDiagnostico = SoluccionSalud.Service.DiagnosticoService.SvcDiagnostico;
    using SvcCategoriaUnidadServicio = SoluccionSalud.Service.CategoriaUnidadServicioService.SvcCategoriaUnidadServicio;

    using SvcEvolucionObjetivaService = SoluccionSalud.Service.FormulariosService.SvcEvolucionObjetivaService;
    using ServiciosRules = SoluccionSalud.Service.AccionesServiceRules.ServiciosRules;
    using SvcNotificacionDetalle = SoluccionSalud.Service.NotificacionDetalleService.SvcNotificacionDetalle;
    using SvcNanda = SoluccionSalud.Service.NandaService.SvcNanda;
    using SvcDiagnosticoFE = SoluccionSalud.Service._FormularioNuevo.SvcDiagnosticoFE;
    using SvcDiagnosticoPAE = SoluccionSalud.Service.PAEDiagnostico.SvcDiagnosticoPAE;
    using SvcFactorRelacionadoNanda = SoluccionSalud.Service.FactorRelacionadoNandaService.SvcFactorRelacionadoNanda;
    using SvcFactorRelacionado = SoluccionSalud.Service.FactorRelacionadoService.SvcFactorRelacionado;

    using svccombo = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico;
    using svcVw_AtencionPacienteMedicamento = SoluccionSalud.Service.VW_ATENCIONPACIENTEMEDICAMENTOS.svcVw_AtencionPacienteMedicamento;
    //using SvcMedicamentoFE = SoluccionSalud.Service._FormularioNuevo.SvcMedicamentoFE;
    using svcSS_FA_SolicitudProducto = SoluccionSalud.Service.SS_FA_SolicitudProductos.svcSS_FA_SolicitudProducto;
    using svcSS_HC_KardexEnfermeria = SoluccionSalud.Service.KardexEnfermeria.svcSS_HC_KardexEnfermeria;
    using SvcSG_Agente = SoluccionSalud.Service.SG_AgenteService.SvcSG_Agente;



    using AppSaludMVC.Models;
    using SoluccionSalud.Service.FormulariosService;
    using System.Collections;
    using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
    using Microsoft.Practices.EnterpriseLibrary.Logging;
    using System.Data.SqlClient;
    using SoluccionSalud.Componentes;
    using System.Web;
    using SoluccionSalud.Service.AccionesServiceRules;

    using HtmlX = SoluccionSalud.Entidades.Entidades.SS_HC_BANDEJA_NOTIFI_DETALLE;
    using Serilog;

    public class ProgramarKardexController : ControllerGeneral
    {
        public ProgramarKardexController()
        {
        }

        public System.Web.Mvc.ActionResult Index()
        {
            Log.Information("ProgramarKardexController - Index - Entrar");
            setVariablesTempSession_Default(UTILES_MENSAJES.PATH_MAIN_HCLINICA);
            ////OBTENER DATOS DE LA PERSONA-MEDICO-USUARIO
            List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            //OBS:ADD de seguridad
            //obj.CentroCostos = ENTITY_GLOBAL.Instance.UnidadReplicacion; //AUX ..
            //*obj.CodigoCargo = (int)ENTITY_GLOBAL.Instance.PacienteID;
            int ini = 0;
            if (Session["TIPOATENCION_ACTUAL"] != null)
            {
                ini = (int)Session["TIPOATENCION_ACTUAL"];
            }
            int fin = 0;
            obj.AFE = ENTITY_GLOBAL.Instance.Establecimiento;//Para obtener Nombre de Estab. Seleccionado
            obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            obj.ACCION = "LISTARPORIDKARDEX";


            lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, ini, fin);
            if (lista.Count > 0)
            {
                foreach (var result in lista)
                {
                    obj = result;
                }
                /**OBS  en el caso hubiera más de un registro, podría ser a causa de diferentes perfiles permitidos.
                       revisar stored: SP_VW_PERSONAPACIENTE_LISTAR */
                ENTITY_GLOBAL.Instance.OPCION_PADRE = lista[0].Servicio;   //OBS: seguridad            
                ENTITY_GLOBAL.Instance.PERFILACTUAL = lista[0].Observacion;   //OBS: seguridad     

                setCodigoFormatosPaginas("GENERAL", lista[0].CodigoPlan);  //OBS: PAG. DEFAULT            

                Session["TIPOTRABAJADOR_ACTUAL"] = lista[0].TipoTrabajador;
                Session["NOMBRE_USUARIO_MEDICO"] = lista[0].NombreCompleto;
                //}
                //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 2;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION2 = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;



                //           
            }
            return View(obj);
        }
        public System.Web.Mvc.ActionResult LoadBandejaEntrada()
        {
            Log.Information("ProgramarKardexController - LoadBandejaEntrada - Entrar");
            return this.RedirectToAction("Index", "BandejaMedico");
        }
        public PartialViewResult VisorFormularios(
            string unidadReplicacion, Nullable<int> paciente,
            Nullable<int> Clinico, Nullable<long> Atencion, string Form, string Accion)
        {
            Log.Information("ProgramarKardexController - VisorFormularios - Entrar");
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new SEGURIDADCONCEPTO();
            string estado = "PanelCentralBlanco";
            if (Clinico <= 0)
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
                //ENTITY_GLOBAL.Instance.EpisodioAtencion = Atencion;
                /**CONTROL DE CAMPOS FILROS DE LA CRONOLOG SELECCIONDA**/
                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 1;
                ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP = ENTITY_GLOBAL.Instance.PacienteID;
                ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP = ENTITY_GLOBAL.Instance.EpisodioClinico;
                ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION_TEMP = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION_TEMP = ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION;
                /************************************/
                objMiscl.ACCION = "VISTA_FORM";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.ValorCodigo1 = Accion.Trim();
                objMiscl.ValorCodigo2 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                objMiscl.CodigoTabla = Accion.Trim();
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
                if (resulMiscelaneosTitulo.Count > 0)
                {
                    estado = "VisorFormularios";
                    model.CONCEPTO = resulMiscelaneosTitulo[0].CodigoTabla.Trim() + "_View";
                    model.DESCRIPCION = resulMiscelaneosTitulo[0].DescripcionLocal;
                    /*
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                    ENTITY_GLOBAL.Instance.VistaPacienteID = ENTITY_GLOBAL.Instance.PacienteID;
                    ENTITY_GLOBAL.Instance.VistaEpisodioClinico = Clinico;
                    ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = Atencion;
                     * */

                    ENTITY_GLOBAL.Instance.UnidadReplicacion = unidadReplicacion;
                    ENTITY_GLOBAL.Instance.PacienteID = paciente;
                    ENTITY_GLOBAL.Instance.EpisodioClinico = Clinico;
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = Atencion;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";

                    ENTITY_GLOBAL.Instance.CONCEPTO = resulMiscelaneosTitulo[0].CodigoTabla;

                }

            }

            return crearWindowRegistro(estado, model, "", "South1");

            /*
            return new PartialViewResult
            {
                ViewName = estado,
                ContainerId = "South1",
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };*/
        }

        /***/
        public PartialViewResult VisorHCEReportes(int idPaciente, int idOrdenAtencion,
            string codFormato, string codigoOA, string Accion, string nombrePaciente, string Form, string FormContainer)
        {
            Log.Information("ProgramarKardexController - VisorHCEReportes - Entrar");
            Log.Debug("ProgramarKardexController - VisorHCEReportes - idPaciente {A}, idOrdenAtencion {B}, codFormato {C}, codigoOA {D}"
                        , idPaciente, idOrdenAtencion, codFormato, codigoOA);

            var model = ENTITY_GLOBAL.Instance;
            //ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto;

            string host = System.Web.HttpContext.Current.Request.Url.Host;
            //string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
            string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
            string path = System.Web.HttpContext.Current.Request.ApplicationPath;

            /**MANDAR EN UN CAMPO SI ES NECESARIO*/
            //model.UsuarioModificacion = hostPort + path;            
            return crearWindowRegistro(Form, model, "", FormContainer);

        }

        public System.Web.Mvc.ActionResult eventoLoadReporteTest(string containerId, string text)
        {
            Log.Information("ProgramarKardexController - eventoLoadReporteTest - Entrar");
            var model = new SS_HC_EpisodioAtenciones();
            ComponentLoader xCompo = X.GetCmp<Ext.Net.ComponentLoader>("compLoaderReporte");
            xCompo.Url = "http://localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I";
            xCompo.LoadContent();
            return this.Direct();
            /*
            return new PartialViewResult
            {
                ViewName = "http://localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I",
                ContainerId = containerId,
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };*/
        }

        /***/
        public System.Web.Mvc.ActionResult eventoLoadReporte(string containerId, string text)
        {
            try
            {
                Log.Information("ProgramarKardexController - eventoLoadReporte - Entrar");
                List<ENTITY_MENSAJES> contenidoReport = new List<ENTITY_MENSAJES>();
                ENTITY_MENSAJES objInfo = new ENTITY_MENSAJES();
                //String UrlFormato = "PanelCentralBlanco";
                String accionReporte = null;
                String UrlPathReporte = "";
                var objVistaSeguridad = new SS_CHE_VistaSeguridad();
                objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                objVistaSeguridad.Accion = "DATOSFORMULARIO";
                if (text.Trim() != "root")
                {
                    objVistaSeguridad.IdOpcion = Convert.ToInt32(text.Trim());
                    var model = new SS_HC_EpisodioAtenciones();
                    model.IdOpcion = text.Trim();
                    var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);
                    if (resulListado.Count > 0)
                    {
                        switch (resulListado[0].TipoFormato)
                        {
                            case 2:
                                //FIJO
                                //UrlFormato = "PanelCenter"; //resulListado[0].CodigoFormato;
                                model.CONCEPTO = resulListado[0].CodigoFormato.Trim();
                                objInfo.TIPOMSG = "FFIJO";
                                accionReporte = model.CONCEPTO;
                                //accionReporte = "CCEP0003";

                                /*
                                if ("CCEP0003" == model.CONCEPTO)
                                {
                                     //ANAMNESIS EA
                                    accionReporte = "CountryListReport";
                                }
                                else
                                {
                                    accionReporte = "CountryListReport";
                                }*/
                                break;
                            case 3:
                                //DINÁMICO
                                string searchForThis = "weasis";
                                objInfo.TIPOMSG = "FDINAM";
                                break;
                            default:
                                if (resulListado[0].CodigoFormato != null)
                                {
                                    model.CONCEPTO = resulListado[0].CodigoFormato.Trim() + "_View";
                                }
                                //UrlFormato = "PanelCentralBlanco";
                                break;

                        }
                    }
                    if (accionReporte != null)
                    {
                        string host = System.Web.HttpContext.Current.Request.Url.Host;
                        string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
                        //string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
                        string path = System.Web.HttpContext.Current.Request.ApplicationPath;

                        /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                        UrlPathReporte = hostPort + path;

                        objInfo.IDMSG = 1;
                        objInfo.TITULO = UrlPathReporte;
                        objInfo.DESCRIPCION = accionReporte;
                        /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                        //model.UsuarioModificacion = hostPort + path; 
                        contenidoReport.Add(objInfo);

                        return this.Store(contenidoReport);
                    }
                    else
                    {
                        return this.Direct();
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - eventoLoadReporte - Bloque Catch");
                Log.Error(ex, ex.Message);
                return showMsgTratamientoExcepcion(ex, "");
            }
            return this.Direct();
            /*
            return new PartialViewResult
            {
                ViewName = UrlFormato,
                ContainerId = containerId,
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };*/
        }


        /***/
        public PartialViewResult VisorHCExternoManuales(int idPaciente, int idOrdenAtencion,
            string codFormato, string codigoOA, string Accion, string nombrePaciente, string Form, string FormContainer)
        {
            Log.Information("ProgramarKardexController - VisorHCExternoManuales - Entrar");
            Log.Debug("ProgramarKardexController - VisorHCExternoManuales - idPaciente {A}, idOrdenAtencion {B}, codigoOA {C}, hay mas parametros"
                       , idPaciente, idOrdenAtencion, codigoOA);
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new V_EpisodioAtenciones();
            //ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto;
            model.NombreCompleto = ENTITY_GLOBAL.Instance.NombreCompletoPaciente;
            model.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            //model.IdOrdenAtencion = idOrdenAtencion;
            //model.UsuarioCreacion = codFormato; //FORMATO
            model.Accion = Accion;
            model.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            string host = System.Web.HttpContext.Current.Request.Url.Host;
            //string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
            string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
            string path = System.Web.HttpContext.Current.Request.ApplicationPath;

            model.UsuarioModificacion = hostPort + path;

            string estado = "PanelCentralBlanco";
            return crearWindowRegistro(Form, model, "", FormContainer);

        }
        public StoreResult ArbolDocHCEManuales(string node, string Accion,
            string formato, string codigoOA, string idPaciente, string idOrdenAtencion,
            string tipoAtencion, string especialidad, string medico, string unidadServ, string diagnostico
            )
        {
            NodeCollection nodes = new Ext.Net.NodeCollection();
            MA_MiscelaneosDetalle LocalEnty = new MA_MiscelaneosDetalle();
            List<MA_MiscelaneosDetalle> Listar = new List<MA_MiscelaneosDetalle>();
            try
            {
                Log.Information("ProgramarKardexController - ArbolDocHCEManuales - Entrar");
                Log.Debug("ProgramarKardexController - ArbolDocHCEManuales - idPaciente {A}, idOrdenAtencion {B}, codigoOA {C}, hay mas parametros"
                           , idPaciente, idOrdenAtencion, codigoOA);
                int tipo = 0;
                string id = "0";
                string segPag = "0";
                string[] compoNodoId = node.Split('|');
                if (compoNodoId.Length > 2)
                {
                    tipo = Convert.ToInt32(compoNodoId[0]);
                    id = compoNodoId[1];
                    segPag = compoNodoId[2];
                }
                if (tipo == 1)
                {
                    //LocalEnty.ValorCodigo2 = idOrdenAtencion;
                    //LocalEnty.ValorCodigo3 = idPaciente;
                    //////////
                    LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    LocalEnty.ValorCodigo2 = idPaciente;
                    LocalEnty.ACCION = "VIRTDOCUMENT";
                    LocalEnty.UltimoUsuario = ENTITY_GLOBAL.Instance.USUARIO;
                    LocalEnty.ValorNumerico = Convert.ToDouble(id);
                    //////////
                    LocalEnty.ValorEntero1 = getValorFiltroInt(tipoAtencion);
                    LocalEnty.ValorEntero2 = getValorFiltroInt(especialidad);
                    LocalEnty.ValorEntero3 = getValorFiltroInt(medico);
                    LocalEnty.ValorEntero4 = getValorFiltroInt(unidadServ);
                    LocalEnty.ValorEntero5 = getValorFiltroInt(diagnostico);
                    //////////
                    Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(LocalEnty, 0, 0);
                }
                else if (tipo == 2)
                {
                    LocalEnty.ValorNumerico = 0;
                }
                if (Listar != null)
                {
                    foreach (var resulenti in Listar)
                    {
                        Node asyncNode = new Node();
                        ENTITY_GLOBAL.Instance.PacienteDatos1 = resulenti.DescripcionExtranjera;
                        // SiteMapNode siteNode = SiteMap.RootNode;
                        //  SiteMapNode smNode = new
                        //           SiteMapNode(siteNode.Provider, "Key", "~/", "Default");
                        // siteNode.ChildNodes.Add(smNode);
                        String url = resulenti.DescripcionExtranjera + resulenti.ValorCodigo1;
                        //url = url.Replace("\\", "/");
                        asyncNode.Text = resulenti.DescripcionLocal;
                        asyncNode.NodeID = "" + resulenti.ValorEntero3 + "|" + //Tipo
                            resulenti.ValorEntero4 + "|" + //AUX COD REF
                            resulenti.ValorEntero2 + "|" +  //PÁG
                            url; //URL
                        asyncNode.Leaf = resulenti.ValorEntero3 > 1 ? true : false;  //INDICA SI ES CARPETA o NO
                        if (resulenti.ValorNumerico != null)
                        {
                            if (resulenti.ValorEntero3 > 1)
                            {
                                if (resulenti.ValorNumerico == 2)
                                    asyncNode.Icon = Icon.PageGreen;
                                else
                                    asyncNode.Icon = Icon.PageRed;
                            }
                        }
                        nodes.Add(asyncNode);
                    }
                }
                //OBS:ADD de seguridad
                return this.Store(nodes);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - ArbolDocHCEManuales - Bloque Catch");
                Log.Error(ex, ex.Message);
                throw ex;
            }
        }

        public System.Web.Mvc.ActionResult getSeleccionMedicoEsp_DocHC(String MODO, int persona, String cmp,
            Nullable<int> especialidad,
            String nombre, String idWindow)
        {
            Log.Information("ProgramarKardexController - getSeleccionMedicoEsp_DocHC - Entrar");
            Log.Debug("ProgramarKardexController - getSeleccionMedicoEsp_DocHC - MODO {A}, persona {B}, nombre {C}"
                        , MODO, persona, nombre);
            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var nf = X.GetCmp<NumberField>("txtFiltroIdMedico_HCDoc");
            if (persona != null) { nf.SetValue(persona); }

            var tfNom = X.GetCmp<TextField>("txtFiltroDescMedico_HCDoc");
            if (nombre != null && nombre != "") { tfNom.SetValue(nombre); }

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult getSeleccionDiagnostico_DocHC(String MODO, int id,
            String cod, String descripcion, String idWindow)
        {
            Log.Information("ProgramarKardexController - getSeleccionDiagnostico_DocHC - Entrar");
            Log.Debug("ProgramarKardexController - getSeleccionDiagnostico_DocHC - MODO {A}, id {B}, cod {C}"
                        , MODO, id, cod);
            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var nf = X.GetCmp<NumberField>("nfFiltroIdDiagnostico_HCDoc");
            if (id != null && id != 0) { nf.SetValue(id); }
            var tfCod = X.GetCmp<NumberField>("txtFiltroCodDiagnostico_HCDoc");
            if (cod != null && cod != "") { tfCod.SetValue(cod); }

            var tfNom = X.GetCmp<TextField>("txtFiltroDescDiagnostico_HCDoc");
            if (descripcion != null && descripcion != "") { tfNom.SetValue(descripcion); }

            return this.Direct();
        }

        public System.Web.Mvc.ActionResult getSeleccionCatUnidadServicio_DocHC(String MODO, int id, String codigo, String descripcion, String idWindow)
        {
            Log.Information("ProgramarKardexController - getSeleccionCatUnidadServicio_DocHC - Entrar");
            Log.Debug("ProgramarKardexController - getSeleccionDiagnostico_DocHC - MODO {A}, id {B}, descripcion {C}"
                        , MODO, id, descripcion);
            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }

            var nf = X.GetCmp<NumberField>("nfIdUnidadServicio_HCDoc");
            nf.SetValue(id);
            var txt = X.GetCmp<TextField>("tfUnidServ_HCDoc");
            txt.SetValue(descripcion);
            return this.Direct();
        }
        public PartialViewResult loadDocHCExternoManuales(string Accion,
            string nombre, string Form, string FormContainer)
        {
            Log.Information("ProgramarKardexController - loadDocHCExternoManuales - Entrar");
            Log.Debug("ProgramarKardexController - loadDocHCExternoManuales - Accion {A}, nombre {B}, Form {C}"
                        , Accion, nombre, Form);
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new V_EpisodioAtenciones();
            model.NombreCompleto = nombre;
            model.Accion = Accion;
            string estado = "PanelCentralBlanco";

            return new PartialViewResult
            {
                ViewName = Form,
                ContainerId = FormContainer,
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };
        }

        public System.Web.Mvc.ActionResult visorFormProcesos(String url, Object objModel, String titulo)
        {
            Log.Information("ProgramarKardexController - visorFormProcesos - Entrar");
            Log.Debug("ProgramarKardexController - visorFormProcesos - url {A}, objModel {B}, titulo {C}"
                        , url, objModel, titulo);
            return new Ext.Net.MVC.PartialViewResult
            {
                ViewName = url
                //  Model = objModel
            };
        }

        #region ActioResult_BuscadoRegistros
        public System.Web.Mvc.ActionResult BuscadorRegistro(String MODO, String usuario)
        {
            Log.Information("ProgramarKardexController - BuscadorRegistro - Entrar");
            //var field = X.GetCmp<TreePanel>("treeMain");
            //field.RemoveAll();
            ENTITY_GLOBAL.Instance.objModel = null;
            HC_Medicamento objAutorizac = new HC_Medicamento();
            //var Listar = new List<USUARIO>();
            if (MODO == "NUEVO")
            {
                objAutorizac.Accion = "NUEVO";
            }
            objAutorizac.Accion = MODO;

            //objPefilUsuario.PERFIL = objUsuario.USUARIO1;
            //return View("Maestros/Usuario/UsuarioRegistro", objUsuario);

            objAutorizac.Accion = MODO;


            return NewPageWindows("Buscadores/BuscarMedicamento_View", objAutorizac, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        /*********************************************************************************/
        /*********************************************************************************/
        /**FORMULARIOS I FASE*/
        /*********************************************************************************/

        public System.Web.Mvc.ActionResult Familias(string Linea, string Familia, string Accion)
        {
            Log.Information("ProgramarKardexController - Familias - Entrar");

            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboGenericoTxtDos(Linea, Familia, "", "", Accion));
        }
        public System.Web.Mvc.ActionResult UnidadMedidas(string Linea, string Familia, string SubFamilia, string Accion)
        {
            Log.Information("ProgramarKardexController - UnidadMedidas - Entrar");

            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboGenericoTxtDos(Linea, Familia, SubFamilia, "", Accion));
        }
        public System.Web.Mvc.ActionResult MedicamentoListado(int start, int limit, string Linea,
           string Familia, string SubFamilia, string CodigoMedicamento, string Descripcion, string Accion)
        {
            Log.Information("ProgramarKardexController - MedicamentoListado - Entrar");

            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetGrillaGenericos(Linea, Familia, SubFamilia, Descripcion, Accion));
        }

        public System.Web.Mvc.ActionResult ReturnFindMedicamento(String modo, String linea, String familia, String subFamilia,
            String descripcion, string descripLinea, string descripFamilia, String idWindow)
        {
            Log.Information("ProgramarKardexController - ReturnFindMedicamento - Entrar");

            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            //List<MA_MiscelaneosDetalle> ObjListarActivo;
            //ObjListarActivo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(retornos, typeof(List<MA_MiscelaneosDetalle>));
            var panel = X.GetCmp<Panel>("Panel1");
            panel.Hidden = false;
            panel.Visible = true;
            var txtLinea = X.GetCmp<TextField>("Linea");
            var txtFamilia = X.GetCmp<TextField>("Familia");
            var txtSubFamilia = X.GetCmp<TextField>("SubFamilia");

            var LineaDescripcion = X.GetCmp<TextField>("LineaDescripcion");
            var FamiliaDescripcion = X.GetCmp<TextField>("FamiliaDescripcion");
            var SubFamiliaDescripcion = X.GetCmp<TextField>("SubFamiliaDescripcion");

            txtLinea.SetValue(linea);
            txtFamilia.SetValue(familia);
            txtSubFamilia.SetValue(subFamilia);

            LineaDescripcion.SetValue(descripLinea);
            FamiliaDescripcion.SetValue(descripFamilia);
            SubFamiliaDescripcion.SetValue(descripcion);
            return this.Direct();
        }



        public System.Web.Mvc.ActionResult VariableSession(String Variables, string text)
        {
            Log.Information("ProgramarKardexController - VariableSession - Entrar");
            if ((Variables != null) || (Variables.Length > 0))
            {
                List<MA_MiscelaneosDetalle> VariableGenerales = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(Variables, typeof(List<MA_MiscelaneosDetalle>));
                Session["VariableGenerales"] = VariableGenerales;
                var store = X.GetCmp<Store>("StoreDatosPrevencion");
                store.Reload();
                //var store1 = X.GetCmp<Store>("storeRiegoDetalle");
                //store1.Reload();
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult CCEP0302_storeRiegoDetalle(
            String cuidadoPreventivo, String fechaSeg, String tipoListado,
            String idTipoCuidadoPreventivo)
        {
            try
            {
                Log.Information("ProgramarKardexController - CCEP0302_storeRiegoDetalle - Entra");
                var Listar = new List<SS_HC_SeguimientoRiesgo>();
                var varRiesgo = new SS_HC_SeguimientoRiesgo();
                varRiesgo.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                varRiesgo.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                varRiesgo.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                //ES UN HISTÓRICO DE TODOS LOS EPISODIOS
                //varRiesgo.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                /*if (Session["VariableGenerales"] != null)
                {
                    var Listado = (List<MA_MiscelaneosDetalle>)Session["VariableGenerales"];
                    varRiesgo.IdTipoCuidadoPreventivo = Listado[0].ValorEntero1;
                }*/
                varRiesgo.FechaSeguimiento = getValorFiltroDate(fechaSeg);

                varRiesgo.UsuarioCreacion = cuidadoPreventivo;    //AUX PARA idCuidadoPreventivo                             
                varRiesgo.IdTipoCuidadoPreventivo = getValorFiltroInt(idTipoCuidadoPreventivo);
                varRiesgo.Accion = "LISTARDETALLE";
                Listar = SvcSeguimientoRiesgo.listarSeguimientoRiesgo(varRiesgo);
                if (Listar.Count > 0)
                {
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                }
                //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
                return this.Store(Listar.ToList());
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - CCEP0302_storeRiegoDetalle - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }
        public System.Web.Mvc.ActionResult GuardaTemporalDB(String Variables, string text)
        {
            Log.Information("ProgramarKardexController - GuardaTemporalDB - Entrar");
            var Listado = new List<SS_HC_SeguimientoRiesgoDetalle>();
            var ListadoSave = new List<SS_HC_SeguimientoRiesgoDetalle>();

            var varRiesgoDetalle = new SS_HC_SeguimientoRiesgoDetalle();
            var varRiesgo = new SS_HC_SeguimientoRiesgo();

            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();
            }
            else
            {
                try
                {
                    if ((Variables != null) || (Variables.Length > 0))
                    {
                        //GuardaTemporalPrevencion(Variables,"0");
                        /////TRANSACTION
                        List<SS_HC_SeguimientoRiesgo> listaCab = new List<SS_HC_SeguimientoRiesgo>();
                        List<SS_HC_SeguimientoRiesgoDetalle> listaDetalle = new List<SS_HC_SeguimientoRiesgoDetalle>();

                        List<MA_MiscelaneosDetalle> VariableGenerales = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(Variables, typeof(List<MA_MiscelaneosDetalle>));
                        if (VariableGenerales.Count > 0)
                        {
                            int registro = 0;
                            //CONVENIENTEMENTE PARA RECORRER PRIMERO, EN EL STORED, LAS ELIMINACIONES
                            if (Session["VariableGeneralesTempDELETE"] != null)
                            {
                                Listado = (List<SS_HC_SeguimientoRiesgoDetalle>)Session["VariableGeneralesTempDELETE"];
                            }
                            if (Session["VariableGeneralesTemp"] != null)
                            {
                                ListadoSave = (List<SS_HC_SeguimientoRiesgoDetalle>)Session["VariableGeneralesTemp"];
                            }
                            Listado.AddRange(ListadoSave);

                            // using SvcSeguimientoRiesgoDetalle = SoluccionSalud.Service.SeguimientoRiesgoDetalleService.SvcSeguimientoRiesgoDetalle;
                            // using SvcSeguimientoRiesgo = SoluccionSalud.Service.SeguimientoRiesgoService.SvcSeguimientoRiesgo;
                            varRiesgo.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                            varRiesgo.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            varRiesgo.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                            varRiesgo.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                            varRiesgo.IdTipoCuidadoPreventivo = VariableGenerales[0].ValorEntero1;
                            varRiesgo.FechaSeguimiento = VariableGenerales[0].ValorFecha;
                            varRiesgo.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                            varRiesgo.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                            //registro = SvcSeguimientoRiesgo.setMantenimiento(varRiesgo);
                            listaCab.Add(varRiesgo);

                            foreach (SS_HC_SeguimientoRiesgoDetalle obj in Listado)
                            {
                                if ((obj.IdCuidadoPreventivo != null) || obj.Accion == "DELETE")
                                {
                                    varRiesgoDetalle = new SS_HC_SeguimientoRiesgoDetalle();
                                    varRiesgoDetalle.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    varRiesgoDetalle.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    varRiesgoDetalle.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    varRiesgoDetalle.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    varRiesgoDetalle.IdCuidadoPreventivo = obj.IdCuidadoPreventivo;
                                    varRiesgoDetalle.Comentario = obj.Comentario;
                                    ////////////////////////////////////
                                    varRiesgoDetalle.Secuencia = obj.Secuencia;
                                    varRiesgoDetalle.Accion = obj.Accion;
                                    //registro = SvcSeguimientoRiesgoDetalle.setMantenimiento(varRiesgoDetalle);
                                    listaDetalle.Add(varRiesgoDetalle);
                                }
                            }
                            registro = SvcSeguimientoRiesgo.setMantenimiento(new SS_HC_SeguimientoRiesgo(), listaCab, listaDetalle);

                            if (registro > 0)
                            {
                                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                                ENTITY_GLOBAL.Instance.INTERUPTORDELL_TEMP = null;
                                Session["VariableGenerales"] = null;
                                Session["VariableGeneralesTemp"] = null;
                                Session["VariableGeneralesTempDELETE"] = null;

                                var store = X.GetCmp<Store>("StoreDatosPrevencion");

                                //store.Reload();
                                var store1 = X.GetCmp<Store>("storeRiegoDetalle");
                                store1.Reload();
                                //X.Msg.Notify("Mensaje", "Registro Satisfactoriamente..").Show();
                                String mensaje = "Se " + "actualizó" + " el Formulario satisfactoriamente. Código Transacción: " +
                                    UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.PacienteID, "");

                                //ActivaDescativaButtonSave(true);
                                eventoPostFormulario(true, "");
                                //return showMensajeBox(mensaje, "Ventana de Mensajes ", "INFO");
                                return showMensajeNotify("Mensaje", mensaje, "INFO");
                            }
                            else
                            {
                                eventoPostFormulario(false, "");
                                return showMensajeNotify("Error", "Sucedió un error inesperado", "ERROR");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - GuardaTemporalDB - Bloque Catch");
                    Log.Error(ex, ex.Message);
                    //EventLog.GenerarLogError(ex);
                    var sqlException = ex.InnerException as SqlException;
                    var detalle = new MA_MiscelaneosDetalle();
                    detalle.ACCION = "ERRORES";
                    List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                    if (sqlException != null)
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                    }
                    else
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                    }
                    string mostrarExc = "Excepción genérica:" + ex.Message;
                    if (resultado.Count > 0)
                    {
                        mostrarExc = resultado[0].DescripcionLocal;
                    }
                    eventoPostFormulario(false, "");
                    return showMensajeNotify("Error", mostrarExc, "ERROR");
                    throw;
                }
            }

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult GuardaTemporalPrevencion(String Variables, string text)
        {
            Log.Information("ProgramarKardexController - GuardaTemporalPrevencion - Entrar");
            try
            {
                if ((Variables != null) || (Variables.Length > 0))
                {
                    List<SS_HC_SeguimientoRiesgoDetalle> listaSegRiesgoDetalleTemp = new List<SS_HC_SeguimientoRiesgoDetalle>();
                    List<SS_HC_SeguimientoRiesgoDetalle> listaSegRiesgoDetalleTempDelete = new List<SS_HC_SeguimientoRiesgoDetalle>();
                    List<SS_HC_SeguimientoRiesgoDetalle> listaSegRiesgoDetalleAux = new List<SS_HC_SeguimientoRiesgoDetalle>();

                    if (Session["VariableGeneralesTemp"] != null)
                    {
                        listaSegRiesgoDetalleTemp = (List<SS_HC_SeguimientoRiesgoDetalle>)Session["VariableGeneralesTemp"];
                    }
                    listaSegRiesgoDetalleAux = (List<SS_HC_SeguimientoRiesgoDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(Variables, typeof(List<SS_HC_SeguimientoRiesgoDetalle>));
                    if (text == "1")
                    {
                        if (listaSegRiesgoDetalleAux.Count > 0)
                        {
                            if (listaSegRiesgoDetalleTemp.Count > 0)
                            {
                                bool hallado = false;
                                foreach (var resultAux in listaSegRiesgoDetalleAux)
                                {
                                    hallado = false;
                                    foreach (var resultTemp in listaSegRiesgoDetalleTemp)
                                    {
                                        if (resultAux.IdCuidadoPreventivo == resultTemp.IdCuidadoPreventivo)
                                        {
                                            hallado = true;
                                            resultTemp.Comentario = resultAux.Comentario;
                                        }
                                    }
                                    if (!hallado)
                                    {
                                        listaSegRiesgoDetalleTemp.Add(resultAux);
                                    }
                                }
                            }
                            else
                            {
                                listaSegRiesgoDetalleTemp.AddRange(listaSegRiesgoDetalleAux);
                            }
                        }
                    }
                    else
                    {
                        if (Session["VariableGeneralesTempDELETE"] != null)
                        {
                            listaSegRiesgoDetalleTempDelete = (List<SS_HC_SeguimientoRiesgoDetalle>)Session["VariableGeneralesTempDELETE"];
                        }
                        if (listaSegRiesgoDetalleAux.Count > 0)
                        {
                            foreach (var resultDelete in listaSegRiesgoDetalleAux)
                            {
                                bool hallado = false;
                                if (listaSegRiesgoDetalleTemp.Count > 0)
                                {
                                    foreach (var resultSave in listaSegRiesgoDetalleTemp)
                                    {
                                        if (resultSave.IdCuidadoPreventivo == resultDelete.IdCuidadoPreventivo)
                                        {
                                            if (resultDelete.Secuencia > 0)
                                            {
                                                listaSegRiesgoDetalleTempDelete.Add(resultDelete);
                                            }
                                            listaSegRiesgoDetalleTemp.Remove(resultSave);
                                            hallado = true;
                                            break;
                                        }
                                    }
                                }
                                if (!hallado)
                                {
                                    if (resultDelete.Secuencia > 0)
                                    {
                                        listaSegRiesgoDetalleTempDelete.Add(resultDelete);
                                    }
                                }
                            }
                        }
                        Session["VariableGeneralesTempDELETE"] = listaSegRiesgoDetalleTempDelete;
                    }
                    Session["VariableGeneralesTemp"] = listaSegRiesgoDetalleTemp;
                    /////////////////  
                }
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - GuardaTemporalPrevencion - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:" + ex.Message;
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
            return this.Direct();
        }




        public System.Web.Mvc.ActionResult ServiciosVarios()
        {Log.Information("ProgramarKardexController - ServiciosVarios - Entrar");
            //Ext.EventObject.F2
            //var  x =Ext.Net.even
            return View();
        }


        public System.Web.Mvc.ActionResult CCEP0310_View()
        {Log.Information("ProgramarKardexController - CCEP0310_View - Entrar");
            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            /*****OBS: Prueba CARGA RESOURSEC VALIDACION*******/
            Session["MENSAJES_VALFORM"] = null;
            cargarPropiedadesFormulario(true);
            setPropiedadesFormulario(true);
            /***************************************************/
            return View();
        }



        public System.Web.Mvc.ActionResult Next_Click(int index)
        {
            //Log.Information("ProgramarKardexController - Index - Entrar");
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
            Log.Information("ProgramarKardexController - CheckButtons - Entrar");
            this.GetCmp<Button>("btnNext").Disabled = index == 7;
            this.GetCmp<Button>("btnPrev").Disabled = index == 0;
            index = index + 1;
            this.GetCmp<Button>("txtLabel").Text = "Paginas de " + index.ToString().Trim() + " a 8";
        }


        public System.Web.Mvc.ActionResult Vista_View()
        {
            Log.Information("ProgramarKardexController - Vista_View - Entrar");

            return RedirectToAction("", "", "");
        }



        public System.Web.Mvc.ActionResult DobleClicGrilla(String Name, String selection, String Mode)
        {
            Log.Information("ProgramarKardexController - DobleClicGrilla - Entrar");

            SelectedRowCollection src = JSON.Deserialize<SelectedRowCollection>(selection);
            List<int> omitIds = new List<int>();
            foreach (SelectedRow row in src)
            {
                omitIds.Add(Convert.ToInt32(row.RecordID));
            }
            var values = new System.Web.Routing.RouteValueDictionary();
            values.Add("id", omitIds[0]);
            string url = string.Format("/ProgramarKardex/Index?idCodigo={0}", omitIds[0]);

            return this.PartialExtView(
                  viewName: "CCEP9921_View",
                  containerId: "dd",
                // model: this.Session["card"],
                  mode: RenderMode.AddTo,
                  clearContainer: true
              );
            //  return this.Direct();
        }
        public System.Web.Mvc.ActionResult SelectPaciente(string selection)
        {
            Log.Information("ProgramarKardexController - SelectPaciente - Entrar");

            ENTITY_GLOBAL.Instance.PacienteID = Convert.ToInt32(selection.Trim());
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult SelectClinico(string Clinico, string Atencion)
        {
            Log.Information("ProgramarKardexController - SelectClinico - Entrar");

            //ENTITY_GLOBAL.Instance.EpisodioClinico = Convert.ToInt32(Clinico.Trim());
            //ENTITY_GLOBAL.Instance.EpisodioAtencion = Convert.ToInt64(Atencion.Trim());
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
            return this.Direct();
        }

        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaaC(string valor)
        {
            Log.Information("ProgramarKardexController - ActivarGrillaaC - Entrar");

            this.GetCmp<GridPanel>("grillaContacto").Hidden = false;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillabC(string valor)
        {
            Log.Information("ProgramarKardexController - ActivarGrillabC - Entrar");

            this.GetCmp<GridPanel>("grillaContacto").Hidden = true;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaA(string valor)
        {
            Log.Information("ProgramarKardexController - ActivarGrillaA - Entrar");

            this.GetCmp<GridPanel>("grillaMed").Hidden = false;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaB(string valor)
        {
            Log.Information("ProgramarKardexController - ActivarGrillaB - Entrar");

            this.GetCmp<GridPanel>("grillaMed").Hidden = true;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaAA(string valor)
        {
            Log.Information("ProgramarKardexController - ActivarGrillaAA - Entrar");

            this.GetCmp<GridPanel>("grillaMedRegular").Hidden = false;
            return this.Direct();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult ActivarGrillaBB(string valor)
        {
            Log.Information("ProgramarKardexController - ActivarGrillaBB - Entrar");

            this.GetCmp<GridPanel>("grillaMedRegular").Hidden = true;
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult ActiontxtPA()
        {
            Log.Information("ProgramarKardexController - ActiontxtPA - Entrar");

            X.Msg.Notify("The Server Time is: ", DateTime.Now.ToLongTimeString()).Show();
            return this.Direct();
        }

        [DirectMethod]
        public System.Web.Mvc.ActionResult setTree()
        {
            Log.Information("ProgramarKardexController - setTree - Entrar");

            var p = this.GetCmp<TreePanel>("TreeEast");
            p.Refresh();
            p.ClearContent();
            p.RemoveAll();
            //p.LoadContent(Url.Action("View1"));

            return this.Direct();
        }


        public System.Web.Mvc.ActionResult SubmitData(string data)
        {
            Log.Information("ProgramarKardexController - SubmitData - Entrar");

            List<EventModel> events = JSON.Deserialize<List<EventModel>>(data);

            return new PartialViewResult
            {
                ViewName = "EventsViewer",
                ViewBag =
                {
                    Events = events
                }
            };
        }
        public class BasicModel
        {
            public static EventModelCollection Events
            {
                get
                {
                    DateTime now = DateTime.Now.Date;

                    return new EventModelCollection { 
                    new EventModel
                    {
                        EventId = 1001,
                        CalendarId = 1,
                        Title = "Vacation",
                        StartDate = now.AddDays(-20).AddHours(10),
                        EndDate = now.AddDays(-10).AddHours(15),
                        IsAllDay = false,
                        Notes = "Have fun"
                    },
                    new EventModel
                    {
                        EventId = 1002,
                        CalendarId = 2,
                        Title = "Lunch with Matt",
                        StartDate = now.AddHours(11).AddMinutes(30),
                        EndDate = now.AddHours(13),
                        IsAllDay = false,
                        Location = "Chuy's!",
                        Url = "http://chuys.com",
                        Notes = "Order the queso",
                        Reminder = "15"
                    },
                    new EventModel
                    {
                        EventId = 1003,
                        CalendarId = 3,
                        Title = "Project due",
                        StartDate = now.AddHours(15),
                        EndDate = now.AddHours(15),
                        IsAllDay = false
                    },
                    new EventModel
                    {
                        EventId = 1004,
                        CalendarId = 1,
                        Title = "Sarah's birthday",
                        StartDate = now,
                        EndDate = now,
                        IsAllDay = true,
                        Notes = "Need to get a gift"
                    },
                    new EventModel
                    {
                        EventId = 1005,
                        CalendarId = 2,
                        Title = "A long one...",
                        StartDate = now.AddDays(-12),
                        EndDate = now.AddDays(10).AddSeconds(-1),
                        IsAllDay = true
                    },
                    new EventModel
                    {
                        EventId = 1006,
                        CalendarId = 3,
                        Title = "School holiday",
                        StartDate = now.AddDays(5),
                        EndDate = now.AddDays(7).AddSeconds(-1),
                        IsAllDay = true,
                        Reminder = "2880"
                    },
                    new EventModel
                    {
                        EventId = 1007,
                        CalendarId = 1,
                        Title = "Haircut",
                        StartDate = now.AddHours(9),
                        EndDate = now.AddHours(9).AddMinutes(30),
                        IsAllDay = false,
                        Notes = "Get cash on the way"
                    },
                    new EventModel
                    {
                        EventId = 1008,
                        CalendarId = 3,
                        Title = "An old event",
                        StartDate = now.AddDays(-30),
                        EndDate = now.AddDays(-28),
                        IsAllDay = true,
                        Notes = "Get cash on the way"
                    },
                    new EventModel
                    {
                        EventId = 1009,
                        CalendarId = 2,
                        Title = "Board meeting",
                        StartDate = now.AddDays(-2).AddHours(13),
                        EndDate = now.AddDays(-2).AddHours(18),
                        IsAllDay = false,
                        Location = "ABC Inc.",
                        Reminder = "60"
                    },
                    new EventModel
                    {
                        EventId = 1010,
                        CalendarId = 3,
                        Title = "Jenny's final exams",
                        StartDate = now.AddDays(-2),
                        EndDate = now.AddDays(3).AddSeconds(-1),
                        IsAllDay = true
                    },
                    new EventModel
                    {
                        EventId = 1011,
                        CalendarId = 1,
                        Title = "Movie night",
                        StartDate = now.AddDays(2).AddHours(19),
                        EndDate = now.AddDays(2).AddHours(23),
                        IsAllDay = false,
                        Notes = "Don't forget the tickets!",
                        Reminder = "60"
                    }
                };
                }
            }
        }


        public System.Web.Mvc.ActionResult AsignarConsultorTelesalud(String MODO, String usuario)
        {
            Log.Information("ProgramarKardexController - AsignarConsultorTelesalud - Entrar");

            //var field = X.GetCmp<TreePanel>("treeMain");
            //field.RemoveAll();
            ENTITY_GLOBAL.Instance.objModel = null;
            VW_ATENCIONPACIENTE objAutorizac = new VW_ATENCIONPACIENTE();
            //var Listar = new List<USUARIO>();
            if (MODO == "NUEVO")
            {
                objAutorizac.Accion = "NUEVO";
            }
            objAutorizac.Accion = MODO;
            return NewPageWindows("TeleSalud/AsignarConsultor", objAutorizac, "");
            //return View("UsuarioRegistro", LocalEnty);
        }
        public System.Web.Mvc.ActionResult postWindowProxima(String id)
        {
            Log.Information("ProgramarKardexController - postWindowProxima - Entrar");

            VW_SS_GE_ESPECIALIDADMEDICO objFiltro = new VW_SS_GE_ESPECIALIDADMEDICO();
            var Listar = new List<VW_SS_GE_ESPECIALIDADMEDICO>();

            var field = X.GetCmp<TextField>("tfNomMed");
            var tfNum = X.GetCmp<TextField>("tfNroMed");
            if (field != null)
            {
                objFiltro.ACCION = "LISTARPAG";
                if (id.Trim().Length > 0) objFiltro.PERSONA = Convert.ToInt32(id);
                Listar = SvcVWEspecialidadMedico.listarEspecialidadMedico(objFiltro, 0, 10);
                if (Listar.Count == 1)
                {
                    foreach (VW_SS_GE_ESPECIALIDADMEDICO objEntity in Listar)
                    {
                        objFiltro = objEntity;
                        field.SetValue(objFiltro.NOMBRECOMPLETO);
                        tfNum.SetValue(objFiltro.CMP);
                    }
                }
            }
            setPropiedadesFormulario(true);
            return this.Direct();
        }





        public System.Web.Mvc.ActionResult getGrillaEspecialidadMedico(int start, int limit,
            string cmp, string nombrecompleto, string nroregespecialidad, string idespecialidad,
           string estado, string tipoBuscar)
        {
            Boolean indicaValidacionForm = false;
            try
            {
                Log.Information("ProgramarKardexController - getGrillaEspecialidadMedico - Entrar");

                ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_SS_GE_ESPECIALIDADMEDICO>();
                var LocalEnty = new VW_SS_GE_ESPECIALIDADMEDICO();
                LocalEnty.CMP = getValorFiltroStr(cmp);
                LocalEnty.NOMBRECOMPLETO = getValorFiltroStr(nombrecompleto);
                LocalEnty.NUMEROREGISTROESPECIALIDAD = getValorFiltroStr(nroregespecialidad);
                LocalEnty.IDESPECIALIDAD = (getValorFiltroInt(idespecialidad) != null ? Convert.ToInt32(getValorFiltroInt(idespecialidad)) : 0);
                LocalEnty.ESTADO = getValorFiltroStr(estado);
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }
                LocalEnty.ACCION = "LISTARPAG";
                int cantElementos = SvcVWEspecialidadMedico.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.ACCION = "LISTARPAG";
                    Listar = SvcVWEspecialidadMedico.listarEspecialidadMedico(LocalEnty, inicio, final);
                }
                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - getGrillaEspecialidadMedico - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                indicaValidacionForm = true;
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }
        public System.Web.Mvc.ActionResult seleccionadorMedico(String accionSeleccion, String accionListado)
        {
            Log.Information("ProgramarKardexController - seleccionadorMedico - Entrar");

            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.USUARIO = accionListado;
            obj.ACCION = accionSeleccion;
            if (Session["MODULO_DEF"] != null)
            {
            }
            return crearWindowRegistro("SeleccionadorMedico", obj, "");
        }
        public System.Web.Mvc.ActionResult getSeleccionMedico(String MODO, int persona, String cmp, String nombre, String idWindow)
        {
            Log.Information("ProgramarKardexController - getSeleccionMedico - Entrar");

            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var nf = X.GetCmp<NumberField>("nfMedico");
            if (persona != null) { nf.SetValue(persona); }

            var tfNom = X.GetCmp<TextField>("tfNomMed");
            if (nombre != null && nombre != "") { tfNom.SetValue(nombre); }

            var tfCmd = X.GetCmp<TextField>("tfNroMed");
            if (cmp != null && cmp != "") { tfCmd.SetValue(cmp); }

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult getSeleccionMedicoDos(String MODO, int persona, String cmp, String nombre, String idWindow)
        {
            Log.Information("ProgramarKardexController - getSeleccionMedicoDos - Entrar");

            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var nf = X.GetCmp<NumberField>("IdPersonalSalud");
            if (persona != null) { nf.SetValue(persona); }

            var tfNom = X.GetCmp<TextField>("tfNomMed");
            if (nombre != null && nombre != "") { tfNom.SetValue(nombre); }

            var tfCmd = X.GetCmp<TextField>("tfNroMed");
            if (cmp != null && cmp != "") { tfCmd.SetValue(cmp); }

            return this.Direct();
        }

        /*******/
        public System.Web.Mvc.ActionResult seleccionadorDiagnostico(String accionSeleccion, String accionListado)
        {
            Log.Information("ProgramarKardexController - seleccionadorDiagnostico - Entrar");

            SS_GE_Diagnostico obj = new SS_GE_Diagnostico();
            obj.UsuarioCreacion = accionListado; //AUXILIAR
            obj.Accion = accionSeleccion;
            return crearWindowRegistro("SeleccionadorDiagnostico", obj, "");
        }

        public System.Web.Mvc.ActionResult getGrillaDiagnostico(int start, int limit,
            string descripcion, string codigo, string estado, string tipoBuscar)
        {
            Log.Information("ProgramarKardexController - getGrillaDiagnostico - Entrar");

            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<SS_GE_Diagnostico>();

                var LocalEnty = new SS_GE_Diagnostico();

                LocalEnty.CodigoDiagnostico = getValorFiltroStr(codigo);
                LocalEnty.Nombre = getValorFiltroStr(descripcion);
                LocalEnty.Estado = getValorFiltroInt(estado);
                if (estado == "-1")
                {
                    LocalEnty.Estado = null;
                }
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;

                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }


                LocalEnty.Accion = "CONTARLISTAPAG";
                int cantElementos = SvcDiagnostico.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = "LISTARPAG";
                    Listar = SvcDiagnostico.listarDiagnostico(LocalEnty, inicio, final);
                }

                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - getGrillaDiagnostico - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                indicaValidacionForm = true;
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }
        /********/
        public System.Web.Mvc.ActionResult seleccionadorUnidadServicio(String accionSeleccion, String accionListado)
        {
            Log.Information("ProgramarKardexController - seleccionadorUnidadServicio - Entrar");
            SS_HC_CatalogoUnidadServicio obj = new SS_HC_CatalogoUnidadServicio();
            obj.UsuarioCreacion = accionListado; //AUXILIAR
            obj.Accion = accionSeleccion;
            if (Session["MODULO_DEF"] != null)
            {
                //obj.Modulo = (string)Session["MODULO_DEF"];
            }
            return crearWindowRegistro("SeleccionadorUnidadServicio", obj, "");
        }
        public System.Web.Mvc.ActionResult getGrillaUnidadServicioSelec(int start, int limit, string descripcion, string codigoPadre, string tipoBuscar)
        {
            Log.Information("ProgramarKardexController - getGrillaUnidadServicioSelec - Entrar");

            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                //ConsultaCita();
                var Listar = new List<SS_HC_CatalogoUnidadServicio>();

                var LocalEnty = new SS_HC_CatalogoUnidadServicio();

                LocalEnty.Descripcion = getValorFiltroStr(descripcion);
                LocalEnty.CodigoUnidadServicio = getValorFiltroStr(codigoPadre);

                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                //Si la búsqueda proviene de filtros
                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

                LocalEnty.Accion = "LISTARPAG";
                int cantElementos = SvcCategoriaUnidadServicio.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = "LISTARPAG";
                    Listar = SvcCategoriaUnidadServicio.listarCatUnidadServicio(LocalEnty, inicio, final);
                }
                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - getGrillaUnidadServicioSelec - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                indicaValidacionForm = true;
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }
        /******************/



        /***/
        public System.Web.Mvc.ActionResult VisorDocumentosHCE(string codigoFile, string titulo,
            string nombreFile, string extencionFile, string Accion, string Form, string FormContainer)
        {
            Log.Information("ProgramarKardexController - VisorDocumentosHCE - Entrar");
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new ENTITY_GENERALHCE();
            model.campoStr01 = codigoFile;
            model.campoStr02 = nombreFile;
            string host = System.Web.HttpContext.Current.Request.Url.Host;
            string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
            //string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
            string path = System.Web.HttpContext.Current.Request.ApplicationPath;

            model.campoStr03 = hostPort + path;
            model.campoStr04 = extencionFile;
            model.campoStr05 = titulo;

            string estado = "PanelCentralBlanco";
            return crearWindowRegistro(Form, model, "");
        }

        public System.Web.Mvc.ActionResult DialogVerFile(String pathAuxDefault, String nombreArchivo,
            string Form, string Accion, string MODO)
        {
            try
            {
                Log.Information("ProgramarKardexController - DialogVerFile - Entrar");

                String urlBase = "";
                //default                                                                
                string pathsExtendsDefault = "/resources/DocumentosAdjuntos/";
                String host = System.Web.HttpContext.Current.Request.Url.Host;
                String strPathAndQuery = HttpContext.Request.Url.PathAndQuery;
                String hostPort = HttpContext.Request.Url.Authority;
                String strPathAndQuery1 = HttpRuntime.AppDomainAppVirtualPath;
                String path = System.Web.HttpContext.Current.Request.ApplicationPath;
                /*
                //String ruta = "http://localhost:11505/~resources/DocumentosAdjuntos/" + nombreArchivo;
                String ruta = "http://localhost:11505/~resources/DocumentosAdjuntos/" + "ResultadoExamen.doc";
                String rutaGoogle = "http://docs.google.com/viewer?url=" + ruta + "&embedded=true&a=bi&w=1820&pagenumber=1";
                 */
                urlBase = "http://" + hostPort + path + pathsExtendsDefault;

                //de PARAMETROS                
                List<ParametrosMast> listaParam = new List<ParametrosMast>();
                ParametrosMast objParam = new ParametrosMast();
                objParam.Accion = "LISTAR";
                objParam.CompaniaCodigo = "999999";
                objParam.AplicacionCodigo = "WA";//obs
                objParam.ParametroClave = "URL_EXAMD";
                listaParam = SvcParametro.listarParametro(objParam, 0, 0);
                if (listaParam.Count > 0)
                {
                    if ((listaParam[0].Texto + "").Trim() == "S")//USAR PARÁMETRO
                    {
                        urlBase = (listaParam[0].DescripcionParametro + "").Trim();
                    }
                }
                //Session["PARAM_PATHEXAMENDOCUMENTOS"] = url;
                /////
                List<ENTITY_GENERALHCE> listaAtach = new List<ENTITY_GENERALHCE>();
                var model = new ENTITY_GENERALHCE();
                model.campoStr01 = urlBase + nombreArchivo;
                model.campoStr02 = nombreArchivo;
                model.campoStr03 = hostPort + path;
                model.ACCION = MODO;
                string[] cad = nombreArchivo.Split('.');
                string extension = "";
                if (cad.Length > 1)
                {
                    extension = cad[1];
                }
                model.campoStr04 = extension;
                if (MODO == "DIALOG")
                {
                    return crearWindowRegistro(Form, model, "");
                }
                else
                {
                    model.campoStr10 = "_blank";
                    listaAtach.Add(model);
                    return this.Store(listaAtach);
                }
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - DialogVerFile - Bloque Catch");
                Log.Error(ex, ex.Message);

            }
            return this.Direct();
        }

        /*********/
        public System.Web.Mvc.ActionResult ListadoPacienteEpisodioAtencion(int start, int limit, String proceso,
            String profSalud, String txtbuscar, String fechaDesde, String fechaHasta, String tipoBuscar,
            String codigooa, String accion)
        {
            Log.Information("ProgramarKardexController - ListadoPacienteEpisodioAtencion - Entrar");
            ENTITY_GLOBAL.Instance.GRUPO = "";
            //var field = X.GetCmp<TextField>("txtPaciente");             
            var Listar = new List<V_EpisodioAtenciones>();
            var LocalEnty = new V_EpisodioAtenciones();

            int ini = (start == 0 ? start : start + 1);
            int fin = start + limit;
            if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }

            LocalEnty.UsuarioModificacion = getValorFiltroStr(proceso); //AUX para ACCION o FORM
            LocalEnty.UsuarioCreacion = getValorFiltroStr(codigooa); //AUX para código OA
            //  OBS: profSalud
            LocalEnty.FechaModificacion = getValorFiltroDate(fechaDesde); //AUX desde
            LocalEnty.FechaRegistro = getValorFiltroDate(fechaHasta);  ///AUS hasta
            LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
            //////////////
            LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;



            LocalEnty.Codigo002 = getValorFiltroStr(proceso);
            LocalEnty.CodigoOA = getValorFiltroStr(codigooa);
            LocalEnty.Accion = "LISTARPAG";
            if (accion != null && accion != "")
            {
                LocalEnty.Accion = accion;
            }

            int cantElementos = 0;
            Listar = SvcV_EpisodioAtenciones.ListarV_EpisodioAtenciones(LocalEnty, ini, fin);
            if (Listar.Count > 0)
            {
                cantElementos = Listar[0].contador_filas;
            }


            //Agregado para listar columnas variantes
            //getColumnasCronologia(proceso, "COLUMNAS_CRONOL");

            return this.Store(Listar, cantElementos);

        }

        public System.Web.Mvc.ActionResult getColumnasCronologia(String opcion, String accion)
        {
            try
            {
                Log.Information("ProgramarKardexController - getColumnasCronologia - Entrar");
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = accion;
                string usu = "";
                string unidadreplicacion = "";
                int idpaciente = 0;
                int episodioclinico = 0;
                int idepisodioatencion = 0;
                int idordenatencion = 0;
                string CodigoOA = "";
                int IdMedico = 0;
                int IdOpcion = Convert.ToInt32(opcion);
                string codigoformato = "";

                var ObjLista = SvcMiscelaneoFormularioCrono.listarMA_MiscelaneosFormularioCrono(detalle, usu, unidadreplicacion, idpaciente, episodioclinico, idepisodioatencion, idordenatencion, CodigoOA, IdMedico, IdOpcion, codigoformato);
                //var Determinacion = this.GetCmp<Column>("Columncompania");
                //Determinacion.Text = (compania);
                if (ObjLista != null)
                {
                    if (ObjLista.Count > 0)
                    {
                        /*
                        var desc1crono = ObjLista[0].ValorCodigo2;
                        var desc2crono = ObjLista[0].ValorCodigo3;
                        var desc3crono = ObjLista[0].ACCION;
                        */
                        return this.Direct(ObjLista[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - getColumnasCronologia - Bloque Catch");
                Log.Error(ex, ex.Message);
            }
            //ENTITY_GLOBAL.Instance.Descrono2 = valorentero;
            //var grado = this.GetCmp<Column>("Columncompania");
            //grado.Text = (valorentero);
            //var Nomdesc2  = "Determinacion";
            //ENTITY_GLOBAL.Instance.Descrono2 = Nomdesc2;
            //var Nomdes3 = "Grado de Afección";
            //ENTITY_GLOBAL.Instance.Descrono3 = Nomdes3;

            return this.Direct();

        }

        public System.Web.Mvc.ActionResult ListadoPacienteEpisodio(int start, int limit, String Name, String selection, String Mode)
        {
            Log.Information("ProgramarKardexController - ListadoPacienteEpisodio - Entrar");

            var field = X.GetCmp<TextField>("txtBuscar");
            var vtxtBuscar = this.GetCmp<TextField>("txtBuscar");
            var xdtDeste = this.GetCmp<DateField>("dtDeste");

            var dtDeste = this.GetCmp<DateField>("dtDeste").Text;
            var dtHasta = this.GetCmp<Button>("dtHasta").Text;


            var personaPaciente = new PERSONAMAST();
            personaPaciente.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
            personaPaciente.ACCION = "LISTARDIAGNOSTICO";
            var list = SvcPersonaMast.GetSelectPersonaMast(personaPaciente).ToList();
            return this.Store(SvcPersonaMast.GetSelectPersonaMast(personaPaciente).ToList());
        }

        public System.Web.Mvc.ActionResult CCEP9921_View()
        {
            Log.Information("ProgramarKardexController - CCEP9921_View - Entrar");

            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            SS_HC_KardexEnfermeria ObjSP;
            var fieldCod = X.GetCmp<TextField>("txtPaciente");
            fieldCod.SetValue(ENTITY_GLOBAL.Instance.NombreCompletoPaciente);


            var fieldCod2 = X.GetCmp<TextField>("txtCodigoOA");
            fieldCod2.SetValue(ENTITY_GLOBAL.Instance.CodigoOA);

            var fieldCod3 = X.GetCmp<DateField>("txtFecha1");
            /*fieldCod3.SetValue(ENTITY_GLOBAL.Instance.FechaReceta);*/

            ObjSP = new SS_HC_KardexEnfermeria();
            ObjSP.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            ObjSP.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            ObjSP.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            ObjSP.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;

            /*
            ObjSP.Accion = "NDOCUMENTO";

            object result = svcSS_HC_KardexEnfermeria.Listar(ObjSP);

            var fieldCod4 = X.GetCmp<TextField>("txtDocumento");
            fieldCod4.SetValue(result.ToString());*/

            ObjSP.Accion = "OBSERVACION";

            object result2 = svcSS_HC_KardexEnfermeria.Listar(ObjSP);

            var fieldCod5 = X.GetCmp<TextArea>("txtObservacion");
            fieldCod5.SetValue(result2.ToString());

            ObjSP.Accion = "IDSOLICITUD";

            object result3 = svcSS_HC_KardexEnfermeria.Listar(ObjSP);

            var fieldCod6 = X.GetCmp<TextField>("txtIdSolicitudProducto");
            fieldCod6.SetValue(result3.ToString());


            return View();
        }

        public System.Web.Mvc.ActionResult FormView()
        {
            Log.Information("ProgramarKardexController - FormView - Entrar");

            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            var html = "Html.TextBox(" + "'Textbox1'" + ", " + "'val'" + ")";
            ViewBag.RenderedHtml = html;
            System.Text.StringBuilder htmlOutput = new System.Text.StringBuilder();


            RegistraPagina();

            return View("FormViewCaptura");
        }
        public PartialViewResult PanelWest(string containerId)
        {
            Log.Information("ProgramarKardexController - PanelWest - Entrar");

            return new PartialViewResult
            {
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                Model = ENTITY_GLOBAL.Instance,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }
        public PartialViewResult PanelEast(string containerId)
        {
            Log.Information("ProgramarKardexController - PanelEast - Entrar");

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
            Log.Information("ProgramarKardexController - PanelNorth - Entrar");

            ////////////////////////
            VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
            }
            ////////////////////////
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            var objDatos = new PERSONAMAST();
            LocalEnty.ACCION = "LISTARPACIENTE";
            //LocalEnty.Estado = "";
            LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
            Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
            //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
            if (Listar.Count > 0)
            {
                foreach (PERSONAMAST objPersona in Listar)
                {
                    objDatos = objPersona;
                    ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto.Replace("\r", string.Empty);
                    Session["NOMBREPACIENTE_ACTUAL"] = objDatos.NombreCompleto.Replace("\r", string.Empty);
                }
            }
            ////TIPO PACIENTE
            objDatos.RutaFirma = vistaGenSelec.TipoPacienteNombre; //AUX
            ////OBTENER ASEGURADORA
            var detalle = new MA_MiscelaneosDetalle();
            detalle.ACCION = "INFOPACIENTE";
            detalle.ValorCodigo1 = "" + ENTITY_GLOBAL.Instance.PacienteID;
            detalle.ValorCodigo1 = "" + vistaGenSelec.IdPaciente;
            detalle.ValorCodigo2 = "" + vistaGenSelec.IdEmpresaAseguradora;
            var ObjLista = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, 0, 0);
            if (ObjLista.Count > 0)
            {
                objDatos.DireccionReferencia = ObjLista[0].DescripcionLocal; //AUX
            }
            //////////////////////////////////////////////
            objDatos.Direccion = "";
            objDatos.DireccionEmergencia = "";
            /////////////Obtener Alergias///////////////////
            var objAnam = new SS_HC_Anamnesis_AP();
            var listaAnam = new List<SS_HC_Anamnesis_AP>();
            objAnam.Accion = "LISTARPORPACIENTE";
            objAnam.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objAnam.IdPaciente = (int)vistaGenSelec.IdPaciente;
            //objAnam.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.VistaEpisodioClinico;
            //objAnam.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.VistaEpisodioAtencion;
            listaAnam = SvcFormularioAnamnesisAP.AnamnesisAP_Listar(objAnam).ToList();
            if (listaAnam.Count > 0)
            {
                string medAux = "";
                string alimAux = "";
                foreach (SS_HC_Anamnesis_AP obj in listaAnam)
                {
                    medAux = medAux + obj.Medicamentos + ", ";
                    alimAux = alimAux + obj.Alimentos + ", ";
                }
                if (medAux.Length > 1)
                {
                    objDatos.Direccion = medAux.Substring(0, medAux.Length - 1);
                }
                if (alimAux.Length > 1)
                {
                    objDatos.DireccionEmergencia = alimAux.Substring(0, alimAux.Length - 1);
                }

            }

            /////////////////////////////////////////////
            objDatos.ClasePersonaCodigo = "";
            objDatos.PersonaClasificacion = "";
            //////////////////obtener registro acompañante////////////

            //var objAcomp = new SS_HC_RegistroAcompanante();
            //var listaAcomp = new List<SS_HC_RegistroAcompanante>();
            //objAcomp.Accion = "LISTARPORPACIENTE";
            //objAcomp.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            //objAcomp.IdPaciente = (int)vistaGenSelec.IdPaciente;


            //listaAcomp = SvcRegistroAcompanante.listarRegistroAcompanante(objAcomp).ToList();
            //if (listaAcomp.Count > 0)
            //{
            //    string nombresAux = "";
            //    string obsAux = "";
            //    string numAux = "";
            //    string tipoAux = "";
            //    string parenAux = "";
            //    string telefAux = "";


            //    foreach (SS_HC_RegistroAcompanante obj in listaAcomp)
            //    {
            //        nombresAux = obj.ApePat + " " + obj.ApeMat + " " + obj.Nombres;
            //        obsAux = obj.Observaciones;
            //        numAux = obj.numero;
            //        tipoAux = obj.Tipo;
            //        parenAux = Convert.ToString(obj.TipoParentesco);
            //        telefAux = obj.Telefono;
            //    }

            //    objDatos.ClasePersonaCodigo = nombresAux;
            //    objDatos.DocumentoMilitarFA = numAux;
            //    objDatos.PaisEmisor = tipoAux;
            //    objDatos.Pasaporte = parenAux;
            //    objDatos.PersonaClasificacion = obsAux;
            //    objDatos.TipoCuentaLocal = telefAux;

            //}


            detalle = new MA_MiscelaneosDetalle();
            detalle.ACCION = "TRATACTIVO";
            int paciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            paciente = (int)vistaGenSelec.IdPaciente;

            ObjLista = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, paciente, 0);
            string tratactivo = "";
            foreach (MA_MiscelaneosDetalle objModelx in ObjLista)
            {
                if (tratactivo.Length > 2) tratactivo = tratactivo + ", ";
                tratactivo = tratactivo + (objModelx.DescripcionLocal + "").Trim() + " (" + objModelx.ValorCodigo1.Trim() + " - " + objModelx.ValorCodigo1.Trim() + ")";
            }
            objDatos.CorrelativoSCTR = tratactivo;

            SS_AD_OrdenAtencionPreexistencia objFormato = new SS_AD_OrdenAtencionPreexistencia();
            objFormato.accion = "LISTAR";
            objFormato.IdDiagnostico = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objFormato.IdDiagnostico = (int)vistaGenSelec.IdPaciente;
            var ListarPreEx = SvcOrdAtenPreexistencia.listarOrdAtePreexistencia(objFormato, 0, 0);
            string Preexit = "";
            foreach (SS_AD_OrdenAtencionPreexistencia objModelxx in ListarPreEx)
            {
                if (Preexit.Length > 2) Preexit = Preexit + ", ";
                Preexit = Preexit + (objModelxx.NombreDiagnostico + "").Trim() + " (" + (objModelxx.CodigoDiagnostico + "").Trim() + ")";
            }
            objDatos.CuentaMonedaLocal_tmp = Preexit;
            /////
            objDatos.CodigoBarras = ENTITY_GLOBAL.Instance.CodigoOA; //AUX PARA OA

            ////////////////
            return new PartialViewResult
            {
                Model = objDatos,
                ContainerId = containerId,
                ViewName = "PanelNorth",
                WrapByScriptTag = false
            };
        }
        public System.Web.Mvc.ActionResult ListadoTratamientoActivoPaciente(String idPaciente, String fecha)
        {
            Log.Information("ProgramarKardexController - ListadoTratamientoActivoPaciente - Entrar");

            var detalle = new MA_MiscelaneosDetalle();
            detalle.ACCION = "TRATACTIVO";
            int paciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            var Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, paciente, 0);

            //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
            //Session["ENTITY_PACIENTE"] = Listar;                
            return this.Store(Listar);
        }
        public System.Web.Mvc.ActionResult ListadoPreexistenciasPaciente(String idPaciente, String fecha)
        {
            Log.Information("ProgramarKardexController - ListadoPreexistenciasPaciente - Entrar");

            var Listar = new List<SS_AD_OrdenAtencionPreexistencia>();
            SS_AD_OrdenAtencionPreexistencia objFormato = new SS_AD_OrdenAtencionPreexistencia();
            objFormato.accion = "LISTAR";
            objFormato.IdDiagnostico = (int)ENTITY_GLOBAL.Instance.PacienteID;
            Listar = SvcOrdAtenPreexistencia.listarOrdAtePreexistencia(objFormato, 0, 0);
            return this.Store(Listar);
        }

        public PartialViewResult PanelSouth(string containerId)
        {
            Log.Information("ProgramarKardexController - PanelSouth - Entrar");

            var objVistaSeguridad = new SS_CHE_VistaSeguridad();
            objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
            objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
            objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;

            objVistaSeguridad.Accion = "LISTAPROCESOGENERAL";



            /**LISTADO PARA VERIFICAR DOCUMENTOS ADJUNTOS HCE*/
            MA_MiscelaneosDetalle LocalEnty = new MA_MiscelaneosDetalle();
            LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            LocalEnty.ValorCodigo2 = "" + ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnty.ACCION = "VIRTDOCUMENT";
            LocalEnty.ValorNumerico = 0;
            int result = SvcMiscelaneos.setMantenimiento(LocalEnty);
            objVistaSeguridad.IndicadorObjeto = result;
            /******************************/
            //LocalEnty.GRUPO = "";
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelSouth",
                WrapByScriptTag = false,
                Model = objVistaSeguridad


            };
        }


        [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
        public System.Web.Mvc.ActionResult LoadView1()
        {
            Log.Information("ProgramarKardexController - LoadView1 - Entrar");

            TreePanel p = X.GetCmp<TreePanel>("TreeEast");
            p.Refresh();
            //p.LoadContent(Url.Action("View1"));
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult FilterPanel(string recipienteID)
        {
            Log.Information("ProgramarKardexController - FilterPanel - Entrar");

            PartialViewResult pr = new PartialViewResult(recipienteID);
            pr.RenderMode = RenderMode.AddTo;
            pr.SingleControl = true;
            pr.WrapByScriptTag = true;
            return pr;
        }

        [DirectMethod(IDMode = DirectMethodProxyIDMode.None)]
        public System.Web.Mvc.ActionResult RefreshMenu()
        {
            Log.Information("ProgramarKardexController - RefreshMenu - Entrar");

            return this.Direct(BuildTree());
        }
        public static Ext.Net.Node BuildTree()
        {
            Log.Information("ProgramarKardexController - BuildTree - Entrar");

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
            Log.Information("ProgramarKardexController - ShowProperties - Entrar");

            Ext.Net.MVC.PartialViewResult partialViewResult = new Ext.Net.MVC.PartialViewResult(containerId);
            partialViewResult.RenderMode = RenderMode.AddTo;
            partialViewResult.SingleControl = true;
            partialViewResult.ContainerId = containerId;
            partialViewResult.Model = model;
            return partialViewResult;
        }
        public PartialViewResult LoadFormatos(string containerId, string text)
        {
            Log.Information("ProgramarKardexController - LoadFormatos - Entrar");

            string WEBNUEVO = "";
            string WEBMODIFICAR = "";

            ENTITY_GLOBAL.Instance.INDICA_FORM_COMPARTIDO = 0;

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
            Session["containerId_ACTUAL"] = containerId;
            Session["textTree_ACTUAL"] = text;
            ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            var UrlFormato = "PanelCentralBlanco";
            var model = new SS_HC_EpisodioAtenciones();
            model.IdOpcion = text.Trim();
            //CONSTRUIR COD HCE
            //model.WORKFLAG = String.Format("{0:00000}", ENTITY_GLOBAL.Instance.EpisodioClinico) + "." + String.Format("{0:00000}", ENTITY_GLOBAL.Instance.EpisodioAtencion);
            model.DescansoMedico = UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim, ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.PacienteID, "");

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
                switch (resulListado[0].TipoFormato)
                {
                    case 2: //ES FIJO
                        UrlFormato = "PanelCenter"; //resulListado[0].CodigoFormato;
                        model.CONCEPTO = resulListado[0].CodigoFormato.Trim() + "_View";
                        model.Accion = resulListado[0].CodigoFormato.Trim() + "_View";
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
                            obj.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                            obj.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim;
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
                    }
                    objVistaSeguridad = new SS_CHE_VistaSeguridad();
                    objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                    objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                    objVistaSeguridad.Accion = "DATOSRECURSOS";
                    objVistaSeguridad.CodigoFormato = resulListado[0].CodigoFormato.Trim();
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
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_COPY = 1;
            }
            //CONFIG DE SEGURIDAD DE IMPRESION
            cargarPermisosFormato(true);

            return new PartialViewResult
            {
                ViewName = UrlFormato,
                ContainerId = containerId,
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };
        }
        /// <summary>
        /// arboles
        /// </summary>
        /// <returns></returns>
        /// 

        public PartialViewResult LoadFormatosArbol(string containerId, string opc)
        {
            Log.Information("ProgramarKardexController - LoadFormatosArbol - Entrar");

            string WEBNUEVO = "";
            string WEBMODIFICAR = "";
            string text = ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL;

            if (opc == "Bita")
            {
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 1;
            }
            else
            {
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION2;
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 2;
            }


            ENTITY_GLOBAL.Instance.INDICA_FORM_COMPARTIDO = 0;

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
            Session["containerId_ACTUAL"] = containerId;
            Session["textTree_ACTUAL"] = text;
            ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            var UrlFormato = "PanelCentralBlanco";
            var model = new SS_HC_EpisodioAtenciones();
            model.IdOpcion = text.Trim();
            //CONSTRUIR COD HCE
            //model.WORKFLAG = String.Format("{0:00000}", ENTITY_GLOBAL.Instance.EpisodioClinico) + "." + String.Format("{0:00000}", ENTITY_GLOBAL.Instance.EpisodioAtencion);
            model.DescansoMedico = UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim, ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.PacienteID, "");

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
                switch (resulListado[0].TipoFormato)
                {
                    case 2: //ES FIJO
                        UrlFormato = "PanelCenter"; //resulListado[0].CodigoFormato;
                        model.CONCEPTO = resulListado[0].CodigoFormato.Trim() + "_View";
                        model.Accion = resulListado[0].CodigoFormato.Trim() + "_View";
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
                            obj.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                            obj.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim;
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
                ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL = resulListado[0].IdOpcion;
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
                    }
                    objVistaSeguridad = new SS_CHE_VistaSeguridad();
                    objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                    objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                    objVistaSeguridad.Accion = "DATOSRECURSOS";
                    objVistaSeguridad.CodigoFormato = resulListado[0].CodigoFormato.Trim();
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
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_COPY = 1;
            }
            //CONFIG DE SEGURIDAD DE IMPRESION
            cargarPermisosFormato(true);

            return new PartialViewResult
            {
                ViewName = UrlFormato,// "PanelCentralBlanco",
                ContainerId = containerId,
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };
        }


        public System.Web.Mvc.ActionResult reloadFormatos()
        {
            Log.Information("ProgramarKardexController - reloadFormatos - Entrar");

            string containerId = "";
            string text = "0";
            if (Session["containerId_ACTUAL"] != null && Session["textTree_ACTUAL"] != null)
            {
                containerId = (string)Session["containerId_ACTUAL"];
                text = (string)Session["textTree_ACTUAL"];
                return LoadFormatos(containerId, text);
            }
            else
            {
                return LoadFormatos("", "0");
            }
        }

        public PartialViewResult reloadPanelNorthC()
        {
            Log.Information("ProgramarKardexController - reloadPanelNorthC - Entrar");

            string containerId = "";
            if (Session["containerId_ACTUAL"] != null)
            {
                containerId = (string)Session["containerId_ACTUAL"];
                return PanelNorth(containerId);
            }
            else
            {
                return PanelNorth("");
            }
        }

        public PartialViewResult LoadCentral(string containerId, string text)
        {/*
           List<SEGURIDADCONCEPTO> listaAsignados = new List<SEGURIDADCONCEPTO>();
            var objConceptosAux = new SEGURIDADCONCEPTO();
            objConceptosAux.APLICACIONCODIGO = ENTITY_GLOBAL.Instance.APPCODIGO;
            objConceptosAux.GRUPO = "GRUPO018"; //OBS: HARDCODE ... PARAMETRIZAR
            objConceptosAux.CONCEPTO = text;
            objConceptosAux.ULTIMOUSUARIO = ENTITY_GLOBAL.Instance.USUARIO;
            objConceptosAux.ACCION = "CONCEPTOFORMPORID";            
            listaAsignados = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSP(objConceptosAux);
            var model = new SEGURIDADCONCEPTO();
            string estadoPanel = "PanelCentralBlanco";
            var objMiscl = new MA_MiscelaneosDetalle();
            objMiscl.ACCION = "TITULO_FORM";
            objMiscl.AplicacionCodigo = "CG";
            objMiscl.CodigoTabla = text.Trim();
            var resulObjMiscl = new MA_MiscelaneosDetalle();
            var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);

            if (listaAsignados.Count ==1)
            {
                foreach (SEGURIDADCONCEPTO obj in listaAsignados)
                {
                    //¿?
                    if (resulMiscelaneosTitulo.Count > 0)
                    {
                        ENTITY_GLOBAL.Instance.MENUREC_CODIGO = resulMiscelaneosTitulo[0].ValorCodigo1;
                        ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = resulMiscelaneosTitulo[0].DescripcionExtranjera;

                    }
                    else {
                        ENTITY_GLOBAL.Instance.MENUREC_CODIGO = "REG0000";
                        ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = "SIN RECURSO";
                    }
                    ENTITY_GLOBAL.Instance.NIVEL = 1;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                    
                    if ((obj.TIPODEOBJETO+"").Trim() == "1")
                    {
                        model.CONCEPTO = (obj.WEBPAGE + "").Trim() + "_View";  //OBS
                        model.DESCRIPCION = obj.DESCRIPCION;
                        model.GRUPO = "REG0000";
                        estadoPanel = "PanelCenter";
                        ENTITY_GLOBAL.Instance.CONCEPTO = obj.CONCEPTO;
                    }
                    else
                    {
                        estadoPanel = "PanelCentralBlanco"; 
                    }
                }
            }
            return new PartialViewResult
            {
                ViewName = estadoPanel,
                ContainerId = containerId,
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };*/
            Log.Information("ProgramarKardexController - LoadCentral - Entrar");

            ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            //VERSION ANTERIOR
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new SEGURIDADCONCEPTO();
            string estado = "PanelCentralBlanco";
            objMiscl.ACCION = "TITULO_FORM";
            objMiscl.AplicacionCodigo = "CG";
            objMiscl.CodigoTabla = text.Trim();
            var resulObjMiscl = new MA_MiscelaneosDetalle();
            var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);
            if (resulMiscelaneosTitulo.Count > 0)
            {

                foreach (MA_MiscelaneosDetalle obMa_Mis in resulMiscelaneosTitulo)
                {
                    ENTITY_GLOBAL.Instance.MENUREC_CODIGO = obMa_Mis.ValorCodigo1;
                    ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = obMa_Mis.DescripcionExtranjera;
                    ENTITY_GLOBAL.Instance.GRUPO = "REG0000";
                    ENTITY_GLOBAL.Instance.NIVEL = 1;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";

                    if (obMa_Mis.ValorCodigo4 == null)
                    {
                        if (obMa_Mis.ValorEntero1 > 0)
                        {
                            ENTITY_GLOBAL.Instance.CONCEPTO = obMa_Mis.ValorCodigo3.Trim();
                            model.CONCEPTO = obMa_Mis.ValorCodigo3.Trim() + "_View";
                            estado = "PanelCenter";
                        }
                        else
                        {
                            estado = "PanelCentralBlanco";
                        }

                    }
                    else if (obMa_Mis.ValorCodigo4.Trim() == "1")
                    {
                        ENTITY_GLOBAL.Instance.CONCEPTO = obMa_Mis.ValorCodigo3.Trim();
                        model.CONCEPTO = obMa_Mis.ValorCodigo3.Trim() + "_View";
                        estado = "PanelCenter";
                    }
                    else if (obMa_Mis.ValorCodigo4.Trim() == "2")
                    {
                        ENTITY_GLOBAL.Instance.CONCEPTO = obMa_Mis.ValorCodigo2.Trim() + "=" + obMa_Mis.ValorCodigo3.Trim();
                        model.CONCEPTO = obMa_Mis.ValorCodigo2.Trim() + "=" + obMa_Mis.ValorCodigo3.Trim();
                        estado = "PanelCenterUrl";
                    }
                    ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION = obMa_Mis.DescripcionLocal.Trim();
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
            Log.Information("ProgramarKardexController - EditCentral - Entrar");
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
                ENTITY_GLOBAL.Instance.EpisodioAtencion = Convert.ToInt32(selection.Trim());
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
                Log.Information("ProgramarKardexController - ExecuteResult - Entrar");
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
            Log.Information("ProgramarKardexController - GetTreeView - Entrar");

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
            Log.Information("ProgramarKardexController - GetTreeChild - Entrar");

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


        public System.Web.Mvc.ActionResult DiscriminaControles(string selection, string accion)
        {
            Log.Information("ProgramarKardexController - DiscriminaControles - Entrar");

            var combo1 = this.GetCmp<ComboBox>("cmbFiltro");
            combo1.Hidden = true;
            return this.Direct();
        }

        public StoreResult GetListarBusquedaServicios(int start, int limit, string tipofiltro,
              string filtro, string tipoBuscar, string Linea, string Familia, String Stock)
        {
            Log.Information("ProgramarKardexController - GetListarBusquedaServicios - Entrar");

            ENTITY_GLOBAL.Instance.GRUPO = "";

            var Listar = new List<MA_MiscelaneosDetalle>();
            var LocalEnty = new MA_MiscelaneosDetalle();
            int cantElementos = 0;
            if (ENTITY_GLOBAL.Instance.MENUREC_CODIGO.Trim() != "0000")
            {
                LocalEnty.CodigoTabla = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;

                //LocalEnty.CodigoElemento = node.Trim();
                //objMiscelaneos

                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.CONCEPTO;
                if (tipofiltro == "CO")
                {
                    LocalEnty.CodigoElemento = filtro;
                    LocalEnty.DescripcionLocal = null;
                }
                else
                {
                    LocalEnty.CodigoElemento = null;
                    LocalEnty.DescripcionLocal = filtro;
                }
                LocalEnty.ValorNumerico = 1; //OBS tipo de folder
                LocalEnty.ACCION = "NIVEL2";

                int ini = (start == 0 ? start : start + 1);
                int fin = start + limit;

                if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }

                //LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;
                //LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION;



                LocalEnty.ValorCodigo4 = Linea;
                LocalEnty.ValorCodigo5 = Familia;

                LocalEnty.ACCION = "BUSCARSERVICIOS";
                LocalEnty.ValorCodigo1 = null;

                if (Stock == "1")
                {
                    LocalEnty.ValorEntero7 = 1;

                }
                else { LocalEnty.ValorEntero7 = 0; }


                string filtroFavoritosNum = null;
                if ((Session["indicaFavoritos"] + "") == "ACTIVO")
                {
                    LocalEnty.ValorCodigo1 = (Session["indicaFavoritos"] + ""); //AUX indicador
                    filtroFavoritosNum = getFiltroFavoritos();
                }
                LocalEnty.ValorCodigo3 = filtroFavoritosNum;
                //ADD 06/11/15  para Obtener Indicador EPS 
                LocalEnty.ValorCodigo6 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                var SES = Session["VW_ATENCIONPACIENTE_GEN_SELECC"];

                if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                {
                    VW_ATENCIONPACIENTE_GENERAL objAtencionPacSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                    if (objAtencionPacSelecc.PersonaAnt != null)
                    {
                        try
                        {
                            // var VALOR = objAtencionPacSelecc.PersonaAnt.Trim();
                            //int numer =int.Parse(VALOR);
                            LocalEnty.ValorCodigo7 = Convert.ToString(objAtencionPacSelecc.PersonaAnt.Trim());//AUX para IdContrato
                            //LocalEnty.ValorEntero1 = Convert.ToInt32(objAtencionPacSelecc.PersonaAnt);//AUX para IdContrato
                        }
                        catch (Exception ex)
                        {
                            EventLog.GenerarLogError(ex);
                        }
                    }
                }
                Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(LocalEnty, ini, fin);
                //cantElementos = SvcMiscelaneos.setMantenimiento(LocalEnty);
                if (Listar.Count > 0)
                {
                    cantElementos = Convert.ToInt32(Listar[0].ValorEntero7); //AUX PARA EL CONTADOR
                    //LocalEnty.ACCION = "BUSCARSERVICIOS";
                    //Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(LocalEnty, ini, fin);
                }
            }
            return this.Store(Listar, cantElementos);
        }
        public StoreResult ArbolMacroProcesos(string node, string filtro)
        {
            Log.Information("ProgramarKardexController - ArbolMacroProcesos - Entrar");

            NodeCollection nodes = new Ext.Net.NodeCollection();
            var objVistaSeguridad = new SS_CHE_VistaSeguridad();
            //OBS:ADD de seguridad
            objVistaSeguridad.CadenaRecursividad = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objVistaSeguridad.IdEmpleado = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objVistaSeguridad.IndicadorPrioridad = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objVistaSeguridad.Version = "" + ENTITY_GLOBAL.Instance.EpisodioAtencion; //AUX - OBS
            ////////////////
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objVistaSeguridad.TipoTrabajador = (String)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            if (Session["TIPOATENCION_ACTUAL"] != null)
            {
                objVistaSeguridad.idTipoAtencion = (int)Session["TIPOATENCION_ACTUAL"];
            }
            //////////////
            //////ADD PARA CONFIGURACION DE ASIGNACIONES
            VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = null;
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                objVistaSeguridad.IdGrupo = vistaGenSelec.IdEspecialidad;//AUX 
            }
            objVistaSeguridad.Compania = ENTITY_GLOBAL.Instance.Compania;
            if (ENTITY_GLOBAL.Instance.Establecimiento != null)
            {
                objVistaSeguridad.IdOrganizacion = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
            }
            if (Session["IdUnidadServicio_ACTUAL"] != null)
            {
                objVistaSeguridad.IdObjetoAsociado = (int)Session["IdUnidadServicio_ACTUAL"];
            }

            if (ENTITY_GLOBAL.Instance.NIVEL == 1)
            {
                objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;
                objVistaSeguridad.Accion = "LISTAPROCESOS";
                objVistaSeguridad.Nivel = 1;
                var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);

                foreach (var resulenti in resulListado)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = resulenti.NombreOpcion;
                    asyncNode.NodeID = resulenti.IdOpcion.ToString().Trim();
                    nodes.Add(asyncNode);
                }
                ENTITY_GLOBAL.Instance.NIVEL = 2;
            }
            else
            {
                if ("root" != node.Trim())
                {
                    var p = this.GetCmp<TreePanel>("treepanel");

                    objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                    objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                    objVistaSeguridad.IdOpcionPadre = Convert.ToInt32(node.Trim());
                    objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                    objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;
                    objVistaSeguridad.Accion = "LISTAPROCESOS";
                    objVistaSeguridad.Nivel = 2;


                    var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);
                    foreach (var resulenti in resulListado)
                    {
                        Node asyncNode = new Node();
                        asyncNode.Text = resulenti.NombreOpcion;
                        asyncNode.NodeID = resulenti.IdOpcion.ToString().Trim();
                        asyncNode.Href = "javascript:myFunction('" + resulenti.NombreOpcion + "')";
                        asyncNode.Leaf = resulenti.TipoIcono > 1 ? true : false;
                        if (resulenti.TipoIcono != null)
                        {
                            if (resulenti.TipoIcono == 5) asyncNode.Icon = Icon.PageGreen;
                            if (resulenti.TipoIcono == 6) asyncNode.Icon = Icon.PageRed;
                        }

                        nodes.Add(asyncNode);
                    }
                }

                ENTITY_GLOBAL.Instance.NIVEL = 2;
            }
            //ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 2;
            return this.Store(nodes);

        }
        public System.Web.Mvc.ActionResult setNodoRootServicios(string tipo)
        {
            Log.Information("ProgramarKardexController - setNodoRootServicios - Entrar");

            Ext.Net.Node root = new Ext.Net.Node();
            root.Text = ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION;
            root.NodeID = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;
            string prefix = DateTime.Now.Second + "_";

            /*
            for (int i = 0; i < 10; i++)
            {
                Ext.Net.Node node = new Ext.Net.Node();
                node.Text = prefix + i;
                node.Leaf = true;
                root.Children.Add(node);
            }*/

            //return root;
            return this.Direct(root);
        }

        public System.Web.Mvc.ActionResult setNodoRootGeneral(string tipo, string id, string text, bool leaf)
        {
            Log.Information("ProgramarKardexController - setNodoRootGeneral - Entrar");

            Ext.Net.Node root = new Ext.Net.Node();
            if (id != null && id != "" && text != null && text != "")
            {
                root.Text = text;
                root.NodeID = id;
            }
            return this.Direct(root);
        }
        public StoreResult GetTreeViewChildRitgh(string node, string filtro)
        {
            Log.Information("ProgramarKardexController - GetTreeViewChildRitgh - Entrar");

            NodeCollection nodes = new Ext.Net.NodeCollection();
            var objMiscelaneos = new MA_MiscelaneosDetalle();
            if (ENTITY_GLOBAL.Instance.NIVEL == 1)
            {
                objMiscelaneos.AplicacionCodigo = "CG";
                objMiscelaneos.CodigoTabla = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;
                objMiscelaneos.CodigoElemento = ENTITY_GLOBAL.Instance.CONCEPTO;
                objMiscelaneos.ValorCodigo1 = ENTITY_GLOBAL.Instance.CONCEPTO;
                //objMiscelaneos.DescripcionLocal = filtro;
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
            else
            {
                var p = this.GetCmp<TreePanel>("treepanel");

                objMiscelaneos.AplicacionCodigo = "CG";
                objMiscelaneos.CodigoTabla = ENTITY_GLOBAL.Instance.MENUREC_CODIGO;
                objMiscelaneos.CodigoElemento = node.Trim();
                //objMiscelaneos
                objMiscelaneos.ValorCodigo1 = ENTITY_GLOBAL.Instance.CONCEPTO;
                objMiscelaneos.DescripcionLocal = filtro;
                objMiscelaneos.ACCION = "NIVEL2";
                //////
                objMiscelaneos.ValorCodigo2 = null;
                string filtroFavoritosNum = null;
                if ((Session["indicaFavoritos"] + "") == "ACTIVO")
                {
                    objMiscelaneos.ValorCodigo2 = (Session["indicaFavoritos"] + ""); //AUX indicador
                    filtroFavoritosNum = getFiltroFavoritos();
                }
                objMiscelaneos.ValorCodigo3 = filtroFavoritosNum;  //AUX filtros favoritos numeros   


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
            Log.Information("ProgramarKardexController - GetTreeViewChild - Entrar");

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
                /**OBS: APLICACIONCODIGO como usuiario auxiliar*/
                entidaLocal.APLICACIONCODIGO = ENTITY_GLOBAL.Instance.USUARIO;

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
                    entidaLocal.GRUPO = "GRUPO018";
                    var serviceResuls = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSP(entidaLocal);
                    foreach (var resulenti in serviceResuls)
                    {
                        Node asyncNode = new Node();
                        asyncNode.Text = resulenti.DESCRIPCION;
                        asyncNode.NodeID = resulenti.CONCEPTO;
                        if (resulenti.TIPODEDETALLE != null)
                        {
                            if (resulenti.TIPODEDETALLE.Trim() == "5") asyncNode.Icon = Icon.PageGreen;
                            if (resulenti.TIPODEDETALLE.Trim() == "6") asyncNode.Icon = Icon.PageRed;
                        }
                        asyncNode.Leaf = Convert.ToInt32(resulenti.TIPODEOBJETO.ToString().Trim()) == 1 ? true : false;
                        nodes.Add(asyncNode);
                    }
                }
            }


            return this.Store(nodes);
        }
        /**FORM CUIDADO PREVENTIVO && SEG. RIESGOS*/
        public StoreResult GetTreeViewCuidadosPrevSegRiesgos(string node, string tipo)
        {
            Log.Information("ProgramarKardexController - GetTreeViewCuidadosPrevSegRiesgos - Entrar");

            var ListaMiscel = new List<MA_MiscelaneosDetalle>();

            SS_HC_SeguimientoRiesgoDetalle objSegRiesgoDetalle = new SS_HC_SeguimientoRiesgoDetalle();
            var listaSegRiesgoDetalle = new List<SS_HC_SeguimientoRiesgoDetalle>();
            int TipoPreven = 0;
            /*if (Session["VariableGenerales"] != null)
            {
                ListaMiscel = (List<MA_MiscelaneosDetalle>)Session["VariableGenerales"];
                TipoPreven = (int)ListaMiscel[0].ValorEntero1;
            }*/
            TipoPreven = Convert.ToInt32(getValorFiltroInt(tipo));
            NodeCollection nodes = new Ext.Net.NodeCollection();
            if (node == "WA")//ROOT ........ OBS: HARDCODE
            {

                //var entidaLocal = new SEGURIDADGRUPO();
                var entidaLocal = new SS_HC_CuidadoPreventivo();
                entidaLocal.Accion = "LISTAR";
                //entidaLocal.Nivel = 0;
                //entidaLocal.CodigoCuidadoPreventivoPadre = null;
                //entidaLocal.IdCuidadoPreventivoPadre = null;
                entidaLocal.IdTipoCuidadoPreventivo = TipoPreven;
                entidaLocal.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                // var serviceResul = null; // SoluccionSalud.Service.CuidadoPreventivoService.SvcCuidadoPreventivo.listarCuidadoPreventivo(entidaLocal, 0, 0);
                //var serviceResul = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto.GetSelectSP(entidaLocal);
                /*foreach (var resulenti in null)
                {
                    String cadenaNodoDesc = "|0|0| ";
                    Node asyncNode = new Node
                    {
                        Text = resulenti.Nivel.ToString().Trim() + '|' + resulenti.IdCuidadoPreventivo +
                            '|' + resulenti.Descripcion + cadenaNodoDesc,
                        NodeID = resulenti.IdCuidadoPreventivo.ToString().Trim(),
                        //NodeID = resulenti.IdCuidadoPreventivo.ToString().Trim(),
                        Leaf = resulenti.Nivel == 1 ? true : false,
                        AttributesObject = new
                        {
                            CodigoCuidadoPreventivo = resulenti.CodigoCuidadoPreventivo,
                            IdCuidadoPreventivo = resulenti.IdCuidadoPreventivo,
                            IdTipoPeriodicidad = resulenti.IdTipoPeriodicidad,
                            Descripcion = resulenti.Descripcion,
                            Version = resulenti.Version,
                            Orden = resulenti.Orden
                        }
                    };
                    nodes.Add(asyncNode);
                }*/
            }
            else
            {

                var entidaLocal = new SS_HC_CuidadoPreventivo();
                /**OBS: usuiario auxiliar*/
                entidaLocal.Accion = "LISTARHIJO";
                string[] cadenas = null;
                cadenas = node.Trim().Split('|');
                //entidaLocal.CodigoCuidadoPreventivoPadre = node;  //OBS
                entidaLocal.IdCuidadoPreventivoPadre = Convert.ToInt32(cadenas[0]);
                entidaLocal.IdTipoCuidadoPreventivo = TipoPreven;
                entidaLocal.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                List<SS_HC_CuidadoPreventivo> serviceResuls = new List<SS_HC_CuidadoPreventivo>();
                //serviceResuls = SoluccionSalud.Service.CuidadoPreventivoService.SvcCuidadoPreventivo.listarCuidadoPreventivo(entidaLocal, 0, 0);
                //bool indicaCargado = false;
                //if (indicaCargado)
                //{              
                //}
                //else
                //{
                //}
                /* foreach (var resulenti in serviceResuls)
                 {
                     objSegRiesgoDetalle.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                     objSegRiesgoDetalle.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                     objSegRiesgoDetalle.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                     objSegRiesgoDetalle.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                     objSegRiesgoDetalle.IdCuidadoPreventivo = resulenti.IdCuidadoPreventivo;
                     objSegRiesgoDetalle.Accion = "LISTARPORIDCUIDADO";
                     listaSegRiesgoDetalle = SvcSeguimientoRiesgoDetalle.listarSeguimientoRiesgoDetalle(objSegRiesgoDetalle);
                     //0: indica que NO debe marcarse en el árbol
                     String cadenaNodoDesc = "|0|0| ";
                     if (listaSegRiesgoDetalle.Count > 0)
                     {
                         //1: indica que SÍ debe marcarse en el árbol
                         cadenaNodoDesc = "|" + "1" + "|" + listaSegRiesgoDetalle[0].Secuencia + "|" + listaSegRiesgoDetalle[0].Comentario;
                     }
                     Node asyncNode = new Node
                     {
                         Text = resulenti.Nivel.ToString().Trim() + '|' + resulenti.IdCuidadoPreventivo +
                             '|' + resulenti.Descripcion + cadenaNodoDesc,
                         NodeID = resulenti.IdCuidadoPreventivo.ToString().Trim(),
                         //NodeID = resulenti.IdCuidadoPreventivo.ToString().Trim(),
                         Leaf = resulenti.Nivel == 1 ? true : false,
                         AttributesObject = new
                         {
                             CodigoCuidadoPreventivo = resulenti.CodigoCuidadoPreventivo,
                             IdCuidadoPreventivo = resulenti.IdCuidadoPreventivo,
                             IdTipoPeriodicidad = resulenti.IdTipoPeriodicidad,
                             Descripcion = resulenti.Descripcion,
                             Version = resulenti.Version,
                             Orden = resulenti.Orden
                         }
                     };
                     nodes.Add(asyncNode);
                 }*/
            }
            /*
            var tree = X.GetCmp<TreePanel>("TreePanelSegRiesgos");
                    Node asyncNodeX = new Node { 
                        Text="ADULTO HOMBRE",
                        NodeID = "AA",
                        AttributesObject = new
                        {
                            CodigoCuidadoPreventivo = "AA",
                            IdTipoPeriodicidad = 5,
                            Descripcion = "ADULTO HOMBRE",
                            Version = "COMENT...",
                            Orden = 1
                        }
                    };
           
            tree.SetRootNode(asyncNodeX);
            */

            return this.Store(nodes);
        }

        public StoreResult getSeguridadOpciones(string filtro)
        {
            Log.Information("ProgramarKardexController - getSeguridadOpciones - Entrar");

            SS_CHE_VistaSeguridad objVistaSeguridad = new SS_CHE_VistaSeguridad();
            objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
            objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
            objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;
            objVistaSeguridad.Accion = "LISTAPROCESOGENERAL";
            //objVistaSeguridad.Nivel = 2;
            List<SS_CHE_VistaSeguridad> lista = new List<SS_CHE_VistaSeguridad>();
            lista = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);
            return this.Store(lista);
        }

        [DirectMethod]
        public string CreateGridPanel(string path)
        {
            return "yes";
        }

        private void RegistraPagina()
        {
            Log.Information("ProgramarKardexController - RegistraPagina - Entrar");


            //var path = Path.Combine(Server.MapPath("~/Views/HClinica"), "");
            //file.SaveAs(path);
            String comillas = @"""";
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

        public System.Web.Mvc.ActionResult cambioSeleccionCronologias(String indica)
        {
            Log.Information("ProgramarKardexController - cambioSeleccionCronologias - Entrar");

            if (indica == "DESELECCION")
            {
                if (ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS == 1)
                {
                    ENTITY_GLOBAL.Instance.UnidadReplicacion = ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP;
                    ENTITY_GLOBAL.Instance.PacienteID = ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP;
                    ENTITY_GLOBAL.Instance.EpisodioClinico = ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP;
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION_TEMP;
                }
                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 0;
            }

            //return showMensajeBox("INFORMACION EXITO","Mensaje","INFO");
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult validarCambiosFormulario(string containerId, string text)
        {
            Log.Information("ProgramarKardexController - validarCambiosFormulario - Entrar");

            if (ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS == 1)
            {
                ENTITY_GLOBAL.Instance.UnidadReplicacion = ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP;
                ENTITY_GLOBAL.Instance.PacienteID = ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP;
                ENTITY_GLOBAL.Instance.EpisodioClinico = ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP;
                //  ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION_TEMP;
                //ADD
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION_TEMP;

                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 0;
            }
            if (ENTITY_GLOBAL.Instance.indicadorAuxiliar && ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "VISTA")
            {
                if ((ENTITY_GLOBAL.Instance.CONCEPTO + "").Trim() != (text + "").Trim())
                {
                    return showMensajeConfirmacion("Confirmación",
                       "Existen modificaciones sin guardar. ¿Desea salir del formulario " +
                               ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION + " ?.",
                        "Sí", "No",
                        "LoadFormatos('" + containerId + "', '" + text + "')", "DoSave()", "DoCancel()");
                }
                else
                {
                    return this.Direct();
                }
            }
            else
            {
                return LoadFormatos(containerId, text);
            }
        }
        public System.Web.Mvc.ActionResult validarCambiosFormularioInicio(string containerId, string text)
        {
            Log.Information("ProgramarKardexController - validarCambiosFormularioInicio - Entrar");

            if (ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS == 1)
            {
                ENTITY_GLOBAL.Instance.UnidadReplicacion = ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP;
                ENTITY_GLOBAL.Instance.PacienteID = ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP;
                ENTITY_GLOBAL.Instance.EpisodioClinico = ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION_TEMP;
                //ADD
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION_TEMP;

                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 0;
            }

            if (ENTITY_GLOBAL.Instance.indicadorAuxiliar && ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION != "VISTA")
            {
                if ((ENTITY_GLOBAL.Instance.CONCEPTO + "").Trim() != (text + "").Trim())
                {
                    return showMensajeConfirmacion("Confirmación",
                         "Existen modificaciones sin guardar. ¿Desea salir del formulario" +
                          ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION + "?.",
                         "Sí", "No",
                         "DoNoInicio()", "DoInicio()", "DoNoInicio()");
                    //'" +
                    //        ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION + "'
                }
                else
                {
                    return this.Direct();
                }
            }
            else
            {
                return LoadBandejaEntrada();
            }
        }
        public System.Web.Mvc.ActionResult eventoResizeForm(string height, string indica)
        {
            Log.Information("ProgramarKardexController - eventoResizeForm - Entrar");

            var form = this.GetCmp<TreePanel>("center");

            form.SetHeight(600);
            form.Reload();
            return this.Direct();
        }        /***/
        public System.Web.Mvc.ActionResult setActivoFiltro(
            string text, string id, bool valor)
        {
            Log.Information("ProgramarKardexController - setActivoFiltro - Entrar");

            if (valor) //ADD
            {
                Session["indicaFavoritos"] = "ACTIVO";
            }
            else
            {
                Session["indicaFavoritos"] = "INACTIVO";
            }
            return this.Direct();
        }
        /***/
        public System.Web.Mvc.ActionResult add_delete_DataSeleccFavoritos(
            string text, string id, string numero, bool valor)
        {
            Log.Information("ProgramarKardexController - add_delete_DataSeleccFavoritos - Entrar");

            List<SS_HC_FavoritoNumero> dataSelec = null;
            int idfavorito = Convert.ToInt32(id);
            int idNumero = Convert.ToInt32(numero);
            if (Session["DataFavoritosSelec"] != null)
            {
                dataSelec = (List<SS_HC_FavoritoNumero>)Session["DataFavoritosSelec"];
            }
            else
            {
                dataSelec = new List<SS_HC_FavoritoNumero>();
            }
            if (valor) //ADD
            {
                SS_HC_FavoritoNumero objSelec = new SS_HC_FavoritoNumero();
                try
                {
                    objSelec.IdFavorito = idfavorito;
                    objSelec.NumeroFavorito = idNumero;
                    objSelec.Accion = "";
                    dataSelec.Add(objSelec);
                }
                catch (Exception ex)
                {
                    Log.Error(ex, ex.Message);
                }
            }
            else//DELETE
            {
                if (dataSelec.Count > 0)
                {
                    foreach (var result in dataSelec)
                    {
                        if (idNumero == result.NumeroFavorito && idfavorito == result.IdFavorito)
                        {
                            dataSelec.Remove(result);
                            break;
                        }
                    }
                }
            }

            Session["DataFavoritosSelec"] = dataSelec;
            return this.Direct();
        }

        /***/
        public System.Web.Mvc.ActionResult eventoMantenFavoritoRegistro(String MODO, String idFavorito,
            String idNumero, String ItemSeleccionado, String indicaItem)
        {
            Log.Information("ProgramarKardexController - eventoMantenFavoritoRegistro - Entrar");

            List<vw_favoritos> listaFavoritos = new List<vw_favoritos>();
            vw_favoritos objModel = new vw_favoritos();
            //objModel.Accion = MODO;

            if (MODO == "NUEVO")
            {
                objModel.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                objModel.IdAgente = ENTITY_GLOBAL.Instance.IDAGENTE;
            }
            else
            {
                objModel.Accion = "LISTAR";
                if (getValorFiltroInt(idFavorito) != null)
                {
                    objModel.IdFavorito = Convert.ToInt32(idFavorito);
                }
                if (getValorFiltroInt(idNumero) != null)
                {
                    objModel.NumeroFavorito = Convert.ToInt32(idNumero);
                }

                objModel.IdAgente = ENTITY_GLOBAL.Instance.IDAGENTE;
                listaFavoritos = SvcVw_Favoritos.listarvw_favoritos(objModel, 0, 0);
                if (listaFavoritos.Count == 1)
                {
                    objModel = listaFavoritos[0];
                    /*
                    objModel.CodigoAgente = listaFavoritos[0].CodigoAgente;
                    objModel.IdFavorito = listaFavoritos[0].IdFavorito;
                    objModel.NumeroFavorito = listaFavoritos[0].NumeroFavorito;
                    objModel.Mnemotecnico = listaFavoritos[0].Mnemotecnico;
                    */
                }
                else
                {
                    return showMensajeNotify("Advertencia", "Asegúrese de haber seleccionado algún Bien o Servicio.", "WARNING");
                }

            }

            objModel.NombreTabla = indicaItem; //AUX
            objModel.Version = "" + ItemSeleccionado;
            objModel.Accion = MODO;
            return crearWindowRegistro("AdminFavoritos/AdminFavoritosServicios", objModel, "");
        }

        public System.Web.Mvc.ActionResult save_Addfavorito(vw_favoritos objSave, String MODO,
            String idWindow, String indicaItem)
        {
            Log.Information("ProgramarKardexController - save_Addfavorito - Entrar");

            List<ENTITY_MENSAJES> msgNoValido = null;
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            if (objSave != null)
            {
                try
                {
                    if (MODO == "NUEVO")
                    {
                        objSave.Accion = "INSERT";
                        accion = "registró";
                    }
                    else if (MODO == "UPDATE")
                    {
                        objSave.Accion = "INSERT";
                        accion = "modificó";
                    }
                    else if (MODO == "DELETE")
                    {
                        objSave.Accion = "DELETEUSER";
                        accion = "eliminó";
                    }
                    else
                    {
                        tipoMsg = "WARNING";
                        message = "No se encotró el MODO.";
                        tituloMsg = "Advertencia";
                    }
                    ///////////SAVE
                    SS_HC_FavoritoDetalle objSaveDetalle = new SS_HC_FavoritoDetalle();
                    int idFavorito = 0;
                    int numeroFavorito = 0;
                    if (MODO == "NUEVO")
                    {

                    }
                    else
                    {
                        idFavorito = objSave.IdFavorito;
                        numeroFavorito = Convert.ToInt32(objSave.NumeroFavorito);
                    }
                    if (idFavorito > 0 && numeroFavorito > 0)
                    {
                        objSaveDetalle.Accion = objSave.Accion;
                        objSaveDetalle.IdFavorito = idFavorito;
                        objSaveDetalle.NumeroFavorito = numeroFavorito;

                        objSaveDetalle.ValorTexto4 = indicaItem;
                        objSaveDetalle.ValorTexto2 = objSave.NombreTabla;
                        objSaveDetalle.ValorTexto1 = objSave.Version;
                        objSaveDetalle.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;

                        if (objSave.Version != null)
                        {
                            string[] cadArray = objSave.Version.Trim().Split('|');
                            string cadenas = cadArray[1].Replace("[", "");
                            cadenas = cadenas.Replace("]", "").Trim();
                            if (indicaItem == "ITEMS")
                            {
                                if (cadenas.Contains("-"))
                                {
                                    string[] cadArray2 = cadenas.Trim().Split('-');
                                    if (cadArray2.Length > 2)
                                    {
                                        objSaveDetalle.ValorTexto5 = cadArray2[0]; //LINEA
                                        objSaveDetalle.ValorTexto2 = cadArray2[1]; //FAMILIA
                                        objSaveDetalle.ValorTexto3 =
                                             (cadArray2[2] + "").Trim(); //SUB FAM
                                        if (cadArray2.Length > 3)
                                        {
                                            objSaveDetalle.ValorTexto3 = objSaveDetalle.ValorTexto3 + "|" +
                                                    (cadArray2[3] + "").Trim(); //ITEM para MED                                                                                       
                                        }
                                    }
                                }
                            }
                            else
                            {
                                if (!cadenas.Contains("-"))
                                {
                                    objSaveDetalle.ValorId = Convert.ToInt32(cadenas);
                                }
                            }

                            idResultado = SvcFavoritoDetalle.setMantenimiento(objSaveDetalle, Convert.ToInt32(objSave.IdAgente),
                                Convert.ToInt32(objSave.TipoFavorito));
                        }
                    }

                    if (idResultado > 0)
                    {
                        message = "Se " + accion + " el  Elemento (" + objSave.Descripcion + ") satisfactoriamente.";
                    }
                    else
                    {
                        tipoMsg = "ERROR";
                        message = "No se pudo guadar los cambios. Sucedió un error en la operación.";
                        tituloMsg = "Error";
                    }
                    Store compoX = X.GetCmp<Ext.Net.Store>("StoreBuscarServicios");
                    compoX.Reload();

                    return showMensajeNotify("INFO", message, "INFO");
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - save_Addfavorito - Bloque Catch");
                    Log.Error(ex, ex.Message);
                    EventLog.GenerarLogError(ex);
                    var sqlException = ex.InnerException as SqlException;
                    var detalle = new MA_MiscelaneosDetalle();
                    detalle.ACCION = "ERRORES";
                    List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                    if (sqlException != null)
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                    }
                    else
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                    }
                    string mostrarExc = "Excepción genérica:";
                    if (resultado.Count > 0)
                    {
                        mostrarExc = resultado[0].DescripcionLocal;
                    }
                    indicaValidacionForm = true;
                    return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                    throw;
                }
            }
            return this.Direct();
        }

        /***/
        public string getFiltroFavoritos()
        {
            Log.Information("ProgramarKardexController - getFiltroFavoritos - Entrar");
            string filtroFav = "";
            string filtroDelimIni = "R";
            string filtroDelimUnion = "y";
            List<SS_HC_FavoritoNumero> dataSelec = null;
            //int idNumero = Convert.ToInt32(id);
            if (Session["DataFavoritosSelec"] != null)
            {
                dataSelec = (List<SS_HC_FavoritoNumero>)Session["DataFavoritosSelec"];
                foreach (var result in dataSelec)
                {
                    filtroFav = filtroFav + filtroDelimIni + result.IdFavorito + "_" + result.NumeroFavorito + filtroDelimUnion;
                }
                filtroFav = filtroFav + "x";
            }
            return filtroFav;
        }


        public class checkMenu
        {
            public string ID { get; set; }
            public string Text { get; set; }
            public static List<Ext.Net.CheckMenuItem> getCheckMenuBienesServ(string valor)
            {
                Log.Information("ProgramarKardexController - getCheckMenuBienesServ - Entrar");

                var Listar = new List<SS_HC_FavoritoNumero>();
                var LocalEnty = new SS_HC_FavoritoNumero();
                int idAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                int tipoFav = 1;
                LocalEnty.Accion = "LISTARMENUFAV";
                Listar = SvcFavoritoNumero.listarFavoritoNumero(LocalEnty, idAgente, tipoFav);
                List<Ext.Net.CheckMenuItem> listaCheckMenu = new List<Ext.Net.CheckMenuItem>();

                foreach (var result in Listar)
                {
                    Ext.Net.CheckMenuItem objCheckMenu = new Ext.Net.CheckMenuItem();
                    objCheckMenu.ID = (result.IdFavorito + "|" + result.NumeroFavorito);
                    objCheckMenu.Text = (result.Descripcion + "").Trim();
                    //objCheckMenu.Checked
                    objCheckMenu.Hidden = false;
                    //objCheckMenu.Icon =
                    listaCheckMenu.Add(objCheckMenu);
                }
                return listaCheckMenu;
            }
            public static List<Ext.Net.MenuItem> getMenuBienesServ(string valor)
            {
                Log.Information("ProgramarKardexController - getMenuBienesServ - Entrar");

                var Listar = new List<SS_HC_FavoritoNumero>();
                var LocalEnty = new SS_HC_FavoritoNumero();
                int idAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                int tipoFav = 1;
                LocalEnty.Accion = "LISTARMENUFAV";
                Listar = SvcFavoritoNumero.listarFavoritoNumero(LocalEnty, idAgente, tipoFav);
                List<Ext.Net.MenuItem> listaMenu = new List<Ext.Net.MenuItem>();

                foreach (var result in Listar)
                {
                    Ext.Net.MenuItem objMenu = new Ext.Net.MenuItem();
                    objMenu.ID = (result.IdFavorito + "|" + result.NumeroFavorito) + "|_item";
                    objMenu.Text = (result.Descripcion + "").Trim();
                    //objCheckMenu.Checked
                    objMenu.Hidden = false;
                    objMenu.Icon = Ext.Net.Icon.ApplicationFormAdd;
                    listaMenu.Add(objMenu);
                }
                return listaMenu;
            }

            public static List<Ext.Net.CheckMenuItem> getCheckMenuCHE(string valor)
            {
                Log.Information("ProgramarKardexController - getCheckMenuCHE - Entrar");


                List<Ext.Net.CheckMenuItem> lista = new List<Ext.Net.CheckMenuItem>();
                Ext.Net.CheckMenuItem obj;
                for (int i = 0; i <= 10; i++)
                {
                    obj = new Ext.Net.CheckMenuItem();
                    obj.ID = "a" + i.ToString().Trim();
                    obj.Text = "aaa";
                    obj.Hidden = false;
                    lista.Add(obj);
                }
                return lista;
            }
        }


        /****ADD MENSAJES VALIDACIÓN **/
        public System.Web.Mvc.ActionResult addRecursosValidacion(String data, String indica)
        {
            Log.Information("ProgramarKardexController - addRecursosValidacion - Entrar");

            /*******SET PROP. FORMULARIO*****************************/
            Session["MENSAJES_VALFORM"] = null;
            if (data != null && Session["RECURSOS_VALFORM"] != null)
            {
                List<VW_SS_HC_TABLAFORMATO_VALIDACION> dataRecursosForm;
                List<ENTITY_MENSAJES> dataMensajesValidacion = new List<ENTITY_MENSAJES>();
                List<VW_SS_HC_TABLAFORMATO_VALIDACION> dataFields;
                dataFields = (List<VW_SS_HC_TABLAFORMATO_VALIDACION>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<VW_SS_HC_TABLAFORMATO_VALIDACION>));
                foreach (var resultMsg in dataFields)
                {
                    dataMensajesValidacion.Add(new ENTITY_MENSAJES
                    {
                        DESCRIPCION = resultMsg.ValorTexto,
                        IDCOMPONENTE = resultMsg.NombreCampo,
                        NIVEL = 1
                    });

                }
                Session["MENSAJES_VALFORM"] = dataMensajesValidacion;
            }
            /*************************************************************/
            List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
            msgNoValido = (List<ENTITY_MENSAJES>)Session["MENSAJES_VALFORM"];
            //return this.Store(listaResources);
            return showMensajeBotton(msgNoValido, "", "");
            //return this.Direct();
        }


        public PartialViewResult eventoVerFile(String nombreArchivo, int idRegistro, string Form, string Accion)
        {
            Log.Information("ProgramarKardexController - eventoVerFile - Entrar");

            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new SEGURIDADCONCEPTO();
            string estado = "PanelCentralBlanco";
            string paths = "~/resources/DocumentosAdjuntos/";
            if (idRegistro <= 0)
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
                estado = "VisorDocumentos";
                //String ruta = "http://localhost:11505/~resources/DocumentosAdjuntos/" + nombreArchivo;
                String ruta = "http://localhost:11505/~resources/DocumentosAdjuntos/" + "ResultadoExamen.doc";
                String rutaGoogle = "http://docs.google.com/viewer?url=" + ruta + "&embedded=false&a=bi&w=1820&pagenumber=1";
                model.CONCEPTO = nombreArchivo;
                model.Url = rutaGoogle;
                model.DESCRIPCION = rutaGoogle;
            }
            return new PartialViewResult
            {
                ViewName = estado,
                ContainerId = "South1",
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };
        }

        /*ABOUT DEL SISTEMA**/
        public System.Web.Mvc.ActionResult eventoAbout(string indicador)
        {
            Log.Information("ProgramarKardexController - eventoAbout - Entrar");

            ENTITY_GENERALHCE objModel = new ENTITY_GENERALHCE();
            objModel.ACCION = "VER";
            /********************/
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            List<MA_MiscelaneosDetalle> listInfoSession = new List<MA_MiscelaneosDetalle>();
            MA_MiscelaneosDetalle InfoSession = new MA_MiscelaneosDetalle();
            InfoSession.ACCION = "INFOABOUT";
            InfoSession.CodigoElemento = "" + ENTITY_GLOBAL.Instance.IDAGENTE;
            InfoSession.AplicacionCodigo = ENTITY_GLOBAL.Instance.APPCODIGO;
            InfoSession.Compania = ENTITY_GLOBAL.Instance.Compania;
            InfoSession.CodigoTabla = ENTITY_GLOBAL.Instance.Sucursal;//AUX            
            InfoSession.ValorCodigo1 = ENTITY_GLOBAL.Instance.Establecimiento;

            if (ENTITY_GLOBAL.Instance.CODPERSONA != null)
            {
                InfoSession.ValorCodigo2 = "" + ENTITY_GLOBAL.Instance.CODPERSONA;
            }
            int paciente = 0;
            if (ENTITY_GLOBAL.Instance.PacienteID != null)
            {
                paciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            }

            listInfoSession = SvcMiscelaneos.listarMA_MiscelaneosDetalle(InfoSession, paciente, 0);
            //ver stored: [SP_SS_HC_MA_MiscelaneosDetalle_LISTAR]
            if (listInfoSession.Count > 0)
            {
                objModel.campoStr01 = listInfoSession[0].Compania; //CompaniaSocio desc
                objModel.campoStr02 = listInfoSession[0].CodigoTabla; //Sucursal desc
                objModel.campoStr03 = listInfoSession[0].AplicacionCodigo; //Aplicacion desc

                objModel.campoStr04 = listInfoSession[0].ValorCodigo1; //ESTABLECIMIENTO
                objModel.campoStr05 = listInfoSession[0].ValorCodigo2;     //PERIODO
                objModel.campoStr06 = listInfoSession[0].ValorCodigo3;  //DB

                objModel.campoStr07 = listInfoSession[0].ValorCodigo4; //TipoTrabajador desc                
                objModel.USUARIO = listInfoSession[0].UltimoUsuario;//USUARIO
                objModel.campoStr08 = listInfoSession[0].DescripcionLocal; //NOMBRE EMPLEADO
                objModel.campoInt01 = Convert.ToInt32(listInfoSession[0].ValorEntero1);
                objModel.campoStr08 = listInfoSession[0].ValorCodigo5; // módulo prueba
                objModel.campoStr09 = listInfoSession[0].ValorCodigo6; //sistema prueba
                objModel.campoStr10 = listInfoSession[0].ValorCodigo7; //DESARROLLADO POR
            }
            /********************/
            string Form = "AboutView";
            return crearWindowRegistro(Form, objModel, "");
        }
        /**EPISODIOS CLINICOS****/
        public System.Web.Mvc.ActionResult EstadoClinico(Nullable<int> selection, string accion)
        {
            Log.Information("ProgramarKardexController - EstadoClinico - Entrar");

            try
            {
                int registro = -1;
                string mensaje = "";
                if (accion == "Nuevo")
                {
                    SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                    objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEpClinico.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    objEpClinico.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    objEpClinico.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                    objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;

                    objEpClinico.ACCION = "UPDATE_EPINUEVO";

                    registro = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                    mensaje = "Asignación de NUEVO EPISODIO satisfactorio. Episodio Clínico creado:";


                }
                else if (accion == "Continuar")
                {
                    if (selection != null)
                    {
                        SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                        objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        objEpClinico.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                        objEpClinico.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                        objEpClinico.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                        objEpClinico.CodigoEpisodioClinico = selection;
                        objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;

                        objEpClinico.ACCION = "UPDATE_EPICONTINUAR";
                        registro = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                        mensaje = "Asignación de EPISODIO CONTINUADO satisfactorio. Episodio Clínico asignado:";

                    }
                }


                if (registro > 0)
                {
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = registro;
                    Label labelX = X.GetCmp<Ext.Net.Label>("lblNumEpsiodioHCE");
                    Button btnNuevo = X.GetCmp<Ext.Net.Button>("btnNewEpisodio_HCE");
                    btnNuevo.Hidden = true;
                    Button btnCont = X.GetCmp<Ext.Net.Button>("btnContEpisodio_HCE");
                    btnCont.Hidden = true;

                    labelX.Text = UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencion,
                                    0, ENTITY_GLOBAL.Instance.CodigoOA);

                    UTILES_MENSAJES.setParametro_Form("EPI_CLINICO_CREADO", ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo);

                    return showMensajeNotify("Ventana de Mensajes",
                   mensaje +
                    registro, "INFO");
                }
                else
                {                   
                    return showMensajeNotify("Ventana de Mensajes",
                        "No se pudo asignar el episodio. Error inesperado.", "ERROR");
                }
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - EstadoClinico - Bloque Catch");
                Log.Error(ex, ex.Message);
            }
            return this.Direct();
        }


        public System.Web.Mvc.ActionResult EstadoClinicoMedicamento(Nullable<int> selection, string accion)
        {
            Label labelX = X.GetCmp<Ext.Net.Label>("lblNumEpsiodioHCE");
            Button btnNuevo = X.GetCmp<Ext.Net.Button>("btnNewEpisodio_HCE");
            btnNuevo.Hidden = true;
            Button btnCont = X.GetCmp<Ext.Net.Button>("btnContEpisodio_HCE");
            btnCont.Hidden = true;

            try
            {
                int registro = -1;
                string mensaje = "";

            }
            catch (Exception ex)
            {

            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult ListadoAtenciones(String MODO, int paciente, string nombre, string codigooa)
        {
            Log.Information("ProgramarKardexController - ListadoAtenciones - Entrar");
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.Accion = "Continuar";
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);

            objModel.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objModel.EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
            objModel.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;

            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            return crearWindowRegistro("Procesos/ContinuarEpisodio", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult eventoRenderController(String codigo, String data, String indica)
        {
            Log.Information("ProgramarKardexController - eventoRenderController - Entrar");

            if (indica == "ORIGENDIAGNOSTICO")
            {
                if (codigo == "IMPRESIONDIAG")
                {
                    Panel panelServ = X.GetCmp<Panel>("East1");
                    if (panelServ != null)
                    {
                        panelServ.Collapse();
                    }
                }
            }
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientesContinuar(int start, int limit,
     string txtFecha1, string txtFecha2, string txtCodigoOA, string txtPaciente,
     string tipoConsulta, string tipoEstado, string idPaciente, string tipoBuscar)
        {
            Log.Information("ProgramarKardexController - GrillaListadoAtencionPacientesContinuar - Entrar");

            int cantElementos = 0;
            var Listar = new List<VW_ATENCIONPACIENTE>();
            try
            {
                ////////////////
                ENTITY_GLOBAL.Instance.GRUPO = "";
                //ConsultaCita();
                //var field = X.GetCmp<TextField>("txtPaciente");                             
                var LocalEnty = new VW_ATENCIONPACIENTE();
                int ini = (start == 0 ? start : start + 1);
                int fin = start + limit;
                //Si la busqueda proviene de filtros
                if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }

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
                if (txtFecha1 != null)
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
                if (txtFecha1 != null)
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

                LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);

                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                LocalEnty.IdPaciente = getValorFiltroInt(idPaciente);

                /**ADD CONFIGURACIÓN*/
                //LocalEnty.Compania = ENTITY_GLOBAL.Instance.Compania;
                //LocalEnty.Sucursal = ENTITY_GLOBAL.Instance.Sucursal;
                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                LocalEnty.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                {
                    LocalEnty.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                }
                ///////////
                var ACCIONlistado = "LISTARPAGCONTINUAR";
                if (tipoConsulta == "CONTINUAR")
                {
                    LocalEnty.Servicio = "EPISODIO"; //AUX para listar solo los Creados como EPISODIOS
                    ACCIONlistado = "LISTARPAGCONTINUAR";
                }

                LocalEnty.Accion = ACCIONlistado;
                cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = ACCIONlistado;
                    Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
                }
                //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
                //Session["ENTITY_PACIENTE"] = Listar;  
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - GrillaListadoAtencionPacientesContinuar - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Ocurrió una excepción en la ejecución.";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
            return this.Store(Listar, cantElementos);
        }

        // MOTOR DE REGLAS
        /**Regla: SP_RGN_07_AlertaDescansoMedico*/
        public System.Web.Mvc.ActionResult POSaludDescansoMedico(int PacienteID, int dias, String regla, String arrays)
        {
            Log.Information("ProgramarKardexController - POSaludDescansoMedico - Entrar");
            String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
                    (String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
            if (PARAM == "S")
            {
                try
                {
                    int tiempoDescanso = 0;
                    /******* MISCELANEOS AQUILES INFORMACION*****************************/
                    HC_RuleGetCollectionStore objEnv = new HC_RuleGetCollectionStore();
                    List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                    objLista = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(arrays, typeof(List<MA_MiscelaneosDetalle>));
                    objEnv.AplicacionCodigo = "999";
                    objEnv.CodigoElemento = "11111";
                    objEnv.CodigoTabla = "0000";
                    objEnv.ValorFechaFinal = objLista[0].ValorFecha;
                    objEnv.ValorEntero1 = ENTITY_GLOBAL.Instance.PacienteID;
                    objEnv.ACCION = "DESCANSOMEDICO";
                    var Result = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);
                    tiempoDescanso = (int)objLista[0].ValorEntero1;
                    if (Result.Count > 0) tiempoDescanso = tiempoDescanso + ((int)Result[0].ValorEntero2);

                    /*******INVOCA REGLA*****************************/
                    MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                    objRegla.CodigoTabla = regla;
                    objRegla.Dias = tiempoDescanso;
                    objRegla = ServiciosRules.POSaludDescansoMedico(objRegla);

                    /*************************************************************/
                    ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                    mostMensaje.DESCRIPCION = "El Paciente excede el número de días de descanso.";
                    if (objRegla != null)
                        mostMensaje.ESTADOBOOL = objRegla.resultBool;
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    msgNoValido.Add(mostMensaje);
                    //return this.Store(listaResources);
                    return showMensajeBotton(msgNoValido, "", "");
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - POSaludDescansoMedico - Bloque Catch");
                    Log.Error(ex, ex.Message);
                }
                return this.Direct();
            }
            else
            {
                return this.Direct();
            }

        }
        /**Regla : SP_RGN_02_ExamenGinecologico*/
        public System.Web.Mvc.ActionResult POSaludControlGinecologia(int PacienteID, int valor, String regla, String arrays)
        {
            Log.Information("ProgramarKardexController - POSaludControlGinecologia - Entrar");
            String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
                    (String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
            if (PARAM == "S")
            {
                try
                {
                    int tiempoDescanso = 0;
                    /******* MISCELANEOS AQUILES INFORMACION*****************************/
                    HC_RuleGetCollectionStore objEnv = new HC_RuleGetCollectionStore();
                    List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                    //  objLista = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(arrays, typeof(List<MA_MiscelaneosDetalle>));
                    objEnv.AplicacionCodigo = "999";
                    objEnv.CodigoElemento = "11111";
                    objEnv.CodigoTabla = "0000";
                    objEnv.ValorEntero1 = ENTITY_GLOBAL.Instance.PacienteID;
                    objEnv.ACCION = "CONTROLGINECOLOGIA";
                    var Result = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);

                    /*******INVOCA REGLA*****************************/
                    MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                    objRegla.CodigoTabla = regla;
                    if (Result.Count > 0)
                    {
                        objRegla.SexoPaciente = Result[0].ValorCodigo1;
                        objRegla.EdadPaciente = (int)Result[0].ValorEntero2;
                        objRegla.TipoAtencion = (int)Result[0].ValorEntero3;
                        objRegla.CodigoComponente = Result[0].ValorCodigo2;
                        objRegla.FechaUltimoExamen = (Result[0].ValorFecha != null ? ((DateTime)(Result[0].ValorFecha)) : DateTime.Now);
                        objRegla.Annos = (DateTime.Now.Year - objRegla.FechaUltimoExamen.Year);
                    }
                    objRegla = ServiciosRules.POSaludControlGinecologia(objRegla);

                    /*************************************************************/
                    ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                    mostMensaje.DESCRIPCION = "El Paciente No registra control de ginecología.";
                    if (objRegla != null)
                        mostMensaje.ESTADOBOOL = objRegla.resultBool;
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    msgNoValido.Add(mostMensaje);
                    //return this.Store(listaResources);
                    return showMensajeBotton(msgNoValido, "", "");
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - POSaludControlGinecologia - Bloque Catch");
                    Log.Error(ex, ex.Message);
                }
                return this.Direct();
            }
            else
            {
                return this.Direct();
            }
        }

        /**Regla : SP_RGN_06_ReportarDiagnostico*/
        public System.Web.Mvc.ActionResult POSaludDiagnosticoInformado(int PacienteID, int valor, String regla, String arrays)
        {
            Log.Information("ProgramarKardexController - POSaludDiagnosticoInformado - Entrar");

            String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
        (String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
            if (PARAM == "S")
            {
                try
                {
                    int tiempoDescanso = 0;
                    /******* MISCELANEOS AQUILES INFORMACION*****************************/
                    HC_RuleGetCollectionStore objEnv = new HC_RuleGetCollectionStore();
                    List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                    //  objLista = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(arrays, typeof(List<MA_MiscelaneosDetalle>));
                    objEnv.AplicacionCodigo = "999";
                    objEnv.CodigoElemento = "11111";
                    objEnv.CodigoTabla = "0000";
                    objEnv.ValorCodigo1 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEnv.ValorEntero1 = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    objEnv.ValorEntero2 = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    objEnv.ValorEntero3 = Convert.ToInt32("" + ENTITY_GLOBAL.Instance.EpisodioAtencion);
                    objEnv.ACCION = "REPDIAGNOSTICO";
                    var Result = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);

                    /*******INVOCA REGLA*****************************/
                    MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                    objRegla.CodigoTabla = regla;
                    if (Result.Count > 0)
                    {
                        objRegla.UnidadReplicacion = Result[0].ValorCodigo1;
                        //objRegla.IdPaciente = (int)Result[0].ValorEntero1;
                        objRegla.EpisodioClinico = (int)Result[0].ValorEntero2;
                        objRegla.EpisodioAtencion = (int)Result[0].ValorEntero3;
                        objRegla.Secuencia = (int)Result[0].ValorEntero4;
                        objRegla.CodigoDiagnostico = Result[0].ValorCodigo2;
                        objRegla.DeterminacionDiagnostico = Result[0].ValorCodigo3;
                    }
                    objRegla = ServiciosRules.POSaludDiagnosticoInformado(objRegla);

                    /*************************************************************/
                    ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                    mostMensaje.DESCRIPCION = "No registró Diagnóstico Definitivo.";
                    if (objRegla != null)
                    {
                        mostMensaje.ESTADOBOOL = objRegla.resultBool;
                        if (objRegla.resultBool != null ? Convert.ToBoolean(objRegla.resultBool) : false)
                        {
                            //...
                            objEnv.ValorEntero4 = objRegla.Secuencia;
                            objEnv.ACCION = "REPDIAGNOSTICO_UP";
                            var Result2 = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);
                        }
                    }
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    msgNoValido.Add(mostMensaje);
                    //return this.Store(listaResources);
                    return showMensajeBotton(msgNoValido, "", "");
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - POSaludDiagnosticoInformado - Bloque Catch");
                    Log.Error(ex, ex.Message);
                }
                return this.Direct();
            }
            else
            {
                return this.Direct();
            }

        }

        /**Regla: SP_RGN_05_AlertaPrioridadEspera*/
        public System.Web.Mvc.ActionResult POSaludEmergenciaEspera(int PacienteID, int valor, String regla, String arrays)
        {
            Log.Information("ProgramarKardexController - POSaludEmergenciaEspera - Entrar");

            String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
                (String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
            if (PARAM == "S")
            {
                try
                {
                    int tiempoDescanso = 0;
                    /******* MISCELANEOS AQUILES INFORMACION*****************************/
                    HC_RuleGetCollectionStore objEnv = new HC_RuleGetCollectionStore();
                    List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                    //  objLista = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(arrays, typeof(List<MA_MiscelaneosDetalle>));
                    objEnv.AplicacionCodigo = "999";
                    objEnv.CodigoElemento = "11111";
                    objEnv.CodigoTabla = "0000";
                    objEnv.ValorCodigo1 = ENTITY_GLOBAL.Instance.UnidadReplicacion;

                    objEnv.ACCION = "PRIORIDADESPERA";
                    var Result = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);

                    /*******INVOCA REGLA*****************************/
                    MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                    objRegla.CodigoTabla = regla;
                    if (Result.Count > 0)
                    {
                        objRegla.UnidadReplicacion = Result[0].ValorCodigo1;
                        objRegla.IdOrdenAtencion = (int)Result[0].ValorEntero1;
                        objRegla.TipoAtencion = (int)Result[0].ValorEntero2;
                        objRegla.FechaInicio = (Result[0].ValorFecha != null ? ((DateTime)(Result[0].ValorFecha)) : DateTime.Now);
                        objRegla.Prioridad = (int)Result[0].ValorEntero3;
                    }
                    objRegla = ServiciosRules.POSaludEmergenciaEspera(objRegla);

                    /*************************************************************/
                    ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                    mostMensaje.DESCRIPCION = "Atención prioritaria.";
                    if (objRegla != null)
                        mostMensaje.ESTADOBOOL = objRegla.resultBool;
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    msgNoValido.Add(mostMensaje);
                    //return this.Store(listaResources);
                    return showMensajeBotton(msgNoValido, "", "");
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - POSaludEmergenciaEspera - Bloque Catch");
                    Log.Error(ex, ex.Message);
                }
                return this.Direct();
            }
            else
            {
                return this.Direct();
            }

        }

        /*Regla : SP_RGN_01_ExamenLaboratorio**/
        public System.Web.Mvc.ActionResult POSaludExamenLaboratorio(int PacienteID, int valor, String regla, String arrays)
        {
            Log.Information("ProgramarKardexController - POSaludExamenLaboratorio - Entrar");
            String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
                (String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
            if (PARAM == "S")
            {
                try
                {
                    int tiempoDescanso = 0;
                    /******* MISCELANEOS AQUILES INFORMACION*****************************/
                    HC_RuleGetCollectionStore objEnv = new HC_RuleGetCollectionStore();
                    List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                    //  objLista = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(arrays, typeof(List<MA_MiscelaneosDetalle>));
                    objEnv.AplicacionCodigo = "999";
                    objEnv.CodigoElemento = "11111";
                    objEnv.CodigoTabla = "0000";
                    objEnv.ValorCodigo1 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEnv.ValorEntero1 = ENTITY_GLOBAL.Instance.PacienteID;
                    objEnv.ACCION = "PO_EXAMENPERIODO";
                    var Result = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);

                    /*******INVOCA REGLA*****************************/
                    MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                    objRegla.CodigoTabla = regla;
                    if (Result.Count > 0)
                    {
                        //objRegla.IdPaciente = (int)Result[0].ValorEntero1;
                        objRegla.TipoOrdenAtencion = (int)Result[0].ValorEntero2;
                        objRegla.CodigoComponente = Result[0].ValorCodigo3;
                        objRegla.FechaUltimoExamen = (Result[0].ValorFecha != null ? ((DateTime)(Result[0].ValorFecha)) : DateTime.Now);
                        objRegla.Annos = (DateTime.Now.Year - objRegla.FechaUltimoExamen.Year);
                    }
                    objRegla = ServiciosRules.POSaludExamenLaboratorio(objRegla);

                    /*************************************************************/
                    ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                    mostMensaje.DESCRIPCION = "El Paciente no registra exámenes de Laboratorio.";
                    if (objRegla != null)
                        mostMensaje.ESTADOBOOL = objRegla.resultBool;
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    msgNoValido.Add(mostMensaje);
                    //return this.Store(listaResources);
                    return showMensajeBotton(msgNoValido, "", "");
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - POSaludExamenLaboratorio - Bloque Catch");
                    Log.Error(ex, ex.Message);
                }
                return this.Direct();
            }
            else
            {
                return this.Direct();
            }
        }


        /******FORMULARIOS ADD****/


        /**PRUEBA*/
        public System.Web.Mvc.ActionResult CCEX0001_View()
        {
            Log.Information("ProgramarKardexController - CCEX0001_View - Entrar");
            try
            {
                /////
                var LocalEnty = new SS_HC_Anamnesis_EA();
                var Listar = new List<SS_HC_Anamnesis_EA>();
                LocalEnty.Accion = "LISTAR";

                /*****OBS: Prueba CARGA RESOURSEC VALIDACION*******/
                Session["MENSAJES_VALFORM"] = null;
                cargarPropiedadesFormulario(true);
                setPropiedadesFormulario(true);
                /***************************************************/
                //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
                return View("FormulariosHCE/CCEX0001_View", LocalEnty);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - CCEX0001_View - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Ocurrió una excepción en la ejecución.";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }




        /****FORMU: EVOLUCIÓN OBJETIVA***/
        public System.Web.Mvc.ActionResult CCEP2010_View()
        {
            Log.Information("ProgramarKardexController - CCEP2010_View - Entrar");

            try
            {
                SS_HC_EvolucionObjetiva LocalObj = null;
                var LocalEnty = new SS_HC_EvolucionObjetiva();
                var Listar = new List<SS_HC_EvolucionObjetiva>();
                LocalEnty.Accion = "LISTAR";
                if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado == 1)
                {
                    LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                }
                //Listar = SvcEvolucionObjetivaService.getPorId_SS_HC_EvolucionObjetiva(LocalEnty);
                bool hallado = false;
                LocalObj = SvcEvolucionObjetivaService.getPorId_SS_HC_EvolucionObjetiva(LocalEnty);
                if (LocalObj != null)
                {
                    LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    LocalEnty.IdEpisodioAtencion = 0;
                    LocalEnty.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                    /* var fecha = Convert.ToString(LocalObj.FechaIngreso);
                     LocalObj.FechaIngreso = DateTime.Parse(fecha);*/

                    /*
                    Listar = SvcEvolucionObjetivaService.listarSS_HC_EvolucionObjetiva(LocalEnty);
                    String HISTORICO_EVOL = "";
                    if (Listar.Count > 0)
                    {
                        int contador = 0;

                        foreach (SS_HC_EvolucionObjetiva objEntity in Listar)
                        {
                            if (objEntity.EvolucionObjetiva != null && LocalObj.IdEpisodioAtencion != objEntity.IdEpisodioAtencion)
                            {
                                contador++;
                                HISTORICO_EVOL = HISTORICO_EVOL + contador + ".-" + objEntity.EvolucionObjetiva
                                    + "(Dic.Riesgo:" + objEntity.DictamenRiesgo + ")" + "\n"
                                    ;
                            }
                        }
                    }*/
                    LocalEnty = LocalObj;
                    LocalEnty.Version = ""; //AUX PARA MOSTRAR PREVIOS
                    LocalEnty.Accion = "UPDATE";
                    hallado = true;
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
                    {
                        LocalEnty.Accion = "VISTA";
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    }
                }

                /*
                if (Listar.Count > 0)
                {
                    foreach (SS_HC_EvolucionObjetiva objEntity in Listar)
                    {
                        LocalEnty = objEntity;
                        LocalEnty.Accion = "UPDATE";
                        hallado = true;
                        if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
                        {
                            LocalEnty.Accion = "VISTA";
                        }
                        else
                        {
                            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                        }
                    }
                }*/
                if (!hallado)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
                    {
                        LocalEnty.Accion = "VISTA";
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                        LocalEnty.Accion = "NUEVO";
                    }
                }

                /////////////////////////////////////////////////
                ///ADD LA OPCIÓN DE COPIA
                if (Session["COPIA_FORMULARIO"] == "ACTIVA" && Session["DATA_COPIA_FORM"] != null)
                {
                    Object objetoGen = getObjetoMiscelaneoFormulario_de_Historial((string)Session["DATA_COPIA_FORM"], "PEGAR",
                    UTILES_MENSAJES.FORM_EVOL_OBJETIVA_F1, LocalEnty.EvolucionObjetiva);
                    if (objetoGen != null)
                    {
                        String objCopy = (String)objetoGen;
                        LocalEnty.EvolucionObjetiva = "" + objCopy;
                    }
                    Session["COPIA_FORMULARIO"] = "INACTIVA";
                }


                //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
                /*****OBS: Prueba CARGA RESOURSEC VALIDACION*******/
                Session["MENSAJES_VALFORM"] = null;
                cargarPropiedadesFormulario(true);
                setPropiedadesFormulario(true);
                /***************************************************/

                /**ADD para config del PATH del form*/
                setConfigPath(UTILES_MENSAJES.PATH_MAIN_HCLINICA + "FormulariosHCE/", "");
                return View("FormulariosHCE/CCEP2010_View", LocalEnty);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - CCEP2010_View - Bloque Catch");
                Log.Error(ex, ex.Message);
                return showMsgTratamientoExcepcion(ex, "");
                throw;
            }
        }

        public System.Web.Mvc.ActionResult Save_EvolucionObjetiva(SS_HC_EvolucionObjetiva objSave, String HoraIngreso)
        {
            Log.Information("ProgramarKardexController - Save_EvolucionObjetiva - Entrar");
            /*  var fechavalida = false;
              try { 



                 var fecha= DateTime.Parse(objSave.FechaIngreso.ToString());

                 if (fecha.Year < 1900) { 
                     fechavalida = false; }
                 else { 
                     fechavalida = true; }
                  //fechavalida = true;
              }
              catch
              {
                  fechavalida = false;
              }

              if (fechavalida == false) { return null; }
              */


            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();
            }
            else
            {
                try
                {
                    int registro = -1;
                    if (objSave != null)
                    {
                        if (objSave.FechaIngreso == null)
                        {
                            eventoPostFormulario(true, "");

                            return showMensajeNotifyData("Mensaje", "Por favor seleccione una fecha de ingreso...", "ERROR", false);


                        }

                        if (objSave.EvolucionObjetiva == null)
                        {


                            eventoPostFormulario(true, "");

                            return showMensajeNotifyData("Mensaje", "Por favor ingrese una Evolucion...", "ERROR", false);


                        }
                        objSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        objSave.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        objSave.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        objSave.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        objSave.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                        objSave.Version = ENTITY_GLOBAL.Instance.CONCEPTO.Trim();
                        objSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        objSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        objSave.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;

                        /*char[] MyChar = {'\ '};*/
                        var hora = HoraIngreso.TrimStart('\"');
                        hora = hora.TrimEnd('\"');
                        var tiempo = DateTime.Parse(hora);

                        var fechaingreso = Convert.ToDateTime(objSave.FechaIngreso);
                        fechaingreso = fechaingreso.AddHours(tiempo.Hour);
                        fechaingreso = fechaingreso.AddMinutes(tiempo.Minute);

                        objSave.FechaIngreso = fechaingreso;

                        if (objSave.Accion == "NUEVO")
                        {
                            objSave.FechaCreacion = DateTime.Now;
                        }
                        objSave.FechaModificacion = DateTime.Now;
                        string mensage = "";
                        registro = SvcEvolucionObjetivaService.setMantenimiento(objSave);
                        if (registro > 0)
                        {
                            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                            else mensage = " actualizó ";
                            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                            ENTITY_GLOBAL.Instance.FORMULARIOREGISTRO_ID = registro;
                            String mensaje = "Se " + mensage + " el Formulario satisfactoriamente. Código Transacción: " +
                                UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                                ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                                ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.PacienteID, "");

                            //ActivaDescativaButtonSave(true);
                            eventoPostFormulario(true, "");
                            //return showMensajeBox(mensaje, "Ventana de Mensajes ", "INFO");
                            return showMensajeNotify("Mensaje", mensaje, "INFO");
                        }
                        else
                        {
                            eventoPostFormulario(false, "");
                            return showMensajeNotifyData("Error", "Sucedió un error inesperado", "ERROR", false);

                        }
                    }
                    else
                    {
                        eventoPostFormulario(false, "");
                        return showMensajeNotifyData("Error", "No se pudo obtener el registro actual", "ERROR", false);
                    }
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - Save_EvolucionObjetiva - Bloque Catch");
                    Log.Error(ex, ex.Message);
                    return showMsgTratamientoExcepcion(ex, "");
                    throw;
                }
            }


            // int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            return this.Direct();
        }
        /****FORMU: ANTECEDENTES FAMILIARES, MODIFICADA***/
        public System.Web.Mvc.ActionResult CCEP0055_View()
        {
            Log.Information("ProgramarKardexController - CCEP0055_View - Entrar");
            try
            {
                Session["DataSS_Antic_FamiliaresDelete"] = null;
                Session["DATASS_HC_Anamnesis_AF_sec"] = null;
                Session["DataSS_Antec_FamiliaresMainDelete"] = null;
                Session["DataSS_Antec_FamiliaresMain"] = null;
                var LocalEnty = new SS_HC_Anamnesis_AFAM();
                var Listar = new List<SS_HC_Anamnesis_AFAM>();
                LocalEnty.Accion = "LISTAR";
                if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
                {
                    /*
                    LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.VistaEpisodioClinico;
                    LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.VistaEpisodioAtencion;
                    LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    */
                    LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                }
                else if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado == 1)
                {
                    LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                }
                Listar = SvcAnamnesisAFService.AnamnesisAFListar(LocalEnty).ToList();
                ////////////
                bool hallado = false;
                if (Listar.Count > 0)
                {
                    LocalEnty.Accion = "UPDATE";
                    /*
                    foreach (SS_HC_Anamnesis_AFAM objEntity in Listar)
                    {
                        LocalEnty = objEntity;
                        LocalEnty.Accion = "UPDATE";

                        hallado = true;
                        if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
                        {
                            LocalEnty.Accion = "VISTA";
                        }
                        else
                        {
                            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                        }
                    }*/
                }
                if (!hallado)
                {
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
                    {
                        LocalEnty.Accion = "VISTA";
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                        LocalEnty.Accion = "NUEVO";
                    }
                }
                //////////
                /*****OBS: Prueba CARGA RESOURSEC VALIDACION*******/
                Session["MENSAJES_VALFORM"] = null;
                cargarPropiedadesFormulario(true);
                setPropiedadesFormulario(true);
                /***************************************************/

                /**ADD para config del PATH del form*/
                setConfigPath(UTILES_MENSAJES.PATH_MAIN_HCLINICA + "FormulariosHCE/", "");
                return View("FormulariosHCE/CCEP0055_View", LocalEnty);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - CCEP0055_View - Bloque Catch");
                Log.Error(ex, ex.Message);
                return showMsgTratamientoExcepcion(ex, "");
                //throw;
            }

        }


        public System.Web.Mvc.ActionResult CCEP0055_ANTEC_FAMILIARES_MAIN()
        {
            Log.Information("ProgramarKardexController - CCEP0055_ANTEC_FAMILIARES_MAIN - Entrar");
            var LocalEnty = new SS_HC_Anamnesis_AFAM();
            var Listar = new List<SS_HC_Anamnesis_AFAM>();
            LocalEnty.Accion = "LISTAR";
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
            {
                /*
                LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.VistaEpisodioClinico;
                LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.VistaEpisodioAtencion;
                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                 */
                LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            }
            else if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado == 1)
            {
                LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            }
            Listar = SvcAnamnesisAFService.AnamnesisAFListar(LocalEnty).ToList();
            ////////////
            if (Listar.Count > 0)
            {
                foreach (SS_HC_Anamnesis_AFAM objEntity in Listar)
                {
                    objEntity.Accion = "UPDATE";
                    if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
                    {
                        objEntity.Accion = "VISTA";
                    }
                }
            }
            return this.Store(Listar.ToList());
        }
        public System.Web.Mvc.ActionResult CCEP0055_ANTEC_FAMILIARES(String secuenciaFamilia)
        {
            Log.Information("ProgramarKardexController - CCEP0055_ANTEC_FAMILIARES - Entrar");

            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();
            List<MA_MiscelaneosDetalle> ListarShow = new List<MA_MiscelaneosDetalle>();
            LocalEnty.ACCION = "ANTEC_FAMILIARES_ALT";
            if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "VISTA")
            {
                /*
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.VistaEpisodioClinico.ToString().Trim();
                LocalEnty.ValorCodigo3 = ENTITY_GLOBAL.Instance.VistaEpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo4 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                 */
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioClinico.ToString().Trim();
                LocalEnty.ValorCodigo3 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo4 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            }
            else if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado == 1)
            {
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioClinico.ToString().Trim();
                LocalEnty.ValorCodigo3 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo4 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            }
            //
            LocalEnty.ValorNumerico = Convert.ToDouble(getValorFiltroInt(secuenciaFamilia != null ? secuenciaFamilia : "0"));
            List<MA_MiscelaneosDetalle> ObjListar = new List<MA_MiscelaneosDetalle>();
            if (Session["DATASS_HC_Anamnesis_AF_sec"] != null)
            {
                ObjListar = (List<MA_MiscelaneosDetalle>)Session["DATASS_HC_Anamnesis_AF_sec"];
                if (ObjListar.Count > 0)
                {
                    foreach (var result in ObjListar)
                    {
                        if (("" + result.ValorEntero5) == secuenciaFamilia)
                        {
                            ListarShow.Add(result);
                        }
                    }
                }

            }
            if (ListarShow.Count == 0)
            {
                Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();
                if (Listar.Count > 0)
                {
                    ObjListar.AddRange(Listar);
                    Session["DATASS_HC_Anamnesis_AF_sec"] = ObjListar;
                }
            }
            else
            {
                Listar.AddRange(ListarShow);
            }
            //return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());

            return this.Store(Listar.ToList());
        }
        /***/
        public System.Web.Mvc.ActionResult Save_Antic_FamiliaresAlt(SS_HC_Anamnesis_AFAM objAnamEA, String selection, String selectionMain, string text)
        {
            Log.Information("ProgramarKardexController - Save_Antic_FamiliaresAlt - Entrar");

            String mensaje = "";
            SS_HC_Anamnesis_AFAM_Enfermedad objEnt;
            string mensage = "";
            long secActual = -1;
            long IdEpisodioAtencionID = -1;
            string cadenas = "";
            String[] cadArray;
            List<MA_MiscelaneosDetalle> ObjListar = null;
            List<SS_HC_Anamnesis_AFAM> ObjListarMain = null;
            // TRANSACCIONALES
            List<SS_HC_Anamnesis_AFAM> ObjCabecera = new List<SS_HC_Anamnesis_AFAM>();
            List<SS_HC_Anamnesis_AFAM_Enfermedad> ObjDetalle = new List<SS_HC_Anamnesis_AFAM_Enfermedad>();


            if (ENTITY_GLOBAL.Instance.EpisodioClinicoEstado != 1)
            {
                X.Msg.Alert("Ventana de Mensajes ", "Por favor seleccione episodio clínico... ").Show();
            }
            else
            {
                if (text == "O")
                {
                    addDataUpdate_Antic_FamiliaresAlt("UPDATEDETALLE", selection, 1);
                    /*
                    Session["DATASS_HC_Anamnesis_AF_sec"] = null;
                    if (selection != "[]")
                    {
                        ObjListar = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<MA_MiscelaneosDetalle>));
                        Session["DATASS_HC_Anamnesis_AF_sec"] = ObjListar; //Detalle
                    }*/

                    Session["DataSS_Antec_FamiliaresMain"] = null;
                    if (selectionMain != "[]")
                    {
                        ObjListarMain = (List<SS_HC_Anamnesis_AFAM>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionMain, typeof(List<SS_HC_Anamnesis_AFAM>));
                        Session["DataSS_Antec_FamiliaresMain"] = ObjListarMain; //Detalle
                    }
                    ////////////
                }
                else
                {
                    try
                    {
                        ///////////INICIO
                        addDataUpdate_Antic_FamiliaresAlt("UPDATEDETALLE", selection, 1);
                        /*
                        Session["DATASS_HC_Anamnesis_AF_sec"] = null;
                        if (selection != "[]")
                        {
                            ObjListar = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<MA_MiscelaneosDetalle>));
                            Session["DATASS_HC_Anamnesis_AF_sec"] = ObjListar; //Detalle
                        }*/

                        Session["DataSS_Antec_FamiliaresMain"] = null;
                        if (selectionMain != "[]")
                        {
                            ObjListarMain = (List<SS_HC_Anamnesis_AFAM>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionMain, typeof(List<SS_HC_Anamnesis_AFAM>));
                            Session["DataSS_Antec_FamiliaresMain"] = ObjListarMain; //Detalle
                        }

                        ////////////
                        objAnamEA = new SS_HC_Anamnesis_AFAM();
                        //BLOQUE MAIN
                        if (Session["DataSS_Antec_FamiliaresMain"] != null || Session["DataSS_Antec_FamiliaresMainDelete"] != null)
                        {
                            if (Session["DataSS_Antec_FamiliaresMain"] != null)
                            {
                                ObjListarMain = (List<SS_HC_Anamnesis_AFAM>)Session["DataSS_Antec_FamiliaresMain"];
                                foreach (SS_HC_Anamnesis_AFAM objMain in ObjListarMain)
                                {
                                    //int secAux = 0;
                                    if (objMain.Accion == "NUEVO")
                                    {
                                        objMain.FechaCreacion = DateTime.Now;
                                        objMain.Estado = 2;
                                    }
                                    //objMain.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                                    objMain.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    objMain.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    objMain.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    objMain.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    objMain.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objMain.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objMain.FechaModificacion = DateTime.Now;
                                    ObjCabecera.Add(objMain);
                                }
                            }


                            //objAnamEA.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                            objAnamEA.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                            objAnamEA.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            objAnamEA.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                            objAnamEA.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                            //BLOQUE MAIN - DELETE
                            List<SS_HC_Anamnesis_AFAM> dataDeleteMain = null;
                            if (Session["DataSS_Antec_FamiliaresMainDelete"] != null)
                            {
                                dataDeleteMain = (List<SS_HC_Anamnesis_AFAM>)Session["DataSS_Antec_FamiliaresMainDelete"];
                            }
                            // BORRAR  - MAIN
                            if (dataDeleteMain != null)
                            {
                                foreach (var objDel in dataDeleteMain)
                                {
                                    // SvcAnamnesisAFService.setMantAnamnesisAF(objDel);
                                    ObjCabecera.Add(objDel);
                                }
                            }

                            /*
                            objAnamEA.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                            objAnamEA.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                            objAnamEA.FechaModificacion = DateTime.Now;
                            long secAux = 0;
                            if (objAnamEA.Accion == "NUEVO")
                            {
                                objAnamEA.FechaCreacion = DateTime.Now;
                                objAnamEA.Estado = 2;
                            }
                            ObjCabecera.Add(objAnamEA);
                             */
                            //IdEpisodioAtencionID = SvcAnamnesisAFService.setMantAnamnesisAF(objAnamEA);

                            /**********************************************************************/
                            //BLOQUE DELETE
                            List<SS_HC_Anamnesis_AFAM_Enfermedad> dataDelete = null;
                            if (Session["DataSS_Antic_FamiliaresDelete"] != null)
                            {
                                dataDelete = (List<SS_HC_Anamnesis_AFAM_Enfermedad>)Session["DataSS_Antic_FamiliaresDelete"];
                            }

                            //BLOQUE DETALLE
                            if (Session["DATASS_HC_Anamnesis_AF_sec"] != null)
                            {
                                ObjListar = (List<MA_MiscelaneosDetalle>)Session["DATASS_HC_Anamnesis_AF_sec"];
                                if (ObjListar.Count > 0)
                                {
                                    if (ObjListar[0].ValorCodigo2.Trim().Length > 0)
                                    {
                                        foreach (MA_MiscelaneosDetalle objEntity in ObjListar)
                                        {
                                            objEnt = new SS_HC_Anamnesis_AFAM_Enfermedad();
                                            objEnt.Accion = objEntity.ACCION;// "DETALLE";
                                            objEnt.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                            objEnt.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                            objEnt.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                            objEnt.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                            cadArray = objEntity.ValorCodigo2.Trim().Split('|');
                                            cadenas = cadArray[1].Replace("[", "");
                                            cadenas = cadenas.Replace("]", "").Trim();
                                            objEnt.IdDiagnostico = Convert.ToInt32(cadenas);
                                            objEnt.Observaciones = objEntity.ValorCodigo3.Trim();
                                            objEnt.SecuenciaFamilia = Convert.ToInt32(objEntity.ValorEntero5);
                                            if ((objEntity.ACCION.Trim() + "") == "NUEVO")
                                            {
                                                objEnt.Accion = "DETALLE";
                                            }
                                            if ((objEntity.ACCION.Trim() + "") != "DETALLE")
                                            {
                                                objEnt.Secuencia = Convert.ToInt32(objEntity.CodigoElemento);
                                            }
                                            ObjDetalle.Add(objEnt);
                                            //IdEpisodioAtencionID = SvcAnamnesisAFService.setMantAnamnesisAF(objEnt);

                                        }
                                    }
                                }
                            }
                            // BORRAR DETALLE
                            if (dataDelete != null)
                            {
                                foreach (var objDel in dataDelete)
                                {
                                    // SvcAnamnesisAFService.setMantAnamnesisAF(objDel);
                                    ObjDetalle.Add(objDel);
                                }
                            }
                            ///////////
                            IdEpisodioAtencionID = SvcAnamnesisAFService.setMantAnamnesisAF(objAnamEA, ObjCabecera, ObjDetalle);
                            if (IdEpisodioAtencionID > 0)
                            {
                                if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                                else mensage = " actualizó ";
                                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                                ENTITY_GLOBAL.Instance.FORMULARIOREGISTRO_ID = (int)IdEpisodioAtencionID;
                                mensaje = "Se " + mensage + " el Formulario satisfactoriamente. Código Transacción: " +
                                    UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                                    ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.PacienteID, "");

                                Session["DataSS_Antec_FamiliaresMain"] = null;
                                Session["DataSS_Antec_FamiliaresMainDelete"] = null;
                                Session["DataSS_Antic_FamiliaresDelete"] = null;
                                Session["DATASS_HC_Anamnesis_AF_sec"] = null;

                                //eventoLoadPostFormulario(true, "storeEnfermedad", null);
                                eventoPostFormulario(true, "");
                                return showMensajeNotify("Mensaje", mensaje, "INFO");
                            }
                            else
                            {
                                eventoPostFormulario(false, "");
                                return showMensajeNotifyData("Error", "Sucedió un error inesperado", "ERROR", false);
                            }
                        }
                        else
                        {
                            eventoPostFormulario(false, "");
                            return showMensajeNotifyData("Alerta ", "No se detectaron cambios para guardar", "WARNING", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        return showMsgTratamientoExcepcion(ex, "");
                    }
                }
            }
            // int reg= svc
            //objAnamnesis_AP.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;            
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult addEliminar_Antic_FamiliaresMainAlt(String MODO, String secuenciaFamilia)
        {
            Log.Information("ProgramarKardexController - addEliminar_Antic_FamiliaresMainAlt - Entrar");

            List<SS_HC_Anamnesis_AFAM> dataDelete = null;
            if ((secuenciaFamilia + "").Length > 0)
            {
                if (Session["DataSS_Antec_FamiliaresMainDelete"] != null)
                {
                    dataDelete = (List<SS_HC_Anamnesis_AFAM>)Session["DataSS_Antec_FamiliaresMainDelete"];
                }
                if (dataDelete == null)
                {
                    dataDelete = new List<SS_HC_Anamnesis_AFAM>();
                }
                SS_HC_Anamnesis_AFAM objDelete = new SS_HC_Anamnesis_AFAM();
                objDelete.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objDelete.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                objDelete.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                objDelete.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                try
                {
                    string cadenas = secuenciaFamilia;
                    objDelete.SecuenciaFamilia = Convert.ToInt32(cadenas);
                    objDelete.Accion = "DELETE";
                    dataDelete.Add(objDelete);
                    Session["DataSS_Antec_FamiliaresMainDelete"] = dataDelete;
                    //UPDATE DETALLE ENERMEDAD                    
                    List<MA_MiscelaneosDetalle> objLista = null;
                    objLista = (List<MA_MiscelaneosDetalle>)Session["DATASS_HC_Anamnesis_AF_sec"];
                    if (objLista != null)
                    {
                        foreach (var result in objLista)
                        {
                            if (result.ACCION != "DELETEDETALLE")
                            {
                                if (("" + result.ValorEntero5) == ("" + objDelete.SecuenciaFamilia))
                                {
                                    if (result.ACCION != "DETALLE" && result.ACCION != "NUEVO")
                                    {
                                        result.ACCION = "DELETEDETALLE";
                                    }
                                }
                            }
                        }
                        if (objLista.Count > 0)
                        {
                            Session["DATASS_HC_Anamnesis_AF_sec"] = objLista;
                        }
                    }

                }
                catch (Exception ex)
                {
                    Log.Error(ex, ex.Message);
                    /**SE puede agregar alerta si se llama a un metodo adecuado:*/
                    //e.GetType;
                }
            }
            return this.Direct();
        }

        /**METODO PARA GUARDAR EN MEMORIA CAMBIOS Y ACTUALIZACIONES*/
        public bool addDataUpdate_Antic_FamiliaresAlt(string MODO, String data, int tipo)
        {
            Log.Information("ProgramarKardexController - addDataUpdate_Antic_FamiliaresAlt - Entrar");

            if (data != null)
            {
                List<MA_MiscelaneosDetalle> objLista = null;
                List<MA_MiscelaneosDetalle> ObjListarUpdateNew = new List<MA_MiscelaneosDetalle>();
                List<MA_MiscelaneosDetalle> ObjListarUpdate = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<MA_MiscelaneosDetalle>));
                objLista = (List<MA_MiscelaneosDetalle>)Session["DATASS_HC_Anamnesis_AF_sec"];
                if (tipo == 1)//UPDATE
                {
                    if (objLista == null)
                    {
                        objLista = ObjListarUpdate;
                    }
                    else if (objLista != null && ObjListarUpdate != null)
                    {
                        foreach (var result in objLista)
                        {
                            bool hallado = false;
                            if (result.ACCION != "DELETEDETALLE")
                            {
                                foreach (var resultUpd in ObjListarUpdate)
                                {
                                    if (result.ValorEntero5 == resultUpd.ValorEntero5
                                        && result.CodigoElemento == resultUpd.CodigoElemento)//AUX SEC FAMILIA)//AUX SEC FAMILIA
                                    {
                                        result.CodigoElemento = resultUpd.CodigoElemento;
                                        result.ValorCodigo2 = resultUpd.ValorCodigo2;
                                        result.ValorCodigo3 = resultUpd.ValorCodigo3;
                                        result.ValorEntero5 = resultUpd.ValorEntero5;
                                        if (result.ACCION != "DETALLE" && result.ACCION != "NUEVO")
                                        {
                                            result.ACCION = MODO;
                                        }
                                        hallado = true;
                                        break;
                                    }
                                }
                                ///

                            }
                        }
                    }
                }
                else if (tipo == 2)//UPDATE
                {
                    if (objLista == null)
                    {
                        objLista = new List<MA_MiscelaneosDetalle>();
                    }
                    if (ObjListarUpdate.Count > 0)
                    {
                        objLista.AddRange(ObjListarUpdate);
                    }
                }
                //TERMINAR
                if (ObjListarUpdate.Count > 0)
                {
                    Session["DATASS_HC_Anamnesis_AF_sec"] = objLista;
                }
                //objUpd.GetAll();
            }
            return true;
        }
        public System.Web.Mvc.ActionResult addEliminar_Antic_FamiliaresAlt(String MODO, String codigo,
            String secuencia, String secuenciaFam, int tipo)
        {
            Log.Information("ProgramarKardexController - addEliminar_Antic_FamiliaresAlt - Entrar");

            List<SS_HC_Anamnesis_AFAM_Enfermedad> dataDelete = null;
            if ((codigo + "").Length > 0)
            {
                Nullable<int> SecFamilia = getValorFiltroInt(secuenciaFam);
                List<MA_MiscelaneosDetalle> objLista = null;
                if (tipo == 1)
                {
                    objLista = (List<MA_MiscelaneosDetalle>)Session["DATASS_HC_Anamnesis_AF_sec"];
                }
                if (objLista != null)
                {
                    foreach (var result in objLista)
                    {
                        if (result.ACCION != "DELETEDETALLE")
                        {
                            if (result.ValorEntero5 == SecFamilia
                                && result.CodigoElemento == secuencia)//AUX SEC FAMILIA
                            {
                                try
                                {
                                    if (result.ACCION != "DETALLE" && result.ACCION != "NUEVO")
                                    {
                                        result.ACCION = MODO;
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Log.Error(ex, ex.Message);
                                }
                                break;
                            }
                        }
                    }
                    if (objLista.Count > 0)
                    {
                        Session["DATASS_HC_Anamnesis_AF_sec"] = objLista;
                    }
                }
            }
            return this.Direct();
        }
        /**erportes partialview**/
        public System.Web.Mvc.ActionResult HCEReportesPartialView(String Accion)
        {
            Log.Information("ProgramarKardexController - HCEReportesPartialView - Entrar");
            ENTITY_GENERALHCE objReporte = new ENTITY_GENERALHCE
            {
                IDENTIY_GEN = 1,
                UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion,
                EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico,
                EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion,
                PacienteID = ENTITY_GLOBAL.Instance.PacienteID,
                //AUX
                campoStr01 = "localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I",
                campoStr02 = "CCEPF101"
            };

            if ("CCEPF101" != null)
            {
                string host = System.Web.HttpContext.Current.Request.Url.Host;
                string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
                //string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
                string path = System.Web.HttpContext.Current.Request.ApplicationPath;
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                String UrlPathReporte = hostPort + path;
                objReporte.campoStr01 = UrlPathReporte;
                objReporte.campoStr03 = "SINGLE";
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                //model.UsuarioModificacion = hostPort + path;                                 

            }
            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 2;


            /************************************************/
            //////////      
            /* return new Ext.Net.MVC.PartialViewResult
             {
                 ViewName = "HCReportes/HCEReportesPartialView",
                 Model = objReporte
             };
             */
            //cerrarWindow("WindowVisorCronologiasForm");
            return crearWindowRegistro("HCReportesReceta/HCEReportesPartialView", objReporte, "");


        }
        /**PARA REPORTES BITACORA**/
        public System.Web.Mvc.ActionResult HCEReportesBitacoraView(String containerId)
        {
            Log.Information("ProgramarKardexController - HCEReportesBitacoraView - Entrar");

            ENTITY_GENERALHCE objReporte = new ENTITY_GENERALHCE
            {
                IDENTIY_GEN = 1,
                UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion,
                EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico,
                EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion,
                PacienteID = ENTITY_GLOBAL.Instance.PacienteID,
                //AUX
                //campoStr01 = "localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I",
                campoStr02 = ENTITY_GLOBAL.Instance.CONCEPTO



            };





            if (ENTITY_GLOBAL.Instance.CONCEPTO != null)
            {
                string host = System.Web.HttpContext.Current.Request.Url.Host;
                string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
                //string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
                string path = System.Web.HttpContext.Current.Request.ApplicationPath;
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                String UrlPathReporte = hostPort + path;
                objReporte.campoStr01 = UrlPathReporte;
                objReporte.campoStr03 = "SINGLE";
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                //model.UsuarioModificacion = hostPort + path;                                 

            }



            /************************************************/
            //////////       
            return View("HCReportes/HCEReportesBitacoraView", "", objReporte);
            //return crearWindowRegistro("HCReportes/HCEReportesBitacoraView", objReporte, "", "Center1");

            /* return new PartialViewResult
             {
                 ViewName = "HCReportes/HCEReportesBitacoraView",
                 ContainerId = "Center1",
                 Model = objReporte,
                 //SingleControl = true,
                 ClearContainer = true,
                 WrapByScriptTag = true,
                 RenderMode = RenderMode.AddTo
             };*/





        }

        /**PARA REPORTES VIEW**/
        public System.Web.Mvc.ActionResult HCEReportesView()
        {
            Log.Information("ProgramarKardexController - HCEReportesView - Entrar");

            ENTITY_GENERALHCE objReporte = new ENTITY_GENERALHCE
            {
                IDENTIY_GEN = 1,
                UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion,
                EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico,
                EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion,
                PacienteID = ENTITY_GLOBAL.Instance.PacienteID,
                //AUX
                //campoStr01 = "localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I",
                campoStr02 = ENTITY_GLOBAL.Instance.CONCEPTO



            };





            if (ENTITY_GLOBAL.Instance.CONCEPTO != null)
            {
                string host = System.Web.HttpContext.Current.Request.Url.Host;
                string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
                //string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
                string path = System.Web.HttpContext.Current.Request.ApplicationPath;
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                String UrlPathReporte = hostPort + path;
                objReporte.campoStr01 = UrlPathReporte;
                objReporte.campoStr03 = "SINGLE";
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                //model.UsuarioModificacion = hostPort + path;                                 

            }



            /************************************************/
            //////////       
            /*return View("HCReportes/HCEReportesView", objReporte);*/
            return View("HCReportesReceta/HCEReportesViewR", objReporte);

        }
        /**PARA REPORTES VIEW TOTAL HC**/



        public System.Web.Mvc.ActionResult HCEReportesViewReceta()
        {
            Log.Information("ProgramarKardexController - HCEReportesViewReceta - Entrar");

            ENTITY_GENERALHCE objReporte = new ENTITY_GENERALHCE
            {
                IDENTIY_GEN = 1,
                UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion,
                EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico,
                EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion,
                PacienteID = ENTITY_GLOBAL.Instance.PacienteID,
                //AUX
                //campoStr01 = "localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I",
                campoStr02 = "CCEPF101"



            };





            if ("CCEPF101" != null)
            {
                string host = System.Web.HttpContext.Current.Request.Url.Host;
                string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
                //string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
                string path = System.Web.HttpContext.Current.Request.ApplicationPath;
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                String UrlPathReporte = hostPort + path;
                objReporte.campoStr01 = UrlPathReporte;
                objReporte.campoStr03 = "SINGLE";
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                //model.UsuarioModificacion = hostPort + path;                                 

            }



            /************************************************/
            //////////       
            /*return View("HCReportes/HCEReportesView", objReporte);*/
            return crearWindowRegistro("HCReportesReceta/HCEReportesPartialView", objReporte, "");


        }

        public System.Web.Mvc.ActionResult HCEReportesView_total()
        {
            Log.Information("ProgramarKardexController - HCEReportesView_total - Entrar");

            ENTITY_GENERALHCE objReporte = new ENTITY_GENERALHCE
            {
                IDENTIY_GEN = 1,
                UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion,
                EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico,
                EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion,
                PacienteID = ENTITY_GLOBAL.Instance.PacienteID,
                //AUX
                //campoStr01 = "localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I",
                campoStr02 = ENTITY_GLOBAL.Instance.CONCEPTO
            };
            if (ENTITY_GLOBAL.Instance.CONCEPTO != null)
            {
                string host = System.Web.HttpContext.Current.Request.Url.Host;
                string hostPort = System.Web.HttpContext.Current.Request.Url.Authority;
                //string hostPort = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
                string path = System.Web.HttpContext.Current.Request.ApplicationPath;
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                String UrlPathReporte = hostPort + path;
                objReporte.campoStr01 = UrlPathReporte;
                objReporte.campoStr03 = "TOTALHC";
                /**MANDAR EN UN CAMPO SI ES NECESARIO*/
                //model.UsuarioModificacion = hostPort + path;                                 

            }
            /************************************************/
            //////////  
            return View("HCReportesReceta/HCEReportesViewR", objReporte);
            /*return View("HCReportes/HCEReportesView", objReporte);*/
        }

        /**Prepara los Códigos Formatos VIEW para recueparar la vista anterior*/
        public Boolean setCodigoFormatosPaginas(String indicadorEtapa, String opcionView)
        {
            Log.Information("ProgramarKardexController - setCodigoFormatosPaginas - Entrar");

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
        public System.Web.Mvc.ActionResult initLoadFormatos(String container)
        {
            Log.Information("ProgramarKardexController - initLoadFormatos - Entrar");

            string containerId = "";
            string text = "0";
            if (ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL != null)
            {
                containerId = container;
                text = ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL;
                return LoadFormatos(containerId, text);
            }
            else
            {
                return this.Direct();
            }
        }

        /****ADD PERMISOS AL FORMATO **/
        public System.Web.Mvc.ActionResult addPermisosFormatos(String data, String indica)
        {
            Log.Information("ProgramarKardexController - addPermisosFormatos - Entrar");

            /*******SET PROP. FORMULARIO*****************************/
            List<ENTITY_GENERALHCE> listaRecursosPermisos = new List<ENTITY_GENERALHCE>();
            if (Session["RECURSOS_PERMISOSFORMATOS"] == null) cargarPermisosFormato(true);
            if (Session["RECURSOS_PERMISOSFORMATOS"] != null)
            {
                listaRecursosPermisos = (List<ENTITY_GENERALHCE>)Session["RECURSOS_PERMISOSFORMATOS"];
            }
            /*************************************************************/
            return this.Store(listaRecursosPermisos);
            //return this.Direct();
        }

        /**CARGA LAS PROPEDADES DE PERMISOS DEL FORMATO ***********/
        public bool cargarPermisosFormato(bool activo)
        {
            Log.Information("ProgramarKardexController - cargarPermisosFormato - Entrar");

            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = 0;
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
            }
            return true;
        }
        /***************************************************************************/
        /***************************************************************************/
        /*********************SEGUNDA ETAPA****************************/

        /**COPIAR FORMULARIOS : (FASE II)*/
        public System.Web.Mvc.ActionResult visorHCECopiarFormularios(string Accion, string nombrePaciente,
            string Form, string FormContainer)
        {
            Log.Information("ProgramarKardexController - visorHCECopiarFormularios - Entrar");

            Session["COPIA_FORMULARIO"] = "INACTIVA";
            Session["DATA_COPIA_FORM"] = null;
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new V_EpisodioAtenciones();
            //ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto;
            model.NombreCompleto = ENTITY_GLOBAL.Instance.NombreCompletoPaciente;
            model.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;

            model.Accion = Accion;
            model.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            model.UsuarioModificacion = ENTITY_GLOBAL.Instance.CONCEPTO;

            model.UsuarioModificacion = "" + ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL;

            //ENTITY_GLOBAL.Instance.EpisodioAtencion = Atencion;
            /**CONTROL DE CAMPOS FILTROS DE LA CRONOLOG SELECCIONDA (PARA COPIAR)**/
            ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 1;
            ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP = ENTITY_GLOBAL.Instance.PacienteID;
            ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP = ENTITY_GLOBAL.Instance.EpisodioClinico;
            ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP = ENTITY_GLOBAL.Instance.EpisodioAtencion;
            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION_TEMP = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            /************************************/

            string estado = "PanelCentralBlanco";
            //return crearWindowRegistro(Form, model, "", FormContainer);
            return crearWindowRegistro(Form, model, "");

        }

        /**COPIAR FORMULARIOS : (FASE II)*/
        public System.Web.Mvc.ActionResult eventoRegistroHistorialForm(string Accion, string nombrePaciente, string Form, string FormContainer)           
        {
            Log.Information("ProgramarKardexController - eventoRegistroHistorialForm - Entrar");
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new V_EpisodioAtenciones();
        
            model.NombreCompleto = ENTITY_GLOBAL.Instance.NombreCompletoPaciente;
            model.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            model.Accion = Accion;
            model.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            model.UsuarioModificacion = ENTITY_GLOBAL.Instance.CONCEPTO;
            model.UsuarioModificacion = "" + ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL;        

            /**CONTROL DE CAMPOS FILTROS DE LA CRONOLOG SELECCIONDA (PARA COPIAR)**/
            ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 1;
            ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP = ENTITY_GLOBAL.Instance.PacienteID;
            ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP = ENTITY_GLOBAL.Instance.EpisodioClinico;
            ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP = ENTITY_GLOBAL.Instance.EpisodioAtencion;
            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION_TEMP = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION_TEMP = ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION;

            /************************************/

            string estado = "PanelCentralBlanco";
            //return crearWindowRegistro(Form, model, "", FormContainer);
            return crearWindowRegistro(Form, model, "");
        }

        /***/
        public System.Web.Mvc.ActionResult eventoRegistroHistoricoFormulario(string formato,string accion, string idWindow,            
            Nullable<long> idEpiAtencionCopy, Nullable<int> idEpiClinicoCopy, string UnidadReplicacionCopy,
            String data
            )
        {
            Log.Information("ProgramarKardexController - eventoRegistroHistoricoFormulario - Entrar");

            if ("COPIAR" == accion)
            {
                //ASIGNAR NUEVOS VALORES
                ENTITY_GLOBAL.Instance.UnidadReplicacion = UnidadReplicacionCopy;
                //ENTITY_GLOBAL.Instance.PacienteID = ENTITY_GLOBAL.Instance.PacienteID;
                ENTITY_GLOBAL.Instance.EpisodioClinico = idEpiClinicoCopy;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = idEpiAtencionCopy;

                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 1;
            }
            else if ("PEGAR" == accion)
            {
                if ((data != null) || (data.Length > 0))
                {
                    Session["DATA_COPIA_FORM"] = data;
                }
                ENTITY_GLOBAL.Instance.UNIDREPLICACION_COPY = UnidadReplicacionCopy;
                ENTITY_GLOBAL.Instance.IDPACIENTE_COPY = ENTITY_GLOBAL.Instance.PacienteID;
                ENTITY_GLOBAL.Instance.EPISODIOCLINICO_COPY = idEpiClinicoCopy;
                ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_COPY = idEpiAtencionCopy;
                Session["COPIA_FORMULARIO"] = "ACTIVA";
                //var field = X.GetCmp<TextField>("txtPaciente");
                var win = X.GetCmp<Window>(idWindow);
                if (win != null)
                {
                    //X.Msg.Alert("Error ", "000000 WIN NO NULO." + win.Title).Show();
                    win.Hide();
                }
                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 1;
                cambioSeleccionCronologias("DESELECCION");
                return reloadFormatos();
            }
            else if ("HISTORIAL" == accion)
            {
                //ASIGNAR NUEVOS VALORES
                ENTITY_GLOBAL.Instance.UnidadReplicacion = UnidadReplicacionCopy;
                //ENTITY_GLOBAL.Instance.PacienteID = ENTITY_GLOBAL.Instance.PacienteID;
                ENTITY_GLOBAL.Instance.EpisodioClinico = idEpiClinicoCopy;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = idEpiAtencionCopy;

                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 1;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
            }

            //return showMsgTratamientoExcepcion(ex, "");
            //return crearWindowRegistro(Form, model, "", FormContainer);
            return this.Direct();
        }

        /********EVENTO DE EXAMENESADICIONALES**************/

        public System.Web.Mvc.ActionResult eventoAgregarHistoricoFormulario(string formato, string accion, string idWindow,
            Nullable<long> idEpiAtencionCopy, Nullable<int> idEpiClinicoCopy, string UnidadReplicacionCopy,
            String data
            )
        {
            Log.Information("ProgramarKardexController - eventoAgregarHistoricoFormulario - Entrar");


            List<MA_MiscelaneosDetalle> dataSave = null;
            var varPasarDetalle = new MA_MiscelaneosDetalle();

            List<MA_MiscelaneosDetalle> ObjListar = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<MA_MiscelaneosDetalle>));


            try
            {
                if (ObjListar != null)
                {

                    if (ObjListar.Count > 0)
                    {

                        foreach (MA_MiscelaneosDetalle objadd in ObjListar)
                        {
                            varPasarDetalle.CodigoElemento = objadd.CodigoElemento;
                            varPasarDetalle.ValorCodigo5 = objadd.ValorCodigo5;
                            varPasarDetalle.DescripcionLocal = objadd.DescripcionLocal;
                            varPasarDetalle.ValorCodigo1 = objadd.ValorCodigo1;
                            varPasarDetalle.ValorCodigo2 = objadd.ValorCodigo2;
                            varPasarDetalle.ValorCodigo3 = objadd.ValorCodigo3;
                            varPasarDetalle.ValorCodigo4 = objadd.ValorCodigo4;
                            varPasarDetalle.ValorCodigo7 = objadd.ValorCodigo7;
                            varPasarDetalle.ValorEntero1 = objadd.ValorEntero1;
                            varPasarDetalle.ValorEntero2 = objadd.ValorEntero2;

                            var txtComp = X.GetCmp<TextField>("RecepcionaRecurso");
                            txtComp.SetValue(JSON.Serialize(varPasarDetalle));

                        }


                    }

                    //cerrarWindow(idWindow);

                }

                return cerrarWindow(idWindow);

            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - eventoAgregarHistoricoFormulario - Bloque Catch");
                Log.Error(ex, ex.Message);
                return showMsgTratamientoExcepcion(ex, "EXC: eventoAgregarHistoricoFormulario");
            }



        }


        /************************/
        public Object getObjetoMiscelaneoFormulario_de_Historial(String data,string accion, string codigoForm, Object dataValidacion)
        {
            Log.Information("ProgramarKardexController - getObjetoMiscelaneoFormulario_de_Historial - Entrar");

            if (accion == "PEGAR" && data != null)
            {
                List<V_EpisodioAtenciones> listaCopiaForm = (List<V_EpisodioAtenciones>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<V_EpisodioAtenciones>));
                //List<V_EpisodioAtenciones> dataSave = null;
                Session["DATA_COPIA_FORM"] = data;
                //PARA DIAGNóSTICOS
                if (codigoForm == UTILES_MENSAJES.FORM_DIAGNOSTICO_F1)
                {
                    List<MA_MiscelaneosDetalle> listaCopia = new List<MA_MiscelaneosDetalle>();
                    if (listaCopiaForm != null)
                    {
                        List<MA_MiscelaneosDetalle> listaValidar = new List<MA_MiscelaneosDetalle>();
                        if (dataValidacion != null)
                        {
                            listaValidar = (List<MA_MiscelaneosDetalle>)dataValidacion;
                        }
                        foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                        {
                            String codigoCopy = (obj.Id001 != null ? obj.Id001.ToString() : "");
                            Boolean hallado = false;
                            foreach (MA_MiscelaneosDetalle objValidar in listaValidar)
                            {
                                String codigoVal = getCodigoElementoForm(objValidar.ValorCodigo1, codigoForm);
                                if (codigoCopy.Length > 0 && codigoVal == codigoCopy)
                                {
                                    hallado = true;
                                    break;
                                }
                            }
                            if (!hallado)
                            {

                                //OBTENER POR ID (SE PIDIÓ TODOS LOS VALORES DEL REGISTRO)
                                SS_HC_Diagnostico objFiltro = new SS_HC_Diagnostico();
                                objFiltro.UnidadReplicacion = obj.UnidadReplicacion;
                                objFiltro.IdPaciente = obj.IdPaciente;
                                objFiltro.EpisodioClinico = obj.EpisodioClinico;
                                objFiltro.IdEpisodioAtencion = obj.IdEpisodioAtencion;
                                objFiltro.Secuencia = (obj.Id002 != null ? Convert.ToInt32(obj.Id002) : 0);
                                objFiltro = SvcDiagnosticoService.obtenerPorId(objFiltro);
                                if (objFiltro != null)
                                {
                                    MA_MiscelaneosDetalle objAdd = new MA_MiscelaneosDetalle();
                                    objAdd.ValorCodigo1 = (obj.Descripcion001 != null ? obj.Descripcion001.Trim() : "") + "|" + "[" + (obj.Id001 != null ? obj.Id001.ToString() : "") + "]";
                                    objAdd.ACCION = "NUEVO";
                                    objAdd.UltimoUsuario = "COPIA";//AUX
                                    //
                                    objAdd.CodigoElemento = "" + objFiltro.Secuencia;
                                    objAdd.ValorCodigo6 = objFiltro.Observacion;
                                    objAdd.ValorCodigo2 = objFiltro.DeterminacionDiagnostica;
                                    objAdd.ValorCodigo3 = "" + (objFiltro.IdDiagnosticoPrincipal != null ? objFiltro.IdDiagnosticoPrincipal : 0);
                                    objAdd.ValorCodigo4 = objFiltro.GradoAfeccion;
                                    objAdd.ValorCodigo5 = objFiltro.TipoAntecedente;
                                    objAdd.ValorCodigo6 = objFiltro.Observacion;
                                    objAdd.ValorEntero5 = objFiltro.IndicadorPreExistencia;
                                    objAdd.ValorEntero6 = objFiltro.IndicadorCronico;
                                    objAdd.ValorEntero6 = objFiltro.IndicadorCronico;

                                    listaCopia.Add(objAdd);
                                }

                            }
                        }
                    }
                    return listaCopia;
                }
                else if (codigoForm == UTILES_MENSAJES.FORM_MEDICAMENTOS_F1)
                {
                    List<HC_Medicamento> listaCopia = new List<HC_Medicamento>();
                    //PARA MEDICAMENTOS
                    if (listaCopiaForm != null)
                    {
                        List<HC_Medicamento> listaValidar = new List<HC_Medicamento>();
                        if (dataValidacion != null)
                        {
                            listaValidar = (List<HC_Medicamento>)dataValidacion;
                        }
                        foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                        {
                            String codigoCopy = (obj.Codigo001 != null ? obj.Codigo001.Trim() : "") +
                                (obj.Codigo002 != null ? obj.Codigo002.Trim() : "") +
                                (obj.Codigo003 != null ? obj.Codigo003.Trim() : "") +
                                (obj.Codigo004 != null ? obj.Codigo004.Trim() : "")
                                ;
                            Boolean hallado = false;
                            foreach (HC_Medicamento objValidar in listaValidar)
                            {
                                String codigoVal = (objValidar.Linea != null ? objValidar.Linea.Trim() : "") +
                                      (objValidar.Familia != null ? objValidar.Familia.Trim() : "") +
                                      (objValidar.SubFamilia != null ? objValidar.SubFamilia.Trim() : "") +
                                      (objValidar.CodigoComponente != null ? objValidar.CodigoComponente.Trim() : "")
                                      ;
                                if (codigoCopy.Length > 0 && codigoVal == codigoCopy)
                                {
                                    hallado = true;
                                    break;
                                }
                            }
                            if (!hallado)
                            {
                                ENTITY_GLOBAL.Instance.INTERUPTOR_TEMP = 1;
                                HC_Medicamento objAdd = new HC_Medicamento();
                                objAdd.SubFamiliaDescripcion = obj.Descripcion001;
                                //objAdd.IndicadorEPS = obj.Id002;
                                objAdd.Linea = obj.Codigo001;
                                objAdd.Familia = obj.Codigo002;
                                objAdd.SubFamilia = obj.Codigo003;
                                objAdd.CodigoComponente = obj.Codigo004;

                                objAdd.TipoMedicamento = obj.Id001;
                                objAdd.Secuencia = obj.Id002;
                                //objAdd.Version = obj.Codigo004;
                                //objAdd.ValorCodigo1 = (obj.Descripcion001 != null ? obj.Descripcion001.Trim() : "") + "|" + "[" + (obj.Id001 != null ? obj.Id001.ToString() : "") + "]";

                                objAdd.Accion = "NUEVO";
                                objAdd.UsuarioModificacion = "COPIA";//AUX
                                listaCopia.Add(objAdd);
                            }
                        }
                    }
                    return listaCopia;
                }
                else if (codigoForm == UTILES_MENSAJES.FORM_DIETAS_MNUT_F1 + "_2"
                        || codigoForm == UTILES_MENSAJES.FORM_DIETAS_MNUT_F1 + "_3"
                    )
                {
                    //VERIFICAR QUE TIPO DE MEDICAMENT ES
                    int tipoMed = 0;
                    if (codigoForm == UTILES_MENSAJES.FORM_DIETAS_MNUT_F1 + "_2"
                    )
                    {
                        tipoMed = 2;
                    }
                    else if (codigoForm == UTILES_MENSAJES.FORM_DIETAS_MNUT_F1 + "_3")
                    {
                        tipoMed = 3;
                    }


                    List<HC_Medicamento> listaCopia = new List<HC_Medicamento>();
                    //PARA DIETAS Y MICRO NUT
                    if (listaCopiaForm != null)
                    {
                        List<HC_Medicamento> listaValidar = new List<HC_Medicamento>();
                        if (dataValidacion != null)
                        {
                            listaValidar = (List<HC_Medicamento>)dataValidacion;
                        }
                        foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                        {
                            if (obj.Id001 == tipoMed)
                            {
                                String codigoCopy = (obj.Codigo001 != null ? obj.Codigo001.Trim() : "") +
                                    (obj.Codigo002 != null ? obj.Codigo002.Trim() : "") +
                                    (obj.Codigo003 != null ? obj.Codigo003.Trim() : "") +
                                    (obj.Codigo004 != null ? obj.Codigo004.Trim() : "")
                                    ;
                                Boolean hallado = false;
                                foreach (HC_Medicamento objValidar in listaValidar)
                                {
                                    String codigoVal = (objValidar.Linea != null ? objValidar.Linea.Trim() : "") +
                                          (objValidar.Familia != null ? objValidar.Familia.Trim() : "") +
                                          (objValidar.SubFamilia != null ? objValidar.SubFamilia.Trim() : "") +
                                          (objValidar.CodigoComponente != null ? objValidar.CodigoComponente.Trim() : "")
                                          ;
                                    if (codigoCopy.Length > 0 && codigoVal == codigoCopy)
                                    {
                                        hallado = true;
                                        break;
                                    }
                                }
                                if (!hallado)
                                {
                                    ENTITY_GLOBAL.Instance.INTERUPTOR_TEMP = 1;
                                    HC_Medicamento objAdd = new HC_Medicamento();
                                    objAdd.SubFamiliaDescripcion = obj.Descripcion001;
                                    //objAdd.IndicadorEPS = obj.Id002;
                                    objAdd.Linea = obj.Codigo001;
                                    objAdd.Familia = obj.Codigo002;
                                    objAdd.SubFamilia = obj.Codigo003;
                                    objAdd.CodigoComponente = obj.Codigo004;


                                    objAdd.TipoMedicamento = obj.Id001;
                                    objAdd.Secuencia = obj.Id002;

                                    //objAdd.Version = obj.Codigo004;
                                    //objAdd.ValorCodigo1 = (obj.Descripcion001 != null ? obj.Descripcion001.Trim() : "") + "|" + "[" + (obj.Id001 != null ? obj.Id001.ToString() : "") + "]";

                                    objAdd.Accion = "NUEVO";
                                    objAdd.UsuarioModificacion = "COPIA";//AUX
                                    listaCopia.Add(objAdd);
                                }
                            }
                        }
                    }
                    return listaCopia;
                }
                else if (codigoForm == UTILES_MENSAJES.FORM_EVOL_OBJETIVA_F1)
                {

                    String objValidar = "";
                    if (dataValidacion != null)
                    {
                        objValidar = (String)dataValidacion;
                    }
                    String objCopia = objValidar;
                    foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                    {
                        if (objValidar.Trim() != obj.Descripcion001.Trim())
                        {
                            objCopia = "" + objCopia + "\n" +
                                obj.Descripcion001 + "(Copia)";
                        }
                    }
                    return objCopia;
                }
                else if (codigoForm == UTILES_MENSAJES.FORM_DIAGNOSTICO_F2)
                {
                    List<MA_MiscelaneosDetalle> listaCopia = new List<MA_MiscelaneosDetalle>();
                    if (listaCopiaForm != null)
                    {
                        List<MA_MiscelaneosDetalle> listaValidar = new List<MA_MiscelaneosDetalle>();
                        if (dataValidacion != null)
                        {
                            listaValidar = (List<MA_MiscelaneosDetalle>)dataValidacion;
                        }
                        foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                        {
                            String codigoCopy = (obj.Id001 != null ? obj.Id001.ToString() : "");
                            Boolean hallado = false;
                            foreach (MA_MiscelaneosDetalle objValidar in listaValidar)
                            {
                                String codigoVal = getCodigoElementoForm(objValidar.ValorCodigo1, codigoForm);
                                if (codigoCopy.Length > 0 && codigoVal == codigoCopy)
                                {
                                    hallado = true;
                                    break;
                                }
                            }
                            if (!hallado)
                            {

                                //OBTENER POR ID (SE PIDIÓ TODOS LOS VALORES DEL REGISTRO)
                                SS_HC_Diagnostico_FE objFiltro = new SS_HC_Diagnostico_FE();
                                objFiltro.UnidadReplicacion = obj.UnidadReplicacion;
                                objFiltro.IdPaciente = obj.IdPaciente;
                                objFiltro.EpisodioClinico = obj.EpisodioClinico;
                                objFiltro.IdEpisodioAtencion = obj.IdEpisodioAtencion;
                                objFiltro.Secuencia = (obj.Id002 != null ? Convert.ToInt32(obj.Id002) : 0);
                                objFiltro = SvcDiagnosticoFE.obtenerPorId(objFiltro);
                                if (objFiltro != null)
                                {
                                    MA_MiscelaneosDetalle objAdd = new MA_MiscelaneosDetalle();
                                    objAdd.ValorCodigo1 = (obj.Descripcion001 != null ? obj.Descripcion001.Trim() : "") + "|" + "[" + (obj.Id001 != null ? obj.Id001.ToString() : "") + "]";
                                    objAdd.ACCION = "NUEVO";
                                    objAdd.UltimoUsuario = "COPIA";//AUX
                                    //
                                    objAdd.CodigoElemento = "" + objFiltro.Secuencia;
                                    objAdd.ValorCodigo6 = objFiltro.Observacion;
                                    objAdd.ValorCodigo2 = objFiltro.DeterminacionDiagnostica;
                                    objAdd.ValorCodigo3 = "" + (objFiltro.IdDiagnosticoPrincipal != null ? objFiltro.IdDiagnosticoPrincipal : 0);
                                    objAdd.ValorCodigo4 = objFiltro.GradoAfeccion;
                                    objAdd.ValorCodigo5 = objFiltro.TipoAntecedente;
                                    objAdd.ValorCodigo6 = objFiltro.Observacion;
                                    objAdd.ValorEntero5 = objFiltro.IndicadorPreExistencia;
                                    objAdd.ValorEntero6 = objFiltro.IndicadorCronico;
                                    objAdd.ValorEntero6 = objFiltro.IndicadorCronico;

                                    listaCopia.Add(objAdd);
                                }

                            }
                        }
                    }
                    return listaCopia;
                }
                else if (codigoForm == UTILES_MENSAJES.FORM_MEDICAMENTOS_F2)
                {
                    //List<MA_MiscelaneosDetalle> listaCopia = new List<MA_MiscelaneosDetalle>();
                    List<BE_Medicamento_FE> listaCopia = new List<BE_Medicamento_FE>();
                    //PARA MEDICAMENTOS
                    if (listaCopiaForm != null)
                    {
                        List<BE_Medicamento_FE> listaValidar = new List<BE_Medicamento_FE>();
                        if (dataValidacion != null)
                        {
                            listaValidar = (List<BE_Medicamento_FE>)dataValidacion;
                        }
                        foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                        {
                            String codigoCopy = (obj.Codigo001 != null ? obj.Codigo001.Trim() : "") +
                                (obj.Codigo002 != null ? obj.Codigo002.Trim() : "") +
                                (obj.Codigo003 != null ? obj.Codigo003.Trim() : "") +
                                (obj.Codigo004 != null ? obj.Codigo004.Trim() : "")
                                ;
                            Boolean hallado = false;
                            foreach (BE_Medicamento_FE objValidar in listaValidar)
                            {
                                String codigoVal = (objValidar.Linea != null ? objValidar.Linea.Trim() : "") +
                                      (objValidar.Familia != null ? objValidar.Familia.Trim() : "") +
                                      (objValidar.SubFamilia != null ? objValidar.SubFamilia.Trim() : "") +
                                      (objValidar.CodigoComponente != null ? objValidar.CodigoComponente.Trim() : "")
                                      ;
                                if (codigoCopy.Length > 0 && codigoVal == codigoCopy)
                                {
                                    hallado = true;
                                    break;
                                }
                            }
                            if (!hallado)
                            {
                                ENTITY_GLOBAL.Instance.INTERUPTOR_TEMP = 1;
                                BE_Medicamento_FE objAdd = new BE_Medicamento_FE();
                                objAdd.SubFamiliaDescripcion = obj.Descripcion001;
                                //objAdd.IndicadorEPS = obj.Id002;
                                objAdd.Linea = obj.Codigo001;
                                objAdd.Familia = obj.Codigo002;
                                objAdd.SubFamilia = obj.Codigo003;
                                objAdd.CodigoComponente = obj.Codigo004;

                                objAdd.TipoMedicamento = obj.Id001;
                                objAdd.Secuencia = obj.Id002;
                                //objAdd.Version = obj.Codigo004;
                                //objAdd.ValorCodigo1 = (obj.Descripcion001 != null ? obj.Descripcion001.Trim() : "") + "|" + "[" + (obj.Id001 != null ? obj.Id001.ToString() : "") + "]";

                                objAdd.Accion = "NUEVO";
                                objAdd.UsuarioModificacion = "COPIA";//AUX
                                listaCopia.Add(objAdd);
                            }
                        }
                    }
                    //imple
                    return listaCopia;
                }
                else if (codigoForm == UTILES_MENSAJES.FORM_DIETAS_MNUT_F2)
                {
                    List<MA_MiscelaneosDetalle> listaCopia = new List<MA_MiscelaneosDetalle>();
                    //imple
                    return listaCopia;
                }
                //else if (codigoForm == UTILES_MENSAJES.FORM_EVOL_OBJETIVA_F2)
                else if (codigoForm == UTILES_MENSAJES.FORM_EXAMENSOLICITADO_F2)
                {
                    List<MA_MiscelaneosDetalle> listaCopia = new List<MA_MiscelaneosDetalle>();
                    //imple
                    if (listaCopiaForm != null)
                    {
                        List<MA_MiscelaneosDetalle> listaValidar = new List<MA_MiscelaneosDetalle>();
                        if (dataValidacion != null)
                        {
                            listaValidar = (List<MA_MiscelaneosDetalle>)dataValidacion;
                        }
                        foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                        {
                            String codigoCopy = (obj.Id001 != null ? obj.Id001.ToString() : "");
                            Boolean hallado = false;
                            foreach (MA_MiscelaneosDetalle objValidar in listaValidar)
                            {
                                String codigoVal = getCodigoElementoForm(objValidar.ValorCodigo1, codigoForm);
                                if (codigoCopy.Length > 0 && codigoVal == codigoCopy)
                                {
                                    hallado = true;
                                    break;
                                }
                            }
                            //if (!hallado)
                            //{

                            //    //OBTENER POR ID (SE PIDIÓ TODOS LOS VALORES DEL REGISTRO)
                            //    SS_HC_Diagnostico_FE objFiltro = new SS_HC_Diagnostico_FE();
                            //    objFiltro.UnidadReplicacion = obj.UnidadReplicacion;
                            //    objFiltro.IdPaciente = obj.IdPaciente;
                            //    objFiltro.EpisodioClinico = obj.EpisodioClinico;
                            //    objFiltro.IdEpisodioAtencion = obj.IdEpisodioAtencion;
                            //    objFiltro.Secuencia = (obj.Id002 != null ? Convert.ToInt32(obj.Id002) : 0);
                            //    objFiltro = SvcDiagnosticoFE.obtenerPorId(objFiltro);
                            //    if (objFiltro != null)
                            //    {
                            //        MA_MiscelaneosDetalle objAdd = new MA_MiscelaneosDetalle();
                            //        objAdd.ValorCodigo1 = (obj.Descripcion001 != null ? obj.Descripcion001.Trim() : "") + "|" + "[" + (obj.Id001 != null ? obj.Id001.ToString() : "") + "]";
                            //        objAdd.ACCION = "NUEVO";
                            //        objAdd.UltimoUsuario = "COPIA";//AUX
                            //        //
                            //        objAdd.CodigoElemento = "" + objFiltro.Secuencia;
                            //        objAdd.ValorCodigo6 = objFiltro.Observacion;
                            //        objAdd.ValorCodigo2 = objFiltro.DeterminacionDiagnostica;
                            //        objAdd.ValorCodigo3 = "" + (objFiltro.IdDiagnosticoPrincipal != null ? objFiltro.IdDiagnosticoPrincipal : 0);
                            //        objAdd.ValorCodigo4 = objFiltro.GradoAfeccion;
                            //        objAdd.ValorCodigo5 = objFiltro.TipoAntecedente;
                            //        objAdd.ValorCodigo6 = objFiltro.Observacion;
                            //        objAdd.ValorEntero5 = objFiltro.IndicadorPreExistencia;
                            //        objAdd.ValorEntero6 = objFiltro.IndicadorCronico;                              
                            //        listaCopia.Add(objAdd);
                            //    }

                            //}
                        }
                    }
                    return listaCopia;
                }
                else if (codigoForm == UTILES_MENSAJES.FORM_EVOL_OBJETIVA_F2)
                {
                    String objValidar = "";
                    if (dataValidacion != null)
                    {
                        objValidar = (String)dataValidacion;
                    }
                    String objCopia = objValidar;
                    foreach (V_EpisodioAtenciones obj in listaCopiaForm)
                    {
                        if (objValidar.Trim() != obj.Descripcion001.Trim())
                        {
                            objCopia = "" + objCopia + "\n" +
                                obj.Descripcion001 + "(Copia)";
                        }
                    }
                    return objCopia;
                }
            }
            return null;
        }

        public String getCodigoElementoForm(string segmentoCadena, string codigoForm)
        {
            Log.Information("ProgramarKardexController - getCodigoElementoForm - Entrar");
            String codigo = "";
            try
            {
                if (segmentoCadena.Contains("|"))
                {
                    String[] vectorCadena = segmentoCadena.Split('|');
                    if (vectorCadena.Length > 1)
                    {
                        codigo = vectorCadena[1];
                    }
                    codigo = codigo.Replace("[", "");
                    codigo = codigo.Replace("]", "");
                }
                return codigo;
            }
            catch (Exception ex)
            {
                Log.Error(ex, ex.Message);
                return "";
            }
        }

        /**Prepara los Códigos Formatos VIEW para recueparar la vista anterior*/
        public Boolean getIndicaFormatosCopiar(String codigoFormato)
        {
            Log.Information("ProgramarKardexController - getIndicaFormatosCopiar - Entrar");
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
                    || codigoFormato == UTILES_MENSAJES.FORM_MEDICAMENTOS_F2
                    || codigoFormato == UTILES_MENSAJES.FORM_DIETAS_MNUT_F2
                    )
                {
                    result = true;
                }

            }
            return result;
        }

        /**TEST FORM**/


        /**PARA EL LISATDO DE LA BITACORA*/
        public StoreResult ArbolMacroProcesosBitacora(string node, string filtro)
        {
            Log.Information("ProgramarKardexController - ArbolMacroProcesosBitacora - Entrar");

            NodeCollection nodes = new Ext.Net.NodeCollection();
            var objVistaSeguridad = new SS_CHE_VistaSeguridad();
            if (node == "root")
            {
                SS_HC_EpisodioAtencion objEpisodio = new SS_HC_EpisodioAtencion();
                objEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objEpisodio.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                //OBS: se filtra por tipo de ATENCIÓN
                Nullable<int> TipoAtencion = null;
                if (Session["TIPOATENCION_ACTUAL"] != null)
                {
                    TipoAtencion = (int)Session["TIPOATENCION_ACTUAL"];
                }
                objEpisodio.TipoAtencion = TipoAtencion;
                objEpisodio.Accion = "LISTAR";
                objEpisodio.Estado = UTILES_MENSAJES.ESTADO_EPI_ENATENCION;
                Dictionary<String, String> DICT_ATENCION = new Dictionary<String, String>();
                List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(objEpisodio, 0, 0);
                foreach (SS_HC_EpisodioAtencion resulenti in listaEpi)
                {
                    if (!DICT_ATENCION.ContainsKey("" + resulenti.CodigoOA))
                    {
                        DICT_ATENCION["" + resulenti.CodigoOA] = resulenti.CodigoOA;
                    }
                }
                foreach (var obj in DICT_ATENCION)
                {
                    Node asyncNode = new Node();
                    asyncNode.Leaf = false;
                    asyncNode.Icon = Icon.Note;

                    asyncNode.Text = "OA: " + obj.Value;
                    asyncNode.NodeID = "0|" +     //[0] nivel
                                       obj.Value       //[1]
                                    ;
                    foreach (var resulenti in listaEpi)
                    {
                        if (obj.Value == resulenti.CodigoOA)
                        {
                            string codigoEpi = UTILES_MENSAJES.getCodigoTransaccionHCE((long)(resulenti.FlagFirma != null ? resulenti.FlagFirma : 0),
                                   resulenti.EpisodioAtencion, resulenti.IdEpisodioAtencion, resulenti.IdPaciente, "");

                            Node asyncNodeHijo = new Node();
                            asyncNodeHijo.Leaf = false;
                            asyncNodeHijo.Icon = Icon.NoteGo;
                            asyncNodeHijo.Text = "Atención:" + codigoEpi + ": " + (resulenti.FechaRegistro != null ? Convert.ToDateTime(resulenti.FechaRegistro).ToString("yyyy-MM-dd HH:mm") : " [fecha no especif.]");
                            asyncNodeHijo.NodeID = "1|" +     //[0] nivel
                                                resulenti.EpisodioClinico + "|" +      //[1]
                                                resulenti.IdEpisodioAtencion + "|" +       //[2]
                                                resulenti.IdOrdenAtencion + "|" +      //[3]
                                                resulenti.LineaOrdenAtencion        //[4]                                  
                                                ;
                            asyncNode.Children.Add(asyncNodeHijo);
                            //asyncNodeHijos.Add(asyncNodeHijo);                              
                        }
                    }
                    nodes.Add(asyncNode);
                }
            }
            else
            {
                if (node.Length > 0)
                {
                    string nivel = "";
                    string idEpiClinico = "";
                    string idEpiAtencion = "";
                    string idOa = "";
                    string lineaOa = "";
                    string idOpcion = "";
                    string[] vector = node.Split('|');
                    if (vector.Length > 0)
                    {
                        nivel = vector[0];
                        if (vector.Length > 4)
                        {
                            idEpiClinico = vector[1];
                            idEpiAtencion = vector[2];
                            idOa = vector[3];
                            lineaOa = vector[4];
                            if (vector.Length > 5)
                            {
                                idOpcion = vector[5];
                            }
                        }


                        if (nivel == "0")
                        {
                            //NO HACER NADA
                        }
                        else
                        {
                            /***********FILTROS ****/

                            //OBS:ADD de seguridad
                            objVistaSeguridad.CadenaRecursividad = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                            objVistaSeguridad.IdEmpleado = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            objVistaSeguridad.IndicadorPrioridad = Convert.ToInt32(idEpiClinico);
                            objVistaSeguridad.Version = "" + idEpiAtencion;

                            ////////////////
                            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                            {
                                objVistaSeguridad.TipoTrabajador = (String)Session["TIPOTRABAJADOR_ACTUAL"];
                            }
                            if (Session["TIPOATENCION_ACTUAL"] != null)
                            {
                                objVistaSeguridad.idTipoAtencion = (int)Session["TIPOATENCION_ACTUAL"];
                            }
                            //////////////
                            //////ADD PARA CONFIGURACION DE ASIGNACIONES
                            VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = null;
                            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                            {
                                vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                                objVistaSeguridad.IdGrupo = vistaGenSelec.IdEspecialidad;//AUX 
                            }
                            objVistaSeguridad.Compania = ENTITY_GLOBAL.Instance.Compania;
                            if (ENTITY_GLOBAL.Instance.Establecimiento != null)
                            {
                                objVistaSeguridad.IdOrganizacion = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                            }
                            if (Session["IdUnidadServicio_ACTUAL"] != null)
                            {
                                objVistaSeguridad.IdObjetoAsociado = (int)Session["IdUnidadServicio_ACTUAL"];
                            }
                            objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                            objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                            objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                            objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;
                            objVistaSeguridad.Accion = "LISTAPROCESOS";
                            objVistaSeguridad.Nivel = 2;

                            if (nivel == "1")
                            {
                                objVistaSeguridad.Accion = "LISTAPROCESOS";
                                objVistaSeguridad.IdOpcionPadre = Convert.ToInt32(ENTITY_GLOBAL.Instance.OPCION_PADRE != null ? ENTITY_GLOBAL.Instance.OPCION_PADRE : "0");
                            }
                            else
                            {
                                objVistaSeguridad.Accion = "LISTAPROCESOSBITACORA";
                                objVistaSeguridad.IdOpcionPadre = Convert.ToInt32(idOpcion.Length > 0 ? idOpcion : "0");
                            }
                            /***********************/
                            var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);
                            foreach (var resulenti in resulListado)
                            {
                                Node asyncNode = new Node();
                                asyncNode.Text = resulenti.NombreOpcion;
                                //asyncNode.NodeID = resulenti.IdOpcion.ToString().Trim();
                                asyncNode.NodeID = "2|" +     //[0] nivel
                                                    idEpiClinico + "|" +      //[1]
                                                    idEpiAtencion + "|" +       //[2]
                                                    idOa + "|" +      //[3]
                                                    lineaOa + "|" +        //[4]    
                                                    resulenti.IdOpcion.ToString().Trim(); //[5]    
                                ;

                                asyncNode.Href = "javascript:myFunction('" + resulenti.NombreOpcion + "')";
                                asyncNode.Leaf = resulenti.TipoIcono > 1 ? true : false;
                                if (resulenti.TipoIcono != null)
                                {
                                    if (resulenti.TipoIcono == 5) asyncNode.Icon = Icon.PageGreen;
                                    if (resulenti.TipoIcono == 6) asyncNode.Icon = Icon.PageRed;
                                }

                                nodes.Add(asyncNode);
                            }
                        }
                    }
                }
            }
            //ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 1;
            return this.Store(nodes);
        }

        /**Cargar un formato seleccionado de la bitácora, sin alterar las variables de la atención actual*/
        public System.Web.Mvc.ActionResult LoadFormatoBitacora(string containerId, string node)
        {
            Log.Information("ProgramarKardexController - LoadFormatoBitacora - Entrar");

            if (ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS == 0)
            {
                ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP = ENTITY_GLOBAL.Instance.PacienteID;
                ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP = ENTITY_GLOBAL.Instance.EpisodioClinico;
                ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION_TEMP = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                //ADD
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION_TEMP = ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION;
                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 1;
            }

            string idOpcion = "";
            //SI ESTÁ ACTIVO EL NIVEL HISTÓRICO
            if (ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS == 1)
            {
                string nivel = "";
                string idEpiClinico = "";
                string idEpiAtencion = "";
                string idOa = "";
                string lineaOa = "";

                string[] vector = node.Split('|');
                if (vector.Length > 0)
                {
                    nivel = vector[0];
                    if (vector.Length > 4)
                    {
                        idEpiClinico = vector[1];
                        idEpiAtencion = vector[2];
                        idOa = vector[3];
                        lineaOa = vector[4];
                        if (vector.Length > 5)
                        {
                            idOpcion = vector[5];
                        }
                    }
                }

                ENTITY_GLOBAL.Instance.UnidadReplicacion = ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP;
                ENTITY_GLOBAL.Instance.PacienteID = ENTITY_GLOBAL.Instance.IDPACIENTE_TEMP;
                ENTITY_GLOBAL.Instance.EpisodioClinico = Convert.ToInt32(idEpiClinico.Length > 0 ? idEpiClinico : "0");
                ENTITY_GLOBAL.Instance.EpisodioAtencion = Convert.ToInt32(idEpiAtencion.Length > 0 ? idEpiAtencion : "0");
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                //ADD
                //ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION_TEMP;                
            }

            if (idOpcion.Length > 0)
            {
                return LoadFormatos(containerId, idOpcion);
            }
            else
            {
                return this.Direct();
            }
        }

        public System.Web.Mvc.ActionResult ExamenesAdicionales(String MODO)
        {
            Log.Information("ProgramarKardexController - ExamenesAdicionales - Entrar");

            var objModel = new SS_HC_BANDEJA_NOTIFI_DETALLE();

            objModel.Accion = MODO;
            objModel.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objModel.IdPaciente = ENTITY_GLOBAL.Instance.PacienteID;
            objModel.EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
            objModel.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);

            //aqui me quede

            return crearWindowRegistro("ExamenesAdicionales", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);

        }

        public System.Web.Mvc.ActionResult getGrillaNotificacionDetalle(int start, int limit, string desc, string tipoBuscar, string estado)
        {
            Log.Information("ProgramarKardexController - getGrillaNotificacionDetalle - Entrar");


            ENTITY_GLOBAL.Instance.GRUPO = "";
            //ConsultaCita();
            var Listar = new List<SS_HC_BANDEJA_NOTIFI_DETALLE>();

            var LocalEnty = new SS_HC_BANDEJA_NOTIFI_DETALLE();
            LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            LocalEnty.IdPaciente = ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnty.EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
            LocalEnty.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);

            LocalEnty.Descripcion01 = desc;
            LocalEnty.Estado = estado;
            int inicio = (start == 0 ? start : start + 1);
            int final = start + limit;
            //Si la búsqueda proviene de filtros
            if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

            LocalEnty.Accion = "LISTARDETALLE";
            Listar = SvcNotificacionDetalle.listarNotificacionDetalle(LocalEnty, inicio, final);

            return this.Store(Listar);



        }


        /**Método para el evento del uso de un Bien y servicio */
        public System.Web.Mvc.ActionResult eventoSeleccionarBienServicio(String codigoFormato)
        {
            Log.Information("ProgramarKardexController - eventoSeleccionarBienServicio - Entrar");

            try
            {
                //Session["ESCOLLAPSED_BIENSERV"] = "S"; //Se podría usar
                Panel panelServ = X.GetCmp<Panel>("East1");
                if (panelServ != null)
                {
                    panelServ.Expand();
                    //panelServ.Collapse();
                }
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - eventoSeleccionarBienServicio - Bloque Catch");
                Log.Error(ex, ex.Message);
            }
            return this.Direct();
        }


        public System.Web.Mvc.ActionResult getPaneles(String accion)
        {
            Log.Information("ProgramarKardexController - getPaneles - Entrar");

            try
            {
                var LocalEnty = new MA_MiscelaneosDetalle();
                var ObjLista = new List<MA_MiscelaneosDetalle>();
                LocalEnty.ACCION = "DIAGNOSTICONANDAPAE";
                LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
                LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioClinico.ToString().Trim();
                LocalEnty.ValorCodigo3 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
                LocalEnty.ValorCodigo5 = ENTITY_GLOBAL.Instance.UnidadReplicacion;

                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                ObjLista = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();

                if (ObjLista != null)
                {
                    if (ObjLista.Count > 0)
                    {

                        return this.Direct(ObjLista[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - getPaneles - Bloque Catch");
                Log.Error(ex, ex.Message);
            }


            return this.Direct();

        }


        public System.Web.Mvc.ActionResult cargar_planf(int idNanda)
        {
            Log.Information("ProgramarKardexController - cargar_planf - Entrar");

            var lista = new List<SS_HC_NANDA>();

            var LocalEnty = new SS_HC_NANDA();
            //LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            // LocalEnty.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
            // LocalEnty.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
            // LocalEnty.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
            LocalEnty.IdNanda = idNanda;
            LocalEnty.Accion = "LISTAR";


            //lista = SvcDiagnosticoPAE.listarDiagnosticoPAE(LocalEnty, 0, 1);
            lista = SvcNanda.listarNanda(LocalEnty, 0, 1);

            /* if (lista.Count > 0)
             {
               
                 for (int i = 0; i < lista.Count; i++)
                 {
                     Panel panel = new Panel
                     {
                         ID = "Panel" + i,
                         Title = "<table style='width:100%';><col width='70%'><col witdh='30%'><tr><td><span>" + (i + 1) + ") " + lista[i].UsuarioCreacion + " - " + lista[i].Accion + "</span></td><td>Dominio: " + lista[i].Version +" Clase: "+lista[i].Observacion+ "</td></tr></table>",
                         Html = "<div id='subpanel"+i+"'></div>",
                         BodyPadding = 5,
                         Border = false
                     };

                     panel.AddTo(this.GetCmp<Panel>("Paneles"));

                     panel.Expand();
                 }
                 ENTITY_GLOBAL.Instance.CANTIDAD_PANEL = lista.Count;
                 Session["cantidad-panel"] = lista.Count;
             }
             */

            return this.Store(lista);

            // return this.Direct();
        }


        public System.Web.Mvc.ActionResult getGrillaFactores(int start, int limit, int desc,
              string tipoBuscar, string estado)
        {
            Log.Information("ProgramarKardexController - getGrillaFactores - Entrar");

            ENTITY_GLOBAL.Instance.GRUPO = "";
            //ConsultaCita();
            var Listar = new List<SS_HC_FactorRelacionadoNanda>();

            var LocalEnty = new SS_HC_FactorRelacionadoNanda();
            //LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            // LocalEnty.IdPaciente = ENTITY_GLOBAL.Instance.PacienteID;
            // LocalEnty.EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
            // LocalEnty.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);

            LocalEnty.IdNanda = desc;
            LocalEnty.Accion = "FACTORRELACIONADO";
            int inicio = (start == 0 ? start : start + 1);
            int final = start + limit;
            //Si la búsqueda proviene de filtros
            if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

            LocalEnty.Accion = "LISTARDETALLE";
            Listar = SvcFactorRelacionadoNanda.listarFactorRelacionadoNanda(LocalEnty, inicio, final);

            return this.Store(Listar);



        }


        public System.Web.Mvc.ActionResult AdicionarFactor(String MODO, String IdNanda)
        {
            Log.Information("ProgramarKardexController - AdicionarFactor - Entrar");

            var objModel = new SS_HC_FactorRelacionadoNanda();

            objModel.Accion = MODO;
            objModel.IdNanda = Convert.ToInt32(IdNanda);
            //objModel.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            // objModel.IdPaciente = ENTITY_GLOBAL.Instance.PacienteID;
            // objModel.EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
            // objModel.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);

            //aqui me quede

            return crearWindowRegistro("PAE/AdicionarFactor", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);

        }


        public System.Web.Mvc.ActionResult getGrillaFactorRelacionadoNanda(int start, int limit,
             string IdNanda, string IdFactorRelacionado, string tipoBuscar)
        {
            Log.Information("ProgramarKardexController - getGrillaFactorRelacionadoNanda - Entrar");

            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                //ConsultaCita();
                var Listar = new List<SS_HC_FactorRelacionadoNanda>();

                var LocalEnty = new SS_HC_FactorRelacionadoNanda();
                LocalEnty.IdNanda = Convert.ToInt32(getValorFiltroStr(IdNanda));
                //LocalEnty.IdFactorRelacionado = Convert.ToInt32(getValorFiltroStr(IdFactorRelacionado));

                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                //Si la búsqueda proviene de filtros
                /*if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

                LocalEnty.Accion = "FACTORRELACIONADO";
                int cantElementos = SvcFactorRelacionadoNanda.setMantenimientoFRN(LocalEnty);
                if (cantElementos > 0)
                {*/
                LocalEnty.Accion = "LISTARFACTORNANDA";
                Listar = SvcFactorRelacionadoNanda.listarFactorRelacionadoNanda(LocalEnty, inicio, final);
                // }
                return this.Store(Listar);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - getGrillaFactorRelacionadoNanda - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                indicaValidacionForm = true;
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }




        public System.Web.Mvc.ActionResult eventoAgregarHistoricoFormulario2(string formato, string accion, string idWindow,
            Nullable<long> idEpiAtencionCopy, Nullable<int> idEpiClinicoCopy, string UnidadReplicacionCopy,
            String data
            )
        {
            Log.Information("ProgramarKardexController - eventoAgregarHistoricoFormulario2 - Entrar");


            List<MA_MiscelaneosDetalle> dataSave = null;
            var varPasarDetalle = new MA_MiscelaneosDetalle();

            List<MA_MiscelaneosDetalle> ObjListar = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<MA_MiscelaneosDetalle>));


            try
            {
                if (ObjListar != null)
                {

                    if (ObjListar.Count > 0)
                    {

                        foreach (MA_MiscelaneosDetalle objadd in ObjListar)
                        {
                            varPasarDetalle.CodigoElemento = objadd.CodigoElemento;
                            varPasarDetalle.ValorCodigo5 = objadd.ValorCodigo5;
                            varPasarDetalle.DescripcionLocal = objadd.DescripcionLocal;
                            varPasarDetalle.ValorCodigo1 = objadd.ValorCodigo1;
                            varPasarDetalle.ValorCodigo2 = objadd.ValorCodigo2;
                            varPasarDetalle.ValorCodigo3 = objadd.ValorCodigo3;
                            varPasarDetalle.ValorCodigo4 = objadd.ValorCodigo4;
                            varPasarDetalle.ValorCodigo7 = objadd.ValorCodigo7;
                            varPasarDetalle.ValorEntero1 = objadd.ValorEntero1;
                            varPasarDetalle.ValorEntero2 = objadd.ValorEntero2;

                            var txtComp = X.GetCmp<TextField>("RecepcionaRecurso2");
                            txtComp.SetValue(JSON.Serialize(varPasarDetalle));

                        }


                    }

                    //cerrarWindow(idWindow);

                }

                return cerrarWindow(idWindow);

            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - eventoAgregarHistoricoFormulario2 - Bloque Catch");
                Log.Error(ex, ex.Message);
                return showMsgTratamientoExcepcion(ex, "EXC: eventoAgregarHistoricoFormulario2");
            }



        }



        /*********************/


        public StoreResult COMBOS(String valor)
        {
            Log.Information("ProgramarKardexController - COMBOS - Entrar");

            var lista = new List<svccombo>();
            lista = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboGenericos(valor, "");

            return this.Store(lista);
        }
        public StoreResult COMBOS2(String valor2)
        {
            Log.Information("ProgramarKardexController - COMBOS2 - Entrar");

            var lista = new List<svccombo>();
            lista = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboGenerico(valor2);

            return this.Store(lista);
        }

        public System.Web.Mvc.ActionResult eventoFirmaActoMedicoRegistro(String MODO, String idpaciente, String codigooa, String paciente, String password)
        {
            Log.Information("ProgramarKardexController - eventoFirmaActoMedicoRegistro - Entrar");
            /****************************************************/
            var Listar = new List<SG_Agente>();
            //USUARIO objUsuario = new USUARIO();
            SG_Agente objUsuario = new SG_Agente();
            objUsuario.ACCION = "VALIDARLOGIN";
            objUsuario.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            objUsuario.Clave = password;

            Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);


            Boolean validoLogin = false;
            if (Listar.Count > 0)
            {
                validoLogin = true;
                foreach (SG_Agente objEntity in Listar)
                {
                    objUsuario = objEntity;
                }
            }
            if (objUsuario != null)
            {

            }

            if (validoLogin)
            {







                /****************************************************/

                SS_HC_EpisodioAtencion objEpisodio = new SS_HC_EpisodioAtencion();
                if (MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER")
                {
                    try
                    {
                        /////
                        objEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        objEpisodio.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        objEpisodio.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        objEpisodio.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        objEpisodio.Accion = "LISTARPORID";

                        List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(objEpisodio, 0, 0);
                        if (listaEpi != null)
                        {
                            foreach (var result in listaEpi)
                            {
                                objEpisodio = result;
                            }
                        }

                        objEpisodio.Accion = MODO;
                        objEpisodio.idMedicoFirma = ENTITY_GLOBAL.Instance.CODPERSONA;
                        objEpisodio.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                        objEpisodio.Version = ENTITY_GLOBAL.Instance.NombreCompletoPaciente;  //AUX

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
                                objEpisodio.DescansoMedico = obj.NombreCompleto; ///nombre del medico
                            }

                            // EJECUTAMOS INTEROPERATIBILIDAD
                            //eventoProcesoInteroperabilidad("INTEROP");

                            ///


                        }
                    }
                    catch (Exception ex)
                    {
                        EventLog.GenerarLogError(ex);
                        var sqlException = ex.InnerException as SqlException;
                        var detalle = new MA_MiscelaneosDetalle();
                        detalle.ACCION = "ERRORES";
                        List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                        if (sqlException != null)
                        {
                            resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                        }
                        else
                        {
                            resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                        }
                        string mostrarExc = "Ocurrió una excepción en la ejecución.";
                        if (resultado.Count > 0)
                        {
                            mostrarExc = resultado[0].DescripcionLocal;
                        }
                        return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                        throw;
                    }
                }

                objEpisodio.Accion = MODO;
                return crearWindowRegistro("Procesos/FirmarActoMedico", objEpisodio, "");

            }
            else
                return showMensajeBox("La contraseña es incorrecta.",
                    "Error al acceder", "ERROR");
        }

        public System.Web.Mvc.ActionResult eventoProcesoInteroperabilidad(string modo)
        {
            Log.Information("ProgramarKardexController - eventoProcesoInteroperabilidad - Entrar");

            List<ENTITY_MENSAJES> msgNoValido = null;
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;

            SS_HC_EpisodioAtencion obj = new SS_HC_EpisodioAtencion();

            obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            obj.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            obj.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            obj.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            obj.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
            obj.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;

            obj.Accion = "PROC_INTEROPERABILIDAD";

            var result = SvcEpisodioAtencion.setMantenimiento(obj);
            if (result > 0)
            {
                message = "El proceso se ejecutó exitosamente.";
            }
            else
            {
                indicaValidacionForm = true;
                tipoMsg = "ERROR";
                tituloMsg = "Error";
                message = "Ocurrió un error en el proceso.";
            }
            if (indicaValidacionForm)
            {
                //return showMensajeBox(message, tituloMsg, tipoMsg);
                return showMensajeNotify(tituloMsg, message, tipoMsg);
            }
            else
            {
                return showMensajeNotify(tituloMsg, message, tipoMsg);
            }

            //return this.Direct();
        }

        public System.Web.Mvc.ActionResult GrillaListadoMedicamentoPacientes(int start, int limit, string txtFecha1, string txtFecha2,
        string txtPaciente, string tipoEstado, string tipoBuscar)
        {
            Log.Information("ProgramarKardexController - GrillaListadoMedicamentoPacientes - Entrar");

            Boolean indicaValidacionForm = false;
            var objLista = new List<SS_FA_SolicitudProductoDetalle>();
            try
            {
                //ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_ATENCIONPACIENTEMEDICAMENTO>();

                var LocalEnty = new VW_ATENCIONPACIENTEMEDICAMENTO();


                LocalEnty.FechaCreacion = Convert.ToDateTime(getValorFiltroStr(txtFecha1));
                LocalEnty.IngresoFechaRegistro = Convert.ToDateTime(getValorFiltroStr(txtFecha1));
                LocalEnty.NombreCompleto = getValorFiltroStr(txtPaciente);
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);

                LocalEnty.UnidadReplicacion = SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.UnidadReplicacion;
                LocalEnty.IdPaciente = (int)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.EpisodioClinico = (int)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.EpisodioClinico;
                LocalEnty.IdEpisodioAtencion = (long)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.EpisodioAtencion;


                if (tipoEstado == "-1")
                {
                    LocalEnty.Estado = null;
                }
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;

                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }


                //  LocalEnty.Familia = "CONTARLISTAPAG";
                //  int cantElementos = svcVw_AtencionPacienteMedicamento.setMantenimiento(LocalEnty);
                //   if (cantElementos > 0)
                //  {
                LocalEnty.Familia = "LISTARPAG";
                Listar = svcVw_AtencionPacienteMedicamento.listarVwAtencionPacienteMedicamento(LocalEnty, inicio, final);

                SS_FA_SolicitudProductoDetalle obtemp;
                foreach (VW_ATENCIONPACIENTEMEDICAMENTO objEntity1 in Listar)
                {
                    if (Convert.ToInt32(Session["CANTIDAD"]) < objEntity1.Secuencia)
                    {
                        Session["CANTIDAD"] = objEntity1.Secuencia;
                    }

                    obtemp = new SS_FA_SolicitudProductoDetalle();
                    obtemp.UnidadReplicacion = objEntity1.UnidadReplicacion;
                    obtemp.IdEpisodioAtencion = objEntity1.IdEpisodioAtencion;
                    obtemp.IdPaciente = objEntity1.IdPaciente;
                    obtemp.EpisodioClinico = objEntity1.EpisodioClinico;
                    obtemp.Secuencia = objEntity1.Secuencia;
                    obtemp.UnidadReplicacionReferencia = objEntity1.UnidadReplicacion;
                    obtemp.IdEpisodioAtencionReferencia = objEntity1.IdEpisodioAtencion;
                    obtemp.IdPacienteReferencia = objEntity1.IdPaciente;
                    obtemp.EpisodioClinicoReferencia = objEntity1.EpisodioClinico;
                    obtemp.Cantidad = objEntity1.Cantidad;
                    obtemp.Linea = objEntity1.Linea;
                    obtemp.Familia = objEntity1.Familia;
                    obtemp.SubFamilia = objEntity1.SubFamilia;
                    obtemp.TipoComponente = objEntity1.TipoComponente;
                    obtemp.CodigoComponente = objEntity1.CodigoComponente;
                    obtemp.Estado = objEntity1.Estado;
                    obtemp.Accion = objEntity1.Accion;


                    objLista.Add(obtemp);



                }
                Session["HC_SolMedicamentoDetList"] = objLista;

                // }

                return this.Store(Listar);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - GrillaListadoMedicamentoPacientes - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                indicaValidacionForm = true;
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }

        public System.Web.Mvc.ActionResult SelectPersonaMedicamentoEpisodioEvento(String selection, string accion)
        {
            Log.Information("ProgramarKardexController - SelectPersonaMedicamentoEpisodioEvento - Entrar");


            //ENTITY_GLOBAL.Instance.NIVEL = 1;
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
            List<VW_ATENCIONPACIENTEMEDICAMENTO> ObjListar = (List<VW_ATENCIONPACIENTEMEDICAMENTO>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<VW_ATENCIONPACIENTEMEDICAMENTO>));
            //accion = "Nuevo";
            if (ObjListar.Count > 0)
            {
                Session["VW_ATENCIONPACIENTEMED_SELECC"] = ObjListar[0];
                ////TIPO DE ATENCION SELECCIONADA



                ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                ///ADD 09/15



                //ENTITY_GLOBAL.Instance.UnidadReplicacion = ObjListar[0].UnidadReplicacion;
                ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].EpisodioClinico;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].IdEpisodioAtencion;
                ENTITY_GLOBAL.Instance.NombreCompletoPaciente = ObjListar[0].NombreCompleto;//ADD cambios --/09/2015
                ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                ///ADD 09/15


                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;


            }
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult Save_Solicitud(String selectionArray1, String selectionArray2)
        {
            Log.Information("ProgramarKardexController - Save_Solicitud - Entrar");
            List<SS_FA_SolicitudProducto> ObjLista1 = new List<SS_FA_SolicitudProducto>();
            List<SS_FA_SolicitudProductoDetalle> ObjLista2 = new List<SS_FA_SolicitudProductoDetalle>();
            string mensage = "";
            if (selectionArray1.Trim().Length > 0)
            {
                try
                {
                    if (selectionArray1.Trim().Length > 0)
                    {
                        ObjLista1 = (List<SS_FA_SolicitudProducto>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray1, typeof(List<SS_FA_SolicitudProducto>));
                    }
                    if (selectionArray2.Trim().Length > 0)
                    {
                        ObjLista2 = (List<SS_FA_SolicitudProductoDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray2, typeof(List<SS_FA_SolicitudProductoDetalle>));
                    }

                    SS_FA_SolicitudProducto ObjSP;
                    SS_FA_SolicitudProductoDetalle ObjSPD;
                    SS_FA_SolicitudProducto cabeceraMed = new SS_FA_SolicitudProducto();
                    List<SS_FA_SolicitudProductoDetalle> listadetalleMed = new List<SS_FA_SolicitudProductoDetalle>();

                    foreach (SS_FA_SolicitudProducto objEntity1 in ObjLista1)
                    {
                        ObjSP = new SS_FA_SolicitudProducto();
                        ObjSP = objEntity1;

                        ObjSP.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        ObjSP.UsuarioCreacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                        ObjSP.FechaCreacion = DateTime.Now;

                        if (objEntity1.NumeroDocumento.Count() > 0)
                        {
                            ObjSP.Accion = "UPDATE";
                        }
                        else { ObjSP.Accion = "NUEVO"; }

                        cabeceraMed = ObjSP;
                    }

                    foreach (SS_FA_SolicitudProductoDetalle objEntity2 in ObjLista2)
                    {
                        ObjSPD = new SS_FA_SolicitudProductoDetalle();
                        ObjSPD = objEntity2;

                        ObjSPD.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        ObjSPD.UnidadReplicacionReferencia = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        ObjSPD.IdEpisodioAtencionReferencia = objEntity2.IdEpisodioAtencion;
                        ObjSPD.EpisodioClinicoReferencia = objEntity2.EpisodioClinico;
                        ObjSPD.UsuarioCreacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                        ObjSPD.FechaCreacion = DateTime.Now;
                        if (objEntity2.Accion == "NUEVO" || objEntity2.Accion == "UPDATE")
                        {
                            ObjSPD.Accion = "UPDATE";
                        }
                        else { ObjSPD.Accion = "NUEVO"; }
                        if (objEntity2.Version == "99")
                        {
                            ObjSPD.TipoComponente = "M";
                        }
                        listadetalleMed.Add(ObjSPD);
                    }
                    /********elimina**********/
                    if (Session["HC_SolMedicamentoDetListDELETE"] != null)
                    {
                        List<SS_FA_SolicitudProductoDetalle> listaDel = (List<SS_FA_SolicitudProductoDetalle>)Session["HC_SolMedicamentoDetListDELETE"];
                        foreach (var result2 in listaDel)
                        {
                            listadetalleMed.Add(result2);
                        }
                    }
                    /************/

                    int result = svcSS_FA_SolicitudProducto.setMantenimiento(cabeceraMed, listadetalleMed);

                    if (result > 0)
                    {
                        if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                        else mensage = " actualizó ";
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                        //ENTITY_GLOBAL.Instance.EpisodioAtencion = (int)SecuenciaMedica;
                        String mensaje = "Se " + mensage + " el Formulario satisfactoriamente. Código Transacción: " +
                            UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                            ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.PacienteID, "");

                        //X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + IdEpisodioAtencionID.ToString().Trim()).Show();
                        //ActivaDescativaButtonSave(true);                        
                        /*Session["HC_MedicamentoList"] = null;
                        Session["HC_MedicamentoDetalleList"] = null;
                        Session["HC_MedicamentoDetalleListDELETE"] = null;
                        eventoLoadPostFormulario(true, "storeExamenes0", null);
                        //ActivaDescativaButtonSave(true);
                        eventoPostFormulario(true, "");*/

                        return showMensajeNotify("Mensaje", mensaje, "INFO");
                    }
                    else
                    {
                        eventoPostFormulario(false, "");
                        return showMensajeNotify("Error", "Sucedió un error inesperado", "ERROR");
                    }
                }
                catch (Exception ex)
                {
                    Log.Information("ProgramarKardexController - Save_Solicitud - Bloque Catch");
                    Log.Error(ex, ex.Message);
                    //EventLog.GenerarLogError(ex);
                    var sqlException = ex.InnerException as SqlException;
                    var detalle = new MA_MiscelaneosDetalle();
                    detalle.ACCION = "ERRORES";
                    List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                    if (sqlException != null)
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                    }
                    else
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                    }
                    string mostrarExc = "Excepción genérica:" + ex.Message;
                    if (resultado.Count > 0)
                    {
                        mostrarExc = resultado[0].DescripcionLocal;
                    }
                    eventoPostFormulario(false, "");
                    return showMensajeNotify("Error", mostrarExc, "ERROR");
                    throw;
                }
            }
            return this.Direct();
        }


        public System.Web.Mvc.ActionResult Delete_SolicitudDetalle(String accion, String codigo, String secuencia)
        {
            Log.Information("ProgramarKardexController - Delete_SolicitudDetalle - Entrar");
            List<SS_FA_SolicitudProductoDetalle> listaDelete = new List<SS_FA_SolicitudProductoDetalle>();
            List<SS_FA_SolicitudProductoDetalle> listaSave = new List<SS_FA_SolicitudProductoDetalle>();
            SS_FA_SolicitudProductoDetalle objDelete = new SS_FA_SolicitudProductoDetalle();
            if (Session["HC_SolMedicamentoDetListDELETE"] != null)
            {
                listaDelete = (List<SS_FA_SolicitudProductoDetalle>)Session["HC_SolMedicamentoDetListDELETE"];
            }
            if (Session["HC_SolMedicamentoDetList"] != null && secuencia != null /*&& secuenciaMed != null*/)
            {
                listaSave = (List<SS_FA_SolicitudProductoDetalle>)Session["HC_SolMedicamentoDetList"];
                foreach (SS_FA_SolicitudProductoDetalle objEntity1 in listaSave)
                {
                    if (objEntity1.Secuencia == Convert.ToInt32(secuencia) &&
                        objEntity1.CodigoComponente == codigo)
                    {
                        if ((objEntity1.Accion + "").Trim() != "")
                        {
                            objDelete.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                            objDelete.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            objDelete.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                            objDelete.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                            /*objDelete.SecuenciaMedicamento = objEntity1.SecuenciaMedicamento;*/
                            objDelete.IdSolicitudProducto = objEntity1.IdSolicitudProducto;
                            objDelete.Secuencia = objEntity1.Secuencia;
                            objDelete.CodigoComponente = objEntity1.CodigoComponente;
                            objDelete.Accion = accion;
                            listaDelete.Add(objDelete);
                        }
                        //////////////                        
                        listaSave.Remove(objEntity1);
                        break;
                    }
                }
                Session["HC_SolMedicamentoDetListDELETE"] = listaDelete;
                Session["HC_SolMedicamentoDetList"] = listaSave;
            }
            return this.Direct();
        }


        /********* KARDEX ****************/

        public System.Web.Mvc.ActionResult GrillaListadoMedicamentoKardex(int start, int limit, string txtFecha1, string txtFecha2,
       string txtPaciente, string tipoEstado, string tipoBuscar)
        {
            Log.Information("ProgramarKardexController - GrillaListadoMedicamentoKardex - Entrar");
            Boolean indicaValidacionForm = false;
            try
            {
                //ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_ATENCIONPACIENTEMEDICAMENTO>();
                var NewLista = new List<VW_ATENCIONPACIENTEMEDICAMENTO>();
                var varLocal = new VW_ATENCIONPACIENTEMEDICAMENTO();

                var LocalEnty = new VW_ATENCIONPACIENTEMEDICAMENTO();

                LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                LocalEnty.FechaCreacion = Convert.ToDateTime(getValorFiltroStr(txtFecha1));
                LocalEnty.IngresoFechaRegistro = Convert.ToDateTime(getValorFiltroStr(txtFecha2));
                LocalEnty.NombreCompleto = getValorFiltroStr(txtPaciente);
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);
                LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                if (tipoEstado == "-1")
                {
                    LocalEnty.Estado = null;
                }
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;

                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }


                //  LocalEnty.Familia = "CONTARLISTAPAG";
                //  int cantElementos = svcVw_AtencionPacienteMedicamento.setMantenimiento(LocalEnty);
                //   if (cantElementos > 0)
                //  {
                LocalEnty.Familia = "LISTARKARDEX";
                Listar = svcVw_AtencionPacienteMedicamento.listarVwAtencionPacienteMedicamento(LocalEnty, inicio, final);
                // }
                int grupoAnt = 0;
                int countG = 0;
                foreach (VW_ATENCIONPACIENTEMEDICAMENTO objEnt in Listar) 
                {
                    varLocal = objEnt;
                    if (objEnt.GrupoMedicamento != grupoAnt & objEnt.GrupoMedicamento !=0) 
                    {
                        if (objEnt.GrupoMedicamento == null)
                        {
                            grupoAnt = 0;
                        }
                        else { 
                            grupoAnt = (int)objEnt.GrupoMedicamento; 
                        }                       
                        countG = 0;
                    }
                    if (objEnt.GrupoMedicamento == grupoAnt & objEnt.GrupoMedicamento != 0 & grupoAnt!=0 & countG==1) 
                    {
                        varLocal.Celular = "Ocultar";
                    }
                    if (objEnt.GrupoMedicamento == grupoAnt) {
                    countG = 1;
                    }
                    if(objEnt.CodigoOA != null)
                    {
                        //DateTime fechaBase = Convert.ToDateTime(getValorFiltroStr(txtFecha1));
                        //DateTime fechaEval = Convert.ToDateTime(objEnt.CodigoOA);
                        //DateTime newfechaBase = Convert.ToDateTime(fechaBase.Day + "/" + fechaBase.Month + "/" + fechaBase.Year);
                        //DateTime newfechaEval = Convert.ToDateTime(fechaEval.Day + "/" + fechaEval.Month + "/" + fechaEval.Year);

                        //if (newfechaEval < newfechaBase || newfechaEval == newfechaBase) 
                        //{ 
                        //    varLocal.Estado = 4;
                        //}
                                                
                    }

                   /* if (objEnt.CodigoOA)*/

                    
                    NewLista.Add(varLocal);
                }
               /* return this.Store(Listar);*/
                return this.Store(NewLista);
            }
            catch (Exception ex)
            {
                Log.Information("ProgramarKardexController - GrillaListadoMedicamentoKardex - Bloque Catch");
                Log.Error(ex, ex.Message);
                EventLog.GenerarLogError(ex);
                var sqlException = ex.InnerException as SqlException;
                var detalle = new MA_MiscelaneosDetalle();
                detalle.ACCION = "ERRORES";
                List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                if (sqlException != null)
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                }
                else
                {
                    resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                }
                string mostrarExc = "Excepción genérica:";
                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                indicaValidacionForm = true;
                return showMensajeNotify("Excepción", mostrarExc, "ERROR");
                throw;
            }
        }




        public System.Web.Mvc.ActionResult Save_Kardex(String selectionArray1, String selectionArray2)
        {
            Log.Information("ProgramarKardexController - Save_Kardex - Entrar");

            List<SS_HC_KardexEnfermeria> ObjLista1 = new List<SS_HC_KardexEnfermeria>();
            List<SS_HC_KardexEnfermeriaDetalle> ObjLista2 = new List<SS_HC_KardexEnfermeriaDetalle>();
            string mensage = "";
            if (selectionArray1.Trim().Length > 0)
            {
                try
                {
                    if (selectionArray1.Trim().Length > 0)
                    {
                        ObjLista1 = (List<SS_HC_KardexEnfermeria>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray1, typeof(List<SS_HC_KardexEnfermeria>));
                    }
                    if (selectionArray2.Trim().Length > 0)
                    {
                        ObjLista2 = (List<SS_HC_KardexEnfermeriaDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray2, typeof(List<SS_HC_KardexEnfermeriaDetalle>));
                    }

                    SS_HC_KardexEnfermeria ObjSP;
                    SS_HC_KardexEnfermeriaDetalle ObjSPD;
                    SS_HC_KardexEnfermeria cabeceraMed = new SS_HC_KardexEnfermeria();
                    List<SS_HC_KardexEnfermeriaDetalle> listadetalleMed = new List<SS_HC_KardexEnfermeriaDetalle>();

                    foreach (SS_HC_KardexEnfermeria objEntity1 in ObjLista1)
                    {
                        ObjSP = new SS_HC_KardexEnfermeria();
                        ObjSP = objEntity1;

                        ObjSP.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

                      

                        if (objEntity1.IdOrdenAtencion != 0)
                        {
                            ObjSP.UsuarioModificacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSP.FechaModificacion = DateTime.Now;
                            ObjSP.Accion = "UPDATE";
                        }
                        else {
                            ObjSP.UsuarioCreacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSP.FechaCreacion = DateTime.Now;
                            ObjSP.Accion = "NUEVO"; }

                        cabeceraMed = ObjSP;
                    }

                    foreach (SS_HC_KardexEnfermeriaDetalle objEntity2 in ObjLista2)
                    {
                        ObjSPD = new SS_HC_KardexEnfermeriaDetalle();
                        ObjSPD = objEntity2;

                        ObjSPD.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        ObjSPD.UnidadReplicacionReferencia = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        ObjSPD.IdEpisodioAtencionReferencia = objEntity2.IdEpisodioAtencion;
                        ObjSPD.EpisodioClinicoReferencia = objEntity2.EpisodioClinico;

                        if (objEntity2.FechaCorte != null & objEntity2.Estado == 4) 
                        {
                            ObjSPD.FechaCorte = DateTime.Now;
                        }

                        if (objEntity2.Accion == "NUEVO" || objEntity2.Accion == "UPDATE")
                        {
                            if (objEntity2.UsuarioModificacion != null)
                            {
                                var horas = DateTime.Parse(objEntity2.UsuarioModificacion);
                                var fechaincio = Convert.ToDateTime(objEntity2.HoraInicioProg);
                                fechaincio = fechaincio.AddHours(horas.Hour);

                                ObjSPD.HoraInicioProg = fechaincio;
                            }

                            ObjSPD.UsuarioModificacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSPD.FechaModificacion = DateTime.Now;
                            ObjSPD.Accion = "UPDATE";
                        }
                        else {
                            if (objEntity2.UsuarioModificacion != null) { 

                            var horas = DateTime.Parse(objEntity2.UsuarioModificacion);
                            DateTime fechaincio = Convert.ToDateTime(objEntity2.HoraInicioProg);
                            fechaincio = fechaincio.AddHours(horas.Hour);

                            ObjSPD.HoraInicioProg = fechaincio;
                            ObjSPD.UsuarioModificacion = null;
                            }
                            ObjSPD.UsuarioCreacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSPD.FechaCreacion = DateTime.Now;

                            ObjSPD.Accion = "NUEVO"; 
                        }
                        if (objEntity2.Version == "99")
                        {
                            ObjSPD.TipoComponente = "M";
                        }
                        listadetalleMed.Add(ObjSPD);
                    }
                    /********elimina**********/
                    if (Session["HC_SolMedicamentoDetListDELETE"] != null)
                    {
                        List<SS_HC_KardexEnfermeriaDetalle> listaDel = (List<SS_HC_KardexEnfermeriaDetalle>)Session["HC_SolMedicamentoDetListDELETE"];
                        foreach (var result2 in listaDel)
                        {
                            listadetalleMed.Add(result2);
                        }
                    }
                    /************/

                    int result = svcSS_HC_KardexEnfermeria.setMantenimiento(cabeceraMed, listadetalleMed);

                    if (result > 0)
                    {
                        if (ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "NUEVO") mensage = " registro ";
                        else mensage = " actualizó ";
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                        //ENTITY_GLOBAL.Instance.EpisodioAtencion = (int)SecuenciaMedica;
                        String mensaje = "Se " + mensage + " el Formulario satisfactoriamente. Código Transacción: " +
                            UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                            ENTITY_GLOBAL.Instance.EpisodioAtencion, ENTITY_GLOBAL.Instance.PacienteID, "");

                        //X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + mensage + ". Nro Atención : " + IdEpisodioAtencionID.ToString().Trim()).Show();
                        //ActivaDescativaButtonSave(true);                        
                        /*Session["HC_MedicamentoList"] = null;
                        Session["HC_MedicamentoDetalleList"] = null;
                        Session["HC_MedicamentoDetalleListDELETE"] = null;
                        eventoLoadPostFormulario(true, "storeExamenes0", null);
                        //ActivaDescativaButtonSave(true);
                        eventoPostFormulario(true, "");*/

                        return showMensajeNotify("Mensaje", mensaje, "INFO");
                    }
                    else
                    {
                        eventoPostFormulario(false, "");
                        return showMensajeNotify("Error", "Sucedió un error inesperado", "ERROR");
                    }
                }
                catch (Exception ex)
                {
                    //EventLog.GenerarLogError(ex);
                    var sqlException = ex.InnerException as SqlException;
                    var detalle = new MA_MiscelaneosDetalle();
                    detalle.ACCION = "ERRORES";
                    List<MA_MiscelaneosDetalle> resultado = new List<MA_MiscelaneosDetalle>();
                    if (sqlException != null)
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, sqlException.Number, 0);
                    }
                    else
                    {
                        resultado = SvcMiscelaneos.listarMA_MiscelaneosDetalle(detalle, ex.HResult, 0);
                    }
                    string mostrarExc = "Excepción genérica:" + ex.Message;
                    if (resultado.Count > 0)
                    {
                        mostrarExc = resultado[0].DescripcionLocal;
                    }
                    eventoPostFormulario(false, "");
                    return showMensajeNotify("Error", mostrarExc, "ERROR");
                    throw;
                }
            }
            return this.Direct();
        }





        /************************************/

        #endregion


    }
}
