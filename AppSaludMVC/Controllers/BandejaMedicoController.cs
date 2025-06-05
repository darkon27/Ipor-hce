using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Ext.Net;
using Ext.Net.MVC;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryReport;
using System.Data.SqlClient;
using SoluccionSalud.Service.UsuarioService;
using AppSaludMVC.HceService;
using System.Net;
using System.DirectoryServices.Protocols;
using SoluccionSalud.Service.ParametroService;

namespace AppSaludMVC.Controllers
{


    using SvcDiccionario = SoluccionSalud.Service.DiccionarioService.SvcDiccionario;
    using SvcSeguridad = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto;
    using SvcSeguridadConcepto = SoluccionSalud.Service.SeguridadConceptoService.SvcSeguridadConcepto;
    using SvcPersonaMast = SoluccionSalud.Service.PersonaMastService.SvcPersonaMast;
    using SvcMiscelaneos = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos;
    using SvcFormularios = SoluccionSalud.Service.FormulariosService.SvcFormularios;
    using SvcFormularioAnamnesisAP = SoluccionSalud.Service.FormulariosService.SvcFormularioAnamnesisAP;
    using SvcVw_Personapaciente = SoluccionSalud.Service.VW_PERSONAPACIENTEService.SvcVw_Personapaciente;
    using SvcVw_AtencionPaciente = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente;
    using SvcAsigMedico = SoluccionSalud.Service.AsigMedicoService.SvcAsigMedico;
    using SvcVWAsigMedico = SoluccionSalud.Service.VWAsigMedicoService.SvcVWAsigMedico;
    using SvcVw_Favoritos = SoluccionSalud.Service.WH_FavoritosService.SvcVW_FavoritosService;
    using SvcFavoritoNumero = SoluccionSalud.Service.FavoritoNumeroService.SvcFavoritoNumero;
    using SvcFavorito = SoluccionSalud.Service.FavoritoService.Svcfavorito;
    using SvcFavoritoDetalle = SoluccionSalud.Service.FavoritoDetalleService.SvcFavoritoDetalle;
    using SOA_AtencionesSpring = SoluccionSalud.Service.ServiciosAlternoSOA.SOA_AtencionesSpring;
    using SvcEpisodioAtencion = SoluccionSalud.Service.EpisodioAtencionService.SvcEpisodioAtencion;
    using SvcTabla = SoluccionSalud.Service.TablaService.SvcTabla;
    using SvcSG_Agente = SoluccionSalud.Service.SG_AgenteService.SvcSG_Agente;
    using SvcSeguridadAutorizacion = SoluccionSalud.Service.SeguridadAutorizacionService.SvcSeguridadAutorizacion;
    using SvcProcedimientoEjecucion = SoluccionSalud.Service.ProcedimientoEjecucionService.SvcProcedimientoEjecucion;
    using SvcUnidadServicio = SoluccionSalud.Service.UnidadServicioService.SvcUnidadServicio;
    using SvcEspecialidad = SoluccionSalud.Service.EspecialidadService.SvcEspecialidad;
    using SvcTABLAFORMATOVALIDACION = SoluccionSalud.Service.TABLAFORMATOVALIDACIONService.SvcTABLAFORMATOVALIDACION;
    using SvcPaciente = SoluccionSalud.Service.VW_PERSONAPACIENTEService.SP_SS_GE_PacienteService;
    using SvcEpisodioClinico = SoluccionSalud.Service.EpisodioClinicoService.SvcEpisodioClinico;
    using SvcPacDoc = SoluccionSalud.Service.PacDocService.SvcPacDoc;
    using SvcSSHCUbicacion = SoluccionSalud.Service.SSHCUbicacionService.SvcSSHCUbicacion;
    using SvcAgrupadorAtencionVigente = SoluccionSalud.Service.ADICIONAL_Service.SvcAgrupadorAtencionVigente;
    using ServiciosRules = SoluccionSalud.Service.AccionesServiceRules.ServiciosRules;
    using SvcRegistroAcompanante = SoluccionSalud.Service.RegistrarAcompananteService.SvcRegistroAcompanante;
    using SvcNotificacion = SoluccionSalud.Service.NotificacionService.SvcNotificacion;
    using SvcEpisodioNotificaciones = SoluccionSalud.Service._FormularioNuevo.SvcEpisodioNotificaciones;
    using svcVw_AtencionPacienteMedicamento = SoluccionSalud.Service.VW_ATENCIONPACIENTEMEDICAMENTOS.svcVw_AtencionPacienteMedicamento;
    using SvcSG_Opcion = SoluccionSalud.Service.SG_OpcionService.SvcSG_Opcion;
    using SvcV_EpisodioAtenciones = SoluccionSalud.Service.V_EpisodioAtencionesService.SvcV_EpisodioAtenciones;
    using svcSS_FA_SolicitudProducto = SoluccionSalud.Service.SS_FA_SolicitudProductos.svcSS_FA_SolicitudProducto;


    using System.Configuration;
    using System.Data;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;
    using SoluccionSalud.Service._FormularioNuevo;
    using SoluccionSalud.Service.VWEspecialidadMedicoService;
    using System.Threading;
    using System.Threading.Tasks;
    using Serilog;
    using System.ComponentModel;
    //using DotNetOpenAuth.OpenId.Extensions.AttributeExchange.WellKnownAttributes;
    using System.Collections;
    using System.Web.UI;
    using System.Security.Policy;
    using System.Web.Http.OData;
    using CrystalDecisions.CrystalReports.Engine;
    using System.Net.Http;
    using System.Net.Http.Formatting;
    using SoluccionSalud.Service.AuditoriaService;
    using System.Web.Script.Serialization;
    using Ext.Net.Utilities.Inflatr;
    using WebGrease.Activities;
    using Microsoft.Ajax.Utilities;

    //using AppSaludMVC.Controllers.HistoriaClinicaWestController;

    public class BandejaMedicoController : ControllerGeneral
    {
        //
        // GET: /BandejaMedico/
        public BandejaMedicoController()
        {


        }

        public System.Web.Mvc.ActionResult Index()
        {
            Log.Information("Entra a BandejaMedicoController");
            ENTITY_GLOBAL.Instance.NombreCompletoPaciente = null;
            Session["TECNOLOGO_MIKASA"] = null;
            Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = null;
            Session["NOMBREPACIENTE_HEAD"] = null;
            Session["EDADPACIENTE_HEAD"] = null;
            ENTITY_GLOBAL.Instance.VALOR_ESPECIALIDAD = null;
            if (ENTITY_GLOBAL.Instance != null)
            {
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            }
            ENTITY_GLOBAL.Instance.COPIADO_DISABLED = "BN";
            ENTITY_GLOBAL.Instance.OBJETOS_F5 = null;
            return View();
        }
        public PartialViewResult reloadPanelWestC()
        {
            Log.Information("BandejaMedicoController - reloadPanelWestC");
            string containerId = "";
            if (Session["containerId_ACTUAL_West"] != null)
            {
                containerId = (string)Session["containerId_ACTUAL_West"];
                return PanelWest(containerId);
            }
            else
            {
                return PanelWest("");
            }
        }
        public PartialViewResult PanelWest(string containerId)
        {
            Log.Information("BandejaMedicoController - PanelWest");
            Session["containerId_ACTUAL_West"] = containerId;
            return new PartialViewResult
            {
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                Model = ENTITY_GLOBAL.Instance,
                ViewName = "PanelWest",
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }
        public PartialViewResult PanelEast(string containerId)
        {
            Log.Information("BandejaMedicoController - PanelEast");
            return new PartialViewResult
            {
                Model = ENTITY_GLOBAL.Instance,
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }

        public PartialViewResult reloadPanelNorthC()
        {
            Log.Information("BandejaMedicoController - reloadPanelNorthC");
            string containerId = "";
            if (Session["containerId_ACTUAL_North"] != null)
            {
                containerId = (string)Session["containerId_ACTUAL_North"];
                return PanelNorth(containerId);
            }
            else
            {
                return PanelNorth("");
            }
        }
        public PartialViewResult PanelNorth(string containerId)
        {
            //////////////////////////////////////////////
            /****RECARGAR PARÁMETROS UTILIZADOS***/
            Log.Information("BandejaMedicoController - reloadPanelNorthC");
            //UTILES_MENSAJES.loadParametro_Formulario("ACTIVOSOA", "", true);
            ///**PARÁMETRO  QUE PERMITE O NO LA CONSULTA AL MOTOR DE REGLAS */
            //UTILES_MENSAJES.loadParametro_Formulario("ACTIVORULE", "", true);

            Session["containerId_ACTUAL_North"] = containerId;

            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            List<MA_MiscelaneosDetalle> listInfoSession = new List<MA_MiscelaneosDetalle>();
            MA_MiscelaneosDetalle InfoSession = new MA_MiscelaneosDetalle();
            InfoSession.ACCION = "INFOSESSION";
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
            List<SS_FA_NotificacionDetalle> lstNotificacion = new List<SS_FA_NotificacionDetalle>();
            lstNotificacion = SvcMiscelaneos.listarNotificaciones();
            obj.lstNotificacion = lstNotificacion;

            if (ENTITY_GLOBAL.Instance.NOMBREUSU_GENERICO != null)
            {

                obj.CompaniaSocio = listInfoSession[0].Compania; //CompaniaSocio desc
                obj.Sucursal = listInfoSession[0].CodigoTabla; //Sucursal desc
                obj.IngresoAplicacionCodigo = listInfoSession[0].AplicacionCodigo; //Aplicacion desc

                obj.DireccionReferencia = listInfoSession[0].ValorCodigo1; //ESTABLECIMIENTO
                obj.CentroCostos = listInfoSession[0].ValorCodigo2;     //PERIODO
                obj.DescripcionHistoria = listInfoSession[0].ValorCodigo3;  //DB

                obj.USUARIO = ENTITY_GLOBAL.Instance.USUARIO_GENERICO;//USUARIO
                obj.NombreCompleto = ENTITY_GLOBAL.Instance.NOMBREUSU_GENERICO; //NOMBRE EMPLEADO
                obj.TipoTrabajador = listInfoSession[0].ValorCodigo4; //TipoTrabajador desc 
                obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDEMPLEADO_GENERICO);
                ENTITY_GLOBAL.Instance.IDAGENTEGENERICO = Convert.ToInt32(listInfoSession[0].CodigoElemento);


            }
            else
            {
                ENTITY_GLOBAL.Instance.IDAGENTEGENERICO = null;
                //ver stored: [SP_SS_HC_MA_MiscelaneosDetalle_LISTAR]
                if (listInfoSession.Count > 0)
                {
                    obj.CompaniaSocio = listInfoSession[0].Compania; //CompaniaSocio desc
                    obj.Sucursal = listInfoSession[0].CodigoTabla; //Sucursal desc
                    obj.IngresoAplicacionCodigo = listInfoSession[0].AplicacionCodigo; //Aplicacion desc

                    obj.DireccionReferencia = listInfoSession[0].ValorCodigo1; //ESTABLECIMIENTO
                    obj.CentroCostos = listInfoSession[0].ValorCodigo2;     //PERIODO
                    obj.DescripcionHistoria = listInfoSession[0].ValorCodigo3;  //DB

                    obj.TipoTrabajador = listInfoSession[0].ValorCodigo4; //TipoTrabajador desc                
                    obj.USUARIO = listInfoSession[0].UltimoUsuario;//USUARIO
                    obj.NombreCompleto = listInfoSession[0].DescripcionLocal; //NOMBRE EMPLEADO
                    obj.Persona = Convert.ToInt32(listInfoSession[0].ValorEntero1);

                }

            }
            //    var tipoAtencion = ENTITY_GLOBAL.Instance.USUARIO == "ENFEMER" ? "PanelNorthEmergencia" : "PanelNorth";
            var tipoAtencion = "";
            var USUARIO = ENTITY_GLOBAL.Instance.USUARIO;
            var ESPECIALIDADUSU = ENTITY_GLOBAL.Instance.USUARIOESP;
            var CODIGOBANDEJA = ENTITY_GLOBAL.Instance.COD_BANDEJA;
            var enfermer = ENTITY_GLOBAL.Instance.EnfermeraNombre;

            if (ENTITY_GLOBAL.Instance.USUARIO == "ENFEMER")
            {
                tipoAtencion = "PanelNorthEmergencia";
            }
            else if (ENTITY_GLOBAL.Instance.VALIDAR_PANEL_NORT != null)
            {
                tipoAtencion = "PanelNorthEmergencia";
            }
            else
            {
                tipoAtencion = "PanelNorth";
            }

            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = tipoAtencion,
                WrapByScriptTag = false,
                Model = obj
            };
        }

        public PartialViewResult PanelSouth(string containerId)
        {
            Log.Information("BandejaMedicoController - PanelSouth");
            Log.Debug("BandejaMedicoController - PanelSouth - containerId {A}", containerId);
            var LocalEnty = new SEGURIDADCONCEPTO();
            LocalEnty.ACCION = "CONCEPTOSSEGURIDADPROC";
            LocalEnty.ULTIMOUSUARIO = ENTITY_GLOBAL.Instance.USUARIO;
            //LocalEnty.GRUPO = "";
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelSouth",
                WrapByScriptTag = false,
                Model = LocalEnty
            };
        }
        public PartialViewResult LoadFormatos(string containerId, string text)
        {
            Log.Information("BandejaMedicoController - LoadFormatos");
            Log.Debug("BandejaMedicoController - LoadFormatos - containerId {A},text {B}", containerId, text);

            ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;

            var UrlFormato = "PanelCentralBlanco";
            var model = new SEGURIDADCONCEPTO();
            var objVistaSeguridad = new SS_CHE_VistaSeguridad();
            objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
            objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            objVistaSeguridad.Accion = "DATOSFORMULARIO";
            objVistaSeguridad.IdOpcion = Convert.ToInt32(text.Trim());
            var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);

            if (resulListado.Count > 0)
            {
                switch (resulListado[0].IndicadorFormato)
                {
                    case 2:
                        UrlFormato = "PanelCenter"; //resulListado[0].CodigoFormato;
                        break;
                    case 3:
                        UrlFormato = "PanelCenterUrl";
                        break;
                    default:
                        UrlFormato = "PanelCentralBlanco";
                        break;
                }
                if (resulListado[0].CodigoFormato == null)
                {
                    UrlFormato = "PanelCentralBlanco";
                }
                else
                {
                    //ADD
                    ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL = resulListado[0].IdOpcion;

                    model.CONCEPTO = resulListado[0].CodigoFormato.Trim() + "_View";
                    model.DESCRIPCION = resulListado[0].NombreOpcion;
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
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                    Session["RecursosActivos"] = resulListado;
                    if (resulListado.Count > 0)
                    {
                        ENTITY_GLOBAL.Instance.MENUREC_CODIGO = resulListado[0].Nombre;
                        ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = resulListado[0].DescripcionAgente;
                        ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
                        if (ENTITY_GLOBAL.Instance.MENUREC_CODIGO == "MM000")
                        {
                            ENTITY_GLOBAL.Instance.indicadorAuxiliar = true;
                        }
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.MENUREC_CODIGO = "0000";
                        ENTITY_GLOBAL.Instance.MENUREC_DESCRIPCION = "SIN RECURSOS";
                    }


                }

            }


            //ANTES DE MOSTRAR
            setCodigoFormatosPaginas("GENERAL", text);
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
        public StoreResult ArbolBandejaMedico(string node, string filtro)
        {
            //Log.Information("BandejaMedicoController - ArbolBandejaMedico");
            //Log.Debug("BandejaMedicoController - PanelSouth - node {A} filtro {B}", node, filtro);

            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                if (ENTITY_GLOBAL.Instance.USUARIO_GENERICO != null)
                {
                    ENTITY_GLOBAL.Instance.USUARIO = ENTITY_GLOBAL.Instance.USUARIO_GENERICO;
                    ENTITY_GLOBAL.Instance.IDAGENTE = ENTITY_GLOBAL.Instance.IDAGENTE_GENERICO;
                }
                else
                {
                    ENTITY_GLOBAL.Instance.USUARIO = ENTITY_GLOBAL.Instance.USUARIO;
                    ENTITY_GLOBAL.Instance.IDAGENTE = ENTITY_GLOBAL.Instance.IDAGENTE;
                }
                //  ENTITY_GLOBAL.Instance.USUARIO = ENTITY_GLOBAL.Instance.USUARIO_GENERICO;
                // ENTITY_GLOBAL.Instance.IDAGENTE = ENTITY_GLOBAL.Instance.IDAGENTE_GENERICO;

            }

            var objMiscl = new MA_MiscelaneosDetalle();
            List<MA_MiscelaneosDetalle> resulMiscelaneosTitulo = new List<MA_MiscelaneosDetalle>();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new SEGURIDADCONCEPTO();


            objMiscl.ACCION = "COMBOSGENERICOS";
            objMiscl.AplicacionCodigo = "CG";
            objMiscl.CodigoTabla = "TECNOSERVICIO";
            objMiscl.ValorCodigo5 = ENTITY_GLOBAL.Instance.USUARIO;
            resulMiscelaneosTitulo = ENTITY_GLOBAL.SESSIONlistaTECNOSERVICIO;
            //resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);

            if (objMiscl.CodigoTabla == "TECNOSERVICIO" && resulMiscelaneosTitulo.Count > 0)
            {
                ENTITY_GLOBAL.Instance.ValorServicioTecno = Convert.ToInt32(resulMiscelaneosTitulo[0].ValorCodigo1);
            }
            else
            {
                ENTITY_GLOBAL.Instance.ValorServicioTecno = 0;
            }


            NodeCollection nodes = new Ext.Net.NodeCollection();
            var objVistaSeguridad = new SS_CHE_VistaSeguridad();
            if (ENTITY_GLOBAL.Instance.NIVEL == 1)
            {
                objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;
                objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
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
                var p = this.GetCmp<TreePanel>("treepanel");

                objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;
                objVistaSeguridad.IdOpcionPadre = Convert.ToInt32(node.Trim());
                objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                objVistaSeguridad.Accion = "LISTAPROCESOS";
                objVistaSeguridad.IndicadorMultiple = null;
                objVistaSeguridad.Nivel = 2;
                var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);
                foreach (var resulenti in resulListado)
                {
                    Node asyncNode = new Node();
                    asyncNode.Text = resulenti.NombreOpcion;
                    asyncNode.NodeID = resulenti.IdOpcion.ToString().Trim();
                    asyncNode.Href = "javascript:myFunction('" + resulenti.NombreOpcion + "')";
                    asyncNode.Leaf = resulenti.TipoIcono > 1 ? true : false;
                    if (resulenti.TipoIcono == 2) asyncNode.Icon = Ext.Net.Icon.UserComment2;
                    if (resulenti.TipoIcono == 3) asyncNode.Icon = Ext.Net.Icon.UserGrayCool;
                    if (resulenti.TipoIcono == 4) asyncNode.Icon = Ext.Net.Icon.UserAlert;
                    if (resulenti.TipoIcono == 5) asyncNode.Icon = Ext.Net.Icon.UserTick;
                    if (resulenti.TipoIcono == 6) asyncNode.Icon = Ext.Net.Icon.UserGo;

                    if (resulenti.TipoIcono == 10) asyncNode.Icon = Ext.Net.Icon.UserEdit; //CIRUGÍA
                    if (resulenti.TipoIcono == 11) asyncNode.Icon = Ext.Net.Icon.UserRed; //EMERGENCIA
                    if (resulenti.TipoIcono == 12) asyncNode.Icon = Ext.Net.Icon.UserSuit; //HOSPITALIZACIÓN
                    if (resulenti.TipoIcono == 13)
                    {
                        //asyncNode.IconFile = "D:/jaav/trabajo/SALUDHCE/Workspace_jaavHCE/AppSaludMVC/resources/images/medicocirugia.png";
                        //asyncNode.IconCls = "medicocirugia-icon";
                        asyncNode.Icon = Ext.Net.Icon.UserEarth; // AMBULATORIO
                    }

                    /*
                    Ext.Net.Icon iconXX = new Ext.Net.Icon() { 
                        Ur
                    };*/




                    nodes.Add(asyncNode);
                }
                ENTITY_GLOBAL.Instance.NIVEL = 2;
            }
            Log.Information("BandejaMedicoController - ArbolBandejaMedico - Salir");
            return this.Store(nodes);

        }
        public System.Web.Mvc.ActionResult validarCambiosFormulario(string containerId, string text)
        {
            Log.Information("BandejaMedicoController - validarCambiosFormulario - Entrar");
            if (ENTITY_GLOBAL.Instance.indicadorAuxiliar)
            {
                if ((ENTITY_GLOBAL.Instance.CONCEPTO + "").Trim() != (text + "").Trim())
                {
                    return showMensajeConfirmacion("Confirmación",
                         "Existen modificaciones sin guardar. ¿Desea salir del formulario " +
                                ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION + "?",
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
                ENTITY_GLOBAL.Instance.FECHABANDEJADISPENSACION = DateTime.Now;
                ENTITY_GLOBAL.Instance.CODIGOOADISPENSACION = null;

                var objVistaSeguridad = new SS_CHE_VistaSeguridad();
                objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                objVistaSeguridad.Accion = "DATOSFORMULARIO";
                objVistaSeguridad.IdOpcion = Convert.ToInt32(text.Trim());
                var resulListado = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);

                if ((resulListado[0].CodigoFormato + "").Trim() == "CCEP9009" || (resulListado[0].CodigoFormato + "").Trim() == "CCEP9917" || (resulListado[0].CodigoFormato + "").Trim() == "CCEP9020")
                {
                    ENTITY_GLOBAL.Instance.VALIDAR_PANEL_NORT = resulListado[0].CodigoFormato;
                }
                else
                {
                    ENTITY_GLOBAL.Instance.VALIDAR_PANEL_NORT = null;
                }


                if ((resulListado[0].CodigoFormato + "").Trim() == "CCEP0103")
                {
                    ENTITY_GLOBAL.Instance.MODULO = "GS";
                    ENTITY_GLOBAL.Instance.OPCION_PADRE = "3033";//OBS: HArdcode: poner en parámetro
                    return this.RedirectToAction("Index", "Gestion");
                }
                else
                {
                    return LoadFormatos(containerId, text);
                }

            }
        }

        [DirectMethod(Namespace = "confirmacionFormX")]
        public System.Web.Mvc.ActionResult showMensajeConfirmacion(String titulo, String message,
            String textSI, String textNO,
            String handlerSI, String handlerNO, String handlerCancel)
        {
            Log.Information("BandejaMedicoController - showMensajeConfirmacion - Entrar");
            Log.Debug("BandejaMedicoController - showMensajeConfirmacion - titulo {A}, message {B}, textSI {C}, textNO {D}," +
                " handleSI {E}, handlerNO {F}, handlerCancel {G}", titulo, message, textSI, textNO, handlerSI, handlerNO, handlerCancel);
            //Tipo: {"INFO", "WARNING", "ERROR", "QUESTION"}
            //X.Msg.Notify(titulo, message).Show();
            NotificationAlignConfig Align = new NotificationAlignConfig()
            {
                OffsetY = -300,
            };
            X.Msg.Confirm(titulo, message, new MessageBoxButtonsConfig
            {
                Yes = new MessageBoxButtonConfig
                {
                    Handler = "" + handlerSI,
                    Text = textSI
                },
                No = new MessageBoxButtonConfig
                {
                    Handler = "" + handlerNO,
                    Text = textNO
                }
                ,
                Cancel = new MessageBoxButtonConfig
                {
                    Handler = "" + handlerCancel,
                    Text = "Cancelar"

                }
            }).Show();
            //return this.Store("1");
            return this.Direct();

        }
        #region Registos_Formarios
        public System.Web.Mvc.ActionResult CCEP7001_View()
        {
            Log.Information("BandejaMedicoController - CCEP7001_View ");
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP7002_View()
        {
            Log.Information("BandejaMedicoController - CCEP7002_View ");
            var txtMedicoNom = X.GetCmp<TextField>("txtMedico");
            if (ENTITY_GLOBAL.Instance.PERFILADMIN == -2)
            {
                txtMedicoNom.SetValue("");
            }
            else
            {
                txtMedicoNom.SetValue(ENTITY_GLOBAL.Instance.MedicoNombre);
                //Session["NOMBRE_MEDICO"] = objUsuario.Nombre;
                txtMedicoNom.SetValue((string)Session["NOMBRE_MEDICO"]);
            }
            return View();
        }

        /******************************************************************/

        public System.Web.Mvc.ActionResult CCEP7007_View()
        {
            Log.Information("BandejaMedicoController - CCEP7007_View ");
            var txtMedicoNom = X.GetCmp<TextField>("txtMedico");
            if (ENTITY_GLOBAL.Instance.CODIGOPERFIL == "AUDITORIA_SANNA")
            {
                txtMedicoNom.SetValue("ARIAS OTAROLA , MANUEL WILLIAM");
            }
            else
            {
                txtMedicoNom.SetValue(ENTITY_GLOBAL.Instance.MedicoNombre);
                //Session["NOMBRE_MEDICO"] = objUsuario.Nombre;
                txtMedicoNom.SetValue((string)Session["NOMBRE_MEDICO"]);
            }
            return View("CCEP7007_View", ENTITY_GLOBAL.Instance);//   
        }
        /***********************ADMINISTRAR FAVORITO***********************/
        public System.Web.Mvc.ActionResult CCEP7003_View()
        {
            Log.Information("BandejaMedicoController - CCEP7003_View ");

            return View("AdministrarFavoritos/CCEP7003_View");
        }

        public System.Web.Mvc.ActionResult getGrillaFavoritoGrupo(int start, int limit,
       string descripcion, string favorito, string mnemotecnico, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaFavoritoGrupo ");
            Log.Debug("BandejaMedicoController - getGrillaFavoritoGrupo - start {A}, limit {B}, descripcion {C}, favorito {D}," +
            " mnemotecnico {E}, tipoBuscar {F}", start, limit, descripcion, favorito, mnemotecnico, tipoBuscar);
            ENTITY_GLOBAL.Instance.GRUPO = "";
            var Listar = new List<vw_favoritos>();

            var LocalEnty = new vw_favoritos();

            LocalEnty.IdFavorito = (getValorFiltroInt(favorito) != null ? Convert.ToInt32(getValorFiltroInt(favorito)) : 0);
            LocalEnty.Descripcion = getValorFiltroStr(descripcion);
            LocalEnty.Mnemotecnico = getValorFiltroStr(mnemotecnico);
            LocalEnty.IdAgente = ENTITY_GLOBAL.Instance.IDAGENTE;
            int inicio = (start == 0 ? start : start + 1);
            int final = start + limit;

            if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }
            LocalEnty.Accion = "LISTARGRUPO";
            int cantElementos = SvcVw_Favoritos.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {
                LocalEnty.Accion = "LISTARGRUPO";
                Listar = SvcVw_Favoritos.listarvw_favoritos(LocalEnty, inicio, final);
            }
            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult GrupoFavoritoRegistro(String MODO, int id, int nro)
        {
            Log.Information("BandejaMedicoController - GrupoFavoritoRegistro - Entrar");
            Log.Debug("BandejaMedicoController - GrupoFavoritoRegistro - MODO {A}, id {B}, nro {C}", MODO, id, nro);
            var Listar = new List<SS_HC_FavoritoNumero>();

            SS_HC_FavoritoNumero objFiltro = new SS_HC_FavoritoNumero();
            if (MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER")
            {
                objFiltro.Accion = "LISTAR";
                objFiltro.IdFavorito = id;
                objFiltro.NumeroFavorito = nro;
                Listar = SvcFavoritoNumero.listarFavoritoNumero(objFiltro, 0, 0);
                if (Listar.Count == 1)
                {
                    foreach (SS_HC_FavoritoNumero objEntity in Listar)
                    {
                        objFiltro = objEntity;
                    }
                }
            }
            else if (MODO == "NUEVO")
            {
                objFiltro.Accion = "NUEVO";
                //  objFiltro.IdFavorito = id;
            }
            objFiltro.Accion = MODO;
            Log.Information("BandejaMedicoController - GrupoFavoritoRegistro - Salir -  parametro objFiltro.Accion {A}", objFiltro.Accion);
            return crearWindowRegistro("AdministrarFavoritos/GrupoFavoritoRegistro", objFiltro, "");
        }
        public System.Web.Mvc.ActionResult save_Grupo(SS_HC_FavoritoNumero objFiltro, String MODO, String idWindow)
        {
            Log.Information("BandejaMedicoController - save_Grupo - Entrar");
            Log.Debug("BandejaMedicoController - save_Grupo - objFiltro {A}, MODO {B}, idWindow {C}", objFiltro, MODO, idWindow);
            List<ENTITY_MENSAJES> msgNoValido = null;
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            if (objFiltro != null)
            {
                ////VALIDACIÓN
                objFiltro.Accion = MODO;
                msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objFiltro, UTILES_MENSAJES.FORM_MSFAVORITONUMERO);
                if (msgNoValido.Count > 0)
                {
                    message = msgNoValido[0].DESCRIPCION;
                    tipoMsg = "WARNING";
                    tituloMsg = "Advertencia";
                    indicaValidacionForm = true;
                }
                else
                {
                    if (MODO == "NUEVO")
                    {
                        objFiltro.Accion = "INSERT";
                        accion = "registró";
                    }
                    else if (MODO == "UPDATE")
                    {
                        objFiltro.Accion = "UPDATE";
                        accion = "modificó";
                    }
                    else if (MODO == "DELETE")
                    {
                        objFiltro.Accion = "DELETE";
                        accion = "eliminó";
                    }
                    else
                    {
                        tipoMsg = "WARNING";
                        message = "No se encontró el MODO.";
                        tituloMsg = "Advertencia";
                    }
                    try
                    {
                    }
                    catch (Exception e)
                    {
                        Log.Information("BandejaMedicoController - save_Grupo - Bloque Catch");
                        Log.Error(e, e.Message);
                        X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                    }
                    objFiltro.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objFiltro.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objFiltro.Version = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                    idResultado = SvcFavoritoNumero.setMantenimiento(objFiltro);

                    if (idResultado > 0)
                    {
                        message = "Se " + accion + " el  usuario (" + objFiltro.Descripcion + ") satisfactoriamente.";
                    }
                    else
                    {
                        tipoMsg = "ERROR";
                        message = "No se pudo guadar los cambios. Sucedio un error en la operación.";
                        tituloMsg = "Error";
                    }
                }
            }
            else
            {
                tipoMsg = "ERROR";
                message = "No se pudo guadar los cambios. No se recibió el objeto vinculado.";
                tituloMsg = "Error";
            }
            objFiltro.Accion = "INFO";
            if (indicaValidacionForm)
            {
                return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinal");
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
            }
        }
        public System.Web.Mvc.ActionResult postWindowGrupoFavorito(String id)
        {
            Log.Information("BandejaMedicoController - postWindowGrupoFavorito - Entrar");
            Log.Debug("BandejaMedicoController - postWindowGrupoFavorito - id {A}", id);
            SS_HC_Favorito objAg = new SS_HC_Favorito();
            var Listar = new List<SS_HC_Favorito>();

            var field = X.GetCmp<TextField>("tfFavoritoDesc");
            if (field != null)
            {
                objAg.Accion = "LISTAR";
                objAg.IdFavorito = (getValorFiltroInt(id) != null ? Convert.ToInt32(getValorFiltroInt(id)) : 0);
                Listar = SvcFavorito.listarFavorito(objAg, 0, 0);
                if (Listar.Count == 1)
                {
                    foreach (SS_HC_Favorito objEntity in Listar)
                    {
                        objAg = objEntity;
                        field.SetValue(objAg.Descripcion);
                    }
                }
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult AgregarDetalleFavorito(String MODO, int id, int nro)
        {
            Log.Information("BandejaMedicoController - AgregarDetalleFavorito - Entrar");
            Log.Debug("BandejaMedicoController - save_Grupo - MODO {A}, id {B}, nro {C}", MODO, id, nro);
            var Listar = new List<vw_favoritos>();

            vw_favoritos obj = new vw_favoritos();
            if (id != null)
            {
                obj.Accion = "LISTARNUEVO";
                obj.IdFavorito = id;
                obj.NumeroFavorito = nro;

                Listar = SvcVw_Favoritos.listarvw_favoritos(obj, 0, 0);
                if (Listar.Count > 0)
                {
                    foreach (vw_favoritos objEntity in Listar)
                    {
                        obj = objEntity;
                    }
                }
            }
            else if (MODO == "NUEVO")
            {
                obj.Accion = "NUEVO";
            }
            Session["DataDetalleFavDelete"] = null;
            Session["DataDetalleFavSave"] = null;
            return crearWindowRegistro("AdministrarFavoritos/AgregarDetalleFavorito", obj, "");
        }
        public System.Web.Mvc.ActionResult getGrillaFavoritoDetalle(int start, int limit, String id, String numero, String descripcion, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaFavoritoDetalle - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaFavoritoDetalle - start {A}, limit {B}, id {C},numero {D}, descripcion {E}, tipoBuscar {F}  "
                , start, limit, id, numero, descripcion, tipoBuscar);
            ENTITY_GLOBAL.Instance.GRUPO = "";
            var Listar = new List<SS_HC_FavoritoDetalle>();

            var LocalEnty = new SS_HC_FavoritoDetalle();

            LocalEnty.IdFavorito = Convert.ToInt32(getValorFiltroInt(id));
            LocalEnty.NumeroFavorito = Convert.ToInt32(getValorFiltroInt(numero));
            LocalEnty.ValorTexto1 = getValorFiltroStr(descripcion);

            int inicio = (start == 0 ? start : start + 1);
            int final = start + limit;

            if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

            LocalEnty.Accion = "CONTARLISTAPAG";
            int cantElementos = SvcFavoritoDetalle.setMantenimiento(LocalEnty, 0, 0);
            if (cantElementos > 0)
            {
                LocalEnty.Accion = "LISTARPAG";
                Listar = SvcFavoritoDetalle.listarFavoritoDetalle(LocalEnty, inicio, final, 0, 0);
            }

            return this.Store(Listar, cantElementos);
        }
        public StoreResult GetListarBusquedaServicios(int start, int limit, string tipofiltro, string tipoBuscar, string Linea, string Familia, string descripciones)
        {
            Log.Information("BandejaMedicoController - GetListarBusquedaServicios - Entrar");
            Log.Debug("BandejaMedicoController - GetListarBusquedaServicios - start {A}, limit {B}, tipofiltro {C},tipoBuscar {D}, Linea {E}, Familia {F}. descripciones {G} "
                , start, limit, tipofiltro, tipoBuscar, Linea, Familia, descripciones);
            ENTITY_GLOBAL.Instance.GRUPO = "";

            var Listar = new List<MA_MiscelaneosDetalle>();
            var LocalEnty = new MA_MiscelaneosDetalle();
            int cantElementos = 0;


            LocalEnty.CodigoTabla = getValorFiltroStr(tipofiltro);
            LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.CONCEPTO;
            LocalEnty.ValorCodigo4 = getValorFiltroStr(Linea);
            LocalEnty.ValorCodigo5 = getValorFiltroStr(Familia);
            LocalEnty.ValorCodigo2 = getValorFiltroStr(descripciones);

            int ini = (start == 0 ? start : start + 1);
            int fin = start + limit;

            if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }

            LocalEnty.ACCION = "BUSCARLINEAFAMILIA";
            cantElementos = SvcMiscelaneos.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {
                LocalEnty.ACCION = "BUSCARLINEAFAMILIA";
                Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(LocalEnty, ini, fin);
            }
            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult save_favoritoDetalle(SS_HC_FavoritoDetalle objSave, String MODO, String idWindow)
        {
            Log.Information("BandejaMedicoController - save_favoritoDetalle - Entrar");
            Log.Debug("BandejaMedicoController - save_favoritoDetalle - objSave {A}, MODO {B}, idWindow {C}"
                , objSave, MODO, idWindow);
            List<ENTITY_MENSAJES> msgNoValido = null;
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            if (objSave != null)
            {
                msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objSave, UTILES_MENSAJES.FORM_MSFAVORITONUMERO);
                if (msgNoValido.Count > 0)
                {
                    message = msgNoValido[0].DESCRIPCION;
                    tipoMsg = "WARNING";
                    tituloMsg = "Advertencia";
                    indicaValidacionForm = true;
                }
                else
                {
                    List<SS_HC_FavoritoDetalle> dataDelete = new List<SS_HC_FavoritoDetalle>();
                    List<SS_HC_FavoritoDetalle> dataSave = new List<SS_HC_FavoritoDetalle>();
                    if (Session["DataDetalleFavDelete"] != null)
                    {
                        dataDelete = (List<SS_HC_FavoritoDetalle>)Session["DataDetalleFavDelete"];
                        foreach (SS_HC_FavoritoDetalle obj in dataDelete)
                        {
                            idResultado = SvcFavoritoDetalle.setMantenimiento(obj, 0, 0);
                        }
                    }

                    if (Session["DataDetalleFavSave"] != null)
                    {
                        dataSave = (List<SS_HC_FavoritoDetalle>)Session["DataDetalleFavSave"];
                        foreach (SS_HC_FavoritoDetalle obj in dataSave)
                        {
                            obj.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                            idResultado = SvcFavoritoDetalle.setMantenimiento(obj, 0, 0);
                        }
                    }

                    if (idResultado > 0)
                    {
                        message = "Se " + accion + " el  usuario (" + objSave.Secuencia + ") satisfactoriamente.";

                    }
                    else
                    {
                        if (dataSave.Count == 0)
                        {
                            message = "Se grabó satisfactoriamente.";
                        }
                        else
                        {
                            tipoMsg = "ERROR";
                            //message = "No se pudo guadar los cambios. Sucedio un error en la operación.";
                            message = "Se " + accion + " el  usuario (" + objSave.Secuencia + ") satisfactoriamente.";
                            tituloMsg = "Error";
                        }
                    }
                }
            }
            else
            {
                tipoMsg = "ERROR";
                message = "No se pudo guadar los cambios. No se recibió el objeto vinculado.";
                tituloMsg = "Error";
            }

            objSave.Accion = "INFO";
            if (indicaValidacionForm)
            {
                Session["DataDetalleFavDelete"] = null;
                Session["DataDetalleFavSave"] = null;
                return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinal");
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
            }
        }
        public System.Web.Mvc.ActionResult add_SaveDetalleFavorito(String data, string accion, int nuevo, int num)
        {
            Log.Information("BandejaMedicoController - add_SaveDetalleFavorito - Entrar");
            Log.Debug("BandejaMedicoController - add_SaveDetalleFavorito - data {A}, accion {B}, nuevo {C}, num {D}"
                , data, accion, nuevo, num);
            List<ENTITY_MENSAJES> mensajes = new List<ENTITY_MENSAJES>();
            String mensaje = null;
            ENTITY_MENSAJES objMsg = new ENTITY_MENSAJES();

            if ((data != null) || (data.Length > 0))
            {
                List<SS_HC_FavoritoDetalle> VariableGenerales = (List<SS_HC_FavoritoDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<SS_HC_FavoritoDetalle>));
                List<SS_HC_FavoritoDetalle> dataSave = null;
                if (Session["DataDetalleFavSave"] != null)
                {
                    dataSave = (List<SS_HC_FavoritoDetalle>)Session["DataDetalleFavSave"];
                }
                else
                {
                    dataSave = new List<SS_HC_FavoritoDetalle>();
                }
                if (VariableGenerales.Count > 0)
                {

                    for (int i = 0; i < VariableGenerales.Count; i++)
                    {
                        SS_HC_FavoritoDetalle node = VariableGenerales[i];

                        SS_HC_FavoritoDetalle objDet = new SS_HC_FavoritoDetalle();
                        var Listar = new List<SS_HC_FavoritoDetalle>();
                        objDet.Accion = "LISTAR";
                        objDet.IdFavorito = nuevo;
                        objDet.NumeroFavorito = num;
                        Listar = SvcFavoritoDetalle.listarFavoritoDetalle(objDet, 0, 0, 0, 0);

                        if (Listar.Count > 0)
                        {
                            foreach (SS_HC_FavoritoDetalle objEntity in Listar)
                            {
                                if (objEntity.ValorId == node.ValorId)
                                {
                                    mensaje = "Elemento seleccionado ya se encuentra guardado dentro de la tabla. No puede ser guardado'";
                                    mensajes.Add(new ENTITY_MENSAJES
                                    {
                                        DESCRIPCION = mensaje,
                                        IDCOMPONENTE = "txtDesc",
                                        NIVEL = 1
                                    });
                                }
                                else
                                {
                                    foreach (var result in VariableGenerales)
                                    {
                                        SS_HC_FavoritoDetalle objDeta = new SS_HC_FavoritoDetalle();
                                        var Listado = new List<SS_HC_FavoritoDetalle>();
                                        objDeta.Accion = "LISTAR";
                                        objDeta.IdFavorito = nuevo;
                                        objDeta.NumeroFavorito = num;
                                        objDeta.ValorId = result.ValorId;
                                        Listado = SvcFavoritoDetalle.listarFavoritoDetalle(objDeta, 0, 0, 0, 0);
                                        if (Listado.Count == 0)
                                        { dataSave.Add(result); }
                                    }
                                }
                            }
                        }
                        else
                        {
                            foreach (var result in VariableGenerales)
                            {

                                dataSave.Add(result);
                            }
                        }
                    }

                    //foreach (var result in VariableGenerales)
                    //{
                    //    dataSave.Add(result);
                    //}
                }
                Session["DataDetalleFavSave"] = dataSave;
                Log.Information("BandejaMedicoController - add_SaveDetalleFavorito - Salir - Session: {A} ", dataSave);
            }

            return this.Store(mensajes);
        }
        public System.Web.Mvc.ActionResult add_DeleteDetalleFavorito(String data, string accion)
        {
            Log.Information("BandejaMedicoController - add_DeleteDetalleFavorito - Entrar");
            Log.Debug("BandejaMedicoController - add_DeleteDetalleFavorito - data {A}, accion {B}"
                , data, accion);
            if ((data != null) || (data.Length > 0))
            {
                List<SS_HC_FavoritoDetalle> VariableGenerales = (List<SS_HC_FavoritoDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<SS_HC_FavoritoDetalle>));
                List<SS_HC_FavoritoDetalle> dataDelete = null;
                if (Session["DataDetalleFavDelete"] != null)
                {
                    dataDelete = (List<SS_HC_FavoritoDetalle>)Session["DataDetalleFavDelete"];
                }
                else
                {
                    dataDelete = new List<SS_HC_FavoritoDetalle>();
                }
                if (VariableGenerales.Count > 0)
                {
                    foreach (var result in VariableGenerales)
                    {
                        dataDelete.Add(result);
                    }
                }
                Session["DataDetalleFavDelete"] = dataDelete;
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult Familias(string Linea, string Familia, string Accion)
        {
            Log.Information("BandejaMedicoController - Familias - Entrar");
            Log.Debug("BandejaMedicoController - Familias - Linea {A}, Familia {B}, Accion {C}"
                , Linea, Familia, Accion);
            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboGenericoTxtDos(Linea, Familia, "", "", Accion));
        }
        public System.Web.Mvc.ActionResult getGrillaFavorito(int start, int limit,
           string id, string descripcion, string estado, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaFavorito - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaFavorito - start {A}, limit {B}, id {C} , descripcion {D},estado {E}, tipoBuscar {F} "
                , start, limit, id, descripcion, estado, tipoBuscar);
            ENTITY_GLOBAL.Instance.GRUPO = "";
            var Listar = new List<SS_HC_Favorito>();
            var LocalEnty = new SS_HC_Favorito();
            LocalEnty.TipoFavorito = Convert.ToInt32(getValorFiltroInt(id));
            LocalEnty.Descripcion = getValorFiltroStr(descripcion);
            LocalEnty.Estado = getValorFiltroInt(estado);
            LocalEnty.IdAgente = ENTITY_GLOBAL.Instance.IDAGENTE;
            if (estado == "-1")
            {
                LocalEnty.Estado = null;
            }
            int inicio = (start == 0 ? start : start + 1);
            int final = start + limit;

            if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

            LocalEnty.Accion = "NUEVOLISTAPAG";
            int cantElementos = SvcFavorito.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {
                LocalEnty.Accion = "NUEVOLISTAPAG";
                Listar = SvcFavorito.listarFavorito(LocalEnty, inicio, final);
            }

            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult getSeleccionadorFavorito(String MODO, int id, String descripcion, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionadorFavorito - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionadorFavorito - MODO {A}, id {B}, descripcion {C} , idWindow {D} "
                , MODO, id, descripcion, idWindow);
            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var nf = X.GetCmp<NumberField>("nfFavorito");
            nf.SetValue(id);
            var txt = X.GetCmp<TextField>("tfFavoritoDesc");
            txt.SetValue(descripcion);

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult seleccionadorFavorito(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - seleccionadorFavorito - Entrar");
            Log.Debug("BandejaMedicoController - seleccionadorFavorito - accionSeleccion {A}, accionListado {B}"
                , accionSeleccion, accionListado);
            SS_HC_Favorito obj = new SS_HC_Favorito();
            obj.UsuarioCreacion = accionListado; //AUXILIAR
            obj.Accion = accionSeleccion;
            return crearWindowRegistro("SeleccionadorFavoritos", obj, "");
        }
        public System.Web.Mvc.ActionResult FavoritoRegistro(String MODO, int idFavorito)
        {
            Log.Information("BandejaMedicoController - FavoritoRegistro - Entrar");
            Log.Debug("BandejaMedicoController - FavoritoRegistro - MODO {A}, idFavorito {B}"
                , MODO, idFavorito);
            var Listar = new List<SS_HC_Favorito>();

            SS_HC_Favorito objfavorito = new SS_HC_Favorito();
            if (MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER")
            {
                objfavorito.Accion = "LISTAR";
                objfavorito.IdFavorito = idFavorito;

                Listar = SvcFavorito.listarFavorito(objfavorito, 0, 0);
                if (Listar.Count > 0)
                {
                    foreach (SS_HC_Favorito objEntity in Listar)
                    {
                        objfavorito = objEntity;
                    }
                }
            }
            else if (MODO == "NUEVO")
            {
                objfavorito.Accion = "NUEVO";
            }
            objfavorito.Accion = MODO;

            return crearWindowRegistro("AdministrarFavoritos/FavoritoRegistro", objfavorito, "");

        }
        public System.Web.Mvc.ActionResult save_favorito(SS_HC_Favorito objSave, String MODO, String idWindow)
        {
            Log.Information("BandejaMedicoController - save_favorito - Entrar");
            Log.Debug("BandejaMedicoController - save_favorito - objSave {A}, MODO {B}, idWindow {C}"
                , objSave, MODO, idWindow);
            List<ENTITY_MENSAJES> msgNoValido = null;
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            if (objSave != null)
            {
                ////VALIDACIÓN
                objSave.Accion = MODO;
                msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objSave, UTILES_MENSAJES.FORM_MSTCUERPOHUMANO);
                if (msgNoValido.Count > 0)
                {
                    message = msgNoValido[0].DESCRIPCION;
                    tipoMsg = "WARNING";
                    tituloMsg = "Advertencia";
                    indicaValidacionForm = true;
                }
                else
                {
                    if (MODO == "NUEVO")
                    {
                        objSave.Accion = "INSERT";
                        accion = "registró";
                    }
                    else if (MODO == "UPDATE")
                    {
                        objSave.Accion = "UPDATE";
                        accion = "modificó";
                    }
                    else if (MODO == "DELETE")
                    {
                        objSave.Accion = "DELETE";
                        accion = "eliminó";
                    }
                    else
                    {
                        tipoMsg = "WARNING";
                        message = "No se encotró el MODO.";
                        tituloMsg = "Advertencia";
                    }
                    try
                    {
                        //objCuerpo.Estado = Convert.ToInt32(objCuerpo.UsuarioModificacion);
                    }
                    catch (Exception e)
                    {
                        Log.Information("BandejaMedicoController - save_favorito - Bloque Catch");
                        Log.Error(e, e.Message);
                        X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                    }

                    objSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    idResultado = SvcFavorito.setMantenimiento(objSave);

                    if (idResultado > 0)
                    {
                        message = "Se " + accion + " el  usuario (" + objSave.Descripcion + ") satisfactoriamente.";
                    }
                    else
                    {
                        tipoMsg = "ERROR";
                        message = "No se pudo guadar los cambios. Sucedio un error en la operación.";
                        tituloMsg = "Error";
                    }
                }
            }
            else
            {
                tipoMsg = "ERROR";
                message = "No se pudo guadar los cambios. No se recibió el objeto vinculado.";
                tituloMsg = "Error";
            }

            objSave.Accion = "INFO";
            if (indicaValidacionForm)
            {
                return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinales");
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinales");
            }
        }
        public System.Web.Mvc.ActionResult postWindowAgente_L(String idpadreagente, String idpadre)
        {
            Log.Information("BandejaMedicoController - postWindowAgente_L - Entrar");
            Log.Debug("BandejaMedicoController - postWindowAgente_L - idpadreagente {A}, idpadre {B}"
                , idpadreagente, idpadre);
            SG_Agente objAg = new SG_Agente();
            var Listar = new List<SG_Agente>();

            var field = X.GetCmp<TextField>("txtDescripA");
            if (field != null)
            {
                objAg.ACCION = "LISTAR";
                objAg.IdAgente = (getValorFiltroInt(idpadreagente) != null ? Convert.ToInt32(getValorFiltroInt(idpadreagente)) : 0);
                Listar = SvcSG_Agente.listarSG_Agente(objAg, 0, 0);
                if (Listar.Count == 1)
                {
                    foreach (SG_Agente objEntity in Listar)
                    {
                        objAg = objEntity;
                        field.SetValue(objAg.Descripcion);
                    }
                }
            }
            ////
            SS_HC_Tabla objTabla = new SS_HC_Tabla();
            var ListarTa = new List<SS_HC_Tabla>();

            var field1 = X.GetCmp<TextField>("txtDescrip");
            if (field1 != null)
            {
                objTabla.Accion = "LISTARPORID";
                objTabla.IdFavoritoTabla = (getValorFiltroInt(idpadre) != null ? Convert.ToInt32(getValorFiltroInt(idpadre)) : 0);
                ListarTa = SvcTabla.listarTabla(objTabla, 0, 0);
                if (ListarTa.Count == 1)
                {
                    foreach (SS_HC_Tabla objEntity in ListarTa)
                    {
                        objTabla = objEntity;
                        field1.SetValue(objTabla.Descripcion);
                    }
                }
            }
            return this.Direct();
        }
        /************SELECCIONADOR TABLA**************/
        public System.Web.Mvc.ActionResult getGrillaTabla(int start, int limit, string tabla, string nombre, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaTabla - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaTabla - start {A}, limit {B}, tabla {C}, nombre {D},tipoBuscar {E}"
                , start, limit, tabla, nombre, tipoBuscar);
            ENTITY_GLOBAL.Instance.GRUPO = "";
            var Listar = new List<SS_HC_Tabla>();

            var LocalEnty = new SS_HC_Tabla();

            LocalEnty.TipoTabla = Convert.ToInt32(getValorFiltroInt(tabla));
            LocalEnty.Descripcion = getValorFiltroStr(nombre);

            int inicio = (start == 0 ? start : start + 1);
            int final = start + limit;

            if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }


            LocalEnty.Accion = "CONTARLISTAPAG";
            int cantElementos = SvcTabla.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {
                LocalEnty.Accion = "LISTARPAG";
                Listar = SvcTabla.listarTabla(LocalEnty, inicio, final);
            }

            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult seleccionadorTabla(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - seleccionadorTabla - Entrar");
            Log.Debug("BandejaMedicoController - seleccionadorTabla - accionSeleccion {A}, accionListado {B}"
                , accionSeleccion, accionListado);
            SS_HC_Tabla obj = new SS_HC_Tabla();
            obj.UsuarioCreacion = accionListado;
            obj.Accion = accionSeleccion;
            return crearWindowRegistro("SeleccionadorTabla", obj, "");
        }
        public System.Web.Mvc.ActionResult getSeleccionadorTabla(String MODO, int id, String descripcion, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionadorTabla - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionadorTabla - MODO {A}, id {B}, descripcion {C}, idWindow {D}"
                , MODO, id, descripcion, idWindow);
            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var nf = X.GetCmp<NumberField>("nfIdPadre");
            nf.SetValue(id);
            var txt = X.GetCmp<TextField>("txtDescrip");
            txt.SetValue(descripcion);

            return this.Direct();
        }
        /***********************ASIGNACION MEDICO***********************/
        public System.Web.Mvc.ActionResult CCEP7004_View()
        {
            Log.Information("BandejaMedicoController - CCEP7004_View - Entrar");
            return View("AsignacionMedico/CCEP7004_View");
        }
        public System.Web.Mvc.ActionResult GrillaListadoAsignacionMed(int start, int limit, string txtHC,
          string txtFecha1, string txtFecha2, string txtHCA, string txtCodigoOA, string txtPaciente,
          string tipoConsulta, string tipoEstado, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAsignacionMed - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAsignacionMed - start {A}, limit {B}, txtHC {C}, txtFecha1 {D} ,txtFecha2 {E}" +
                ", txtHCA {F} txtCodigoOA {G} ,txtPaciente {H}, tipoConsulta {I}, tipoEstado {J} ,tipoBuscar {K}"
                , start, limit, txtHC, txtFecha1, txtFecha2, txtHCA, txtCodigoOA, txtPaciente, tipoConsulta, tipoEstado, tipoBuscar);
            ENTITY_GLOBAL.Instance.GRUPO = "";
            var Listar = new List<VW_ATENCIONPACIENTE>();
            var LocalEnty = new VW_ATENCIONPACIENTE();
            int ini = (start == 0 ? start : start + 1);
            int fin = start + limit;
            if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }
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
                txtFecha2 = txtFecha2.Replace("\"", "");
                LocalEnty.FecFinDiscamec = Convert.ToDateTime(txtFecha2);
            }
            LocalEnty.CodigoHC = ((txtHC + "").Trim().Length == 0 ? null : txtHC);
            LocalEnty.CodigoHCAnterior = ((txtHCA + "").Trim().Length == 0 ? null : txtHCA);
            LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
            LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
            LocalEnty.Servicio = tipoConsulta;
            LocalEnty.Estado = getValorFiltroInt(tipoEstado);
            LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
            LocalEnty.Accion = "LISTARPAGNUEVO";
            int cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {
                LocalEnty.Accion = "LISTARPAGNUEVO";
                Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
            }
            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult getGrillaListadoVwPersonapacienteSeleccionar(int start, int limit, int persona, string nombre, string accion, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaListadoVwPersonapacienteSeleccionar - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaListadoVwPersonapacienteSeleccionar - start {A}, limit {B}, persona {C}, nombre {D} ,accion {E}" +
                ", tipoBuscar {F}"
                , start, limit, persona, nombre, accion, tipoBuscar);
            ENTITY_GLOBAL.Instance.GRUPO = "";
            var Listar = new List<VW_PERSONAPACIENTE>();

            var LocalEnty = new VW_PERSONAPACIENTE();

            LocalEnty.Persona = persona;
            LocalEnty.NombreCompleto = nombre;
            int ini = (start == 0 ? start : start + 1);
            int fin = start + limit;
            if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }
            LocalEnty.ACCION = accion;
            int cantElementos = SvcVw_Personapaciente.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {
                LocalEnty.ACCION = accion;
                Listar = SvcVw_Personapaciente.listarVwPersonapaciente(LocalEnty, ini, fin);
            }
            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult getGrillaSeleccionarPaciente(String MODO, int persona, String idWindow)
        {
            Log.Information("BandejaMedicoController - getGrillaSeleccionarPaciente - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaSeleccionarPaciente - MODO {A}, persona {B}, idWindow {C}", MODO, persona, idWindow);
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var txt = X.GetCmp<NumberField>("nfIdEmp");
            txt.SetValue(persona);

            List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.Persona = persona;
            obj.ACCION = "LISTARPORID";
            lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, 0, 0);
            if (lista.Count == 1)
            {
                foreach (var result in lista)
                {
                    var txtNombre = X.GetCmp<TextField>("tfDescEmp");
                    txtNombre.SetValue(result.NombreCompleto);
                }
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult getGrillaSeleccionarMedico(String MODO, int persona, String idWindow)
        {
            Log.Information("BandejaMedicoController - getGrillaSeleccionarMedico - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaSeleccionarMedico - stMODOart {A}, persona {B}, idWindow {C}", MODO, persona, idWindow);
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var txt = X.GetCmp<NumberField>("nfIdMed");
            txt.SetValue(persona);

            List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.Persona = persona;
            obj.ACCION = "LISTARPORID";
            lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, 0, 0);
            if (lista.Count == 1)
            {
                foreach (var result in lista)
                {
                    var txtNombre = X.GetCmp<TextField>("txtMedico");
                    txtNombre.SetValue(result.NombreCompleto);
                }
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult seleccionadorPersona(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - seleccionadorPersona - Entrar");
            Log.Debug("BandejaMedicoController - seleccionadorPersona - accionSeleccion {A}, accionListado {B}}", accionSeleccion, accionListado);
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.Actividad = accionListado;
            obj.ACCION = accionSeleccion;
            return crearWindowRegistro("SeleccionadorPersona", obj, "");
        }
        public System.Web.Mvc.ActionResult AsigMedicoRegistro(String MODO, String unidad, int idepisodio, int paciente, int episodio, String codigooa)
        {
            Log.Information("BandejaMedicoController - AsigMedicoRegistro - Entrar");
            Log.Debug("BandejaMedicoController - AsigMedicoRegistro - MODO {A}, unidad {B}, idepisodio {C}, paciente {D} ,episodio {E}, codigooa {F}"
            , MODO, unidad, idepisodio, paciente, episodio, codigooa);
            var Listar = new List<VW_SS_HC_ASIGNACIONMEDICO>();
            VW_SS_HC_ASIGNACIONMEDICO objFiltro = new VW_SS_HC_ASIGNACIONMEDICO();
            if (MODO == "INSERT" || MODO == "NUEVO" || MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER")
            {
                objFiltro.accion = "LISTAR";
                objFiltro.unidadreplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                //objFiltro.idepisodioatencion = idepisodio;
                objFiltro.idpaciente = paciente;
                //objFiltro.episodioclinico = episodio;
                //objFiltro.idasignacionmedico = idasignacion;
                // objFiltro.CodigoOA = codigooa;
                Listar = SvcVWAsigMedico.listarVWAsigMedico(objFiltro, 0, 0);
                if (Listar.Count == 1)
                {
                    foreach (VW_SS_HC_ASIGNACIONMEDICO objEntity in Listar)
                    {
                        objFiltro = objEntity;
                    }
                }
            }
            objFiltro.accion = MODO;
            return crearWindowRegistro("AsignacionMedico/AsigMedicoRegistro", objFiltro, "");
        }
        public System.Web.Mvc.ActionResult postWindowAsigMedico(String ur, String idepisodio, String idpaciente, String episodio, String idasignacion, String codigooa, String nombre, String medico)
        {
            Log.Information("BandejaMedicoController - postWindowAsigMedico - Entrar");
            Log.Debug("BandejaMedicoController - postWindowAsigMedico - ur {A}, idepisodio {B}, idpaciente {C}, episodio {D} ,idasignacion {E}, codigooa {F},nombre {G}, medico {H}"
            , ur, idepisodio, idpaciente, episodio, idasignacion, codigooa, nombre, medico);
            VW_PERSONAPACIENTE objAg = new VW_PERSONAPACIENTE();
            var Listar1 = new List<VW_PERSONAPACIENTE>();

            var field11 = X.GetCmp<TextField>("tfDescEmp");
            if (field11 != null)
            {
                objAg.ACCION = "LISTAR";
                objAg.Persona = (getValorFiltroInt(nombre) != null ? Convert.ToInt32(getValorFiltroInt(nombre)) : 0);
                Listar1 = SvcVw_Personapaciente.listarVwPersonapaciente(objAg, 0, 0);
                if (Listar1.Count == 1)
                {
                    foreach (VW_PERSONAPACIENTE objEntity1 in Listar1)
                    {
                        objAg = objEntity1;
                        field11.SetValue(objAg.NombreCompleto);
                    }
                }
            }
            VW_PERSONAPACIENTE objAgi = new VW_PERSONAPACIENTE();
            var Listar2 = new List<VW_PERSONAPACIENTE>();

            var field3 = X.GetCmp<TextField>("txtMedico");
            if (field3 != null)
            {
                objAg.ACCION = "LISTAR";
                objAg.Persona = (getValorFiltroInt(medico) != null ? Convert.ToInt32(getValorFiltroInt(medico)) : 0);

                Listar1 = SvcVw_Personapaciente.listarVwPersonapaciente(objAg, 0, 0);
                if (Listar2.Count == 1)
                {
                    foreach (VW_PERSONAPACIENTE objEntity1 in Listar2)
                    {
                        objAg = objEntity1;
                        field3.SetValue(objAg.NombreCompleto);
                    }
                }
            }

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult save_AsigMedico(VW_SS_HC_ASIGNACIONMEDICO objFiltro, String MODO, String idWindow)
        {
            Log.Information("BandejaMedicoController - save_AsigMedico - Entrar");
            Log.Debug("BandejaMedicoController - save_AsigMedico - objFiltro {A}, MODO {B}, idWindow {C}"
            , objFiltro, MODO, idWindow);
            List<ENTITY_MENSAJES> msgNoValido = null;
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;

            if (objFiltro != null)
            {
                objFiltro.accion = MODO;
                msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objFiltro, UTILES_MENSAJES.FORM_MSTVWASIGMED);
                if (msgNoValido.Count > 0)
                {
                    message = msgNoValido[0].DESCRIPCION;
                    tipoMsg = "WARNING";
                    tituloMsg = "Advertencia";
                    indicaValidacionForm = true;
                }
                else
                {
                    if (MODO == "NUEVO")
                    {
                        objFiltro.accion = "INSERT";
                        accion = "asignó médico";
                    }
                    if (MODO == "INSERT")
                    {
                        objFiltro.accion = "INSERT";
                        accion = "reasignó médico";
                    }
                    else if (MODO == "UPDATE")
                    {
                        objFiltro.accion = "UPDATE";
                        accion = "modificó";
                    }
                    else if (MODO == "DELETE")
                    {
                        objFiltro.accion = "DELETE";
                        accion = "eliminó";
                    }
                    else
                    {
                        tipoMsg = "WARNING";
                        message = "No se encontró el MODO.";
                        tituloMsg = "Advertencia";
                    }
                    try
                    {
                        //objCuerpo.Estado = Convert.ToInt32(objCuerpo.UsuarioModificacion);
                    }
                    catch (Exception e)
                    {
                        Log.Information("BandejaMedicoController - save_AsigMedico - Bloque catch");
                        Log.Error(e, e.Message);
                        X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                    }
                    /////registro
                    objFiltro.usuariomodificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objFiltro.usuariocreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objFiltro.unidadreplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    idResultado = SvcVWAsigMedico.setMantenimiento(objFiltro);
                    //////////////////////FINAL
                    if (idResultado > 0)
                    {
                        message = "Se " + accion + " la asignación satisfactoriamente.";
                    }
                    else
                    {
                        tipoMsg = "ERROR";
                        message = "No se pudieron guardar los cambios. Sucedio un error en la operación.";
                        tituloMsg = "Error";
                    }
                }
            }
            else
            {
                tipoMsg = "ERROR";
                message = "No se pudieron guardar los cambios. No se recibió el objeto vinculado.";
                tituloMsg = "Error";
            }
            objFiltro.accion = "INFO";
            if (indicaValidacionForm)
            {
                return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinal");
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
            }
        }

        /***********************FIN********************/

        /***********ACTOS MEDICOS*********/
        /**Medicos ambulatorio*/
        public System.Web.Mvc.ActionResult CCEP9001_View()
        {
            Log.Information("BandejaMedicoController - CCEP9001_View - Entrar");
            var txtMedicoNom = X.GetCmp<TextField>("txtMedico");
            if (ENTITY_GLOBAL.Instance.PERFILADMIN == -2)
            {
                txtMedicoNom.SetValue("");
            }
            else
            {
                txtMedicoNom.SetValue(ENTITY_GLOBAL.Instance.MedicoNombre);
                txtMedicoNom.SetValue((string)Session["NOMBRE_MEDICO"]);
            }
            return View("ActosMedicos/CCEP9001_View", ENTITY_GLOBAL.Instance);//            
        }

        public System.Web.Mvc.ActionResult CCEP9301_View()
        {
            Log.Information("BandejaMedicoController - CCEP9301_View - Entrar");
            //ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION;
            return View("AdmisionTeleSalud/CCEP9301_View", ENTITY_GLOBAL.Instance);//            
        }
        public System.Web.Mvc.ActionResult CCEP9020_View()
        {
            Log.Information("BandejaMedicoController - CCEP9020_View - Entrar");
            //ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION;
            return View("AdmisionTeleSalud/CCEP9020_View", ENTITY_GLOBAL.Instance);//            
        }
        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientesTeleSalud(int start, int limit, string txtHC,
         string txtFecha1, string txtFecha2, string txtHCA, string txtCodigoOA, string txtPaciente,
         string tipoConsulta, string tipoEstado, string tipoBuscar, string tipoListado)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - start {A}, limit {B}, txtHC {C}, txtFecha1 {D} ,txtFecha2 {E}, txtHCA {F}" +
                ",txtCodigoOA {G}, txtPaciente {H},tipoConsulta {I}, tipoEstado {J},  tipoBuscar {K}, tipoListado {L}"
            , start, limit, txtHC, txtFecha1, txtFecha2, txtHCA, txtCodigoOA, txtPaciente, tipoConsulta, tipoEstado, tipoBuscar, tipoListado);
            int cantElementos = 0;
            var ListarGeneral = new List<VW_ATENCIONPACIENTE_GENERAL>();
            try
            {
                ////////////////                
                var objGenral = new VW_ATENCIONPACIENTE_GENERAL();

                //ConsultaCita();
                //var field = X.GetCmp<TextField>("txtPaciente");             
                var Listar = new List<VW_ATENCIONPACIENTE>();
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
                    objGenral.FechaInicio = Convert.ToDateTime(txtFecha1);
                }
                else
                {
                    var FechaX = DateTime.Now;
                    FechaX.AddDays(-30);
                    objGenral.FechaInicio = FechaX;

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
                    objGenral.FechaFin = Convert.ToDateTime(txtFecha2);
                }
                else
                {
                    objGenral.FechaFin = DateTime.Now;
                }
                /**LISTADO*/

                objGenral.CodigoHC = ((txtHC + "").Trim().Length == 0 ? null : txtHC);
                objGenral.CodigoHCAnterior = ((txtHCA + "").Trim().Length == 0 ? null : txtHCA);
                objGenral.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                objGenral.PacienteNombre = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                objGenral.EstadoEpiAtencion = getValorFiltroInt(tipoEstado);
                objGenral.Accion = tipoListado;
                objGenral.tipoListado = tipoListado;
                //ListarGeneral = SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(objGenral, ini, fin);
                objGenral.IdMedico = ENTITY_GLOBAL.Instance.CODPERSONA;
                objGenral.NumeroFila = ini;
                objGenral.Contador = fin;
                /**ADD CONFIGURACIÓN*/
                objGenral.Compania = ENTITY_GLOBAL.Instance.Compania;
                objGenral.Sucursal = ENTITY_GLOBAL.Instance.Sucursal;
                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objGenral.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                {
                    objGenral.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                }
                ///////////

                //String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") != null ?
                //        (String)UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") : null);

                String PARAM = ENTITY_GLOBAL.Instance.ACTIVOSOA;
                objGenral.Modalidad = 10;  //AUX PARA TELESALUD

                ListarGeneral = SOA_AtencionesSpring.ListaPacienteTeleSalud(objGenral, "N");

                if (ListarGeneral.Count > 0)
                {
                    cantElementos = ListarGeneral[0].Contador;
                    //cantElementos =21;
                    /**MATCH CON EPISODIOS DE ATENCIÓN*/
                    //hecho en la capa de servicio
                }
                return this.Store(ListarGeneral, cantElementos);

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - Bloque Catch");
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

        public System.Web.Mvc.ActionResult PacienteAprobado(String MODO, int idPersona, String txtCodigoOA, int clinico)
        {
            Log.Information("BandejaMedicoController - PacienteAprobado - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - MODO {A}, idPersona {B}, txtCodigoOA {C}, clinico {D} "
                        , MODO, idPersona, txtCodigoOA, clinico);
            var Listar = new List<VW_PERSONAPACIENTE>();
            var ListarGeneral = new List<VW_ATENCIONPACIENTE_GENERAL>();

            ////////////////                
            var objGenral = new VW_ATENCIONPACIENTE_GENERAL();

            //ConsultaCita();
            //var field = X.GetCmp<TextField>("txtPaciente");             

            var LocalEnty = new VW_ATENCIONPACIENTE();
            /**LISTADO*/


            objGenral.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
            // objGenral.IdOrdenAtencion = Convert.ToInt32(txtCodigoOA);
            objGenral.IdPaciente = idPersona;
            objGenral.EpisodioClinico = clinico;
            objGenral.tipoListado = "MED_AMBULATORIO";
            //ListarGeneral = SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(objGenral, ini, fin);
            objGenral.NumeroFila = 0;
            objGenral.Contador = 5;
            /**ADD CONFIGURACIÓN*/
            objGenral.Accion = "TELEAPROB";
            objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objGenral.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
            if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
            {
                objGenral.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
            }
            ///////////

            objGenral.Modalidad = 10;  //AUX PARA TELESALUD

            ListarGeneral = SOA_AtencionesSpring.ListaPacienteTeleSalud(objGenral, "N");
            if (ListarGeneral.Count > 0)
            {
                foreach (VW_ATENCIONPACIENTE_GENERAL objEntity in ListarGeneral)
                {
                    objGenral = objEntity;
                }
            }
            Session["MENSAJES_VALFORM"] = null;
            cargarPropiedadesFormulario(true);

            return crearWindowRegistro("AdmisionTelesalud/PacienteAprobado", objGenral, "");

        }
        public System.Web.Mvc.ActionResult AsignacionMedico(String MODO, int idPersona, String txtCodigoOA, int clinico)
        {
            Log.Information("BandejaMedicoController - AsignacionMedico - Entrar");
            Log.Debug("BandejaMedicoController - AsignacionMedico - MODO {A}, idPersona {B}, txtCodigoOA {C}, clinico {D}"
                        , MODO, idPersona, txtCodigoOA, clinico);
            var Listar = new List<VW_PERSONAPACIENTE>();
            var ListarGeneral = new List<VW_ATENCIONPACIENTE_GENERAL>();

            ////////////////                
            var objGenral = new VW_ATENCIONPACIENTE_GENERAL();

            //ConsultaCita();
            //var field = X.GetCmp<TextField>("txtPaciente");             

            var LocalEnty = new VW_ATENCIONPACIENTE();
            /**LISTADO*/


            objGenral.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
            //objGenral.IdOrdenAtencion = Convert.ToInt32(txtCodigoOA);
            objGenral.IdPaciente = idPersona;
            objGenral.EpisodioClinico = clinico;
            objGenral.tipoListado = "MED_AMBULATORIO";
            //ListarGeneral = SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(objGenral, ini, fin);
            objGenral.NumeroFila = 0;
            objGenral.Contador = 5;
            /**ADD CONFIGURACIÓN*/
            objGenral.Accion = "TELEAPROB";
            objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objGenral.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
            if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
            {
                objGenral.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
            }
            ///////////

            objGenral.Modalidad = 10;  //AUX PARA TELESALUD

            ListarGeneral = SOA_AtencionesSpring.ListaPacienteTeleSalud(objGenral, "N");
            if (ListarGeneral.Count > 0)
            {
                foreach (VW_ATENCIONPACIENTE_GENERAL objEntity in ListarGeneral)
                {
                    objGenral = objEntity;
                }
            }
            Session["MENSAJES_VALFORM"] = null;
            cargarPropiedadesFormulario(true);

            return crearWindowRegistro("AdmisionTelesalud/AsignarMedico", objGenral, "");

        }
        public System.Web.Mvc.ActionResult save_Paciente_aprobar(SS_GE_Paciente objPaciente, PERSONAMAST objPersona, String MODO, String idWindow, String ESPECIALIDAD, VW_ATENCIONPACIENTE epi)
        {
            Log.Information("BandejaMedicoController - save_Paciente_aprobar - Entrar");
            Log.Debug("BandejaMedicoController - save_Paciente_aprobar - objPaciente {A}, objPersona {B}, MODO {C}, idWindow {D} ,ESPECIALIDAD {E}, epi {F}"
                        , objPaciente, objPersona, MODO, idWindow, ESPECIALIDAD, epi);
            int idResultado = 0;
            String accion = "Aprobo";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
            try
            {

                SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objEpClinico.EpisodioClinico = Convert.ToInt32(epi.EpisodioClinico);
                objEpClinico.IdPaciente = Convert.ToInt32(epi.IdPaciente);
                objEpClinico.UsuarioCreacion = epi.CodigoOA;
                objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                objEpClinico.FlagMedico = Convert.ToInt32(epi.IdEspecialidad);

                objEpClinico.ACCION = "APROBAR";

                idResultado = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                if (idResultado > 0)
                {
                    indicaValidacionForm = true;
                    message = "Se " + accion + " satisfactoriamente.";
                }
                else
                {
                    tipoMsg = "ERROR";
                    message = "No se pudo guadar los cambios. Sucedio un error en la operación.";
                    tituloMsg = "Error";
                }

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_Paciente_aprobar - Bloque Catch");
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


            if (!indicaValidacionForm)
            {
                return showMensajeBotton(msgNoValido, tituloMsg, tipoMsg);
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
            }
        }

        public System.Web.Mvc.ActionResult save_Paciente_desaprobar(SS_GE_Paciente objPaciente, PERSONAMAST objPersona, String MODO, String idWindow, VW_ATENCIONPACIENTE epi)
        {
            Log.Information("BandejaMedicoController - save_Paciente_desaprobar - Entrar");
            Log.Debug("BandejaMedicoController - save_Paciente_desaprobar - objPaciente {A}, objPersona {B}, MODO {C}, idWindow {D} ,epi {E}"
                        , objPaciente, objPersona, MODO, idWindow, epi);

            int idResultado = 0;
            String accion = "Desaprobó";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
            try
            {

                SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objEpClinico.EpisodioClinico = Convert.ToInt32(epi.EpisodioClinico);
                objEpClinico.IdPaciente = Convert.ToInt32(epi.IdPaciente);
                objEpClinico.UsuarioCreacion = epi.CodigoOA;
                objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;


                objEpClinico.ACCION = "DESAPROBAR";

                idResultado = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                if (idResultado > 0)
                {
                    indicaValidacionForm = true;
                    message = "Se " + accion + " satisfactoriamente.";
                }
                else
                {
                    tipoMsg = "ERROR";
                    message = "No se pudo guadar los cambios. Sucedio un error en la operación.";
                    tituloMsg = "Error";
                }

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_Paciente_desaprobar - Bloque Catch");
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


            if (!indicaValidacionForm)
            {
                return showMensajeBotton(msgNoValido, tituloMsg, tipoMsg);
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
            }
        }
        public System.Web.Mvc.ActionResult save_Paciente_medico(SS_GE_Paciente objPaciente, PERSONAMAST objPersona, String MODO, String idWindow, VW_ATENCIONPACIENTE_GENERAL epi)
        {
            Log.Information("BandejaMedicoController - save_Paciente_medico - Entrar");
            Log.Debug("BandejaMedicoController - save_Paciente_medico - objPaciente {A}, objPersona {B}, MODO {C}, idWindow {D} ,epi {E}"
                        , objPaciente, objPersona, MODO, idWindow, epi);
            int idResultado = 0;
            String accion = "Registró";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
            try
            {

                SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objEpClinico.EpisodioClinico = Convert.ToInt32(epi.EpisodioClinico);
                objEpClinico.IdPaciente = Convert.ToInt32(epi.IdPaciente);
                objEpClinico.UsuarioCreacion = epi.CodigoOA;
                objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                String sCadena = Convert.ToString(epi.FechaAtencion);
                String sSubCadena = sCadena.Substring(0, 10);

                objEpClinico.FechaRegistro = Convert.ToDateTime(sSubCadena + " " + epi.Cama);
                objEpClinico.FlagMedico = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);


                objEpClinico.ACCION = "MEDICO";

                idResultado = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                if (idResultado == 0)
                {
                    indicaValidacionForm = true;
                    message = "Se " + accion + " satisfactoriamente.";
                }
                else
                {
                    return showMensajeBox("Sucedio un error. No se pudo guardar los cambios, ingrese una fecha válida.", "Mensaje", "ERROR", "");
                }

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_Paciente_medico - Bloque Catch");
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


            if (!indicaValidacionForm)
            {
                return showMensajeBotton(msgNoValido, tituloMsg, tipoMsg);
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
            }
        }

        public System.Web.Mvc.ActionResult PacienteRegistro(String MODO, int idPersona)
        {
            Log.Information("BandejaMedicoController - PacienteRegistro - Entrar");
            Log.Debug("BandejaMedicoController - PacienteRegistro - MODO {A}, idPersona {B}", MODO, idPersona);

            var Listar = new List<VW_PERSONAPACIENTE>();

            VW_PERSONAPACIENTE objPersona = new VW_PERSONAPACIENTE();
            if (MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER")
            {
                objPersona.ACCION = "LISTAR";
                objPersona.Persona = idPersona;

                Listar = SvcVw_Personapaciente.listarVwPersonapaciente(objPersona, 0, 0);
                if (Listar.Count > 0)
                {
                    foreach (VW_PERSONAPACIENTE objEntity in Listar)
                    {
                        objPersona = objEntity;
                    }
                }
            }
            else if (MODO == "NUEVO")
            {
                objPersona.ACCION = "NUEVO";
            }
            objPersona.ACCION = MODO;

            Session["MENSAJES_VALFORM"] = null;
            cargarPropiedadesFormulario(true);

            return crearWindowRegistro("AdmisionTelesalud/PacienteRegistro", objPersona, "");

        }

        public System.Web.Mvc.ActionResult PacienteRegistroTriaje(String MODO, int idPersona)
        {
            Log.Information("BandejaMedicoController - PacienteRegistroTriaje - Entrar");
            Log.Debug("BandejaMedicoController - PacienteRegistroTriaje - MODO {A}, idPersona {B}", MODO, idPersona);
            var Listar = new List<VW_PERSONAPACIENTE>();

            VW_PERSONAPACIENTE objPersona = new VW_PERSONAPACIENTE();
            if (MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER")
            {
                objPersona.ACCION = "LISTAR";
                objPersona.Persona = idPersona;

                Listar = SvcVw_Personapaciente.listarVwPersonapaciente(objPersona, 0, 0);
                if (Listar.Count > 0)
                {
                    foreach (VW_PERSONAPACIENTE objEntity in Listar)
                    {
                        objPersona = objEntity;
                    }
                }
            }
            else if (MODO == "NUEVO")
            {
                objPersona.ACCION = "NUEVO";
            }
            objPersona.ACCION = MODO;

            Session["MENSAJES_VALFORM"] = null;
            cargarPropiedadesFormulario(true);

            return crearWindowRegistro("AdmisionTelesalud/PacienteRegistroTriaje", objPersona, "");

        }
        public System.Web.Mvc.ActionResult save_Paciente(SS_GE_Paciente objPaciente, PERSONAMAST objPersona, String MODO, String idWindow)
        {
            Log.Information("BandejaMedicoController - save_Paciente - Entrar");
            Log.Debug("BandejaMedicoController - save_Paciente - objPaciente {A}, objPersona {B}, MODO {C}, idWindow {D}"
                        , objPaciente, objPersona, MODO, idWindow);

            List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;
            objPersona.NombreCompleto = objPersona.ApellidoPaterno.Trim() + " " + objPersona.ApellidoMaterno.Trim() + ", " + objPersona.Nombres.Trim();

            if (objPaciente != null && objPersona != null)
            {

                objPaciente.Accion = MODO;
                objPersona.ACCION = MODO;

                if (Session["MENSAJES_VALFORM"] != null)
                {
                    msgNoValido = (List<ENTITY_MENSAJES>)Session["MENSAJES_VALFORM"];
                }
                else
                {
                    msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objPaciente, UTILES_MENSAJES.FORM_MSPACIENTE);
                }

                if (msgNoValido.Count > 0)
                {
                    message = msgNoValido[0].DESCRIPCION;
                    tipoMsg = "WARNING";
                    tituloMsg = "Advertencia";
                    indicaValidacionForm = true;
                }
                else
                {
                    try
                    {
                        if (MODO == "NUEVO")
                        {
                            objPaciente.Accion = "INSERTELESALUD";
                            objPersona.ACCION = "INSERTELESALUD";
                            accion = "registró";
                        }
                        else if (MODO == "UPDATE")
                        {
                            objPaciente.Accion = "UPDATE";
                            objPersona.ACCION = "UPDATE";
                            accion = "modificó";
                        }
                        else if (MODO == "DELETE")
                        {
                            objPaciente.Accion = "DELETE";
                            objPersona.ACCION = "DELETE";
                            accion = "eliminó";
                        }
                        else
                        {
                            tipoMsg = "WARNING";
                            message = "No se encotró el MODO.";
                            tituloMsg = "Advertencia";
                        }
                        try
                        {
                            //objCuerpo.Estado = Convert.ToInt32(objCuerpo.UsuarioModificacion);
                        }
                        catch (Exception e)
                        {
                            Log.Information("BandejaMedicoController - save_Paciente - Bloque Catch");
                            Log.Error(e, e.Message);
                            X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                        }
                        objPersona.CodigoBarras = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        objPersona.UltimoUsuario = ENTITY_GLOBAL.Instance.USUARIO;
                        objPaciente.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        idResultado = SvcPaciente.setMantenimiento(objPaciente, objPersona);

                        if (idResultado > 0)
                        {
                            message = "Se " + accion + " el  paciente (" + objPersona.Nombres + ") satisfactoriamente.";
                        }
                        else
                        {
                            tipoMsg = "ERROR";
                            message = "No se pudo guadar los cambios. Sucedio un error en la operación.";
                            tituloMsg = "Error";
                        }
                    }
                    catch (Exception ex)
                    {
                        Log.Information("BandejaMedicoController - save_Paciente - Bloque Catch 2");
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
            }
            else
            {
                tipoMsg = "ERROR";
                message = "No se pudo guadar los cambios. No se recibió el objeto vinculado.";
                tituloMsg = "Error";
            }

            objPaciente.Accion = "INFO";

            if (indicaValidacionForm)
            {
                return showMensajeBotton(msgNoValido, tituloMsg, tipoMsg);
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
            }
        }

        public System.Web.Mvc.ActionResult postWindowMedico(String idPais, String idDepa, String idProv, String idDist)
        {
            try
            {
                Log.Information("BandejaMedicoController - postWindowMedico - Entrar");
                Log.Debug("BandejaMedicoController - postWindowMedico - idPais {A}, idDepa {B}, idProv {C}, idDist {D}"
                            , idPais, idDepa, idProv, idDist);
                var Listar = new List<MA_MiscelaneosDetalle>();
                MA_MiscelaneosDetalle obj = new MA_MiscelaneosDetalle();
                obj.ValorCodigo1 = (getValorFiltroStr(idPais) != null ? (getValorFiltroStr(idPais)) : "");
                obj.ValorCodigo2 = (getValorFiltroStr(idDepa) != null ? (getValorFiltroStr(idDepa)) : "");
                obj.ValorCodigo3 = (getValorFiltroStr(idProv) != null ? (getValorFiltroStr(idProv)) : "");
                obj.ValorCodigo4 = (getValorFiltroStr(idDist) != null ? (getValorFiltroStr(idDist)) : "");
                obj.AplicacionCodigo = "WA";
                obj.Compania = "999999";
                obj.CodigoTabla = "TODOLUGAR";
                obj.ACCION = "COMBOSGENERICO";
                Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(obj, 0, 10);
                if (Listar.Count == 1)
                {
                    foreach (var result in Listar)
                    {
                        var txtpais = X.GetCmp<TextField>("tfPais");
                        txtpais.SetValue(result.DescripcionLocal);
                        var txtdepa = X.GetCmp<TextField>("tfDepartamento");
                        txtdepa.SetValue(result.DescripcionExtranjera);
                        var txtprov = X.GetCmp<TextField>("tfProvincia");
                        txtprov.SetValue(result.ValorCodigo6);
                        var txtdist = X.GetCmp<TextField>("tfDistrito");
                        txtdist.SetValue(result.ValorCodigo5);
                    }
                }
            }
            catch (Exception e)
            {
                Log.Information("BandejaMedicoController - postWindowMedico - Bloque Catch");
                Log.Error(e, e.Message);
                return showMensajeBox(e.Message, "Excepción", "ERROR", "");
            }
            setPropiedadesFormulario(true);
            return this.Direct();
        }
        //*seleccionador Lugar*//
        public System.Web.Mvc.ActionResult getGrillaLugar(int start, int limit,
           string pais, string depa, string prov, string dist, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaLugar - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaLugar - start {A}, limit {B}, pais {C}, depa {D} ,prov {E}, dist {F}"
                        , start, limit, pais, depa, prov, dist, tipoBuscar);
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                //ConsultaCita();
                var Listar = new List<MA_MiscelaneosDetalle>();

                MA_MiscelaneosDetalle LocalEnty = new MA_MiscelaneosDetalle();
                LocalEnty.ValorCodigo1 = (getValorFiltroStr(pais) != null ? (getValorFiltroStr(pais)) : "");
                LocalEnty.ValorCodigo2 = (getValorFiltroStr(depa) != null ? (getValorFiltroStr(depa)) : "");
                LocalEnty.ValorCodigo3 = (getValorFiltroStr(prov) != null ? (getValorFiltroStr(prov)) : "");
                LocalEnty.AplicacionCodigo = "WA";
                LocalEnty.Compania = "999999";
                LocalEnty.CodigoTabla = "TODOLUGAR";
                //LocalEnty.Nivel = (getValorFiltroInt(tipoNivel) != null ? Convert.ToInt32(getValorFiltroInt(tipoNivel)) : 0);
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                //Si la búsqueda proviene de filtros
                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

                LocalEnty.ACCION = "COMBOSGENERICOS";
                int cantElementos = SvcMiscelaneos.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.ACCION = "COMBOSGENERICO";
                    Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(LocalEnty, inicio, final);
                }
                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - getGrillaLugar - Bloque Catch");
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

        public System.Web.Mvc.ActionResult getGrillaEspecialidadMedico(int start, int limit,
           string cmp, string nombrecompleto, string nroregespecialidad, string idespecialidad,
          string estado, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaEspecialidadMedico - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaEspecialidadMedico - start {A}, limit {B}, cmp {C}, nombrecompleto {D} ,nroregespecialidad {E}, idespecialidad {F}" +
                            ",estado {G}, tipoBuscar {H}"
                        , start, limit, cmp, nombrecompleto, nroregespecialidad, idespecialidad, estado, tipoBuscar);
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_PERSONAPACIENTE>();
                var LocalEnty = new VW_PERSONAPACIENTE();
                //LocalEnty.CMP = getValorFiltroStr(cmp);
                //LocalEnty.NOMBRECOMPLETO = getValorFiltroStr(nombrecompleto);
                //LocalEnty.NUMEROREGISTROESPECIALIDAD = getValorFiltroStr(nroregespecialidad);
                //LocalEnty.IDESPECIALIDAD = (getValorFiltroInt(idespecialidad) != null ? Convert.ToInt32(getValorFiltroInt(idespecialidad)) : 0);
                //LocalEnty.ESTADO = getValorFiltroStr(estado);
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }
                LocalEnty.ACCION = "CONTARLISTARPAGTRIAJE";

                int cantElementos = SvcVw_Personapaciente.setMantenimiento(LocalEnty);
                //int cantElementos = SvcVw_Personapaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {

                    //LocalEnty.PersonaAnt = Convert.ToString(1000051);
                    LocalEnty.ACCION = "LISTARPAGTRIAJE";
                    Listar = SvcVw_Personapaciente.listarVwPersonapaciente(LocalEnty, inicio, final);
                }

                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - getGrillaEspecialidadMedico - Bloque Catch");
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
        public System.Web.Mvc.ActionResult seleccionadorLugar(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - seleccionadorLugar - Entrar");
            Log.Debug("BandejaMedicoController - seleccionadorLugar - start {A}, limit {B}", accionSeleccion, accionListado);
            MA_MiscelaneosDetalle obj = new MA_MiscelaneosDetalle();
            obj.UltimoUsuario = accionListado; //AUXILIAR
            obj.ACCION = accionSeleccion;
            if (Session["MODULO_DEF"] != null)
            {
                //  obj.Modulo = (string)Session["MODULO_DEF"];
            }
            return crearWindowRegistro("SeleccionadorLugar", obj, "");
        }

        public System.Web.Mvc.ActionResult PacienteTriaje(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - PacienteTriaje - Entrar");
            Log.Debug("BandejaMedicoController - PacienteTriaje - start {A}, limit {B}", accionSeleccion, accionListado);

            var Listar = new List<VW_PERSONAPACIENTE>();

            VW_PERSONAPACIENTE objPersona = new VW_PERSONAPACIENTE();

            objPersona.ACCION = "NUEVO";

            Session["MENSAJES_VALFORM"] = null;
            cargarPropiedadesFormulario(true);
            return crearWindowRegistro("PacienteTriaje", objPersona, "");
        }
        public System.Web.Mvc.ActionResult getSeleccionadorLugar(String MODO, String idPais, String pais, String idDepa, String depa, String idProv, String prov, String idDist, String dist, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionadorLugar - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionadorLugar - MODO {A}, idPais {B}, pais {C}, idDepa {D} ,depa {E}, idProv {F}" +
                            ",prov {G}, idDist {H},dist {I}, idWindow {J}"
                        , MODO, idPais, pais, idDepa, depa, idProv, prov, idDist, dist, idWindow);
            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var txtidpais = X.GetCmp<TextField>("Pais");
            txtidpais.SetValue(idPais);
            var txtpais = X.GetCmp<TextField>("tfPais");
            txtpais.SetValue(pais);
            var txtiddepa = X.GetCmp<TextField>("Departamento");
            txtiddepa.SetValue(idDepa);
            var txtdepa = X.GetCmp<TextField>("tfDepartamento");
            txtdepa.SetValue(depa);
            var txtidprov = X.GetCmp<TextField>("Provincia");
            txtidprov.SetValue(idProv);
            var txtprov = X.GetCmp<TextField>("tfProvincia");
            txtprov.SetValue(prov);
            var txtiddist = X.GetCmp<TextField>("CodigoPostal");
            txtiddist.SetValue(idDist);
            var txtdist = X.GetCmp<TextField>("tfDistrito");
            txtdist.SetValue(dist);

            return this.Direct();
        }

        public System.Web.Mvc.ActionResult seleccionadorPersonasTriaje(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - seleccionadorPersonasTriaje - Entrar");
            Log.Debug("BandejaMedicoController - seleccionadorPersonasTriaje - accionSeleccion {A}, accionListado {B}"
                        , accionSeleccion, accionListado);
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.UltimoUsuario = accionListado;
            obj.ACCION = accionSeleccion;
            if (Session["MODULO_DEF"] != null)
            {
            }
            return crearWindowRegistro("SeleccionadorPersonas_Triaje", obj, "");
        }
        public System.Web.Mvc.ActionResult getGrillaPersonasPac(int start, int limit, int persona, string nombre, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaPersonasPac - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaPersonasPac - start {A}, limit {B}, persona {C}, nombre {D} ,tipoBuscar {E}"
                        , start, limit, persona, nombre, tipoBuscar);
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_PERSONAPACIENTE>();

                var LocalEnty = new VW_PERSONAPACIENTE();
                //LocalEnty.Persona = persona;
                LocalEnty.NombreCompleto = nombre;
                int ini = (start == 0 ? start : start + 1);
                int fin = start + limit;
                if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }

                LocalEnty.ACCION = "LISTARPACPER";
                int cantElementos = SvcVw_Personapaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.ACCION = "LISTARPACPER";
                    Listar = SvcVw_Personapaciente.listarVwPersonapaciente(LocalEnty, ini, fin);


                }
                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - getGrillaPersonasPac - Bloque Catch");
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

        public System.Web.Mvc.ActionResult getGrillaPersonasPacTriaje(int start, int limit, int persona, string nombre, string historiaclinica, string documento, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaPersonasPacTriaje - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaPersonasPacTriaje - start {A}, limit {B}, persona {C}, nombre {D} ,historiaclinica {E},documento {F},tipoBuscar {G}"
                        , start, limit, persona, nombre, historiaclinica, documento, tipoBuscar);
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_PERSONAPACIENTE>();

                var LocalEnty = new VW_PERSONAPACIENTE();
                //LocalEnty.Persona = persona;
                LocalEnty.NombreCompleto = nombre;
                int ini = (start == 0 ? start : start + 1);
                int fin = start + limit;
                if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }

                LocalEnty.ACCION = "LISTARPACPER";
                int cantElementos = SvcVw_Personapaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.ACCION = "LISTARPACPER_TRIAJE";
                    //      LocalEnty.USUARIO = "CEG";                   
                    LocalEnty.Nombres = historiaclinica;
                    LocalEnty.Documento = documento;
                    Listar = SvcVw_Personapaciente.listarVwPersonapaciente(LocalEnty, ini, fin);



                }
                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - getGrillaPersonasPacTriaje - Bloque Catch");
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

        public System.Web.Mvc.ActionResult seleccionadorPersonas(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - seleccionadorPersonas - Entrar");
            Log.Debug("BandejaMedicoController - seleccionadorPersonas - accionSeleccion {A}, accionListado {B}", accionSeleccion, accionListado);

            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.UltimoUsuario = accionListado;
            obj.ACCION = accionSeleccion;
            if (Session["MODULO_DEF"] != null)
            {
            }
            return crearWindowRegistro("SeleccionadorPersonas", obj, "");
        }
        public System.Web.Mvc.ActionResult getSeleccionadorPersonas(String MODO, String persona, String pat, String mat,
            String nom, String tdi, String docide, String docfis, String tipmed, String pais, String depa, String prov,
            String dist, String dire, String orig, String sexo, String fecnac, String estciv, String tel, String cel,
            String tipdoc, String docs, String busq, String nomcomp, String corr, String nivins, String ranet,
            String edad, String lugnac, String nac, String codhc, String codhcant, String codhcsec, String raza,
            String rel, String ubichc, String codase, String rutfot, String fecIng, String arelab, String lugproc,
            String tipalm, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionadorPersonas - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionadorPersonas - Entran más de 20 variables en el parametro - 3 primeros: {A} {B} {C}"
                        , MODO, persona, pat);

            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }

            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
            {
                if (codhc == "")
                {
                    ENTITY_GLOBAL.Instance.CodigoHceRequest = "NO_EXISTE";
                }
                else
                {
                    ENTITY_GLOBAL.Instance.CodigoHceRequest = codhc;
                }

                var txtpersona = X.GetCmp<TextField>("Persona");
                txtpersona.SetValue(persona);
                if (pat != null)
                {
                    var txtpat = X.GetCmp<TextField>("ApellidoPaterno");
                    txtpat.SetValue(pat);
                }
                if (mat != "null")
                {
                    var txtmat = X.GetCmp<TextField>("ApellidoMaterno");
                    txtmat.SetValue(mat);
                }
                if (nom != null)
                {
                    var txtnom = X.GetCmp<TextField>("Nombres");
                    txtnom.SetValue(nom);
                }

                ///aqui 
                ///
                ENTITY_GLOBAL.Instance.NombreCompletoPaciente = pat.ToUpper() + " " + mat.ToUpper() + " " + nom.ToUpper();

                {
                    var txtdocs = X.GetCmp<TextField>("Documento");
                    txtdocs.SetValue(docs);
                }
            }
            else
            {



                var txtpersona = X.GetCmp<TextField>("Persona");
                txtpersona.SetValue(persona);
                if (pat != null)
                {
                    var txtpat = X.GetCmp<TextField>("ApellidoPaterno");
                    txtpat.SetValue(pat);
                }
                if (mat != "null")
                {
                    var txtmat = X.GetCmp<TextField>("ApellidoMaterno");
                    txtmat.SetValue(mat);
                }
                if (busq != "null")
                {
                    var tfBusqueda = X.GetCmp<TextField>("Busqueda");
                    tfBusqueda.SetValue(busq);
                }
                if (estciv != "null")
                {
                    var tfestciv = X.GetCmp<TextField>("EstadoCivil");
                    tfestciv.SetValue(estciv);
                }
                if (tel != "null")
                {
                    var txttel = X.GetCmp<TextField>("Telefono");
                    txttel.SetValue(tel);
                }
                if (cel != "null")
                {
                    var txtcel = X.GetCmp<TextField>("Celular");
                    txtcel.SetValue(cel);
                }

                if (corr != "null")
                {
                    var tfcorr = X.GetCmp<TextField>("CorreoElectronico");
                    tfcorr.SetValue(corr);
                }
                if (nomcomp != "null")
                {
                    var tfNombreCompleto = X.GetCmp<TextField>("NombreCompleto");
                    tfNombreCompleto.SetValue(nomcomp);
                }
                if (nom != null)
                {
                    var txtnom = X.GetCmp<TextField>("Nombres");
                    txtnom.SetValue(nom);
                }
                if (nivins != "null")
                {
                    var tfnivins = X.GetCmp<TextField>("NivelInstruccion");
                    tfnivins.SetValue(nivins);
                }
                if (edad != "null")
                {
                    var tfedad = X.GetCmp<TextField>("edad");
                    tfedad.SetValue(edad);
                }
                if (lugnac != "null")
                {
                    var tflugnac = X.GetCmp<TextField>("LugarNacimiento");
                    tflugnac.SetValue(lugnac);
                }
                if (nac != "null")
                {
                    var tfnac = X.GetCmp<TextField>("Nacionalidad");
                    tfnac.SetValue(nac);
                }
                if (codhc != "null")
                {
                    var tfcodhc = X.GetCmp<TextField>("CodigoHC");
                    tfcodhc.SetValue(codhc);
                }
                if (codhcant != "null")
                {
                    var tfcodhcant = X.GetCmp<TextField>("CodigoHCAnterior");
                    tfcodhcant.SetValue(codhcant);
                }
                if (codhcsec != "null")
                {
                    var tfcodhcsec = X.GetCmp<TextField>("CodigoHCSecundario");
                    tfcodhcsec.SetValue(codhcsec);
                }
                if (raza != "null")
                {
                    var tfraza = X.GetCmp<TextField>("Raza");
                    tfraza.SetValue(raza);
                }
                if (tipalm != "null")
                {
                    var tftipalm = X.GetCmp<TextField>("TipoAlmacenamiento");
                    tftipalm.SetValue(tipalm);
                }
                if (ubichc != "null")
                {
                    var tfubichc = X.GetCmp<TextField>("UbicacionHHCC");
                    tfubichc.SetValue(ubichc);
                }
                if (lugproc != "null")
                {
                    var tflugproc = X.GetCmp<TextField>("LugarProcedencia");
                    tflugproc.SetValue(lugproc);
                }
                if (codase != "null")
                {
                    var tfcodase = X.GetCmp<TextField>("CodigoAsegurado");
                    tfcodase.SetValue(codase);
                }
                if (arelab != "null")
                {
                    var tfarelab = X.GetCmp<TextField>("AreaLaboral");
                    tfarelab.SetValue(arelab);
                }
                if (dire != "null")
                {
                    var txtdire = X.GetCmp<TextField>("Direccion");
                    txtdire.SetValue(dire);
                }
                if (docs != "null")
                {
                    var txtdocs = X.GetCmp<TextField>("Documento");
                    txtdocs.SetValue(docs);
                }
                if (docide != "null")
                {
                    var txtdi = X.GetCmp<TextField>("DocumentoIdentidad");
                    txtdi.SetValue(docide);
                }
                if (docfis != "null")
                {
                    var txtdf = X.GetCmp<TextField>("DocumentoFiscal");
                    txtdf.SetValue(docfis);
                }
                if (pais != "null")
                {
                    var txtidpais = X.GetCmp<TextField>("Pais");
                    txtidpais.SetValue(pais);
                }
                if (depa != "null")
                {
                    var txtiddepa = X.GetCmp<TextField>("Departamento");
                    txtiddepa.SetValue(depa);
                }
                if (prov != "null")
                {
                    var txtidprov = X.GetCmp<TextField>("Provincia");
                    txtidprov.SetValue(prov);
                }
                if (dist != "null")
                {
                    var txtiddist = X.GetCmp<TextField>("CodigoPostal");
                    txtiddist.SetValue(dist);
                }
                try
                {
                    var Listar = new List<MA_MiscelaneosDetalle>();
                    MA_MiscelaneosDetalle objs = new MA_MiscelaneosDetalle();
                    objs.ValorCodigo1 = (getValorFiltroStr(pais) != null ? (getValorFiltroStr(pais)) : "");
                    objs.ValorCodigo2 = (getValorFiltroStr(depa) != null ? (getValorFiltroStr(depa)) : "");
                    objs.ValorCodigo3 = (getValorFiltroStr(prov) != null ? (getValorFiltroStr(prov)) : "");
                    objs.ValorCodigo4 = (getValorFiltroStr(dist) != null ? (getValorFiltroStr(dist)) : "");
                    objs.AplicacionCodigo = "WA";
                    objs.Compania = "999999";
                    objs.CodigoTabla = "TODOLUGAR";
                    objs.ACCION = "COMBOSGENERICO";
                    Listar = SvcMiscelaneos.listarMA_MiscelaneosDetalle(objs, 0, 10);
                    if (Listar.Count == 1)
                    {
                        foreach (var result in Listar)
                        {
                            var txtpais = X.GetCmp<TextField>("tfPais");
                            txtpais.SetValue(result.DescripcionLocal);
                            var txtdepa = X.GetCmp<TextField>("tfDepartamento");
                            txtdepa.SetValue(result.DescripcionExtranjera);
                            var txtprov = X.GetCmp<TextField>("tfProvincia");
                            txtprov.SetValue(result.ValorCodigo6);
                            var txtdist = X.GetCmp<TextField>("tfDistrito");
                            txtdist.SetValue(result.ValorCodigo5);
                        }
                    }
                }
                catch (Exception e)
                {
                    Log.Information("BandejaMedicoController - getSeleccionadorPersonas - Bloque Catch");
                    Log.Error(e, e.Message);
                    return showMensajeBox(e.Message, "Excepción", "ERROR", "");
                }

                var fechita = Convert.ToDateTime(fecnac);
                var txtfecnac = X.GetCmp<DateField>("FechaNacimiento");
                txtfecnac.SetValue(fechita);

                var dffecIng = X.GetCmp<DateField>("FechaIngreso");

                dffecIng.SetValue(getValorFiltroDate(fecIng));


                if (tdi != "null")
                {
                    var txttdi = X.GetCmp<TextField>("TipoDocumentoIdentidad");
                    txttdi.SetValue(tdi);
                }
                if (tipdoc != "null")
                {
                    var txttipdoc = X.GetCmp<TextField>("TipoDocumento");
                    txttipdoc.SetValue(tipdoc);
                }
                if (tipmed != "null")
                {
                    var txttipmed = X.GetCmp<TextField>("TipoMedico");
                    txttipmed.SetValue(tipmed);
                }
                if (orig != "null")
                {
                    var txtorig = X.GetCmp<TextField>("Origen");
                    txtorig.SetValue(orig);
                }
                if (sexo != "null")
                {
                    var txtsexo = X.GetCmp<TextField>("Sexo");
                    txtsexo.SetValue(sexo);
                }
                if (ranet != "null")
                {
                    var cmbRanet = X.GetCmp<TextField>("rangoEtario");
                    cmbRanet.SetValue(ranet);
                }
                if (rel != "null")
                {
                    var cmbRel = X.GetCmp<TextField>("Raza");
                    cmbRel.SetValue(rel);
                }
                if (rutfot != "null")
                {
                    var tfrutfot = X.GetCmp<TextField>("RutaFoto");
                    tfrutfot.SetValue(rutfot);
                }
            }
            return this.Direct();
        }
        /****/
        /**CARGA LAS PROPEDADES DEL FORMULARIO DESDE LA BASE DE DATOS*/
        public bool cargarPropiedadesFormulario(bool activo)
        {
            Log.Information("BandejaMedicoController - cargarPropiedadesFormulario - Entrar");
            Log.Debug("BandejaMedicoController - cargarPropiedadesFormulario - activo {A}", activo);


            Session["RECURSOS_VALFORM"] = null;
            if (activo)
            {
                var CodFormato = ENTITY_GLOBAL.Instance.CONCEPTO;
                var idFormato = ENTITY_GLOBAL.Instance.IDFORMATO;

                List<VW_SS_HC_TABLAFORMATO_VALIDACION> listaResources = new List<VW_SS_HC_TABLAFORMATO_VALIDACION>();
                VW_SS_HC_TABLAFORMATO_VALIDACION objRes = new VW_SS_HC_TABLAFORMATO_VALIDACION();
                objRes.Accion = "LISTARVALIDA";
                objRes.CodigoFormato = CodFormato;
                objRes.IdFormato = Convert.ToInt32(idFormato);
                listaResources = SvcTABLAFORMATOVALIDACION.listarVWTABLAFORMATOVALIDACION(objRes, 0, 0);
                if (listaResources != null)
                {
                    Session["RECURSOS_VALFORM"] = listaResources;
                    /*foreach (var result in listaResources)
                    {
                    }*/
                }
            }
            return true;
        }

        /**SETEA LAS PROPEDADES DEL FORMULARIO EN CADA COMPONENTE UI QUE EXISTA EN LOS RECURSOS CARGADOS*/
        public bool setPropiedadesFormulario(bool activo)
        {
            Log.Information("BandejaMedicoController - setPropiedadesFormulario - Entrar");
            Log.Debug("BandejaMedicoController - setPropiedadesFormulario - activo {A}", activo);
            if (activo)
            {
                if (Session["RECURSOS_VALFORM"] != null)
                {
                    List<VW_SS_HC_TABLAFORMATO_VALIDACION> listaResources = new List<VW_SS_HC_TABLAFORMATO_VALIDACION>();
                    VW_SS_HC_TABLAFORMATO_VALIDACION objRes = new VW_SS_HC_TABLAFORMATO_VALIDACION();
                    listaResources = (List<VW_SS_HC_TABLAFORMATO_VALIDACION>)Session["RECURSOS_VALFORM"];
                    setPropiedadesForm(listaResources);
                }
            }
            return true;
        }
        /*****UTILES CONTRUCCION FORMULARIOS****/
        /**SETEA LAS PROPIEDADES  CARGADAS Y VÁLIDAS PARA EL FORMUALRIO ACTUAL*/
        public static bool setPropiedadesForm(List<VW_SS_HC_TABLAFORMATO_VALIDACION> listaProp)
        {
            Log.Information("BandejaMedicoController - setPropiedadesForm - Entrar");
            Log.Debug("BandejaMedicoController - setPropiedadesForm - listaProp {A}", listaProp);
            if (listaProp != null)
            {
                Dictionary<String, Object> dictComponentes = new Dictionary<String, Object>();
                foreach (var result in listaProp)
                {
                    Object compoTemp = null;
                    if (result.EstadoValidacion == 2 && result.TipoComponente == "EXT")
                    {
                        if (dictComponentes.ContainsKey(result.NombreCampo))
                        {
                            compoTemp = dictComponentes["" + result.NombreCampo];
                        }
                        else
                        {
                            compoTemp = getComponenteForm(result.NombreComponente, 0, result.NombreCampo);
                        }
                        if (compoTemp != null)
                        {
                            //dictComponentes["" + result.NombreCampo] = compoTemp;
                            //dictComponentes.Add("" + result.NombreCampo, compoTemp);
                            //Object compo = getComponenteForm(result.NombreComponente, 0, result.NombreCampo, dictComponentes);
                            Object compo = compoTemp;
                            Object valor = null;
                            if (result.FlagTipoDato == "T")
                            {
                                if (result.ValorTexto != null)
                                {
                                    valor = getValor_FiltroParametros(result.ValorTexto.Trim(), "T");
                                    //valor = result.ValorTexto.Trim();
                                }
                                //valor = (result.ValorTexto != null ? result.ValorTexto.Trim() : "");
                            }
                            else if (result.FlagTipoDato == "N")
                            {
                                valor = result.ValorNumerico;
                            }
                            else if (result.FlagTipoDato == "D")
                            {
                                valor = result.ValorDate;
                            }
                            else if (result.FlagTipoDato == "B")
                            {
                                valor = result.ValorNumerico;
                            }

                            compo = UTILES_MENSAJES.setPropiedadesComponenteForm(compo, result.NombreAtributo, valor, result.FlagTipoDato);
                            if (compo != null)
                            {
                                dictComponentes["" + result.NombreCampo] = compo;
                            }

                        }
                    }
                }
                return true;
            }
            //TextField field01 = X.GetCmp<TextField>("Codigo"); 
            return true;
        }
        /***/
        /**Obtener valor de RECURSO desde PARÁMETRO Si existiera*/
        public static Object getValor_FiltroParametros(String valor, String tipoDato)
        {
            Log.Information("BandejaMedicoController - getValor_FiltroParametros - Entrar");
            Log.Debug("BandejaMedicoController - getValor_FiltroParametros - valor {A},tipoDato {B} ", valor, tipoDato);
            String valorTemp = valor;
            if (valor.Length > 0)
            {
                ////verificamos si posee operador de existencia de Parámetros
                if (valor.Contains(UTILES_MENSAJES.PARAM_OPER_esParam))
                {
                    valorTemp = valor.Replace(UTILES_MENSAJES.PARAM_OPER_esParam, "|" + UTILES_MENSAJES.PARAM_OPER_esParam);
                    string[] vector = valorTemp.Split('|');
                    for (int i = 0; i < vector.Length && valor.Contains(UTILES_MENSAJES.PARAM_OPER_esParam); i++)
                    {
                        if (vector[i].Contains(UTILES_MENSAJES.PARAM_OPER_esParam))
                        {
                            //ARMAR TOKEN EQUIVALENTE A PARAMETRO
                            vector[i] = vector[i].Replace(UTILES_MENSAJES.PARAM_OPER_esParam, "|");
                            vector[i] = vector[i].Replace(" ", "|");
                            vector[i] = vector[i].Replace(";", "|");
                            vector[i] = vector[i].Replace(",", "|");
                            vector[i] = vector[i].Replace(":", "|");
                            vector[i] = vector[i].Replace(".", "|");
                            vector[i] = vector[i].Replace(">", "|");
                            vector[i] = vector[i].Replace("<", "|");
                            vector[i] = vector[i].Replace("[", "|");
                            vector[i] = vector[i].Replace("]", "|");
                            vector[i] = vector[i].Replace("{", "|");
                            vector[i] = vector[i].Replace("}", "|");
                            vector[i] = vector[i].Replace("(", "|");
                            vector[i] = vector[i].Replace(")", "|");
                            vector[i] = vector[i].Replace("-", "|");
                            vector[i] = vector[i].Replace("+", "|");
                            vector[i] = vector[i].Replace("*", "|");
                            vector[i] = vector[i].Replace("/", "|");
                            vector[i] = vector[i].Replace("\n", "|");
                            vector[i] = vector[i].Replace("\t", "|");
                            vector[i] = vector[i].Replace("@", "|");


                            string claveParam = "";
                            Object valorParamTemp = "";
                            string[] vectorSecond = vector[i].Split('|');
                            if (vectorSecond.Length > 1)
                            {
                                claveParam = vectorSecond[1]; //CLAVE PARAMETRO
                                //Obtenermos el valor del parámetro
                                valorParamTemp = UTILES_MENSAJES.loadParametro_Formulario(claveParam, tipoDato, false);
                                if (valorParamTemp != null)
                                {
                                    //REMPLAZAMOS EL PARAMETRO CON SU VERDADERO VALOR
                                    valor = valor.Replace("" + UTILES_MENSAJES.PARAM_OPER_esParam + claveParam, ("" + valorParamTemp).Trim());
                                }
                            }
                        }
                    }
                }
                //UTILES_MENSAJES.PARAM_OPER_esParam
            }
            return valor;
        }
        /***/
        /**OBTIENE EL COMPONENTE UI DEL FORMULARIO DE ACUERDO AL ID Y AL TIPO DE COMPONENTE*/
        public static Object getComponenteForm(String componente, int indicaCompo, String id)
        {
            Log.Information("BandejaMedicoController - getComponenteForm - Entrar");
            Log.Debug("BandejaMedicoController - getComponenteForm - componente {A},indicaCompo {B},id {C}", componente, indicaCompo, id);
            Object compo = null;
            if (componente == "TextField")
            {
                TextField compoX = X.GetCmp<Ext.Net.TextField>("" + id);
                compo = compoX;
            }
            else if (componente == "NumberField")
            {
                NumberField compoX = X.GetCmp<Ext.Net.NumberField>("" + id);
                compo = compoX;
            }
            else if (componente == "TextArea")
            {
                TextArea compoX = X.GetCmp<Ext.Net.TextArea>("" + id);
                //FormPanel compoXXX = X.GetCmp<Ext.Net.FormPanel>("" + id);                

                compo = compoX;
            }
            else if (componente == "DateField")
            {
                DateField compoX = X.GetCmp<Ext.Net.DateField>("" + id);
                compo = compoX;
            }
            else if (componente == "TimeField")
            {
                TimeField compoX = X.GetCmp<Ext.Net.TimeField>("" + id);
                compo = compoX;
            }
            else if (componente == "ComboBox")
            {
                ComboBox compoX = X.GetCmp<Ext.Net.ComboBox>("" + id);
                //FormPanel compoXXX = X.GetCmp<Ext.Net.FormPanel>("" + id);                

                compo = compoX;
            }
            else if (componente == "Radio")
            {
                Radio compoX = X.GetCmp<Ext.Net.Radio>("" + id);
                compo = compoX;
            }
            else if (componente == "RadioGroup")
            {
                RadioGroup compoX = X.GetCmp<Ext.Net.RadioGroup>("" + id);
                compo = compoX;
            }
            else if (componente == "Checkbox")
            {
                Checkbox compoX = X.GetCmp<Ext.Net.Checkbox>("" + id);
                compo = compoX;
            }
            else if (componente == "CheckboxGroup")
            {
                CheckboxGroup compoX = X.GetCmp<Ext.Net.CheckboxGroup>("" + id);
                compo = compoX;
            }
            else if (componente == "Label")
            {
                Label compoX = X.GetCmp<Ext.Net.Label>("" + id);
                compo = compoX;
            }
            else if (componente == "Button")
            {
                Button compoX = X.GetCmp<Ext.Net.Button>("" + id);
                compo = compoX;
            }
            else if (componente == "GridPanel")
            {
                GridPanel compoX = X.GetCmp<Ext.Net.GridPanel>("" + id);
                compo = compoX;
            }
            else if (componente == "TreePanel")
            {
                TreePanel compoX = X.GetCmp<Ext.Net.TreePanel>("" + id);
                compo = compoX;
            }
            return compo;
        }
        /** SALVAR  UBICACION ATENCIóN (Tópico, cama , etc)*/
        public System.Web.Mvc.ActionResult getSaveSeleccionUbicacionAtencionHCE(
            String unidadrep, String tipo, Nullable<int> id, String cod, String descripcion, String idWindow,
            String MODO
            )
        {
            Log.Information("BandejaMedicoController - getSaveSeleccionUbicacionAtencionHCE - Entrar");
            Log.Debug("BandejaMedicoController - getSaveSeleccionUbicacionAtencionHCE - unidadrep {A}, tipo {B}, id {C}, cod {D} ,descripcion {E}, idWindow {F}" +
                            ",MODO {G}", unidadrep, tipo, id, cod, descripcion, idWindow, MODO);
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                int Result = 1;
                VW_ATENCIONPACIENTE_GENERAL objSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];

                MA_MiscelaneosDetalle objSave = new MA_MiscelaneosDetalle();
                objSave.AplicacionCodigo = ENTITY_GLOBAL.Instance.APPCODIGO; //AUX APP CODIGO  (OBG)
                objSave.Compania = unidadrep; //AUX Compa CODIGO  (OBG)
                objSave.CodigoTabla = "UBICACION"; //AUX COD. TABLA o ALGÚN DIFERENCIADOR CODIGO  (OBG)
                objSave.CodigoElemento = "" + objSelecc.IdOrdenAtencion; //AUX ID ORDEN ATENCION (OBG)

                objSave.ValorCodigo1 = tipo; //AUX TIPO UBICACION VIGENTE
                objSave.ValorEntero1 = id; //AUX ID UBICACION VIGENTE
                objSave.ValorEntero2 = objSelecc.IdPaciente; //AUX ID PACIENTE
                /////USAR LA SELECCION DE LA VISITA
                if (ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP != null &&
                    ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP != null)
                {
                    objSave.ValorEntero3 = ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP; //AUX EPI CLINICO
                    objSave.ValorCodigo2 = "" + ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP; //AUX ID EPI ATENCION
                    objSave.ValorEntero4 = objSelecc.IdOrdenAtencion; //AUX IdOrdenAtencion
                    objSave.Estado = "A";
                    objSave.ValorCodigo7 = ENTITY_GLOBAL.Instance.USUARIO;
                    objSave.UltimoUsuario = ENTITY_GLOBAL.Instance.USUARIO;
                    objSave.ACCION = "AGRUPADOR_UBICACIONVIGENTE";
                    objSave.ValorCodigo6 = MODO;
                    Result = SvcMiscelaneos.setMantenimiento(objSave);
                }
                if (Result > 0)
                {
                    Window compoX = X.GetCmp<Ext.Net.Window>(idWindow);
                    if (compoX != null)
                    {
                        compoX.Close();
                    }
                    ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP = null;
                    ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP = null;
                    return showMensajeBox("Se guardaron los cambios correctamente.", "Mensaje", "INFO", "");
                }
                else
                {
                    return showMensajeBox("Sucedio un error. No se pudo guardar los cambios.", "Mensaje", "ERROR", "");
                }
            }

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult beforeSeleccionadorUbicacionAtencion(String accionSeleccion, String accionListado,
            String tipo, String unidadreplicacion, Nullable<int> idpaciente,
            Nullable<long> idepiatencion, Nullable<int> idepiclinico
         )
        {
            Log.Information("BandejaMedicoController - beforeSeleccionadorUbicacionAtencion - Entrar");
            Log.Debug("BandejaMedicoController - beforeSeleccionadorUbicacionAtencion - accionSeleccion {A}, accionListado {B}, tipo {C}, unidadreplicacion {D} ,idpaciente {E}, idepiatencion {F}" +
                            ",idepiclinico {G}", accionSeleccion, accionListado, tipo, unidadreplicacion, idpaciente, idepiatencion, idepiclinico);
            SS_HC_Ubicacion obj = new SS_HC_Ubicacion();
            obj.UsuarioCreacion = accionListado; //AUXILIAR
            obj.Accion = accionSeleccion;
            obj.TipoUbicacion = tipo;
            String MODO = "SELECCION";
            ///////////
            SS_HC_EpisodioAtencion objEpiAtencion = new SS_HC_EpisodioAtencion();
            List<SS_HC_EpisodioAtencion> listaEpiAtencion = new List<SS_HC_EpisodioAtencion>();
            objEpiAtencion.UnidadReplicacion = unidadreplicacion;
            objEpiAtencion.IdPaciente = Convert.ToInt32(idpaciente != null ? idpaciente : 0);
            objEpiAtencion.IdEpisodioAtencion = Convert.ToInt64(idepiatencion != null ? idepiatencion : 0);
            objEpiAtencion.EpisodioClinico = Convert.ToInt32(idepiclinico != null ? idepiclinico : 0);
            objEpiAtencion.Accion = "LISTARPORID";
            listaEpiAtencion = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(objEpiAtencion, 0, 0);

            ENTITY_GLOBAL.Instance.IDEPISODIOATENCION_TEMP = objEpiAtencion.IdEpisodioAtencion;
            ENTITY_GLOBAL.Instance.EPISODIOCLINICO_TEMP = objEpiAtencion.EpisodioClinico;
            ENTITY_GLOBAL.Instance.UNIDREPLICACION_TEMP = objEpiAtencion.UnidadReplicacion;
            if (listaEpiAtencion.Count >= 1)
            {
                Nullable<int> idUbicacion = listaEpiAtencion[0].IdUbicacion;
                if (listaEpiAtencion[0].TipoOrdenAtencion == 11)
                {
                    return showMensajeBox("No se puede asignar una interconsulta a un tópico.", "Advertencia", "WARNING", "");
                }

                //Se verifica si ya existe asignado el TIPO y el ID de ubicación para la atención seleccionada
                //(El tipo debe ser el mismo si no se permitirá asignar nuevamente)
                if (idUbicacion != null && idUbicacion > 0 && tipo == listaEpiAtencion[0].TipoUbicacion)
                {
                    MODO = "VER";
                }
                return SeleccionadorUbicacionAtencion(accionSeleccion, accionListado, MODO, tipo, unidadreplicacion, idUbicacion);

            }
            else
            {
                return showMensajeBox("No se puede asignar una interconsulta a un tópico.", "Advertencia", "WARNING", "");
            }

            //return crearWindowRegistro("Procesos/SeleccionadorUbicacionAtencion", obj, "");
        }

        /** SELECCIONADOR UBICACION ATENCIO (Tópico, cama , etc)*/
        public System.Web.Mvc.ActionResult SeleccionadorUbicacionAtencion(String accionSeleccion, String accionListado,
            String MODO, String tipo, String unidadreplicacion, Nullable<int> id
            )
        {
            Log.Information("BandejaMedicoController - SeleccionadorUbicacionAtencion - Entrar");
            Log.Debug("BandejaMedicoController - SeleccionadorUbicacionAtencion - accionSeleccion {A}, accionListado {B}, MODO {C}, tipo {D} ,unidadreplicacion {E}, id {F}"
                , accionSeleccion, accionListado, MODO, tipo, unidadreplicacion, id);
            SS_HC_Ubicacion obj = new SS_HC_Ubicacion();
            obj.UsuarioCreacion = accionListado; //AUXILIAR
            obj.Accion = accionSeleccion;
            obj.TipoUbicacion = tipo;
            obj.UnidadReplicacion = unidadreplicacion;
            obj.IdUbicacion = Convert.ToInt32(id != null ? id : 0);
            obj.Ruta = MODO;
            return crearWindowRegistro("Procesos/SeleccionadorUbicacionAtencion", obj, "");
        }
        public System.Web.Mvc.ActionResult getGrillaUbicacion(int start, int limit,
            string nombre, string sucursal, string idubicacion, string tipoubicacion, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaUbicacion - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaUbicacion - start {A}, limit {B}, nombre {C}, sucursal {D} ,idubicacion {E}, tipoubicacion {F},tipoBuscar {G}"
                , start, limit, nombre, sucursal, idubicacion, tipoubicacion, tipoBuscar);
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<SS_HC_Ubicacion>();
                var LocalEnty = new SS_HC_Ubicacion();
                LocalEnty.TipoUbicacion = getValorFiltroStr(tipoubicacion);
                LocalEnty.UnidadReplicacion = getValorFiltroStr(sucursal);
                if (getValorFiltroInt(idubicacion) != null)
                {
                    LocalEnty.IdUbicacion = Convert.ToInt32(getValorFiltroInt(idubicacion));
                }

                LocalEnty.Nombre = getValorFiltroStr(nombre);
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }
                LocalEnty.Accion = "LISTARPAGSELEC";
                int cantElementos = SvcSSHCUbicacion.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = "LISTARPAGSELEC";
                    Listar = SvcSSHCUbicacion.listarSSHCUbicacion(LocalEnty, inicio, final);
                }
                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - getGrillaUbicacion - Bloque Catch");
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
        /****************/

        /*****LISTADO DOCUMENTO PACIENTE*****/
        public System.Web.Mvc.ActionResult getGrillaDocumentoListado(string codigo, string tipoBuscar, int start, int limit)
        {
            Log.Information("BandejaMedicoController - getGrillaDocumentoListado - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaDocumentoListado - codigo {A}, tipoBuscar {B}, start {C}, limit {D}"
                , start, codigo, tipoBuscar, start, limit);
            ENTITY_GLOBAL.Instance.GRUPO = "";

            var Listar = new List<SS_HC_PacienteDocumentos>();

            var LocalEnty = new SS_HC_PacienteDocumentos();
            LocalEnty.IdPaciente = (getValorFiltroInt(codigo) != null ? Convert.ToInt32(getValorFiltroInt(codigo)) : 0);

            int ini = (start == 0 ? start : start + 1);
            int fin = start + limit;

            //LocalEnty.Accion = "LISTARPAG";
            int cantElementos = 1;//SvcPacDoc.setMantenimiento(LocalEnty);
            if (cantElementos > 0)
            {
                LocalEnty.Accion = "LISTARPAG";
                LocalEnty.NumeroDocumento = ENTITY_GLOBAL.Instance.CodigoOA;
                Listar = SvcPacDoc.listarPacDoc(LocalEnty, ini, fin);
            }
            return this.Store(Listar, cantElementos);
        }
        public System.Web.Mvc.ActionResult DocumentoListado(String MODO, String idPaciente)
        {
            Log.Information("BandejaMedicoController - DocumentoListado - Entrar");
            Log.Debug("BandejaMedicoController - DocumentoListado - MODO {A}, idPaciente{B}"
                , MODO, idPaciente);
            var Listar = new List<SS_HC_PacienteDocumentos>();

            SS_HC_PacienteDocumentos objFiltro = new SS_HC_PacienteDocumentos();
            if (MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER" || MODO == "LISTAR")
            {
                objFiltro.Accion = "LISTAR";
                objFiltro.IdPaciente = Convert.ToInt32(getValorFiltroInt(idPaciente));
                Listar = SvcPacDoc.listarPacDoc(objFiltro, 0, 0);
                if (Listar.Count == 1)
                {
                    foreach (SS_HC_PacienteDocumentos objEntity in Listar)
                    {
                        objFiltro = objEntity;
                    }
                }
            }
            else if (MODO == "NUEVO")
            {
                objFiltro.Accion = "NUEVO";
            }
            objFiltro.Accion = MODO;
            return crearWindowRegistro("ActosMedicos/DocumentoListado", objFiltro, "");
        }
        /******FIN*****/
        /**Medicos Emergencia*/
        public System.Web.Mvc.ActionResult CCEP9002_View()
        {
            Log.Information("BandejaMedicoController - CCEP9002_View - Entrar");
            /**VERIFICAR ESPECIALIDAD*/

            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE
            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);

            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            return View("ActosMedicos/CCEP9002_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Medicos Hospitalización*/
        public System.Web.Mvc.ActionResult CCEP9003_View()
        {
            Log.Information("BandejaMedicoController - CCEP9003_View - Entrar");
            /**VERIFICAR ESPECIALIDAD*/

            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE
            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            return View("ActosMedicos/CCEP9003_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Medicos Cirugía*/
        public System.Web.Mvc.ActionResult CCEP9004_View()
        {
            /**VERIFICAR ESPECIALIDAD*/
            Log.Information("BandejaMedicoController - CCEP9004_View - Entrar");
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            return View("ActosMedicos/CCEP9004_View", ENTITY_GLOBAL.Instance);//            
        }

        /**Tecnólogo Médico Ambulatorio*/
        public System.Web.Mvc.ActionResult CCEP9005_View()
        {
            Log.Information("BandejaMedicoController - CCEP9005_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            //  var txtMedicoNom = X.GetCmp<TextField>("txtMedicoSolicitante");
            //Session["NOMBRE_MEDICO"] = objUsuario.Nombre;
            //txtMedicoNom.SetValue((string)Session["NOMBRE_MEDICO"]);
            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9005_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Tecnólogo Médico Emergencia*/
        public System.Web.Mvc.ActionResult CCEP9006_View()
        {
            Log.Information("BandejaMedicoController - CCEP9006_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9006_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Tecnólogo Médico Hospitalización*/
        public System.Web.Mvc.ActionResult CCEP9007_View()
        {
            Log.Information("BandejaMedicoController - CCEP9007_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }

            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9007_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Tecnólogo Médico Cirugía*/
        public System.Web.Mvc.ActionResult CCEP9008_View()
        {
            Log.Information("BandejaMedicoController - CCEP9008_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }

            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9008_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Enfermera Emergencia*/
        public System.Web.Mvc.ActionResult CCEP9009_View()
        {
            Log.Information("BandejaMedicoController - CCEP9009_View - Entrar");
            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9009_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Enfermera Hospitalaria*/
        public System.Web.Mvc.ActionResult CCEP9010_View()
        {
            Log.Information("BandejaMedicoController - CCEP9010_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }

            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9010_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Enfermera Cirugía*/
        public System.Web.Mvc.ActionResult CCEP9011_View()
        {
            Log.Information("BandejaMedicoController - CCEP9011_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }

            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9011_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Obstetra  Emergencia*/
        public System.Web.Mvc.ActionResult CCEP9012_View()
        {
            Log.Information("BandejaMedicoController - CCEP9012_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }

            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9012_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Obstetra  Hospitalaria*/
        public System.Web.Mvc.ActionResult CCEP9013_View()
        {
            Log.Information("BandejaMedicoController - CCEP9013_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }

            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9013_View", ENTITY_GLOBAL.Instance);//            
        }
        /**Obstetra  Cirugía*/
        public System.Web.Mvc.ActionResult CCEP9014_View()
        {
            Log.Information("BandejaMedicoController - CCEP9014_View - Entrar");
            //TIPO TRABAJADOR ACTUAL
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }

            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            return View("ActosMedicos/CCEP9014_View", ENTITY_GLOBAL.Instance);
        }


        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientesActosMedicos(int start, int limit, string txtHC,
        string txtFecha1, string txtFecha2, string txtHCA, string txtCodigoOA, string txtMedico, string txtPaciente,
            string idPaciente, string idOrdenAtencion,
            string tipoConsulta, string tipoEstado, string tipoServicio, string idespecialidad, string tipoBuscar, string tipoListado, string codcomponente,
            string NombComponente, string txtMedicoSolicitante, string unidadReplicacion)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesActosMedicos - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesActosMedicos - start {A}, limit {B}, txtHC {C}, txtFecha1 {D} ,txtFecha2 {E}, txtHCA {F}" +
                            ",txtCodigoOA {G}, txtPaciente {H},tipoConsulta {I}, tipoEstado {J},  tipoBuscar {K}, tipoListado {L} , existen más parametros ..."
                        , start, limit, txtHC, txtFecha1, txtFecha2, txtHCA, txtCodigoOA, txtPaciente, tipoConsulta, tipoEstado, tipoBuscar, tipoListado);
            int cantElementos = 0;
            var ListarGeneral = new List<VW_ATENCIONPACIENTE_GENERAL>();
            var ListarGeneralOrder = new List<VW_ATENCIONPACIENTE_GENERAL>();
            try
            {
                ////////////////                
                var objGenral = new VW_ATENCIONPACIENTE_GENERAL();
                Session["Ssesion_ListarPaciiente"] = null;

                //ConsultaCita();
                //var field = X.GetCmp<TextField>("txtPaciente");            
                var Listar = new List<VW_ATENCIONPACIENTE>();
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
                    objGenral.FechaInicio = Convert.ToDateTime(txtFecha1);
                }
                else
                {
                    var FechaX = DateTime.Now;
                    FechaX.AddDays(-30);
                    objGenral.FechaInicio = FechaX;

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
                    txtFecha2 = txtFecha2.Replace("\"", "");
                    LocalEnty.FecFinDiscamec = Convert.ToDateTime(txtFecha2);
                    objGenral.FechaFin = Convert.ToDateTime(txtFecha2);
                }
                else
                {
                    objGenral.FechaFin = DateTime.Now;
                }

                double PARAFILTROFEcahora = 0;
                decimal PARAFILTROFECHA = (decimal)UTILES_MENSAJES.getParametro_Form("ACTIVIDDIA");
                double nrfec = 0;
                PARAFILTROFEcahora = Convert.ToDouble(PARAFILTROFECHA);
                nrfec = (Convert.ToDateTime(objGenral.FechaFin) - Convert.ToDateTime(objGenral.FechaInicio)).TotalDays;

                if (nrfec > PARAFILTROFEcahora)
                {
                    DateTime FechaXX = Convert.ToDateTime(objGenral.FechaFin);
                    objGenral.FechaInicio = FechaXX.AddDays(-PARAFILTROFEcahora);
                }

                /**LISTADO*/

                objGenral.CodigoHC = ((txtHC + "").Trim().Length == 0 ? null : txtHC);
                objGenral.CodigoHCAnterior = ((txtHCA + "").Trim().Length == 0 ? null : txtHCA);
                objGenral.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                objGenral.MedicoNombre = ((txtMedico + "").Trim().Length == 0 ? null : txtMedico);
                objGenral.PacienteNombre = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                objGenral.EstadoEpiAtencion = getValorFiltroInt(tipoEstado);
                objGenral.IdEspecialidad = getValorFiltroInt(idespecialidad);
                objGenral.Accion = tipoListado;
                objGenral.tipoListado = tipoListado;

                objGenral.TipoOrdenAtencion = getValorFiltroInt(tipoServicio);
                objGenral.Componente = codcomponente;
                //objGenral.ComponenteNombre = NombComponente;
                objGenral.UsuarioModificacion = NombComponente;
                objGenral.UsuarioCreacion = ((txtMedicoSolicitante + "").Trim().Length == 0 ? null : txtMedicoSolicitante); ;
                objGenral.UnidadReplicacionEC = unidadReplicacion;
                //  objGenral.MedicoNombre = medicoSolicitante;

                objGenral.IdPaciente = getValorFiltroInt(idPaciente);
                objGenral.IdOrdenAtencion = Convert.ToInt32(getValorFiltroInt(idOrdenAtencion));
                //ListarGeneral = SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(objGenral, ini, fin);
                objGenral.IdMedico = ENTITY_GLOBAL.Instance.CODPERSONA;
                objGenral.NumeroFila = ini;
                objGenral.Contador = fin;
                /**ADD CONFIGURACIÓN*/
                ENTITY_GLOBAL.Instance.COD_HCEBANDEJA = tipoListado;
                objGenral.Compania = ENTITY_GLOBAL.Instance.Compania;
                objGenral.Sucursal = ENTITY_GLOBAL.Instance.Sucursal;
                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objGenral.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                {
                    objGenral.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                }
                ///////////ADD TIPO ATENCiÓN
                objGenral.TipoAtencion = getTipoAtencionActoMedico(tipoListado);

                //String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") != null ?
                //        (String)UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") : null);
                String PARAM = ENTITY_GLOBAL.Instance.ACTIVOSOA;
                ListarGeneral = SOA_AtencionesSpring.ListaAtencionesHCE(objGenral, PARAM);
                if (tipoListado == "MED_EMERGENCIA2" || tipoListado == "ENFERM_EMERGENCIAS")
                {
                    ENTITY_GLOBAL.Instance.INDICADOR_EMER = "MED_EMERGENCIA";
                }
                else if (tipoListado == "MED_HOSP_CIRUGIA")
                {
                    ENTITY_GLOBAL.Instance.INDICADOR_EMER = "MED_HOSPI";
                }
                else
                {
                    ENTITY_GLOBAL.Instance.INDICADOR_EMER = "";
                }
                if (ListarGeneral.Count > 0)
                {
                    cantElementos = ListarGeneral[0].Contador;
                    //String PARAMRULE = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
                    //(String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
                    String PARAMRULE = ENTITY_GLOBAL.Instance.ACTIVORULE;
                    if (PARAMRULE == "S")
                    {
                        if (tipoListado.Contains("EMERGENCIA"))
                        {
                            foreach (VW_ATENCIONPACIENTE_GENERAL result in ListarGeneral)
                            {
                                if (result.EstadoEpiAtencion == 0)
                                {
                                    Boolean resultRegla = POSaludEmergenciaEsperaAlter(result, 0, "POSaludEmergenciaEspera");
                                    if (resultRegla)
                                    {
                                        result.IndicadorExamenPrincipal = 1;
                                    }
                                    else
                                    {
                                        result.IndicadorExamenPrincipal = 0;
                                    }
                                }
                            }
                        }
                    }
                    ListarGeneralOrder = ListarGeneral.OrderBy(x => x.EstadoEpiAtencion).ToList();
                    /**MATCH CON EPISODIOS DE ATENCIÓN*/
                    //hecho en la capa de servicio
                }
                return this.Store(ListarGeneralOrder, cantElementos);

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesActosMedicos - Bloque Catch");
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
        /***************************************GRILLA AUDITORIA**********************************/

        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientesActosMedicos_Auditoria(int start, int limit, string txtHC,
           string txtFecha1, string txtFecha2, string txtHCA, string txtCodigoOA, string txtMedico, string txtPaciente,
           string idPaciente, string idOrdenAtencion,
           string tipoConsulta, string tipoEstado, string idespecialidad, string tipoBuscar, string tipoListado)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesActosMedicos_Auditoria - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesActosMedicos_Auditoria - start {A}, limit {B}, txtHC {C}, txtFecha1 {D} ,txtFecha2 {E}, txtHCA {F}" +
                            ",txtCodigoOA {G}, txtPaciente {H},tipoConsulta {I}, tipoEstado {J},  tipoBuscar {K}, tipoListado {L}, existen mas parametros..."
                        , start, limit, txtHC, txtFecha1, txtFecha2, txtHCA, txtCodigoOA, txtPaciente, tipoConsulta, tipoEstado, tipoBuscar, tipoListado);
            int cantElementos = 0;
            var ListarGeneral = new List<VW_ATENCIONPACIENTE_GENERAL>();
            try
            {
                if (tipoBuscar == "FILTRO")
                {
                    ////////////////                
                    var objGenral = new VW_ATENCIONPACIENTE_GENERAL();
                    Session["Ssesion_ListarPaciiente"] = null;
                    //ConsultaCita();
                    //var field = X.GetCmp<TextField>("txtPaciente");             
                    var Listar = new List<VW_ATENCIONPACIENTE>();
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
                        objGenral.FechaInicio = Convert.ToDateTime(txtFecha1);
                    }
                    else
                    {
                        var FechaX = DateTime.Now;
                        FechaX.AddDays(-30);
                        objGenral.FechaInicio = FechaX;

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
                        objGenral.FechaFin = Convert.ToDateTime(txtFecha2);
                    }
                    else
                    {
                        objGenral.FechaFin = DateTime.Now;
                    }

                    double PARAFILTROFEcahora = 0;
                    decimal PARAFILTROFECHA = (decimal)UTILES_MENSAJES.getParametro_Form("ACTIVIDDIA");
                    double nrfec = 0;
                    PARAFILTROFEcahora = Convert.ToDouble(PARAFILTROFECHA);
                    nrfec = (Convert.ToDateTime(objGenral.FechaFin) - Convert.ToDateTime(objGenral.FechaInicio)).TotalDays;

                    if (nrfec > PARAFILTROFEcahora)
                    {
                        DateTime FechaXX = Convert.ToDateTime(objGenral.FechaFin);
                        objGenral.FechaInicio = FechaXX.AddDays(-PARAFILTROFEcahora);
                    }

                    /**LISTADO*/

                    objGenral.CodigoHC = ((txtHC + "").Trim().Length == 0 ? null : txtHC);
                    objGenral.CodigoHCAnterior = ((txtHCA + "").Trim().Length == 0 ? null : txtHCA);
                    objGenral.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                    objGenral.MedicoNombre = ((txtMedico + "").Trim().Length == 0 ? null : txtMedico);
                    objGenral.PacienteNombre = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                    objGenral.EstadoEpiAtencion = getValorFiltroInt(tipoEstado);
                    objGenral.IdEspecialidad = getValorFiltroInt(idespecialidad);
                    objGenral.Accion = tipoListado;
                    objGenral.tipoListado = tipoListado;
                    objGenral.IdPaciente = getValorFiltroInt(idPaciente);
                    objGenral.IdOrdenAtencion = Convert.ToInt32(getValorFiltroInt(idOrdenAtencion));
                    //ListarGeneral = SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(objGenral, ini, fin);
                    objGenral.IdMedico = ENTITY_GLOBAL.Instance.CODPERSONA;
                    objGenral.NumeroFila = ini;
                    objGenral.Contador = fin;
                    /**ADD CONFIGURACIÓN*/
                    ENTITY_GLOBAL.Instance.COD_HCEBANDEJA = tipoListado;
                    objGenral.Compania = ENTITY_GLOBAL.Instance.Compania;
                    objGenral.Sucursal = ENTITY_GLOBAL.Instance.Sucursal;
                    objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objGenral.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                    if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                    {
                        objGenral.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                    }
                    ///////////ADD TIPO ATENCiÓN
                    objGenral.TipoAtencion = getTipoAtencionActoMedico(tipoListado);

                    //String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") != null ?
                    //        (String)UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") : null);
                    String PARAM = ENTITY_GLOBAL.Instance.ACTIVOSOA;
                    ListarGeneral = SOA_AtencionesSpring.ListaAtencionesHCE(objGenral, PARAM);

                    if (ListarGeneral.Count > 0)
                    {
                        cantElementos = ListarGeneral[0].Contador;
                        //String PARAMRULE = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
                        //(String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
                        String PARAMRULE = ENTITY_GLOBAL.Instance.ACTIVORULE;
                        if (PARAMRULE == "S")
                        {
                            if (tipoListado.Contains("EMERGENCIA"))
                            {
                                foreach (VW_ATENCIONPACIENTE_GENERAL result in ListarGeneral)
                                {
                                    if (result.EstadoEpiAtencion == 0)
                                    {
                                        Boolean resultRegla = POSaludEmergenciaEsperaAlter(result, 0, "POSaludEmergenciaEspera");
                                        if (resultRegla)
                                        {
                                            result.IndicadorExamenPrincipal = 1;
                                        }
                                        else
                                        {
                                            result.IndicadorExamenPrincipal = 0;
                                        }
                                    }
                                }
                            }
                        }
                        /**MATCH CON EPISODIOS DE ATENCIÓN*/
                        //hecho en la capa de servicio
                    }
                }
                return this.Store(ListarGeneral, cantElementos);

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesActosMedicos_Auditoria - Bloque Catch");
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

        /*****************************************************************************************/
        public System.Web.Mvc.ActionResult CCEP7005_View()
        {
            Log.Information("BandejaMedicoController - CCEP7005_View - Entrar");
            return View();
        }

        public System.Web.Mvc.ActionResult UrlHClinica()
        {
            Log.Information("BandejaMedicoController - UrlHClinica - Entrar");
            return this.RedirectToAction("Index", "HClinica");
        }

        /**MENSAJES*/
        public System.Web.Mvc.ActionResult showMensajeBotton(List<ENTITY_MENSAJES> listaMsgNoValido, String titulo, String tipo)
        {
            Log.Information("BandejaMedicoController - showMensajeBotton - Entrar");
            Log.Debug("BandejaMedicoController - showMensajeBotton - listaMsgNoValido {A}, titulo {B}, tipo {C}", listaMsgNoValido, titulo, tipo);
            if (listaMsgNoValido != null)
            {
                return this.Store(listaMsgNoValido);
            }
            else
            {
                return this.Direct();
            }
        }

        public System.Web.Mvc.ActionResult showMensajeBox(String message, String titulo, String tipo, String nombrefn)
        {
            Log.Information("BandejaMedicoController - showMensajeBox - Entrar");
            Log.Debug("BandejaMedicoController - showMensajeBox - message {A}, titulo {B}, tipo {C},nombrefn {D}", message, titulo, tipo, nombrefn);
            X.Msg.Show(new MessageBoxConfig
            {
                Title = titulo,
                Message = message,
                Buttons = MessageBox.Button.OK,
                Icon = (MessageBox.Icon)Enum.Parse(typeof(MessageBox.Icon), tipo),
                Fn = new JFunction
                {
                    Fn = nombrefn // "accionFinal"
                }

            });
            return this.Direct();

        }
        /**Terminar y cerrar Window y mostrar mensaje*/
        public System.Web.Mvc.ActionResult cerrarWindow(String id)
        {
            Log.Information("BandejaMedicoController - cerrarWindow - Entrar");
            Log.Debug("BandejaMedicoController - cerrarWindow - id {A}", id);
            var win = X.GetCmp<Window>(id);
            if (win != null)
            {
                win.Hide();
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult terminarShowMensajeBox(String idWindow, String message, String titulo, String tipo, String nombrefn)
        {
            Log.Information("BandejaMedicoController - terminarShowMensajeBox - Entrar");
            Log.Debug("BandejaMedicoController - terminarShowMensajeBox - message {A}, titulo {B}, tipo {C},nombrefn {D} , idWindow {E}", message, titulo, tipo, nombrefn, idWindow);
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            return showMensajeBox(message, titulo, tipo, nombrefn);
        }

        /**UTILES*/
        public System.Web.Mvc.ActionResult crearWindowRegistro(String url, Object objModel, String titulo)
        {
            Log.Information("BandejaMedicoController - crearWindowRegistro - Entrar");
            Log.Debug("BandejaMedicoController - crearWindowRegistro - url {A}, objModel {B}, titulo {C}", url, objModel, titulo);
            return new Ext.Net.MVC.PartialViewResult
            {
                ViewName = url,
                Model = objModel
            };
        }
        /***/
        public Ext.Net.MVC.PartialViewResult crearWindowRegistro(String Form, Object objModel, String titulo, String FormContainer)
        {
            Log.Information("BandejaMedicoController - crearWindowRegistro - Entrar");
            Log.Debug("BandejaMedicoController - crearWindowRegistro - Form {A}, objModel {B}, titulo {C},FormContainer {D}", Form, objModel, titulo, FormContainer);
            return new PartialViewResult
            {
                ViewName = Form,
                ContainerId = FormContainer,
                Model = objModel,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };
        }

        /**Metodo para retornar el valor correcto del filtro*/
        public String getValorFiltroStr(String filtro)
        {
            //Log.Information("BandejaMedicoController - getValorFiltroStr - Entrar");
            //Log.Debug("BandejaMedicoController - getValorFiltroStr - filtro {A}", filtro);
            if (filtro != null)
            {
                if (filtro == "null")
                {
                    filtro = null;
                }
                else if (filtro.Trim().Length == 0)
                {
                    filtro = null;
                }
            }
            if (filtro != null)
            {
                return filtro.Trim();
            }
            return null;
        }
        public Nullable<int> getValorFiltroInt(String filtro)
        {
            //Log.Information("BandejaMedicoController - getValorFiltroInt - Entrar");
            //Log.Information("BandejaMedicoController - getValorFiltroInt - filtro " + filtro);
            if (filtro != null)
            {
                if (filtro == "null")
                {
                    filtro = null;
                }
                else if (filtro.Trim().Length == 0)
                {
                    filtro = null;
                }
            }
            if (filtro != null)
            {
                return Convert.ToInt32(filtro);
            }
            return null;
        }
        public Nullable<DateTime> getValorFiltroDate(String filtro)
        {
            Log.Information("BandejaMedicoController - getValorFiltroDate - Entrar");
            Log.Debug("BandejaMedicoController - getValorFiltroDate - filtro {A}", filtro);
            try
            {
                if (filtro != null)
                {
                    if (filtro == "null")
                    {
                        filtro = null;
                    }
                    else if (filtro.Trim().Length == 0)
                    {
                        filtro = null;
                    }
                }
                if (filtro != null)
                {
                    filtro = filtro.Replace("\"", "");
                    return Convert.ToDateTime(filtro);
                }
            }
            catch (Exception e)
            {
                Log.Information("BandejaMedicoController - getValorFiltroDate - Bloque Catch");
                Log.Error(e, e.Message);
            }
            return null;
        }
        /**FIN**/
        #endregion
        #region Registos_ActoMedico
        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientes(int start, int limit, string txtHC,
           string txtFecha1, string txtFecha2, string txtMedico, string txtHCA, string txtCodigoOA, string txtPaciente,
           string tipoConsulta, string tipoEstado, string tipoBuscar, string estadoAsigMedico)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientes - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientes - start {A}, limit {B}, txtHC {C}, txtFecha1 {D} ,txtFecha2 {E}, txtHCA {F}" +
                            ",txtCodigoOA {G}, txtPaciente {H},tipoConsulta {I}, tipoEstado {J},  tipoBuscar {K}, existen mas parametros ..."
                        , start, limit, txtHC, txtFecha1, txtFecha2, txtHCA, txtCodigoOA, txtPaciente, tipoConsulta, tipoEstado, tipoBuscar);

            int cantElementos = 0;
            var Listar = new List<VW_ATENCIONPACIENTE>();
            try
            {
                ////////////////
                ENTITY_GLOBAL.Instance.GRUPO = "";
                Session["Ssesion_ListarPaciiente"] = null;
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

                //double PARAFILTROFEcahora = 0;
                //decimal PARAFILTROFECHA = (decimal)UTILES_MENSAJES.getParametro_Form("ACTIVIDDIA");
                //double nrfec = 0;               
                //PARAFILTROFEcahora = Convert.ToDouble(PARAFILTROFECHA);
                //nrfec = (Convert.ToDateTime(objGenral.FechaFin) - Convert.ToDateTime(objGenral.FechaInicio)).TotalDays;

                //if (nrfec > PARAFILTROFEcahora)
                //{
                //    DateTime FechaXX = Convert.ToDateTime(objGenral.FechaFin);
                //    objGenral.FechaInicio = FechaXX.AddDays(-PARAFILTROFEcahora);
                //}

                LocalEnty.CodigoHC = ((txtHC + "").Trim().Length == 0 ? null : txtHC);
                LocalEnty.CodigoHCAnterior = ((txtHCA + "").Trim().Length == 0 ? null : txtHCA);
                LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);



                var ACCIONlistado = "";
                if (tipoConsulta == "FIRMAACTOS")
                {
                    ACCIONlistado = "LISTARPAG_FIRMAMEDICO";
                }
                else
                {
                    LocalEnty.Servicio = tipoConsulta;
                    ACCIONlistado = "LISTARPAGSELECPACIENTEOA";
                }
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);
                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;

                /**ADD CONFIGURACIÓN*/

                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                LocalEnty.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                {
                    LocalEnty.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                }
                ///////////

                ////ESTADO ASIGNACION MEDICO
                LocalEnty.NumeroFile = getValorFiltroInt(estadoAsigMedico);            //AUX ESTADO ASIG MEDICO

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
                Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientes - Bloque Catch");
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
        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientesContinuar(int start, int limit,
     string txtFecha1, string txtFecha2, string txtCodigoOA, string txtPaciente,
     string tipoConsulta, string tipoEstado, string idPaciente, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - start {A}, limit {B}, txtFecha1 {D} ,txtFecha2 {E}" +
                            ",txtCodigoOA {G}, txtPaciente {H},tipoConsulta {I}, tipoEstado {J},  tipoBuscar {K}, existen mas parametros ..."
                        , start, limit, txtFecha1, txtFecha2, txtCodigoOA, txtPaciente, tipoConsulta, tipoEstado, tipoBuscar);
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
                var ACCIONlistado = "LISTARPAG";
                if (tipoConsulta == "CONTINUAR")
                {
                    LocalEnty.Servicio = "EPISODIO"; //AUX para listar solo los Creados como EPISODIOS
                    ACCIONlistado = "LISTARPAG";
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
        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientesVisita(int start, int limit,
     string txtFecha1, string txtFecha2, string tipoAtencion, string episodioClinico,
     string tipoConsulta, string tipoEstado, string idPaciente,
             string idOrdenAtencion, string lineaOrdenAtencion,
            string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesVisita - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesVisita - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} ,tipoConsulta {E}, tipoEstado {F}" +
                            ",tipoBuscar {G}, existen mas parametros"
                        , start, limit, txtFecha1, txtFecha2, tipoConsulta, tipoEstado, tipoBuscar);
            int cantElementos = 0;

            var Listar = new List<VW_ATENCIONPACIENTE>();
            try
            {
                var LocalEnty = new VW_ATENCIONPACIENTE();
                int ini = (start == 0 ? start : start + 1);
                int fin = start + limit;
                Session["Ssesion_ListarPaciiente"] = null;
                if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }
                if (tipoBuscar == "MEDICOS" || tipoBuscar == "LOADM") { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = "MEDICOS"; }
                else if (tipoBuscar == "FILTROR" && ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA == "MEDICOS") { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = "MEDICOS"; }
                else if (tipoBuscar == "NADA" || tipoBuscar == "LOADN") { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = ""; }
                else { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = ""; }

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
                //LocalEnty.Estado = getValorFiltroInt(tipoEstado);  2018/01/24 Jordan Mateo
                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                LocalEnty.IdPaciente = getValorFiltroInt(idPaciente);
                LocalEnty.EpisodioClinico = getValorFiltroInt(episodioClinico);

                /**ADD CONFIGURACIÓN*/
                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                LocalEnty.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                {
                    LocalEnty.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                }
                ///////////
                LocalEnty.LineaOrdenAtencion = getValorFiltroInt(lineaOrdenAtencion);
                LocalEnty.IdOrdenAtencion = getValorFiltroInt(idOrdenAtencion);

                var ACCIONlistado = "";
                if (tipoConsulta == "VISITA")
                {
                    ACCIONlistado = "LISTARPAG";
                }

                LocalEnty.Accion = ACCIONlistado;
                LocalEnty.Nacionalidad = "08";
                cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = ACCIONlistado;

                    Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
                    Listar = Listar.OrderBy(order => order.IdTipoOrden).ToList();
                }
                if (ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA == "MEDICOS")
                {
                    LocalEnty.Accion = "LISTARESPE";
                    LocalEnty.IdEspecialidad = ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER;
                    cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                    Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
                    Listar = Listar.OrderBy(order => order.IdTipoOrden).ToList();
                }
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesVisita - Bloque Catch");
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


        public System.Web.Mvc.ActionResult GrillaListadoAtencionPacientesVisitaEnf(int start, int limit, string txtFecha1, string txtFecha2, string tipoAtencion, string episodioClinico,
            string tipoConsulta, string tipoEstado, string idPaciente, string idOrdenAtencion, string lineaOrdenAtencion, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesVisitaEnf - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesVisitaEnf - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} ,tipoConsulta {E}, tipoEstado {F}" +
                            ",tipoBuscar {G}, existen mas parametros"
                        , start, limit, txtFecha1, txtFecha2, tipoConsulta, tipoEstado, tipoBuscar);
            int cantElementos = 0;

            var Listar = new List<VW_ATENCIONPACIENTE>();
            try
            {
                Session["Ssesion_ListarPaciiente"] = null;
                var LocalEnty = new VW_ATENCIONPACIENTE();
                int ini = (start == 0 ? start : start + 1);
                int fin = start + limit;
                //Si la busqueda proviene de filtros
                if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }
                if (tipoBuscar == "MEDICOS" || tipoBuscar == "LOADM") { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = "MEDICOS"; }
                else if (tipoBuscar == "FILTROR" && ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA == "MEDICOS") { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = "MEDICOS"; }
                else if (tipoBuscar == "NADA" || tipoBuscar == "LOADN") { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = ""; }
                else { ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA = ""; }

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

                //LocalEnty.Estado = getValorFiltroInt(tipoEstado);  2018/01/24 Jordan Mateo
                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                LocalEnty.IdPaciente = getValorFiltroInt(idPaciente);
                LocalEnty.EpisodioClinico = getValorFiltroInt(episodioClinico);

                /**ADD CONFIGURACIÓN*/
                LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                LocalEnty.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                {
                    LocalEnty.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                }
                ///////////
                LocalEnty.LineaOrdenAtencion = getValorFiltroInt(lineaOrdenAtencion);
                LocalEnty.IdOrdenAtencion = getValorFiltroInt(idOrdenAtencion);

                var ACCIONlistado = "";
                if (tipoConsulta == "VISITA")
                {
                    ACCIONlistado = "LISTARPAG";
                }

                LocalEnty.Accion = ACCIONlistado;
                LocalEnty.Nacionalidad = "02";
                cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = ACCIONlistado;

                    Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
                    Listar = Listar.OrderBy(order => order.IdTipoOrden).ToList();
                }
                if (ENTITY_GLOBAL.Instance.INDICA_ESPECIALIDAD_GRILLA == "MEDICOS")
                {
                    LocalEnty.Accion = "LISTARESPE";
                    LocalEnty.IdEspecialidad = ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER;
                    cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                    Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
                    Listar = Listar.OrderBy(order => order.IdTipoOrden).ToList();
                    //Listar = Listar.Where(x => x.IdEspecialidad == ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER).ToList();
                }

                //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
                //Session["ENTITY_PACIENTE"] = Listar;  
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesVisitaEnf - Bloque Catch");
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


        public System.Web.Mvc.ActionResult GrillaListadoDispensacion(int start, int limit,
string txtFecha1, string txtFecha2, string tipoAtencion, string episodioClinico,
string tipoConsulta, string tipoEstado, string idPaciente,
    string idOrdenAtencion, string lineaOrdenAtencion,
   string tipoBuscar, int tipoMedicamento)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} ,tipoAtencion {E}, episodioClinico {F}" +
                            ",tipoConsulta {G}, tipoEstado {H},idPaciente {I}, idOrdenAtencion {J},  lineaOrdenAtencion {K}, tipoBuscar {L},tipoMedicamento {M}"
                        , start, limit, txtFecha1, txtFecha2, tipoAtencion, episodioClinico, tipoConsulta, tipoEstado, idPaciente, idOrdenAtencion,
                        lineaOrdenAtencion, tipoBuscar, tipoMedicamento);

            int cantElementos = 0;
            var Listar = new List<VW_ATENCIONPACIENTE>();
            try
            {
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

                //LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                //LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                //LocalEnty.Estado = getValorFiltroInt(tipoEstado);  2018/01/24 Jordan Mateo

                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                LocalEnty.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                LocalEnty.IdPaciente = getValorFiltroInt(idPaciente);
                LocalEnty.EpisodioClinico = getValorFiltroInt(episodioClinico);
                LocalEnty.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                LocalEnty.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                LocalEnty.IdProcedimiento = tipoMedicamento;

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
                LocalEnty.LineaOrdenAtencion = getValorFiltroInt(lineaOrdenAtencion);
                LocalEnty.IdOrdenAtencion = getValorFiltroInt(idOrdenAtencion);

                var ACCIONlistado = "";
                if (tipoConsulta == "VISITA")
                {
                    ACCIONlistado = "LISTARPAGDIS";
                    LocalEnty.FecFinDiscamec = null;
                    LocalEnty.FecIniDiscamec = null;
                }

                LocalEnty.Accion = ACCIONlistado;
                //cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                //if (cantElementos > 0)
                //{
                LocalEnty.Accion = "LISTARDISPE";
                // ACCIONlistado = "LISTARFARMACO";
                Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);

                if (tipoConsulta == "VISITA" && Listar.Count > 0)
                {
                    cantElementos = Listar.Count;
                    var Listado = new List<VW_ATENCIONPACIENTE>();
                    DataTable dtValida = new DataTable();
                    List<EpisodioAtencion> listaDatito = new List<EpisodioAtencion>();
                    //String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") != null ? (String)UTILES_MENSAJES.getParametro_Form("ACTIVOSOA") : null);
                    String PARAM = ENTITY_GLOBAL.Instance.ACTIVOSOA;
                    HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                    HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                    if (PARAM == "S")
                    {
                        WsEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                        WsEpisodio.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        WsEpisodio.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        WsEpisodio.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        WsEpisodio.IdOrdenAtencion = (int)Listar[0].IdOrdenAtencion;
                        WsEpisodio.Linea = (int)Listar[0].LineaOrdenAtencion;
                        WsEpisodio.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                        WsEpisodio.FechaCreacion = DateTime.Now;
                        WsEpisodio.UsuarioCreacion = "DISPE";
                        WsEpisodio.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    }
                    else
                    {

                        dtValida.Columns.Add("CustLName", typeof(String));
                        dtValida.Columns.Add("CustFName", typeof(String));
                        dtValida.Columns.Add("Purchases", typeof(String));
                        dtValida.Columns.Add("CustLName2", typeof(String));
                        dtValida.Columns.Add("CustFName2", typeof(String));
                        dtValida.Columns.Add("Purchases2", typeof(String));
                    }

                    dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);

                    string JSONString = JsonConvert.SerializeObject(dtValida);
                    listaDatito = (List<EpisodioAtencion>)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONString, typeof(List<EpisodioAtencion>));

                    if (listaDatito.Count > 0)
                    {
                        int contadorEjm = 0;
                        int valorContadorErp = listaDatito.Count;

                        foreach (VW_ATENCIONPACIENTE lst in Listar)
                        {
                            if (valorContadorErp > 0)
                            {
                                if (lst.CelularEmergencia.Length > 0)
                                {
                                    List<EpisodioAtencion> cantidadSolicitada = listaDatito.Where(x => x.SecuenciaHCE == lst.CelularEmergencia).ToList();
                                    if (cantidadSolicitada.Count > 0)
                                    {
                                        lst.IdEspecialidadProxima = cantidadSolicitada[0].IndicadorProcedimiento == null ? 0 : (int)cantidadSolicitada[0].IndicadorProcedimiento;
                                    }
                                    else
                                    {
                                        if (!string.IsNullOrEmpty(lst.ObservacionProxima))
                                        {
                                            if (!string.IsNullOrEmpty(lst.IdAsignacionMedico.ToString()))
                                            {

                                            }
                                            else
                                            {
                                                lst.IdAsignacionMedico = 0;
                                            }
                                            lst.IdEspecialidadProxima = 0;
                                        }
                                    }
                                }
                                else
                                {
                                    //int cantidadEnfermeria = 0;
                                    lst.IdEspecialidadProxima = 0;
                                }

                                //lst.IdEspecialidadProxima = listaDatito[contadorEjm].IndicadorProcedimiento == null ? 0 : (int)listaDatito[contadorEjm].IndicadorProcedimiento;
                                Listado.Add(lst);
                                contadorEjm++;
                            }
                            valorContadorErp--;
                        }
                    }
                    else
                    {
                        foreach (VW_ATENCIONPACIENTE lst in Listar)
                        {
                            lst.IdEspecialidadProxima = 0;
                            Listado.Add(lst);
                        }
                    }


                    Listar = Listado;
                }
                //}
                //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
                //Session["ENTITY_PACIENTE"] = Listar;  
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoAtencionPacientesTeleSalud - Bloque Catch");
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


        public System.Web.Mvc.ActionResult GrillaListadoAtencionFarmaco(int start, int limit,
    string txtFecha1, string txtFecha2, string tipoAtencion, string episodioClinico,
    string tipoConsulta, string tipoEstado, string idPaciente,
            string idOrdenAtencion, string lineaOrdenAtencion,
           string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoAtencionFarmaco - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoAtencionFarmaco - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} ,tipoAtencion {E}, episodioClinico {F}" +
                            ",tipoConsulta {G}, tipoEstado {H},idPaciente {I}, idOrdenAtencion {J},  lineaOrdenAtencion {K}, tipoBuscar {L}"
                        , start, limit, txtFecha1, txtFecha2, tipoAtencion, episodioClinico, tipoConsulta, tipoEstado, idPaciente, idOrdenAtencion,
                        lineaOrdenAtencion, tipoBuscar);
            int cantElementos = 0;
            var Listar = new List<VW_ATENCIONPACIENTE>();
            try
            {
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

                //LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                //LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                //LocalEnty.Estado = getValorFiltroInt(tipoEstado);  2018/01/24 Jordan Mateo

                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                LocalEnty.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                LocalEnty.IdPaciente = getValorFiltroInt(idPaciente);
                LocalEnty.EpisodioClinico = getValorFiltroInt(episodioClinico);

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
                LocalEnty.LineaOrdenAtencion = getValorFiltroInt(lineaOrdenAtencion);
                LocalEnty.IdOrdenAtencion = getValorFiltroInt(idOrdenAtencion);

                var ACCIONlistado = "";
                if (tipoConsulta == "VISITA")
                {
                    ACCIONlistado = "LISTARPAG";
                }

                LocalEnty.Accion = ACCIONlistado;
                cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = "LISTARFARMACO";
                    // ACCIONlistado = "LISTARFARMACO";
                    Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
                }
                //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
                //Session["ENTITY_PACIENTE"] = Listar;  
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoAtencionFarmaco - Bloque Catch");
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

        public System.Web.Mvc.ActionResult GrillaListadoEvolucionObjetiva(int start, int limit,
string txtFecha1, string txtFecha2, string tipoAtencion, string episodioClinico,
string tipoConsulta, string tipoEstado, string idPaciente,
    string idOrdenAtencion, string lineaOrdenAtencion,
   string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoEvolucionObjetiva - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoEvolucionObjetiva - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} ,tipoAtencion {E}, episodioClinico {F}" +
                            ",tipoConsulta {G}, tipoEstado {H},idPaciente {I}, idOrdenAtencion {J},  lineaOrdenAtencion {K}, tipoBuscar {L}"
                        , start, limit, txtFecha1, txtFecha2, tipoAtencion, episodioClinico, tipoConsulta, tipoEstado, idPaciente, idOrdenAtencion,
                        lineaOrdenAtencion, tipoBuscar);
            int cantElementos = 0;
            var Listar = new List<VW_ATENCIONPACIENTE>();
            try
            {
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

                //LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                //LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                //LocalEnty.Estado = getValorFiltroInt(tipoEstado);  2018/01/24 Jordan Mateo

                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                LocalEnty.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                LocalEnty.IdPaciente = getValorFiltroInt(idPaciente);
                LocalEnty.EpisodioClinico = getValorFiltroInt(episodioClinico);

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
                LocalEnty.LineaOrdenAtencion = getValorFiltroInt(lineaOrdenAtencion);
                LocalEnty.IdOrdenAtencion = getValorFiltroInt(idOrdenAtencion);

                var ACCIONlistado = "";
                if (tipoConsulta == "VISITA")
                {
                    ACCIONlistado = "LISTARPAG";
                }

                LocalEnty.Accion = ACCIONlistado;
                cantElementos = SvcVw_AtencionPaciente.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = "EVOLUCIONOBJETIVA";
                    // ACCIONlistado = "LISTARFARMACO";
                    Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(LocalEnty, ini, fin);
                }
                //ENTITY_GLOBAL obj = (ENTITY_GLOBAL)HttpContext.Current.Session["ENTITY_GLOBAL"];
                //Session["ENTITY_PACIENTE"] = Listar;  
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoEvolucionObjetiva - Bloque Catch");
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



        public System.Web.Mvc.ActionResult save_FirmaActosMedicosTriajeSpring(SS_HC_EpisodioAtencion obj, String MODO, String idWindow, String password)
        {
            try
            {
                Log.Information("BandejaMedicoController - save_FirmaActosMedicosTriajeSpring - Entrar");
                Log.Debug("BandejaMedicoController - save_FirmaActosMedicosTriajeSpring - obj {A}, MODO {B}, idWindow {C}, password {D}", obj, MODO, idWindow);
                /****************************************************/
                obj.FechaFirma = DateTime.Now;
                var Listar = new List<SG_Agente>();
                SG_Agente objUsuario = new SG_Agente();
                /****************************************************/
                DataTable dtAgente = new DataTable();
                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                string INDADL = "";
                string ADDOMAIN = "";
                string USUARIORED = "";
                if (ENTITY_GLOBAL.Instance.USUARIO.ToUpper() != "ROYAL")
                {
                    DataTable dtValida = new DataTable();
                    WsEpisodio.SecuenciaHCE = ENTITY_GLOBAL.Instance.USUARIO.Trim().ToUpper();
                    WsEpisodio.UsuarioCreacion = "ADDOMAINWE";
                    dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                    if (dtValida != null)
                    {
                        if (dtValida.Rows.Count > 0)
                        {
                            foreach (DataRow intobj in dtValida.AsEnumerable())
                            {
                                INDADL = intobj["IndicadorValidarUsuarioRed"].ToString();
                                ADDOMAIN = intobj["NombreDominioRed"].ToString();
                                USUARIORED = intobj["UsuarioRed"].ToString();
                            }
                            try
                            {
                                if (INDADL == "2" || INDADL == "S")
                                {
                                    if (ADDOMAIN.Length > 0)
                                    {
                                        if (USUARIORED.Length > 0)
                                        {
                                            LdapConnection connection = new LdapConnection(ADDOMAIN);
                                            NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper(), password);
                                            connection.Credential = credential;
                                            connection.Bind();
                                        }
                                        else
                                        {
                                            return showMensajeNotify("Error al acceder", "No cuenta con el UsuarioRed en el AD..", "ERROR", "Asignarlo en el ERP");
                                        }
                                    }
                                    else
                                    {
                                        return showMensajeNotify("Error al acceder", "No cuenta con el Dominio ASignado para el AD..", "ERROR", "Asignarlo en el ERP");
                                    }
                                }
                            }
                            catch (LdapException lexc)
                            {
                                string errorMessage = Newtonsoft.Json.JsonConvert.SerializeObject(lexc.ServerErrorMessage);
                                Log.Information("Login - ServerErrorMessage");
                                Log.Debug(errorMessage);

                                string[] cadArray = errorMessage.Trim().Split(',');
                                string msj = cadArray[2];
                                Log.Information("Login - Message[]");
                                Log.Debug(msj);

                                //string errorMessage;
                                switch (msj)
                                {
                                    case " data 52e": // Invalid credentials
                                        errorMessage = "Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.";
                                        break;
                                    case " data 525": // User not found
                                        errorMessage = "Usuario no encontrado (525).";
                                        break;
                                    case " data 530": // Not permitted to logon at this time
                                        errorMessage = "No se permite iniciar sesión en este momento (530). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 532": // Password expired
                                        errorMessage = "La Contraseña ha caducado (532). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 533": // Account disabled
                                        errorMessage = "La Cuenta esta deshabilitada (533). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 701": // Account expired
                                        errorMessage = "Cuenta expirada (701). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 773": // User must reset password
                                        errorMessage = "El usuario debe restablecer su contraseña (773). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 775": // User account locked
                                        errorMessage = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";
                                        break;
                                    default:
                                        errorMessage = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                                        break;
                                }
                                return showMensajeNotify("No hemos podido acceder", errorMessage, "ERROR", "REINICIAR");
                            }
                            catch (Exception ex)
                            {
                                //ex.Message;
                                Log.Information("LdapConnection - Login");
                                Log.Debug("ex.Message {A} ", ex.Message);
                            }
                        }
                        else
                        {
                            Log.Information("LdapConnection - Login");
                            return showMensajeBox("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                        }
                    }
                    else
                    {
                        Log.Information("LdapConnection - Login");
                        return showMensajeBox("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                    }
                }

                /****************************************************/
                if (INDADL == "2" || INDADL == "S")
                {
                    objUsuario.ACCION = "VALIDARADDOMAIN";
                    objUsuario.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO.Trim().ToUpper();
                    Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                    Log.Debug("VALIDARADDOMAIN listarSG_Agente ", Newtonsoft.Json.JsonConvert.SerializeObject(Listar));
                    foreach (SG_Agente objEntity in Listar)
                    {
                        password = objEntity.Clave;
                    }
                }

                objUsuario.ACCION = "VALIDARLOGIN";
                objUsuario.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO.Trim().ToUpper();
                objUsuario.Clave = password;
                Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);

                Boolean validoLogin = false;
                if (Listar.Count > 0)
                {
                    validoLogin = true;
                    foreach (SG_Agente objEntity in Listar)
                    {
                        if (objEntity.flatUsuGenerico == 2)
                        {
                            validoLogin = false;
                        }
                        else
                        {
                            objUsuario = objEntity;
                        }

                    }
                }

                if (validoLogin)
                {
                    /****************************************************/
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    long idResultado = 0;
                    String accion = "";
                    String message = "";
                    String tipoMsg = "INFO";
                    String tituloMsg = "Mensaje";
                    Boolean indicaValidacionForm = false;

                    //caa

                    long response = 0;
                    SS_HC_EpisodioTriaje ObjTrace = new SS_HC_EpisodioTriaje();
                    var ObjTriajeFirma = new SS_CE_TriajeFirma();


                    ObjTriajeFirma.IdTriaje = Convert.ToInt32(SaveTriajeInSpring());
                    ObjTriajeFirma.Tipo = Convert.ToInt32(3);
                    ObjTriajeFirma.FechaCreacion = DateTime.Now;
                    ObjTriajeFirma.FechaModificacion = DateTime.Now;
                    ObjTriajeFirma.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    ObjTriajeFirma.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    ObjTriajeFirma.IdEpisodioTriajeHCE = ENTITY_GLOBAL.Instance.EpisodioTriaje;


                    idResultado = SvcEpisodioTriaje.RegistrarTriajeSpring(ObjTriajeFirma);
                    ObjTrace.Accion = "UPDATE_FIRMA_MEDICO";
                    ObjTrace.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioTriaje);
                    ObjTrace.Estado = 3;
                    ObjTrace.FechaModificacion = DateTime.Now;
                    ObjTrace.FechaFirma = obj.FechaFirma;
                    ObjTrace.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    ObjTrace.ObservacionFirma = obj.ObservacionFirma;
                    ObjTrace.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                    ObjTrace.IdMedicoFirma = ENTITY_GLOBAL.Instance.CODPERSONA;
                    ObjTrace.FlagFirma = 1;

                    response = SvcEpisodioTriaje.UpdateEspecialidadTriaje(ObjTrace);

                    obj.Accion = "INFO";
                    return JavaScript("InicioMedico('" + "Triaje Registrado Correctamente.!!" + "')");

                }
                else
                    return showMensajeNotify("Error al acceder", "La contraseña es incorrecta.", "ERROR");
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_FirmaActosMedicosTriajeSpring - Bloque Catch");
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


        public long SaveTriajeInSpring()
        {
            Log.Information("BandejaMedicoController - SaveTriajeInSpring - Entrar");
            var LocalEnty = new SS_HC_TriajeEmergencia_FE();
            var lstDataEmer = new List<SS_HC_TriajeEmergencia_FE>();
            LocalEnty.Accion = "LISTAR";
            long IdTriajeData = 0;

            LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnty.EpisodioTriaje = (int)ENTITY_GLOBAL.Instance.EpisodioTriaje;
            LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            bool hallado = false;
            LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            // LocalEnty.EpisodioTriaje = (int)ENTITY_GLOBAL.Instance.EpisodioTriaje;
            lstDataEmer = SvcTriajeEmergenciaFEService.listarEntidad(LocalEnty);


            if (lstDataEmer.Count > 0)
            {
                foreach (SS_HC_TriajeEmergencia_FE item in lstDataEmer)
                {
                    var objTriaje = new SS_CE_TriajeViewModel();

                    objTriaje.Accion = "INSERT_TRIAJE_SPRING";
                    objTriaje.FechaInicio = item.Hora;
                    //objTriaje.Hora = item.Fecha;
                    objTriaje.NivelTriaje = item.Prioridad;
                    objTriaje.EstadoDocumento = null;
                    objTriaje.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objTriaje.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    objTriaje.UnidadReplicacion = item.UnidadReplicacion;
                    objTriaje.IdEspecialidad = Convert.ToInt32(item.Especialidad);
                    objTriaje.PresionMinima = item.PresionArterialMSD1;
                    objTriaje.PresionMaxima = item.PresionArterialMSD2;
                    objTriaje.Pulso = Convert.ToInt32(item.FrecuenciaCardiaca);
                    objTriaje.Respiracion = item.FrecuenciaRespiratoria;
                    objTriaje.FechaCreacion = DateTime.Now;
                    objTriaje.FechaModificacion = DateTime.Now;
                    objTriaje.Temperatura = item.Temperatura;
                    objTriaje.SaturacionMaxima = item.SaturacionOxigeno;
                    objTriaje.Sintomas = item.Sintomas;

                    if (item.TiempoEnfermedadUnidad != null)
                    {

                        if (item.TiempoEnfermedadUnidad.Equals("1"))
                        {
                            objTriaje.TiempoEnfermedad = item.TiempoEnfermedad.ToString() + " HORAS";
                        }

                        if (item.TiempoEnfermedadUnidad.Equals("2"))
                        {
                            objTriaje.TiempoEnfermedad = item.TiempoEnfermedad.ToString() + " DIAS";
                        }

                        if (item.TiempoEnfermedadUnidad.Equals("3"))
                        {
                            objTriaje.TiempoEnfermedad = item.TiempoEnfermedad.ToString() + " SEMANAS";
                        }

                        if (item.TiempoEnfermedadUnidad.Equals("4"))
                        {
                            objTriaje.TiempoEnfermedad = item.TiempoEnfermedad.ToString() + " MESES";
                        }

                        if (item.TiempoEnfermedadUnidad.Equals("5"))
                        {
                            objTriaje.TiempoEnfermedad = item.TiempoEnfermedad.ToString() + " AÑOS";
                        }

                    }
                    else
                    {
                        objTriaje.TiempoEnfermedad = item.TiempoEnfermedad.ToString();
                    }



                    objTriaje.IdPaciente = item.IdPaciente;
                    objTriaje.IndAprobacionTriaje = 1;
                    objTriaje.Sucursal = item.UnidadReplicacion;
                    objTriaje.IdEpisodioTriajeHCE = ENTITY_GLOBAL.Instance.EpisodioTriaje;


                    //objSC.Accion, objSC.FechaInicio, objSC.Hora, objSC.NivelTriaje, objSC.EstadoDocumento, objSC.UsuarioCreacion,
                    //   objSC.UsuarioModificacion, objSC.FechaCreacion, objSC.FechaModificacion,
                    //   objSC.UnidadReplicacion, objSC.PresionMinima, objSC.PresionMaxima, objSC.Pulso, objSC.Respiracion,
                    //   objSC.Temperatura, objSC.SaturacionMaxima, objSC.Sintomas, objSC.TiempoEnfermedad, objSC.IdPaciente,
                    //   objSC.IndAprobacionTriaje, objSC.Sucursal


                    IdTriajeData = SvcEpisodioTriaje.RegistrarTriajeSpringData(objTriaje);
                }



                var ObjAlergia = new SS_HC_Triaje_Ant_Alergia_FE();
                var Listar = new List<SS_HC_Triaje_Ant_Alergia_FE>();

                ObjAlergia.Accion = "LISTAR";
                ObjAlergia.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                ObjAlergia.EpisodioTriaje = (int)ENTITY_GLOBAL.Instance.EpisodioTriaje;
                ObjAlergia.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                Listar = SvcTriajeAntAlergia.TriajeAlergia_Listar(ObjAlergia).ToList();

                SP_ListarAlergiaDetalle_FE_Result Obj = new SP_ListarAlergiaDetalle_FE_Result();

                Obj.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                Obj.EpisodioTriaje = (int)ENTITY_GLOBAL.Instance.EpisodioTriaje;
                Obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;


                var ListaDetalle = SvcEpisodioTriaje.TriajeAlegriaDetalle(Obj);

                string AlergiasCab = "ALERGIA A MEDICAMENTOS : ";
                string AlergiasSub = "MEDICAMENTOS DE FORMA REGULAR : ";

                string AlergiaAlimentoCab = "ALERGIA A ALIMENTOS : ";

                string AlergiaContactoCab = "ALERGIA POR CONTACTO : ";
                string AlergiaAmbientalCab = "ALEGIA AMBIENTAL : ";


                if (Listar.Count > 0)
                {
                    foreach (SS_HC_Triaje_Ant_Alergia_FE items2 in Listar)
                    {
                        SS_CE_TriajeViewModel objSC = new SS_CE_TriajeViewModel();
                        objSC.IdTriaje = IdTriajeData;
                        objSC.medicamentoregular1 = items2.MedicamentoRegular;
                        objSC.alergiamedicamento1 = items2.IdMedicamento;
                        // objSC.indalergiaalimento = items2.TieneAlimento;
                        if (ListaDetalle.Count > 0)
                        {
                            foreach (var item in ListaDetalle)
                            {
                                if (item.TipoRegistro.Trim() == "RE")
                                {
                                    AlergiasSub += "\n\r"
                               + item.DesAlergia + "" + item.DescripcionManual + " Dosis : " + item.Dosis + " Frecuencia : " + item.DesFrecuencia + " Vía : " + item.DescripcionVia;
                                }
                                else if (item.TipoRegistro.Trim() == "MA")
                                {
                                    if (item.DesAlergia.Trim().Contains("Medicamentos"))
                                    {
                                        AlergiasCab += "\n\r" + item.DesAlergia + ":" + item.DescripcionManual;
                                    }
                                    else if (item.DesAlergia.Trim().Contains("Alimentos"))
                                    {
                                        AlergiaAlimentoCab += "\n\r" + item.DesAlergia + " : " + item.DescripcionManual;

                                    }
                                    else if (item.DesAlergia.Trim().Contains("Por Contacto"))
                                    {
                                        AlergiaContactoCab += "\n\r" + item.DesAlergia + " : " + item.DescripcionManual;

                                    }
                                    else if (item.DesAlergia.Trim().Contains("Ambiental"))
                                    {
                                        AlergiaAmbientalCab += "\n\r" + item.DesAlergia + " : " + item.DescripcionManual;
                                    }
                                }
                                //+ =+ "MEDICAMENTO :" +item.DescripcionManual
                                //;
                            }
                        }
                        var cab = AlergiasCab == "ALERGIA A MEDICAMENTOS : " ? "ALERGIA A MEDICAMENTOS : NO" : AlergiasCab;
                        var det = AlergiasSub == "MEDICAMENTOS DE FORMA REGULAR : " ? "MEDICAMENTOS DE FORMA REGULAR : NO" : AlergiasSub;
                        var cabAl = AlergiaAlimentoCab == "ALERGIA A ALIMENTOS : " ? "ALERGIA A ALIMENTOS : NO" : AlergiaAlimentoCab;
                        var cabCon = AlergiaContactoCab == "ALERGIA POR CONTACTO : " ? "ALERGIA POR CONTACTO : NO" : AlergiaContactoCab;
                        var cabAmb = AlergiaAmbientalCab == "ALEGIA AMBIENTAL : " ? "ALEGIA AMBIENTAL : NO" : AlergiaAmbientalCab;
                        var trasfu = items2.TransfusionSanguinea.Trim() == "S" ? "SI" : "NO";
                        var Protrasfu = items2.ProblemaTransfusion.Trim() == "S" ? "SI" : "NO";
                        //var alAli = items2.TieneAlimento.Trim() == "S" ? "SI" : "NO";
                        var alCon = items2.TieneContacto.Trim() == "S" ? "SI" : "NO";
                        var His = items2.TieneHistoria.Trim() == "S" ? "SI" : "NO";
                        var Ambi = items2.TieneHistoria.Trim() == "S" ? "SI" : "NO";
                        var Comentario = items2.Comentarios;
                        objSC.AntcedentesAlergias = cab + "\n\r" +
                             cabAl + "\n\r" +
                             cabCon + "\n\r" +
                             cabAmb + "\n\r" +
                             det + "\n\r" +
                            "TRANSFUSIÓN SANGUINEA : " + trasfu + "\n\r" +
                            "PROBLEMA CON TRANSFUSIONES : " + Protrasfu + "\n\r" +
                            // "ALERGIA ALIMENTO : " + alAli + "\n\r" +
                            //"ALERGIA POR CONTACTO : " + alCon + "\n\r" +
                            //"HISTORIA ALERGIAS A MEDICAMENTOS : " + His + "\n\r" +
                            //"ALEGIA AMBIENTAL : " + Ambi + "\n\r" +
                            "COMENTARIOS : " + "\n\r" +
                            Comentario;
                        var inCada = SvcEpisodioTriaje.UpdateTriajeAlergias(2, objSC);
                    }
                }
            }
            else
            {
                Log.Information("BandejaMedicoController - SaveTriajeInSpring - Bloque Msje Error");
                X.Msg.Alert("Aviso.!!", "Para poder firmar, primero tiene que registrar todos los formularios...").Show();
            }
            return IdTriajeData;
        }
        public System.Web.Mvc.ActionResult GrillaListadoGrupoAtencionPacienteContinuar(int start, int limit,
        string txtFecha1, string txtFecha2, string tipoAtencion, string episodioClinico,
             string idOrdenAtencion, string idEpisodioAtencion, string unidadReplicacion,
        string tipoConsulta, string tipoEstado, string idPaciente, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoGrupoAtencionPacienteContinuar - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoGrupoAtencionPacienteContinuar - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} ,tipoAtencion {E}, episodioClinico {F}" +
                                        ",tipoConsulta {G}, tipoEstado {H},idPaciente {I}, idOrdenAtencion {J}, tipoBuscar {L}, hay más parámetros ..."
                                    , start, limit, txtFecha1, txtFecha2, tipoAtencion, episodioClinico, tipoConsulta, tipoEstado, idPaciente, idOrdenAtencion, tipoBuscar);
            int cantElementos = 0;
            var Listar = new List<SS_HC_EpisodioAtencion>();
            try
            {
                var LocalEnty = new SS_HC_EpisodioAtencion();
                /*int ini = (start == 0 ? start : start + 1);
                int fin = start + limit;
                //Si la busqueda proviene de filtros
                if (tipoBuscar == "FILTRO") { ini = 0; fin = limit; }
                */
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
                    LocalEnty.FechaInicioDescansoMedico = Convert.ToDateTime(txtFecha1);
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
                    LocalEnty.FechaFinDescansoMedico = Convert.ToDateTime(txtFecha2);
                }

                //LocalEnty.CodigoOA = ((txtCodigoOA + "").Trim().Length == 0 ? null : txtCodigoOA);
                //LocalEnty.NombreCompleto = ((txtPaciente + "").Trim().Length == 0 ? null : txtPaciente);
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);

                LocalEnty.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                LocalEnty.IdPaciente = Convert.ToInt32(getValorFiltroInt(idPaciente));
                LocalEnty.EpisodioClinico = Convert.ToInt32(getValorFiltroInt(episodioClinico));
                LocalEnty.IdEpisodioAtencion = Convert.ToInt32(getValorFiltroInt(idEpisodioAtencion));

                LocalEnty.IdOrdenAtencion = Convert.ToInt32(getValorFiltroInt(idOrdenAtencion));

                /**ADD CONFIGURACIÓN*/
                //LocalEnty.Compania = ENTITY_GLOBAL.Instance.Compania;
                //LocalEnty.Sucursal = ENTITY_GLOBAL.Instance.Sucursal;
                LocalEnty.UnidadReplicacion = unidadReplicacion;
                LocalEnty.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
                {
                    LocalEnty.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
                }
                ///////////
                var ACCIONlistado = "ATENCIONTECMEDICO";
                LocalEnty.Accion = ACCIONlistado;
                Listar = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(LocalEnty, 0, 0);
                ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(Listar[0].IdPersonalSalud);
                ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(Listar[0].FechaFirma);


            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoGrupoAtencionPacienteContinuar - Bloque Catch");
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
            return this.Store(Listar);
        }


        /**Evento que activa o desactiva los botones del panel (Considerando el Estado o acción) 
         * y guarda el objeto de Atención Seleccionado*/
        public System.Web.Mvc.ActionResult SelectPersonaEpisodioEvento(String selection, string accion)
        {
            Log.Information("BandejaMedicoController - SelectPersonaEpisodioEvento - Entrar");
            Log.Debug("BandejaMedicoController - SelectPersonaEpisodioEvento - selection {A}, accion {B}", selection, accion);
            ENTITY_GLOBAL.Instance.FLAG_ANULAME = null;
            this.GetCmp<Button>("btnShowHC").Disabled = false;
            List<ENTITY_MENSAJES> listaMsgNoValido = new List<ENTITY_MENSAJES>();
            ENTITY_MENSAJES sms = new ENTITY_MENSAJES();
            if (accion != "Continuar") {
                this.GetCmp<Button>("NewEpisodio").Disabled = true;
                this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                this.GetCmp<Button>("ContEpisodio").Disabled = true;
                this.GetCmp<Button>("VerEpisodio").Disabled = true;
                this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                this.GetCmp<Button>("btnModifVisita").Disabled = true;
                this.GetCmp<Button>("btnVerVisita").Disabled = true;
                this.GetCmp<Button>("btnVisitas").Disabled = true;
                this.GetCmp<Button>("abrirEpisodio").Disabled = true;
            }
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
            List<VW_ATENCIONPACIENTE_GENERAL> ObjListar = (List<VW_ATENCIONPACIENTE_GENERAL>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<VW_ATENCIONPACIENTE_GENERAL>));
            //accion = "Nuevo";
            if (ObjListar.Count > 0)
            {
                DateTime fechaCita = ObjListar[0].CitaFecha.Value;
                string fechaFormateada = fechaCita.ToString("dd/MM/yyyy");
                Session["FechaCitaIntervencion"] = fechaFormateada;
                Session["CodigoHC_PACIENTE"] = "" + ObjListar[0].CodigoHC;
                ENTITY_GLOBAL.Instance.IDPERSONALSALUD_EMERG = ObjListar[0].IdPersonalSalud;
                if (ObjListar[0].TipoAtencion.ToString() != null) ENTITY_GLOBAL.Instance.TIPOATENCION = ObjListar[0].TipoAtencion.ToString(); // Agregado 29/01/2018
                if (ObjListar[0].TipoOrdenAtencion.ToString() != null) ENTITY_GLOBAL.Instance.TipoOrdenAtencion = Convert.ToInt32(ObjListar[0].TipoOrdenAtencion); // Agregado 29/01/2018
                if (ObjListar[0].IdEspecialidad.ToString() != null) ENTITY_GLOBAL.Instance.IdEspecialidad = Convert.ToInt32(ObjListar[0].IdEspecialidad); // Agregado 29/01/2018
                if (ObjListar[0].tipoListado == "MED_AMBULATORIO") {
                    if (ObjListar[0].EstadoEpiAtencion == 0) {
                        if (ObjListar[0].TipoPaciente == 6) {
                            try
                            {
                                DataTable dtValida = new DataTable();
                                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                                WsEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                WsEpisodio.IdOrdenAtencion = (int)ObjListar[0].IdOrdenAtencion;
                                WsEpisodio.Linea = (int)ObjListar[0].LineaOrdenAtencion;
                                WsEpisodio.IdPaciente = (int)ObjListar[0].IdPaciente;
                                WsEpisodio.IdEpisodioAtencion = (int)ObjListar[0].IdEspecialidad;
                                WsEpisodio.UsuarioCreacion = "P_ACTVALCPM";
                                WsEpisodio.FechaCreacion = DateTime.Now;
                                WsEpisodio.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                                if (dtValida != null) {
                                    var a = dtValida.AsEnumerable();
                                    foreach (DataRow _row in dtValida.AsEnumerable())
                                    {
                                        sms.DESCRIPCION = "El paciente ya supero las citas para la especialidad de " + ObjListar[0].NombreEspecialidad + " de la modalidad CPM en " + _row["Cantidad"].ToString() + " citas";
                                    }
                                }
                            }
                            catch (Exception exception)
                            {
                                Log.Information("BandejaMedicoController - SelectPersonaEpisodioEvento - Bloque Catch");
                                Log.Error(exception, exception.Message);
                                string dd = exception.Source;
                            }
                        }
                    }
                }

                #region setParametersToRelevo
                ENTITY_GLOBAL.Instance.IdOrdenAtencionRelevo = ObjListar[0].IdOrdenAtencion;
                ENTITY_GLOBAL.Instance.CodigoOARelevo = ObjListar[0].CodigoOA;
                ENTITY_GLOBAL.Instance.IdLineaRelevo = ObjListar[0].LineaOrdenAtencion;
                ENTITY_GLOBAL.Instance.NombreMedicoAntRelevo = ObjListar[0].MedicoNombre;
                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA") {
                    if ((ObjListar[0].TipoOrdenAtencion == 1 || ObjListar[0].TipoOrdenAtencion == 11) && ObjListar[0].EstadoEpiAtencion != 3)
                    {
                        this.GetCmp<Button>("BtnRelevoOpenMedico").Disabled = false;
                    }
                    else {
                        this.GetCmp<Button>("BtnRelevoOpenMedico").Disabled = true;
                    }
                }

                #endregion

                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = ObjListar[0];
                ////TIPO DE ATENCION SELECCIONADA
                if (ObjListar[0].TipoAtencion != null) {
                    Session["TIPOATENCION_ACTUAL"] = Convert.ToInt32(ObjListar[0].TipoAtencion);
                }
                if (ObjListar[0].EstadoEpiAtencion == null || ObjListar[0].EstadoEpiAtencion == 0) {
                    if (accion != "Continuar") {
                        this.GetCmp<Button>("NewEpisodio").Disabled = false;
                        this.GetCmp<Button>("ContEpisodio").Disabled = false;
                        //ADD 09/15
                        this.GetCmp<Button>("abrirEpisodio").Disabled = false;
                        if (ObjListar[0].tipoListado == "MED_AMBULATORIO") {
                            this.GetCmp<Button>("btnllamadoVisita").Disabled = false;
                        }
                    }
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ENTITY_GLOBAL.Instance.CAMA = ObjListar[0].Cama;
                    ENTITY_GLOBAL.Instance.MedicoNombre = ObjListar[0].MedicoNombre;
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;
                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA") {
                        ENTITY_GLOBAL.Instance.SECUENCIAL_HCE = ObjListar[0].TipoOrdenAtencionNombre;
                        ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER = ObjListar[0].IdEspecialidad;
                        ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER = ObjListar[0].Origen;
                        ENTITY_GLOBAL.Instance.INDICADOR_INTERCONSULTA = Convert.ToInt32(ObjListar[0].IdProcedimiento);
                        this.GetCmp<Button>("btnFarmacologo").Disabled = true;
                        this.GetCmp<Button>("btnEvolucion").Disabled = true;
                        if (ObjListar[0].EstadoEpiAtencion == 3 && (ObjListar[0].TipoOrdenAtencion == 1 || ObjListar[0].TipoOrdenAtencion == 11)) //EPI ATENDIDO
                        {
                            this.GetCmp<Button>("BtnAltaOpenMedico").Disabled = false;
                        }
                        else {
                            this.GetCmp<Button>("BtnAltaOpenMedico").Disabled = true;
                        }
                    }
                    else if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION") {
                        ENTITY_GLOBAL.Instance.SECUENCIAL_HCE = ObjListar[0].TipoOrdenAtencionNombre;
                        ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER = ObjListar[0].IdEspecialidad;
                        ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER = ObjListar[0].Version;
                    }
                    this.GetCmp<Button>("anularEpisodio").Disabled = true;
                    ENTITY_GLOBAL.Instance.MODALIDAD_TEMP = ObjListar[0].Modalidad;
                    ENTITY_GLOBAL.Instance.IdMedico = Convert.ToInt32(ObjListar[0].Comentarios);
                    ENTITY_GLOBAL.Instance.COD_MEDICO = ENTITY_GLOBAL.Instance.IdMedico;
                    if (ENTITY_GLOBAL.Instance.IdMedico == 0) {
                        ENTITY_GLOBAL.Instance.IdMedico = null;
                    }
                }
                else {
                    ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].EpisodioClinico;
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].EpisodioAtencion; /*ObjListar[0].IdEpisodioAtencion;*/
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = ObjListar[0].EpisodioAtencion;//ADD cambios --/09/2015
                    ENTITY_GLOBAL.Instance.MODALIDAD_TEMP = ObjListar[0].Modalidad;
                    int response = 0;
                    if (ObjListar[0].TipoAtencion.ToString() != null) ENTITY_GLOBAL.Instance.TIPOATENCION = ObjListar[0].TipoAtencion.ToString(); // Agregado 29/01/2018
                    if (ObjListar[0].IdEpisodioAtencion != null) {
                        ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = Convert.ToInt64(ObjListar[0].IdEpisodioAtencion); //ADD ORLANDO 17.05.2017
                        ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = Convert.ToInt64(ObjListar[0].IdEpisodioAtencion); //ADD ORLANDO 17.05.2017
                    }
                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA") {
                        ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER = ObjListar[0].IdEspecialidad;
                        ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER = ObjListar[0].Origen;
                        ENTITY_GLOBAL.Instance.SECUENCIAL_HCE = ObjListar[0].TipoOrdenAtencionNombre;
                        ENTITY_GLOBAL.Instance.INDICADOR_INTERCONSULTA = Convert.ToInt32(ObjListar[0].IdProcedimiento);
                        if (ObjListar[0].EstadoEpiAtencion == 3 && ((ObjListar[0].TipoOrdenAtencion == 1 || ObjListar[0].TipoOrdenAtencion == 11) || ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso"))  //EPI ATENDIDO
                        {
                            var objGenral2 = new SS_HCE_ConsultaExterna();
                            objGenral2.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                            objGenral2.Linea = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo" ? 1 : ObjListar[0].LineaOrdenAtencion;
                            objGenral2.Accion = "ALTA_ADMIN";
                            response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);
                            if (response == 0 && ObjListar[0].IdEpisodioAtencion != null) {
                                if (ObjListar[0].ComponenteNombre == "I. Opinión") {
                                    this.GetCmp<Button>("BtnAltaOpenMedico").Disabled = true;
                                }
                                else {
                                    this.GetCmp<Button>("anularEpisodio").Disabled = false;
                                    this.GetCmp<Button>("BtnAltaOpenMedico").Disabled = false;
                                }
                            }
                            else {
                                this.GetCmp<Button>("BtnAltaOpenMedico").Disabled = true;
                                this.GetCmp<Button>("anularEpisodio").Disabled = true;
                            }
                        }
                        else {
                            this.GetCmp<Button>("BtnAltaOpenMedico").Disabled = true;
                        }
                    }
                    else if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION") {
                        ENTITY_GLOBAL.Instance.SECUENCIAL_HCE = ObjListar[0].TipoOrdenAtencionNombre;
                        ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER = ObjListar[0].IdEspecialidad;
                        ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER = ObjListar[0].Version;
                    }
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ENTITY_GLOBAL.Instance.CAMA = ObjListar[0].Cama;
                    ENTITY_GLOBAL.Instance.IdMedico = Convert.ToInt32(ObjListar[0].Comentarios);
                    if (ENTITY_GLOBAL.Instance.IdMedico == 0) {
                        ENTITY_GLOBAL.Instance.IdMedico = null;
                    }
                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOSALUD") {
                        ENTITY_GLOBAL.Instance.COD_MEDICO = ObjListar[0].IdPersonalSalud; 
                    }
                    else {
                        ENTITY_GLOBAL.Instance.COD_MEDICO = ENTITY_GLOBAL.Instance.IdMedico;
                    }
                    ENTITY_GLOBAL.Instance.MedicoNombre = ObjListar[0].MedicoNombre;
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                    if (ObjListar[0].EstadoEpiAtencion == 0 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO") //EPI ATENDIDO
                    {
                        this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                        this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                    }
                    if ((ObjListar[0].EstadoEpiAtencion == 5 || ObjListar[0].EstadoEpiAtencion == 4 || ObjListar[0].EstadoEpiAtencion == 1) && ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO") //ATENDIDO
                    {
                        this.GetCmp<Button>("anularEpisodio").Disabled = true;
                    }
                    if ((ObjListar[0].EstadoEpiAtencion == 5 || ObjListar[0].EstadoEpiAtencion == 4 || ObjListar[0].EstadoEpiAtencion == 3) && ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO") //ATENDIDO
                    {
                        this.GetCmp<Button>("anularEpisodio").Disabled = true;
                    }
                    if (ObjListar[0].IdEpisodioAtencion == null) {
                        this.GetCmp<Button>("anularEpisodio").Disabled = true;
                        this.GetCmp<Button>("btnShowHC").Disabled = true;
                    }
                    if (ObjListar[0].EstadoEpiAtencion == 2)//EPI EN ATENCIÓN
                    {
                        if (accion != "Continuar") {
                            this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                            this.GetCmp<Button>("VerEpisodio").Disabled = false;
                            this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                            this.GetCmp<Button>("btnNuevaVisita").Disabled = false;
                            this.GetCmp<Button>("btnModifVisita").Disabled = false;
                            this.GetCmp<Button>("btnVerVisita").Disabled = false;
                            this.GetCmp<Button>("btnVisitas").Disabled = false;
                            this.GetCmp<Button>("anularEpisodio").Disabled = false;
                            this.GetCmp<Button>("btnFarmacologo").Disabled = false;
                            this.GetCmp<Button>("btnEvolucion").Disabled = false;
                        }
                        else {
                            this.GetCmp<Button>("aprobarAtencion").Disabled = false;
                            this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                            this.GetCmp<Button>("VerEpisodio").Disabled = false;
                            this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                        }
                    }
                    else if (ObjListar[0].EstadoEpiAtencion == 3) //EPI ATENDIDO
                    {
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                        ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                        ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        this.GetCmp<Button>("VerEpisodio").Disabled = false;
                        this.GetCmp<Button>("btnVerVisita").Disabled = false;
                        this.GetCmp<Button>("btnVisitas").Disabled = false;
                        this.GetCmp<Button>("btnShowHC").Disabled = false;
                        if (ObjListar[0].IdEpisodioAtencion != null) {
                            if (response == 0 && ObjListar[0].IdEpisodioAtencion != null) {
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO") {
                                    this.GetCmp<Button>("anularEpisodio").Disabled = false;
                                }
                            }
                            else {
                                this.GetCmp<Button>("anularEpisodio").Disabled = true;
                            }
                     
                            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA") {
                                this.GetCmp<Button>("btnFarmacologo").Disabled = false;
                                this.GetCmp<Button>("btnEvolucion").Disabled = false;
                            }
                        }
                        else {
                            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA") {
                                this.GetCmp<Button>("anularEpisodio").Disabled = true;
                                this.GetCmp<Button>("btnFarmacologo").Disabled = true;
                                this.GetCmp<Button>("btnEvolucion").Disabled = true;
                            }
                        }
                    }
                    else if (ObjListar[0].EstadoEpiAtencion == 4) //METODO TELESALUD
                    {
                        this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                        this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                    }
                    else if (ObjListar[0].EstadoEpiAtencion == 1 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOSALUD") //METODO TELESALUD
                    {
                        this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                        this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                    }
                }
                if (ObjListar[0].EstadoEpiAtencion == 0 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOSALUD") //METODO TELESALUD
                {
                    this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                    this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                }
                if (ObjListar[0].EstadoEpiAtencion == 3 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOSALUD") //METODO TELESALUD
                {
                    this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                }
                string vvall = ENTITY_GLOBAL.Instance.COD_BANDEJA + "   " + Convert.ToString(Session["TIPOTRABAJADOR_ACTUAL"]);
                if (ObjListar[0].EstadoEpiAtencion == 5 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO") //METODO TELESALUD
                {
                    this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                }
                if ((ObjListar[0].EstadoEpiAtencion == 0 || ObjListar[0].EstadoEpiAtencion == 1 || ObjListar[0].EstadoEpiAtencion == 4) && ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOSALUD" && Convert.ToString(Session["TIPOTRABAJADOR_ACTUAL"]) == "10") //METODO TELESALUD
                {
                    this.GetCmp<Button>("aprobarAtencion").Disabled = false;
                }
                else if ((ObjListar[0].EstadoEpiAtencion != 0 || ObjListar[0].EstadoEpiAtencion != 1 || ObjListar[0].EstadoEpiAtencion != 4) && ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOSALUD" && Convert.ToString(Session["TIPOTRABAJADOR_ACTUAL"]) == "10") //METODO TELESALUD
                {
                    this.GetCmp<Button>("aprobarAtencion").Disabled = true;
                }
                if (ObjListar[0].EstadoEpiAtencion == 3) //EPI ATENDIDO
                {
                    if (ObjListar[0].IdEpisodioAtencion == null || ObjListar[0].IdEpisodioAtencion == 0) {
                        this.GetCmp<Button>("NewEpisodio").Disabled = true;
                        this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                        this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                        this.GetCmp<Button>("ContEpisodio").Disabled = true;
                        this.GetCmp<Button>("VerEpisodio").Disabled = true;
                        this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                        this.GetCmp<Button>("btnModifVisita").Disabled = true;
                        this.GetCmp<Button>("btnVerVisita").Disabled = true;
                        this.GetCmp<Button>("btnVisitas").Disabled = true;
                        this.GetCmp<Button>("abrirEpisodio").Disabled = true;
                        if (ObjListar[0].tipoListado == "MED_AMBULATORIO") {
                            this.GetCmp<Button>("btnllamadoVisita").Disabled = true;
                        }
                    }
                    else if (ObjListar[0].EstadoEpiAtencion == 3 && ObjListar[0].LineaOrdenAtencion == 1 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                    {
                        ENTITY_GLOBAL.Instance.FLAG_ANULAME = "ALTA";
                    }
                    else if (ObjListar[0].EstadoEpiAtencion == 3 && ObjListar[0].LineaOrdenAtencion > 1 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && ObjListar[0].TipoOrdenAtencion == 1)
                    {
                        ENTITY_GLOBAL.Instance.FLAG_ANULAME = "ALTA";
                    }
                    else {
                        bool permitirModificarAtencion = false;
                        //Realizamos el mismo LISTADO INICIAL que se hace en la carga del MACROPROCESO
                        //Para verificar el ID DE OPCION
                        List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
                        VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
                        //OBS:ADD de seguridad
                        int ini = 0;
                        if (Session["TIPOATENCION_ACTUAL"] != null)
                        {
                            ini = (int)Session["TIPOATENCION_ACTUAL"];
                        }
                        int fin = 0;
                        obj.AFE = ENTITY_GLOBAL.Instance.Establecimiento;//Para obtener Nombre de Estab. Seleccionado
                        obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
                        obj.ACCION = "LISTARPORID";
                        //El TIPO DE ATENCION en una variable AUXILIAR: ini
                        lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, ini, fin);
                        if (lista.Count > 0) {
                            /**OBS  en el caso hubiera más de un registro, podría ser a causa de diferentes perfiles permitidos.
                                   revisar stored: SP_VW_PERSONAPACIENTE_LISTAR */
                            int idOpcionTemp = Convert.ToInt32(getValorFiltroStr(lista[0].Servicio) != null ? lista[0].Servicio : "0");   //OBS: seguridad   : ID OPCION         
                            String descOpcionTemp = lista[0].Observacion;   //OBS: seguridad     : DESC OPCION
                            permitirModificarAtencion = esValidoModificarAtencion(idOpcionTemp, ObjListar[0].FechaFin, "DESP_FIRMA");
                            if (permitirModificarAtencion) {
                                this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                                this.GetCmp<Button>("btnModifVisita").Disabled = false;
                                return showMensajeNotify("Información Proceso: " + descOpcionTemp, "Todavía es posible editar la Atención. ", "WARNING");
                            }
                        }
                    }
                }
                if (ObjListar[0].EstadoEpiAtencion == 0 && ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO" && sms.DESCRIPCION != null) //EPI ATENDIDO
                {
                    return showMensajeBox(sms.DESCRIPCION + ".", "Información Proceso: ", "WARNING");
                }
            }
            return this.Direct();
        }



        ///--- TRIAJE
        ///

        #region
        public System.Web.Mvc.ActionResult OpenRelevoMedico(String accionSeleccion, String accionListado, int linea, int idOrdenAtencion)
        {
            Log.Information("BandejaMedicoController - OpenRelevoMedico - Entrar");
            Log.Debug("BandejaMedicoController - OpenRelevoMedico - accionSeleccion {A}, accionListado {B}, linea {C}, idOrdenAtencion {D}"
                                    , accionSeleccion, accionListado, linea, idOrdenAtencion);
            int response = 0;
            var objGenral2 = new SS_HCE_ConsultaExterna();
            objGenral2.IdOrdenAtencion = idOrdenAtencion;
            objGenral2.Linea = linea;
            objGenral2.Accion = "RELEVOPRINCIPAL";

            response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);

            if (response == 0)
            {
                return showMensajeValidate("Advertencia!", "Está linea no es la atención Principal", "ERROR");
            }

            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.USUARIO = accionListado;
            obj.ACCION = accionSeleccion;
            obj.ApellidoPaterno = ENTITY_GLOBAL.Instance.NombreMedicoAntRelevo;

            if (Session["MODULO_DEF"] != null)
            {
            }



            return crearWindowRegistro("RelevoMedicoTriaje", obj, "");
        }

        public System.Web.Mvc.ActionResult getSeleccionMedicoTriaje(String MODO, int persona, String cmp, String nombre, int especialidad, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionMedicoTriaje - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionMedicoTriaje - MODO {A}, persona {B}, cmp {C}, nombre {D} ,especialidad {E}, idWindow {F}"
                                    , MODO, persona, cmp, nombre, especialidad, idWindow);
            USUARIO obj = new USUARIO();
            obj.ACCION = MODO;
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var nf = X.GetCmp<NumberField>("TxtIdMedicoENtrante");
            if (persona != null) { nf.SetValue(persona); }




            ENTITY_GLOBAL.Instance.IdPersonaMedicoRelevo = persona;

            var tfNom = X.GetCmp<TextField>("TxtMedicoRelevoNombres");
            if (nombre != null && nombre != "") { tfNom.SetValue(nombre); }
            var tEsp = X.GetCmp<TextField>("TxtEspecialidad");
            if (especialidad != null && especialidad != 0) { tEsp.SetValue(especialidad); }

            var TxtMedicoANteriorRelevo = X.GetCmp<TextField>("TxtMedicoANteriorRelevo");
            TxtMedicoANteriorRelevo.SetValue(ENTITY_GLOBAL.Instance.NombreMedicoAntRelevo);
            ENTITY_GLOBAL.Instance.NombreMedicoRelevoActual = nombre;
            var ModalAutentification = X.GetCmp<FieldSet>("ModalAutentification");
            ModalAutentification.Hidden = false;
            var BtnReelevarMedico = X.GetCmp<Button>("BtnReelevarMedico");
            BtnReelevarMedico.Disabled = false;
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult ValidateUserTriaje(SG_Agente obje)
        {
            Log.Information("BandejaMedicoController - ValidateUserTriaje - Entrar");
            Log.Debug("BandejaMedicoController - ValidateUserTriaje - obje {A}", obje);
            if (obje.CodigoAgente == null)
            {
                return showMensajeValidate("Aviso.!!", "Ingrese Usuario", "ERROR");
            }
            else if (obje.Clave == null)
            {
                return showMensajeValidate("Aviso.!!", "Ingrese Contraseña", "ERROR");
            }
            else
            {
                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                List<SG_Agente> list = new List<SG_Agente>();
                SG_Agente objUsuario = new SG_Agente();
                /****************************************************/

                string INDADL = "";
                string ADDOMAIN = "";
                string USUARIORED = "";
                if (obje.CodigoAgente.ToUpper() != "ROYAL")
                {
                    DataTable dtValida = new DataTable();

                    WsEpisodio.SecuenciaHCE = obje.CodigoAgente.ToUpper();
                    WsEpisodio.UsuarioCreacion = "ADDOMAINWE";
                    dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                    if (dtValida != null)
                    {
                        if (dtValida.Rows.Count > 0)
                        {
                            foreach (DataRow intobj in dtValida.AsEnumerable())
                            {
                                INDADL = intobj["IndicadorValidarUsuarioRed"].ToString();
                                ADDOMAIN = intobj["NombreDominioRed"].ToString();
                                USUARIORED = intobj["UsuarioRed"].ToString();
                            }
                            try
                            {
                                if (INDADL == "2" || INDADL == "S")
                                {
                                    if (ADDOMAIN.Length > 0)
                                    {
                                        if (USUARIORED.Length > 0)
                                        {
                                            string SSSD = " ADDOMAIN ::" + ADDOMAIN + " USUARIORED ::" + USUARIORED.Trim().ToUpper() + " Clave ::" + obje.Clave;

                                            if (SSSD.Length <= 0)
                                            {
                                                SSSD = "vacio";
                                            }

                                            Log.Debug("NetworkCredential" + SSSD, SSSD);
                                            LdapConnection connection = new LdapConnection(ADDOMAIN);
                                            NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper(), obje.Clave);
                                            connection.Credential = credential;
                                            connection.Bind();

                                        }
                                        else
                                        {
                                            return showMensajeValidate("Aviso!", "No cuenta con el UsuarioRed en el AD..", "WARNING");
                                            //showMensajeNotify("No cuenta con el UsuarioRed en el AD..", "Error al acceder", "ERROR", "Asignarlo en el ERP");
                                        }
                                    }
                                    else
                                    {
                                        return showMensajeValidate("Aviso!", "No cuenta con el Dominio ASignado para el AD..", "WARNING");
                                        //showMensajeNotify("No cuenta con el Dominio ASignado para el AD..", "Error al acceder", "ERROR", "Asignarlo en el ERP");
                                    }
                                    //if (objUsuario.Clave != txtPassword.Trim())
                                    //{
                                    //    objUsuario.Clave = txtPassword.Trim();
                                    //    resultado = SvcSG_Agente.setMantenimiento(objUsuario);
                                    //}
                                }
                            }
                            catch (LdapException lexc)
                            {
                                string errorMessage = Newtonsoft.Json.JsonConvert.SerializeObject(lexc.ServerErrorMessage);
                                Log.Information("Login - ServerErrorMessage");
                                Log.Debug(errorMessage);

                                string[] cadArray = errorMessage.Trim().Split(',');
                                string msj = cadArray[2];
                                Log.Information("Login - Message[]");
                                Log.Debug(msj);

                                //string errorMessage;
                                switch (msj)
                                {
                                    case " data 52e": // Invalid credentials
                                        errorMessage = "Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.";
                                        break;
                                    case " data 525": // User not found
                                        errorMessage = "Usuario no encontrado (525).";
                                        break;
                                    case " data 530": // Not permitted to logon at this time
                                        errorMessage = "No se permite iniciar sesión en este momento (530). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 532": // Password expired
                                        errorMessage = "La Contraseña ha caducado (532). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 533": // Account disabled
                                        errorMessage = "La Cuenta esta deshabilitada (533). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 701": // Account expired
                                        errorMessage = "Cuenta expirada (701). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 773": // User must reset password
                                        errorMessage = "El usuario debe restablecer su contraseña (773). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 775": // User account locked
                                        errorMessage = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";
                                        break;
                                    default:
                                        errorMessage = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                                        break;
                                }
                                return showMensajeValidate("Aviso!", errorMessage, "WARNING");
                                //showMensajeNotify(errorMessage, "No hemos podido acceder", "ERROR", "REINICIAR");
                            }
                            catch (Exception ex)
                            {
                                //ex.Message;
                                Log.Information("LdapConnection - Login");
                                Log.Debug("ex.Message {A} ", Newtonsoft.Json.JsonConvert.SerializeObject(ex));
                            }
                        }
                        else
                        {
                            Log.Information("LdapConnection - Login");
                            return showMensajeValidate("Aviso!", "No existe el Usuario en el Sistema", "WARNING");
                            //showMensajeNotify("No existe el Usuario en el Sistema", "Error al acceder", "ERROR", "REINICIAR");
                        }
                    }
                    else
                    {
                        Log.Information("LdapConnection - Login");
                        return showMensajeValidate("Aviso!", "No existe el Usuario en el Sistema", "WARNING");
                        //showMensajeValidate("No existe el Usuario en el Sistema", "Error al acceder", "ERROR", "REINICIAR");                       
                    }

                }
                /****************************************************/

                if (INDADL == "2" || INDADL == "S")
                {
                    objUsuario.ACCION = "VALIDARADDOMAIN";
                    objUsuario.CodigoAgente = obje.CodigoAgente.Trim().ToUpper();
                    list = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                    Log.Debug("VALIDARADDOMAIN listarSG_Agente ", Newtonsoft.Json.JsonConvert.SerializeObject(list));
                    foreach (SG_Agente objEntity in list)
                    {
                        //objUsuario = objEntity;
                        obje.Clave = objEntity.Clave;
                    }
                }

                objUsuario.ACCION = "VALIDARLOGIN_RELEVO";
                objUsuario.CodigoAgente = obje.CodigoAgente;
                objUsuario.Clave = obje.Clave;
                list = SvcEpisodioTriaje.listarSG_AgenteLogin(objUsuario, 0, 0);

                if (list.Count > 0)
                {
                    String Response = "";
                    var IdEmpleadoValidate = Convert.ToInt32(list[0].IdEmpleado);
                    var IdAgenteRequest = Convert.ToInt32(obje.IdEmpleado);
                    var especialidad = (list[0].tipotrabajador == null || list[0].tipotrabajador == "") ? 0 : Convert.ToInt32(list[0].tipotrabajador);

                    /*if (especialidad != 30)
                    {
                        return showMensajeValidate("Registro Cancelado!", "El médico registrado no cuenta con la especialidad Emergencia", "ERROR");
                    }
                    else
                    {*/
                    if (IdEmpleadoValidate == IdAgenteRequest)
                    {

                        List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                        int response = 0;
                        var objGenral = new SS_HCE_ConsultaExterna();
                        objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                        objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                        objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                        objGenral.Medico = IdEmpleadoValidate;
                        objGenral.TipoOrdenMedica = 2;
                        objGenral.Especialidad = obje.IdGrupoTransaccion;
                        objGenral.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        objGenral.UsuarioCreacion = list[0].CodigoAgente;
                        objGenral.Accion = "RELEVO";

                        response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);

                        if (response >= 1)
                        {
                            //var GridPanel1 = X.GetCmp<GridPanel>("GridPanel1");
                            //GridPanel1.GetStore().Reload();

                            //  GridPanel1.getStore().reload();

                            //var store = X.GetCmp<Store>("StoreTasks");
                            //store.Reload();
                            SS_HC_EpisodioClinico objEPiCLin = new SS_HC_EpisodioClinico();
                            objEPiCLin.IdPaciente = IdEmpleadoValidate;
                            objEPiCLin.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                            objEPiCLin.ACCION = "RELEVAME";
                            int indica = SvcEpisodioClinico.setMantenimiento(objEPiCLin);
                            var win = X.GetCmp<Window>("WindowPacienteTriaje");
                            win.Close();

                            ENTITY_GLOBAL.Instance.NombreMedicoAntRelevo = ENTITY_GLOBAL.Instance.NombreMedicoRelevoActual;
                            return showMensajeValidate("Registro Exitoso!", "El relevo se realizó satisfactoriamente..!!", "INFO");
                        }
                        else
                        {
                            return showMensajeValidate("Registro Cancelado!", "El médico asignado, no cuenta con un horario en el turno indicado", "ERROR");
                        }
                    }
                    else
                    {
                        Response = "Las credenciales no corresponden al médico seleccionado..!";
                        return showMensajeValidate("Aviso!", Response, "WARNING");
                    }
                    //}




                }

            }

            return showMensajeValidate("Aviso!", "Usuario no registrado, verifique sus credenciales e intente de nuevo..!!", "ERROR");
        }


        public System.Web.Mvc.ActionResult showMensajeValidate(String titulo, String message, String tipo)
        {

            Log.Information("BandejaMedicoController - showMensajeValidate - Entrar");
            Log.Debug("BandejaMedicoController - showMensajeValidate - titulo {A}, message {B}, tipo {C}"
                                    , titulo, message, tipo);

            X.Msg.Show(new MessageBoxConfig
            {
                Title = titulo,
                Message = message,
                Buttons = MessageBox.Button.OK,
                Icon = (MessageBox.Icon)Enum.Parse(typeof(MessageBox.Icon), tipo),

            });


            return this.Direct();

        }
        public System.Web.Mvc.ActionResult getGrillaEspecialidadMedicoTriaje(int start, int limit,
           string cmp, string nombrecompleto, string nroregespecialidad, string idespecialidad,
          string estado, string codigo, string ceg, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaEspecialidadMedicoTriaje - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaEspecialidadMedicoTriaje - start {A}, limit {B}, cmp {C}, nombrecompleto {D} ,nroregespecialidad {E}, idespecialidad {F}" +
                                        ",estado {G}, codigo {H},ceg {I}, tipoBuscar {J}", start, limit, cmp, nombrecompleto, nroregespecialidad, idespecialidad, estado, codigo, ceg, tipoBuscar);
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_SS_GE_ESPECIALIDADMEDICO>();
                var LocalEnty = new VW_SS_GE_ESPECIALIDADMEDICO();
                LocalEnty.CMP = getValorFiltroStr(cmp);
                LocalEnty.NOMBRECOMPLETO = getValorFiltroStr(nombrecompleto);
                LocalEnty.NUMEROREGISTROESPECIALIDAD = getValorFiltroStr(nroregespecialidad);
                LocalEnty.IDESPECIALIDAD = (getValorFiltroInt(idespecialidad) != null ? Convert.ToInt32(getValorFiltroInt(idespecialidad)) : 0);
                LocalEnty.ESTADO = getValorFiltroStr(estado);
                LocalEnty.PERSONA = Convert.ToInt32(getValorFiltroStr(codigo));
                LocalEnty.ORIGEN = getValorFiltroStr(ceg);
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
                Log.Information("BandejaMedicoController - getGrillaEspecialidadMedicoTriaje - Bloque Catch");
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


        #endregion

        public System.Web.Mvc.ActionResult DialojMedicosTriaje(String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - DialojMedicosTriaje - Entrar");
            Log.Debug("BandejaMedicoController - DialojMedicosTriaje - accionSeleccion {A}, accionListado {B}"
                                    , accionSeleccion, accionListado);
            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
            obj.USUARIO = accionListado;
            obj.ACCION = accionSeleccion;
            if (Session["MODULO_DEF"] != null)
            {
            }
            return crearWindowRegistro("RelevoMedicoDialojList", obj, "");
        }

        public System.Web.Mvc.ActionResult GetAllGrillaBandejaTriaje(DataBandeja objBandeja,
          String UnidadReplicacion, String PacienteNombre, String DocumentoIdentidad,
          String NroHC, String FechaInicio, String FechaFin, String Prioridad,
          String Estado, String IdEspecialidad, String AccionFiltro)
        {
            Log.Information("BandejaMedicoController - GetAllGrillaBandejaTriaje - Entrar");
            Log.Debug("BandejaMedicoController - GetAllGrillaBandejaTriaje - objBandeja {A}, UnidadReplicacion {B}, PacienteNombre {C}, DocumentoIdentidad {D} ,NroHC {E}, FechaInicio {F}" +
                                        ",FechaFin {G}, Prioridad {H},Estado {I}, IdEspecialidad {J},  AccionFiltro {K}, tipoBuscar {L}"
                                    , objBandeja, UnidadReplicacion, PacienteNombre, DocumentoIdentidad, NroHC, FechaInicio, FechaFin, Prioridad, Estado, IdEspecialidad, AccionFiltro);

            if (objBandeja.AccionFiltro != null || objBandeja.DocumentoIdentidad != null || objBandeja.Estado != null ||
               objBandeja.FechaFin != null || objBandeja.FechaInicio != null || objBandeja.IdEspecialidad != null ||
               objBandeja.NroHC != null || objBandeja.PacienteNombre != null || objBandeja.Prioridad != null ||
               objBandeja.UnidadReplicacion != null)
            {

                objBandeja.AccionFiltro = AccionFiltro;
                objBandeja.DocumentoIdentidad = DocumentoIdentidad;
                if (Estado == "")
                {
                    objBandeja.Estado = null;
                }
                else if (Estado == null)
                {
                    objBandeja.Estado = null;
                }
                else
                {
                    objBandeja.Estado = Convert.ToInt32(Estado);
                }

                if (FechaInicio == "")
                {
                    FechaInicio = null;
                }
                else
                {
                    objBandeja.FechaInicio = Convert.ToDateTime(FechaInicio);
                    objBandeja.FechaFin = Convert.ToDateTime(FechaFin);
                }

                if (FechaFin == "")
                {
                    FechaFin = null;
                }
                else
                {
                    objBandeja.FechaInicio = Convert.ToDateTime(FechaInicio);
                    objBandeja.FechaFin = Convert.ToDateTime(FechaFin);
                }

                //Agregado JM 20/10/2020
                double PARAFILTROFEcahora = 0;
                decimal PARAFILTROFECHA = (decimal)UTILES_MENSAJES.getParametro_Form("ACTIVIDDIA");
                double nrfec = 0;
                PARAFILTROFEcahora = Convert.ToDouble(PARAFILTROFECHA);
                nrfec = (Convert.ToDateTime(objBandeja.FechaFin) - Convert.ToDateTime(objBandeja.FechaInicio)).TotalDays;

                if (nrfec > PARAFILTROFEcahora)
                {
                    DateTime FechaXX = Convert.ToDateTime(objBandeja.FechaFin);
                    objBandeja.FechaInicio = FechaXX.AddDays(-PARAFILTROFEcahora);
                }
                ///

                if (IdEspecialidad == "") { objBandeja.IdEspecialidad = 0; } else { objBandeja.IdEspecialidad = Convert.ToInt32(IdEspecialidad); }
                objBandeja.NroHC = NroHC;
                objBandeja.PacienteNombre = PacienteNombre;
                if (Prioridad == "") { objBandeja.Prioridad = 0; } else { objBandeja.Prioridad = Convert.ToInt32(Prioridad); }
                objBandeja.UnidadReplicacion = UnidadReplicacion;

            }

            int PageNumber = 1;
            int PageSize = 10;
            int contador = 0;
            var Listar2 = new List<SP_ListarBandejaTriaje_Result>();
            Listar2 = SvcEpisodioTriaje.EpisorioTriaje_Listar(objBandeja, PageNumber, PageSize);
            objBandeja = null;
            //var query = Listar2.AsQueryable();

            //var lst = query.Skip(PageNumber).Take(10).ToList().ToList();

            contador = Listar2.Count(); //Convert.ToInt32(SvcEpisodioTriaje.GetItemCount());
            //ENTITY_GLOBAL.Instance.CountCloseSessionTriaje++;
            return this.Store(Listar2, contador);
        }


        public System.Web.Mvc.ActionResult GuardarBandeja(SS_HC_EpisodioTriaje obje)
        {
            Log.Information("BandejaMedicoController - GuardarBandeja - Entrar");
            Log.Debug("BandejaMedicoController - GuardarBandeja - start {A}", obje);
            try
            {

                long idResultado = 0;
                String Accion = obje.Accion.Trim();
                obje.Estado = 0;
                SS_CE_TriajeViewModel p = new SS_CE_TriajeViewModel();
                p.Accion = "VALIDA_PACIENTE";
                p.UsuarioCreacion = obje.IdPaciente.ToString(); //IDPACIENTE
                p.UsuarioModificacion = ENTITY_GLOBAL.Instance.CodigoHceRequest; // HC
                var response = SvcEpisodioTriaje.RegistrarTriajeSpringData(p);

                if (response == 1)
                {
                    DataTable dtValida = new DataTable();

                    HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                    HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                    WsEpisodio.IdPaciente = obje.IdPaciente;
                    WsEpisodio.UsuarioCreacion = "UPDATE_HISTORIA";
                    WsEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                    dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);

                    if (dtValida != null)
                    {

                        String HcResponse = "";

                        for (int i = 0; i < dtValida.Rows.Count; i++)
                        {
                            HcResponse = dtValida.Rows[i]["HISTORIA"].ToString();
                        }

                        var idPacientes = Convert.ToInt32(obje.IdPaciente);
                        //try
                        //{
                        //    var id = SvcEpisodioTriaje.UpdatePacienteHC(idPacientes, HcResponse);
                        //}
                        //catch (Exception ex2)
                        //{

                        //    HClinicaController.GinecoLog(this, ex2);
                        //    return showMsgTratamientoExcepcion(ex2, "");
                        //    throw;
                        //}
                        obje.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        obje.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        obje.Version = HcResponse;
                    }

                    idResultado = SvcEpisodioTriaje.setMantenimientoEpisodioTriaje(obje);

                }
                else if (response == 2)
                {
                    idResultado = SvcEpisodioTriaje.setMantenimientoEpisodioTriaje(obje);
                }

                var lstTriaje = SvcEpisodioTriaje.getSelectEpisodioByCode(idResultado);

                obje.CodigoOT = lstTriaje[0].CodigoOT;


                ENTITY_GLOBAL.Instance.CodigoOrdenTriaje = lstTriaje[0].CodigoOT; ;

                obje.UnidadReplicacion = "CEG";
                obje.Accion = "INSERT_TRIAJE";
                obje.IdEpisodioTriaje = 0;
                //obje.CodigoOT = "0";
                obje.IdPrioridad = 0;
                obje.IdPersonalSalud = 0;
                obje.IdEspecialidad = null;
                obje.FlagFirma = 0;
                //obje.Estado = 0;
                obje.IdMedicoFirma = 0;

                String JsonDataTriaje = JsonConvert.SerializeObject(obje);
                String responseTriaje = "[" + JsonDataTriaje + "]";

                //LISTA TEMPORARL 
                List<TemporalSesionTriaje> ObjDataTriaje = (List<TemporalSesionTriaje>)Newtonsoft.Json.JsonConvert.DeserializeObject(responseTriaje, typeof(List<TemporalSesionTriaje>));

                Session["DATA_ALL_TRIAJE"] = ObjDataTriaje[0];
                if (idResultado >= 1)
                {
                    ENTITY_GLOBAL.Instance.ACCCION_ABRIR_ARBOL = "ABRIR_TRIAJE";
                    ENTITY_GLOBAL.Instance.EpisodioTriaje = Convert.ToInt32(idResultado);
                    return showMensajeNotify("Mensaje", "Registro Exitoso.!!", "INFO");
                }


            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GuardarBandeja - Bloque Catch");
                Log.Error(ex, ex.Message);
                HClinicaController.GinecoLog(this, ex);
                return showMsgTratamientoExcepcion(ex, "");
                throw;
            }

            return null;
        }

        public System.Web.Mvc.ActionResult EstadoClinicoTriaje(string selection, string accion, string idUnidadServicio)
        {
            Log.Information("BandejaMedicoController - EstadoClinicoTriaje - Entrar");
            Log.Debug("BandejaMedicoController - EstadoClinicoTriaje - selection {A}, accion {B}, idUnidadServicio {C}"
                                    , selection, accion, idUnidadServicio);
            bool indicaAbrir = false;
            long registro = -1;
            var datitoxd = ENTITY_GLOBAL.Instance.COD_BANDEJA;
            var DATA_ALL_TRIAJE = Session["DATA_ALL_TRIAJE"];
            String JsonDataTriaje = JsonConvert.SerializeObject(DATA_ALL_TRIAJE);
            String responseTriaje = "[" + JsonDataTriaje + "]";
            List<TemporalSesionTriaje> ObjTriajeListar = (List<TemporalSesionTriaje>)Newtonsoft.Json.JsonConvert.DeserializeObject(responseTriaje, typeof(List<TemporalSesionTriaje>));
            Session["DATA_ALL_PACIENTE_CABECERA"] = DATA_ALL_TRIAJE;
            var pueba = Session["DATA_ALL_PACIENTE_CABECERA"];
            ENTITY_GLOBAL.Instance.EpisodioClinico = 1;
            ENTITY_GLOBAL.Instance.EpisodioAtencion = 1; /*ObjListar[0].IdEpisodioAtencion;*/
            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = 2;//ADD cambios --/09/2015
            ENTITY_GLOBAL.Instance.MODALIDAD_TEMP = ObjTriajeListar[0].Modalidad;
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
            ENTITY_GLOBAL.Instance.PacienteID = ObjTriajeListar[0].IdPaciente;
            ENTITY_GLOBAL.Instance.CodigoOA = ObjTriajeListar[0].CodigoOA;
            ENTITY_GLOBAL.Instance.CAMA = "CAMA";
            ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER = "Emergencia";
            ENTITY_GLOBAL.Instance.IdMedico = Convert.ToInt32(ObjTriajeListar[0].Comentarios);
            ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = Convert.ToInt32(1); //ADD ORLANDO 17.05.2017
            ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = Convert.ToInt32(1); //ADD ORLANDO 17.05.2017
            Session["TIPOATENCION_ACTUAL"] = Convert.ToInt32(ObjTriajeListar[0].TipoAtencion);
            if (ObjTriajeListar.Count > 0)
            {
                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = ObjTriajeListar[0];
            }
            if (accion == "NUEVAVISITA" || accion == "ABRIR")
            {
                indicaAbrir = true;
            }
            //GUARDAR TEMPORAL: UnidServicio
            VW_ATENCIONPACIENTE_GENERAL objEpiAtencionSelecc;
            Nullable<int> UnidadServicioAux = null;
            if (getValorFiltroInt(idUnidadServicio) != null)
            {
                UnidadServicioAux = Convert.ToInt32(getValorFiltroInt(idUnidadServicio));
            }
            else
            {
                VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                UnidadServicioAux = Convert.ToInt32(seleccion.IdUnidadServicio);
            }
            Nullable<int> EstablecimientoAux = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
            Session["IdUnidadServicio_ACTUAL"] = UnidadServicioAux;
            if (idUnidadServicio == "Triaje")
            {
                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                epiAtencionSave.Accion = "LISTARPORID";
                List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                if (listaEpi.Count > 0)
                {
                    ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO                    
                    if (listaEpi[0].Estado == UTILES_MENSAJES.ESTADO_EPI_ATENDIDO) //Atendido - firmado
                    {
                        //regresar a estado de EN ATENCION
                        actualizarEstadoEpiAtencion(listaEpi[0], UTILES_MENSAJES.ESTADO_EPI_ENATENCION);
                    }
                    //Cambiar estado de ATENCIO FIRMADA
                    return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio en Modo - MODIFICAR . Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                        ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");
                }
            }

            if (accion == "NUEVAVISITA" || accion == "ABRIR")// jordan mateo 02/04/2019 
            {
                SS_HC_EpisodioAtencion epiAtencionObjSave = new SS_HC_EpisodioAtencion();
                SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();
                epiAtencionObjSave.CodigoOA = EpiAtencionTemp.CodigoOA;
                epiAtencionObjSave.IdEspecialidad = EpiAtencionTemp.IdEspecialidad;
                epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                epiAtencionObjSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                epiAtencionObjSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                epiAtencionObjSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                epiAtencionObjSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionObjSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                epiAtencionObjSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                epiAtencionObjSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                if (epiAtencionObjSave.TipoAtencion == 1)
                {
                    epiAtencionObjSave.Accion = "LISTAR";
                    List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionObjSave, 0, 0);
                    if (listaEpi.Count > 0)
                    {
                        foreach (SS_HC_EpisodioAtencion Obj_EpisodioAtencion in listaEpi)
                        {
                            if (!string.IsNullOrEmpty(Obj_EpisodioAtencion.IdPersonalSalud.ToString())) ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(Obj_EpisodioAtencion.IdPersonalSalud);
                            ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(Obj_EpisodioAtencion.FechaFirma);
                            ENTITY_GLOBAL.Instance.EpisodioClinico = Obj_EpisodioAtencion.EpisodioClinico;
                            ENTITY_GLOBAL.Instance.EpisodioAtencion = Obj_EpisodioAtencion.EpisodioAtencion;
                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = Obj_EpisodioAtencion.EpisodioAtencion;
                            if (Obj_EpisodioAtencion.TipoAtencion.ToString() != null) ENTITY_GLOBAL.Instance.TIPOATENCION = Obj_EpisodioAtencion.TipoAtencion.ToString();
                            if (Obj_EpisodioAtencion.IdEpisodioAtencion != null)
                            {
                                ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = Convert.ToInt64(Obj_EpisodioAtencion.IdEpisodioAtencion);
                                ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = Convert.ToInt64(Obj_EpisodioAtencion.IdEpisodioAtencion);
                            }
                            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                        }
                        accion = "UPDATE";
                    }
                }
            }
            if (accion == "ABRIR")
            {
                SS_HC_EpisodioAtencion epiAtencionObjAbrir = new SS_HC_EpisodioAtencion();
                epiAtencionObjAbrir.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionObjAbrir.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionObjAbrir.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionObjAbrir.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                epiAtencionObjAbrir.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionObjAbrir.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionObjAbrir.IdEpisodioAtencion = -1;
                epiAtencionObjAbrir.EpisodioClinico = -1;

                SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();

                epiAtencionObjAbrir.FlagFirma = EpiAtencionTemp.FlagFirma;
                epiAtencionObjAbrir.FechaOrden = EpiAtencionTemp.FechaOrden;
                epiAtencionObjAbrir.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                epiAtencionObjAbrir.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                epiAtencionObjAbrir.Accion = "ABRIREPICLINICO";
                registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAbrir);
                int EpicLinico = 0;
                if (registro > 0)
                {
                    accion = "Continuar";
                    EpicLinico = Convert.ToInt32("" + registro);
                    ENTITY_GLOBAL.Instance.EpisodioClinico = EpicLinico;
                }
                else
                {
                    accion = "Nuevo";
                }
            }

            if (accion == "Continuar" || accion == "NUEVAVISITA")
            {
                if (!indicaAbrir)
                {
                    SelectPersonaEpisodioAuxiliar(selection, accion);
                }
                if (ENTITY_GLOBAL.Instance.EpisodioClinico != null)
                {
                    SS_HC_EpisodioAtencion epiAtencionObjSave = new SS_HC_EpisodioAtencion();
                    epiAtencionObjSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionObjSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionObjSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                    epiAtencionObjSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionObjSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionObjSave.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                    epiAtencionObjSave.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim; //ADD  cambios 09/15 
                    if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                    {
                        epiAtencionObjSave.TipoTrabajador = "" + Session["TIPOTRABAJADOR_ACTUAL"];
                    }
                    string mensajeFinal = "";
                    if (accion == "Continuar")
                    {
                        epiAtencionObjSave.TipoEpisodio = "EPISODIO";
                        epiAtencionObjSave.Accion = "CONTINUAR";
                        mensajeFinal = "NUEVO Episodio";
                    }
                    else
                    {
                        epiAtencionObjSave.TipoEpisodio = "VISITA";
                        epiAtencionObjSave.Accion = "INSERT";
                        mensajeFinal = "NUEVA Visita de Episodio";
                    }
                    SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();

                    if (EpiAtencionTemp != null)
                    {
                        epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                        Nullable<int> idEspecialidadAux = EpiAtencionTemp.IdEspecialidad;
                        if (UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL") != null)
                        {
                            int idEspecialidadTemp = (int)UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL");
                            if (idEspecialidadTemp > 0)
                            {
                                idEspecialidadAux = idEspecialidadTemp;
                            }
                        }
                        epiAtencionObjSave.IdEspecialidad = idEspecialidadAux;
                        epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                        epiAtencionObjSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                        epiAtencionObjSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                        epiAtencionObjSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                    }
                    epiAtencionObjSave.IdUnidadServicio = UnidadServicioAux;
                    epiAtencionObjSave.IdEstablecimientoSalud = EstablecimientoAux;
                    epiAtencionObjSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.IdMedico;
                    registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjSave);
                    if (registro > 0)
                    {
                        ENTITY_GLOBAL.Instance.EpisodioAtencion = registro;
                        epiAtencionObjSave.EpisodioClinico = 0;
                        epiAtencionObjSave.IdEpisodioAtencion = 0;
                        epiAtencionObjSave.Accion = "LISTAR";
                        List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionObjSave, 0, 0);

                        ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                        if (listaEpi.Count > 0)
                        {
                            //if (!string.IsNullOrEmpty(listaEpi[0].IdPersonalSalud.ToString())) ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);                       
                            ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                            ENTITY_GLOBAL.Instance.EpisodioClinico = listaEpi[0].EpisodioClinico;
                            epiAtencionObjSave.EpisodioClinico = listaEpi[0].EpisodioClinico;
                            epiAtencionObjSave.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                            // cambio para pruebas independientes
                            try
                            {
                                int IdEp = Convert.ToInt32(registro);
                                int IdCli = epiAtencionObjSave.EpisodioClinico;
                                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                string valor = "";
                                valor = ObtenerTramaOA.InterOperabilidadConsultaExterna(listaEpi[0].UnidadReplicacion, IdEp, listaEpi[0].IdPaciente, epiAtencionObjSave.EpisodioClinico).ToString();
                            }
                            catch (Exception ex)
                            {
                                showMensajeNotifyData("Error", "No se pudo enviar por el servicio  " + listaEpi[0].UnidadReplicacion.Trim() + "|" + registro + "|" + listaEpi[0].IdPaciente + "|" + listaEpi[0].EpisodioClinico + "  |  " + ex.StackTrace, "ERROR", false);
                            }

                            /******ADD PARA FORMATOS COMPARTIDOS***/
                            epiAtencionObjSave.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                            epiAtencionObjSave.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                            epiAtencionObjSave.EpisodioClinico = listaEpi[0].EpisodioClinico;
                            epiAtencionObjSave.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                            epiAtencionObjSave.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                            epiAtencionObjSave.Accion = "FORM_COMPARTIDOS";
                            long resultFormComp = SvcEpisodioAtencion.setCopiarEpisodio(epiAtencionObjSave, 0, "");
                            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                            ////////
                            objEpiAtencionSelecc = getVW_ATENCIONPACIENTE_GENERAL_SELECC();
                            objEpiAtencionSelecc.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                            objEpiAtencionSelecc.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                            objEpiAtencionSelecc.EpisodioClinico = listaEpi[0].EpisodioClinico;
                            objEpiAtencionSelecc.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                            objEpiAtencionSelecc.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                            Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = objEpiAtencionSelecc;

                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                            ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = listaEpi[0].IdEpisodioAtencion;
                            ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = listaEpi[0].IdEpisodioAtencion;
                            ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO

                            ///////////////////////////////
                            /******ADD**********/
                            VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                            {
                                vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                            }
                            var Listar = new List<PERSONAMAST>();
                            var LocalEnty = new PERSONAMAST();
                            var objDatos = new PERSONAMAST();
                            LocalEnty.ACCION = "LISTARPACIENTE";
                            LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                            Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
                            if (Listar.Count > 0)
                            {
                                Session["Ssesion_ListarPaciiente"] = Listar;
                                foreach (PERSONAMAST objPersona in Listar)
                                {
                                    objDatos = objPersona;
                                    Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                                    int edad = 0;
                                    DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                                    DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                                    if (nacimiento != null)
                                    {
                                        edad = DateTime.Now.Year - nacimiento.Year;
                                        if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                            edad = edad - 1;
                                    }
                                    Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                                    if (vistaGenSelec.Origen == "Consulta")
                                    {
                                        Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                                    }
                                    else
                                    {
                                        var componente = vistaGenSelec.ComponenteNombre;
                                        Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                                    }
                                    ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelec.TipoOrdenAtencion;
                                    ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelec.CodigoHC;
                                    ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelec.CodigoOA;
                                    ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelec.Componente;

                                }
                            }
                            /***************/

                            return showMensajeNotify("Ventana de Mensajes",
                                "Registro satisfactorio de " + mensajeFinal + ". Código Transacción: " +
                                UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                                listaEpi[0].EpisodioAtencion,
                                listaEpi[0].IdEpisodioAtencion, 0, ""), "INFO");
                        }
                    }
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                }
                else
                {
                    X.Msg.Alert("Ventana de Validación", "Por favor seleccione Episodio Clínico a Continuar...").Show();
                }
            }
            else if (accion == "Nuevo")
            {
                SS_HC_EpisodioAtencion epiAtencionClinicoSave = new SS_HC_EpisodioAtencion();
                epiAtencionClinicoSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019;
                epiAtencionClinicoSave.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionClinicoSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionClinicoSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                epiAtencionClinicoSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionClinicoSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionClinicoSave.IdEpisodioAtencion = -1;
                epiAtencionClinicoSave.EpisodioClinico = -1;

                string mensage = "";
                PERSONAMAST personaTemp = getPERSONAMAST_SELECC();
                SS_GE_Paciente pacienteTemp = getSS_GE_Paciente_SELECC();
                SS_HC_EpisodioClinico EpiClinicoTemp = getSS_HC_EpisodioClinico_SELECC();
                SS_HC_EpisodioAtencion EpiAtencionTemp = null;
                SS_HC_AsignacionMedico asigmedicoTemp = getSS_HC_AsignacionMedico_SELECC();

                List<SS_HC_EpisodioAtencion> listaEpiAtencionTemp = new List<SS_HC_EpisodioAtencion>();
                if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                {
                    EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();
                    EpiAtencionTemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    EpiAtencionTemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    EpiAtencionTemp.IdUnidadServicio = UnidadServicioAux;
                    EpiAtencionTemp.IdEstablecimientoSalud = EstablecimientoAux;
                    listaEpiAtencionTemp.Add(EpiAtencionTemp);
                }

                epiAtencionClinicoSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                registro = SvcEpisodioAtencion.setPreMantenimiento(personaTemp, pacienteTemp, asigmedicoTemp, EpiClinicoTemp, listaEpiAtencionTemp);
                if (registro > 0)
                {
                    //////////////////////Guardar Episodio Clinico
                    if (EpiAtencionTemp != null)
                    {
                        epiAtencionClinicoSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                    }
                    epiAtencionClinicoSave.Accion = "EPISODIOCLINICO";
                    registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionClinicoSave);
                    if (registro > 0)
                    {
                        ENTITY_GLOBAL.Instance.EpisodioClinico = Convert.ToInt32(registro);
                        SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                        epiAtencionSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.IdMedico;
                        epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                        epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                        epiAtencionSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                        epiAtencionSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        epiAtencionSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                        epiAtencionSave.TipoEpisodio = "EPISODIO";
                        if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                        {
                            epiAtencionSave.TipoTrabajador = "" + Session["TIPOTRABAJADOR_ACTUAL"];
                        }
                        /******ADD**********/
                        VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                        if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                        {
                            vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                        }
                        var Listar = new List<PERSONAMAST>();
                        var LocalEnty = new PERSONAMAST();
                        var objDatos = new PERSONAMAST();
                        LocalEnty.ACCION = "LISTARPACIENTE";
                        LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                        Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
                        if (Listar.Count > 0)
                        {
                            Session["Ssesion_ListarPaciiente"] = Listar;
                            foreach (PERSONAMAST objPersona in Listar)
                            {
                                objDatos = objPersona;
                                ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto;
                                Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                                if (vistaGenSelec.Origen == "Consulta")
                                {
                                    Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                                }
                                ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelec.CodigoHC;
                                ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelec.CodigoOA;
                                ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelec.Componente;

                                int edad = 0;
                                DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                                DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                                if (nacimiento != null)
                                {
                                    edad = DateTime.Now.Year - nacimiento.Year;
                                    if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                        edad = edad - 1;
                                }
                                Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                            }
                        }
                        epiAtencionSave.Accion = "INSERT";
                        if (EpiAtencionTemp != null)
                        {
                            epiAtencionSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                            Nullable<int> idEspecialidadAux = EpiAtencionTemp.IdEspecialidad;
                            if (UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL") != null)
                            {
                                int idEspecialidadTemp = (int)UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL");
                                if (idEspecialidadTemp > 0)
                                {
                                    idEspecialidadAux = idEspecialidadTemp;
                                }
                            }
                            epiAtencionSave.IdEspecialidad = idEspecialidadAux;
                            epiAtencionSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                            epiAtencionSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                            epiAtencionSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                            epiAtencionSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                            epiAtencionSave.FechaOrden = EpiAtencionTemp.FechaOrden;

                        }
                        epiAtencionSave.IdUnidadServicio = UnidadServicioAux;
                        epiAtencionSave.IdEstablecimientoSalud = EstablecimientoAux;
                        if (!string.IsNullOrEmpty(ENTITY_GLOBAL.Instance.CODPERSONA.ToString())) epiAtencionSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                        registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionSave);
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                        if (registro > 0)
                        {
                            epiAtencionSave.IdEpisodioAtencion = registro;
                            epiAtencionSave.Accion = "LISTARPORID";
                            List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                            ENTITY_GLOBAL.Instance.EpisodioAtencion = registro;
                            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                            if (listaEpi.Count > 0)
                            {
                                /******ADD PARA FORMATOS COMPARTIDOS***/
                                if (!string.IsNullOrEmpty(listaEpi[0].IdPersonalSalud.ToString())) ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                                ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                                epiAtencionSave.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                epiAtencionSave.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                epiAtencionSave.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                epiAtencionSave.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                epiAtencionSave.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                epiAtencionSave.Accion = "FORM_COMPARTIDOS";
                                /******ADD PARA INTEROPERABILIDAD***/
                                try
                                {
                                    HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                    string valor = "";
                                    int IdEp = Convert.ToInt32(epiAtencionSave.IdEpisodioAtencion);
                                    valor = ObtenerTramaOA.InterOperabilidadConsultaExterna(epiAtencionSave.UnidadReplicacion, IdEp, epiAtencionSave.IdPaciente, epiAtencionSave.EpisodioClinico).ToString();
                                }
                                catch
                                {
                                }
                                long resultFormComp = SvcEpisodioAtencion.setCopiarEpisodio(epiAtencionSave, 0, "");
                                objEpiAtencionSelecc = getVW_ATENCIONPACIENTE_GENERAL_SELECC();
                                objEpiAtencionSelecc.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                objEpiAtencionSelecc.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                objEpiAtencionSelecc.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                objEpiAtencionSelecc.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                objEpiAtencionSelecc.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = objEpiAtencionSelecc;
                                ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                                ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                                return showMensajeNotify("Ventana de Mensajes", " Registro satisfactorio de Episodio NUEVO . Código Transacción: " +
                                    UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo, listaEpi[0].EpisodioAtencion, listaEpi[0].IdEpisodioAtencion, 0, ""), "INFO");

                            }
                        }
                    }
                }
                else
                {

                    return showMensajeBox("Imposible Ingresar", "", "");
                }


            }
            else if (accion == "Finalizar")
            {

                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;

                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                epiAtencionSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionSave.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);

                //ADD ref Unidad Serv 21/09
                epiAtencionSave.IdUnidadServicio = UnidadServicioAux;
                epiAtencionSave.IdEstablecimientoSalud = EstablecimientoAux;

                epiAtencionSave.Accion = "FINALIZAATENCION";

                registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionSave);

                //X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + "Registro" + ". Episodio de Atención Finalizado: " + String.Format("{0:00000}", registro)).Show();
                return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio FINALIZADO . Código Transacción: " +
                    UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                    ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");

            }
            else if (accion == "VISTA")
            {
                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = 1;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = 2;
                //ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "ABRIR_TRIAJE";

                ENTITY_GLOBAL.Instance.ACCCION_ABRIR_ARBOL = "ABRIR_TRIAJE";
                // ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION2 = "UPDATE";
                /////////////////
                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();

                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                epiAtencionSave.Accion = "LISTARPORID";

                //agregado para la accion vista
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";

                List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                if (listaEpi.Count > 0)
                {
                    //ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                    ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO                    
                    //if (getValorFiltroInt(listaEpi[0].Accion) != null)
                    //{
                    //    try
                    //    {
                    //        //ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = Convert.ToInt32(listaEpi[0].Accion); //AUX CODIGO EPI CLINICO : MODIF 2017-08
                    //         ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO //VERS ANTIGUA
                    //    }
                    //    catch (Exception e) { }
                    //}
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                    //if (listaEpi[0].Estado == UTILES_MENSAJES.ESTADO_EPI_ATENDIDO) //Atendido - firmado
                    //{
                    //    //regresar a estado de EN ATENCION
                    //    actualizarEstadoEpiAtencion(listaEpi[0], UTILES_MENSAJES.ESTADO_EPI_ENATENCION);
                    //}
                    ENTITY_GLOBAL.Instance.COD_BANDEJA = "TRIAJE";

                    //Cambiar estado de ATENCIO FIRMADA

                    //X.Msg.Notify("Ventana de Mensajes ",
                    //  "Satisfactoriamente se " + "Registro" + ". Nuevo Episodio Clínico y Atención : "
                    //+ String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();
                    return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio en Modo - VISTA . Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                        ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");

                }
            }
            else if (accion == "AUDITOR")
            {
                /******ADD**********/
                VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                {
                    vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                }
                var Listar = new List<PERSONAMAST>();
                var LocalEnty = new PERSONAMAST();
                var objDatos = new PERSONAMAST();
                LocalEnty.ACCION = "LISTARPACIENTE";
                LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
                if (Listar.Count > 0)
                {
                    Session["Ssesion_ListarPaciiente"] = Listar;
                    foreach (PERSONAMAST objPersona in Listar)
                    {
                        objDatos = objPersona;
                        //ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto;
                        Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                        if (vistaGenSelec.Origen == "Consulta")
                        {
                            Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                        }
                        else
                        {
                            var componente = vistaGenSelec.ComponenteNombre;
                            Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                        }

                        ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelec.TipoOrdenAtencion;
                        ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelec.CodigoHC;
                        ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelec.CodigoOA;
                        ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelec.Componente;
                        int edad = 0;
                        DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                        DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                        if (nacimiento != null)
                        {
                            edad = DateTime.Now.Year - nacimiento.Year;
                            if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                edad = edad - 1;

                            //if (edad < 0)
                            //{
                            //    edad = 0;
                            //}
                        }
                        //DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                        //DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                        //int edad = DateTime.Today.AddTicks(-nacimiento.Ticks).Year - 1;


                        Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                    }
                }
                /***************/

                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                // ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION2 = "VISTA";
                //X.Msg.Notify("Ventana de Mensajes ", "" + "Registro" + ". Episodio de Atención Solo Lectura: " + String.Format("{0:00000}", registro)).Show();
                /////////////////
                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                epiAtencionSave.Accion = "LISTARPORID";
                List<SS_HC_EpisodioAtencion> listaEpi =
                    SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                if (listaEpi.Count > 0)
                {
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                    ENTITY_GLOBAL.Instance.IdMedicoaudi = Convert.ToInt32(listaEpi[0].IdPersonalSalud);

                    //if (getValorFiltroInt(listaEpi[0].Accion) != null)
                    //{
                    //    try
                    //    {
                    //        //ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = Convert.ToInt32(listaEpi[0].Accion); //AUX CODIGO EPI CLINICO : MODIF 2017-08
                    //        ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO //VERS ANTIGUA
                    //    }
                    //    catch (Exception e) { }
                    //}
                    //X.Msg.Notify("Ventana de Mensajes ",
                    //  "Satisfactoriamente se " + "Registro" + ". Nuevo Episodio Clínico y Atención : "
                    //+ String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();
                    return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio en Modo - SÓLO LECTURA. Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                        ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");

                }

            }
            else if (accion == "UPDATE")
            {





                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                // ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION2 = "UPDATE";
                /////////////////
                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                //epiAtencionSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                epiAtencionSave.Accion = "LISTARPORID";
                List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                if (listaEpi.Count > 0)
                {
                    //ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                    ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO                    
                    //if (getValorFiltroInt(listaEpi[0].Accion) != null)
                    //{
                    //    try
                    //    {
                    //        //ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = Convert.ToInt32(listaEpi[0].Accion); //AUX CODIGO EPI CLINICO : MODIF 2017-08
                    //         ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO //VERS ANTIGUA
                    //    }
                    //    catch (Exception e) { }
                    //}

                    if (listaEpi[0].Estado == UTILES_MENSAJES.ESTADO_EPI_ATENDIDO) //Atendido - firmado
                    {
                        //regresar a estado de EN ATENCION
                        actualizarEstadoEpiAtencion(listaEpi[0], UTILES_MENSAJES.ESTADO_EPI_ENATENCION);
                    }

                    //Cambiar estado de ATENCIO FIRMADA

                    //X.Msg.Notify("Ventana de Mensajes ",
                    //  "Satisfactoriamente se " + "Registro" + ". Nuevo Episodio Clínico y Atención : "
                    //+ String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();
                    return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio en Modo - MODIFICAR . Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                        ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");

                }


            }
            else if (accion == "ABRIR_TRIAJE")
            {


                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = 1;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = 2;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "ABRIR_TRIAJE";

                ENTITY_GLOBAL.Instance.ACCCION_ABRIR_ARBOL = "ABRIR_TRIAJE";
                // ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION2 = "UPDATE";
                /////////////////
                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionSave.IdPaciente = 14;
                epiAtencionSave.EpisodioClinico = 2;
                epiAtencionSave.IdEpisodioAtencion = 1;
                //epiAtencionSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;
                epiAtencionSave.Accion = "LISTARPORID";
                List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                if (listaEpi.Count > 0)
                {
                    //ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                    ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO                    
                    //if (getValorFiltroInt(listaEpi[0].Accion) != null)
                    //{
                    //    try
                    //    {
                    //        //ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = Convert.ToInt32(listaEpi[0].Accion); //AUX CODIGO EPI CLINICO : MODIF 2017-08
                    //         ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO //VERS ANTIGUA
                    //    }
                    //    catch (Exception e) { }
                    //}

                    if (listaEpi[0].Estado == UTILES_MENSAJES.ESTADO_EPI_ATENDIDO) //Atendido - firmado
                    {
                        //regresar a estado de EN ATENCION
                        actualizarEstadoEpiAtencion(listaEpi[0], UTILES_MENSAJES.ESTADO_EPI_ENATENCION);
                    }
                    ENTITY_GLOBAL.Instance.COD_BANDEJA = "TRIAJE";

                    //Cambiar estado de ATENCIO FIRMADA

                    //X.Msg.Notify("Ventana de Mensajes ",
                    //  "Satisfactoriamente se " + "Registro" + ". Nuevo Episodio Clínico y Atención : "
                    //+ String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();
                    return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio en Modo - MODIFICAR . Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                        ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");

                }


            }



            return this.Direct();


        }
        /**Listado de Unidad de Servicio*/


        public System.Web.Mvc.ActionResult SelectPersonaEpisodioEventoTriaje(String selection, string accion)
        {
            Log.Information("BandejaMedicoController - SelectPersonaEpisodioEventoTriaje - Entrar");
            Log.Debug("BandejaMedicoController - SelectPersonaEpisodioEventoTriaje - selection {A}, accion {B}"
                                    , selection, accion);
            this.GetCmp<Button>("btnShowHC").Disabled = false;

            if (accion != "Continuar")
            {




                this.GetCmp<Button>("NewEpisodio").Disabled = true;
                this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                this.GetCmp<Button>("ContEpisodio").Disabled = true;
                this.GetCmp<Button>("VerEpisodio").Disabled = true;


                //ADD 09/15                
                this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                this.GetCmp<Button>("btnModifVisita").Disabled = true;
                this.GetCmp<Button>("btnVerVisita").Disabled = true;
                this.GetCmp<Button>("btnVisitas").Disabled = true;
                this.GetCmp<Button>("abrirEpisodio").Disabled = true;
                //if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                //{
                //    this.GetCmp<Button>("btnllamadoVisita").Disabled = true;
                //}

            }

            //ENTITY_GLOBAL.Instance.NIVEL = 1;
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
            //List<VW_ATENCIONPACIENTE_GENERAL> ObjListar = (List<VW_ATENCIONPACIENTE_GENERAL>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<VW_ATENCIONPACIENTE_GENERAL>));


            //String json = selection.Replace("\"", "");
            List<VW_ATENCIONPACIENTE_GENERAL> ObjListar = (List<VW_ATENCIONPACIENTE_GENERAL>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<VW_ATENCIONPACIENTE_GENERAL>));

            //LISTA TEMPORARL 
            List<TemporalSesionTriaje> ObjDataTriaje = (List<TemporalSesionTriaje>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<TemporalSesionTriaje>));

            //accion = "Nuevo" TemporalSesionTriaje;


            Session["DATA_ALL_TRIAJE"] = ObjDataTriaje[0];

            ENTITY_GLOBAL.Instance.EpisodioTriaje = ObjDataTriaje[0].IdEpisodioTriaje;
            ENTITY_GLOBAL.Instance.NombreCompletoPaciente = ObjDataTriaje[0].Accion;
            ENTITY_GLOBAL.Instance.CodigoOrdenTriaje = ObjDataTriaje[0].CodigoOT;
            ENTITY_GLOBAL.Instance.DocumentoCapTriaje = ObjDataTriaje[0].UsuarioModificacion;

            if (ObjListar.Count > 0)
            {
                Session["CodigoHC_PACIENTE"] = "" + ObjListar[0].Version;
                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = ObjListar[0];
                ////TIPO DE ATENCION SELECCIONADA
                if (ObjListar[0].TipoAtencion != null)
                {
                    Session["TIPOATENCION_ACTUAL"] = Convert.ToInt32(ObjListar[0].TipoAtencion);
                }
                if (ObjListar[0].EstadoEpiAtencion == null || ObjListar[0].EstadoEpiAtencion == 0)
                {
                    if (accion != "Continuar")
                    {
                        this.GetCmp<Button>("NewEpisodio").Disabled = false;
                        this.GetCmp<Button>("ContEpisodio").Disabled = false;
                        //ADD 09/15
                        this.GetCmp<Button>("abrirEpisodio").Disabled = false;
                        if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                        {
                            this.GetCmp<Button>("btnllamadoVisita").Disabled = false;
                        }

                    }
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ENTITY_GLOBAL.Instance.CAMA = ObjListar[0].Cama;
                    ENTITY_GLOBAL.Instance.MedicoNombre = ObjListar[0].MedicoNombre;
                    ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER = "Emergencia";
                    ///ADD 09/15
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;

                    ENTITY_GLOBAL.Instance.MODALIDAD_TEMP = ObjListar[0].Modalidad;
                    ENTITY_GLOBAL.Instance.IdMedico = Convert.ToInt32(ObjListar[0].Comentarios);
                    ENTITY_GLOBAL.Instance.COD_MEDICO = ENTITY_GLOBAL.Instance.IdMedico;
                    if (ENTITY_GLOBAL.Instance.IdMedico == 0)
                    {
                        ENTITY_GLOBAL.Instance.IdMedico = null;
                    }
                }
                else
                {
                    ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].EpisodioClinico;
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].EpisodioAtencion; /*ObjListar[0].IdEpisodioAtencion;*/
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = ObjListar[0].EpisodioAtencion;//ADD cambios --/09/2015
                    ENTITY_GLOBAL.Instance.MODALIDAD_TEMP = ObjListar[0].Modalidad;
                    if (ObjListar[0].TipoAtencion.ToString() != null) ENTITY_GLOBAL.Instance.TIPOATENCION = ObjListar[0].TipoAtencion.ToString(); // Agregado 29/01/2018
                    if (ObjListar[0].IdEpisodioAtencion != null)
                    {
                        ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = Convert.ToInt64(ObjListar[0].IdEpisodioAtencion); //ADD ORLANDO 17.05.2017
                        ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = Convert.ToInt64(ObjListar[0].IdEpisodioAtencion); //ADD ORLANDO 17.05.2017
                    }
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ENTITY_GLOBAL.Instance.CAMA = ObjListar[0].Cama;
                    ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER = "Emergencia";
                    //ENTITY_GLOBAL.Instance.IdMedico = Convert.ToInt32(ObjListar[0].IdMedico);
                    ENTITY_GLOBAL.Instance.IdMedico = Convert.ToInt32(ObjListar[0].Comentarios);
                    if (ENTITY_GLOBAL.Instance.IdMedico == 0)
                    {
                        ENTITY_GLOBAL.Instance.IdMedico = null;
                    }

                    ENTITY_GLOBAL.Instance.COD_MEDICO = ENTITY_GLOBAL.Instance.IdMedico;
                    ENTITY_GLOBAL.Instance.MedicoNombre = ObjListar[0].MedicoNombre;
                    ///ADD 09/15
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                    if (ObjListar[0].EstadoEpiAtencion == 2)//EPI EN ATENCIÓN
                    {
                        if (accion != "Continuar")
                        {
                            this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                            this.GetCmp<Button>("VerEpisodio").Disabled = false;
                            this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                            //ADD 09/15      
                            this.GetCmp<Button>("btnNuevaVisita").Disabled = false;
                            this.GetCmp<Button>("btnModifVisita").Disabled = false;
                            this.GetCmp<Button>("btnVerVisita").Disabled = false;
                            this.GetCmp<Button>("btnVisitas").Disabled = false;
                        }
                        else
                        {
                            this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                            this.GetCmp<Button>("VerEpisodio").Disabled = false;
                            this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                        }
                    }
                    else if (ObjListar[0].EstadoEpiAtencion == 3) //EPI ATENDIDO
                    {

                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                        ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                        ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        this.GetCmp<Button>("VerEpisodio").Disabled = false;
                        //ADD 09/15      
                        this.GetCmp<Button>("btnVerVisita").Disabled = false;
                        this.GetCmp<Button>("btnVisitas").Disabled = false;
                    }
                }

                //ADD 2017-07
                /**Verificar si es VALIDA LA MODIFICACIÓN POR PARÁMETRO CONFIGURADO 
                 * EN LA OPCION DEL PROCESO AL QUE CORRESPONDE ESTA ATENCIÓN
                 * SOLO PARA ATENCIONES FIRMADAS/ATENDIDAS
                 */

                if (ObjListar[0].EstadoEpiAtencion == 3) //EPI ATENDIDO
                {
                    if (ObjListar[0].IdEpisodioAtencion == null || ObjListar[0].IdEpisodioAtencion == 0)
                    {
                        this.GetCmp<Button>("NewEpisodio").Disabled = true;
                        this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                        this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                        this.GetCmp<Button>("ContEpisodio").Disabled = true;
                        this.GetCmp<Button>("VerEpisodio").Disabled = true;
                        //ADD 09/15                
                        this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                        this.GetCmp<Button>("btnModifVisita").Disabled = true;
                        this.GetCmp<Button>("btnVerVisita").Disabled = true;
                        this.GetCmp<Button>("btnVisitas").Disabled = true;
                        this.GetCmp<Button>("abrirEpisodio").Disabled = true;
                        if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                        {
                            this.GetCmp<Button>("btnllamadoVisita").Disabled = true;
                        }

                    }
                    else
                    {

                        bool permitirModificarAtencion = false;
                        //Realizamos el mismo LISTADO INICIAL que se hace en la carga del MACROPROCESO
                        //Para verificar el ID DE OPCION
                        List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
                        VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
                        //OBS:ADD de seguridad
                        int ini = 0;
                        if (Session["TIPOATENCION_ACTUAL"] != null)
                        {
                            ini = (int)Session["TIPOATENCION_ACTUAL"];
                        }
                        int fin = 0;
                        obj.AFE = ENTITY_GLOBAL.Instance.Establecimiento;//Para obtener Nombre de Estab. Seleccionado
                        obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
                        obj.ACCION = "LISTARPORID";
                        //El TIPO DE ATENCION en una variable AUXILIAR: ini
                        lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, ini, fin);
                        if (lista.Count > 0)
                        {
                            /**OBS  en el caso hubiera más de un registro, podría ser a causa de diferentes perfiles permitidos.
                                   revisar stored: SP_VW_PERSONAPACIENTE_LISTAR */
                            int idOpcionTemp = Convert.ToInt32(getValorFiltroStr(lista[0].Servicio) != null ? lista[0].Servicio : "0");   //OBS: seguridad   : ID OPCION         
                            String descOpcionTemp = lista[0].Observacion;   //OBS: seguridad     : DESC OPCION

                            //FechaFin AUX para FechaFirma
                            permitirModificarAtencion = esValidoModificarAtencion(idOpcionTemp, ObjListar[0].FechaFin, "DESP_FIRMA");
                            //Hacer uso de la validación
                            if (permitirModificarAtencion)
                            {
                                this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                                this.GetCmp<Button>("btnModifVisita").Disabled = false;

                                return showMensajeNotify("Información Proceso: " + descOpcionTemp, "Todavía es posible editar la Atención.", "WARNING");
                            }
                        }
                    }
                }
                //bloqueo de procediemiento
                if (ObjListar[0].IdOrdenRelacionado != 0)
                {
                    this.GetCmp<Button>("btnModifVisita").Disabled = true;

                }
                //else
                //{
                //    this.GetCmp<Button>("btnModifVisita").Disabled = false;

                //}
                //if (ObjListar[0].IdOrdenRelacionado == 0)
                //{
                //    this.GetCmp<Button>("btnAanularTriaje").Enabled = true;
                //}
                //else
                //{
                //    this.GetCmp<Button>("btnAanularTriaje").Disabled = true;
                //}
            }
            return this.Direct();
        }


        public System.Web.Mvc.ActionResult SelectPersonaEpisodioEventoAuditoria(String selection, string accion)
        {
            Log.Information("BandejaMedicoController - GrillaListadoEvolucionObjetiva - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoEvolucionObjetiva - selection {A}, accion {B}"
                                    , selection, accion);
            if (accion != "Continuar")
            {
                this.GetCmp<Button>("NewEpisodio").Disabled = true;
                this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                this.GetCmp<Button>("ContEpisodio").Disabled = true;
                this.GetCmp<Button>("VerEpisodio").Disabled = true;
                //ADD 09/15                
                this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                this.GetCmp<Button>("btnModifVisita").Disabled = true;
                this.GetCmp<Button>("btnVerVisita").Disabled = true;
                this.GetCmp<Button>("btnVisitas").Disabled = true;
                this.GetCmp<Button>("abrirEpisodio").Disabled = true;
            }
            List<VW_ATENCIONPACIENTE_GENERAL> ObjListar = new List<VW_ATENCIONPACIENTE_GENERAL>();
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_AUDITORIA")
            {
                List<VW_ATENCIONPACIENTE_GENERAL> ListarLocalSess = (List<VW_ATENCIONPACIENTE_GENERAL>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<VW_ATENCIONPACIENTE_GENERAL>));

                foreach (var examenes in ListarLocalSess)
                {
                    SS_HC_EpisodioAtencion epiAtencionObjSave = new SS_HC_EpisodioAtencion();
                    epiAtencionObjSave.IdPaciente = Convert.ToInt32(examenes.IdPaciente);
                    epiAtencionObjSave.IdOrdenAtencion = Convert.ToInt32(examenes.IdOrdenAtencion);
                    epiAtencionObjSave.LineaOrdenAtencion = Convert.ToInt32(examenes.LineaOrdenAtencion);
                    epiAtencionObjSave.UnidadReplicacion = examenes.UnidadReplicacion;
                    epiAtencionObjSave.Accion = "LISTAR";
                    //epiAtencionObjSave.FechaAtencion
                    List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionObjSave, 0, 0);

                    foreach (var epis in listaEpi)
                    {
                        ListarLocalSess[0].IdEpisodioAtencion = epis.IdEpisodioAtencion;
                        ListarLocalSess[0].EpisodioClinico = epis.EpisodioClinico;
                        ListarLocalSess[0].EpisodioAtencion = epis.EpisodioAtencion;
                    }
                }
                ObjListar = ListarLocalSess;
                //cambio 20241023
                //VW_ATENCIONPACIENTE_GENERAL LocalEnty = new VW_ATENCIONPACIENTE_GENERAL();
                //LocalEnty.Accion = "LISTARPAG";
                //LocalEnty.IdPaciente = ListarLocalSess[0].IdPaciente;
                //LocalEnty.CodigoOA = ListarLocalSess[0].CodigoOA;
                //LocalEnty.IdOrdenAtencion = ListarLocalSess[0].IdOrdenAtencion;
                //LocalEnty.LineaOrdenAtencion = ListarLocalSess[0].LineaOrdenAtencion;
                //LocalEnty.NumeroFila = 10;
                //ObjListar = SvcVw_AtencionPaciente.listarVwAtencionPacienteGeneral(LocalEnty, 0, 10);
            }
            else
            {
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
                ObjListar = (List<VW_ATENCIONPACIENTE_GENERAL>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<VW_ATENCIONPACIENTE_GENERAL>));
            }

            //ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
            //List<VW_ATENCIONPACIENTE_GENERAL> ObjListar = (List<VW_ATENCIONPACIENTE_GENERAL>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<VW_ATENCIONPACIENTE_GENERAL>));

            //accion = "Nuevo";
            if (ObjListar.Count > 0)
            {
                if (ObjListar[0].Origen == "Procedimiento2")
                {
                    this.GetCmp<Button>("NewEpisodio").Disabled = true;
                    this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                    this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                    this.GetCmp<Button>("ContEpisodio").Disabled = true;
                    this.GetCmp<Button>("VerEpisodio").Disabled = false;
                    //ADD 09/15                
                    this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                    this.GetCmp<Button>("btnModifVisita").Disabled = true;
                    this.GetCmp<Button>("btnVerVisita").Disabled = true;
                    this.GetCmp<Button>("btnVisitas").Disabled = true;
                    this.GetCmp<Button>("abrirEpisodio").Disabled = true;
                    if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                    {
                        this.GetCmp<Button>("btnllamadoVisita").Disabled = true;
                    }

                }
                else
                {

                    Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = ObjListar[0];
                    ////TIPO DE ATENCION SELECCIONADA
                    if (ObjListar[0].TipoAtencion != null)
                    {
                        Session["TIPOATENCION_ACTUAL"] = Convert.ToInt32(ObjListar[0].TipoAtencion);
                    }
                    if (ObjListar[0].EstadoEpiAtencion == null || ObjListar[0].EstadoEpiAtencion == 0)
                    {
                        if (accion != "Continuar")
                        {
                            this.GetCmp<Button>("NewEpisodio").Disabled = false;
                            this.GetCmp<Button>("ContEpisodio").Disabled = false;
                            //ADD 09/15
                            this.GetCmp<Button>("abrirEpisodio").Disabled = false;
                            if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                            {
                                this.GetCmp<Button>("btnllamadoVisita").Disabled = false;
                            }

                        }
                        ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                        ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                        ENTITY_GLOBAL.Instance.CAMA = ObjListar[0].Cama;
                        ENTITY_GLOBAL.Instance.MedicoNombre = ObjListar[0].MedicoNombre;
                        ///ADD 09/15
                        ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                        ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;
                        ENTITY_GLOBAL.Instance.MODALIDAD_TEMP = ObjListar[0].Modalidad;
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].EpisodioClinico;
                        ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].EpisodioAtencion; /*ObjListar[0].IdEpisodioAtencion;*/
                        // ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].IdEpisodioAtencion; // Modificado --01/06/2017 Motivo: No mostraba data
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = ObjListar[0].EpisodioAtencion;//ADD cambios --/09/2015
                        ENTITY_GLOBAL.Instance.MODALIDAD_TEMP = ObjListar[0].Modalidad;

                        if (ObjListar[0].IdEpisodioAtencion != null)
                        {
                            ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = Convert.ToInt64(ObjListar[0].IdEpisodioAtencion); //ADD ORLANDO 17.05.2017
                            ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = Convert.ToInt64(ObjListar[0].IdEpisodioAtencion); //ADD ORLANDO 17.05.2017
                        }

                        ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                        ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                        ENTITY_GLOBAL.Instance.CAMA = ObjListar[0].Cama;

                        ENTITY_GLOBAL.Instance.IdMedico = Convert.ToInt32(ObjListar[0].Comentarios);
                        ENTITY_GLOBAL.Instance.MedicoNombre = ObjListar[0].MedicoNombre;
                        ///ADD 09/15
                        ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                        ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;

                        ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                        if (ObjListar[0].EstadoEpiAtencion == 2)//EPI EN ATENCIÓN
                        {
                            if (accion != "Continuar")
                            {
                                this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                                this.GetCmp<Button>("VerEpisodio").Disabled = true;//false 01/07/2020
                                this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                                //ADD 09/15      
                                this.GetCmp<Button>("btnNuevaVisita").Disabled = false;
                                this.GetCmp<Button>("btnModifVisita").Disabled = false;
                                this.GetCmp<Button>("btnVerVisita").Disabled = false;
                                this.GetCmp<Button>("btnVisitas").Disabled = false;
                            }
                            else
                            {
                                this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                                this.GetCmp<Button>("VerEpisodio").Disabled = false;
                                this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                            }
                        }
                        else if (ObjListar[0].EstadoEpiAtencion == 3) //EPI ATENDIDO
                        {
                            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                            ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                            ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                            this.GetCmp<Button>("VerEpisodio").Disabled = false;
                            //ADD 09/15      
                            this.GetCmp<Button>("btnVerVisita").Disabled = false;
                            this.GetCmp<Button>("btnVisitas").Disabled = false;
                        }
                    }
                    //ADD 2017-07
                    /**Verificar si es VALIDA LA MODIFICACIÓN POR PARÁMETRO CONFIGURADO 
                     * EN LA OPCION DEL PROCESO AL QUE CORRESPONDE ESTA ATENCIÓN
                     * SOLO PARA ATENCIONES FIRMADAS/ATENDIDAS
                     */

                    if (ObjListar[0].EstadoEpiAtencion == 3) //EPI ATENDIDO
                    {
                        if (ObjListar[0].IdEpisodioAtencion == null || ObjListar[0].IdEpisodioAtencion == 0)
                        {
                            this.GetCmp<Button>("NewEpisodio").Disabled = true;
                            this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                            this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                            this.GetCmp<Button>("ContEpisodio").Disabled = true;
                            this.GetCmp<Button>("VerEpisodio").Disabled = true;
                            //ADD 09/15                
                            this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                            this.GetCmp<Button>("btnModifVisita").Disabled = true;
                            this.GetCmp<Button>("btnVerVisita").Disabled = true;
                            this.GetCmp<Button>("btnVisitas").Disabled = true;
                            this.GetCmp<Button>("abrirEpisodio").Disabled = true;
                            if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                            {
                                this.GetCmp<Button>("btnllamadoVisita").Disabled = true;
                            }

                        }
                        else
                        {
                            bool permitirModificarAtencion = false;
                            //Realizamos el mismo LISTADO INICIAL que se hace en la carga del MACROPROCESO
                            //Para verificar el ID DE OPCION
                            List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
                            VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
                            //OBS:ADD de seguridad
                            int ini = 0;
                            if (Session["TIPOATENCION_ACTUAL"] != null)
                            {
                                ini = (int)Session["TIPOATENCION_ACTUAL"];
                            }
                            int fin = 0;
                            obj.AFE = ENTITY_GLOBAL.Instance.Establecimiento;//Para obtener Nombre de Estab. Seleccionado
                            obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
                            obj.ACCION = "LISTARPORID";
                            //El TIPO DE ATENCION en una variable AUXILIAR: ini
                            lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, ini, fin);
                            if (lista.Count > 0)
                            {
                                /**OBS  en el caso hubiera más de un registro, podría ser a causa de diferentes perfiles permitidos.
                                       revisar stored: SP_VW_PERSONAPACIENTE_LISTAR */
                                int idOpcionTemp = Convert.ToInt32(getValorFiltroStr(lista[0].Servicio) != null ? lista[0].Servicio : "0");   //OBS: seguridad   : ID OPCION         
                                String descOpcionTemp = lista[0].Observacion;   //OBS: seguridad     : DESC OPCION

                                //FechaFin AUX para FechaFirma
                                permitirModificarAtencion = esValidoModificarAtencion(idOpcionTemp, ObjListar[0].FechaFin, "DESP_FIRMA");
                            }
                        }
                    }
                }
            }
            return this.Direct();
        }

        public bool esValidoModificarAtencion(int idOpcionTemp, Nullable<DateTime> fechaRegistro, string indica)
        {
            Log.Information("BandejaMedicoController - esValidoModificarAtencion - Entrar");
            Log.Debug("BandejaMedicoController - esValidoModificarAtencion - fechaRegistro {A}, indica {B}", fechaRegistro, indica);
            bool permitirModificarAtencion = (indica == "DESP_FIRMA" ? false : true);
            if (fechaRegistro != null)
            //if (true) //EPI ATENDIDO
            {
                if (indica == "DESP_FIRMA")
                {
                    //logica para cuando la ATENCION ha sido FIRMADA o ATENDIDA (estado = 3)
                    int horasDia = 24;
                    List<SG_Opcion> serviceResuls = new List<SG_Opcion>();
                    SG_Opcion filtroOpcion = new SG_Opcion();
                    filtroOpcion.IdOpcion = idOpcionTemp;
                    filtroOpcion.Accion = "LISTARPORID";
                    serviceResuls = SvcSG_Opcion.listarSG_Opcion(filtroOpcion, 0, 0);
                    if (serviceResuls.Count > 0)
                    {
                        Nullable<decimal> cantidadHorasPermitidas = serviceResuls[0].ValorNumerico;
                        if (cantidadHorasPermitidas.HasValue)
                        {
                            //**NOTA COMODIN: se puede setear el valor con un NUMERO NEGATIVO para EVITAR el uso del PARAMETRO
                            if (cantidadHorasPermitidas.Value > 0)
                            {
                                Nullable<DateTime> fechaInicio = fechaRegistro;
                                DateTime fechaFinal = DateTime.Now;
                                if (fechaInicio.HasValue)
                                {
                                    bool esMismoDia = false;
                                    //primero obtener la DIFERENCIA EN HORAS DE LAS FECHAS
                                    double horasTranscurridasTotal = 0;
                                    double horasDiferencia = (fechaFinal - fechaInicio.Value).TotalHours;
                                    //double horasDiferencia = 0;//horas se contaran en partes
                                    double horasTranscurridasDiaInicio = 0;
                                    double horasTranscurridasDiaFinal = 0;

                                    if ((fechaFinal - fechaInicio.Value).TotalHours < 24 && fechaFinal.Day == fechaInicio.Value.Day)
                                    {
                                        esMismoDia = true;
                                    }

                                    /**Calcular las Horas transcurridas, VARIA si la fecha inicio es la misma de la fecha fin*/
                                    if (esMismoDia)
                                    {
                                        //Diferencia de horas si el día o es DOMINGO O SABADO
                                        if (fechaFinal.DayOfWeek != DayOfWeek.Saturday
                                        && fechaFinal.DayOfWeek != DayOfWeek.Sunday)
                                        {
                                            horasTranscurridasTotal = (fechaFinal - fechaInicio.Value).TotalHours;
                                        }
                                    }
                                    else
                                    {
                                        //Horas transcurridas en los dias inicio y fin
                                        horasTranscurridasDiaInicio = 24 - fechaInicio.Value.Hour;
                                        horasTranscurridasDiaFinal = 0 + fechaFinal.Hour;
                                        //LUEGO OBTENER Cuantas fechas del RANGO seran SABADO O DOMINGO
                                        IEnumerable<DateTime> finDe = getFechasRango(fechaInicio.Value, fechaFinal, false, false)
                                            .Where(d => d.DayOfWeek == DayOfWeek.Saturday || d.DayOfWeek == DayOfWeek.Sunday);
                                        int cantidadDiasFinde = finDe.Count();
                                        if (cantidadDiasFinde > 0)
                                        {
                                            //CALCULAR DIFERENCIA , DESCONTANDO las horas de los FINDE
                                            horasDiferencia = horasDiferencia - (horasDia * cantidadDiasFinde);
                                        }
                                        //CLCULAR DIFERENCIA, DESCONTAR AHORA los mismos dias: inicio y fin
                                        horasDiferencia = horasDiferencia - (horasTranscurridasDiaInicio + horasTranscurridasDiaFinal);
                                        //verificar que los DIAS de inicio y FIN no sean SABADOS o DOMINGOS
                                        if (fechaInicio.Value.DayOfWeek == DayOfWeek.Saturday || fechaInicio.Value.DayOfWeek == DayOfWeek.Sunday)
                                        {
                                            horasTranscurridasDiaInicio = 0;
                                        }
                                        if (fechaFinal.DayOfWeek == DayOfWeek.Saturday || fechaFinal.DayOfWeek == DayOfWeek.Sunday)
                                        {
                                            horasTranscurridasDiaFinal = 0;
                                        }
                                        //Calcular Horas transcurridas.
                                        horasTranscurridasTotal =
                                            horasTranscurridasDiaInicio + horasDiferencia + horasTranscurridasDiaFinal;
                                    }

                                    //Validar Solo si el numero de HORAS TRANSCURRIDAS, supera la CANT. de HORAS en el PARAMETRO por OPCION
                                    //Es decir miestras las horas transcurridas sean menor que la del parametro, se podra modficar
                                    if (horasTranscurridasTotal <= Convert.ToInt32(cantidadHorasPermitidas.Value))
                                    {
                                        //permitirModificarAtencion = false;
                                        permitirModificarAtencion = true;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    //....
                }
            }

            return permitirModificarAtencion;
        }

        public Boolean actualizarEstadoEpiAtencion(SS_HC_EpisodioAtencion episodioActual, int estado)
        {
            Log.Information("BandejaMedicoController - actualizarEstadoEpiAtencion - Entrar");
            Log.Debug("BandejaMedicoController - actualizarEstadoEpiAtencion - episodioActual {A}, estado {B}", episodioActual, estado);
            episodioActual.Estado = estado;
            episodioActual.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            episodioActual.Accion = "UPDATE";
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA") { episodioActual.TipoAtencion = 2; }
            long result = SvcEpisodioAtencion.setMantenimiento(episodioActual);
            return result > 0;
        }
        /**Evento  guarda el objeto de Episodio Atención Seleccionado para uso auxiliar (Visitas, Grupo de Aten. de Tcnólog...) */

        /*****************************************************************************/


        public System.Web.Mvc.ActionResult SelectPersonaMedicamentoEpisodioEvento(String selection, string accion)
        {
            Log.Information("BandejaMedicoController - SelectPersonaMedicamentoEpisodioEvento - Entrar");
            Log.Debug("BandejaMedicoController - SelectPersonaMedicamentoEpisodioEvento - selection {A}, accion {B}", selection, accion);
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

                ENTITY_GLOBAL.Instance.CAMA = ObjListar[0].Cama;
                ENTITY_GLOBAL.Instance.MedicoNombre = ObjListar[0].Medico;
                if (ObjListar[0].Secuencia > 0)
                {
                    ENTITY_GLOBAL.Instance.IDSOLICITUDMED = ObjListar[0].Secuencia;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    ENTITY_GLOBAL.Instance.GuiaPedido = ObjListar[0].UsuarioAuditoria;
                }
                else
                {
                    ENTITY_GLOBAL.Instance.IDSOLICITUDMED = 0;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                    ENTITY_GLOBAL.Instance.GuiaPedido = "";
                }
                ENTITY_GLOBAL.Instance.UnidadReplicacion = ObjListar[0].UnidadReplicacion.Trim();//Jordan Mateo --07/02/2019
                ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].EpisodioClinico;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].IdEpisodioAtencion;
                ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdVia;
                ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].IdUnidadMedida;
                ENTITY_GLOBAL.Instance.NombreCompletoPaciente = ObjListar[0].NombreCompleto;//ADD cambios --/09/2015
                ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                ///ADD 09/15
                ENTITY_GLOBAL.Instance.FechaReceta = ObjListar[0].Celular;
                if (ObjListar[0].Estado == 3)
                {
                    this.GetCmp<Button>("GenerarPed").Disabled = true;
                    // this.GetCmp<Button>("btnDevolucion").Disabled = false;
                }
                else
                {
                    // this.GetCmp<Button>("btnDevolucion").Disabled = true;
                    this.GetCmp<Button>("GenerarPed").Disabled = false;
                }
                if (ObjListar[0].Estado > 1)
                {
                    this.GetCmp<Button>("VerPed").Disabled = false;
                }
                else
                {
                    this.GetCmp<Button>("VerPed").Disabled = true;
                }
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
            }
            return this.Direct();
        }

        /**********************************************************************************************/


        public System.Web.Mvc.ActionResult SelectPersonaEpisodioEventoNotif(String tipo, string tipo2, string tipo3, string tipo4, string accion)
        {
            Log.Information("BandejaMedicoController - SelectPersonaEpisodioEventoNotif - Entrar");
            Log.Debug("BandejaMedicoController - SelectPersonaEpisodioEventoNotif - tipo {A}, tipo2 {B}, tipo3 {C}, tipo4 {D} ,accion {E}"
                                    , tipo, tipo2, tipo3, tipo4, accion);
            if (accion != "Continuar")
            {
                this.GetCmp<Button>("ModiEpisodio").Disabled = true;
            }

            var Listar = new List<SS_HC_EpisodioAtencion>();

            SS_HC_EpisodioAtencion objFiltro = new SS_HC_EpisodioAtencion();
            objFiltro.Accion = "LISTARPORID";
            objFiltro.UnidadReplicacion = Convert.ToString(getValorFiltroStr(tipo));
            objFiltro.IdEpisodioAtencion = Convert.ToInt32(getValorFiltroInt(tipo2));
            objFiltro.IdPaciente = Convert.ToInt32(getValorFiltroInt(tipo3));
            objFiltro.EpisodioClinico = Convert.ToInt32(getValorFiltroInt(tipo4));
            Listar = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(objFiltro, 0, 0);
            var ObjseleccionActual = new VW_ATENCIONPACIENTE_GENERAL();
            if (Listar.Count > 0)
            {
                ENTITY_GLOBAL.Instance.PacienteID = Listar[0].IdPaciente;
                ObjseleccionActual.UnidadReplicacion = Listar[0].UnidadReplicacion;
                ObjseleccionActual.IdEpisodioAtencion = Listar[0].IdEpisodioAtencion;
                ObjseleccionActual.IdPaciente = Listar[0].IdPaciente;
                ObjseleccionActual.EpisodioClinico = Listar[0].EpisodioClinico;
                ObjseleccionActual.IdUnidadServicio = Listar[0].IdUnidadServicio;
                ObjseleccionActual.TipoAtencion = Listar[0].TipoAtencion;
                ObjseleccionActual.CodigoOA = Listar[0].CodigoOA;
                ObjseleccionActual.TipoAtencion = Listar[0].TipoAtencion;
                ObjseleccionActual.UnidadReplicacion = Listar[0].UnidadReplicacion;
                ObjseleccionActual.UnidadReplicacionEC = Listar[0].UnidadReplicacionEC;
                ObjseleccionActual.TipoOrdenAtencion = Listar[0].TipoOrdenAtencion;
                ObjseleccionActual.EpisodioAtencion = Listar[0].EpisodioAtencion;
                ObjseleccionActual.LineaOrdenAtencion = Convert.ToInt32(Listar[0].LineaOrdenAtencion);
                ObjseleccionActual.IdOrdenAtencion = Convert.ToInt32(Listar[0].IdOrdenAtencion);
                ObjseleccionActual.FechaRegistro = Listar[0].FechaRegistro;
                ObjseleccionActual.FechaAtencion = Listar[0].FechaAtencion;
                ObjseleccionActual.IdUnidadServicio = Listar[0].IdUnidadServicio;
                ObjseleccionActual.IdEstablecimientoSalud = Listar[0].IdEstablecimientoSalud;
                ObjseleccionActual.EstadoEpiAtencion = Listar[0].Estado;
                ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(Listar[0].IdPersonalSalud);
                ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(Listar[0].FechaFirma);

                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = ObjseleccionActual;

                ENTITY_GLOBAL.Instance.EpisodioClinico = Listar[0].EpisodioClinico;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = Listar[0].IdEpisodioAtencion;
                ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = Listar[0].EpisodioAtencion;//ADD cambios --/09/2015
                ENTITY_GLOBAL.Instance.PacienteID = Listar[0].IdPaciente;
                ENTITY_GLOBAL.Instance.CodigoOA = Listar[0].CodigoOA;
                ///ADD 09/15
                ENTITY_GLOBAL.Instance.IdOrdenAtencion = Listar[0].IdOrdenAtencion;
                ENTITY_GLOBAL.Instance.LineaOrdenAtencion = Listar[0].LineaOrdenAtencion;
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
            }

            ////TIPO DE ATENCION SELECCIONADA
            if (ObjseleccionActual.TipoAtencion != null)
            {
                Session["TIPOATENCION_ACTUAL"] = Convert.ToInt32(ObjseleccionActual.TipoAtencion);
            }
            if (ObjseleccionActual.EstadoEpiAtencion == 2)//EPI EN ATENCIÓN
            {
                if (accion != "Continuar")
                {
                    this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                    //this.GetCmp<Button>("abrirEpisodio").Disabled = false;
                }
                else
                {
                    this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                }
            }
            return this.Direct();
        }

        /******************************************************************************/
        public System.Web.Mvc.ActionResult SelectPersonaEpisodioAuxiliar(String selection, string accion)
        {
            Log.Information("BandejaMedicoController - SelectPersonaEpisodioAuxiliar - Entrar");
            Log.Debug("BandejaMedicoController - SelectPersonaEpisodioAuxiliar - selection {A}, accion {B}", selection, accion);
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
            List<SS_HC_EpisodioAtencion> ObjListar = (List<SS_HC_EpisodioAtencion>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<SS_HC_EpisodioAtencion>));
            if (ObjListar.Count > 0)
            {
                ////TIPO DE ATENCION SELECCIONADA
                if (ObjListar[0].TipoAtencion != null)
                {
                    Session["TIPOATENCION_ACTUAL"] = Convert.ToInt32(ObjListar[0].TipoAtencion);
                }
                if (ObjListar[0].Estado == null || ObjListar[0].Estado == 0)
                {
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ///ADD 09/15
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;
                }
                else
                {
                    //ENTITY_GLOBAL.Instance.UnidadReplicacion = ObjListar[0].UnidadReplicacion;
                    ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].EpisodioClinico;
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].IdEpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = ObjListar[0].EpisodioAtencion;//ADD cambios --/09/2015
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ///ADD 09/15
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;

                    ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                    if (ObjListar[0].Estado == 2)//EPI EN ATENCIÓN
                    {
                    }
                    else if (ObjListar[0].Estado == 3) //EPI ATENDIDO
                    {
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                        ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                        ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    }
                    if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                    {
                        VW_ATENCIONPACIENTE_GENERAL ObjseleccionActual = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                        ////////////////////     
                        ObjseleccionActual.IdEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        ObjseleccionActual.EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                        ObjseleccionActual.IdPaciente = ENTITY_GLOBAL.Instance.PacienteID;
                        ObjseleccionActual.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                        ObjseleccionActual.IdOrdenAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.IdOrdenAtencion);
                        Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = ObjseleccionActual;

                    }

                }
            }
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult SelectPersonaEpisodio(String selection, string accion)
        {
            Log.Information("BandejaMedicoController - SelectPersonaEpisodio - Entrar");
            Log.Debug("BandejaMedicoController - SelectPersonaEpisodio - selection {A}, accion {B}", selection, accion);
            if (accion != "Continuar")
            {

                this.GetCmp<Button>("NewEpisodio").Disabled = true;
                this.GetCmp<Button>("ModiEpisodio").Disabled = true;
                this.GetCmp<Button>("FinalEpisodio").Disabled = true;
                this.GetCmp<Button>("ContEpisodio").Disabled = true;
                this.GetCmp<Button>("VerEpisodio").Disabled = true;
                //ADD 09/15                
                this.GetCmp<Button>("btnNuevaVisita").Disabled = true;
                this.GetCmp<Button>("btnModifVisita").Disabled = true;
                this.GetCmp<Button>("btnVerVisita").Disabled = true;
                this.GetCmp<Button>("btnVisitas").Disabled = true;

                this.GetCmp<Button>("abrirEpisodio").Disabled = true;
                //if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                //{
                //    this.GetCmp<Button>("btnllamadoVisita").Disabled = true;
                //}

            }

            //ENTITY_GLOBAL.Instance.NIVEL = 1;
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 0;
            List<SS_HC_EpisodioAtencion> ObjListar = (List<SS_HC_EpisodioAtencion>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<SS_HC_EpisodioAtencion>));
            //accion = "Nuevo";
            if (ObjListar.Count > 0)
            {
                if (ObjListar[0].TipoAtencion != null)
                {
                    Session["TIPOATENCION_ACTUAL"] = Convert.ToInt32(ObjListar[0].TipoAtencion);
                }
                if (ObjListar[0].Estado == null || ObjListar[0].Estado == 0)
                {
                    if (accion != "Continuar")
                    {
                        this.GetCmp<Button>("NewEpisodio").Disabled = false;
                        this.GetCmp<Button>("ContEpisodio").Disabled = false;
                        //ADD 09/15
                        this.GetCmp<Button>("abrirEpisodio").Disabled = false;
                        //if (ObjListar[0].tipoListado == "MED_AMBULATORIO")
                        //{
                        //    this.GetCmp<Button>("btnllamadoVisita").Disabled = false;
                        //}               
                    }
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ///ADD 09/15
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;
                }
                else
                {
                    //ENTITY_GLOBAL.Instance.UnidadReplicacion = ObjListar[0].UnidadReplicacion;
                    ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].EpisodioClinico;
                    ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].IdEpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = ObjListar[0].EpisodioAtencion;//ADD cambios --/09/2015
                    ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].IdPaciente;
                    ENTITY_GLOBAL.Instance.CodigoOA = ObjListar[0].CodigoOA;
                    ///ADD 09/15
                    ENTITY_GLOBAL.Instance.IdOrdenAtencion = ObjListar[0].IdOrdenAtencion;
                    ENTITY_GLOBAL.Instance.LineaOrdenAtencion = ObjListar[0].LineaOrdenAtencion;

                    ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                    if (ObjListar[0].Estado == 2)//EPI EN ATENCIÓN
                    {
                        if (accion != "Continuar")
                        {
                            this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                            this.GetCmp<Button>("VerEpisodio").Disabled = false;
                            this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                            //ADD 09/15      
                            this.GetCmp<Button>("btnNuevaVisita").Disabled = false;
                            this.GetCmp<Button>("btnModifVisita").Disabled = false;
                            this.GetCmp<Button>("btnVerVisita").Disabled = false;
                            this.GetCmp<Button>("btnVisitas").Disabled = false;
                        }
                        else
                        {
                            this.GetCmp<Button>("ModiEpisodio").Disabled = false;
                            this.GetCmp<Button>("VerEpisodio").Disabled = false;
                            this.GetCmp<Button>("FinalEpisodio").Disabled = false;
                        }
                    }
                    else if (ObjListar[0].Estado == 3) //EPI ATENDIDO
                    {
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                        ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                        ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        this.GetCmp<Button>("VerEpisodio").Disabled = false;
                        //ADD 09/15      
                        this.GetCmp<Button>("btnVerVisita").Disabled = false;
                        this.GetCmp<Button>("btnVisitas").Disabled = false;
                    }
                }
            }
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult ListadoAtenciones(String MODO, int paciente, string nombre, string codigooa)
        {
            Log.Information("BandejaMedicoController - ListadoAtenciones - Entrar");
            Log.Debug("BandejaMedicoController - ListadoAtenciones - MODO {A}, paciente {B}, nombre {C}, codigooa {D}", MODO, paciente, nombre, codigooa);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.Accion = "Continuar";
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            return crearWindowRegistro("Procesos/ContinuarEpisodio", objModel, "");
        }


        public System.Web.Mvc.ActionResult ListadoAtencionesVisita(String MODO, int paciente, string nombre,
            string codigooa, int idoa, int episodioatencion, int episodioclinico,
            long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, Nullable<int> tipointerconsulta, string tipotrabrequerido,
            string tipoListado)
        {
            Log.Information("BandejaMedicoController - ListadoAtencionesVisita - Entrar");
            Log.Debug("BandejaMedicoController - ListadoAtencionesVisita - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipointerconsulta {K}, tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion, tipointerconsulta,
                                    tipotrabrequerido, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;

            objModel.LineaOrdenAtencion = lineaoa;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;


            if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
            }
            ///////////

            objModel.Accion = "LISTARVISITA";
            List<VW_ATENCIONPACIENTE> Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(objModel, 0, 0);


            if (Listar.Count > 0)
            {
                Session["DATA_VISITAS"] = Listar;
                List<VW_ATENCIONPACIENTE> Listar1 = new List<VW_ATENCIONPACIENTE>();
                Listar1 = Listar.Where(x => x.IdTipoInterConsulta == 1 && x.IdOrdenAtencion == objModel.IdOrdenAtencion && x.LineaOrdenAtencion == objModel.LineaOrdenAtencion).ToList();
                if (Listar1.Count > 0)
                {
                    if (Listar1[0].IdTipoInterConsulta == 1)
                        ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;
                }
                else if (Listar.Count > 0 && tipointerconsulta == 1)
                {
                    List<VW_ATENCIONPACIENTE> Listar2 = new List<VW_ATENCIONPACIENTE>();
                    Listar2 = Listar.Where(x => x.IdTipoInterConsulta == 2 && x.IdOrdenAtencion == objModel.IdOrdenAtencion && x.LineaOrdenAtencion == objModel.LineaOrdenAtencion).ToList();
                    if (Listar2.Count > 0)
                    {
                        ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 2;
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 0;
                    }
                }
                else if (tipointerconsulta == 0)
                {
                    ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;
                }
                else
                {
                    ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;

                }
            }
            else
            {
                ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;

            }
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;

            objModel.IdEpisodioAtencion = idepisodioatencion;

            objModel.Accion = MODO;

            //INTER
            List<VW_ATENCIONPACIENTE> ListarTipo = new List<VW_ATENCIONPACIENTE>();
            ListarTipo = Listar.Where(x => x.LineaOrdenAtencion == objModel.LineaOrdenAtencion).ToList();
            if (ListarTipo.Count > 0)
            {
                int tipo = 0;
                tipo = (int)ListarTipo[0].TipoOrdenAtencion;
                if (tipo == 1 || tipo == 11)
                {
                    int response = 0;
                    var objGenral2 = new SS_HCE_ConsultaExterna();
                    objGenral2.IdOrdenAtencion = idoa;
                    objGenral2.Linea = lineaoa;
                    objGenral2.Accion = "RELEVOPRINCIPAL";

                    response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);
                    ENTITY_GLOBAL.Instance.FLAG_ANULAME = response == 0 || ENTITY_GLOBAL.Instance.FLAG_ANULAME == "ALTA" ? "NOPRINCIPAL" : "PRINCIPAL";
                }
            }
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            return crearWindowRegistro("Procesos/VisitaEpisodio", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult ListadoAtencionesVisitaE(String MODO, int paciente, string nombre,
           string codigooa, int idoa, int episodioatencion, int episodioclinico,
           long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, Nullable<int> tipointerconsulta, string tipotrabrequerido,
           string tipoListado)
        {
            Log.Information("BandejaMedicoController - ListadoAtencionesVisita - Entrar");
            Log.Debug("BandejaMedicoController - ListadoAtencionesVisita - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipointerconsulta {K}, tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion, tipointerconsulta,
                                    tipotrabrequerido, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;

            objModel.LineaOrdenAtencion = lineaoa;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;


            if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
            }
            ///////////

            objModel.Accion = "LISTARVISITA";
            List<VW_ATENCIONPACIENTE> Listar = SvcVw_AtencionPaciente.listarVwAtencionPaciente(objModel, 0, 0);


            if (Listar.Count > 0)
            {
                Session["DATA_VISITAS"] = Listar;
                List<VW_ATENCIONPACIENTE> Listar1 = new List<VW_ATENCIONPACIENTE>();
                Listar1 = Listar.Where(x => x.IdTipoInterConsulta == 1 && x.IdOrdenAtencion == objModel.IdOrdenAtencion && x.LineaOrdenAtencion == objModel.LineaOrdenAtencion).ToList();
                if (Listar1.Count > 0)
                {
                    if (Listar1[0].IdTipoInterConsulta == 1)
                        ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;
                }
                else if (Listar.Count > 0 && tipointerconsulta == 1)
                {
                    List<VW_ATENCIONPACIENTE> Listar2 = new List<VW_ATENCIONPACIENTE>();
                    Listar2 = Listar.Where(x => x.IdTipoInterConsulta == 2 && x.IdOrdenAtencion == objModel.IdOrdenAtencion && x.LineaOrdenAtencion == objModel.LineaOrdenAtencion).ToList();
                    if (Listar2.Count > 0)
                    {
                        ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 2;
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 0;
                    }
                }
                else if (tipointerconsulta == 0)
                {
                    ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;
                }
                else
                {
                    ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;

                }
            }
            else
            {
                ENTITY_GLOBAL.Instance.FLAT_INTERCONSULTA = 1;

            }
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;

            objModel.IdEpisodioAtencion = idepisodioatencion;

            objModel.Accion = MODO;

            //INTER
            List<VW_ATENCIONPACIENTE> ListarTipo = new List<VW_ATENCIONPACIENTE>();
            ListarTipo = Listar.Where(x => x.LineaOrdenAtencion == objModel.LineaOrdenAtencion).ToList();
            if (ListarTipo.Count > 0)
            {
                int tipo = 0;
                tipo = (int)ListarTipo[0].TipoOrdenAtencion;
                if (tipo == 1 || tipo == 11)
                {
                    int response = 0;
                    var objGenral2 = new SS_HCE_ConsultaExterna();
                    objGenral2.IdOrdenAtencion = idoa;
                    objGenral2.Linea = lineaoa;

                    //objGenral2.Accion = "RELEVOPRINCIPAL";
                    objGenral2.Accion = "RELEVOPRINCIPALENF";
                    response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);
                    ENTITY_GLOBAL.Instance.FLAG_ANULAME = response == 0 || ENTITY_GLOBAL.Instance.FLAG_ANULAME == "ALTA" ? "NOPRINCIPAL" : "PRINCIPAL";
                }
            }
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            return crearWindowRegistro("Procesos/VisitaEpisodioEnfermeria", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult ListadoAtencionesFarmaco(String MODO, int paciente, string nombre,
            string codigooa, int idoa, int episodioatencion, int episodioclinico,
            long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, string tipotrabrequerido,
            string tipoListado)
        {
            Log.Information("BandejaMedicoController - ListadoAtencionesFarmaco - Entrar");
            Log.Debug("BandejaMedicoController - ListadoAtencionesFarmaco - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion,
                                    tipotrabrequerido, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;

            objModel.IdEpisodioAtencion = idepisodioatencion;
            objModel.LineaOrdenAtencion = lineaoa;
            objModel.Accion = MODO;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            return crearWindowRegistro("Procesos/VisitaFarmaco", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult ListarDispensacion(String MODO, int paciente, string nombre,
            string codigooa, int idoa, int episodioatencion, int episodioclinico,
            long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, string tipotrabrequerido,
            string tipoListado)
        {
            Log.Information("BandejaMedicoController - ListarDispensacion - Entrar");
            Log.Debug("BandejaMedicoController - ListarDispensacion - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion,
                                    tipotrabrequerido, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            //objModel.IdOrdenAtencion = idoa;
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;
            ENTITY_GLOBAL.Instance.OPCION_STOCK_DEF = 1;
            objModel.IdEpisodioAtencion = idepisodioatencion;
            //objModel.LineaOrdenAtencion = lineaoa;
            objModel.Accion = MODO;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            return crearWindowRegistro("Procesos/NuevaDispensacion", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }


        public System.Web.Mvc.ActionResult ListadoEvolucionMedica(String MODO, int paciente, string nombre,
           string codigooa, int idoa, int episodioatencion, int episodioclinico,
           long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, string tipotrabrequerido,
           string tipoListado)
        {
            Log.Information("BandejaMedicoController - ListadoEvolucionMedica - Entrar");
            Log.Debug("BandejaMedicoController - ListadoEvolucionMedica - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion,
                                    tipotrabrequerido, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;

            objModel.IdEpisodioAtencion = idepisodioatencion;
            objModel.LineaOrdenAtencion = lineaoa;
            objModel.Accion = MODO;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            return crearWindowRegistro("Procesos/VisitaEvolucionMedica", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }
        public System.Web.Mvc.ActionResult AnularAtenciones(String MODO, int paciente, string nombre,
           string codigooa, int idoa, int episodioatencion, int episodioclinico,
           long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, Nullable<int> tipointerconsulta, string tipotrabrequerido,
           string tipoListado)
        {
            Log.Information("BandejaMedicoController - AnularAtenciones - Entrar");
            Log.Debug("BandejaMedicoController - AnularAtenciones - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion,
                                    tipotrabrequerido, tipoListado);
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();



            LocalEnty.ACCION = "EXAMENESLIST";
            LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
            LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioClinico.ToString().Trim();
            LocalEnty.ValorCodigo3 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
            LocalEnty.ValorCodigo4 = ENTITY_GLOBAL.Instance.UnidadReplicacion.ToString().Trim();
            LocalEnty.ValorCodigo5 = "SOA";

            Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();

            HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
            string JSONstring = string.Empty;
            DataTable dtValida = new DataTable();
            HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
            WsEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            WsEpisodio.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            WsEpisodio.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            WsEpisodio.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            WsEpisodio.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
            WsEpisodio.Linea = (int)ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
            WsEpisodio.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
            WsEpisodio.FechaCreacion = DateTime.Now;
            WsEpisodio.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
            if (tipoListado == "MED_EMERGENCIA2")
            {
                foreach (DataRow dr in dtValida.AsEnumerable())
                {
                    if (dr["IndicadorAltaMedica"].ToString() == "2")
                    {
                        return showMensajeNotify("No se puede anular OA", "Debe anular el Alta de la atención", "ERROR");
                    }
                }
            }
            JSONstring = JsonConvert.SerializeObject(dtValida);
            List<EpisodioAtencion> result = (List<EpisodioAtencion>)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONstring, typeof(List<EpisodioAtencion>));
            if (result.Count > 0)
            {
                foreach (var examenes in Listar)
                {
                    foreach (EpisodioAtencion lista in result)
                    {
                        if (lista.SecuenciaHCE == examenes.ValorCodigo1)
                        {
                            if (lista.IndicadorCobrado == 2)
                            {
                                return showMensajeNotify("Error al anular OA", "La atención tiene componente(s) con cobro relacionado", "ERROR");

                            }
                        }

                    }
                }
            }

            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;

            objModel.IdEpisodioAtencion = idepisodioatencion;
            objModel.LineaOrdenAtencion = lineaoa;
            objModel.Accion = MODO;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                ENTITY_GLOBAL.Instance.indicadorUsuario = false;
                List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
                VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
                // ANTES IDPERSONALSALUD_EMERG
                obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDPERSONALSALUD_EMERG);
                obj.ACCION = "LISTARPORID";
                lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, 0, 0);
                ENTITY_GLOBAL.Instance.USUARIO_EMERG = lista[0].USUARIO;
            }
            else
            {
                ENTITY_GLOBAL.Instance.indicadorUsuario = true;
            }

            return crearWindowRegistro("Procesos/AnularEpisodio", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }


        public System.Web.Mvc.ActionResult ControllerllamadoVisita(String selection, string accion)
        {
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                VW_ATENCIONPACIENTE_GENERAL objAtencionPacSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                SP_SS_GenerarLlamado_Result EntyMIrth = new SP_SS_GenerarLlamado_Result();
                EntyMIrth.IdCita = objAtencionPacSelecc.IdCita;
                EntyMIrth.Secuencia = objAtencionPacSelecc.IdOrdenAtencion;
                EntyMIrth.Observacion = objAtencionPacSelecc.Nombres;
                EntyMIrth.Usuario = ENTITY_GLOBAL.Instance.USUARIO;

                ViewResponse LocalEnty = new ViewResponse();
                LocalEnty.valor = 1;
                LocalEnty.msg = Newtonsoft.Json.JsonConvert.SerializeObject(EntyMIrth);
                ActionSALUD_GenerarLlamado(LocalEnty, 1);
                //X.Msg.Show(new MessageBoxConfig
                //{
                //    Title = "Se esta llamando al Paciente",
                //    Message = string.Format("Cita - {0}", objAtencionPacSelecc.IdCita.ToString()),
                //    Buttons = MessageBox.Button.OK,
                //    Icon = MessageBox.Icon.QUESTION,
                //    Closable = false,
                //    Fn = new JFunction { Fn = "showResult" },
                //    AnimEl = objAtencionPacSelecc.IdCita.ToString()
                //});
                X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Espere Por Favor",
                    Message = "Se esta llamando al Paciente :: " + objAtencionPacSelecc.PacienteNombre,
                    Buttons = MessageBox.Button.OK,
                    Fn = new JFunction { Fn = "showResult" },
                    ProgressText = "Inicializando...",
                    Width = 300,
                    Progress = true,
                    Closable = false,
                    AnimEl = objAtencionPacSelecc.IdCita.ToString()
                });
                StartLongAction();
            }
            else
            {
                X.Msg.Alert("DirectEvent", string.Format("Error :: No ha seleccionado un registro - {0}", accion)).Show();
            }
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult RefreshProgressllamado()
        {
            Log.Information("HClinicaControllerSup - RefreshProgress - Entrar");
            object progress = HttpContext.Cache["Task1"];
            if (progress != null)
            {
                X.Msg.UpdateProgress(((int)progress) / 20f, string.Format("contando {0} hasta {1}...", progress, 20));
            }
            else
            {
                this.GetCmp<TaskManager>("TaskManager1").StopTask("Task1");
                X.MessageBox.Hide();
                if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                {
                    VW_ATENCIONPACIENTE_GENERAL objAtencionPacSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                    SP_SS_GenerarLlamado_Result EntyMIrth = new SP_SS_GenerarLlamado_Result();
                    EntyMIrth.IdCita = objAtencionPacSelecc.IdCita;
                    EntyMIrth.Secuencia = objAtencionPacSelecc.IdOrdenAtencion;
                    EntyMIrth.Observacion = objAtencionPacSelecc.Nombres;
                    EntyMIrth.Usuario = ENTITY_GLOBAL.Instance.USUARIO;

                    ViewResponse LocalEnty = new ViewResponse();
                    LocalEnty.valor = 3; //elimina sin log
                    LocalEnty.msg = Newtonsoft.Json.JsonConvert.SerializeObject(EntyMIrth);
                    ActionSALUD_GenerarLlamado(LocalEnty, 3);
                }
            }
            return this.Direct();
        }

        private void StartLongAction()
        {
            Log.Information("BandejaMedicoController - StartLongAction - Entrar");
            HttpContext.Cache["Task1"] = 0;
            ThreadPool.QueueUserWorkItem(LongAction);
            this.GetCmp<TaskManager>("TaskManager1").StartTask("Task1");
        }

        private void LongAction(object state)
        {
            Log.Information("BandejaMedicoController - LongAction - Entrar");
            for (int i = 0; i < 20; i++)
            {
                Thread.Sleep(1000);
                HttpContext.Cache["Task1"] = i + 1;
            }
            HttpContext.Cache.Remove("Task1");
        }

        private void ActionSALUD_GenerarLlamado(ViewResponse LocalEnty, int indicador)
        {
            var URL_SERVER = ConfigurationManager.AppSettings.Get("ApiRest");
            HttpClient clienteHttp = new HttpClient();
            clienteHttp.BaseAddress = new Uri(URL_SERVER);
            Log.Information("HClinicaControllerSup - SALUD_GenerarLlamado - EntyLLamado");
            var request = clienteHttp.PostAsync("Formato/SALUD_GenerarLlamado", LocalEnty, new JsonMediaTypeFormatter()).Result;
            int regItems;
            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;
                ViewResponse Resultado = (ViewResponse)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(ViewResponse));
                if (Resultado.valor > 0)
                {
                    regItems = Convert.ToInt32(Resultado.valor);
                }
            }
            clienteHttp.Dispose();
        }

        public System.Web.Mvc.ActionResult ControllerllamadoCancelar(String selection, string accion)
        {
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                VW_ATENCIONPACIENTE_GENERAL objAtencionPacSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                SP_SS_GenerarLlamado_Result EntyMIrth = new SP_SS_GenerarLlamado_Result();
                EntyMIrth.IdCita = objAtencionPacSelecc.IdCita;
                EntyMIrth.Secuencia = objAtencionPacSelecc.IdOrdenAtencion;
                EntyMIrth.Observacion = objAtencionPacSelecc.Nombres;
                EntyMIrth.Usuario = ENTITY_GLOBAL.Instance.USUARIO;

                ViewResponse LocalEnty = new ViewResponse();
                LocalEnty.valor = 2; //elimina con log
                LocalEnty.msg = Newtonsoft.Json.JsonConvert.SerializeObject(EntyMIrth);
                ActionSALUD_GenerarLlamado(LocalEnty, 2);
                X.Msg.Notify("Cerrar", " Se detuvo el llamado").Show();
            }
            else
            {
                X.Msg.Alert("DirectEvent", string.Format("Error :: No ha seleccionado un registro - {0}", accion)).Show();
            }
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult AnularAltaMedicaTriaje(int paciente)
        {
            Log.Information("BandejaMedicoController - AnularAltaMedicaTriaje - Entrar");

            int response = 0;
            var objGenral2 = new SS_HCE_ConsultaExterna();
            objGenral2.IdOrdenAtencion = null;
            objGenral2.Linea = null;
            objGenral2.Accion = "RELEVOPRINCIPAL";

            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = null;
            objModel.CodigoOA = null;
            objModel.IdOrdenAtencion = null;
            objModel.EpisodioAtencion = null;
            objModel.EpisodioClinico = null;
            objModel.IdEpisodioAtencion = null;
            objModel.LineaOrdenAtencion = null;
            objModel.TipoAtencion = null;

            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            objModel.TipoSituacion = null;

            return crearWindowRegistro("Procesos/AnularTriaje", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }



        public System.Web.Mvc.ActionResult AnularAltaMedica(String MODO, int paciente, string nombre,
   string codigooa, int idoa, int episodioatencion, int episodioclinico,
   long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, Nullable<int> tipointerconsulta, string tipotrabrequerido,
   string tipoListado)
        {
            Log.Information("BandejaMedicoController - AnularAltaMedica - Entrar");
            Log.Debug("BandejaMedicoController - AnularAltaMedica - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion,
                                    tipotrabrequerido, tipoListado);
            int response = 0;
            var objGenral2 = new SS_HCE_ConsultaExterna();
            objGenral2.IdOrdenAtencion = idoa;
            objGenral2.Linea = lineaoa;
            objGenral2.Accion = "RELEVOPRINCIPAL";

            response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);

            if (response == 0)
            {
                return showMensajeValidate("Advertencia", "La linea de la atención no es la principal.", "ERROR");
            }
            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();

            LocalEnty.ACCION = "EXAMENESLIST";
            LocalEnty.ValorCodigo1 = ENTITY_GLOBAL.Instance.PacienteID.ToString().Trim();
            LocalEnty.ValorCodigo2 = ENTITY_GLOBAL.Instance.EpisodioClinico.ToString().Trim();
            LocalEnty.ValorCodigo3 = ENTITY_GLOBAL.Instance.EpisodioAtencion.ToString().Trim();
            LocalEnty.ValorCodigo4 = ENTITY_GLOBAL.Instance.UnidadReplicacion.ToString().Trim();
            LocalEnty.ValorCodigo5 = "SOA";

            Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();



            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;

            objModel.IdEpisodioAtencion = idepisodioatencion;
            objModel.LineaOrdenAtencion = lineaoa;
            objModel.Accion = MODO;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO


            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                ENTITY_GLOBAL.Instance.indicadorUsuario = false;
                List<VW_PERSONAPACIENTE> lista = new List<VW_PERSONAPACIENTE>();
                VW_PERSONAPACIENTE obj = new VW_PERSONAPACIENTE();
                obj.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDPERSONALSALUD_EMERG);
                obj.ACCION = "LISTARPORID";
                lista = SvcVw_Personapaciente.listarVwPersonapaciente(obj, 0, 0);
                ENTITY_GLOBAL.Instance.USUARIO_EMERG = lista[0].USUARIO;
            }
            return crearWindowRegistro("Procesos/AnularAltaMedica", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }
        public System.Web.Mvc.ActionResult ListadoAtencionesVisitaENF(String MODO, int paciente, string nombre,
            string codigooa, int idoa, int episodioatencion, int episodioclinico,
            long idepisodioatencion, int lineaoa, Nullable<int> tipoatencion, string tipotrabrequerido,
            string tipoListado)
        {
            Log.Information("BandejaMedicoController - ListadoAtencionesVisitaENF - Entrar");
            Log.Debug("BandejaMedicoController - ListadoAtencionesVisitaENF - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, episodioatencion {F}" +
                                        ",episodioclinico {G}, idepisodioatencion {H},lineaoa {I}, tipoatencion {J},  tipotrabrequerido {L}, tipoListado {M}"
                                    , MODO, paciente, nombre, codigooa, idoa, episodioatencion, episodioclinico, idepisodioatencion, lineaoa, tipoatencion,
                                    tipotrabrequerido, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;
            objModel.EpisodioAtencion = episodioatencion;
            objModel.EpisodioClinico = episodioclinico;

            objModel.IdEpisodioAtencion = idepisodioatencion;
            objModel.LineaOrdenAtencion = lineaoa;
            objModel.Accion = MODO;
            objModel.TipoAtencion = tipoatencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            return crearWindowRegistro("Procesos/VisitaEpisodioENF", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult RegistrarAcompanante(String MODO, int idpaciente, string pacientenombre, string codigooa)
        {
            Log.Information("BandejaMedicoController - RegistrarAcompanante - Entrar");
            Log.Debug("BandejaMedicoController - RegistrarAcompanante - MODO {A}, idpaciente {B}, pacientenombre {C}, codigooa {D}"
                                    , MODO, idpaciente, pacientenombre, codigooa);
            var objModel = new SS_HC_RegistroAcompanante();

            objModel.Accion = MODO;
            objModel.CodigoOA = codigooa;
            objModel.IdPaciente = idpaciente;
            //aqui me quede
            return crearWindowRegistro("ActosMedicos/RegistrarAcompanante", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult postWindowAcompanante(String id, String idPaciente)
        {
            Log.Information("BandejaMedicoController - RegistrarAcompanante - Entrar");
            Log.Debug("BandejaMedicoController - RegistrarAcompanante - id {A}, idPaciente {B}"
                                    , id, idPaciente);
            PERSONAMAST objAg = new PERSONAMAST();
            var Listar = new List<PERSONAMAST>();

            var field = X.GetCmp<TextField>("txtPacienteN");
            if (field != null)
            {
                objAg.ACCION = "LISTAR";
                objAg.Persona = (getValorFiltroInt(id) != null ? Convert.ToInt32(getValorFiltroInt(id)) : 0);
                Listar = SvcPersonaMast.listarPersonaMast(objAg, 0, 0);
                if (Listar.Count == 1)
                {
                    foreach (PERSONAMAST objEntity in Listar)
                    {
                        objAg = objEntity;
                        field.SetValue(objAg.NombreCompleto);
                    }
                }
            }

            setPropiedadesFormulario(true);

            return this.Direct();
        }

        public System.Web.Mvc.ActionResult save_Acompanante(SS_HC_RegistroAcompanante objFiltro, String MODO, String idWindow)
        {
            Log.Information("BandejaMedicoController - save_Acompanante - Entrar");
            Log.Debug("BandejaMedicoController - save_Acompanante - objFiltro {A}, MODO {B}, idWindow {C}"
                                    , objFiltro, MODO, idWindow);
            List<ENTITY_MENSAJES> msgNoValido = null;
            int idResultado = 0;
            String accion = "";
            String message = "";
            String tipoMsg = "INFO";
            String tituloMsg = "Mensaje";
            Boolean indicaValidacionForm = false;

            if (objFiltro != null)
            {
                objFiltro.Accion = MODO;
                if (Session["MENSAJES_VALFORM"] != null)
                {
                    msgNoValido = (List<ENTITY_MENSAJES>)Session["MENSAJES_VALFORM"];
                }
                else
                {
                    msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objFiltro, UTILES_MENSAJES.FORM_MSTREGISTRARACOMPANANTE);
                }

                if (msgNoValido.Count > 0)
                {
                    message = msgNoValido[0].DESCRIPCION;
                    tipoMsg = "WARNING";
                    tituloMsg = "Advertencia";
                    indicaValidacionForm = true;
                }
                else
                {
                    try
                    {

                        if (MODO == "NUEVO")
                        {
                            objFiltro.Accion = "INSERT";
                            accion = "registró";
                        }
                        else if (MODO == "UPDATE")
                        {
                            objFiltro.Accion = "UPDATE";
                            accion = "modificó";
                        }
                        else if (MODO == "DELETE")
                        {
                            objFiltro.Accion = "DELETE";
                            accion = "eliminó";
                        }
                        else
                        {
                            tipoMsg = "WARNING";
                            message = "No se encontró el MODO.";
                            tituloMsg = "Advertencia";
                        }
                        try
                        {
                            //objCuerpo.Estado = Convert.ToInt32(objCuerpo.UsuarioModificacion);
                        }
                        catch (Exception e)
                        {
                            X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                        }
                        /////registro
                        objFiltro.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        objFiltro.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        idResultado = SvcRegistroAcompanante.setMantenimientoRegistroAcompanante(objFiltro);
                        //////////////////////FINAL
                        if (idResultado > 0)
                        {
                            message = "Se " + accion + " satisfactoriamente.";
                        }
                        else
                        {
                            tipoMsg = "ERROR";
                            message = "No se pudieron guardar los cambios. Sucedio un error en la operación.";
                            tituloMsg = "Error";
                        }
                    }
                    catch (Exception ex)
                    {
                        Log.Information("BandejaMedicoController - save_Acompanante - Bloque Catch");
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
            }
            else
            {
                tipoMsg = "ERROR";
                message = "No se pudieron guardar los cambios. No se recibió el objeto vinculado.";
                tituloMsg = "Error";
            }
            objFiltro.Accion = "INFO";
            if (indicaValidacionForm)
            {
                return showMensajeBotton(msgNoValido, tituloMsg, tipoMsg);
            }
            else
            {
                return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "");
            }
        }




        public System.Web.Mvc.ActionResult ListadoGrupoAtencionesTecMed(String MODO, int paciente, string nombre,
    string codigooa, int idoa, string unidadReplicacionOrigen, Nullable<long> episodioatencionOrigen,
            Nullable<int> episodioclinicoOrigen, int lineaoa, Nullable<int> tipoatencion, string tipotrabrequerido
            , string fechaIni, string fechaFin, string tipoListado)
        {
            Log.Information("BandejaMedicoController - ListadoGrupoAtencionesTecMed - Entrar");
            Log.Debug("BandejaMedicoController - ListadoGrupoAtencionesTecMed - MODO {A}, paciente {B}, nombre {C}, codigooa {D} ,idoa {E}, unidadReplicacionOrigen {F}" +
                                        ",episodioatencionOrigen {G}, episodioclinicoOrigen {H},lineaoa {I}, tipoatencion {J},  tipotrabrequerido {K}, tipotrabrequerido {L}, fechaIni {M},fechaFin {N} ,tipoListado {O}"
                                    , MODO, paciente, nombre, codigooa, idoa, unidadReplicacionOrigen, episodioatencionOrigen, episodioclinicoOrigen, lineaoa, tipoatencion,
                                    tipotrabrequerido, tipotrabrequerido, fechaIni, fechaFin, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = paciente;
            objModel.NombreCompleto = nombre;
            objModel.CodigoOA = codigooa;
            objModel.IdOrdenAtencion = idoa;
            objModel.UnidadReplicacionEC = unidadReplicacionOrigen;
            objModel.IdEpisodioAtencion = episodioatencionOrigen;
            objModel.EpisodioClinico = episodioclinicoOrigen;
            objModel.Accion = MODO;
            //
            objModel.LineaOrdenAtencion = lineaoa;
            objModel.TipoAtencion = tipoatencion;
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            //////
            objModel.FecIniDiscamec = getValorFiltroDate(fechaIni);
            objModel.FecFinDiscamec = getValorFiltroDate(fechaFin);

            SS_HC_UnidadServicio objUnidServ = new SS_HC_UnidadServicio();
            objUnidServ.Accion = "LISTAR";
            objUnidServ.IdEstablecimientoSalud = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
            objUnidServ.IndicadorTriaje = tipoatencion;
            int tipoOrdenAtencion = 0;
            if (Session["IDCONFIG_TRABAJADOR_ACTUAL"] != null)
            {
                tipoOrdenAtencion = (int)Session["IDCONFIG_TRABAJADOR_ACTUAL"];
            }
            List<SS_HC_UnidadServicio> listarUnidServ = SvcUnidadServicio.listarUnidadServicio(objUnidServ, tipoOrdenAtencion, 0);
            objModel.IdUnidadServicio = 0;
            if (listarUnidServ.Count > 0)
            {
                objModel.IdUnidadServicio = listarUnidServ[0].IdUnidadServicio; //OBTENER PRIMERO SI EXISTIERA
            }
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }

            objModel.TipoHistoria = tipotrabrequerido;//AUX PARA TIPOTRABAJADOR REQUERIDO
            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO



            UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);

            return crearWindowRegistro("Procesos/TecMedicoEpisodio", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult AutenticacionAdicionalEnfemera(String MODO, string tipotrab, string campoEvento,
        Nullable<int> especialidad, String trabajadorRequerido, Nullable<int> empleadoCreador, String mensajes)
        {
            Log.Information("BandejaMedicoController - AutenticacionAdicionalEnfemera - Entrar");
            Log.Debug("BandejaMedicoController - AutenticacionAdicionalEnfemera - MODO {A}, tipotrab {B}, campoEvento {C}, especialidad {D} ,trabajadorRequerido {E}, empleadoCreador {F}" +
                                        ",mensajes {G}", MODO, tipotrab, campoEvento, especialidad, trabajadorRequerido, empleadoCreador, mensajes);

            ENTITY_GLOBAL.Instance.despachoExtra = false;
            SG_Agente objModel = new SG_Agente();
            objModel.ACCION = MODO;
            objModel.Nombre = campoEvento;
            objModel.IdCodigo = especialidad;  //AUX PARA ID ESPECIALIDAD
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.tipotrabajador = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            objModel.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            ENTITY_GLOBAL.Instance.USUARIOESP = ENTITY_GLOBAL.Instance.USUARIO;
            /////////////////
            objModel.UsuarioCreacion = objModel.tipotrabajador; //AUX PARA TIPO TRAB REQ //AUX PARA TIPO TRAB REQ
            objModel.IdEmpleado = empleadoCreador; //AUX ID EMPLEADO CREADOR            
            if (mensajes.Length > 0)
            {
                mensajes = mensajes.Trim();
                if (mensajes.Substring(0, 1) == ";")
                {
                    mensajes = mensajes.Substring(1, mensajes.Length - 1);
                }
            }
            objModel.Descripcion = mensajes + "."; //AUX PARA EMNSAJES

            //VALIDAR PEDIDO YA DESPACHADO
            if (ENTITY_GLOBAL.Instance.GuiaPedido != "")
            {
                int idResultados = 0;
                var objGenral = new SS_HCE_ConsultaExterna();
                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                objGenral.Componente = ENTITY_GLOBAL.Instance.GuiaPedido;
                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                objGenral.Accion = "VALIDATE_PEDIDO";
                idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);

                if (idResultados == -1)
                {
                    ENTITY_GLOBAL.Instance.GuiaPedido = "";
                    objModel.Descripcion = "ADVERTENCIA: La Solicitud de Pedido N° " + objGenral.Componente + " ya se encuentra Despachado. Si desea puede generar otra nueva Solicitud de Pedido. Presione Confirmar.";
                }
            }

            return crearWindowRegistro("Procesos/AutenticacionAdicional", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult AutenticacionAdicionalEnfemera02(String MODO, string tipotrab, string campoEvento,
        Nullable<int> especialidad, String trabajadorRequerido, Nullable<int> empleadoCreador, String mensajes)
        {
            ENTITY_GLOBAL.Instance.despachoExtra = true;
            Log.Information("BandejaMedicoController - AutenticacionAdicionalEnfemera - Entrar");
            Log.Debug("BandejaMedicoController - AutenticacionAdicionalEnfemera - MODO {A}, tipotrab {B}, campoEvento {C}, especialidad {D} ,trabajadorRequerido {E}, empleadoCreador {F}" +
                                        ",mensajes {G}", MODO, tipotrab, campoEvento, especialidad, trabajadorRequerido, empleadoCreador, mensajes);

            ENTITY_GLOBAL.Instance.despachoExtra = true;
            SG_Agente objModel = new SG_Agente();
            objModel.ACCION = MODO;
            objModel.Nombre = campoEvento;
            objModel.IdCodigo = especialidad;  //AUX PARA ID ESPECIALIDAD
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.tipotrabajador = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            objModel.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            ENTITY_GLOBAL.Instance.USUARIOESP = ENTITY_GLOBAL.Instance.USUARIO;
            /////////////////
            objModel.UsuarioCreacion = objModel.tipotrabajador; //AUX PARA TIPO TRAB REQ //AUX PARA TIPO TRAB REQ
            objModel.IdEmpleado = empleadoCreador; //AUX ID EMPLEADO CREADOR            
            if (mensajes.Length > 0)
            {
                mensajes = mensajes.Trim();
                if (mensajes.Substring(0, 1) == ";")
                {
                    mensajes = mensajes.Substring(1, mensajes.Length - 1);
                }
            }
            objModel.Descripcion = mensajes + "."; //AUX PARA EMNSAJES

            //VALIDAR PEDIDO YA DESPACHADO
            if (ENTITY_GLOBAL.Instance.GuiaPedido != "")
            {
                int idResultados = 0;
                var objGenral = new SS_HCE_ConsultaExterna();
                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                objGenral.Componente = ENTITY_GLOBAL.Instance.GuiaPedido;
                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                objGenral.Accion = "VALIDATE_PEDIDO";
                idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);

                if (idResultados == -1)
                {
                    ENTITY_GLOBAL.Instance.GuiaPedido = "";
                    objModel.Descripcion = "ADVERTENCIA: La Solicitud de Pedido N° " + objGenral.Componente + " ya se encuentra Despachado. Si desea puede generar otra nueva Solicitud de Pedido. Presione Confirmar.";
                }
            }

            return crearWindowRegistro("Procesos/AutenticacionAdicional", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult AutenticacionAdicional(String MODO, string tipotrab, string campoEvento,
            Nullable<int> especialidad, String trabajadorRequerido, Nullable<int> empleadoCreador, String mensajes)
        {
            Log.Information("BandejaMedicoController - AutenticacionAdicional - Entrar");
            Log.Debug("BandejaMedicoController - AutenticacionAdicional - MODO {A}, tipotrab {B}, campoEvento {C}, especialidad {D} ,trabajadorRequerido {E}, empleadoCreador {F}" +
                                        ",mensajes {G}", MODO, tipotrab, campoEvento, especialidad, trabajadorRequerido, empleadoCreador, mensajes);
            //metodo para nuevo y vista
            if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia")
            {
                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                int idResultados = 0;
                var objGenral = new SS_HCE_ConsultaExterna();
                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                objGenral.Accion = "APE_EMER";

                idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                if (idResultados == 0)
                {
                    return showMensajeNotify("No se pudo aperturar!", "La atención no cuenta con una apertura de emergencia.", "INFO");
                    // return showMensajeNotifyData("Error", "No se pudo aperturar la atención  " + "La cuenta con una apertura de emergencia.", "ERROR", false);
                }
            }

            SG_Agente objModel = new SG_Agente();
            objModel.ACCION = MODO;
            objModel.Nombre = campoEvento;
            objModel.IdCodigo = especialidad;  //AUX PARA ID ESPECIALIDAD
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.tipotrabajador = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            objModel.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            ENTITY_GLOBAL.Instance.USUARIOESP = ENTITY_GLOBAL.Instance.USUARIO;
            /////////////////
            objModel.UsuarioCreacion = trabajadorRequerido; //AUX PARA TIPO TRAB REQ
            objModel.IdEmpleado = empleadoCreador; //AUX ID EMPLEADO CREADOR            
            if (mensajes.Length > 0)
            {
                mensajes = mensajes.Trim();
                if (mensajes.Substring(0, 1) == ";")
                {
                    mensajes = mensajes.Substring(1, mensajes.Length - 1);
                }
            }
            objModel.Descripcion = mensajes + "."; //AUX PARA EMNSAJES
            return crearWindowRegistro("Procesos/AutenticacionAdicional", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        //Agregado 20/07/2023
        public System.Web.Mvc.ActionResult AutenticacionAdicionalEnf(String MODO, string tipotrab, string campoEvento,
            Nullable<int> especialidad, String trabajadorRequerido, Nullable<int> empleadoCreador, String mensajes)
        {
            Log.Information("BandejaMedicoController - AutenticacionAdicional - Entrar");
            Log.Debug("BandejaMedicoController - AutenticacionAdicional - MODO {A}, tipotrab {B}, campoEvento {C}, especialidad {D} ,trabajadorRequerido {E}, empleadoCreador {F}" +
                                        ",mensajes {G}", MODO, tipotrab, campoEvento, especialidad, trabajadorRequerido, empleadoCreador, mensajes);
            //metodo para nuevo y vista
            if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia")
            {
                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                int idResultados = 0;
                var objGenral = new SS_HCE_ConsultaExterna();
                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                objGenral.Accion = "APE_EMER";

                idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                if (idResultados == 0)
                {
                    return showMensajeNotify("No se pudo aperturar!", "La atención no cuenta con una apertura de emergencia.", "INFO");
                    // return showMensajeNotifyData("Error", "No se pudo aperturar la atención  " + "La cuenta con una apertura de emergencia.", "ERROR", false);
                }
            }

            SG_Agente objModel = new SG_Agente();
            objModel.ACCION = MODO;
            if (MODO == "NUEVO")
            {
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
            }
            objModel.Nombre = campoEvento;
            objModel.IdCodigo = especialidad;  //AUX PARA ID ESPECIALIDAD
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.tipotrabajador = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            objModel.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            ENTITY_GLOBAL.Instance.USUARIOESP = ENTITY_GLOBAL.Instance.USUARIO;
            /////////////////
            objModel.UsuarioCreacion = trabajadorRequerido; //AUX PARA TIPO TRAB REQ
            objModel.IdEmpleado = empleadoCreador; //AUX ID EMPLEADO CREADOR            
            if (mensajes.Length > 0)
            {
                mensajes = mensajes.Trim();
                if (mensajes.Substring(0, 1) == ";")
                {
                    mensajes = mensajes.Substring(1, mensajes.Length - 1);
                }
            }
            objModel.Descripcion = mensajes + "."; //AUX PARA EMNSAJES
            return crearWindowRegistro("Procesos/AutenticacionAdicional", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);
        }

        public System.Web.Mvc.ActionResult eventoAutenticacionEpisodio(String MODO, string tipotrab, string campoEvento,
       Nullable<int> especialidad, String trabajadorRequerido, Nullable<int> empleadoCreador, String mensajes, String IdEpisodioAtencion)
        {
            Log.Information("BandejaMedicoController - eventoAutenticacionEpisodio - Entrar");
            Log.Debug("BandejaMedicoController - eventoAutenticacionEpisodio - MODO {A}, tipotrab {B}, campoEvento {C}, especialidad {D} ,trabajadorRequerido {E}, empleadoCreador {F}" +
                                        ",mensajes {G}", MODO, tipotrab, campoEvento, especialidad, trabajadorRequerido, empleadoCreador, mensajes);
            //metodo para editar episodio
            if (ENTITY_GLOBAL.Instance.TIPOATENCION == "2")  //INDICA_TIPO_ORDENATENCION_EMER
            {
                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                int idResultados = 0;
                var objGenral = new SS_HCE_ConsultaExterna();
                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                objGenral.Accion = "APE_EMER";

                idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                if (idResultados == 0)
                {
                    return showMensajeNotify("No se pudo aperturar!", "La atención no cuenta con una apertura de emergencia.", "INFO");
                }

                VW_ATENCIONPACIENTE respondse = (VW_ATENCIONPACIENTE)Newtonsoft.Json.JsonConvert.DeserializeObject(IdEpisodioAtencion, typeof(VW_ATENCIONPACIENTE));

                List<VW_ATENCIONPACIENTE> ListarVisitas = new List<VW_ATENCIONPACIENTE>();
                ListarVisitas.Add(respondse);
                Session["DATA_VISITAS"] = ListarVisitas;
                //if (!string.IsNullOrEmpty(ENTITY_GLOBAL.Instance.EpisodioClinico.ToString()))
                //{
                //    SS_FA_SolicitudProducto objProducto = new SS_FA_SolicitudProducto();
                //    objProducto.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                //    objProducto.IdEpisodioAtencion = (int)respondse.IdEpisodioAtencion;
                //    objProducto.EpisodioClinico = (int)respondse.EpisodioClinico;
                //    objProducto.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                //    var respprodu = new List<SS_FA_SolicitudProducto>();
                //    respprodu = svcSS_FA_SolicitudProducto.ListarSolicitudProductoListar(objProducto);
                //    if (respprodu.Count > 0)
                //    {  //jordan mateo se migro hacia receta  26/08/2022
                //        return showMensajeNotify("Validación!", "Ya se encuentra dispensado la visita.", "INFO");
                //        
                //    }
                //}
            }

            SG_Agente objModel = new SG_Agente();
            objModel.ACCION = MODO;
            objModel.Nombre = campoEvento;
            objModel.IdCodigo = especialidad;  //AUX PARA ID ESPECIALIDAD
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.tipotrabajador = (string)Session["TIPOTRABAJADOR_ACTUAL"];
            }
            objModel.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
            ENTITY_GLOBAL.Instance.USUARIOESP = ENTITY_GLOBAL.Instance.USUARIO;
            /////////////////
            objModel.UsuarioCreacion = trabajadorRequerido; //AUX PARA TIPO TRAB REQ
            objModel.IdEmpleado = empleadoCreador; //AUX ID EMPLEADO CREADOR            
            if (mensajes.Length > 0)
            {
                mensajes = mensajes.Trim();
                if (mensajes.Substring(0, 1) == ";")
                {
                    mensajes = mensajes.Substring(1, mensajes.Length - 1);
                }
            }
            objModel.Descripcion = mensajes + "."; //AUX PARA EMNSAJES
            return crearWindowRegistro("Procesos/AutenticacionAdicional", objModel, "");
        }


        public System.Web.Mvc.ActionResult autenticacion_Usuario(SG_Agente objSave,
            String txtUsername, String txtPassword, Nullable<int> idEspecialidad, String MODO, String idWindow,
            String campoEvento, String indicaEspecialidad, String idEmpleadoCreador, String tipoTrabajadorReq
            , String tipoEvento)
        {
            Log.Information("BandejaMedicoController - autenticacion_Usuario - Entrar");
            Log.Debug("BandejaMedicoController - autenticacion_Usuario - objSave {A}, txtUsername {B}, txtPassword {C}, MODO {D} ,idWindow {E}, idWindow {F}, hay más parametros" +
                                        ",mensajes {G}", objSave, txtUsername, txtPassword, idEspecialidad, MODO, idWindow);

            if (txtUsername != "" && tipoEvento == "JS")
            {
                objSave = new SG_Agente();
                objSave.CodigoAgente = txtUsername;
                objSave.Clave = txtPassword;
                objSave.IdCodigo = idEspecialidad;
            }


            if (objSave != null)
            {
                try
                {
                    var Listar = new List<SG_Agente>();
                    List<VW_ATENCIONPACIENTE> ListarVisitas = new List<VW_ATENCIONPACIENTE>();
                    SG_Agente objUsuario = new SG_Agente();
                    /****************************************************/
                    DataTable dtAgente = new DataTable();
                    HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                    HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                    //if (Session["LoginAttempts"] == null)
                    //{
                    Session["LoginAttempts"] = 0;
                    //}

                    int loginAttempts = (int)Session["LoginAttempts"];

                    //if (loginAttempts > ENTITY_GLOBAL.Instance.ADSession)
                    //{
                    //    return showMensajeBox("Has alcanzado el número máximo de intentos. Por favor, contacta a Mesa de Ayuda.", "Acceso denegado", "ERROR", "REINICIAR");
                    //}

                    string INDADL = "";
                    string ADDOMAIN = "";
                    string USUARIORED = "";

                    if (txtUsername.ToUpper() != "ROYAL")
                    {
                        DataTable dtValida = new DataTable();
                        WsEpisodio.SecuenciaHCE = txtUsername.Trim().ToUpper();
                        WsEpisodio.UsuarioCreacion = "ADDOMAINWE";
                        dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);

                        if (dtValida != null && dtValida.Rows.Count > 0)
                        {
                            foreach (DataRow intobj in dtValida.AsEnumerable())
                            {
                                INDADL = intobj["IndicadorValidarUsuarioRed"].ToString();
                                ADDOMAIN = intobj["NombreDominioRed"].ToString();
                                USUARIORED = intobj["UsuarioRed"].ToString();
                            }

                            try
                            {
                                if (INDADL == "2" || INDADL == "S")
                                {
                                    if (ADDOMAIN.Length > 0 && USUARIORED.Length > 0)
                                    {
                                        Log.Information("NetworkCredential - inicio");
                                        LdapConnection connection = new LdapConnection(ADDOMAIN);
                                        NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper(), txtPassword);
                                        connection.Credential = credential;
                                        connection.Bind();
                                        Log.Information("NetworkCredential - Fin");
                                    }
                                    else
                                    {
                                        List<ENTITY_MENSAJES> listaMsgNo = new List<ENTITY_MENSAJES>();
                                        ENTITY_MENSAJES sms = new ENTITY_MENSAJES();
                                        sms.DESCRIPCION = "No cuenta con el UsuarioRed en el Sistema";
                                        listaMsgNo.Add(sms);
                                        return showMensajeBotton(listaMsgNo, "Error", "ERROR");
                                        //  showMensajeNotify("Autenticación Correcta", mensajeFinal, "INFO");
                                    }
                                }
                            }
                            catch (LdapException lexc)
                            {
                                string errorMessage = Newtonsoft.Json.JsonConvert.SerializeObject(lexc.ServerErrorMessage);
                                Log.Information("Login - ServerErrorMessage");
                                Log.Debug(errorMessage);

                                string[] cadArray = errorMessage.Trim().Split(',');
                                string msj = cadArray[2];
                                Log.Information("Login - Message[]");
                                Log.Debug(msj);

                                //string errorMessage;
                                switch (msj)
                                {
                                    case " data 52e": // Invalid credentials
                                        errorMessage = "Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.";
                                        break;
                                    case " data 525": // User not found
                                        errorMessage = "Usuario no encontrado (525).";
                                        break;
                                    case " data 530": // Not permitted to logon at this time
                                        errorMessage = "No se permite iniciar sesión en este momento (530). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 532": // Password expired
                                        errorMessage = "La Contraseña ha caducado (532). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 533": // Account disabled
                                        errorMessage = "La Cuenta esta deshabilitada (533). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 701": // Account expired
                                        errorMessage = "Cuenta expirada (701). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 773": // User must reset password
                                        errorMessage = "El usuario debe restablecer su contraseña (773). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 775": // User account locked
                                        errorMessage = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";
                                        break;
                                    default:
                                        errorMessage = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                                        break;
                                }

                                List<ENTITY_MENSAJES> listaMsgNo = new List<ENTITY_MENSAJES>();
                                ENTITY_MENSAJES sms = new ENTITY_MENSAJES();
                                sms.DESCRIPCION = errorMessage;
                                listaMsgNo.Add(sms);
                                return showMensajeBotton(listaMsgNo, "Error", "ERROR");
                            }
                            catch (Exception ex)
                            {
                                Log.Information("LdapConnection - Login");
                                Log.Debug("ex.Message {A} ", Newtonsoft.Json.JsonConvert.SerializeObject(ex));
                            }
                        }
                        else
                        {
                            Log.Information("LdapConnection - Login");
                            List<ENTITY_MENSAJES> listaMsgNo = new List<ENTITY_MENSAJES>();
                            ENTITY_MENSAJES sms = new ENTITY_MENSAJES();
                            sms.DESCRIPCION = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                            listaMsgNo.Add(sms);
                            return showMensajeBotton(listaMsgNo, "Error", "ERROR");
                        }
                    }

                    /****************************************************/
                    if (INDADL == "2" || INDADL == "S")
                    {
                        objUsuario.ACCION = "VALIDARADDOMAIN";
                        objUsuario.CodigoAgente = txtUsername;
                        Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                        Log.Debug("listarSG_Agente VALIDARADDOMAIN ", Newtonsoft.Json.JsonConvert.SerializeObject(Listar));
                        foreach (SG_Agente objEntity in Listar)
                        {
                            objSave.Clave = objEntity.Clave;
                        }
                    }

                    objUsuario.ACCION = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? objUsuario.ACCION = "VALIDARLOGINEMER" : objUsuario.ACCION = "VALIDARLOGIN";
                    objUsuario.CodigoAgente = txtUsername;
                    objUsuario.Clave = objSave.Clave;
                    objUsuario.IdGrupoTransaccion = objSave.IdCodigo;
                    //OBS:  verificar proceso adecuado...
                    //Listar = SvcUsuario.listarUsuario(objUsuario);
                    Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);

                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && tipoTrabajadorReq != "02" && Listar.Count > 0)
                    {
                        int response = 0;
                        var objGenral2 = new SS_HCE_ConsultaExterna();
                        objGenral2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                        objGenral2.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                        objGenral2.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                        objGenral2.Medico = Listar[0].IdEmpleado;
                        objGenral2.TipoOrdenMedica = 2;
                        objGenral2.Especialidad = objUsuario.IdGrupoTransaccion;
                        objGenral2.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        objGenral2.Accion = "HORARIO";
                        response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);

                        if (response == 0)
                        {
                            List<ENTITY_MENSAJES> listaMsgNoValido = new List<ENTITY_MENSAJES>();
                            ENTITY_MENSAJES sms = new ENTITY_MENSAJES();
                            sms.DESCRIPCION = "El médico no tiene horario / especialidad";
                            listaMsgNoValido.Add(sms);
                            return showMensajeBotton(listaMsgNoValido, "Error", "ERROR");
                            // return showMensajeNotify("No se pudo aperturar!", "El médico no tiene horario / especialidad", "INFO");
                        }
                    }
                    Boolean validoLogin = false;
                    string mensajeFinal = "";
                    //////////////VALIDAR LOGIN
                    if (Listar.Count > 0)
                    {
                        objUsuario = Listar[0];
                        ENTITY_GLOBAL.Instance.Enfpersonalsalud = objUsuario.IdEmpleado;
                        ENTITY_GLOBAL.Instance.EnfermeraNombre = objUsuario.Nombre;
                        ENTITY_GLOBAL.Instance.IdMedico = objUsuario.IdEmpleado;
                        ENTITY_GLOBAL.Instance.MedicoNombre = objUsuario.Nombre;
                    }
                    else
                    {
                        objUsuario = null;
                    }
                    if (objUsuario != null)
                    {
                        if (objUsuario.TipoAgente > 1)
                        {
                            if (objUsuario.IdEmpleado != null)
                            {
                                bool indicaContinuar = true;
                                if (objUsuario.Estado < 0)
                                {
                                    indicaContinuar = false;
                                    mensajeFinal = (objUsuario.UsuarioCreacion + "").Trim();
                                }

                                if (indicaEspecialidad == "1" && indicaContinuar)
                                {
                                    if (objUsuario.flatUsuGenerico == 2)
                                    {
                                        indicaContinuar = false;
                                        mensajeFinal = "Es un Usuario Generico No Puede Acceder a Modificar Los Formatos. ";
                                    }
                                    else if (objSave.IdCodigo == null || objSave.IdCodigo == 0 && objUsuario.flatUsuGenerico == null)
                                    {
                                        indicaContinuar = false;
                                        mensajeFinal = "No se pudo Continuar. Debe seleccionar alguna especialidad. ";
                                    }
                                    else
                                    {
                                        UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", objSave.IdCodigo);
                                    }
                                }
                                if (objUsuario.tipotrabajador == null && objUsuario.flatUsuGenerico == 2)
                                {
                                    indicaContinuar = false;
                                    mensajeFinal = "Es un Usuario Generico No Puede Acceder a Modificar Los Formatos. ";
                                }
                                if (idEmpleadoCreador != "" && idEmpleadoCreador != "0" && idEmpleadoCreador != null && indicaContinuar)
                                {
                                    if (objUsuario.IdEmpleado != getValorFiltroInt(idEmpleadoCreador) && (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER != "Emergencia" && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER != "Relevo"))
                                    // if (objUsuario.IdEmpleado != getValorFiltroInt(idEmpleadoCreador))
                                    {
                                        indicaContinuar = false;
                                        mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que creó la atención ";
                                    }
                                }
                                if (tipoTrabajadorReq != "" && tipoTrabajadorReq != null && indicaContinuar && tipoTrabajadorReq != "04")
                                {
                                    if ((objUsuario.tipotrabajador + "").Trim() != (tipoTrabajadorReq + "").Trim())
                                    {
                                        indicaContinuar = false;
                                        mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda al tipo de trabajador correcto. ";
                                    }
                                }

                                /**if(ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER != "Interconsulta" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && objSave.IdCodigo != 30 && tipoTrabajadorReq != "02")
                                {
                                    indicaContinuar = false;
                                    mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la especialidad Emergencia.";
                                }*/
                                if (tipoTrabajadorReq != "02")
                                {
                                    if (Session["DATA_VISITAS"] != null && MODO == "NUEVO")
                                    {
                                        ListarVisitas = (List<VW_ATENCIONPACIENTE>)Session["DATA_VISITAS"];
                                        ListarVisitas = ListarVisitas.Where(x => x.IdTipoInterConsulta == 1 && x.IdPersonalSalud == objUsuario.IdEmpleado).ToList();
                                        if (ListarVisitas.Count == 0)
                                        {
                                            indicaContinuar = false;
                                            mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la atención. ";
                                        }
                                    }
                                    if (MODO == "ABRIR")
                                    {
                                        if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo")
                                        {
                                            int response = 0;
                                            var objGenral2 = new SS_HCE_ConsultaExterna();
                                            objGenral2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                            objGenral2.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            objGenral2.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                            objGenral2.Medico = objUsuario.IdEmpleado;
                                            objGenral2.Accion = "MED_RELEVO";

                                            response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);
                                            if (response != objUsuario.IdEmpleado)
                                            {
                                                indicaContinuar = false;
                                                mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la atención.";
                                            }
                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso")
                                        {

                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Procedimiento")
                                        {
                                            /* int response = 0;
                                             var objGenral2 = new SS_HCE_ConsultaExterna();
                                             objGenral2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                             objGenral2.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                             objGenral2.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                             objGenral2.Medico = objUsuario.IdEmpleado;
                                             objGenral2.Accion = "MED_PROCED";

                                             response = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral2);
                                             if (response != objUsuario.IdEmpleado)
                                             {
                                                 indicaContinuar = false;
                                                 mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la atención.";
                                             }*/
                                        }
                                        else if (obtenerFlatPrincipal(Convert.ToInt32(objUsuario.IdEmpleado), ENTITY_GLOBAL.Instance.CodigoOA).Count > 0 && tipoTrabajadorReq != "04" && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER != "Interconsulta")
                                        {
                                            indicaContinuar = false;
                                            mensajeFinal = "Usuario Incorrecto. El usuario ya esta asignado como médico principal. ";
                                        }
                                    }
                                    if (MODO == "UPDATE" && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo")
                                    {
                                        if (Session["DATA_VISITAS"] != null)
                                        {
                                            ListarVisitas = (List<VW_ATENCIONPACIENTE>)Session["DATA_VISITAS"];
                                            ListarVisitas = ListarVisitas.Where(x => x.IdTipoInterConsulta == 1 && x.IdPersonalSalud == objUsuario.IdEmpleado).ToList();
                                            if (ListarVisitas.Count == 0)
                                            {
                                                indicaContinuar = false;
                                                mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la atención. ";
                                            }
                                        }
                                    }
                                    if (Session["DATA_VISITAS"] != null && MODO == "UPDATE" && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia")
                                    {
                                        ListarVisitas = (List<VW_ATENCIONPACIENTE>)Session["DATA_VISITAS"];
                                        ListarVisitas = ListarVisitas.Where(x => x.IdPersonalSalud == objUsuario.IdEmpleado).ToList();
                                        if (ListarVisitas.Count > 0)
                                        {
                                            indicaContinuar = true;
                                            //if (ListarVisitas.Count == 1)
                                            //{
                                            //    indicaContinuar = true;
                                            //}
                                            //else
                                            //{
                                            //    ListarVisitas = ListarVisitas.Where(x => x.IdTipoInterConsulta == 1 && x.IdPersonalSalud == objUsuario.IdEmpleado).ToList();
                                            //    if (ListarVisitas.Count == 0)
                                            //    {
                                            //        indicaContinuar = false;
                                            //        mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la atención. ";
                                            //    }
                                            //    else
                                            //    {
                                            //        indicaContinuar = true;
                                            //    }
                                            //}
                                        }
                                        else
                                        {
                                            mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la atención. ";
                                            indicaContinuar = false;
                                        }
                                    }
                                    if ((MODO == "UPDATE" || MODO == "NUEVO") && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso")
                                    {
                                        ListarVisitas = (List<VW_ATENCIONPACIENTE>)Session["DATA_VISITAS"];
                                        ListarVisitas = ListarVisitas.Where(x => x.LineaOrdenAtencion == ENTITY_GLOBAL.Instance.LineaOrdenAtencion).ToList();
                                        ListarVisitas = Session["DATA_VISITAS"] == null ? new List<VW_ATENCIONPACIENTE>() : (List<VW_ATENCIONPACIENTE>)Session["DATA_VISITAS"];
                                        if (ListarVisitas.Count > 0)
                                        {
                                            ListarVisitas = ListarVisitas.Where(x => x.LineaOrdenAtencion == ENTITY_GLOBAL.Instance.LineaOrdenAtencion).ToList();
                                            if (ListarVisitas.Count > 0)
                                            {
                                                if (objUsuario.IdEmpleado != ListarVisitas[0].IdPersonalSalud)
                                                {
                                                    indicaContinuar = false;
                                                    mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda a la atención. ";
                                                }
                                            }

                                        }
                                    }
                                    if (objUsuario.IdGrupoTransaccion != ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER && ListarVisitas.Count == 0 && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Interconsulta" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && tipoTrabajadorReq != "04")
                                    {
                                        indicaContinuar = false;
                                        mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda al tipo de especialidad correcta. ";
                                    }
                                    //if (objUsuario.IdGrupoTransaccion != ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER && ListarVisitas.Count == 0 && ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && tipoTrabajadorReq != "04")
                                    //{
                                    //    indicaContinuar = false;
                                    //    mensajeFinal = "Usuario Incorrecto. Debe ingresar el usuario que corresponda al tipo de especialidad correcta. ";
                                    //}
                                }

                                if (indicaContinuar)
                                {
                                    //////////////VALIDAR AUTORIZACIÓN COMPAÑÍA y  SUCURSAL
                                    var ListarAutoriza = new List<SY_SeguridadAutorizaciones>();
                                    var LocalEnty = new SY_SeguridadAutorizaciones();
                                    LocalEnty.AplicacionCodigo = "SY";
                                    int inicio = Convert.ToInt32(objUsuario.IdAgente);
                                    LocalEnty.Usuario = objUsuario.CodigoAgente;
                                    LocalEnty.Accion = "LISTARSEGURIDAD";
                                    LocalEnty.Grupo = "COMPANIASOCIO";
                                    LocalEnty.Concepto = ENTITY_GLOBAL.Instance.Compania;
                                    ListarAutoriza = SvcSeguridadAutorizacion.listarSysSeguridadAutorizaciones(LocalEnty, inicio, 0);
                                    if (ListarAutoriza.Count > 0)//POSEE AUTORIZACIÓN PARA COMPAÑÍA ACTUAL
                                    {
                                        LocalEnty.Grupo = "SUCURSAL";
                                        LocalEnty.Concepto = ENTITY_GLOBAL.Instance.Sucursal;
                                        ListarAutoriza = SvcSeguridadAutorizacion.listarSysSeguridadAutorizaciones(LocalEnty, inicio, 0);
                                        if (ListarAutoriza.Count > 0)//POSEE AUTORIZACIÓN PARA SUCURSAL ACTUAL
                                        {
                                            validoLogin = true;
                                            //OBS: 2

                                            mensajeFinal = "Personal de Salud actual: " + objUsuario.UsuarioModificacion;//AUX PARA EL NOMBRE DE LA PERSONA
                                        }
                                        else
                                        {
                                            mensajeFinal = "No se pudo Continuar. El Agente ingresado no posee Autorización para la Sucursal Actual: " + ENTITY_GLOBAL.Instance.Sucursal;
                                        }
                                    }
                                    else
                                    {
                                        mensajeFinal = "No se pudo Continuar. El Agente ingresado no posee Autorización para la Compañía Actual: " + ENTITY_GLOBAL.Instance.Compania;
                                    }
                                }
                            }
                            else
                            {
                                mensajeFinal = "No se pudo Continuar. Necesita ingresar con un Agente asociado a un Empleado.";
                            }
                        }
                        else
                        {
                            mensajeFinal = "No se pudo Continuar. Necesita ingresar con un Agente del tipo 'Usuario'.";
                        }
                    }
                    else
                    {
                        mensajeFinal = "No se pudo hallar usuario con el nombre o clave especificados";
                    }

                    if (validoLogin)
                    {
                        if (campoEvento != null)
                        {
                            /***SET NUEVOS*/
                            //ENTITY_GLOBAL.Instance.OPc
                            ENTITY_GLOBAL.Instance.PERFILACTUAL = objUsuario.Descripcion;//debe ser el perfil por defecto
                            //ENTITY_GLOBAL.Instance.APPCODIGO = "WA";//¿?
                            ENTITY_GLOBAL.Instance.CODPERSONA = objUsuario.IdEmpleado;
                            ENTITY_GLOBAL.Instance.IDAGENTE = objUsuario.IdAgente;
                            //ADD  __/09/15
                            ENTITY_GLOBAL.Instance.TIPOAGENTE = objUsuario.TipoAgente; //ADD

                            Session["TIPOTRABAJADOR_ACTUAL"] = objUsuario.tipotrabajador; //ADD
                            ENTITY_GLOBAL.Instance.USUARIO = objUsuario.CodigoAgente.Trim().ToUpper(); //ADD
                            /////////////////// 
                            /***********/
                            var campo = this.GetCmp<TextField>("" + campoEvento);
                            campo.SetValue("ACTIVO");

                            var win = this.GetCmp<Window>("" + idWindow);
                            win.Close();
                        }
                        if (MODO != "FINALIZAR")
                        {
                            return showMensajeNotify("Autenticación Correcta", mensajeFinal, "INFO");
                            //if (ENTITY_GLOBAL.Instance.IDEMPLEADO_GENERICO == 0 && MODO!="ABRIR")
                            //{
                            //    return JavaScript("LoadVisitas('TODOS');");
                            //}else{
                            //    return showMensajeNotify("Autenticación Correcta", mensajeFinal, "INFO");
                            //}

                        }

                    }
                    else
                    {
                        UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
                        /*
                        var campo = this.GetCmp<TextField>("txtRecepcionaErrorAutentic" );
                        campo.SetValue("INACTIVO");
                        */
                        List<ENTITY_MENSAJES> listaMensajes = new List<ENTITY_MENSAJES>();
                        listaMensajes.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensajeFinal,
                            IDCOMPONENTE = "CodigoFormatoPadre",
                            NIVEL = 1
                        });
                        return showMensajeBotton(listaMensajes, "Error", "ERROR");
                        //return showMensajeBox(mensajeFinal,"Error al acceder", "ERROR", "");

                    }
                }
                catch (Exception ex)
                {
                    Log.Information("BandejaMedicoController - autenticacion_Usuario - Entrar");
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

            return this.Direct();
        }

        public List<VW_ATENCIONPACIENTE> obtenerFlatPrincipal(int IdEmpleadoSalud, string CodigoOA)
        {
            Log.Information("BandejaMedicoController - obtenerFlatPrincipal - Entrar");
            Log.Debug("BandejaMedicoController - obtenerFlatPrincipal - IdEmpleadoSalud {A}, CodigoOA {B}"
                                    , IdEmpleadoSalud, CodigoOA);
            var objModel = new VW_ATENCIONPACIENTE();
            List<VW_ATENCIONPACIENTE> lista = new List<VW_ATENCIONPACIENTE>();
            objModel.Accion = "LISTARFLAT";
            objModel.IdPersonalSalud = IdEmpleadoSalud;
            objModel.CodigoOA = CodigoOA;
            lista = SvcVw_AtencionPaciente.listarVwAtencionPaciente(objModel, 0, 0);
            return lista;

        }

        public System.Web.Mvc.ActionResult obtenerComboSeguridadTxt(string paramStr01, string paramStr02,
            string paramInt01, string usuario, string Accion)
        {
            Log.Information("BandejaMedicoController - obtenerComboSeguridadTxt - Entrar");
            Log.Debug("BandejaMedicoController - obtenerComboSeguridadTxt - paramStr01 {A}, paramStr02 {B},paramInt01 {C},usuario {D},Accion {E}"
                                    , paramStr01, paramStr02, paramInt01, usuario, Accion);
            int valor = Convert.ToInt32(paramInt01);
            return this.Store(SoluccionSalud.Service.MiscelaneosService.
                SvcMiscelaneos.comboModelGenerico.GetComboSeguridadTxt(Accion, paramStr01, paramStr02, valor));
        }
        public System.Web.Mvc.ActionResult obtenerComboEspecialidad(
            string paramIdEspecialidad, string usuario, string Accion)
        {
            Log.Information("BandejaMedicoController - obtenerComboEspecialidad - Entrar");
            Log.Debug("BandejaMedicoController - obtenerComboEspecialidad - paramIdEspecialidad {A}, usuario {B},Accion {C}"
                                    , paramIdEspecialidad, usuario, Accion);
            int valor = Convert.ToInt32(getValorFiltroInt(paramIdEspecialidad));
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = usuario;//AUX  CODIGO AGENTE

            List<SS_GE_Especialidad> listaEspecialidad = new List<SS_GE_Especialidad>();
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            }
            else
            {
                listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            }

            if (listaEspecialidad.Count == 1)
            {
                ENTITY_GLOBAL.Instance.VALOR_ESPECIALIDAD = listaEspecialidad[0].IdEspecialidad;
            }
            else { ENTITY_GLOBAL.Instance.VALOR_ESPECIALIDAD = null; }

            return this.Store(listaEspecialidad);
        }

        //Agregado Rafael
        public System.Web.Mvc.ActionResult updateIdEspcLogin(SG_Agente objSave, Nullable<int> idEspecialidad)
        {
            Log.Information("BandejaMedicoController - updateIdEspcLogin - Entrar");
            Log.Debug("BandejaMedicoController - updateIdEspcLogin - objSave {A}"
                                    , objSave);

            if (idEspecialidad.HasValue)
            {
                objSave.IdCodigo = idEspecialidad;
            }

            return this.Direct();
        }

        public System.Web.Mvc.ActionResult EstaSeguroFinalizar()
        {
            X.Msg.Confirm("", new MessageBoxConfig
            {
                Title = "Episodio de Atención",
                Message = "Esta seguro de <br />finalizar el Episodio Clínico?",
                Buttons = MessageBox.Button.YESNOCANCEL,
                Icon = MessageBox.Icon.QUESTION,
                Fn = new JFunction { Fn = "showResult" },
                AnimEl = this.GetCmp<Button>("FinalEpisodio").ClientID
            });

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult SelectPaciente(String selection)
        {
            Log.Information("BandejaMedicoController - SelectPaciente - Entrar");
            Log.Debug("BandejaMedicoController - SelectPaciente - selection {A}}", selection);
            ENTITY_GLOBAL.Instance.EpisodioClinico = null;
            ENTITY_GLOBAL.Instance.EpisodioAtencion = null;
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = null;
            ENTITY_GLOBAL.Instance.MODULO = "HC";
            //ENTITY_GLOBAL.Instance.NIVEL = 1;
            List<PERSONAMAST> ObjListar = (List<PERSONAMAST>)Newtonsoft.Json.JsonConvert.DeserializeObject(selection, typeof(List<PERSONAMAST>));
            ENTITY_GLOBAL.Instance.PacienteID = ObjListar[0].Persona;
            if (ObjListar[0].IndicadorFallecido > 0)
            {
                ENTITY_GLOBAL.Instance.EpisodioClinico = ObjListar[0].IndicadorFallecido;
                ENTITY_GLOBAL.Instance.EpisodioAtencion = ObjListar[0].IndicadorSinCorreo;
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
            }
            return this.Direct();
        }

        /***/
        public System.Web.Mvc.ActionResult eventoFirmaActoMedicoRegistro(String MODO, String idpaciente, String codigooa, String paciente, String idEpiAtencion, String EpiAtencion, String episodioclinico, String codigoepisodioatencion)
        {
            Log.Information("BandejaMedicoController - eventoFirmaActoMedicoRegistro - Entrar");
            Log.Debug("BandejaMedicoController - eventoFirmaActoMedicoRegistro - MODO {A}, idpaciente {B}, codigooa {C}, paciente {D} ,idEpiAtencion {E}, EpiAtencion {F}" +
                                        ",episodioclinico {G}, codigoepisodioatencion {H}"
                                    , MODO, idpaciente, codigooa, paciente, idEpiAtencion, EpiAtencion, episodioclinico, codigoepisodioatencion);

            /****************************************************/

            SS_HC_EpisodioAtencion objEpisodio = new SS_HC_EpisodioAtencion();
            if (MODO == "UPDATE" || MODO == "DELETE" || MODO == "VER")
            {
                try
                {
                    objEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    objEpisodio.IdPaciente = Convert.ToInt32(idpaciente);
                    objEpisodio.EpisodioClinico = Convert.ToInt32(episodioclinico);
                    objEpisodio.IdEpisodioAtencion = Convert.ToInt32(EpiAtencion);
                    objEpisodio.Accion = "LISTARPORID";

                    List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(objEpisodio, 0, 0);
                    ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                    ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                    if (listaEpi != null)
                    {
                        foreach (var result in listaEpi)
                        {
                            objEpisodio = result;
                        }
                    }
                    //string nombre = (string)Session["NOMBREPACIENTE_HEAD"];
                    //int longitud = nombre.Length;
                    objEpisodio.Accion = MODO;
                    objEpisodio.idMedicoFirma = ENTITY_GLOBAL.Instance.CODPERSONA;
                    //objEpisodio.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                    objEpisodio.CodigoOA = codigooa; // cambio 2019/01/03 jordan Mateo 
                    objEpisodio.Version = paciente;

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
                    }
                }
                catch (Exception ex)
                {
                    Log.Information("BandejaMedicoController - eventoFirmaActoMedicoRegistro - Bloque Catch");
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

            objEpisodio.Accion = MODO;
            var episodio = Convert.ToInt32(episodioclinico);
            // var idOpcion = "3002";

            List<SS_CHE_VistaSeguridad> serviceResuls = new List<SS_CHE_VistaSeguridad>();
            SS_CHE_VistaSeguridad entidaLocal = new SS_CHE_VistaSeguridad();
            entidaLocal.Accion = "LISTAROPCIONESCAGENTEOBLIGATORIO";

            //  entidaLocal.IdFormato = idFormato;
            //  entidaLocal.IdOpcion = Convert.ToInt32(idOpcion);
            entidaLocal.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
            entidaLocal.IdOpcionPadre = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDOPCION_PADRE);
            entidaLocal.Modulo = "HC";
            //   entidaLocal.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            //entidaLocal.NivelOpcion = -2;  //FORMATOS  - OPCIONES SIN PLANTILLA

            serviceResuls = SvcSeguridadConcepto.ListarSeguridadOpcion(entidaLocal, 0, 0);

            int vari = 0;

            string formula = "";
            if (serviceResuls.Count > 0)
            {
                foreach (var result in serviceResuls)
                {

                    if (result.IndicadorObligatorio == 2)
                    {

                        var Listars = new List<V_EpisodioAtenciones>();
                        var LocalEntys = new V_EpisodioAtenciones();

                        LocalEntys.UsuarioModificacion = Convert.ToString(result.IdOpcion); //AUX para ACCION o FORM
                        LocalEntys.UsuarioCreacion = ENTITY_GLOBAL.Instance.CodigoOA; //AUX para código OA
                        //  OBS: profSalud
                        // LocalEnty.FechaModificacion = getValorFiltroDate(fechaDesde); //AUX desde
                        // LocalEnty.FechaRegistro = getValorFiltroDate(fechaHasta);  ///AUS hasta
                        LocalEntys.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        //////////////
                        LocalEntys.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        LocalEntys.EpisodioClinico = Convert.ToInt32(episodioclinico);
                        LocalEntys.IdEpisodioAtencion = Convert.ToInt32(EpiAtencion);
                        LocalEntys.IdPaciente = Convert.ToInt32(idpaciente);
                        LocalEntys.Formato_Codigo = Convert.ToString(result.CodigoFormato);


                        LocalEntys.Codigo002 = Convert.ToString(result.IdOpcion);
                        //  LocalEntys.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                        LocalEntys.Accion = "LISTARPAGOBLIGATORIO";


                        int cantElementos = 0;
                        Listars = SvcV_EpisodioAtenciones.ListarV_EpisodioAtenciones(LocalEntys, 0, 10);
                        if (Listars.Count == 0)
                        {
                            vari++;
                            formula = result.Descripcion + ' ' + "<br/>" + ' ' + formula + ' ';
                        }

                    }
                }
            }

            if (vari > 0)
            {
                return showMensajeBox("" + " " + "Existen formularios Obligatorios que no contienen registros :" + "<br/>" + "\n" + "\r\n" + "\r\n" + formula + " " + " ",
                "Advertencia", "WARNING");
            }

            var LocalEnty = new MA_MiscelaneosDetalle();
            var Listar = new List<MA_MiscelaneosDetalle>();

            LocalEnty.ACCION = "DIAGNOSTICOFE";
            LocalEnty.ValorCodigo1 = Convert.ToInt32(idpaciente).ToString().Trim();
            LocalEnty.ValorCodigo2 = Convert.ToInt32(episodioclinico).ToString().Trim();
            LocalEnty.ValorCodigo3 = Convert.ToInt32(EpiAtencion).ToString().Trim();
            LocalEnty.ValorCodigo5 = ENTITY_GLOBAL.Instance.UnidadReplicacion.ToString().Trim();
            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
            Listar = SvcMiscelaneos.GetUpListadoServicios(LocalEnty).ToList();

            if (episodio == null)
            {
                return showMensajeBox("Debe Asignar un Episodio.",
                  "Advertencia", "WARNING");

            }
            else if (Listar.Count <= 0
               )
            {

                return showMensajeBox("Debe Asignar Diagnóstico.",
                 "Advertencia", "WARNING");
            }
            return crearWindowRegistro("Procesos/FirmarActoMedico", objEpisodio, "");
        }


        public System.Web.Mvc.ActionResult save_anularAltaMedicaTriaje(string obj, String MODO, String idWindow, String password, String txtusuario)
        {
            try
            {
                Log.Information("BandejaMedicoController - save_anularAltaMedica - Entrar");
                //Log.Debug("BandejaMedicoController - save_anularAltaMedica - obj {A}, MODO {B}, idWindow {C}, password {D} ,txtusuario {E}"
                // , obj, MODO, idWindow, password, txtusuario);
                /****************************************************/
                var Listar = new List<SG_Agente>();

                SG_Agente objUsuario = new SG_Agente();
                DataTable dtAgente = new DataTable();
                objUsuario.ACCION = "VALIDARLOGIN";
                objUsuario.CodigoAgente = txtusuario;
                objUsuario.Clave = password;
                String accion = "";
                String message = "";
                String tipoMsg = "INFO";
                String tituloMsg = "Mensaje";
                Boolean indicaValidacionForm = false;

                string INDADL = "";
                string ADDOMAIN = "";
                string USUARIORED = "";


                if (obj == null)
                {
                    return showMensajeNotify("Advertencia", "Debe ingresar el motivo de anulación.", "ERROR");
                }

                DataTable dtValida = new DataTable();
                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                WsEpisodio.SecuenciaHCE = txtusuario.Trim().ToUpper();
                WsEpisodio.UsuarioCreacion = "ADDOMAINWE";
                dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                if (dtValida != null)
                {
                    if (dtValida.Rows.Count > 0)
                    {
                        foreach (DataRow intobj in dtValida.AsEnumerable())
                        {
                            INDADL = intobj["IndicadorValidarUsuarioRed"].ToString();
                            ADDOMAIN = intobj["NombreDominioRed"].ToString();
                            USUARIORED = intobj["UsuarioRed"].ToString();
                        }
                        try
                        {
                            if (INDADL == "2" || INDADL == "S")
                            {
                                if (ADDOMAIN.Length > 0)
                                {
                                    if (USUARIORED.Length > 0)
                                    {
                                        LdapConnection connection = new LdapConnection(ADDOMAIN);
                                        NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper() /*+ "@" + dominio*/, password);
                                        connection.Credential = credential;
                                        connection.Bind();

                                    }
                                    else
                                    {
                                        return showMensajeNotify("Error al acceder", "No cuenta con el UsuarioRed en el AD..", "ERROR", "Asignarlo en el ERP");
                                    }
                                }
                                else
                                {
                                    return showMensajeNotify("Error al acceder", "No cuenta con el Dominio ASignado para el AD..", "ERROR", "Asignarlo en el ERP");
                                }
                            }
                        }
                        catch (LdapException lexc)
                        {
                            // Manejar errores específicos de LDAP
                            //string errorMessage = InterpretLdapError(lexc);
                            string errorMessage = Newtonsoft.Json.JsonConvert.SerializeObject(lexc.ServerErrorMessage);
                            Log.Information("Login - ServerErrorMessage");
                            Log.Debug(errorMessage);

                            string[] cadArray = errorMessage.Trim().Split(',');
                            string msj = cadArray[2];
                            Log.Information("Login - Message[]");
                            Log.Debug(msj);

                            //string errorMessage;
                            switch (msj)
                            {
                                case " data 52e": // Invalid credentials
                                    errorMessage = "Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.";
                                    break;
                                case " data 525": // User not found
                                    errorMessage = "Usuario no encontrado (525).";
                                    break;
                                case " data 530": // Not permitted to logon at this time
                                    errorMessage = "No se permite iniciar sesión en este momento (530). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 532": // Password expired
                                    errorMessage = "La Contraseña ha caducado (532). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 533": // Account disabled
                                    errorMessage = "La Cuenta esta deshabilitada (533). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 701": // Account expired
                                    errorMessage = "Cuenta expirada (701). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 773": // User must reset password
                                    errorMessage = "El usuario debe restablecer su contraseña (773). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 775": // User account locked
                                    errorMessage = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";
                                    break;
                                default:
                                    errorMessage = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                                    break;
                            }
                            return showMensajeNotify("Error al acceder", errorMessage, "ERROR", "REINICIAR");
                        }
                        catch (Exception ex)
                        {
                            //ex.Message;
                            Log.Information("Exception - Login");
                            Log.Debug(Newtonsoft.Json.JsonConvert.SerializeObject(ex));
                        }
                    }
                    else
                    {
                        Log.Information("LdapConnection - Login");
                        return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                    }
                }
                else
                {
                    Log.Information("LdapConnection - Login");
                    return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                }


                int VALORRRR = 0;
                VALORRRR = 1;

                if (VALORRRR == 1)
                {
                    if (obj != null)
                    {
                        if (obj.Length > 300) return showMensajeNotify("Error al acceder", "El campo Observaciones solo admite 300 caracteres.", "ERROR");
                    }
                    if (INDADL == "2" || INDADL == "S")
                    {
                        objUsuario.ACCION = "VALIDARADDOMAIN";
                        objUsuario.CodigoAgente = txtusuario.Trim().ToUpper();
                        Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                        foreach (SG_Agente objEntity in Listar)
                        {
                            //objUsuario = objEntity;
                            password = objEntity.Clave;
                        }
                    }

                    objUsuario.ACCION = "VALIDARLOGIN";
                    objUsuario.CodigoAgente = txtusuario.Trim().ToUpper();
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

                    if (validoLogin)
                    {
                        if (objUsuario.tipotrabajador != "02")
                        {
                            return showMensajeNotify("Información", "La anulación es válido solo para usuario enfermera.", "ERROR");
                        }
                        /****************************************************/
                        List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                        long idResultado = 0;


                        if (obj != null || obj != "")
                        {
                            ////VALIDACIÓN
                            //objTipoAtencion.Accion = MODO;
                            //msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objTipoAtencion, UTILES_MENSAJES.FORM_MSTTIPOATENCION);
                            if (msgNoValido.Count > 0)
                            {
                                message = msgNoValido[0].DESCRIPCION;
                                tipoMsg = "WARNING";
                                tituloMsg = "Advertencia";
                                indicaValidacionForm = true;
                            }
                            else
                            {
                                SS_HC_EpisodioTriaje ObjTrace = new SS_HC_EpisodioTriaje();
                                ObjTrace.Accion = "ANULAR_EPISODIOTRIAJE";
                                ObjTrace.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioTriaje);
                                ObjTrace.Estado = 4;
                                ObjTrace.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                idResultado = SvcEpisodioTriaje.UpdateEspecialidadTriaje(ObjTrace);

                                //////////////////////FINAL
                                if (idResultado > 0)
                                {
                                    message = "Se guardaron los cambios satisfactoriamente.";

                                }
                                else
                                {
                                    tipoMsg = "ERROR";
                                    message = "No se pudieron guardar los cambios. Sucedio un error en la operación.";
                                    tituloMsg = "Error";
                                }
                            }
                        }
                        else
                        {
                            tipoMsg = "ERROR";
                            message = "No se pudieron guardar los cambios. No se recibió el objeto vinculado.";
                            tituloMsg = "Error";
                        }
                        //obj.Accion = "INFO";
                        return JavaScript("InicioMedico('" + message + "')");

                    }
                    else
                        return showMensajeNotify("Error al acceder", "La contraseña es incorrecta.", "ERROR");

                }
                else
                {
                    return showMensajeNotify("Error al acceder", "El Usuario ingresado no es el médico principal de la atención.", "ERROR");
                }

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_anularAltaMedica - Bloque Catch");
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

        public System.Web.Mvc.ActionResult save_anularAltaMedica(SS_HC_EpisodioAtencion obj, String MODO, String idWindow, String password, String txtusuario)
        {
            try
            {
                Log.Information("BandejaMedicoController - save_anularAltaMedica - Entrar");
                Log.Debug("BandejaMedicoController - save_anularAltaMedica - obj {A}, MODO {B}, idWindow {C}, password {D} ,txtusuario {E}"
                                        , obj, MODO, idWindow, password, txtusuario);
                /****************************************************/
                var Listar = new List<SG_Agente>();
                //USUARIO objUsuario = new USUARIO();
                SG_Agente objUsuario = new SG_Agente();
                objUsuario.ACCION = "VALIDARLOGIN";
                objUsuario.CodigoAgente = txtusuario;
                objUsuario.Clave = password;
                String accion = "";
                String message = "";
                String tipoMsg = "INFO";
                String tituloMsg = "Mensaje";
                Boolean indicaValidacionForm = false;
                if (obj.ObservacionProxima == null)
                {
                    return showMensajeNotify("Advertencia", "Debe ingresar el motivo de anulación.", "ERROR");
                }
                int VALORRRR = 0;
                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                {
                    if (ENTITY_GLOBAL.Instance.USUARIO_EMERG.ToUpper() == txtusuario.ToUpper())
                    {
                        VALORRRR = 1;

                    }
                }
                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO")
                {
                    if (ENTITY_GLOBAL.Instance.USUARIO.ToUpper() == txtusuario.ToUpper())
                    {
                        VALORRRR = 1;
                    }
                }
                if (VALORRRR == 1)
                {

                    var obseFirma = obj.ObservacionFirma;
                    if (obseFirma != null)
                    {
                        if (obseFirma.Length > 300) return showMensajeNotify("Error al acceder", "El campo Observaciones solo admite 300 caracteres.", "ERROR");
                    }
                    string INDADL = "";
                    string ADDOMAIN = "";
                    string USUARIORED = "";
                    DataTable dtValida = new DataTable();
                    HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                    HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                    WsEpisodio.SecuenciaHCE = txtusuario.Trim().ToUpper();
                    WsEpisodio.UsuarioCreacion = "ADDOMAINWE";
                    dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                    if (dtValida != null)
                    {
                        if (dtValida.Rows.Count > 0)
                        {
                            foreach (DataRow intobj in dtValida.AsEnumerable())
                            {
                                INDADL = intobj["IndicadorValidarUsuarioRed"].ToString();
                                ADDOMAIN = intobj["NombreDominioRed"].ToString();
                                USUARIORED = intobj["UsuarioRed"].ToString();
                            }
                            try
                            {
                                if (INDADL == "2" || INDADL == "S")
                                {
                                    if (ADDOMAIN.Length > 0)
                                    {
                                        if (USUARIORED.Length > 0)
                                        {
                                            //List<ParametrosMast> listaParam = new List<ParametrosMast>();
                                            //ParametrosMast objParam = new ParametrosMast();
                                            //objParam.Accion = "LISTAR";
                                            //objParam.CompaniaCodigo = "999999";
                                            //objParam.AplicacionCodigo = "WA";//obs              
                                            //listaParam = SvcParametro.listarParametro(objParam, 0, 0);

                                            LdapConnection connection = new LdapConnection(ADDOMAIN);
                                            NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper() /*+ "@" + dominio*/, password);
                                            connection.Credential = credential;
                                            connection.Bind();


                                        }
                                        else
                                        {
                                            return showMensajeNotify("Error al acceder", "No cuenta con el UsuarioRed en el AD..", "ERROR", "Asignarlo en el ERP");
                                        }
                                    }
                                    else
                                    {
                                        return showMensajeNotify("Error al acceder", "No cuenta con el Dominio ASignado para el AD..", "ERROR", "Asignarlo en el ERP");
                                    }
                                }
                            }
                            catch (LdapException lexc)
                            {
                                // Manejar errores específicos de LDAP
                                //string errorMessage = InterpretLdapError(lexc);
                                string errorMessage = Newtonsoft.Json.JsonConvert.SerializeObject(lexc.ServerErrorMessage);
                                Log.Information("Login - ServerErrorMessage");
                                Log.Debug(errorMessage);

                                string[] cadArray = errorMessage.Trim().Split(',');
                                string msj = cadArray[2];
                                Log.Information("Login - Message[]");
                                Log.Debug(msj);

                                //string errorMessage;
                                switch (msj)
                                {
                                    case " data 52e": // Invalid credentials
                                        errorMessage = "Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.";
                                        break;
                                    case " data 525": // User not found
                                        errorMessage = "Usuario no encontrado (525).";
                                        break;
                                    case " data 530": // Not permitted to logon at this time
                                        errorMessage = "No se permite iniciar sesión en este momento (530). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 532": // Password expired
                                        errorMessage = "La Contraseña ha caducado (532). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 533": // Account disabled
                                        errorMessage = "La Cuenta esta deshabilitada (533). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 701": // Account expired
                                        errorMessage = "Cuenta expirada (701). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 773": // User must reset password
                                        errorMessage = "El usuario debe restablecer su contraseña (773). Contáctese con Mesa de Ayuda.";
                                        break;
                                    case " data 775": // User account locked
                                        errorMessage = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";
                                        break;
                                    default:
                                        errorMessage = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                                        break;
                                }
                                return showMensajeNotify("Error al acceder", errorMessage, "REINICIAR");
                            }
                            catch (Exception ex)
                            {
                                //ex.Message;
                                Log.Information("Exception - Login");
                                Log.Debug(Newtonsoft.Json.JsonConvert.SerializeObject(ex));
                            }
                        }
                        else
                        {
                            Log.Information("LdapConnection - Login");
                            return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                        }
                    }
                    else
                    {
                        Log.Information("LdapConnection - Login");
                        return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                    }

                    if (INDADL == "2" || INDADL == "S")
                    {
                        objUsuario.ACCION = "VALIDARADDOMAIN";
                        objUsuario.CodigoAgente = txtusuario.Trim().ToUpper();
                        Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                        foreach (SG_Agente objEntity in Listar)
                        {
                            password = objEntity.Clave;
                        }
                    }

                    objUsuario.ACCION = "VALIDARLOGIN";
                    objUsuario.CodigoAgente = txtusuario.Trim().ToUpper();
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
                    //if (objUsuario != null)
                    //{
                    //}
                    if (validoLogin)
                    {
                        /****************************************************/
                        List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                        long idResultado = 0;


                        if (obj != null)
                        {
                            ////VALIDACIÓN
                            //objTipoAtencion.Accion = MODO;
                            //msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objTipoAtencion, UTILES_MENSAJES.FORM_MSTTIPOATENCION);
                            if (msgNoValido.Count > 0)
                            {
                                message = msgNoValido[0].DESCRIPCION;
                                tipoMsg = "WARNING";
                                tituloMsg = "Advertencia";
                                indicaValidacionForm = true;
                            }
                            else
                            {
                                if (MODO == "NUEVO")
                                {
                                    obj.Accion = "INSERT";
                                    accion = "registró";
                                }
                                else if (MODO == "UPDATE")
                                {
                                    obj.Accion = "UPDATE";
                                    accion = "modificó";
                                }
                                else if (MODO == "DELETE")
                                {
                                    obj.Accion = "DELETE";
                                    accion = "eliminó";
                                }
                                else
                                {
                                    tipoMsg = "WARNING";
                                    message = "No se encontró el MODO.";
                                    tituloMsg = "Advertencia";
                                }
                                try
                                {
                                    //objCuerpo.Estado = Convert.ToInt32(objCuerpo.UsuarioModificacion);
                                }
                                catch (Exception e)
                                {
                                    X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                                }
                                /////registro
                                obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                obj.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                obj.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                obj.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                obj.EpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion; //ADD 05.06.2017 OES Motivo: Modificacion en continuar episodio
                                obj.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                                obj.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                obj.ObservacionProxima = idWindow == "ANULAROA" ? obj.ObservacionProxima : null;
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_HOSP_CIRUGIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                                {
                                    obj.TipoAtencion = 3;
                                    // if (ENTITY_GLOBAL.Instance.INDICADOR_HOSPI == 3) { 
                                    //     obj.IdUbicacion = 1; 
                                    //  }

                                    SS_HC_EpisodioAtencion obj2 = new SS_HC_EpisodioAtencion();
                                    obj2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    obj2.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                                    obj2.Accion = "VALIDA_ALTA";
                                    var result = SvcEpisodioAtencion.setMantenimiento(obj2);

                                    if (result != 0)
                                    {
                                        obj.IdUbicacion = 1;
                                    }


                                    // obj.IdUbicacion = 1; // indicador para cerrar la atencion
                                }

                                //obj.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;                            
                                obj.FechaFirma = DateTime.Now;
                                if (idWindow == "ANULAROA")
                                {
                                    obj.Accion = "ANULAROA";
                                    obj.idMedicoFirma = Listar[0].IdEmpleado;
                                    if (ENTITY_GLOBAL.Instance.INDICADOR_INTERCONSULTA == 3)
                                    {
                                        obj.Version = ENTITY_GLOBAL.Instance.SECUENCIAL_HCE;
                                    }


                                    List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                    int idResultados = 0;
                                    int registro = -1;
                                    var objGenral = new SS_HCE_ConsultaExterna();
                                    objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                    objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                    objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                    objGenral.Medico = Listar[0].IdEmpleado;
                                    objGenral.TipoOrdenMedica = ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO" ? 1 : 2;
                                    objGenral.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objGenral.Accion = "ANULAROA";

                                    idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);

                                    if (idResultados > 0)
                                    {
                                        SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                                        objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                        objEpClinico.UsuarioCreacion = ENTITY_GLOBAL.Instance.CodigoOA;
                                        objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                        objEpClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                        objEpClinico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                        objEpClinico.ACCION = "ANULAROA";

                                        registro = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                                    }

                                }
                                else if (idWindow == "ANULARALTA")
                                {

                                    List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                    int idResultados = 0;
                                    int registro = -1;
                                    var objGenral = new SS_HCE_ConsultaExterna();
                                    objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                    objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                    objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                    objGenral.Medico = Listar[0].IdEmpleado;
                                    objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objGenral.Accion = "ANULARALTA";

                                    var timeout = SetTimeout(() =>
                                    {
                                        idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                    }, 3000);


                                    SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                                    objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    objEpClinico.UsuarioCreacion = ENTITY_GLOBAL.Instance.CodigoOA;
                                    objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objEpClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    objEpClinico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    objEpClinico.ACCION = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso" ? "ANULARREINGRESO" : "ANULARALTA";

                                    idResultado = SvcEpisodioClinico.setMantenimiento(objEpClinico);

                                }

                                if (idWindow != "ANULARALTA")
                                {
                                    idResultado = SvcEpisodioAtencion.setMantenimiento(obj);
                                }


                                /******ADD PARA INTEROPERABILIDAD***/
                                try
                                {
                                    if (idWindow != "ANULAROA")
                                    {
                                        //HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                        string valor = "";
                                        int IdEp = Convert.ToInt32(obj.IdEpisodioAtencion);
                                        valor = ObtenerTramaOA.InterOperabilidadSalida(obj.UnidadReplicacion, IdEp, obj.IdPaciente, obj.EpisodioClinico).ToString();

                                        if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                                        {
                                            if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Procedimiento")
                                            {
                                                int idResultadoProc = 0;
                                                var objGenralProc = new SS_HCE_ConsultaExterna();
                                                objGenralProc.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                                objGenralProc.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                                objGenralProc.Accion = "FIRMA_PROC";

                                                var timeout = SetTimeout(() =>
                                                {
                                                    idResultadoProc = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralProc);


                                                }, 3000);
                                            }


                                            var LocalEnty = new SS_HC_EvolucionMedica_FE();
                                            var ListarData = new List<SS_HC_EvolucionMedica_FE>();
                                            LocalEnty.Accion = "LISTAR";
                                            LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                            LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                            LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                            LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                            LocalEnty.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;

                                            ListarData = SvcEvolucionObjetivaFEService.listarSS_HC_EvolucionObjetiva(LocalEnty);
                                            if (ListarData.Count > 0)
                                            {
                                                int idResultadosEvo = 0;
                                                var objGenral = new SS_HCE_ConsultaExterna();
                                                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                                objGenral.UsuarioModificacion = ListarData[0].EvolucionObjetiva;
                                                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                                objGenral.TipoOrdenMedica = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo" ? 1 : 0;
                                                objGenral.Accion = "EVO_OBJETIVO";
                                                // Establish timer settings. 
                                                var timeout = SetTimeout(() =>
                                                {
                                                    idResultadosEvo = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                                    Console.WriteLine("Will be run in 2 seconds if timeout is not cleared...");

                                                }, 4000);
                                            }
                                        }
                                    }

                                }
                                catch (Exception ex)
                                {
                                    Log.Information("BandejaMedicoController - save_anularAltaMedica - Bloque Catch");
                                    Log.Error(ex, ex.Message);

                                }
                                //////////////////////FINAL
                                if (idResultado > 0)
                                {
                                    message = "Se guardaron los cambios del Acto médico, satisfactoriamente.";

                                }
                                else
                                {
                                    tipoMsg = "ERROR";
                                    message = "No se pudieron guardar los cambios. Sucedio un error en la operación.";
                                    tituloMsg = "Error";
                                }
                            }
                        }
                        else
                        {
                            tipoMsg = "ERROR";
                            message = "No se pudieron guardar los cambios. No se recibió el objeto vinculado.";
                            tituloMsg = "Error";
                        }
                        obj.Accion = "INFO";
                        return JavaScript("InicioMedico('" + message + "')");

                    }
                    else
                        return showMensajeNotify("Error al acceder", "La contraseña es incorrecta.", "ERROR");

                }
                else
                {
                    return showMensajeNotify("Error al acceder", "El Usuario ingresado no es el médico principal de la atención.", "ERROR");
                }

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_anularAltaMedica - Bloque Catch");
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
                // string mostrarExc = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                string mostrarExc = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";

                if (resultado.Count > 0)
                {
                    mostrarExc = resultado[0].DescripcionLocal;
                }
                return showMensajeNotifyData("Error al acceder", mostrarExc, "ERROR", true);
                throw;
            }

        }

        public System.Web.Mvc.ActionResult save_FirmaActosMedicos(SS_HC_EpisodioAtencion obj, String MODO, String idWindow, String password)
        {
            Log.Information("BandejaMedicoController - save_FirmaActosMedicos - Entrar");
            Log.Debug("BandejaMedicoController - save_FirmaActosMedicos - obj {A}, MODO {B}, idWindow {C}, password {D}"
                                    , obj, MODO, idWindow, password);
            try
            {
                /****************************************************/
                var Listar = new List<SG_Agente>();
                //USUARIO objUsuario = new USUARIO();
                SG_Agente objUsuario = new SG_Agente();
                objUsuario.ACCION = "VALIDARLOGIN";
                objUsuario.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                objUsuario.Clave = password;
                String accion = "";
                String message = "";
                String tipoMsg = "INFO";
                String tituloMsg = "Mensaje";
                Boolean indicaValidacionForm = false;
                long validadoralta = 0;
                string INDADL = "";
                string ADDOMAIN = "";
                string USUARIORED = "";
                var obseFirma = obj.ObservacionFirma;
                if (obseFirma != null)
                {
                    if (obseFirma.Length > 300) return showMensajeNotify("Error al acceder", "El campo Observaciones solo admite 300 caracteres.", "ERROR");
                }

                DataTable dtValida = new DataTable();
                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                WsEpisodio.SecuenciaHCE = ENTITY_GLOBAL.Instance.USUARIO.Trim().ToUpper();
                WsEpisodio.UsuarioCreacion = "ADDOMAINWE";
                dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                if (dtValida != null)
                {
                    if (dtValida.Rows.Count > 0)
                    {
                        foreach (DataRow intobj in dtValida.AsEnumerable())
                        {
                            INDADL = intobj["IndicadorValidarUsuarioRed"].ToString();
                            ADDOMAIN = intobj["NombreDominioRed"].ToString();
                            USUARIORED = intobj["UsuarioRed"].ToString();
                        }
                        try
                        {
                            if (INDADL == "2" || INDADL == "S")
                            {
                                if (ADDOMAIN.Length > 0)
                                {
                                    if (USUARIORED.Length > 0)
                                    {
                                        LdapConnection connection = new LdapConnection(ADDOMAIN);
                                        NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper() /*+ "@" + dominio*/, password);
                                        connection.Credential = credential;
                                        connection.Bind();

                                    }
                                    else
                                    {
                                        return showMensajeNotify("Error al acceder", "No cuenta con el UsuarioRed en el AD..", "ERROR");
                                    }
                                }
                                else
                                {
                                    return showMensajeNotify("Error al acceder", "No cuenta con el Dominio ASignado para el AD..", "ERROR", "Asignarlo en el ERP");
                                }
                            }
                        }
                        catch (LdapException lexc)
                        {
                            // Manejar errores específicos de LDAP
                            //string errorMessage = InterpretLdapError(lexc);
                            string errorMessage = Newtonsoft.Json.JsonConvert.SerializeObject(lexc.ServerErrorMessage);
                            Log.Debug("save_FirmaActosMedicos ::" + errorMessage);

                            string[] cadArray = errorMessage.Trim().Split(',');
                            string msj = cadArray[2];
                            Log.Debug(msj);

                            //string errorMessage;
                            switch (msj)
                            {
                                case " data 52e": // Invalid credentials
                                    errorMessage = "Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.";
                                    break;
                                case " data 525": // User not found
                                    errorMessage = "Usuario no encontrado (525).";
                                    break;
                                case " data 530": // Not permitted to logon at this time
                                    errorMessage = "No se permite iniciar sesión en este momento (530). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 532": // Password expired
                                    errorMessage = "La Contraseña ha caducado (532). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 533": // Account disabled
                                    errorMessage = "La Cuenta esta deshabilitada (533). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 701": // Account expired
                                    errorMessage = "Cuenta expirada (701). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 773": // User must reset password
                                    errorMessage = "El usuario debe restablecer su contraseña (773). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 775": // User account locked
                                    errorMessage = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";
                                    break;
                                default:
                                    errorMessage = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                                    break;
                            }
                            return showMensajeNotify("Error al acceder", errorMessage, "ERROR", "REINICIAR");
                        }
                        catch (Exception ex)
                        {
                            //ex.Message;
                            Log.Information("Exception - Login");
                            Log.Debug("save_FirmaActosMedicos ::" + Newtonsoft.Json.JsonConvert.SerializeObject(ex));
                        }
                    }
                    else
                    {
                        Log.Information("LdapConnection - Login");
                        return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                    }
                }
                else
                {
                    Log.Information("LdapConnection - Login");
                    return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                }

                if (INDADL == "2" || INDADL == "S")
                {
                    objUsuario.ACCION = "VALIDARADDOMAIN";
                    objUsuario.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO.Trim().ToUpper();
                    Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                    foreach (SG_Agente objEntity in Listar)
                    {
                        password = objEntity.Clave;
                    }
                }

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

                if (validoLogin)
                {
                    /****************************************************/
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    long idResultado = 0;


                    if (obj != null)
                    {
                        ////VALIDACIÓN
                        //objTipoAtencion.Accion = MODO;
                        //msgNoValido = UTILES_MENSAJES.getValidacionFormulario(objTipoAtencion, UTILES_MENSAJES.FORM_MSTTIPOATENCION);
                        if (msgNoValido.Count > 0)
                        {
                            message = msgNoValido[0].DESCRIPCION;
                            tipoMsg = "WARNING";
                            tituloMsg = "Advertencia";
                            indicaValidacionForm = true;
                        }
                        else
                        {
                            if (MODO == "NUEVO")
                            {
                                obj.Accion = "INSERT";
                                accion = "registró";
                            }
                            else if (MODO == "UPDATE")
                            {
                                obj.Accion = "UPDATE";
                                accion = "modificó";
                            }
                            else if (MODO == "DELETE")
                            {
                                obj.Accion = "DELETE";
                                accion = "eliminó";
                            }
                            else
                            {
                                tipoMsg = "WARNING";
                                message = "No se encontró el MODO.";
                                tituloMsg = "Advertencia";
                            }
                            try
                            {
                                //objCuerpo.Estado = Convert.ToInt32(objCuerpo.UsuarioModificacion);
                            }
                            catch (Exception e)
                            {
                                X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                            }
                            /////registro
                            obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                            obj.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            obj.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                            obj.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                            obj.EpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion; //ADD 05.06.2017 OES Motivo: Modificacion en continuar episodio
                            obj.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                            obj.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                            obj.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                            obj.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                            obj.ObservacionProxima = idWindow == "ANULAROA" ? obj.ObservacionProxima : null;
                            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_HOSP_CIRUGIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                            {
                                obj.TipoAtencion = 3;

                                SS_HC_EpisodioAtencion obj2 = new SS_HC_EpisodioAtencion();
                                obj2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                obj2.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                obj2.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                obj2.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                obj2.EpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion; //ADD 05.06.2017 OES Motivo: Modificacion en continuar episodio
                                obj2.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                                obj2.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;


                                obj2.Accion = "VALIDA_ALTA";
                                var result = SvcEpisodioAtencion.setMantenimiento(obj2);
                                validadoralta = result;
                                if (result != 0)
                                {
                                    obj.IdUbicacion = 1;
                                }
                            }

                            //obj.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;                            
                            obj.FechaFirma = DateTime.Now;
                            if (idWindow == "ANULAROA")
                            {
                                obj.Accion = "ANULAROA";
                                obj.idMedicoFirma = Listar[0].IdEmpleado;
                                if (ENTITY_GLOBAL.Instance.INDICADOR_INTERCONSULTA == 3)
                                {
                                    obj.Version = ENTITY_GLOBAL.Instance.SECUENCIAL_HCE;
                                }

                                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                int idResultados = 0;
                                int registro = -1;
                                var objGenral = new SS_HCE_ConsultaExterna();
                                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                objGenral.Medico = Listar[0].IdEmpleado;
                                objGenral.TipoOrdenMedica = ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO" ? 1 : 2;
                                objGenral.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                objGenral.Accion = "ANULAROA";

                                idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);

                                if (idResultados > 0)
                                {
                                    SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                                    objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    objEpClinico.UsuarioCreacion = ENTITY_GLOBAL.Instance.CodigoOA;
                                    objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objEpClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    objEpClinico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    objEpClinico.ACCION = "ANULAROA";

                                    registro = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                                }

                            }
                            else if (idWindow == "ANULARALTA")
                            {

                                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                int idResultados = 0;
                                int registro = -1;
                                var objGenral = new SS_HCE_ConsultaExterna();
                                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                objGenral.Medico = Listar[0].IdEmpleado;
                                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                objGenral.Accion = "ANULARALTA";

                                var timeout = SetTimeout(() =>
                                {
                                    idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                }, 3000);


                                SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                                objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                objEpClinico.UsuarioCreacion = ENTITY_GLOBAL.Instance.CodigoOA;
                                objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                objEpClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                objEpClinico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                objEpClinico.ACCION = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso" ? "ANULARREINGRESO" : "ANULARALTA";

                                idResultado = SvcEpisodioClinico.setMantenimiento(objEpClinico);

                            }
                            else
                            {
                                obj.Accion = "PROC_FIRMARACTO";
                                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                int idResultadoInterconsulta = 0;
                                var objGenral = new SS_HCE_ConsultaExterna();
                                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                objGenral.Medico = ENTITY_GLOBAL.Instance.CODPERSONA;
                                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                if (Listar[0].tipotrabajador == "02")
                                {
                                    var LocalEnty = new SS_HC_NotasEnfermeria_FE();
                                    var ListarEnf = new List<SS_HC_NotasEnfermeria_FE>();
                                    LocalEnty.Accion = "LISTAR";
                                    LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

                                    ListarEnf = SvcNotaEnfermeriaServiceFE.NotaEnfermeriaListar(LocalEnty).ToList();

                                    objGenral.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    if (ListarEnf.Count > 0)
                                    {
                                        objGenral.EpisodioClinico = 1;
                                        objGenral.UsuarioModificacion = ListarEnf[0].NotaEnfermeria;
                                    }
                                    else
                                    {
                                        objGenral.EpisodioClinico = 0;
                                    }

                                    objGenral.Accion = "FIRMA_ENFER";
                                }
                                //else
                                //{
                                //    objGenral.Accion = "DELETE_INTER";
                                //}

                                idResultadoInterconsulta = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                            }
                            if (idWindow != "ANULARALTA")
                            {
                                idResultado = SvcEpisodioAtencion.setMantenimiento(obj);
                            }


                            /******ADD PARA INTEROPERABILIDAD***/
                            try
                            {
                                if (idWindow != "ANULAROA")
                                {
                                    //HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                    string valor = "";
                                    int IdEp = Convert.ToInt32(obj.IdEpisodioAtencion);
                                    valor = ObtenerTramaOA.InterOperabilidadSalida(obj.UnidadReplicacion, IdEp, obj.IdPaciente, obj.EpisodioClinico).ToString();

                                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                                    {
                                        if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Procedimiento")
                                        {
                                            int idResultadoProc = 0;
                                            var objGenralProc = new SS_HCE_ConsultaExterna();
                                            objGenralProc.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            objGenralProc.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                            objGenralProc.Accion = "FIRMA_PROC";

                                            var timeout = SetTimeout(() =>
                                            {
                                                idResultadoProc = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralProc);
                                            }, 3000);
                                        }


                                        var LocalEnty = new SS_HC_EvolucionMedica_FE();
                                        var ListarData = new List<SS_HC_EvolucionMedica_FE>();
                                        LocalEnty.Accion = "LISTAR";
                                        LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                        LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                        LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                        LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                        LocalEnty.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;

                                        ListarData = SvcEvolucionObjetivaFEService.listarSS_HC_EvolucionObjetiva(LocalEnty);
                                        if (ListarData.Count > 0)
                                        {
                                            int idResultadosEvo = 0;
                                            var objGenral = new SS_HCE_ConsultaExterna();
                                            objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                            objGenral.UsuarioModificacion = ListarData[0].EvolucionObjetiva;
                                            objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                            objGenral.TipoOrdenMedica = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo" ? 1 : 0;
                                            objGenral.Accion = "EVO_OBJETIVO";
                                            var timeout = SetTimeout(() =>
                                            {
                                                idResultadosEvo = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                                Console.WriteLine("Will be run in 2 seconds if timeout is not cleared...");

                                            }, 4000);
                                        }
                                    }
                                }
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && validadoralta != 0)
                                {
                                    var LocalEntyAlta = new SS_HC_InformeAlta_FE();
                                    var ListarAlta = new List<SS_HC_InformeAlta_FE>();
                                    LocalEntyAlta.Accion = "LISTAR";
                                    LocalEntyAlta.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    LocalEntyAlta.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    LocalEntyAlta.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    LocalEntyAlta.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    ListarAlta = SvcInformeAltaFE.lista_Cabecera(LocalEntyAlta).ToList();

                                    List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                    int idResultados = 0;
                                    var objGenral = new SS_HCE_ConsultaExterna();
                                    objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                    objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                    objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objGenral.IdPaciente = ENTITY_GLOBAL.Instance.PacienteID;
                                    objGenral.Especialidad = ListarAlta.Count > 0 ? ListarAlta[0].IdEspecialidad : 1; //TIPO COBERTURA ALTA
                                    objGenral.TipoInterConsulta = ListarAlta.Count > 0 ? ListarAlta[0].IdTipoAlta : 1; //TIPO ALTA MEDICA
                                    objGenral.Accion = "ALTAMEDICA";

                                    idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);


                                    if (idResultados > 0)
                                    {
                                        if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso")
                                        {
                                            long resAlta = 0;
                                            SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                            epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            epiAtencionObjAlta.Accion = "ALTAMEDICA";
                                            epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                            resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo")
                                        {
                                            long resAlta = 0;
                                            SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                            epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            epiAtencionObjAlta.Accion = "ALTAMEDICARE";
                                            epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                            resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia")
                                        {
                                            long resAlta = 0;
                                            SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                            epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            epiAtencionObjAlta.Accion = "ALTAMEDICAEME";
                                            epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                            resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Interconsulta")
                                        {
                                            int idResultadoDerivacion = 0;
                                            var objGenralDerivacion = new SS_HCE_ConsultaExterna();
                                            objGenralDerivacion.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            objGenralDerivacion.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                            objGenralDerivacion.Accion = "DERIVACION";
                                            idResultadoDerivacion = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralDerivacion);

                                            if (idResultadoDerivacion > 0)
                                            {
                                                long resAlta = 0;
                                                SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                                epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                                epiAtencionObjAlta.Accion = "ALTAMEDICAEME";
                                                epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                                resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                            }
                                        }
                                        ENTITY_GLOBAL.Instance.INDICADOR_HOSPI = 0;
                                    }
                                }
                                else if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso" ||
                                ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia"))
                                {
                                    int idResultadoConsul = 0;
                                    var objGenralConsul = new SS_HCE_ConsultaExterna();
                                    objGenralConsul.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                    objGenralConsul.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                    objGenralConsul.Accion = "FIRMA_CONSULTA";

                                    var timeout = SetTimeout(() =>
                                    {
                                        idResultadoConsul = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralConsul);
                                    }, 3000);
                                }
                            }
                            catch (Exception ex)
                            {
                                Log.Information("BandejaMedicoController - save_FirmaActosMedicos - Bloque Catch");
                                Log.Error(ex, ex.Message);
                            }
                            //////////////////////FINAL
                            if (idResultado > 0)
                            {
                                message = "Se guardaron los cambios del Acto médico, satisfactoriamente.";
                            }
                            else
                            {
                                tipoMsg = "ERROR";
                                message = "No se pudieron guardar los cambios. Sucedio un error en la operación.";
                                tituloMsg = "Error";
                            }
                        }
                    }
                    else
                    {
                        tipoMsg = "ERROR";
                        message = "No se pudieron guardar los cambios. No se recibió el objeto vinculado.";
                        tituloMsg = "Error";
                    }
                    obj.Accion = "INFO";
                    return JavaScript("InicioMedico('" + message + "')");
                    //if (indicaValidacionForm)
                    //{
                    //    return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinal");
                    //}
                    //else
                    //{
                    //    return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
                    //    //return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinal");
                    //}

                }
                else
                    return showMensajeNotify("Error al acceder", "La contraseña es incorrecta.", "ERROR");
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_FirmaActosMedicos - Bloque Catch");
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

        public System.Web.Mvc.ActionResult save_FirmaActosMedicosTemp(SS_HC_EpisodioAtencion obj, String MODO, String idWindow, String password, String observacion, String input)
        {
            try
            {
                Log.Information("BandejaMedicoController - save_FirmaActosMedicosTemp - Entrar");
                Log.Debug("BandejaMedicoController - save_FirmaActosMedicosTemp - obj {A}, MODO {B}, idWindow {C}, password {D} ,observacion {E}"
                                        , obj, MODO, idWindow, password, observacion);
                /****************************************************/
                var Listar = new List<SG_Agente>();
                //USUARIO objUsuario = new USUARIO();
                SG_Agente objUsuario = new SG_Agente();

                String accion = "";
                String message = "";
                String tipoMsg = "INFO";
                String tituloMsg = "Mensaje";
                Boolean indicaValidacionForm = false;
                obj.ObservacionFirma = observacion;
                var obseFirma = obj.ObservacionFirma;
                //JORDAN MATEO 20220524
                long validadoralta = 0;

                if (obseFirma != null)
                {
                    if (obseFirma.Length > 300) return showMensajeNotify("Error al acceder", "El campo Observaciones solo admite 300 caracteres.", "ERROR");
                }

                string INDADL = "";
                string ADDOMAIN = "";
                string USUARIORED = "";

                DataTable dtValida = new DataTable();
                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                WsEpisodio.SecuenciaHCE = ENTITY_GLOBAL.Instance.USUARIO.Trim().ToUpper();
                WsEpisodio.UsuarioCreacion = "ADDOMAINWE";
                dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                if (dtValida != null)
                {
                    if (dtValida.Rows.Count > 0)
                    {
                        foreach (DataRow intobj in dtValida.AsEnumerable())
                        {
                            INDADL = intobj["IndicadorValidarUsuarioRed"].ToString();
                            ADDOMAIN = intobj["NombreDominioRed"].ToString();
                            USUARIORED = intobj["UsuarioRed"].ToString();
                        }
                        try
                        {
                            if (INDADL == "2" || INDADL == "S")
                            {
                                if (ADDOMAIN.Length > 0)
                                {
                                    if (USUARIORED.Length > 0)
                                    {
                                        LdapConnection connection = new LdapConnection(ADDOMAIN);
                                        NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper() /*+ "@" + dominio*/, password);
                                        connection.Credential = credential;
                                        connection.Bind();

                                    }
                                    else
                                    {
                                        return showMensajeNotify("Error al acceder", "No cuenta con el UsuarioRed en el AD..", "ERROR", "Asignarlo en el ERP");
                                    }
                                }
                                else
                                {
                                    return showMensajeNotify("Error al acceder", "No cuenta con el Dominio ASignado para el AD..", "ERROR", "Asignarlo en el ERP");
                                }
                            }
                        }
                        catch (LdapException lexc)
                        {
                            // Manejar errores específicos de LDAP
                            //string errorMessage = InterpretLdapError(lexc);
                            string errorMessage = Newtonsoft.Json.JsonConvert.SerializeObject(lexc.ServerErrorMessage);
                            Log.Information("Login - ServerErrorMessage");
                            Log.Debug(errorMessage);

                            string[] cadArray = errorMessage.Trim().Split(',');
                            string msj = cadArray[2];
                            Log.Information("Login - Message[]");
                            Log.Debug(msj);

                            //string errorMessage;
                            switch (msj)
                            {
                                case " data 52e": // Invalid credentials
                                    errorMessage = "Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.";
                                    break;
                                case " data 525": // User not found
                                    errorMessage = "Usuario no encontrado (525).";
                                    break;
                                case " data 530": // Not permitted to logon at this time
                                    errorMessage = "No se permite iniciar sesión en este momento (530). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 532": // Password expired
                                    errorMessage = "La Contraseña ha caducado (532). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 533": // Account disabled
                                    errorMessage = "La Cuenta esta deshabilitada (533). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 701": // Account expired
                                    errorMessage = "Cuenta expirada (701). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 773": // User must reset password
                                    errorMessage = "El usuario debe restablecer su contraseña (773). Contáctese con Mesa de Ayuda.";
                                    break;
                                case " data 775": // User account locked
                                    errorMessage = "Tu cuenta ha sido bloqueada debido a varios intentos fallidos. Por favor, contáctese con Mesa de Ayuda";
                                    break;
                                default:
                                    errorMessage = "No hemos podido acceder. Contáctese con Mesa de Ayuda";
                                    break;
                            }
                            return showMensajeNotify("No hemos podido acceder", errorMessage, "ERROR", "REINICIAR");
                        }
                        catch (Exception ex)
                        {
                            //ex.Message;
                            Log.Information("Exception - Login");
                            Log.Debug(Newtonsoft.Json.JsonConvert.SerializeObject(ex));
                        }
                    }
                    else
                    {
                        Log.Information("LdapConnection - Login");
                        return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                    }
                }
                else
                {
                    Log.Information("LdapConnection - Login");
                    return showMensajeNotify("Error al acceder", "No hemos podido acceder. Contáctese con Mesa de Ayuda", "ERROR", "REINICIAR");
                }

                if (INDADL == "2" || INDADL == "S")
                {
                    objUsuario.ACCION = "VALIDARADDOMAIN";
                    objUsuario.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                    Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                    foreach (SG_Agente objEntity in Listar)
                    {
                        //objUsuario = objEntity;
                        password = objEntity.Clave;
                    }
                }

                objUsuario = new SG_Agente();
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

                if (validoLogin)
                {
                    message = "Firmado exitoso";

                    /****************************************************/
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    long idResultado = 0;
                    obj.idMedicoFirma = Listar[0].IdEmpleado;
                    if (obj != null)
                    {
                        if (msgNoValido.Count > 0)
                        {
                            message = msgNoValido[0].DESCRIPCION;
                            tipoMsg = "WARNING";
                            tituloMsg = "Advertencia";
                            indicaValidacionForm = true;
                        }
                        else
                        {
                            if (MODO == "NUEVO")
                            {
                                obj.Accion = "INSERT";
                                accion = "registró";
                            }
                            else if (MODO == "UPDATE")
                            {
                                obj.Accion = "UPDATE";
                                accion = "modificó";
                            }
                            else if (MODO == "DELETE")
                            {
                                obj.Accion = "DELETE";
                                accion = "eliminó";
                            }
                            else
                            {
                                tipoMsg = "WARNING";
                                message = "No se encontró el MODO.";
                                tituloMsg = "Advertencia";
                            }
                            try
                            {
                                //objCuerpo.Estado = Convert.ToInt32(objCuerpo.UsuarioModificacion);
                            }
                            catch (Exception e)
                            {
                                Log.Information("BandejaMedicoController - save_FirmaActosMedicosTemp - Bloque Catch");
                                Log.Error(e, e.Message);
                                X.Msg.Notify("Exception", e.GetBaseException().Message).Show();
                            }
                            /////registro
                            obj.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                            obj.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            obj.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                            obj.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                            obj.EpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion; //ADD 05.06.2017 OES Motivo: Modificacion en continuar episodio
                            obj.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;               // agregado jordan mateo
                            obj.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;          // agregado jordan mateo
                            obj.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                            obj.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                            obj.ObservacionProxima = idWindow == "ANULAROA" ? obj.ObservacionProxima : null;
                            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_HOSP_CIRUGIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                            {
                                obj.TipoAtencion = 3;

                                SS_HC_EpisodioAtencion objalta2 = new SS_HC_EpisodioAtencion();
                                objalta2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                objalta2.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                objalta2.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                objalta2.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                objalta2.EpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion; //ADD 05.06.2017 OES Motivo: Modificacion en continuar episodio
                                objalta2.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                                objalta2.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                objalta2.Accion = "VALIDA_ALTA";
                                var result = SvcEpisodioAtencion.setMantenimiento(objalta2);
                                validadoralta = result;
                                if (result != 0)
                                {
                                    obj.IdUbicacion = 1;
                                }

                                //if (ENTITY_GLOBAL.Instance.INDICADOR_HOSPI == 3)
                                //{ 
                                //    obj.IdUbicacion = 1;

                                //}
                                // obj.IdUbicacion = 1; // indicador para cerrar la atencion
                            }

                            //obj.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;                            
                            obj.FechaFirma = DateTime.Now;
                            if (idWindow == "ANULAROA")
                            {
                                obj.Accion = "ANULAROA";
                                obj.idMedicoFirma = Listar[0].IdEmpleado;
                                if (ENTITY_GLOBAL.Instance.INDICADOR_INTERCONSULTA == 3)
                                {
                                    obj.Version = ENTITY_GLOBAL.Instance.SECUENCIAL_HCE;
                                }


                                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                int idResultados = 0;
                                int registro = -1;
                                var objGenral = new SS_HCE_ConsultaExterna();
                                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                objGenral.Medico = Listar[0].IdEmpleado;
                                objGenral.TipoOrdenMedica = ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO" ? 1 : 2;
                                objGenral.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                objGenral.Accion = "ANULAROA";

                                idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);

                                if (idResultados > 0)
                                {
                                    SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                                    objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    objEpClinico.UsuarioCreacion = ENTITY_GLOBAL.Instance.CodigoOA;
                                    objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objEpClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    objEpClinico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    objEpClinico.ACCION = "ANULAROA";

                                    registro = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                                }

                            }
                            else if (idWindow == "ANULARALTA")
                            {

                                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                int idResultados = 0;
                                int registro = -1;
                                var objGenral = new SS_HCE_ConsultaExterna();
                                objGenral.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                objGenral.Medico = Listar[0].IdEmpleado;
                                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                objGenral.Accion = "ANULARALTA";

                                var timeout = SetTimeout(() =>
                                {
                                    idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                }, 3000);


                                SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                                objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                objEpClinico.UsuarioCreacion = ENTITY_GLOBAL.Instance.CodigoOA;
                                objEpClinico.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                objEpClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                objEpClinico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                objEpClinico.ACCION = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso" ? "ANULARREINGRESO" : "ANULARALTA";

                                idResultado = SvcEpisodioClinico.setMantenimiento(objEpClinico);

                            }
                            else
                            {
                                obj.Accion = "PROC_FIRMARACTO";
                                List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                int idResultadoInterconsulta = 0;
                                var objGenral = new SS_HCE_ConsultaExterna();
                                objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                objGenral.Medico = ENTITY_GLOBAL.Instance.CODPERSONA;
                                objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                if (Listar[0].tipotrabajador == "02")
                                {
                                    var LocalEnty = new SS_HC_NotasEnfermeria_FE();
                                    var ListarEnf = new List<SS_HC_NotasEnfermeria_FE>();
                                    LocalEnty.Accion = "LISTAR";
                                    LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

                                    ListarEnf = SvcNotaEnfermeriaServiceFE.NotaEnfermeriaListar(LocalEnty).ToList();

                                    objGenral.IdEpisodioAtencion = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    if (ListarEnf.Count > 0)
                                    {
                                        objGenral.EpisodioClinico = 1;
                                        objGenral.UsuarioModificacion = ListarEnf[0].NotaEnfermeria;
                                    }
                                    else
                                    {
                                        objGenral.EpisodioClinico = 0;
                                    }

                                    objGenral.Accion = "FIRMA_ENFER";
                                    idResultadoInterconsulta = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                }
                                //else
                                //{
                                //    objGenral.Accion = "DELETE_INTER";
                                //}


                            }
                            //if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO" && idWindow != "ANULAROA")
                            //{
                            //    List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                            //    int idResultadoInterconsulta = 0;
                            //    var objGenral = new SS_HCE_ConsultaExterna();
                            //    objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                            //    objGenral.Accion = "DELETE_INTER";
                            //    idResultadoInterconsulta = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                            //}
                            if (idWindow != "ANULARALTA")
                            {
                                idResultado = SvcEpisodioAtencion.setMantenimiento(obj);
                            }


                            /******ADD PARA INTEROPERABILIDAD***/
                            try
                            {
                                if (idWindow != "ANULAROA")
                                {
                                    //HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                    string valor = "";
                                    int IdEp = Convert.ToInt32(obj.IdEpisodioAtencion);
                                    valor = ObtenerTramaOA.InterOperabilidadSalida(obj.UnidadReplicacion, IdEp, obj.IdPaciente, obj.EpisodioClinico).ToString();

                                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                                    {
                                        if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Procedimiento")
                                        {
                                            int idResultadoProc = 0;
                                            var objGenralProc = new SS_HCE_ConsultaExterna();
                                            objGenralProc.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            objGenralProc.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                            objGenralProc.Accion = "FIRMA_PROC";

                                            var timeout = SetTimeout(() =>
                                            {
                                                idResultadoProc = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralProc);

                                            }, 3000);
                                        }

                                        var LocalEnty = new SS_HC_EvolucionMedica_FE();
                                        var ListarData = new List<SS_HC_EvolucionMedica_FE>();
                                        LocalEnty.Accion = "LISTAR";
                                        LocalEnty.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                        LocalEnty.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                        LocalEnty.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                        LocalEnty.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                        LocalEnty.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;

                                        ListarData = SvcEvolucionObjetivaFEService.listarSS_HC_EvolucionObjetiva(LocalEnty);
                                        if (ListarData.Count > 0)
                                        {
                                            int idResultadosEvo = 0;
                                            var objGenral = new SS_HCE_ConsultaExterna();
                                            objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                            objGenral.UsuarioModificacion = ListarData[0].EvolucionObjetiva;
                                            objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                            objGenral.TipoOrdenMedica = ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo" ? 1 : 0;
                                            objGenral.Accion = "EVO_OBJETIVO";
                                            // Establish timer settings. 
                                            var timeout = SetTimeout(() =>
                                            {
                                                idResultadosEvo = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                                Console.WriteLine("Will be run in 2 seconds if timeout is not cleared...");

                                            }, 5000);
                                        }
                                    }
                                }
                                // if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && ENTITY_GLOBAL.Instance.INDICADOR_HOSPI == 3)
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && validadoralta != 0 && ENTITY_GLOBAL.Instance.COD_HCEBANDEJA != "ENFERM_EMERGENCIAS")
                                {
                                    var LocalEntyAlta = new SS_HC_InformeAlta_FE();
                                    var ListarAlta = new List<SS_HC_InformeAlta_FE>();
                                    LocalEntyAlta.Accion = "LISTAR";
                                    LocalEntyAlta.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    LocalEntyAlta.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    LocalEntyAlta.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    LocalEntyAlta.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    ListarAlta = SvcInformeAltaFE.lista_Cabecera(LocalEntyAlta).ToList();

                                    List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                    int idResultados = 0;
                                    var objGenral = new SS_HCE_ConsultaExterna();
                                    objGenral.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                    objGenral.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                    objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objGenral.IdPaciente = ENTITY_GLOBAL.Instance.PacienteID;
                                    objGenral.Especialidad = ListarAlta.Count > 0 ? ListarAlta[0].IdEspecialidad : 1; //TIPO COBERTURA ALTA
                                    objGenral.TipoInterConsulta = ListarAlta.Count > 0 ? ListarAlta[0].IdTipoAlta : 1; //TIPO ALTA MEDICA
                                    objGenral.Accion = "ALTAMEDICA";
                                    idResultados = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                    if (idResultados > 0)
                                    {
                                        if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso")
                                        {
                                            long resAlta = 0;
                                            SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                            epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            epiAtencionObjAlta.Accion = "ALTAMEDICA";
                                            epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                            resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo")
                                        {
                                            long resAlta = 0;
                                            SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                            epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            epiAtencionObjAlta.Accion = "ALTAMEDICARE";
                                            epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                            resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia")
                                        {
                                            long resAlta = 0;
                                            SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                            epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            epiAtencionObjAlta.Accion = "ALTAMEDICAEME";
                                            epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                            resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                        }
                                        else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Interconsulta")
                                        {
                                            int idResultadoDerivacion = 0;
                                            var objGenralDerivacion = new SS_HCE_ConsultaExterna();
                                            objGenralDerivacion.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                            objGenralDerivacion.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                            objGenralDerivacion.Accion = "DERIVACION";
                                            idResultadoDerivacion = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralDerivacion);

                                            if (idResultadoDerivacion > 0)
                                            {
                                                long resAlta = 0;
                                                SS_HC_EpisodioAtencion epiAtencionObjAlta = new SS_HC_EpisodioAtencion();
                                                epiAtencionObjAlta.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                                epiAtencionObjAlta.Accion = "ALTAMEDICAEME";
                                                epiAtencionObjAlta.LineaOrdenAtencion = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;

                                                resAlta = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAlta);
                                            }


                                        }

                                        //if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && ENTITY_GLOBAL.Instance.INDICADOR_HOSPI == 3)
                                        if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && validadoralta != 0)
                                        {
                                            SS_HC_EpisodioAtencion obj2 = new SS_HC_EpisodioAtencion();
                                            obj2.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                            obj2.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                                            obj2.Accion = "ALTA_UPDATE";
                                            var result = SvcEpisodioAtencion.setMantenimiento(obj2);
                                        }

                                        ENTITY_GLOBAL.Instance.INDICADOR_HOSPI = 0;
                                    }



                                }
                                else if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" && (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso" ||
                                    ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo" || ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia"))
                                {
                                    int idResultadoConsul = 0;
                                    var objGenralConsul = new SS_HCE_ConsultaExterna();
                                    objGenralConsul.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                                    objGenralConsul.Linea = ENTITY_GLOBAL.Instance.LineaOrdenAtencion;
                                    ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL = (string)Session["TIPOTRABAJADOR_ACTUAL"];
                                    if (ENTITY_GLOBAL.Instance.TIPOTRABAJADORACTUAL == "02")
                                    {
                                        objGenralConsul.EstadoDocumento = 2;
                                    }
                                    objGenralConsul.Accion = "FIRMA_CONSULTA";

                                    var timeout = SetTimeout(() =>
                                    {
                                        idResultadoConsul = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralConsul);
                                    }, 3000);
                                }
                                //valor = ObtenerTramaOA.InterOperabilidadSalida(obj.UnidadReplicacion.Trim() + "|" + ENTITY_GLOBAL.Instance.USUARIO.Trim() + "|" + (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion + "|" + (int)ENTITY_GLOBAL.Instance.LineaOrdenAtencion, IdEp, obj.IdPaciente, obj.EpisodioClinico).ToString();
                                //valor = ObtenerTramaOA.InterOperabilidadSalida(obj.UnidadReplicacion.Trim() + "|" + ENTITY_GLOBAL.Instance.USUARIO.Trim() + "|" + (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion + "|" + (int)ENTITY_GLOBAL.Instance.LineaOrdenAtencion, IdEp, obj.IdPaciente, obj.EpisodioClinico).ToString();
                            }
                            catch (Exception e)
                            {
                                Log.Information("BandejaMedicoController - save_FirmaActosMedicosTemp - Bloque Catch");
                                Log.Error(e, e.Message);
                            }
                            //////////////////////FINAL

                        }
                    }
                    else
                    {
                        tipoMsg = "ERROR";
                        message = "No se pudieron guardar los cambios. No se recibió el objeto vinculado.";
                        tituloMsg = "Error";
                    }
                    obj.Accion = "INFO";
                    return JavaScript("InicioMedico('" + message + "')");
                    //if (indicaValidacionForm)
                    //{
                    //    return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinal");
                    //}
                    //else
                    //{
                    //    return terminarShowMensajeBox(idWindow, message, tituloMsg, tipoMsg, "accionFinal");
                    //    //return showMensajeBox(message, tituloMsg, tipoMsg, "accionFinal");
                    //}

                }
                else
                {
                    try
                    {
                        return showMensajeNotify("Error al acceder", "La contraseña es incorrecta.", "ERROR");

                    }
                    catch (Exception ex)
                    {

                        throw ex;
                    }

                }
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - save_FirmaActosMedicosTemp - Bloque Catch");
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

        public CancellationTokenSource SetTimeout(Action action, int millis)
        {
            Log.Information("BandejaMedicoController - SetTimeout - Entrar");
            Log.Debug("BandejaMedicoController - SetTimeout - action {A}, millis {B}", action, millis);
            var cts = new CancellationTokenSource();
            var ct = cts.Token;
            _ = Task.Run(() =>
            {
                Thread.Sleep(millis);
                if (!ct.IsCancellationRequested)
                    action();
            }, ct);

            return cts;
        }

        public static DataTable rptV_EpisodioAtenciones(string Reporte, string UnidadReplicacion, int PacienteID, int EpisodioClinico, long EpisodioAtencion)
        {
            Log.Information("BandejaMedicoController - rptV_EpisodioAtenciones - Entrar");
            Log.Debug("BandejaMedicoController - rptV_EpisodioAtenciones - Reporte {A}, UnidadReplicacion {B}, PacienteID {C}, EpisodioClinico {D} ,EpisodioAtencion {E}"
                                    , Reporte, UnidadReplicacion, PacienteID, EpisodioClinico, EpisodioAtencion);

            using (SqlConnection conx = new SqlConnection(ConfigurationManager.ConnectionStrings["ConexionReportes"].ToString()))
            {
                var idvalorepisodio = "";
                if (ENTITY_GLOBAL.Instance.INDICADOR_EMER == "MED_EMERGENCIA") { idvalorepisodio = "IdEpisodioAtencion"; } else { idvalorepisodio = "Episodio_Atencion"; }
                conx.Open();
                string sql = @"SELECT Accion FROM " + Reporte + "  where UnidadReplicacion='" + UnidadReplicacion + "' and IdPaciente=" + PacienteID + " and  EpisodioClinico= " + EpisodioClinico + "  GROUP BY Accion "; //ADD 05.06.2017 ORLANDO
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
        public System.Web.Mvc.ActionResult eventoProcesoInteroperabilidad(string modo)
        {
            Log.Information("BandejaMedicoController - eventoProcesoInteroperabilidad - Entrar");
            Log.Debug("BandejaMedicoController - eventoProcesoInteroperabilidad - modo {A}", modo);
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
        /**Devuelve el objeto de PERSONAMAST a partir de la atención seleccionada*/
        public PERSONAMAST getPERSONAMAST_SELECC()
        {
            Log.Information("BandejaMedicoController - getPERSONAMAST_SELECC - Entrar");
            PERSONAMAST personaTemp = new PERSONAMAST();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                ////////////////////
                personaTemp.Persona = Convert.ToInt32(seleccion.IdPaciente);
                personaTemp.Origen = "LIMA";
                if (seleccion.UnidadReplicacionEC != null) personaTemp.Origen = seleccion.UnidadReplicacionEC;
                personaTemp.NombreCompleto = seleccion.PacienteNombre;
                personaTemp.Sexo = seleccion.sexo;
                personaTemp.FechaNacimiento = seleccion.FechaNacimiento;
                personaTemp.EstadoCivil = seleccion.EstadoCivil;
                personaTemp.NivelInstruccion = seleccion.NivelInstruccion;
                personaTemp.Direccion = seleccion.Direccion;
                personaTemp.TipoDocumento = (seleccion.TipoDocumento != null ? seleccion.TipoDocumento.Trim() : "");
                personaTemp.Documento = (seleccion.Documento != null ? seleccion.Documento.Trim() : "");
                personaTemp.ApellidoPaterno = (seleccion.ApellidoPaterno != null ? seleccion.ApellidoPaterno.Trim() : "");
                personaTemp.ApellidoMaterno = (seleccion.ApellidoMaterno != null ? seleccion.ApellidoMaterno.Trim() : "");
                personaTemp.Nombres = (seleccion.Nombres != null ? seleccion.Nombres.Trim() : "");
                personaTemp.LugarNacimiento = seleccion.LugarNacimiento;
                personaTemp.CodigoPostal = seleccion.CodigoPostal;
                personaTemp.Provincia = seleccion.Provincia;
                personaTemp.Departamento = seleccion.Departamento;
                personaTemp.Telefono = seleccion.Telefono;
                personaTemp.EsPaciente = seleccion.EsPaciente;
                personaTemp.EsEmpresa = seleccion.EsEmpresa;
                personaTemp.Pais = seleccion.Pais;
                personaTemp.Estado = seleccion.EstadoPersona;
                personaTemp.UltimoUsuario = ENTITY_GLOBAL.Instance.USUARIO;
            }

            return personaTemp;
        }
        /**Devuelve el objeto de SS_GE_Paciente a partir de la atención seleccionada*/
        public SS_GE_Paciente getSS_GE_Paciente_SELECC()
        {
            Log.Information("BandejaMedicoController - getSS_GE_Paciente_SELECC - Entrar");
            SS_GE_Paciente pacienteTemp = new SS_GE_Paciente();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                ////////////////////            
                /**PACIENTES*/
                pacienteTemp.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                //    pacienteTemp.TipoPaciente = seleccion.TipoPaciente;
                pacienteTemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                pacienteTemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                pacienteTemp.CodigoHC = seleccion.CodigoHC;
            }
            return pacienteTemp;
        }
        /**Devuelve el objeto de SS_HC_EpisodioClinico a partir de la atención seleccionada*/
        public SS_HC_EpisodioClinico getSS_HC_EpisodioClinico_SELECC()
        {
            Log.Information("BandejaMedicoController - getSS_HC_EpisodioClinico_SELECC - Entrar");
            SS_HC_EpisodioClinico EpiClinicoTemp = new SS_HC_EpisodioClinico();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                ////////////////////            

                /**EPI CLINICO*/
                EpiClinicoTemp.EpisodioClinico = Convert.ToInt32(seleccion.EpisodioClinico);
                EpiClinicoTemp.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                EpiClinicoTemp.UnidadReplicacion = seleccion.UnidadReplicacion;
                EpiClinicoTemp.FechaRegistro = seleccion.CitaFecha;
                EpiClinicoTemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                EpiClinicoTemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            }
            return EpiClinicoTemp;
        }
        /**Devuelve el objeto de SS_HC_EpisodioAtencion a partir de la atención seleccionada*/
        public SS_HC_EpisodioAtencion getSS_HC_EpisodioAtencion_SELECC()
        {
            Log.Information("BandejaMedicoController - getSS_HC_EpisodioAtencion_SELECC - Entrar");
            SS_HC_EpisodioAtencion EpiAtencionTemp = new SS_HC_EpisodioAtencion();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                //////////////////// 
                /**EPI ATENCION*/
                EpiAtencionTemp.EpisodioClinico = Convert.ToInt32(seleccion.EpisodioClinico);
                EpiAtencionTemp.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                EpiAtencionTemp.IdEpisodioAtencion = Convert.ToInt32(seleccion.IdEpisodioAtencion);
                EpiAtencionTemp.UnidadReplicacion = seleccion.UnidadReplicacion;
                EpiAtencionTemp.IdOrdenAtencion = seleccion.IdOrdenAtencion;
                EpiAtencionTemp.IdUnidadServicio = seleccion.IdUnidadServicio;
                EpiAtencionTemp.IdEstablecimientoSalud = seleccion.IdEstablecimientoSalud;
                EpiAtencionTemp.TipoAtencion = seleccion.TipoAtencion;
                EpiAtencionTemp.LineaOrdenAtencion = seleccion.LineaOrdenAtencion;
                EpiAtencionTemp.TipoOrdenAtencion = seleccion.TipoOrdenAtencion;
                EpiAtencionTemp.IdEspecialidad = seleccion.IdEspecialidad;
                EpiAtencionTemp.IdProcedimiento = ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" ? seleccion.IdProcedimiento : seleccion.Modalidad;
                EpiAtencionTemp.IdUbicacion = seleccion.IdEmpresaAseguradora;
                EpiAtencionTemp.FechaInicioDescansoMedico = seleccion.FechaInicio;
                EpiAtencionTemp.FechaFinDescansoMedico = seleccion.FechaFin;
                EpiAtencionTemp.CodigoOA = seleccion.CodigoOA;
                EpiAtencionTemp.FechaRegistro = seleccion.FechaRegistro;
                EpiAtencionTemp.FechaAtencion = seleccion.FechaAtencion;
                EpiAtencionTemp.FechaOrden = seleccion.CitaFecha;
                EpiAtencionTemp.IdEstablecimientoSaludProxima = seleccion.TipoPaciente;
                EpiAtencionTemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                EpiAtencionTemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                EpiAtencionTemp.FlagFirma = seleccion.IdHospitalizacion;
                EpiAtencionTemp.KeyPublica = seleccion.TipoOrdenAtencionNombre;
                EpiAtencionTemp.LineaHospitalizacionflag = seleccion.ComponenteNombre;

            }
            return EpiAtencionTemp;
        }
        /**Devuelve el objeto de SS_HC_AsignacionMedico a partir de la atención seleccionada*/
        public SS_HC_AsignacionMedico getSS_HC_AsignacionMedico_SELECC()
        {
            Log.Information("BandejaMedicoController - getSS_HC_AsignacionMedico_SELECC - Entrar");
            SS_HC_AsignacionMedico asigmedicoTemp = new SS_HC_AsignacionMedico();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                ////////////////////     
                asigmedicoTemp.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                asigmedicoTemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                asigmedicoTemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
            }
            return asigmedicoTemp;
        }
        /**Devuelve el objeto de SS_HC_AsignacionMedico a partir de la atención seleccionada*/
        public VW_ATENCIONPACIENTE_GENERAL getVW_ATENCIONPACIENTE_GENERAL_SELECC()
        {
            Log.Information("BandejaMedicoController - getVW_ATENCIONPACIENTE_GENERAL_SELECC - Entrar");
            VW_ATENCIONPACIENTE_GENERAL seleccion = new VW_ATENCIONPACIENTE_GENERAL();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                ////////////////////           
            }
            return seleccion;
        }

        /**PARA TECNOLOGO**/
        public System.Web.Mvc.ActionResult EstadoSelecGrupoAtencion(string selectionExamenes, string selectionEpi,
            string accion, string idUnidadServicio)
        {
            Log.Information("BandejaMedicoController - EstadoSelecGrupoAtencion - Entrar");
            Log.Debug("BandejaMedicoController - EstadoSelecGrupoAtencion - selectionExamenes {A}, selectionEpi {B}, accion {C}, idUnidadServicio {D} "
                                    , selectionExamenes, selectionEpi, accion, idUnidadServicio);
            int registro = -1;
            if (accion == "NUEVO")
            {
                SelectPersonaEpisodioAuxiliar(selectionEpi, "Nuevo");
                return registroDetalleGrupoAtencion(selectionExamenes, accion, idUnidadServicio);
            }
            else if (accion == "UPDATE")
            {
                SelectPersonaEpisodioAuxiliar(selectionEpi, accion);
                return EstadoClinico(selectionEpi, "UPDATE", idUnidadServicio);
            }
            else if (accion == "VER")
            {
                SelectPersonaEpisodioAuxiliar(selectionEpi, accion);
                return EstadoClinico(selectionEpi, "VISTA", idUnidadServicio);
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult registroDetalleGrupoAtencion(string selectionExamenes,
            string accion, string idUnidadServicio)
        {
            Log.Information("BandejaMedicoController - registroDetalleGrupoAtencion - Entrar");
            Log.Debug("BandejaMedicoController - registroDetalleGrupoAtencion - selectionExamenes {A}, accion {B}, idUnidadServicio {C} "
                                    , selectionExamenes, accion, idUnidadServicio);
            try
            {
                VW_ATENCIONPACIENTE_GENERAL objEpiAtencionSelecc;
                //GUARDAR TEMPORAL: UnidServicio
                Nullable<int> UnidadServicioAux = null;
                if (getValorFiltroInt(idUnidadServicio) != null)
                {
                    UnidadServicioAux = Convert.ToInt32(getValorFiltroInt(idUnidadServicio));
                }
                Nullable<int> EstablecimientoAux = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);

                if (accion == "NUEVO")
                {
                    bool validoEpiClinico = false;
                    SS_HC_EpisodioAtencion epiAtencionObjAbrir = new SS_HC_EpisodioAtencion();
                    epiAtencionObjAbrir.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    epiAtencionObjAbrir.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionObjAbrir.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                    epiAtencionObjAbrir.Accion = "ABRIREPICLINICO";
                    long registroAux = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAbrir);
                    int EpicLinico = 0;
                    if (registroAux > 0)
                    {
                        validoEpiClinico = true;
                        accion = "Continuar";
                        EpicLinico = Convert.ToInt32("" + registroAux);
                        ENTITY_GLOBAL.Instance.EpisodioClinico = EpicLinico;
                    }

                    if (validoEpiClinico)
                    {
                        SS_HC_EpisodioAtencion epiAtencionObjSave = new SS_HC_EpisodioAtencion();
                        epiAtencionObjSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        epiAtencionObjSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                        epiAtencionObjSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                        epiAtencionObjSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        epiAtencionObjSave.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        epiAtencionObjSave.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim; //ADD  cambios 09/15

                        if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                        {
                            epiAtencionObjSave.TipoTrabajador = "" + Session["TIPOTRABAJADOR_ACTUAL"];
                        }
                        string mensajeFinal = "";
                        epiAtencionObjSave.TipoEpisodio = "EPISODIO";
                        epiAtencionObjSave.Accion = "CONTINUAR";
                        mensajeFinal = "NUEVO Episodio";
                        SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();

                        if (EpiAtencionTemp != null)
                        {
                            //CONTROL DE ESPECIALIDAD SELECCIONADA (Afecta a médico) //ADD 23/09/15                            
                            Nullable<int> idEspecialidadAux = EpiAtencionTemp.IdEspecialidad;
                            if (UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL") != null)
                            {
                                int idEspecialidadTemp = (int)UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL");
                                if (idEspecialidadTemp > 0)
                                {
                                    idEspecialidadAux = idEspecialidadTemp;
                                }
                            }
                            epiAtencionObjSave.IdEspecialidad = idEspecialidadAux;
                            ///////////////////////////////////////////////////////////////
                            epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                            epiAtencionObjSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                            epiAtencionObjSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                            epiAtencionObjSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                        }
                        //ADD 09/15
                        epiAtencionObjSave.IdUnidadServicio = UnidadServicioAux;
                        epiAtencionObjSave.IdEstablecimientoSalud = EstablecimientoAux;
                        epiAtencionObjSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;

                        long registro = 0;
                        bool indicaValidoEpiClinicoOrigen = true;
                        //GUARDADO
                        List<SS_HC_ProcedimientoEjecucion> ObjListar = (List<SS_HC_ProcedimientoEjecucion>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionExamenes, typeof(List<SS_HC_ProcedimientoEjecucion>));
                        if (ObjListar != null)
                        {
                            List<SS_HC_ProcedimientoEjecucion> listaProceEjecucion = new List<SS_HC_ProcedimientoEjecucion>();
                            foreach (var result in ObjListar)
                            {
                                if (result.EpisodioClinicoSolicitado == EpicLinico)
                                {
                                    SS_HC_ProcedimientoEjecucion objSave = result;
                                    //KEY
                                    objSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    objSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                                    objSave.IdEpisodioAtencion = 0;//NUEVO
                                    ////                                
                                    objSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                                    objSave.ACCION = "INSERT";

                                    listaProceEjecucion.Add(objSave);
                                }
                                else
                                {
                                    indicaValidoEpiClinicoOrigen = false;
                                }

                            }
                            if (indicaValidoEpiClinicoOrigen)
                            {
                                registro = SvcProcedimientoEjecucion.setMantenimientoDetalle(epiAtencionObjSave, listaProceEjecucion);
                            }
                            else
                            {
                                List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
                                String mensaje = "El Episodio de Atención actual no Corresponde al Episodio de Origen de los Exámenes seleccionados.";
                                mensajesError.Add(new ENTITY_MENSAJES
                                {
                                    DESCRIPCION = mensaje,
                                    IDCOMPONENTE = "msg",
                                    NIVEL = 1
                                });
                                return this.Store(mensajesError);
                            }

                        }
                        //registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjSave);
                        if (registro > 0)
                        {
                            epiAtencionObjSave.IdEpisodioAtencion = registro;
                            epiAtencionObjSave.Accion = "LISTARPORID";
                            List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionObjSave, 0, 0);
                            ENTITY_GLOBAL.Instance.EpisodioAtencion = registro;
                            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;

                            if (listaEpi.Count > 0)
                            {
                                objEpiAtencionSelecc = getVW_ATENCIONPACIENTE_GENERAL_SELECC();
                                ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                                ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);

                                objEpiAtencionSelecc.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                objEpiAtencionSelecc.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                objEpiAtencionSelecc.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                objEpiAtencionSelecc.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                objEpiAtencionSelecc.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = objEpiAtencionSelecc;

                                ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                                //X.Msg.Notify("Ventana de Mensajes ",
                                //"Satisfactoriamente se " + "Registro "+ ". Nuevo Episodio Atención : " + String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();

                                return showMensajeNotify("Ventana de Mensajes",
                                    "Registro satisfactorio de " + mensajeFinal + ". Código Transacción: " +
                                    UTILES_MENSAJES.getCodigoTransaccionHCE(listaEpi[0].EpisodioClinico,
                                    listaEpi[0].EpisodioAtencion,
                                    listaEpi[0].IdEpisodioAtencion, 0, ""), "INFO");

                            }
                        }
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                        // X.Msg.Alert("Mensajes ", "Seleccione Episodio Clínico").Show();
                    }
                    else
                    {
                        List<ENTITY_MENSAJES> mensajesError = new List<ENTITY_MENSAJES>();
                        String mensaje = "No se encontró alguna Atención Médica vinculada a los Exámenes seleccionados.";
                        mensajesError.Add(new ENTITY_MENSAJES
                        {
                            DESCRIPCION = mensaje,
                            IDCOMPONENTE = "msg",
                            NIVEL = 1
                        });
                        return this.Store(mensajesError);
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - registroDetalleGrupoAtencion - Bloque Catch");
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
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult EstadoSelecVisita(string selection, string accion, string idUnidadServicio)
        {
            Log.Information("BandejaMedicoController - EstadoSelecVisita - Entrar");
            Log.Debug("BandejaMedicoController - EstadoSelecVisita - selection {A}, accion {B}, idUnidadServicio {C} "
                                    , selection, accion, idUnidadServicio);
            int registro = -1;
            if (accion == "NUEVO")
            {
                return EstadoClinico(selection, "NUEVAVISITA", idUnidadServicio);
            }
            else if (accion == "UPDATE")
            {
                SelectPersonaEpisodioAuxiliar(selection, accion);
                return EstadoClinico(selection, "UPDATE", idUnidadServicio);
            }
            else if (accion == "VER")
            {
                SelectPersonaEpisodioAuxiliar(selection, accion);
                return EstadoClinico(selection, "VISTA", idUnidadServicio);
            }
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult EstadoClinicoAMH(string selection, string accion, string data)
        {
            Log.Information("BandejaMedicoController - EstadoClinicoAMH - Entrar");
            Log.Debug("BandejaMedicoController - EstadoClinicoAMH - selection {A}, accion {B}, data {C} "
                                    , selection, accion, data);
            bool indicaAbrir = false;
            long registro = -1;

            List<VW_ATENCIONPACIENTE_GENERAL> ObjListarActivo = (List<VW_ATENCIONPACIENTE_GENERAL>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<VW_ATENCIONPACIENTE_GENERAL>));

            if (ObjListarActivo[0].EstadoEpiClinico == null)
            {
                SS_HC_EpisodioClinico objEPiCLin = new SS_HC_EpisodioClinico();
                objEPiCLin.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                objEPiCLin.IdPaciente = Convert.ToInt32(ObjListarActivo[0].IdPaciente);
                objEPiCLin.IdOrdenAtencion = ObjListarActivo[0].IdOrdenAtencion; //NO USADO
                objEPiCLin.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO; //NO USADO
                objEPiCLin.ACCION = "EPISODIOCLINICO";
                int EpisodioClinico = SvcEpisodioClinico.setMantenimiento(objEPiCLin);
                ENTITY_GLOBAL.Instance.EpisodioClinico = EpisodioClinico;
                SS_HC_EpisodioAtencion epiAtencionClinicoSave = new SS_HC_EpisodioAtencion();
                epiAtencionClinicoSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                epiAtencionClinicoSave.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                epiAtencionClinicoSave.IdPaciente = Convert.ToInt32(ObjListarActivo[0].IdPaciente);
                epiAtencionClinicoSave.CodigoOA = ObjListarActivo[0].CodigoOA;
                epiAtencionClinicoSave.LineaOrdenAtencion = ObjListarActivo[0].LineaOrdenAtencion;
                epiAtencionClinicoSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionClinicoSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionClinicoSave.EpisodioClinico = EpisodioClinico;
                epiAtencionClinicoSave.Accion = "INSERT";
                long IdEpisodioAtencion = SvcEpisodioAtencion.setMantenimiento(epiAtencionClinicoSave);
                ENTITY_GLOBAL.Instance.EpisodioAtencion = IdEpisodioAtencion;
                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
            }
            //return this.RedirectToAction("Index", "HClinica");
            //return showMensajeBotton("Genero Registros", "", "");
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult EstadoClinicoNotificaciones(int IdPaciente, String NombreCompleto, String CodigoOA, int IdOrdenAtencion,
            int TipoAtencion, int Linea, string tipotrabrequerido,
            string tipoListado)
        {
            Log.Information("BandejaMedicoController - EstadoClinicoNotificaciones - Entrar");
            Log.Debug("BandejaMedicoController - EstadoClinicoNotificaciones - IdPaciente {A}, NombreCompleto {B}, CodigoOA {C}, IdOrdenAtencion {D} ,TipoAtencion {E}, Linea {F}" +
                                        ",tipotrabrequerido {G}, tipoListado {H}"
                                    , IdPaciente, NombreCompleto, CodigoOA, IdOrdenAtencion, TipoAtencion, Linea, tipotrabrequerido, tipoListado);
            var objModel = new VW_ATENCIONPACIENTE();
            objModel.IdPaciente = IdPaciente;
            objModel.NombreCompleto = NombreCompleto;
            objModel.CodigoOA = CodigoOA;
            objModel.IdOrdenAtencion = IdOrdenAtencion;
            //objModel.EpisodioAtencion = 1;
            //objModel.EpisodioClinico = 1;
            objModel.Fax = "BandejaMedico/";
            //objModel.IdEpisodioAtencion = 1;
            objModel.LineaOrdenAtencion = Linea;
            objModel.Accion = "TODOS";
            objModel.TipoAtencion = TipoAtencion;
            //
            objModel.Persona = Convert.ToInt32(ENTITY_GLOBAL.Instance.CODPERSONA);
            objModel.IdPersonalSalud = ENTITY_GLOBAL.Instance.TIPOAGENTE;
            ///
            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
            {
                objModel.TipoSituacion = (string)Session["TIPOTRABAJADOR_ACTUAL"]; //AUX PARA TIPOTRABAJADOR
            }
            objModel.TipoHistoria = "08";
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;//AUX  CODIGO AGENTE

            //List<SS_GE_Especialidad> listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            List<SS_GE_Especialidad> listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            //SI SOLO POSEE UNA ESPECIALIDAD SETARLA POR DEFECTO.
            if (listaEspecialidad.Count == 1)
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", listaEspecialidad[0].IdEspecialidad);
            }
            else
            {
                UTILES_MENSAJES.setParametro_Form("ESPECIALIDADHCE_SEL", null);
            }

            objModel.TipoBrevete = tipoListado;//AUX PARA TIPO DE LISTADO

            return crearWindowRegistro("Procesos/VisitaEpisodio", objModel, "");

        }


        public System.Web.Mvc.JsonResult GuardarPacienteNuevo(PERSONAMAST objSP)
        {
            Log.Information("BandejaMedicoController - GuardarPacienteNuevo - Entrar");
            Log.Debug("BandejaMedicoController - GuardarPacienteNuevo - objSP {A}", objSP);
            long idResultado = 0;
            String Accion = objSP.ACCION.Trim();
            objSP.ACCION = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objSP.UltimoUsuario = ENTITY_GLOBAL.Instance.USUARIO;
            if (objSP.FechaNacimiento > DateTime.Now)
            {
                return Json("Fecha_Excedida", System.Web.Mvc.JsonRequestBehavior.AllowGet);
            }
            idResultado = SvcEpisodioTriaje.InsertarPacienteTriaje(objSP);
            if (idResultado == 0000000000)
            {
                // return showMensajeNotify("Mensaje", "El paciente con en el documento :" + objSP.Documento.Trim() + " Ya existe..!", "ERROR");
            }
            else
            {
                if (idResultado > 1)
                {
                    Regi(idResultado);
                }
            }
            return Json(idResultado, System.Web.Mvc.JsonRequestBehavior.AllowGet);
        }


        public void Regi(long idResultado)
        {
            Log.Information("BandejaMedicoController - Regi - Entrar");
            Log.Debug("BandejaMedicoController - Regi - idResultado {A}", idResultado);
            SS_HC_EpisodioTriaje obje = new SS_HC_EpisodioTriaje();

            obje.UnidadReplicacion = "CEG";
            obje.Accion = "INSERT_TRIAJE";
            obje.FechaAtencion = DateTime.Now;
            obje.IdPaciente = Convert.ToInt32(idResultado);
            obje.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
            ENTITY_GLOBAL.Instance.PacienteID = Convert.ToInt32(idResultado);
            GuardarBandeja(obje);
        }

        public System.Web.Mvc.ActionResult EstadoClinico(string selection, string accion, string idUnidadServicio)
        {
            Session["ssesion_ListarPaciiente"] = null;
            Log.Information("BandejaMedicoController - EstadoClinico - Entrar");
            Log.Debug("BandejaMedicoController - EstadoClinico - selection {A}, accion {B}, idUnidadServicio {C}", selection, accion, idUnidadServicio);
            DataTable dtValida = new DataTable();
            HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
            try
            {
                ENTITY_GLOBAL.Instance.COPIADO_DISABLED = "FM";
                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                WsEpisodio.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                WsEpisodio.IdOrdenAtencion = (int)ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                WsEpisodio.UsuarioCreacion = "DATA_PACIENTES";
                WsEpisodio.FechaCreacion = DateTime.Now;
                WsEpisodio.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                Session["SEGURO_POLIZA"] = "";
                Session["SEGURO_COBERTURA"] = "";
                Session["SEGURO_MODALIDAD"] = "";
                Session["SEGURO_CONTRATO"] = "";
                if (dtValida != null)
                {
                    foreach (DataRow row in dtValida.AsEnumerable())
                    {
                        Session["SEGURO_POLIZA"] = row["poliza"].ToString();
                        Session["SEGURO_COBERTURA"] = row["cobertura"].ToString();
                        Session["SEGURO_MODALIDAD"] = row["modalidad"].ToString();
                        Session["SEGURO_CONTRATO"] = row["contrato"].ToString();
                    }
                }
            }
            catch (Exception e)
            {
                Log.Information("BandejaMedicoController - EstadoClinico - Bloque Catch");
                Log.Error(e, e.Message);
            }

            try
            {
                var vistaGenSelecpa = new VW_ATENCIONPACIENTE_GENERAL();
                if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                {
                    vistaGenSelecpa = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                    ENTITY_GLOBAL.Instance.ListadoOrigen = vistaGenSelecpa.Origen;   //jordan Mateo 14/12/2020
                    var persona = new PERSONAMAST
                    {
                        Persona = Convert.ToInt32(vistaGenSelecpa.IdPaciente),
                        NombreCompleto = vistaGenSelecpa.PacienteNombre,
                        FechaNacimiento = vistaGenSelecpa.FechaNacimiento,
                        Documento = vistaGenSelecpa.Documento,
                        Sexo = vistaGenSelecpa.sexo,
                        Nombres = vistaGenSelecpa.Nombres,
                        ApellidoPaterno = vistaGenSelecpa.ApellidoPaterno,
                        ApellidoMaterno = vistaGenSelecpa.ApellidoMaterno,
                        TipoDocumento = vistaGenSelecpa.TipoDocumento,
                        Direccion = vistaGenSelecpa.Direccion,
                        EstadoCivil = vistaGenSelecpa.EstadoCivil,
                        Telefono = vistaGenSelecpa.Telefono,
                        CorreoElectronico = vistaGenSelecpa.CorreoElectronico,
                        // más campos...
                    };
                    Session["ssesion_ListarPaciiente"] = new List<PERSONAMAST> { persona };
                    // Guardar los datos del paciente en sesión directamente desde la vista
                    Session["NOMBREPACIENTE_EMERGE"] = vistaGenSelecpa.PacienteNombre; // $"{vistaGenSelecpa.ApellidoPaterno} {vistaGenSelecpa.ApellidoMaterno} {vistaGenSelecpa.Nombres}";
                    Session["NUMDOCUMENTO_EMERGE"] = vistaGenSelecpa.Documento ?? string.Empty;
                    Session["TIPODOCUMENTO_EMERGE"] = vistaGenSelecpa.TipoDocumento ?? string.Empty;
                    Session["CORREOELECTRO_EMERGE"] = vistaGenSelecpa.CorreoElectronico ?? string.Empty;
                    Session["FECHANACIMIENTO_EMERGE"] = vistaGenSelecpa.FechaNacimiento != null
                        ? vistaGenSelecpa.FechaNacimiento.GetValueOrDefault().ToString("yyyy-MM-dd")
                        : string.Empty;
                    Session["TELEFONO_EMERGE"] = vistaGenSelecpa.Telefono ?? string.Empty;
                    //Session["CELULAR_EMERGE"] = vistaGenSelecpa.Celular ?? string.Empty;
                }


                bool indicaAbrir = false;
                long registro = -1;

                Nullable<int> idEspecialidadAuxEmer = 0;
                if (accion == "NUEVAVISITA" || accion == "ABRIR")
                {
                    indicaAbrir = true;
                }

                //PARA CARGAR LAS SESIONES DE LOS DATOS DEL PACIENTE Y MOSTRARLO EN CIRUGIA          
              
                //var ListarPA = new List<PERSONAMAST>();
                //var LocalEntyPA = new PERSONAMAST();
                //var objDatosPA = new PERSONAMAST();
                //VW_ATENCIONPACIENTE_GENERAL vistaGenSelecpa = new VW_ATENCIONPACIENTE_GENERAL();
                //if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                //{
                //    vistaGenSelecpa = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                //}
                //LocalEntyPA.ACCION = "LISTARPACIENTE";        
                //LocalEntyPA.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                //ListarPA = SvcPersonaMast.GetSelectPersonaMast(LocalEntyPA).ToList();
                //if (ListarPA.Count > 0)
                //{
                //    Session["ssesion_ListarPaciiente"] = ListarPA;
                //    Session["NOMBREPACIENTE_EMERGE"] = "" + ListarPA[0].NombreCompleto;
                //    Session["NUMDOCUMENTO_EMERGE"] = "" + ListarPA[0].Documento;
                //    Session["TIPODOCUMENTO_EMERGE"] = "" + ListarPA[0].TipoDocumento;
                //    Session["CORREOELECTRO_EMERGE"] = "" + ListarPA[0].CorreoElectronico;
                //    string fecha = ListarPA[0].FechaNacimiento.ToString();
                //    Session["FECHANACIMIENTO_EMERGE"] = "" + fecha.Substring(0, 10);
                //    Session["TELEFONO_EMERGE"] = "" + ListarPA[0].Telefono;
                //    Session["CELULAR_EMERGE"] = "" + ListarPA[0].Celular;
                //}

                //GUARDAR TEMPORAL: UnidServicio
                VW_ATENCIONPACIENTE_GENERAL objEpiAtencionSelecc;
                Nullable<int> UnidadServicioAux = null;
                if (getValorFiltroInt(idUnidadServicio) != null)
                {
                    UnidadServicioAux = Convert.ToInt32(getValorFiltroInt(idUnidadServicio));
                }
                else
                {
                    VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
                    UnidadServicioAux = Convert.ToInt32(seleccion.IdUnidadServicio);
                }

                Nullable<int> EstablecimientoAux = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);
                Session["IdUnidadServicio_ACTUAL"] = UnidadServicioAux;


                if (accion == "NUEVAVISITA" || accion == "ABRIR")// jordan mateo 02/04/2019 
                {
                    SS_HC_EpisodioAtencion epiAtencionObjSave = new SS_HC_EpisodioAtencion();
                    SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();
                    epiAtencionObjSave.CodigoOA = EpiAtencionTemp.CodigoOA;
                    epiAtencionObjSave.IdEspecialidad = EpiAtencionTemp.IdEspecialidad;
                    epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                    epiAtencionObjSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                    epiAtencionObjSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                    epiAtencionObjSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    epiAtencionObjSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionObjSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    epiAtencionObjSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                    epiAtencionObjSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;

                    if (epiAtencionObjSave.TipoAtencion == 1)
                    {
                        epiAtencionObjSave.Accion = "LISTAR";
                        List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionObjSave, 0, 0);
                        if (listaEpi.Count > 0)
                        {
                            foreach (SS_HC_EpisodioAtencion Obj_EpisodioAtencion in listaEpi)
                            {
                                if (!string.IsNullOrEmpty(Obj_EpisodioAtencion.IdPersonalSalud.ToString())) ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(Obj_EpisodioAtencion.IdPersonalSalud);
                                ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(Obj_EpisodioAtencion.FechaFirma);

                                ENTITY_GLOBAL.Instance.EpisodioClinico = Obj_EpisodioAtencion.EpisodioClinico;
                                ENTITY_GLOBAL.Instance.EpisodioAtencion = Obj_EpisodioAtencion.EpisodioAtencion;
                                ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = Obj_EpisodioAtencion.EpisodioAtencion;

                                if (Obj_EpisodioAtencion.TipoAtencion.ToString() != null) ENTITY_GLOBAL.Instance.TIPOATENCION = Obj_EpisodioAtencion.TipoAtencion.ToString();
                                if (Obj_EpisodioAtencion.IdEpisodioAtencion != null)
                                {
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = Convert.ToInt64(Obj_EpisodioAtencion.IdEpisodioAtencion);
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = Convert.ToInt64(Obj_EpisodioAtencion.IdEpisodioAtencion);
                                }
                                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                            }
                            accion = "UPDATE";
                        }
                    }
                }
                if (accion == "ABRIR")
                {
                    SS_HC_EpisodioAtencion epiAtencionObjAbrir = new SS_HC_EpisodioAtencion();
                    epiAtencionObjAbrir.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionObjAbrir.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionObjAbrir.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionObjAbrir.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                    epiAtencionObjAbrir.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionObjAbrir.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionObjAbrir.IdEpisodioAtencion = -1;
                    epiAtencionObjAbrir.EpisodioClinico = -1;
                    SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();

                    epiAtencionObjAbrir.FlagFirma = EpiAtencionTemp.FlagFirma;
                    epiAtencionObjAbrir.FechaOrden = EpiAtencionTemp.FechaOrden;
                    epiAtencionObjAbrir.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                    epiAtencionObjAbrir.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                    epiAtencionObjAbrir.Accion = "ABRIREPICLINICO";
                    //OBS: SE DIJO UNA OA NO PUEDE ESTAR EN OTRO EPI ClÍNICO....09/17
                    registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAbrir);
                    int EpicLinico = 0;
                    if (registro >= 1 && (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION") && (EpiAtencionTemp.TipoOrdenAtencion != 1 || ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo"))
                    {
                        accion = "Nuevo";

                    }
                    else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso")
                    {
                        accion = "Nuevo";
                    }
                    else if (registro > 0)
                    {
                        accion = "Continuar";
                        EpicLinico = Convert.ToInt32("" + registro);
                        ENTITY_GLOBAL.Instance.EpisodioClinico = EpicLinico;
                    }
                    else
                    {
                        accion = "Nuevo";
                    }
                    //accion = "Nuevo";
                }

                if (accion == "Continuar" || accion == "NUEVAVISITA")
                {
                    if (!indicaAbrir)
                    {
                        SelectPersonaEpisodioAuxiliar(selection, accion);
                    }
                    if (ENTITY_GLOBAL.Instance.EpisodioClinico != null)
                    {
                        SS_HC_EpisodioAtencion epiAtencionObjSave = new SS_HC_EpisodioAtencion();
                        epiAtencionObjSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                        epiAtencionObjSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                        epiAtencionObjSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                        epiAtencionObjSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        epiAtencionObjSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        epiAtencionObjSave.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        epiAtencionObjSave.EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencionPrim; //ADD  cambios 09/15 
                        if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                        {
                            epiAtencionObjSave.TipoTrabajador = "" + Session["TIPOTRABAJADOR_ACTUAL"];
                        }
                        string mensajeFinal = "";
                        if (accion == "Continuar")
                        {
                            epiAtencionObjSave.TipoEpisodio = "EPISODIO";
                            epiAtencionObjSave.Accion = "CONTINUAR";
                            mensajeFinal = "NUEVO Episodio";
                        }
                        else
                        {
                            epiAtencionObjSave.TipoEpisodio = "VISITA";
                            epiAtencionObjSave.Accion = epiAtencionObjSave.TipoTrabajador == "02" ? "INSERTENF" : "INSERT";
                            mensajeFinal = "NUEVA Visita de Episodio";
                        }
                        SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();

                        if (EpiAtencionTemp != null)
                        {
                            //CONTROL DE ESPECIALIDAD SELECCIONADA (Afecta a médico) //ADD 23/09/15
                            epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                            Nullable<int> idEspecialidadAux = EpiAtencionTemp.IdEspecialidad;
                            if (UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL") != null)
                            {
                                int idEspecialidadTemp = (int)UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL");
                                if (idEspecialidadTemp > 0)
                                {
                                    idEspecialidadAux = idEspecialidadTemp;
                                }
                            }
                            epiAtencionObjSave.IdEspecialidad = (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION") ? ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER : idEspecialidadAux;
                            ///////////////////////////////////////////////////////////////
                            epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                            epiAtencionObjSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                            epiAtencionObjSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                            epiAtencionObjSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                        }
                        //ADD ref Unidad Serv 21/09/15
                        epiAtencionObjSave.IdUnidadServicio = UnidadServicioAux;
                        epiAtencionObjSave.IdEstablecimientoSalud = EstablecimientoAux;
                        epiAtencionObjSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO" ? ENTITY_GLOBAL.Instance.COD_MEDICO : ENTITY_GLOBAL.Instance.CODPERSONA;
                        if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Emergencia")
                        {
                            epiAtencionObjSave.FlagFirma = 99; //relevo
                        }
                        registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjSave);
                        if (registro > 0)
                        {
                            ENTITY_GLOBAL.Instance.EpisodioAtencion = registro;
                            epiAtencionObjSave.EpisodioClinico = 0;
                            epiAtencionObjSave.IdEpisodioAtencion = 0;
                            epiAtencionObjSave.Accion = "LISTAR";
                            List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionObjSave, 0, 0);
                            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                            if (listaEpi.Count > 0)
                            {
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                                {
                                    // por definir metodo para interconsulta
                                    ENTITY_GLOBAL.Instance.COD_MEDICO = ENTITY_GLOBAL.Instance.CODPERSONA;
                                }
                                //if (!string.IsNullOrEmpty(listaEpi[0].IdPersonalSalud.ToString())) ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);                       
                                ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                                ENTITY_GLOBAL.Instance.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                epiAtencionObjSave.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                epiAtencionObjSave.IdEpisodioAtencion = Convert.ToInt32(listaEpi[0].EpisodioAtencion);
                                // cambio para pruebas independientes
                                try
                                {
                                    int IdEp = Convert.ToInt32(registro);
                                    int IdCli = epiAtencionObjSave.EpisodioClinico;
                                    //HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                    string valor = "";
                                    if (epiAtencionObjSave.TipoTrabajador == "02")
                                    {
                                        List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                        int idResultado = 0;
                                        var objGenral = new SS_HCE_ConsultaExterna();
                                        objGenral.IdOrdenAtencion = listaEpi[0].IdOrdenAtencion;
                                        objGenral.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                        objGenral.Accion = "ENFERMERIA";
                                        idResultado = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenral);
                                    }
                                    else
                                    {
                                        valor = ObtenerTramaOA.InterOperabilidadConsultaExterna(listaEpi[0].UnidadReplicacion, IdEp, listaEpi[0].IdPaciente, epiAtencionObjSave.EpisodioClinico).ToString();
                                    }                              
                                }
                                catch (Exception ex)
                                {
                                    Log.Information("BandejaMedicoController - EstadoClinico - Bloque Catch");
                                    Log.Error(ex, ex.Message);
                                    showMensajeNotifyData("Error", "No se pudo enviar por el servicio  " + listaEpi[0].UnidadReplicacion.Trim() + "|" + registro + "|" + listaEpi[0].IdPaciente + "|" + listaEpi[0].EpisodioClinico + "  |  " + ex.StackTrace, "ERROR", false);
                                }

                                /******ADD PARA FORMATOS COMPARTIDOS***/
                                epiAtencionObjSave.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                epiAtencionObjSave.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                epiAtencionObjSave.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                epiAtencionObjSave.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                epiAtencionObjSave.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                epiAtencionObjSave.Accion = "FORM_COMPARTIDOS";
                                long resultFormComp = SvcEpisodioAtencion.setCopiarEpisodio(epiAtencionObjSave, 0, "");
                                if (resultFormComp < 0)
                                {
                                }
                                /************************************/
                                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                                ////////
                                objEpiAtencionSelecc = getVW_ATENCIONPACIENTE_GENERAL_SELECC();
                                objEpiAtencionSelecc.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                objEpiAtencionSelecc.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                objEpiAtencionSelecc.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                objEpiAtencionSelecc.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                objEpiAtencionSelecc.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = objEpiAtencionSelecc;
                                ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                                ENTITY_GLOBAL.Instance.EpisodioAtencionBeta = listaEpi[0].IdEpisodioAtencion;
                                ENTITY_GLOBAL.Instance.EpisodioAtencionBeta2 = listaEpi[0].IdEpisodioAtencion;
                                ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO

                                //VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                                //if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                                //{
                                //    vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                                //}
                                var Listar = new List<PERSONAMAST>();
                                var LocalEnty = new PERSONAMAST();
                                var objDatos = new PERSONAMAST();
                                if (Session["ssesion_ListarPaciiente"] != null)
                                {
                                    Listar = (List<PERSONAMAST>)Session["ssesion_ListarPaciiente"];
                                }
                                //LocalEnty.ACCION = "LISTARPACIENTE";
                                //LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                //LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                                //Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
                                if (Listar.Count > 0)
                                {
                                    Session["ssesion_ListarPaciiente"] = Listar;
                                    foreach (PERSONAMAST objPersona in Listar)
                                    {
                                        objDatos = objPersona;
                                        Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                                        int edad = 0;
                                        DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                                        DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                                        if (nacimiento != null)
                                        {
                                            edad = DateTime.Now.Year - nacimiento.Year;
                                            if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                                edad = edad - 1;
                                        }
                                        Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                                        if (vistaGenSelecpa.Origen == "Consulta")
                                        {
                                            Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                                        }
                                        else if (vistaGenSelecpa.Origen == "Emergencia" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                                        {
                                            Session["COMPONENTE_LEVI"] = "    Hospitalización  ";
                                        }
                                        else if (vistaGenSelecpa.Origen == "Emergencia")
                                        {
                                            Session["COMPONENTE_LEVI"] = "    Emergencia  ";
                                        }
                                        else if (vistaGenSelecpa.Origen == "Interconsulta")
                                        {
                                            Session["COMPONENTE_LEVI"] = "    Interconsulta  ";
                                        }
                                        else if (vistaGenSelecpa.Origen == "Relevo")
                                        {
                                            Session["COMPONENTE_LEVI"] = "    Relevo  ";
                                        }
                                        else if (vistaGenSelecpa.Origen == "RE-Ingreso")
                                        {
                                            Session["COMPONENTE_LEVI"] = "    RE-Ingreso  ";
                                        }
                                        else
                                        {
                                            var componente = vistaGenSelecpa.ComponenteNombre;
                                            if (componente == null)
                                            {
                                                Session["COMPONENTE_LEVI"] = "";
                                            }
                                            else
                                            {
                                                Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                                            }
                                        }

                                        ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelecpa.TipoOrdenAtencion;
                                        ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelecpa.CodigoHC;
                                        ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelecpa.CodigoOA;
                                        ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelecpa.Componente;

                                    }
                                }
                                var localEntity = new SS_HC_Anamnesis_AFAM_CAB_FE();
                                localEntity.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                localEntity.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                localEntity.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                localEntity.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                localEntity.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                                ENTITY_GLOBAL.Instance.OBJETOS_F5 = localEntity;
                                /***************/
                                return showMensajeNotify("Ventana de Mensajes",
                                    "Registro satisfactorio de " + mensajeFinal + ". Código Transacción: " +
                                    UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                                    listaEpi[0].EpisodioAtencion,
                                    listaEpi[0].IdEpisodioAtencion, 0, ""), "INFO");
                            }
                        }
                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                    }
                    else
                    {
                        X.Msg.Alert("Ventana de Validación", "Por favor seleccione Episodio Clínico a Continuar...").Show();
                    }
                }
                else if (accion == "Nuevo")
                {
                    SS_HC_EpisodioAtencion epiAtencionClinicoSave = new SS_HC_EpisodioAtencion();
                    epiAtencionClinicoSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019;
                    epiAtencionClinicoSave.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionClinicoSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionClinicoSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                    epiAtencionClinicoSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionClinicoSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionClinicoSave.IdEpisodioAtencion = -1;
                    epiAtencionClinicoSave.EpisodioClinico = -1;
                    string mensage = "";
                    /////////////////ADD;             

                    PERSONAMAST personaTemp = getPERSONAMAST_SELECC();
                    SS_GE_Paciente pacienteTemp = getSS_GE_Paciente_SELECC();
                    SS_HC_EpisodioClinico EpiClinicoTemp = getSS_HC_EpisodioClinico_SELECC();
                    SS_HC_EpisodioAtencion EpiAtencionTemp = null;
                    SS_HC_AsignacionMedico asigmedicoTemp = getSS_HC_AsignacionMedico_SELECC();

                    List<SS_HC_EpisodioAtencion> listaEpiAtencionTemp = new List<SS_HC_EpisodioAtencion>();
                    if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                    {
                        EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();
                        EpiAtencionTemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        EpiAtencionTemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        //ADD 15/09
                        EpiAtencionTemp.IdUnidadServicio = UnidadServicioAux;
                        EpiAtencionTemp.IdEstablecimientoSalud = EstablecimientoAux;
                        listaEpiAtencionTemp.Add(EpiAtencionTemp);
                    }

                    epiAtencionClinicoSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    registro = SvcEpisodioAtencion.setPreMantenimiento(personaTemp, pacienteTemp, asigmedicoTemp, EpiClinicoTemp, listaEpiAtencionTemp);
                    if (registro > 0)
                    {
                        //////////////////////Guardar Episodio Clinico
                        if (EpiAtencionTemp != null)
                        {
                            epiAtencionClinicoSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                        }
                        epiAtencionClinicoSave.Accion = "EPISODIOCLINICO";
                        //registro = SvcFormularioAnamnesisAP.setMantAnamnesisAP(objAnamnesis_AP);
                        registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionClinicoSave);
                        if (registro > 0)
                        {
                            ENTITY_GLOBAL.Instance.EpisodioClinico = Convert.ToInt32(registro);
                            SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                            epiAtencionSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.IdMedico;
                            epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                            epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                            epiAtencionSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                            epiAtencionSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                            epiAtencionSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                            epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);

                            ////////////////////////////ADD
                            epiAtencionSave.TipoEpisodio = "EPISODIO";
                            if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                            {
                                epiAtencionSave.TipoTrabajador = "" + Session["TIPOTRABAJADOR_ACTUAL"];
                            }
                            ///////////////////////////////
                            /******ADD**********/
                            VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                            {
                                vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                            }
                            var Listar = new List<PERSONAMAST>();
                            var objDatos = new PERSONAMAST();
                            //var LocalEnty = new PERSONAMAST();                         
                            if (Session["ssesion_ListarPaciiente"] != null)
                            {
                                Listar = (List<PERSONAMAST>)Session["ssesion_ListarPaciiente"];
                            }
                            //LocalEnty.ACCION = "LISTARPACIENTE";
                            //LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                            //LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                            //Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();

                            if (Listar.Count > 0)
                            {
                                Session["Ssesion_ListarPaciiente"] = Listar;
                                foreach (PERSONAMAST objPersona in Listar)
                                {
                                    objDatos = objPersona;
                                    ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto;
                                    Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;

                                    if (vistaGenSelec.Origen == "Consulta")
                                    {
                                        Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                                    }
                                    else if (vistaGenSelec.Origen == "Emergencia" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                                    {
                                        Session["COMPONENTE_LEVI"] = "    Hospitalización  ";
                                    }
                                    else if (vistaGenSelec.Origen == "Emergencia")
                                    {
                                        Session["COMPONENTE_LEVI"] = "    Emergencia  ";
                                    }
                                    else if (vistaGenSelec.Origen == "Interconsulta")
                                    {
                                        Session["COMPONENTE_LEVI"] = "    Interconsulta  ";
                                    }
                                    else if (vistaGenSelec.Origen == "Relevo")
                                    {
                                        Session["COMPONENTE_LEVI"] = "    Relevo  ";
                                    }
                                    else if (vistaGenSelec.Origen == "RE-Ingreso")
                                    {
                                        Session["COMPONENTE_LEVI"] = "    RE-Ingreso  ";
                                    }
                                    else
                                    {
                                        var componente = vistaGenSelec.ComponenteNombre;
                                        if (componente == null)
                                        {
                                            Session["COMPONENTE_LEVI"] = "";
                                        }
                                        else
                                        {
                                            Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                                        }
                                    }

                                    ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelec.TipoOrdenAtencion;
                                    ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelec.CodigoHC;
                                    ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelec.CodigoOA;
                                    ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelec.Componente;

                                    int edad = 0;
                                    DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                                    DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                                    if (nacimiento != null)
                                    {
                                        edad = DateTime.Now.Year - nacimiento.Year;
                                        if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                            edad = edad - 1;
                                    }
                                    Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                                }
                            }
                            /***************/
                            epiAtencionSave.Accion = "INSERT";
                            if (EpiAtencionTemp != null)
                            {
                                //CONTROL DE ESPECIALIDAD SELECCIONADA (Afecta a médico) //ADD 23/09/15
                                epiAtencionSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                                Nullable<int> idEspecialidadAux = EpiAtencionTemp.IdEspecialidad;
                                if (UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL") != null)
                                {
                                    int idEspecialidadTemp = (int)UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL");
                                    if (idEspecialidadTemp > 0)
                                    {
                                        idEspecialidadAux = idEspecialidadTemp;
                                        idEspecialidadAuxEmer = idEspecialidadTemp;
                                    }
                                }
                                //jordan Mateo
                                //epiAtencionSave.IdEspecialidad = (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION") ? ENTITY_GLOBAL.Instance.IDESPECIALIDADEMER : idEspecialidadAux;
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                                {
                                    epiAtencionSave.IdEspecialidad = idEspecialidadAuxEmer;
                                }
                                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "AMBULATORIO")
                                {
                                    epiAtencionSave.IdEspecialidad = idEspecialidadAux;
                                }
                                ///////////////////////////////////////////////////////////////
                                epiAtencionSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                                epiAtencionSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                                epiAtencionSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                                epiAtencionSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                                epiAtencionSave.FechaOrden = EpiAtencionTemp.FechaOrden;

                            }
                            //ADD ref Unidad Serv 21/09/15
                            epiAtencionSave.IdUnidadServicio = UnidadServicioAux;
                            epiAtencionSave.IdEstablecimientoSalud = EstablecimientoAux;
                            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                            {
                                if (EpiAtencionTemp.IdProcedimiento == 2)
                                {
                                    epiAtencionSave.IdTipoInterConsulta = 1;
                                }
                                else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo")
                                {
                                    epiAtencionSave.IdTipoInterConsulta = 1;
                                }
                                else if (EpiAtencionTemp.IdProcedimiento == 1 || (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Procedimiento"))
                                {
                                    epiAtencionSave.IdTipoInterConsulta = 2;
                                }
                                else if (EpiAtencionTemp.LineaHospitalizacionflag == "I. Opinión")
                                {
                                    epiAtencionSave.IdTipoInterConsulta = 2;

                                }
                                else if (EpiAtencionTemp.IdProcedimiento == 3 || ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso")
                                {
                                    //Asigna el medico y libera el alta por ser re-ingreso
                                    epiAtencionSave.IdTipoInterConsulta = 1;
                                    SS_HC_EpisodioClinico objEpClinico = new SS_HC_EpisodioClinico();
                                    objEpClinico.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    objEpClinico.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                                    objEpClinico.UsuarioCreacion = EpiAtencionTemp.KeyPublica;
                                    objEpClinico.UsuarioModificacion = EpiAtencionTemp.CodigoOA;
                                    objEpClinico.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    objEpClinico.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    objEpClinico.ACCION = "MED_PRINCIPAL";
                                    registro = SvcEpisodioClinico.setMantenimiento(objEpClinico);
                                }
                                else
                                {
                                    epiAtencionSave.IdTipoInterConsulta = 1;
                                }
                                ENTITY_GLOBAL.Instance.COD_MEDICO = (epiAtencionSave.TipoOrdenAtencion != 11 && epiAtencionSave.TipoOrdenAtencion != 1) ? 0 : ENTITY_GLOBAL.Instance.CODPERSONA;
                            }

                            ////////////////
                            if (!string.IsNullOrEmpty(ENTITY_GLOBAL.Instance.CODPERSONA.ToString()))
                                epiAtencionSave.IdPersonalSalud = ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO" ?
                                    ENTITY_GLOBAL.Instance.COD_MEDICO : ENTITY_GLOBAL.Instance.CODPERSONA;
                            Log.Debug("BandejaMedicoController - EstadoClinico - valor de IdEspecialidad {a}", epiAtencionSave.IdEspecialidad);
                            //epiAtencionSave.IdEspecialidad = 0;
                            if (epiAtencionSave.IdEspecialidad == 0 || epiAtencionSave.IdEspecialidad == null)
                            {
                                throw new Exception("especialidad Error");
                            }
                            registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionSave);
                            Log.Debug("BandejaMedicoController - SvcEpisodioAtencion.setMantenimiento - valor de registro {a}", registro);

                            //registro = 0;
                            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                            // ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION2 = "NUEVO";
                            if (registro <= 0)
                            {
                                throw new Exception("episodio Error");
                            }
                            if (registro > 0)
                            {
                                if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Relevo")
                                {
                                    long reg = 0;
                                    SS_HC_EpisodioAtencion epiAtencionObjRelevo = new SS_HC_EpisodioAtencion();
                                    epiAtencionObjRelevo.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                                    epiAtencionObjRelevo.Accion = "RELEVAME";
                                    epiAtencionObjRelevo.EpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                                    epiAtencionObjRelevo.IdPersonalSalud = ENTITY_GLOBAL.Instance.COD_BANDEJA == "TECNOLOGO" ? ENTITY_GLOBAL.Instance.COD_MEDICO : ENTITY_GLOBAL.Instance.CODPERSONA;
                                    reg = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjRelevo);
                                }
                                epiAtencionSave.IdEpisodioAtencion = epiAtencionSave.TipoAtencion == 2 ? 1 : registro;
                                epiAtencionSave.Accion = "LISTARPORID";
                                List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                                ENTITY_GLOBAL.Instance.EpisodioAtencion = registro;
                                ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                                if (listaEpi.Count > 0)
                                {

                                    /******ADD PARA FORMATOS COMPARTIDOS***/
                                    if (!string.IsNullOrEmpty(listaEpi[0].IdPersonalSalud.ToString()))

                                        ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                                    epiAtencionSave.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                    epiAtencionSave.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                    epiAtencionSave.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                    epiAtencionSave.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                    epiAtencionSave.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                    epiAtencionSave.Accion = "FORM_COMPARTIDOS";

                                    /******ADD PARA INTEROPERABILIDAD***/
                                    int idResultaConsulta = 0;
                                    try
                                    {
                                        //HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                                        string valor = "";
                                        int IdEp = (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION") && (Convert.ToInt32(epiAtencionSave.TipoOrdenAtencion) != 11 && Convert.ToInt32(epiAtencionSave.TipoOrdenAtencion) != 1) ? 1 : Convert.ToInt32(epiAtencionSave.IdEpisodioAtencion);
                                        valor = ObtenerTramaOA.InterOperabilidadConsultaExterna(epiAtencionSave.UnidadReplicacion, IdEp, epiAtencionSave.IdPaciente, epiAtencionSave.EpisodioClinico).ToString();
                                        if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                                        {
                                            List<SS_HCE_ConsultaExterna> listaExterna = new List<SS_HCE_ConsultaExterna>();
                                            var objGenralConsulta = new SS_HCE_ConsultaExterna();
                                            objGenralConsulta.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                            objGenralConsulta.IdOrdenAtencion = listaEpi[0].IdOrdenAtencion;
                                            objGenralConsulta.Linea = listaEpi[0].LineaOrdenAtencion;
                                            objGenralConsulta.Medico = listaEpi[0].IdPersonalSalud;
                                            objGenralConsulta.Especialidad = listaEpi[0].LineaOrdenAtencion == 11 ? listaEpi[0].IdEspecialidad : idEspecialidadAuxEmer;
                                            objGenralConsulta.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                                            objGenralConsulta.Accion = "EMER_CONSULTA";
                                            if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Interconsulta")
                                            {
                                                objGenralConsulta.UsuarioModificacion = "INTERCONSULTA";
                                            }
                                            else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "RE-Ingreso")
                                            {
                                                //objGenralConsulta.Especialidad = 30;
                                                objGenralConsulta.UsuarioModificacion = "RE_INGRESO";
                                            }
                                            else if (ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION_EMER == "Procedimiento")
                                            {
                                                objGenralConsulta.Especialidad = listaEpi[0].IdEspecialidad == null || listaEpi[0].IdEspecialidad == 0 ? 30 : listaEpi[0].IdEspecialidad;
                                                objGenralConsulta.UsuarioModificacion = "PROCEDIEMIENTOX";
                                            }
                                            else
                                            {
                                                objGenralConsulta.UsuarioModificacion = "ALTA";
                                            }
                                            idResultaConsulta = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralConsulta);

                                            if (idResultaConsulta == 0)
                                            {
                                                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                                                dtValida = new DataTable();
                                                WsEpisodio.IdOrdenAtencion = objGenralConsulta.IdOrdenAtencion;
                                                WsEpisodio.Linea = objGenralConsulta.Linea;
                                                WsEpisodio.UsuarioCreacion = "EMER_CONSULTA";
                                                dtValida = ObtenerTramaOA.SoaValidaFacturacion(1, WsEpisodio);
                                                int IdCita = 0;
                                                foreach (DataRow intobj in dtValida.AsEnumerable())
                                                {
                                                    IdCita = Convert.ToInt32(intobj["IdCita"].ToString());
                                                }
                                                if (IdCita == 0)
                                                {
                                                    bool Rpta = false;
                                                    int maxRetries = ENTITY_GLOBAL.Instance.MIRTENVIO;
                                                    int retryCount = 0;
                                                    int delay = ENTITY_GLOBAL.Instance.MIRTHDELAY;
                                                    while (retryCount < maxRetries && !Rpta)
                                                    {
                                                        idResultaConsulta = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralConsulta);
                                                        if (idResultaConsulta > 0)
                                                        {
                                                            Rpta = true;
                                                        }
                                                        if (!Rpta)
                                                        {
                                                            retryCount++;
                                                            Log.Debug(DateTime.Now + " ListaConsultaExternaEmergencia Reintento " + retryCount + " de " + maxRetries);
                                                            if (retryCount < maxRetries)
                                                            {
                                                                Log.Debug(DateTime.Now + " Esperando " + delay / 1000 + " segundos antes del próximo intento.");
                                                                Task.Delay(delay).Wait();
                                                            }
                                                        }
                                                    }
                                                }
                                                Log.Debug("SoaValidaFacturacion {A} ", Newtonsoft.Json.JsonConvert.SerializeObject(WsEpisodio));
                                            }
                                        }
                                    }
                                    catch (Exception EX)
                                    {
                                        idResultaConsulta = 0;
                                        Log.Debug("BandejaMedicoController - asignacion medica  ListaConsultaExternaEmergencia {A}", EX.StackTrace);
                                    }
                                    long resultFormComp = SvcEpisodioAtencion.setCopiarEpisodio(epiAtencionSave, 0, "");
                                    if (resultFormComp < 0)
                                    {
                                    }
                                    /************************************/

                                    objEpiAtencionSelecc = getVW_ATENCIONPACIENTE_GENERAL_SELECC();
                                    objEpiAtencionSelecc.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                    objEpiAtencionSelecc.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                    objEpiAtencionSelecc.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                    objEpiAtencionSelecc.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                    objEpiAtencionSelecc.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                    Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = objEpiAtencionSelecc;
                                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO

                                    var localEntity = new SS_HC_Anamnesis_AFAM_CAB_FE();
                                    localEntity.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                                    localEntity.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                                    localEntity.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                                    localEntity.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                                    localEntity.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                                    ENTITY_GLOBAL.Instance.OBJETOS_F5 = localEntity;
                                    return showMensajeNotify("Ventana de Mensajes", " Registro satisfactorio de Episodio NUEVO . Código Transacción: " +
                                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo, listaEpi[0].EpisodioAtencion, listaEpi[0].IdEpisodioAtencion, 0, ""), "INFO");
                                }
                            }
                        }
                    }
                    else
                    {
                        return showMensajeBox("Imposible Ingresar", "", "");
                    }
                }
                else if (accion == "Finalizar")
                {
                    ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                    ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                    epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionSave.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                    epiAtencionSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionSave.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    //ADD ref Unidad Serv 21/09
                    epiAtencionSave.IdUnidadServicio = UnidadServicioAux;
                    epiAtencionSave.IdEstablecimientoSalud = EstablecimientoAux;
                    epiAtencionSave.Accion = "FINALIZAATENCION";

                    registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionSave);
                    //X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + "Registro" + ". Episodio de Atención Finalizado: " + String.Format("{0:00000}", registro)).Show();
                    return showMensajeNotify("Ventana de Mensajes",
                        "Registro de Episodio FINALIZADO . Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                        ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");
                }
                else if (accion == "VISTA")
                {
                    /******ADD**********/
                    //VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                    //if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                    //{
                    //    vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                    //}  
                    var Listar = new List<PERSONAMAST>();              
                    var objDatos = new PERSONAMAST();
                    if (Session["ssesion_ListarPaciiente"] != null)
                    {
                        Listar = (List<PERSONAMAST>)Session["ssesion_ListarPaciiente"];
                    }
                    //var LocalEnty = new PERSONAMAST();
                    //LocalEnty.ACCION = "LISTARPACIENTE";
                    //LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                    //Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();

                    if (Listar.Count > 0)
                    {
                        Session["Ssesion_ListarPaciiente"] = Listar;
                        foreach (PERSONAMAST objPersona in Listar)
                        {
                            objDatos = objPersona;
                            Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                            if (vistaGenSelecpa.Origen == "Consulta")
                            {
                                Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Emergencia" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                            {
                                Session["COMPONENTE_LEVI"] = "    Hospitalización  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Emergencia")
                            {
                                Session["COMPONENTE_LEVI"] = "    Emergencia  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Interconsulta")
                            {
                                Session["COMPONENTE_LEVI"] = "    Interconsulta  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Relevo")
                            {
                                Session["COMPONENTE_LEVI"] = "    Relevo  ";
                            }
                            else if (vistaGenSelecpa.Origen == "RE-Ingreso")
                            {
                                Session["COMPONENTE_LEVI"] = "    RE-Ingreso  ";
                            }
                            else
                            {
                                var componente = vistaGenSelecpa.ComponenteNombre;
                                if (componente == null)
                                {
                                    Session["COMPONENTE_LEVI"] = "";
                                }
                                else
                                {
                                    Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                                }
                            }

                            ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelecpa.TipoOrdenAtencion;
                            ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelecpa.CodigoHC;
                            ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelecpa.CodigoOA;
                            ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelecpa.Componente;

                            int edad = 0;
                            DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                            DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                            if (nacimiento != null)
                            {
                                edad = DateTime.Now.Year - nacimiento.Year;
                                if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                    edad = edad - 1;
                            }
                            Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                        }
                    }
                    /***************/

                    ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                    ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                    SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                    epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                    epiAtencionSave.Accion = "LISTARPORID";
                    List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                    if (listaEpi.Count > 0)
                    {
                        ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                        ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                        ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                        var localEntity = new SS_HC_Anamnesis_AFAM_CAB_FE();
                        localEntity.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        localEntity.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        localEntity.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        localEntity.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        localEntity.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                        ENTITY_GLOBAL.Instance.OBJETOS_F5 = localEntity;
                        return showMensajeNotify("Ventana de Mensajes",
                        "Registro de Episodio en Modo - SÓLO LECTURA. Código Transacción: " +
                            UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                            ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");
                    }

                }
                else if (accion == "AUDITOR")
                {
                    /******ADD**********/
                    //VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                    //if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                    //{
                    //    vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                    //}
                    var Listar = new List<PERSONAMAST>();                
                    var objDatos = new PERSONAMAST();
                    if (Session["ssesion_ListarPaciiente"] != null)
                    {
                        Listar = (List<PERSONAMAST>)Session["ssesion_ListarPaciiente"];
                    }
                    //var LocalEnty = new PERSONAMAST();
                    //LocalEnty.ACCION = "LISTARPACIENTE";
                    //LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    //LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                    //Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
                    if (Listar.Count > 0)
                    {
                        Session["Ssesion_ListarPaciiente"] = Listar;
                        foreach (PERSONAMAST objPersona in Listar)
                        {
                            objDatos = objPersona;
                            Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                            if (vistaGenSelecpa.Origen == "Consulta")
                            {
                                Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Emergencia" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                            {
                                Session["COMPONENTE_LEVI"] = "    Hospitalización  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Emergencia")
                            {
                                Session["COMPONENTE_LEVI"] = "    Emergencia  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Interconsulta")
                            {
                                Session["COMPONENTE_LEVI"] = "    Interconsulta  ";
                            }
                            else if (vistaGenSelecpa.Origen == "Relevo")
                            {
                                Session["COMPONENTE_LEVI"] = "    Relevo  ";
                            }
                            else if (vistaGenSelecpa.Origen == "RE-Ingreso")
                            {
                                Session["COMPONENTE_LEVI"] = "    RE-Ingreso  ";
                            }
                            else
                            {
                                var componente = vistaGenSelecpa.ComponenteNombre;
                                if (componente == null)
                                {
                                    Session["COMPONENTE_LEVI"] = "";
                                }
                                else
                                {
                                    Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                                }
                            }
                            ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelecpa.TipoOrdenAtencion;
                            ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelecpa.CodigoHC;
                            ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelecpa.CodigoOA;
                            ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelecpa.Componente;
                            int edad = 0;
                            DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                            DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                            if (nacimiento != null)
                            {
                                edad = DateTime.Now.Year - nacimiento.Year;
                                if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                    edad = edad - 1;
                            }
                            Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                        }
                    }
                    /***************/

                    ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                    ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                    SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                    epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                    epiAtencionSave.Accion = "LISTARPORID";
                    List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                    if (listaEpi.Count > 0)
                    {
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                        ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                        ENTITY_GLOBAL.Instance.IdMedicoaudi = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                        return showMensajeNotify("Ventana de Mensajes",
                        "Registro de Episodio en Modo - SÓLO LECTURA. Código Transacción: " +
                            UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                            ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");
                    }
                }
                else if (accion == "UPDATE")
                {
                    //VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
                    //if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                    //{
                    //    vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                    //}
                    //var Listar = new List<PERSONAMAST>();
                    //var LocalEnty = new PERSONAMAST();
                    //var objDatos = new PERSONAMAST();
                    //LocalEnty.ACCION = "LISTARPACIENTE";
                    //LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
                    //LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
                    //Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();

                    var Listar = new List<PERSONAMAST>();
                    var objDatos = new PERSONAMAST();
                    if (Session["ssesion_ListarPaciiente"] != null)
                    {
                        Listar = (List<PERSONAMAST>)Session["ssesion_ListarPaciiente"];
                    }

                    ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                    ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                    /////////////////
                    SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                    epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                    epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                    epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                    epiAtencionSave.Accion = "LISTARPORID";
                    if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                    {
                        epiAtencionSave.Accion = "LISTARPORIDHOSP";
                    };
                    List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                    if (listaEpi.Count > 0)
                    {
                        if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION" || ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                        {
                            ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                        };
                        ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                        ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO   
                        if (listaEpi[0].Estado == UTILES_MENSAJES.ESTADO_EPI_ATENDIDO) //Atendido - firmado
                        {
                            //regresar a estado de EN ATENCION
                            actualizarEstadoEpiAtencion(listaEpi[0], UTILES_MENSAJES.ESTADO_EPI_ENATENCION);
                        }
                        var localEntity = new SS_HC_Anamnesis_AFAM_CAB_FE();
                        localEntity.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        localEntity.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        localEntity.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        localEntity.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                        localEntity.Accion = ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION;
                        ENTITY_GLOBAL.Instance.OBJETOS_F5 = localEntity;
                        //Cambiar estado de ATENCIO FIRMADA
                        return showMensajeNotify("Ventana de Mensajes",
                        "Registro de Episodio en Modo - MODIFICAR . Código Transacción: " +
                            UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                            ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");
                    }
                }
                return this.Direct();
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                return Content("¡Error en el servidor! Detalles: " + ex.Message);
            }
        }


        /**Listado de Unidad de Servicio*/
        public System.Web.Mvc.ActionResult EstadoClinicoMedicamento(string selection, string accion)
        {
            Log.Information("BandejaMedicoController - EstadoClinicoMedicamento - Entrar");
            Log.Debug("BandejaMedicoController - EstadoClinicoMedicamento - selection {A}, accion {B}", selection, accion);

            Nullable<int> EstablecimientoAux = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);


            if (accion == "ABRIR")
            {
                VW_ATENCIONPACIENTEMEDICAMENTO epiAtencionObjAbrir = new VW_ATENCIONPACIENTEMEDICAMENTO();
                epiAtencionObjAbrir.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionObjAbrir.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionObjAbrir.IdEpisodioAtencion = -1;
                epiAtencionObjAbrir.EpisodioClinico = -1;


            }


            else if (accion == "VISTA")
            {
                /******ADD**********/
                VW_ATENCIONPACIENTEMEDICAMENTO vistaGenSelec = new VW_ATENCIONPACIENTEMEDICAMENTO();
                if (Session["VW_ATENCIONPACIENTEMED_SELECC"] != null)
                {
                    vistaGenSelec = (VW_ATENCIONPACIENTEMEDICAMENTO)Session["VW_ATENCIONPACIENTEMED_SELECC"];
                }



            }

            return this.Direct();
        }

        public System.Web.Mvc.ActionResult EstadoClinicoNotificacion(string selection, string accion, string idUnidadServicio)
        {
            Log.Information("BandejaMedicoController - EstadoClinicoNotificacion - Entrar");
            Log.Debug("BandejaMedicoController - EstadoClinicoNotificacion - selection {A}, accion {B},idUnidadServicio {C}", selection, accion, idUnidadServicio);
            bool indicaAbrir = false;
            long registro = -1;
            if (accion == "NUEVAVISITA" || accion == "ABRIR")
            {
                indicaAbrir = true;
            }

            VW_ATENCIONPACIENTE_GENERAL seleccion = (VW_ATENCIONPACIENTE_GENERAL)(Session["VW_ATENCIONPACIENTE_GEN_SELECC"]);
            //GUARDAR TEMPORAL: UnidServicio
            VW_ATENCIONPACIENTE_GENERAL objEpiAtencionSelecc;
            Nullable<int> UnidadServicioAux = null;


            idUnidadServicio = Convert.ToString(seleccion.IdUnidadServicio);
            var idpaciente = (seleccion.IdPaciente);

            if (getValorFiltroInt(idUnidadServicio) != null)
            {
                UnidadServicioAux = Convert.ToInt32(getValorFiltroInt(idUnidadServicio));
            }

            Nullable<int> EstablecimientoAux = Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);

            Session["IdUnidadServicio_ACTUAL"] = UnidadServicioAux;
            if (accion == "ABRIR")
            {
                SS_HC_EpisodioAtencion epiAtencionObjAbrir = new SS_HC_EpisodioAtencion();
                epiAtencionObjAbrir.UnidadReplicacion = seleccion.UnidadReplicacion;
                epiAtencionObjAbrir.UnidadReplicacionEC = seleccion.UnidadReplicacion;
                epiAtencionObjAbrir.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionObjAbrir.CodigoOA = seleccion.CodigoOA;
                epiAtencionObjAbrir.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionObjAbrir.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionObjAbrir.IdEpisodioAtencion = -1;
                epiAtencionObjAbrir.EpisodioClinico = -1;

                SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();

                epiAtencionObjAbrir.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                epiAtencionObjAbrir.Accion = "ABRIREPICLINICO";
                //OBS: SE DIJO UNA OA NO PUEDE ESTAR EN OTRO EPI ClÍNICO....09/17
                registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAbrir);
                int EpicLinico = 0;
                if (registro > 0)
                {
                    accion = "Continuar";
                    EpicLinico = Convert.ToInt32("" + registro);
                    seleccion.EpisodioClinico = EpicLinico;
                }
                else
                {
                    accion = "Nuevo";
                }
                //accion = "Nuevo";
            }

            if (accion == "Continuar" || accion == "NUEVAVISITA")
            {
                if (!indicaAbrir)
                {
                    SelectPersonaEpisodioAuxiliar(selection, accion);
                }
                if (ENTITY_GLOBAL.Instance.EpisodioClinico != null)
                {
                    SS_HC_EpisodioAtencion epiAtencionObjSave = new SS_HC_EpisodioAtencion();
                    epiAtencionObjSave.UnidadReplicacion = seleccion.UnidadReplicacion;
                    epiAtencionObjSave.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                    epiAtencionObjSave.CodigoOA = seleccion.CodigoOA;
                    epiAtencionObjSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionObjSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    epiAtencionObjSave.EpisodioClinico = (int)seleccion.EpisodioClinico;
                    epiAtencionObjSave.EpisodioAtencion = seleccion.EpisodioAtencion; //ADD  cambios 09/15

                    if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                    {
                        epiAtencionObjSave.TipoTrabajador = "" + Session["TIPOTRABAJADOR_ACTUAL"];
                    }
                    string mensajeFinal = "";
                    if (accion == "Continuar")
                    {
                        epiAtencionObjSave.TipoEpisodio = "EPISODIO";
                        epiAtencionObjSave.Accion = "CONTINUAR";
                        mensajeFinal = "NUEVO Episodio";
                    }
                    else
                    {
                        epiAtencionObjSave.TipoEpisodio = "VISITA";
                        epiAtencionObjSave.Accion = "INSERT";
                        mensajeFinal = "NUEVA Visita de Episodio";
                    }
                    SS_HC_EpisodioAtencion EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();

                    if (EpiAtencionTemp != null)
                    {
                        //CONTROL DE ESPECIALIDAD SELECCIONADA (Afecta a médico) //ADD 23/09/15
                        epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                        Nullable<int> idEspecialidadAux = EpiAtencionTemp.IdEspecialidad;
                        if (UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL") != null)
                        {
                            int idEspecialidadTemp = (int)UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL");
                            if (idEspecialidadTemp > 0)
                            {
                                idEspecialidadAux = idEspecialidadTemp;
                            }
                        }
                        epiAtencionObjSave.IdEspecialidad = idEspecialidadAux;
                        ///////////////////////////////////////////////////////////////
                        epiAtencionObjSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                        epiAtencionObjSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                        epiAtencionObjSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                        epiAtencionObjSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                        //epiAtencionObjSave.IdPersonalSalud = EpiAtencionTemp.IdPersonalSalud;
                        //epiAtencionObjSave.IdEstablecimientoSalud = EpiAtencionTemp.IdEstablecimientoSalud;
                        //epiAtencionObjSave.IdUnidadServicio = EpiAtencionTemp.IdUnidadServicio;                       
                    }
                    //ADD ref Unidad Serv 21/09/15
                    epiAtencionObjSave.IdUnidadServicio = UnidadServicioAux;
                    epiAtencionObjSave.IdEstablecimientoSalud = EstablecimientoAux;
                    ///////
                    epiAtencionObjSave.IdPersonalSalud = seleccion.IdPersonalSalud;

                    registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjSave);
                    if (registro > 0)
                    {
                        epiAtencionObjSave.IdEpisodioAtencion = registro;
                        epiAtencionObjSave.Accion = "LISTARPORID";
                        List<SS_HC_EpisodioAtencion> listaEpi = SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionObjSave, 0, 0);
                        ENTITY_GLOBAL.Instance.EpisodioAtencion = registro;
                        ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;

                        if (listaEpi.Count > 0)
                        {
                            //ADD PARA FORMATOS COMPARTIDOS
                            ENTITY_GLOBAL.Instance.COD_MEDICO = Convert.ToInt32(listaEpi[0].IdPersonalSalud);
                            ENTITY_GLOBAL.Instance.FECHA_FIRMA = Convert.ToString(listaEpi[0].FechaFirma);
                            epiAtencionObjSave.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                            epiAtencionObjSave.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                            epiAtencionObjSave.EpisodioClinico = listaEpi[0].EpisodioClinico;
                            epiAtencionObjSave.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                            epiAtencionObjSave.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                            epiAtencionObjSave.Accion = "COMPARTIDO";
                            long resultFormComp = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjSave);
                            if (resultFormComp < 0)
                            {
                            }

                            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                            ////////

                            objEpiAtencionSelecc = getVW_ATENCIONPACIENTE_GENERAL_SELECC();
                            objEpiAtencionSelecc.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                            objEpiAtencionSelecc.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                            objEpiAtencionSelecc.EpisodioClinico = listaEpi[0].EpisodioClinico;
                            objEpiAtencionSelecc.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                            objEpiAtencionSelecc.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                            Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = objEpiAtencionSelecc;

                            ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                            ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                            //X.Msg.Notify("Ventana de Mensajes ",
                            //"Satisfactoriamente se " + "Registro "+ ". Nuevo Episodio Atención : " + String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();

                            return showMensajeNotify("Ventana de Mensajes",
                                "Registro satisfactorio de " + mensajeFinal + ". Código Transacción: " +
                                UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                                listaEpi[0].EpisodioAtencion,
                                listaEpi[0].IdEpisodioAtencion, 0, ""), "INFO");

                        }
                    }

                    ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";
                    // X.Msg.Alert("Mensajes ", "Seleccione Episodio Clínico").Show();
                }
                else
                {
                    X.Msg.Alert("Ventana de Validación", "Por favor seleccione Episodio Clínico a Continuar...").Show();

                    //ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                }
            }
            else if (accion == "Nuevo")
            {
                SS_HC_EpisodioAtencion epiAtencionClinicoSave = new SS_HC_EpisodioAtencion();
                epiAtencionClinicoSave.UnidadReplicacion = seleccion.UnidadReplicacion;
                epiAtencionClinicoSave.UnidadReplicacionEC = seleccion.UnidadReplicacion;
                epiAtencionClinicoSave.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                epiAtencionClinicoSave.CodigoOA = seleccion.CodigoOA;
                epiAtencionClinicoSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionClinicoSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionClinicoSave.IdEpisodioAtencion = -1;
                epiAtencionClinicoSave.EpisodioClinico = -1;

                string mensage = "";
                /////////////////ADD;             

                PERSONAMAST personaTemp = getPERSONAMAST_SELECC();
                SS_GE_Paciente pacienteTemp = getSS_GE_Paciente_SELECC();
                SS_HC_EpisodioClinico EpiClinicoTemp = getSS_HC_EpisodioClinico_SELECC();
                SS_HC_EpisodioAtencion EpiAtencionTemp = null;
                SS_HC_AsignacionMedico asigmedicoTemp = getSS_HC_AsignacionMedico_SELECC();

                List<SS_HC_EpisodioAtencion> listaEpiAtencionTemp = new List<SS_HC_EpisodioAtencion>();
                if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
                {
                    EpiAtencionTemp = getSS_HC_EpisodioAtencion_SELECC();
                    EpiAtencionTemp.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                    EpiAtencionTemp.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                    //ADD 15/09
                    EpiAtencionTemp.IdUnidadServicio = UnidadServicioAux;
                    EpiAtencionTemp.IdEstablecimientoSalud = EstablecimientoAux;

                    listaEpiAtencionTemp.Add(EpiAtencionTemp);
                }

                epiAtencionClinicoSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                registro = SvcEpisodioAtencion.setPreMantenimiento(personaTemp, pacienteTemp, asigmedicoTemp,
                    EpiClinicoTemp, listaEpiAtencionTemp);
                if (registro > 0)
                {
                    //////////////////////Guardar Episodio Clinico
                    if (EpiAtencionTemp != null)
                    {
                        epiAtencionClinicoSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                    }
                    epiAtencionClinicoSave.Accion = "EPISODIOCLINICO";
                    //registro = SvcFormularioAnamnesisAP.setMantAnamnesisAP(objAnamnesis_AP);
                    registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionClinicoSave);
                    if (registro > 0)
                    {
                        ENTITY_GLOBAL.Instance.EpisodioClinico = Convert.ToInt32(registro);

                        SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                        epiAtencionSave.UnidadReplicacion = seleccion.UnidadReplicacion;
                        epiAtencionSave.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                        epiAtencionSave.CodigoOA = seleccion.CodigoOA;
                        epiAtencionSave.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;
                        epiAtencionSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                        epiAtencionSave.EpisodioClinico = Convert.ToInt32(seleccion.EpisodioClinico);

                        ////////////////////////////ADD
                        epiAtencionSave.TipoEpisodio = "EPISODIO";
                        if (Session["TIPOTRABAJADOR_ACTUAL"] != null)
                        {
                            epiAtencionSave.TipoTrabajador = "" + Session["TIPOTRABAJADOR_ACTUAL"];
                        }
                        ///////////////////////////////
                        epiAtencionSave.Accion = "INSERT";

                        if (EpiAtencionTemp != null)
                        {
                            //CONTROL DE ESPECIALIDAD SELECCIONADA (Afecta a médico) //ADD 23/09/15
                            epiAtencionSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                            Nullable<int> idEspecialidadAux = EpiAtencionTemp.IdEspecialidad;
                            if (UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL") != null)
                            {
                                int idEspecialidadTemp = (int)UTILES_MENSAJES.getParametro_Form("ESPECIALIDADHCE_SEL");
                                if (idEspecialidadTemp > 0)
                                {
                                    idEspecialidadAux = idEspecialidadTemp;
                                }
                            }
                            epiAtencionSave.IdEspecialidad = idEspecialidadAux;
                            ///////////////////////////////////////////////////////////////
                            epiAtencionSave.IdOrdenAtencion = EpiAtencionTemp.IdOrdenAtencion;
                            epiAtencionSave.LineaOrdenAtencion = EpiAtencionTemp.LineaOrdenAtencion;
                            epiAtencionSave.TipoOrdenAtencion = EpiAtencionTemp.TipoOrdenAtencion;
                            epiAtencionSave.TipoAtencion = EpiAtencionTemp.TipoAtencion;
                            //epiAtencionSave.IdPersonalSalud = EpiAtencionTemp.IdPersonalSalud;
                            //epiAtencionSave.IdUnidadServicio = EpiAtencionTemp.IdUnidadServicio;
                            //epiAtencionSave.IdEstablecimientoSalud = EpiAtencionTemp.IdEstablecimientoSalud;                                                                                  
                        }
                        //ADD ref Unidad Serv 21/09/15
                        epiAtencionSave.IdUnidadServicio = UnidadServicioAux;
                        epiAtencionSave.IdEstablecimientoSalud = EstablecimientoAux;
                        ////////////////
                        epiAtencionSave.IdPersonalSalud = seleccion.IdPersonalSalud;

                        registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionSave);

                        ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO";

                        if (registro > 0)
                        {
                            epiAtencionSave.IdEpisodioAtencion = registro;
                            epiAtencionSave.Accion = "LISTARPORID";
                            List<SS_HC_EpisodioAtencion> listaEpi =
                                SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                            ENTITY_GLOBAL.Instance.EpisodioAtencion = registro;
                            ENTITY_GLOBAL.Instance.EpisodioClinicoEstado = 1;
                            if (listaEpi.Count > 0)
                            {
                                objEpiAtencionSelecc = getVW_ATENCIONPACIENTE_GENERAL_SELECC();
                                objEpiAtencionSelecc.UnidadReplicacion = listaEpi[0].UnidadReplicacion;
                                objEpiAtencionSelecc.UnidadReplicacionEC = listaEpi[0].UnidadReplicacionEC;
                                objEpiAtencionSelecc.EpisodioClinico = listaEpi[0].EpisodioClinico;
                                objEpiAtencionSelecc.IdEpisodioAtencion = listaEpi[0].IdEpisodioAtencion;
                                objEpiAtencionSelecc.EpisodioAtencion = listaEpi[0].EpisodioAtencion;
                                Session["VW_ATENCIONPACIENTE_GEN_SELECC"] = objEpiAtencionSelecc;
                                ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                                ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                                //X.Msg.Notify("Ventana de Mensajes ",
                                //  "Satisfactoriamente se " + "Registro" + ". Nuevo Episodio Clínico y Atención : "
                                //+ String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();
                                return showMensajeNotify("Ventana de Mensajes",
                                    "Registro satisfactorio de Episodio NUEVO . Código Transacción: " +
                                    UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                                    listaEpi[0].EpisodioAtencion,
                                    listaEpi[0].IdEpisodioAtencion, 0, ""), "INFO");

                            }
                        }
                    }
                }
            }
            else if (accion == "Finalizar")
            {

                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = seleccion.EpisodioClinico;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = seleccion.EpisodioAtencion;

                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = seleccion.UnidadReplicacion;
                epiAtencionSave.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                epiAtencionSave.CodigoOA = seleccion.CodigoOA;
                epiAtencionSave.UsuarioModificacion = ENTITY_GLOBAL.Instance.USUARIO;
                epiAtencionSave.IdEpisodioAtencion = (long)seleccion.EpisodioAtencion;
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(seleccion.EpisodioClinico);

                //ADD ref Unidad Serv 21/09
                epiAtencionSave.IdUnidadServicio = UnidadServicioAux;
                epiAtencionSave.IdEstablecimientoSalud = EstablecimientoAux;

                epiAtencionSave.Accion = "FINALIZAATENCION";

                registro = SvcEpisodioAtencion.setMantenimiento(epiAtencionSave);

                //X.Msg.Notify("Ventana de Mensajes ", "Satisfactoriamente se " + "Registro" + ". Episodio de Atención Finalizado: " + String.Format("{0:00000}", registro)).Show();
                return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio FINALIZADO . Código Transacción: " +
                    UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinico,
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                    ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");

            }
            else if (accion == "VISTA")
            {
                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "VISTA";
                //X.Msg.Notify("Ventana de Mensajes ", "" + "Registro" + ". Episodio de Atención Solo Lectura: " + String.Format("{0:00000}", registro)).Show();
                /////////////////
                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                epiAtencionSave.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioClinico);
                epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(ENTITY_GLOBAL.Instance.EpisodioAtencion);
                epiAtencionSave.Accion = "LISTARPORID";
                List<SS_HC_EpisodioAtencion> listaEpi =
                    SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                if (listaEpi.Count > 0)
                {
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                    //X.Msg.Notify("Ventana de Mensajes ",
                    //  "Satisfactoriamente se " + "Registro" + ". Nuevo Episodio Clínico y Atención : "
                    //+ String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();
                    return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio en Modo - SÓLO LECTURA. Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo,
                        ENTITY_GLOBAL.Instance.EpisodioAtencionPrim,
                        ENTITY_GLOBAL.Instance.EpisodioAtencion, 0, ""), "INFO");

                }

            }
            else if (accion == "UPDATE")
            {
                ENTITY_GLOBAL.Instance.VistaEpisodioClinico = seleccion.EpisodioClinico;
                ENTITY_GLOBAL.Instance.VistaEpisodioAtencion = seleccion.EpisodioAtencion;
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";
                /////////////////
                SS_HC_EpisodioAtencion epiAtencionSave = new SS_HC_EpisodioAtencion();
                epiAtencionSave.UnidadReplicacion = seleccion.UnidadReplicacion;
                epiAtencionSave.IdPaciente = Convert.ToInt32(seleccion.IdPaciente);
                epiAtencionSave.EpisodioClinico = Convert.ToInt32(seleccion.EpisodioClinico);
                epiAtencionSave.IdEpisodioAtencion = Convert.ToInt64(seleccion.EpisodioAtencion);
                epiAtencionSave.Accion = "LISTARPORID";
                List<SS_HC_EpisodioAtencion> listaEpi =
                    SvcEpisodioAtencion.listarSS_HC_EpisodioAtencion(epiAtencionSave, 0, 0);
                if (listaEpi.Count > 0)
                {
                    ENTITY_GLOBAL.Instance.EpisodioAtencionPrim = listaEpi[0].EpisodioAtencion;
                    ENTITY_GLOBAL.Instance.EpisodioClinicoCodigo = listaEpi[0].FlagFirma;  //AUX CODIGO EPI CLINICO
                    //X.Msg.Notify("Ventana de Mensajes ",
                    //  "Satisfactoriamente se " + "Registro" + ". Nuevo Episodio Clínico y Atención : "
                    //+ String.Format("{0:00000}", listaEpi[0].EpisodioAtencion)).Show();
                    return showMensajeNotify("Ventana de Mensajes",
                    "Registro de Episodio en Modo - MODIFICAR . Código Transacción: " +
                        UTILES_MENSAJES.getCodigoTransaccionHCE(seleccion.EpisodioClinico,
                        seleccion.EpisodioAtencion,
                        seleccion.EpisodioAtencion, 0, ""), "INFO");

                }
            }
            return this.Direct();
        }




        public System.Web.Mvc.ActionResult getGrillaUnidadSer(int start, int limit,
            string descripcion, string codigo, string establecimiento, string tipoAtencion, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - getGrillaUnidadSer - Entrar");
            Log.Debug("BandejaMedicoController - getGrillaUnidadSer - start {A}, limit {B},descripcion {C}, hay mas parametros", start, limit, descripcion);
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                //ConsultaCita();
                var Listar = new List<SS_HC_UnidadServicio>();

                var LocalEnty = new SS_HC_UnidadServicio();

                LocalEnty.Descripcion = getValorFiltroStr(descripcion);
                LocalEnty.Codigo = getValorFiltroStr(codigo);

                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                //Si la búsqueda proviene de filtros
                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

                if (establecimiento != null)
                {
                    LocalEnty.IdEstablecimientoSalud = Convert.ToInt32(getValorFiltroInt(establecimiento));
                }
                if (tipoAtencion != null)
                {
                    LocalEnty.IndicadorTriaje = Convert.ToInt32(getValorFiltroInt(tipoAtencion)); //AUX 
                }
                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
                {
                    LocalEnty.IdUnidadServicio = 5;
                }
                else
                {
                    LocalEnty.IdUnidadServicio = 1;
                }

                LocalEnty.Accion = "LISTARPAG";
                int cantElementos = SvcUnidadServicio.setMantenimiento(LocalEnty);
                if (cantElementos > 0)
                {
                    LocalEnty.Accion = "LISTARPAG";
                    Listar = SvcUnidadServicio.listarUnidadServicio(LocalEnty, inicio, final);
                }
                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - getGrillaUnidadSer - Bloque Catch");
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

        public System.Web.Mvc.ActionResult SeleccionadorUnidadServicio(String MODO, String campoEvento,
            String establecimiento, Nullable<int> tipoAtencion, String accionSeleccion, String accionListado)
        {
            Log.Information("BandejaMedicoController - SeleccionadorUnidadServicio - Entrar");
            Log.Debug("BandejaMedicoController - SeleccionadorUnidadServicio - MODO {A}, campoEvento {B}, establecimiento {C}, tipoAtencion {D} ,accionSeleccion {E}, accionListado {F}"
                                    , MODO, campoEvento, establecimiento, tipoAtencion, accionSeleccion, accionListado);
            SS_HC_UnidadServicio obj = new SS_HC_UnidadServicio();
            obj.Accion = accionSeleccion;
            obj.Codigo = campoEvento;
            obj.IdEstablecimientoSalud =
                Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento);


            obj.IndicadorTriaje = tipoAtencion;  //AUX para tipo Atención

            return crearWindowRegistro("Procesos/SeleccionadorUnidadServicio", obj, "");
        }
        public System.Web.Mvc.ActionResult getSeleccionUnidadServicioNuevoEpi(String MODO,
            int idEstab, int idUnidadServicio, String cod, String descripcion, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionUnidadServicioNuevoEpi - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionUnidadServicioNuevoEpi - MODO {A}, idEstab {B}, idUnidadServicio {C}, cod {D} ,descripcion {E}, idWindow {F}"
                                    , MODO, idEstab, idUnidadServicio, cod, descripcion, idWindow);

            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var txt = X.GetCmp<TextField>("txtEventoUnidServicioNuevoEpiHCE");
            txt.SetValue(idUnidadServicio);

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult getSeleccionUnidadServicioNuevaVisita(String MODO,
            int idEstab, int idUnidadServicio, String cod, String descripcion, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionUnidadServicioNuevaVisita - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionUnidadServicioNuevaVisita - MODO {A}, idEstab {B}, idUnidadServicio {C}, cod {D} ,descripcion {E}, idWindow {F}"
                                    , MODO, idEstab, idUnidadServicio, cod, descripcion, idWindow);
            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var txt = X.GetCmp<TextField>("txtEventoUnidServicioNuevaVisitaHCE");
            txt.SetValue(idUnidadServicio);

            return this.Direct();
        }
        public System.Web.Mvc.ActionResult getSeleccionUnidadServicioNuevoEpiTecMedico(String MODO,
            int idEstab, int idUnidadServicio, String cod, String descripcion, String idWindow)
        {
            Log.Information("BandejaMedicoController - getSeleccionUnidadServicioNuevoEpiTecMedico - Entrar");
            Log.Debug("BandejaMedicoController - getSeleccionUnidadServicioNuevoEpiTecMedico - MODO {A}, idEstab {B}, idUnidadServicio {C}, cod {D} ,descripcion {E}, idWindow {F}"
                                    , MODO, idEstab, idUnidadServicio, cod, descripcion, idWindow);

            var win = X.GetCmp<Window>(idWindow);
            if (win != null)
            {
                win.Hide();
            }
            var txt = X.GetCmp<TextField>("txtEventoUnidServicioNuevoEpiTecMedicoHCE");
            txt.SetValue(idUnidadServicio);

            return this.Direct();
        }

        #endregion
        /**combos**/
        public System.Web.Mvc.ActionResult Departamentos(string pais, string departamento, string Accion)
        {
            Log.Information("BandejaMedicoController - Departamentos - Entrar");
            Log.Debug("BandejaMedicoController - Departamentos - pais {A}, departamento {B}, Accion {C}"
                                    , pais, departamento, Accion);
            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboMiscelaneoLista.GetComboGenericoTxtDos(pais, departamento, "", "", Accion));
        }
        public System.Web.Mvc.ActionResult Provincias(string departamento, string provincia, string Accion)
        {
            Log.Information("BandejaMedicoController - Provincias - Entrar");
            Log.Debug("BandejaMedicoController - Provincias - departamento {A}, provincia {B}, Accion {C}"
                                    , departamento, provincia, Accion);
            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboMiscelaneoLista.GetComboGenericoTxtDos(departamento, provincia, "", "", Accion));
        }
        public System.Web.Mvc.ActionResult Zona(string departamento, string provincia, string Accion)
        {
            Log.Information("BandejaMedicoController - Zona - Entrar");
            Log.Debug("BandejaMedicoController - Zona - departamento {A}, provincia {B}, Accion {C}"
                                    , departamento, provincia, Accion);
            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboMiscelaneoLista.GetComboGenericoTxtDos(departamento, provincia, "", "", Accion));
        }
        /***/
        public System.Web.Mvc.ActionResult showMensajeNotify(String titulo, String message, String tipo, String testMessage = "testMessage")
        {
            Log.Information("BandejaMedicoController - showMensajeNotify - Entrar");
            Log.Debug("BandejaMedicoController - showMensajeNotify - titulo {A}, message {B}, tipo {C}"
                                    , titulo, message, tipo);
            //Tipo: {"INFO", "WARNING", "ERROR", "QUESTION"}
            //X.Msg.Notify(titulo, message).Show();


            NotificationAlignConfig Align = new NotificationAlignConfig();

            if (testMessage != "testMessage")
            {
                Align.ElementAnchor = AnchorPoint.Center;
                Align.TargetAnchor = AnchorPoint.Center;
            }
            else
            {
                Align.OffsetY = -400;
            }

            //OffsetY = -400,

            X.Msg.Notify(new NotificationConfig
            {
                Title = titulo,
                Icon = (tipo == "WARNING" ? Icon.Error : (tipo == "ERROR" ? Icon.Error : Icon.Information)),
                AlignCfg = Align,
                Html = message,
                Cls = testMessage
                //AnimEl = this.GetCmp<Button>("Button8").ClientID,
                /*Fn = new JFunction
                {
                    Fn = "accionFinal"
                }*/
            }).Show();
            //return this.Store("1");
            return this.Direct();
        }

        /*SALIR DEL SISTEMA**/
        public System.Web.Mvc.ActionResult eventoSalirSistemas(string indicador)
        {
            Log.Information("BandejaMedicoController - eventoSalirSistemas - Entrar");
            Log.Debug("BandejaMedicoController - eventoSalirSistemas - indicador {A}", indicador);
            return this.RedirectToAction("Index", "Login");
        }

        //Agregado Joel
        public System.Web.Mvc.ActionResult ValidarPassworddd(string IdUsuario, string IdPasswordAntiguo, string pwd1, string pwd2)
        {
            try
            {
                Log.Information("BandejaMedicoController - ValidarPassworddd - Entrar");
                //  ENTITY_GLOBAL BE_Global = new ENTITY_GLOBAL();
                var BE_Global = new ENTITY_GLOBAL();
                VW_PERSONAPACIENTE BE_Paciente = new VW_PERSONAPACIENTE();
                ENTITY_GLOBAL.Instance.APLICATIVOID = 1;
                ENTITY_GLOBAL.Instance.APPCODIGO = "SP4W";
                //ENTITY_GLOBAL.Instance.UnidadReplicacion = "LIMA";
                ENTITY_GLOBAL.Instance.NIVEL = 0;
                ENTITY_GLOBAL.Instance.MODULO = "BE";
                //    ENTITY_GLOBAL.Instance.HostName = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                ENTITY_GLOBAL objENTITY_GLOBAL = ENTITY_GLOBAL.Instance;
                string UnidReplica = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                var Listar = new List<SG_Agente>();
                SG_Agente objUsuario = new SG_Agente();
                objUsuario.ACCION = "VALIDARLOGIN";
                objUsuario.CodigoAgente = IdUsuario;
                objUsuario.Clave = IdPasswordAntiguo;
                Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);

                if (Listar.Count == 0)
                {
                    //var field = X.GetCmp<TextField>("taAlerts");
                    //field.SetValue("Usuar");
                    //eventoPostFormulario(true, "");
                    //return showMensajeNotifyData("Error", "Usuario y/o Contraseña No existe", "ERROR", false);

                    return showMensajeBox("Sucedio un error. No coincide la contraseña actual con la ya registrada.", "Mensaje", "ERROR", "");

                }

                Boolean validoLogin = false;
                if (Listar.Count > 0)
                {
                    validoLogin = true;
                    foreach (SG_Agente objEntity in Listar)
                    {
                        objUsuario = objEntity;
                    }
                }

                if (validoLogin)
                {
                    int resultado = 0;
                    String accion = "";
                    String message = "";
                    String tipoMsg = "INFO";
                    String tituloMsg = "Mensaje";
                    string MODO = "UPDATE";
                    if (MODO == "UPDATE")
                    {
                        objUsuario.ACCION = "UPDATE";
                        accion = "modificó";
                    }

                    if (objUsuario != null)
                    {
                        if (IdPasswordAntiguo != pwd2)
                        {
                            if (pwd1 == pwd2)
                            {
                                objUsuario.Clave = pwd2;
                                resultado = SvcSG_Agente.setMantenimiento(objUsuario);
                            }
                            else
                            {

                                return showMensajeBox("Sucedio un error. Las contraseñas no coinciden.", "Mensaje", "ERROR", "");

                            }

                        }
                        else
                        {

                            return showMensajeBox("Sucedio un error. Las contraseña nueva no pueder ser igual a la actual.", "Mensaje", "ERROR", "");

                        }

                    }
                    //
                    var win = X.GetCmp<Window>("winSelectFile");
                    if (win != null)
                    { win.Hide(); }
                    Session["User"] = objUsuario.IdAgente;

                    string irmodulo;
                    string cbModulos = "HCE";
                    //if (p.Value.ToString().Trim() == "HCE")
                    if ((cbModulos + "").Trim() == "HCE")
                    {
                        ENTITY_GLOBAL.Instance.MODULO = "BE";
                        irmodulo = "BandejaMedico";
                        ENTITY_GLOBAL.Instance.OPCION_PADRE = "3000"; //OBS: HArdcode: poner en parámetro
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.MODULO = "GS";
                        irmodulo = "Gestion";
                        ENTITY_GLOBAL.Instance.OPCION_PADRE = "3033";//OBS: HArdcode: poner en parámetro
                    }
                    string mensaje = "Contraseña modificado correctamente";
                    //return showMensajeBox(mensaje, "Éxito", "INFO");
                    return showMensajeNotify("Éxito", mensaje, "INFO");
                    return this.RedirectToAction("Index", irmodulo);

                }
                else
                    return showMensajeBox("No se pudo hallar usuario con el nombre o clave especificados", "ERROR", "REINICIAR");

            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - ValidarPassworddd - Bloque Catch");
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

        public System.Web.Mvc.ActionResult showMensajeNotifyData(String titulo, String message, String tipo, bool esException)
        {
            Log.Information("BandejaMedicoController - showMensajeNotifyData - Entrar");
            Log.Debug("BandejaMedicoController - showMensajeNotifyData - titulo {A}, message {B}, tipo {C}, esException {D}"
                                    , titulo, message, tipo, esException);
            NotificationAlignConfig Align = new NotificationAlignConfig()
            {
                OffsetY = -500,

            };
            X.Msg.Notify(new NotificationConfig
            {
                Title = titulo,
                Icon = (tipo == "WARNING" ? Icon.Error : (tipo == "ERROR" ? Icon.Error : Icon.Information)),
                AlignCfg = Align,
                Html = message,
                //AnimEl = this.GetCmp<Button>("Button8").ClientID,
                /*Fn = new JFunction
                {
                    Fn = "accionFinal"
                }*/
            }).Show();
            //return this.Store("1");
            if (tipo == "ERROR")
            {
                List<ENTITY_MENSAJES> listaMsg_error = new List<ENTITY_MENSAJES>();
                listaMsg_error.Add(new ENTITY_MENSAJES
                {
                    DESCRIPCION = message,
                    TITULO = titulo,
                    ICON = "ERROR",
                    IDCOMPONENTE = "",
                    TIPOMSG = (esException ? "EXCEPTION" : "ERROR"),
                    NIVEL = 1
                });
                return this.Store(listaMsg_error);
            }
            else
            {
                return this.Direct();
            }
        }

        private void eventoPostFormulario(Boolean succes, String indica)
        {
            Log.Information("BandejaMedicoController - eventoPostFormulario - indica");
            Log.Debug("BandejaMedicoController - eventoPostFormulario - succes {A}, indica {B}"
                                    , succes, indica);
            if (succes)
            {
                this.GetCmp<Button>("cmdGuardar").Disabled = true;
                this.GetCmp<Button>("btnOnEdit").Hidden = false;
                this.GetCmp<Button>("btnCancel").Hidden = true;
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            }
            else
            {
                this.GetCmp<Button>("cmdGuardar").Disabled = false;
            }
            // this.GetCmp<Button>("cmdGuardar").Text = "Actualizar";
        }

        public System.Web.Mvc.ActionResult eventoPassword(string indicador)
        {
            Log.Information("BandejaMedicoController - eventoPassword - indica");
            ENTITY_GLOBAL objModel = new ENTITY_GLOBAL();
            ENTITY_GLOBAL.Instance.APLICATIVOID = 1;
            ENTITY_GLOBAL.Instance.APPCODIGO = "SP4W";
            objModel.USUARIO = ENTITY_GLOBAL.Instance.USUARIO;
            string Form = "ValidarLogin";
            return crearWindowRegistro(Form, objModel, "");
        }
        //Fin agregado joel

        /*ABOUT DEL SISTEMA**/
        public System.Web.Mvc.ActionResult eventoAbout(string indicador)
        {
            Log.Information("BandejaMedicoController - eventoAbout - indica");
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

        /** MOTOR DE REGLAS **/
        /*Regla : SP_RGN_03_AlertaCierreAtencion**/
        public System.Web.Mvc.ActionResult POSaludFirmaMedico(int PacienteID, int valor, String regla, String arrays)
        {
            Log.Information("BandejaMedicoController - POSaludFirmaMedico - Entrar");
            Log.Debug("BandejaMedicoController - POSaludFirmaMedico - PacienteID {A}, valor {B}, regla {C}, arrays {D}"
                                    , PacienteID, valor, regla, arrays);

            //String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
            //                   (String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
            String PARAM = ENTITY_GLOBAL.Instance.ACTIVORULE;
            /**/
            VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
            ENTITY_GLOBAL.Instance.INDICA_TECNOLOGO_MIKASA = valor;
            if (valor == 77)
            {
                Session["TECNOLOGO_MIKASA"] = "Asignar Medico ";
            }
            else
            {
                Session["TECNOLOGO_MIKASA"] = "";
            }

            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
            }
            ////////////////////////
            var Listar = new List<PERSONAMAST>();
            var LocalEnty = new PERSONAMAST();
            var objDatos = new PERSONAMAST();
            LocalEnty.ACCION = "LISTARPACIENTE";
            LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
            Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
            if (Listar.Count > 0)
            {
                Session["Ssesion_ListarPaciiente"] = Listar;
                foreach (PERSONAMAST objPersona in Listar)
                {
                    objDatos = objPersona;
                    ENTITY_GLOBAL.Instance.NombreCompletoPaciente = objDatos.NombreCompleto;
                    Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                    if (vistaGenSelec.Origen == "Consulta")
                    {
                        Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                    }
                    else if (vistaGenSelec.Origen == "Emergencia" && ENTITY_GLOBAL.Instance.COD_BANDEJA == "HOSPITALIZACION")
                    {
                        Session["COMPONENTE_LEVI"] = "    Hospitalización  ";
                    }
                    else if (vistaGenSelec.Origen == "Emergencia")
                    {
                        Session["COMPONENTE_LEVI"] = "    Emergencia  ";
                    }
                    else if (vistaGenSelec.Origen == "Interconsulta")
                    {
                        Session["COMPONENTE_LEVI"] = "    Interconsulta  ";
                    }
                    else if (vistaGenSelec.Origen == "Relevo")
                    {
                        Session["COMPONENTE_LEVI"] = "    Relevo  ";
                    }
                    else if (vistaGenSelec.Origen == "RE-Ingreso")
                    {
                        Session["COMPONENTE_LEVI"] = "    RE-Ingreso  ";
                    }
                    else
                    {
                        var componente = vistaGenSelec.ComponenteNombre;
                        if (componente == null)
                        {
                            Session["COMPONENTE_LEVI"] = "";
                        }
                        else
                        {
                            Session["TECNOLOGO_MIKASA"] = "Asignar Medico ";
                            Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                            ENTITY_GLOBAL.Instance.NOMBRE_PROCEDIMIENTO = componente;
                        }
                    }


                    ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelec.TipoOrdenAtencion;
                    ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelec.CodigoHC;
                    ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelec.CodigoOA;
                    ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelec.Componente;
                    int edad = 0;
                    DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                    DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                    if (nacimiento != null)
                    {
                        edad = DateTime.Now.Year - nacimiento.Year;
                        if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                            edad = edad - 1;

                        //if (edad < 0)
                        //{
                        //    edad = 0;
                        //}
                    }
                    //DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                    //DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                    //int edad = DateTime.Today.AddTicks(-nacimiento.Ticks).Year - 1;


                    Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                }
            }
            /**/
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
                    objEnv.ValorCodigo1 = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                    objEnv.ValorEntero1 = ENTITY_GLOBAL.Instance.PacienteID;
                    objEnv.ValorEntero2 = ENTITY_GLOBAL.Instance.EpisodioClinico;
                    objEnv.ValorEntero3 = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;

                    objEnv.ACCION = "FIRMAMEDICO";
                    var Result = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);

                    /*******INVOCA REGLA*****************************/
                    MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                    objRegla.CodigoTabla = regla;
                    if (Result.Count > 0)
                    {
                        /*
                        objRegla.UnidadReplicacion = Result[0].ValorCodigo1;                
                        objRegla.EpisodioClinico = (int)Result[0].ValorEntero2;
                        objRegla.EpisodioAtencion = (int)Result[0].ValorEntero3;
                        objRegla.TipoAtencion = (int)Result[0].ValorEntero4;
                        */
                        objRegla.Dias = (int)Result[0].ValorEntero6;
                        objRegla.FechaAtencion = (Result[0].ValorFecha != null ? ((DateTime)(Result[0].ValorFecha)) : DateTime.Now);
                        objRegla.Estados = (int)Result[0].ValorEntero5;
                    }
                    objRegla = ServiciosRules.POSaludFirmaMedico(objRegla);

                    /*************************************************************/
                    ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                    mostMensaje.DESCRIPCION = "Se excedió el periodo de tiempo permitido para la modificación de la Atención.";
                    if (objRegla != null)
                    {
                        mostMensaje.ESTADOBOOL = objRegla.resultBool;
                        if (objRegla.resultBool != null ? Convert.ToBoolean(objRegla.resultBool) : false)
                        {
                            //...                
                            objEnv.ACCION = "FIRMAMEDICO_UP";
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
                    Log.Information("BandejaMedicoController - POSaludFirmaMedico - Bloque Catch");
                    Log.Error(ex, ex.Message);

                }
                return this.Direct();
            }
            else
            {
                return this.Direct();
            }
        }

        /**Regla : SP_RGN_04_AlertaCostoPacienteMes*/
        public System.Web.Mvc.ActionResult POSaludConsultaMes(int PacienteID, int valor, String regla, String arrays)
        {
            Log.Information("BandejaMedicoController - POSaludConsultaMes - Entrar");
            Log.Debug("BandejaMedicoController - POSaludConsultaMes - PacienteID {A}, valor {B}, regla {C}, arrays {D}"
                                    , PacienteID, valor, regla, arrays);
            /**********ADD ********/
            VW_ATENCIONPACIENTE_GENERAL vistaGenSelec = new VW_ATENCIONPACIENTE_GENERAL();
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                vistaGenSelec = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
            }
            var Listar = new List<PERSONAMAST>();
            var LocalEnty = new PERSONAMAST();
            var objDatos = new PERSONAMAST();
            LocalEnty.ACCION = "LISTARPACIENTE";
            LocalEnty.Persona = (int)ENTITY_GLOBAL.Instance.PacienteID;
            LocalEnty.Persona = (int)vistaGenSelec.IdPaciente;
            Listar = SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList();
            if (Listar.Count > 0)
            {
                Session["Ssesion_ListarPaciiente"] = Listar;
                foreach (PERSONAMAST objPersona in Listar)
                {
                    objDatos = objPersona;
                    Session["NOMBREPACIENTE_HEAD"] = "Paciente:  " + objDatos.NombreCompleto;
                    if (vistaGenSelec.Origen == "Consulta")
                    {
                        Session["COMPONENTE_LEVI"] = "    Consulta Externa  ";
                    }
                    else
                    {
                        var componente = vistaGenSelec.ComponenteNombre;
                        Session["COMPONENTE_LEVI"] = "    Procedimiento:  " + componente.ToString();
                    }

                    ENTITY_GLOBAL.Instance.INDICA_TIPO_ORDENATENCION = (int)vistaGenSelec.TipoOrdenAtencion;
                    ENTITY_GLOBAL.Instance.INDICA_COD_HC = (string)vistaGenSelec.CodigoHC;
                    ENTITY_GLOBAL.Instance.INDICA_OA = (string)vistaGenSelec.CodigoOA;
                    ENTITY_GLOBAL.Instance.INDICA_COD_COMPONENTE = (string)vistaGenSelec.Componente;
                    int edad = 0;
                    try
                    {
                        DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                        DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                        if (nacimiento != null)
                        {
                            edad = DateTime.Now.Year - nacimiento.Year;
                            if (DateTime.Now.DayOfYear < nacimiento.DayOfYear)
                                edad = edad - 1;

                            //if (edad < 0)
                            //{
                            //    edad = 0;
                            //}
                        }
                    }
                    catch (Exception e)
                    {
                        Log.Information("BandejaMedicoController - POSaludConsultaMes - Bloque Catch");
                        Log.Error(e, e.Message);
                    }
                    //DateTime dat = Convert.ToDateTime(objDatos.FechaNacimiento);
                    //DateTime nacimiento = new DateTime(dat.Year, dat.Month, dat.Day);
                    //int edad = DateTime.Today.AddTicks(-nacimiento.Ticks).Year - 1;
                    Session["EDADPACIENTE_HEAD"] = "    Edad: " + edad.ToString();
                }
            }
            /*****************/


            //    String PARAM = (UTILES_MENSAJES.getParametro_Form("ACTIVORULE") != null ?
            //(String)UTILES_MENSAJES.getParametro_Form("ACTIVORULE") : null);
            String PARAM = ENTITY_GLOBAL.Instance.ACTIVORULE;
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
                    objEnv.ValorCodigo1 = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                    //ES AL ABRIR (Fecha de atenci+on = Fecha Actual)
                    objEnv.ValorFecha = DateTime.Now;
                    objEnv.ACCION = "CONSULTAMES";
                    var Result = SvcMiscelaneos.getRuleGetCollectionStore(objEnv);

                    /*******INVOCA REGLA*****************************/
                    MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                    objRegla.CodigoTabla = regla;
                    if (Result.Count > 0)
                    {
                        objRegla.UnidadReplicacion = Result[0].ValorCodigo1;
                        //objRegla.IdPaciente = (int)Result[0].ValorEntero1;
                        objRegla.Modalidad = (int)Result[0].ValorEntero2;
                        objRegla.Cantidad = (int)Result[0].ValorEntero3;
                    }
                    objRegla = ServiciosRules.POSaludConsultaMes(objRegla);

                    /*************************************************************/
                    ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                    mostMensaje.DESCRIPCION = "El número de atenciones permitidas para el paciente ha sido superado.";
                    if (objRegla != null)
                    {
                        mostMensaje.ESTADOBOOL = objRegla.resultBool;
                    }
                    List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                    msgNoValido.Add(mostMensaje);
                    //return this.Store(listaResources);
                    return showMensajeBotton(msgNoValido, "", "");
                }
                catch (Exception ex)
                {
                    Log.Information("BandejaMedicoController - POSaludConsultaMes - Bloque Catch");
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
        public Boolean POSaludEmergenciaEsperaAlter(VW_ATENCIONPACIENTE_GENERAL objPaciente, int valor, String regla)
        {
            Boolean resultRegla = false;
            try
            {
                Log.Information("BandejaMedicoController - POSaludEmergenciaEsperaAlter - Entrar");
                Log.Debug("BandejaMedicoController - POSaludEmergenciaEsperaAlter - objPaciente {A}, valor {B}, regla {C}}"
                                        , objPaciente, valor, regla);
                List<MA_MiscelaneosDetalle> objLista = new List<MA_MiscelaneosDetalle>();
                /*******INVOCA REGLA*****************************/
                MA_MiscelaneosDetalleRule objRegla = new MA_MiscelaneosDetalleRule();
                objRegla.CodigoTabla = regla;
                if (objPaciente != null)
                {
                    objRegla.UnidadReplicacion = objPaciente.Sucursal;
                    objRegla.IdOrdenAtencion = objPaciente.IdOrdenAtencion;
                    objRegla.TipoAtencion = Convert.ToInt32(objPaciente.TipoAtencion != null ? objPaciente.TipoAtencion : 0);
                    objRegla.FechaInicio = Convert.ToDateTime(objPaciente.FechaInicio != null ? objPaciente.FechaInicio : DateTime.Now);
                    DateTime hoy = DateTime.Now;
                    //CALCULAR AGNOS
                    int agnos = hoy.Year - objRegla.FechaInicio.Year;
                    //CALCULAR MESES
                    int meses = hoy.Month - objRegla.FechaInicio.Month + agnos * 12; //#Meses +/- 12*#AGNOS 
                    //CALCULAR DIAS                       
                    int dias = hoy.DayOfYear - objRegla.FechaInicio.DayOfYear + agnos * 365; //#Meses +/- 12*#AGNOS 
                    objRegla.ValorEntero3 = dias;
                    //CALCULAR HORAS
                    int horas = hoy.Hour - objRegla.FechaInicio.Hour + dias * 24;//#DIAS * # HORASxDÍA
                    objRegla.ValorEntero2 = horas;
                    //CALCULAR MINUTOS
                    int min = hoy.Minute - objRegla.FechaInicio.Minute + horas * 60;//#HORAS*#MINUTOSxHORA
                    objRegla.Minutos = min;

                    objRegla.Prioridad = Convert.ToInt32(objPaciente.IndicadorExamenPrincipal != null ? objPaciente.IndicadorExamenPrincipal : 0);
                }
                //objRegla = ServiciosRules.POSaludEmergenciaEspera(objRegla);

                /*************************************************************/
                ENTITY_MENSAJES mostMensaje = new ENTITY_MENSAJES();
                mostMensaje.DESCRIPCION = "Atención prioritaria.";
                if (objRegla != null)
                    mostMensaje.ESTADOBOOL = objRegla.resultBool;
                List<ENTITY_MENSAJES> msgNoValido = new List<ENTITY_MENSAJES>();
                msgNoValido.Add(mostMensaje);

                resultRegla = objRegla.resultBool != null ? Convert.ToBoolean(objRegla.resultBool) : false;
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - POSaludEmergenciaEsperaAlter - Bloque Catch");
                Log.Error(ex, ex.Message);
            }
            return resultRegla;
        }
        /**Prepara los Códigos Formatos VIEW para recueparar la vista anterior*/
        public Boolean setCodigoFormatosPaginas(String indicadorEtapa, String opcionView)
        {
            Log.Information("BandejaMedicoController - indicadorEtapa - Entrar");
            Log.Debug("BandejaMedicoController - indicadorEtapa - indicadorEtapa {A}, opcionView {B}"
                                    , indicadorEtapa, opcionView);
            Boolean result = true;
            if (opcionView != null)
            {
                if (indicadorEtapa == "GENERAL")
                {
                    String temporal = ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_PREVIA = temporal;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL = opcionView;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_SGTE = null;
                    ENTITY_GLOBAL.Instance.CODOPCION_ULTIMOACTOMED = opcionView;

                }
            }
            return result;
        }
        public System.Web.Mvc.ActionResult initLoadFormatos(String container)
        {
            Log.Information("BandejaMedicoController - initLoadFormatos - Entrar");
            Log.Debug("BandejaMedicoController - initLoadFormatos - container {A}"
                                    , container);
            string containerId = "";
            string text = "0";
            if (ENTITY_GLOBAL.Instance.CODOPCION_ULTIMOACTOMED != null)
            {
                containerId = container;
                text = ENTITY_GLOBAL.Instance.CODOPCION_ULTIMOACTOMED;
                return LoadFormatos(containerId, text);
            }
            else
            {
                return this.Direct();
            }
        }

        /**PARA REPORTES VIEW TOTAL HC**/
        public System.Web.Mvc.ActionResult HCEReportesView_total()
        {
            Log.Information("BandejaMedicoController - HCEReportesView_total - Entrar");
            ENTITY_GENERALHCE objReporte = new ENTITY_GENERALHCE
            {
                IDENTIY_GEN = 1,
                UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion,
                EpisodioClinico = ENTITY_GLOBAL.Instance.EpisodioClinico,
                EpisodioAtencion = ENTITY_GLOBAL.Instance.EpisodioAtencion,
                PacienteID = ENTITY_GLOBAL.Instance.PacienteID,
                //AUX
                //campoStr01 = "localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I",
                campoStr02 = ENTITY_GLOBAL.Instance.CONCEPTO,
                campoStr10 = ENTITY_GLOBAL.Instance.NombreCompletoPaciente
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
            return crearWindowRegistro("HCReportes/HCEReportesView", objReporte, "", "North1");
            //return crearWindowRegistro("HCReportes/HCEReportesView", objReporte, "");            
        }

        /**CARGA LAS PROPEDADES DE PERMISOS DEL FORMATO ***********/
        public bool cargarPermisosFormato(bool activo)
        {
            Log.Information("BandejaMedicoController - cargarPermisosFormato - Entrar");
            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = 0;
            if (activo)
            {
                //SÓLO SE CONSIDERA PARA ESTA SECCIÓN LA SEGURIDAD DE IMPRESIÓN (EQUIVALE A IMP. TODOS)
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
                /*
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
                 */
                int indImpresion = 0;
                int indObligatorio = 0;
                serviceResuls = SvcSeguridadConcepto.ListarSeguridadOpcion(entidaLocal, 0, 0);
                if (serviceResuls.Count > 0)
                {
                    /*
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
                     */
                    indImpresion = Convert.ToInt32(serviceResuls[0].IndicadorImprimir);
                    indObligatorio = Convert.ToInt32(serviceResuls[0].IndicadorObligatorio);
                }

                List<ENTITY_GENERALHCE> listaPermisos = new List<ENTITY_GENERALHCE>();
                ENTITY_GENERALHCE objPermiso = new ENTITY_GENERALHCE();
                /*
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
                 */
                ///ADD PRINT
                listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "IMPRIMIR", campoStr01 = "R", campoInt01 = indImpresion });

                //ADD OBLIGATORIO

                listaPermisos.Add(new ENTITY_GENERALHCE { ACCION = "OBLIGA", campoStr01 = "O", campoInt01 = indObligatorio });

                Session["RECURSOS_PERMISOSFORMATOS"] = listaPermisos;

                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_IMPRESION = indImpresion;

                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_OBLIGATORIO = indObligatorio;

            }
            return true;
        }

        /**OBS:  TIPO DE ATENCIÓN FIJA DE ACUERDO AL LISTADO DE ACTO MÉDICO*/
        public Nullable<int> getTipoAtencionActoMedico(string codigoActoMed)
        {
            Log.Information("BandejaMedicoController - getTipoAtencionActoMedico - Entrar");
            Nullable<int> resultTipoAtencion = null;
            if (codigoActoMed == "MED_AMBULATORIO"
                || codigoActoMed == "TECNOMED_AMBULATORIO"
                )
            {
                resultTipoAtencion = 1;
            }
            else if (codigoActoMed == "MED_EMERGENCIA"
                || codigoActoMed == "TECNOMED_EMERGENCIA"
                || codigoActoMed == "ENFERM_EMERGENCIAS"
                || codigoActoMed == "OBSTET_EMERGENCIAS"
                )
            {
                resultTipoAtencion = 2;
            }
            else if (codigoActoMed == "MED_HOSP_CIRUGIA"
                || codigoActoMed == "TECNOMED_HOSP_CIRUGIA"
                || codigoActoMed == "ENFERM_HOSP_CIRUGIAS"
                || codigoActoMed == "OBSTET_HOSP_CIRUGIAS"
                )
            {
                resultTipoAtencion = 3;
            }
            return resultTipoAtencion;
        }


        public System.Web.Mvc.ActionResult getGrillaNotificacion(int start, int limit,
               string paciente, string tipoBuscar, string idPersonalSalud)
        {
            Log.Information("BandejaMedicoController - getGrillaNotificacion - Entrar");
            Boolean indicaValidacionForm = false;
            try
            {
                ENTITY_GLOBAL.Instance.GRUPO = "";
                //ConsultaCita();
                var Listar = new List<SS_HC_EpisodioNotificaciones_FE>();

                var LocalEnty = new SS_HC_EpisodioNotificaciones_FE();
                LocalEnty.Version = getValorFiltroStr(paciente);
                //LocalEnty.IdPersonalSalud = ENTITY_GLOBAL.Instance.CODPERSONA;

                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;
                //Si la búsqueda proviene de filtros
                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

                LocalEnty.Accion = "LISTARTOTAL";
                //Listar = SvcNotificacion.listarNotificacion(LocalEnty, inicio, final);
                //Listar = SvcEpisodioNotificaciones.EpisodioNotificaciones_Listar(LocalEnty, inicio, final);

                return this.Store(Listar);
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


        public System.Web.Mvc.ActionResult CCEP9917_View()
        {
            Log.Information("BandejaMedicoController - CCEP9917_View - Entrar");
            //ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION;
            return View("VisorReceta/CCEP9917_View", ENTITY_GLOBAL.Instance);//            
        }

        public System.Web.Mvc.ActionResult CCEP9920_View()
        {
            Log.Information("BandejaMedicoController - CCEP9920_View - Entrar");
            //ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION;
            return View("Kardex/CCEP9920_View", ENTITY_GLOBAL.Instance);//            
        }
        public System.Web.Mvc.ActionResult CCEP9922_View()
        {
            Log.Information("BandejaMedicoController - CCEP9922_View - Entrar");
            //ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION;
            return View("DevolucionMedicamento/CCEP9922_View", ENTITY_GLOBAL.Instance);//            
        }





        public System.Web.Mvc.ActionResult Generarpedido(String MODO, String idPaciente)
        {
            Log.Information("BandejaMedicoController - Generarpedido - Entrar");
            //ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION;
            return View("VisorReceta/CCEP9918_View", ENTITY_GLOBAL.Instance);
        }


        public System.Web.Mvc.ActionResult Programar(String MODO, String idPaciente)
        {
            Log.Information("BandejaMedicoController - Programar - Entrar");
            //ENTITY_GLOBAL.Instance.CONCEPTODESCRIPCION;
            return View("ProgramarKardex/CCEP9921_View", ENTITY_GLOBAL.Instance);
        }

        public System.Web.Mvc.ActionResult eventoDispensacion(String codigoOA, DateTime fechacreacion)
        {
            Log.Information("BandejaMedicoController - eventoDispensacion - Entrar");
            ENTITY_GLOBAL.Instance.CODIGOOADISPENSACION = codigoOA;
            ENTITY_GLOBAL.Instance.FECHABANDEJADISPENSACION = fechacreacion;


            var text = "3444";
            var container = "Center1";
            return LoadFormatos(container, text);
        }


        public System.Web.Mvc.ActionResult GrillaListadoMedicamentoPacientes(int start, int limit, string txtFecha1, string txtFecha2,
            string txtCodigoOA, string txtPaciente, string txtMedico, string tipoEstado, string tipoBuscar, string txtCama)
        {
            Log.Information("BandejaMedicoController - GrillaListadoMedicamentoPacientes - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoEvolucionObjetiva - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} ,txtCodigoOA {E}, txtPaciente {F}" +
                            ",txtMedico {G}, tipoEstado {H},tipoBuscar {I}, txtCama {J}"
                        , start, limit, txtFecha1, txtFecha2, txtCodigoOA, txtPaciente, txtMedico, tipoEstado, tipoBuscar, txtCama);
            Boolean indicaValidacionForm = false;
            int cantElementos = 0;
            try
            {
                //ENTITY_GLOBAL.Instance.GRUPO = "";
                //ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_ATENCIONPACIENTEMEDICAMENTO>();
                ENTITY_GLOBAL.Instance.OPCION_STOCK_DEF = 1;
                var LocalEnty = new VW_ATENCIONPACIENTEMEDICAMENTO();

                LocalEnty.FechaCreacion = Convert.ToDateTime(getValorFiltroStr(txtFecha1));         //FECHA INI
                LocalEnty.IngresoFechaRegistro = Convert.ToDateTime(getValorFiltroStr(txtFecha2));  //FECHA FIN

                double PARAFILTROFEcahora = 0;
                decimal PARAFILTROFECHA = (decimal)UTILES_MENSAJES.getParametro_Form("ACTIVIDDIA");
                double nrfec = 0;
                PARAFILTROFEcahora = Convert.ToDouble(PARAFILTROFECHA);
                nrfec = (Convert.ToDateTime(LocalEnty.IngresoFechaRegistro) - Convert.ToDateTime(LocalEnty.FechaCreacion)).TotalDays;

                if (nrfec > PARAFILTROFEcahora)
                {
                    DateTime FechaXX = Convert.ToDateTime(LocalEnty.IngresoFechaRegistro);
                    LocalEnty.FechaCreacion = FechaXX.AddDays(-PARAFILTROFEcahora);
                }


                LocalEnty.NombreCompleto = getValorFiltroStr(txtPaciente);
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);
                LocalEnty.CodigoOA = txtCodigoOA;
                LocalEnty.Medico = txtMedico;
                if (tipoEstado == "-1")
                {
                    LocalEnty.Estado = null;
                }
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;

                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

                LocalEnty.Linea = Convert.ToString(inicio);
                LocalEnty.SubFamilia = Convert.ToString(final);
                LocalEnty.Cama = txtCama.Trim();
                //  LocalEnty.Familia = "CONTARLISTAPAG";
                //  int cantElementos = svcVw_AtencionPacienteMedicamento.setMantenimiento(LocalEnty);
                //   if (cantElementos > 0)
                //  {
                LocalEnty.Familia = "LISTARBAND";
                Listar = svcVw_AtencionPacienteMedicamento.listarVwAtencionPacienteMedicamento(LocalEnty, inicio, final);
                if (Listar.Count > 0)
                {
                    //var ListarDocumento = new List<VW_ATENCIONPACIENTEMEDICAMENTO>();
                    //Listar = Listar.Where(x => x.UsuarioAuditoria == txtCama).ToList();
                    //Listar = Listar.GroupBy(x => x.CodigoOA).Select(grp => grp.First()).ToList();
                    //Listar = Listar.GroupBy(x => x.IdEpisodioAtencion & x.EpisodioClinico).Select(grp =>grp.First()).ToList();
                    if (txtCama.Length > 0)
                    {
                        Listar = Listar.Where(x => x.UsuarioAuditoria == txtCama).ToList();
                    }

                }
                // }

                if (Listar.Count > 0)
                {
                    cantElementos = Convert.ToInt32(Listar[0].CodigoComponente);
                }



                return this.Store(Listar, cantElementos);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoMedicamentoPacientes - Bloque Catch");
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

        public System.Web.Mvc.ActionResult GrillaListadoKardexPacientes(int start, int limit, string txtFecha1, string txtFecha2,
            string txtPaciente, string tipoEstado, string tipoBuscar)
        {
            Log.Information("BandejaMedicoController - GrillaListadoKardexPacientes - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoKardexPacientes - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} , txtPaciente {F}" +
                            ", tipoEstado {H},tipoBuscar {I}"
                        , start, limit, txtFecha1, txtFecha2, txtPaciente, tipoEstado, tipoBuscar);
            Boolean indicaValidacionForm = false;
            try
            {
                //ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_ATENCIONPACIENTEMEDICAMENTO>();

                var LocalEnty = new VW_ATENCIONPACIENTEMEDICAMENTO();

                LocalEnty.FechaCreacion = Convert.ToDateTime(getValorFiltroStr(txtFecha1));
                LocalEnty.IngresoFechaRegistro = Convert.ToDateTime(getValorFiltroStr(txtFecha2));
                LocalEnty.NombreCompleto = getValorFiltroStr(txtPaciente);
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);
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
                LocalEnty.Familia = "LISTARKAR";
                Listar = svcVw_AtencionPacienteMedicamento.listarVwAtencionPacienteMedicamento(LocalEnty, inicio, final);
                // }


                return this.Store(Listar);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoKardexPacientes - Bloque Catch");
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


        public System.Web.Mvc.ActionResult GrillaListadoDevolucionMed(int start, int limit, string txtFecha1, string txtFecha2,
           string txtPaciente, string tipoEstado, string tipoBuscar)
        {
            Boolean indicaValidacionForm = false;
            Log.Information("BandejaMedicoController - GrillaListadoDevolucionMed - Entrar");
            Log.Debug("BandejaMedicoController - GrillaListadoDevolucionMed - start {A}, limit {B}, txtFecha1 {C}, txtFecha2 {D} , txtPaciente {F}" +
                            ", tipoEstado {H},tipoBuscar {I}"
                        , start, limit, txtFecha1, txtFecha2, txtPaciente, tipoEstado, tipoBuscar);
            try
            {

                //ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<VW_ATENCIONPACIENTEMEDICAMENTO>();

                var LocalEnty = new VW_ATENCIONPACIENTEMEDICAMENTO();

                LocalEnty.FechaCreacion = Convert.ToDateTime(getValorFiltroStr(txtFecha1));
                LocalEnty.IngresoFechaRegistro = Convert.ToDateTime(getValorFiltroStr(txtFecha2));
                LocalEnty.NombreCompleto = getValorFiltroStr(txtPaciente);
                LocalEnty.Estado = getValorFiltroInt(tipoEstado);
                if (tipoEstado == "-1")
                {
                    LocalEnty.Estado = null;
                }
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;

                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }

                LocalEnty.Familia = "LISTARKAR";
                Listar = svcVw_AtencionPacienteMedicamento.listarVwAtencionPacienteMedicamento(LocalEnty, inicio, final);



                return this.Store(Listar);
            }
            catch (Exception ex)
            {
                Log.Information("BandejaMedicoController - GrillaListadoDevolucionMed - Bloque Catch");
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

        public System.Web.Mvc.ActionResult SetUsuarioEsp(string usuario)
        {
            Log.Information("BandejaMedicoController - SetUsuarioEsp - Entrar");
            Log.Debug("BandejaMedicoController - SetUsuarioEsp - usuario {A}", usuario);
            ENTITY_GLOBAL.Instance.USUARIOESP = usuario;
            var txt = X.GetCmp<TextField>("CodigoAgente");
            txt.SetValue(usuario);

            SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
            objEspecialidad.Accion = "LISTARPORAGENTE";
            objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA; //AUX  EMPLEADO SALUD
            objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;//AUX  ID AGENTE
            objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;//AUX  ID AGENTE
            objEspecialidad.UsuarioCreacion = usuario;//AUX  CODIGO AGENTE

            List<SS_GE_Especialidad> listaEspecialidad = new List<SS_GE_Especialidad>();
            if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "MED_EMERGENCIA")
            {
                listaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);
            }
            else
            {
                listaEspecialidad = ENTITY_GLOBAL.SESSIONlistaEspecialidad;
            }

            if (listaEspecialidad.Count == 1)
            {
                ENTITY_GLOBAL.Instance.VALOR_ESPECIALIDAD = listaEspecialidad[0].IdEspecialidad;
            }
            else { ENTITY_GLOBAL.Instance.VALOR_ESPECIALIDAD = null; }

            //var cbo = X.GetCmp<ComboBox>("IdCodigo");
            // cbo.GetStore().Reload();


            //  SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboMiscelaneoLista.GetComboGenericoEspecialidad("ROYAL");

            return this.Direct();
        }

        public IEnumerable<DateTime> getFechasRango(DateTime start, DateTime end, bool incuirStart, bool incluirEnd)
        {
            Log.Information("BandejaMedicoController - getFechasRango - Entrar");
            DateTime inicioReal = incuirStart ? start : start.AddDays(1);
            DateTime finalReal = incluirEnd ? end : end.AddDays(-1);
            for (DateTime i = inicioReal; i <= finalReal; i = i.AddDays(1))
            {
                yield return i;
            }
        }

        public class DatosSeguro
        {
            public System.Nullable<int> poliza;
            public string cobertura;
            public string contrato;
            public string modalidad;
        }

        public Task _ { get; set; }
    }
}


