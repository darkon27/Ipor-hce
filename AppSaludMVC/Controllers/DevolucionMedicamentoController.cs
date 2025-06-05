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
using Serilog;

namespace AppSaludMVC.Controllers
{
    using SoluccionSalud.Service._FormularioNuevo;

    using SvcSeguridadConcepto = SoluccionSalud.Service.SeguridadConceptoService.SvcSeguridadConcepto;
    using SvcVWEspecialidadMedico = SoluccionSalud.Service.VWEspecialidadMedicoService.SvcVWEspecialidadMedico;
    using SvcPersonaMast = SoluccionSalud.Service.PersonaMastService.SvcPersonaMast;
    using SvcMiscelaneos = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos;
    using SvcFormularios = SoluccionSalud.Service.FormulariosService.SvcFormularios;
    using SvcFormularioAnamnesisAP = SoluccionSalud.Service.FormulariosService.SvcFormularioAnamnesisAP;
    using SvcParametro = SoluccionSalud.Service.ParametroService.SvcParametro;
    using SvcEpisodioAtencion = SoluccionSalud.Service.EpisodioAtencionService.SvcEpisodioAtencion;
    using SvcEpisodioClinico = SoluccionSalud.Service.EpisodioClinicoService.SvcEpisodioClinico;
    using SvcVw_AtencionPaciente = SoluccionSalud.Service.VW_ATENCIONPACIENTEService.SvcVw_AtencionPaciente;
    using svcSS_FA_SolicitudProducto = SoluccionSalud.Service.SS_FA_SolicitudProductos.svcSS_FA_SolicitudProducto;
    using SvcVw_Personapaciente = SoluccionSalud.Service.VW_PERSONAPACIENTEService.SvcVw_Personapaciente;
    using SvcV_EpisodioAtenciones = SoluccionSalud.Service.V_EpisodioAtencionesService.SvcV_EpisodioAtenciones;
    using SvcOrdAtenPreexistencia = SoluccionSalud.Service.OrdAtenPreexistenciaService.SvcOrdAtenPreexistencia;
    using svcVw_AtencionPacienteMedicamento = SoluccionSalud.Service.VW_ATENCIONPACIENTEMEDICAMENTOS.svcVw_AtencionPacienteMedicamento;
    using svcSS_FA_DevolucionProducto = SoluccionSalud.Service.DevolucionProducto.svcSS_FA_DevolucionProducto;
    using SOA_AtencionesSpring = SoluccionSalud.Service.ServiciosAlternoSOA.SOA_AtencionesSpring;

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






    public class DevolucionMedicamentoController : ControllerGeneral
    {
        //
        // GET: /DevolucionMedicamento/

        public System.Web.Mvc.ActionResult Index()
        {
            Log.Information("DevolucionMedicamentoController - Index - Entrar");

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
            obj.ACCION = "LISTARIDDEVOLUCION";


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
            return this.RedirectToAction("Index", "BandejaMedico");
        }


        /***/
        public PartialViewResult VisorHCEReportes(int idPaciente, int idOrdenAtencion,
            string codFormato, string codigoOA, string Accion, string nombrePaciente, string Form, string FormContainer)
        {
            Log.Information("DevolucionMedicamentoController - VisorHCEReportes - Entrar");


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
            Log.Information("DevolucionMedicamentoController - eventoLoadReporteTest - Entrar");

            var model = new SS_HC_EpisodioAtenciones();
            ComponentLoader xCompo = X.GetCmp<Ext.Net.ComponentLoader>("compLoaderReporte");
            xCompo.Url = "http://localhost:11505/Reportes/VisorReportesHCE.aspx?ReportID=CCEP0003&Visor=I";
            xCompo.LoadContent();
            return this.Direct();
        }

        /***/
        public System.Web.Mvc.ActionResult eventoLoadReporte(string containerId, string text)
        {
            Log.Information("DevolucionMedicamentoController - eventoLoadReporte - Entrar");

            try
            {
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
                Log.Error(ex, ex.Message);
                return showMsgTratamientoExcepcion(ex, "");
            }
            return this.Direct();
        }


        /***/


        /**PARA REPORTES VIEW**/
        public System.Web.Mvc.ActionResult HCEReportesView()
        {
            Log.Information("DevolucionMedicamentoController - HCEReportesView - Entrar");

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
            return View("HCEReportesReceta/HCEReportesViewDev", objReporte);

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
            string url = string.Format("/VisorReceta/Index?idCodigo={0}", omitIds[0]);

            return this.PartialExtView(
                  viewName: "CCEP9918_View",
                  containerId: "dd",
                // model: this.Session["card"],
                  mode: RenderMode.AddTo,
                  clearContainer: true
              );
            //  return this.Direct();
        }

        public System.Web.Mvc.ActionResult postWindowProxima(String id)
        {
            Log.Information("DevolucionMedicamentoController - postWindowProxima - Entrar");
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

        public System.Web.Mvc.ActionResult CCEP9923_View()
        {
            Log.Information("DevolucionMedicamentoController - CCEP9923_View - Entrar");

            //Int32 IdCodigo = int.Parse(Request.QueryString["idCodigo"]);
            SS_FA_DevolucionProducto ObjSP;
            var fieldCod = X.GetCmp<TextField>("txtPaciente");
            fieldCod.SetValue(ENTITY_GLOBAL.Instance.NombreCompletoPaciente);

            var fieldCod2 = X.GetCmp<TextField>("txtCodigoOA");
            fieldCod2.SetValue(ENTITY_GLOBAL.Instance.CodigoOA);

            var fieldCod3 = X.GetCmp<DateField>("txtFecha1");
            fieldCod3.SetValue(ENTITY_GLOBAL.Instance.FechaReceta);

            ObjSP = new SS_FA_DevolucionProducto();
            ObjSP.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
            ObjSP.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            ObjSP.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            ObjSP.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            ObjSP.Accion = "LISTAR";

            List<SS_FA_DevolucionProducto> result = svcSS_FA_DevolucionProducto.Listar(ObjSP);

            if (result.Count > 0)
            {
                ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "UPDATE";

                var fieldCod4 = X.GetCmp<TextField>("txtDocumento");
                fieldCod4.SetValue(result[0].NumeroDocumento);

                var fieldCod5 = X.GetCmp<TextArea>("txtObservacion");
                fieldCod5.SetValue(result[0].Observacion);

                var fieldCod6 = X.GetCmp<TextField>("txtIdSolicitudProducto");
                fieldCod6.SetValue(result[0].IdDevolucionProducto);

                ENTITY_GLOBAL.Instance.IDDEVOLUCIONPRODUCTO = result[0].IdDevolucionProducto;

            }
            else { ENTITY_GLOBAL.Instance.IDDEVOLUCIONPRODUCTO = 0; ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = "NUEVO"; }


            return View("CCEP9923_View", ObjSP);
        }

        public PartialViewResult PanelWest(string containerId)
        {
            Log.Information("DevolucionMedicamentoController - PanelWest - Entrar");

            return new PartialViewResult
            {
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                Model = ENTITY_GLOBAL.Instance,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }


        public static Ext.Net.Node BuildTree()
        {
            Log.Information("DevolucionMedicamentoController - BuildTree - Entrar");

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
            Log.Information("DevolucionMedicamentoController - ShowProperties - Entrar");

            Ext.Net.MVC.PartialViewResult partialViewResult = new Ext.Net.MVC.PartialViewResult(containerId);
            partialViewResult.RenderMode = RenderMode.AddTo;
            partialViewResult.SingleControl = true;
            partialViewResult.ContainerId = containerId;
            partialViewResult.Model = model;
            return partialViewResult;
        }
        public PartialViewResult LoadFormatos(string containerId, string text)
        {
            Log.Information("DevolucionMedicamentoController - LoadFormatos - Entrar");

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
                objVistaSeguridad.IdOpcion = 5055;// Convert.ToInt32(text.Trim());
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


        public PartialViewResult LoadFormatosArbol(string containerId, string opc)
        {
            Log.Information("DevolucionMedicamentoController - LoadFormatosArbol - Entrar");

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
            Log.Information("DevolucionMedicamentoController - reloadFormatos - Entrar");

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

        public PartialViewResult LoadCentral(string containerId, string text)
        {
            Log.Information("DevolucionMedicamentoController - LoadCentral - Entrar");
            /*
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
            Log.Information("DevolucionMedicamentoController - EditCentral - Entrar");

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

        public System.Web.Mvc.ActionResult GetTreeView()
        {
            Log.Information("DevolucionMedicamentoController - GetTreeView - Entrar");

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
            Log.Information("DevolucionMedicamentoController - GetTreeChild - Entrar");


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

        public StoreResult GetListarBusquedaServicios(int start, int limit, string tipofiltro,
             string filtro, string tipoBuscar, string Linea, string Familia, String Stock)
        {
            Log.Information("DevolucionMedicamentoController - GetListarBusquedaServicios - Entrar");

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
            Log.Information("DevolucionMedicamentoController - ArbolMacroProcesos - Entrar");

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
                    objVistaSeguridad.IdOpcionPadre = 5054;// Convert.ToInt32(node.Trim());
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

        public StoreResult getSeguridadOpciones(string filtro)
        {
            Log.Information("DevolucionMedicamentoController - getSeguridadOpciones - Entrar");

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
        public System.Web.Mvc.ActionResult Delete_SolicitudDetalle(String accion, String codigo, String secuencia)
        {
            Log.Information("DevolucionMedicamentoController - Delete_SolicitudDetalle - Entrar");

            List<SS_FA_DevolucionProductoDetalle> listaDelete = new List<SS_FA_DevolucionProductoDetalle>();
            List<SS_FA_DevolucionProductoDetalle> listaSave = new List<SS_FA_DevolucionProductoDetalle>();
            SS_FA_DevolucionProductoDetalle objDelete = new SS_FA_DevolucionProductoDetalle();
            if (Session["HC_SolMedicamentoDetListDELETE"] != null)
            {
                listaDelete = (List<SS_FA_DevolucionProductoDetalle>)Session["HC_SolMedicamentoDetListDELETE"];
            }
            if (Session["HC_DevMedicamentoDetList"] != null && secuencia != null /*&& secuenciaMed != null*/)
            {
                listaSave = (List<SS_FA_DevolucionProductoDetalle>)Session["HC_DevMedicamentoDetList"];
                foreach (SS_FA_DevolucionProductoDetalle objEntity1 in listaSave)
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
                            objDelete.IdDevolucionProducto = objEntity1.IdDevolucionProducto;
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
                Session["HC_DevMedicamentoDetList"] = listaSave;
            }
            return this.Direct();
        }
        private void RegistraPagina()
        {
            Log.Information("DevolucionMedicamentoController - RegistraPagina - Entrar");

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
        public System.Web.Mvc.ActionResult validarCambiosFormulario(string containerId, string text)
        {
            Log.Information("DevolucionMedicamentoController - validarCambiosFormulario - Entrar");

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
            Log.Information("DevolucionMedicamentoController - validarCambiosFormularioInicio - Entrar");

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
        public System.Web.Mvc.ActionResult Familias(string Linea, string Familia, string Accion)
        {

            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboGenericoTxtDos(Linea, Familia, "", "", Accion));
        }
        public System.Web.Mvc.ActionResult UnidadMedidas(string Linea, string Familia, string SubFamilia, string Accion)
        {
            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboGenericoTxtDos(Linea, Familia, SubFamilia, "", Accion));
        }
        public System.Web.Mvc.ActionResult MedicamentoListado(int start, int limit, string Linea,
           string Familia, string SubFamilia, string CodigoMedicamento, string Descripcion, string Accion)
        {
            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetGrillaGenericos(Linea, Familia, SubFamilia, Descripcion, Accion));
        }
        public System.Web.Mvc.ActionResult ReturnFindMedicamento(String modo, String linea, String familia, String subFamilia,
           String descripcion, string descripLinea, string descripFamilia, String idWindow)
        {
            Log.Information("DevolucionMedicamentoController - ReturnFindMedicamento - Entrar");

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

        public Boolean setCodigoFormatosPaginas(String indicadorEtapa, String opcionView)
        {
            Log.Information("DevolucionMedicamentoController - setCodigoFormatosPaginas - Entrar");

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
            Log.Information("DevolucionMedicamentoController - getIndicaFormatosCopiar - Entrar");

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
        public bool cargarPermisosFormato(bool activo)
        {
            Log.Information("DevolucionMedicamentoController - cargarPermisosFormato - Entrar");

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
        public string getFiltroFavoritos()
        {
            Log.Information("DevolucionMedicamentoController - getFiltroFavoritos - Entrar");

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

        public System.Web.Mvc.ActionResult initLoadFormatos(String container)
        {
            Log.Information("DevolucionMedicamentoController - initLoadFormatos - Entrar");

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
        public System.Web.Mvc.ActionResult AddMedicamentoDevol(String MODO)
        {
            Log.Information("DevolucionMedicamentoController - AddMedicamentoDevol - Entrar");

            var objModel = new SS_FA_DevolucionProductoDetalle();

            objModel.Accion = MODO;
            objModel.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            objModel.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            objModel.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
            objModel.IdEpisodioAtencion = Convert.ToInt32(ENTITY_GLOBAL.Instance.EpisodioAtencion);

            //aqui me quede

            return crearWindowRegistro("AddMedicamentoDevol", objModel, "");
            //return View("UsuarioRegistro", LocalEnty);

        }

        public PartialViewResult PanelWest9(string containerId)
        {
            Log.Information("DevolucionMedicamentoController - PanelWest9 - Entrar");

            return new PartialViewResult
            {
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                Model = ENTITY_GLOBAL.Instance,
                ViewName = "PanelWest9",
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }
        public PartialViewResult PanelEast9(string containerId)
        {
            Log.Information("DevolucionMedicamentoController - PanelEast9 - Entrar");

            return new PartialViewResult
            {
                Model = ENTITY_GLOBAL.Instance,
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }

        public PartialViewResult PanelNorth9(string containerId)
        {
            Log.Information("DevolucionMedicamentoController - PanelNorth9 - Entrar");

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
                ViewName = "PanelNorth9",
                WrapByScriptTag = false
            };
        }
        public PartialViewResult PanelEast(string containerId)
        {
            Log.Information("DevolucionMedicamentoController - PanelEast - Entrar");

            return new PartialViewResult
            {
                Model = ENTITY_GLOBAL.Instance,
                RenderMode = RenderMode.AddTo,
                ContainerId = containerId,
                WrapByScriptTag = false // we load the view via Loader with Script mode therefore script tags is not required
            };
        }

        public System.Web.Mvc.ActionResult addPermisosFormatos(String data, String indica)
        {
            Log.Information("DevolucionMedicamentoController - addPermisosFormatos - Entrar");

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

        public System.Web.Mvc.ActionResult eventoAgregarHistoricoFormulario(string formato, string accion, string idWindow,
           Nullable<long> idEpiAtencionCopy, Nullable<int> idEpiClinicoCopy, string UnidadReplicacionCopy,
           String data
           )
        {
            Log.Information("DevolucionMedicamentoController - eventoAgregarHistoricoFormulario - Entrar");


            List<SS_FA_DevolucionProductoDetalle> dataSave = null;
            var varPasarDetalle = new SS_FA_DevolucionProductoDetalle();

            List<SS_FA_DevolucionProductoDetalle> ObjListar = (List<SS_FA_DevolucionProductoDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(data, typeof(List<SS_FA_DevolucionProductoDetalle>));

            try
            {
                if (ObjListar != null)
                {

                    if (ObjListar.Count > 0)
                    {

                        foreach (SS_FA_DevolucionProductoDetalle objadd in ObjListar)
                        {
                            varPasarDetalle.IdPaciente = objadd.IdPaciente;
                            /* varPasarDetalle.NombreCompleto = objadd.NombreCompleto;*/
                            varPasarDetalle.EpisodioClinico = objadd.EpisodioClinico;
                            varPasarDetalle.IdEpisodioAtencion = objadd.IdEpisodioAtencion;
                            varPasarDetalle.Secuencia = objadd.Secuencia;
                            varPasarDetalle.Linea = objadd.Linea;
                            varPasarDetalle.Familia = objadd.Familia;
                            varPasarDetalle.SubFamilia = objadd.SubFamilia;
                            varPasarDetalle.TipoComponente = objadd.TipoComponente;
                            varPasarDetalle.FechaCreacion = objadd.FechaCreacion;
                            varPasarDetalle.GrupoMedicamento = objadd.GrupoMedicamento;
                            varPasarDetalle.CodigoComponente = objadd.CodigoComponente;
                            varPasarDetalle.Version = objadd.Version.Trim();
                            varPasarDetalle.Cantidad = objadd.Cantidad;
                            varPasarDetalle.Estado = objadd.Estado;
                            varPasarDetalle.Accion = objadd.Accion;

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
                Log.Error(ex, ex.Message);
                return showMsgTratamientoExcepcion(ex, "EXC: eventoAgregarHistoricoFormulario");
            }



        }


        public System.Web.Mvc.ActionResult GrillaListadoMedicamentoPacientes(int start, int limit, string txtFecha1, string txtFecha2,
       string txtPaciente, string tipoEstado, string tipoBuscar)
        {
            Log.Information("DevolucionMedicamentoController - GrillaListadoMedicamentoPacientes - Entrar");

            Boolean indicaValidacionForm = false;
            var objLista = new List<SS_FA_DevolucionProductoDetalle>();
            try
            {
                //ENTITY_GLOBAL.Instance.GRUPO = "";
                var Listar = new List<SS_FA_DevolucionProductoDetalle>();

                var LocalEnty = new SS_FA_DevolucionProducto();

                LocalEnty.UnidadReplicacion = SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                LocalEnty.IdPaciente = (int)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.PacienteID;
                LocalEnty.EpisodioClinico = (int)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.EpisodioClinico;
                LocalEnty.IdEpisodioAtencion = (long)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.EpisodioAtencion;
                //LocalEnty.IdDevolucionProducto = (int)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.IDDEVOLUCIONPRODUCTO;

                if (SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.IDDEVOLUCIONPRODUCTO != null)
                {
                    LocalEnty.IdDevolucionProducto = (int)SoluccionSalud.Entidades.Entidades.ENTITY_GLOBAL.Instance.IDDEVOLUCIONPRODUCTO;
                }
                /* if (tipoEstado == "-1")
                 {
                     LocalEnty.Estado = null;
                 }*/
                int inicio = (start == 0 ? start : start + 1);
                int final = start + limit;

                if (tipoBuscar == "FILTRO") { inicio = 0; final = limit; }


                //  LocalEnty.Familia = "CONTARLISTAPAG";
                //  int cantElementos = svcVw_AtencionPacienteMedicamento.setMantenimiento(LocalEnty);
                //   if (cantElementos > 0)
                //  {
                LocalEnty.Accion = "LISTAR";
                Listar = svcSS_FA_DevolucionProducto.ListarDetalle(LocalEnty);

                /* SS_FA_DevolucionProductoDetalle obtemp;
                 foreach (SS_FA_DevolucionProducto objEntity1 in Listar)
                 {
                     if (Convert.ToInt32(Session["CANTIDAD"]) < objEntity1.Secuencia)
                     {
                         Session["CANTIDAD"] = objEntity1.Secuencia;
                     }

                     obtemp = new SS_FA_DevolucionProductoDetalle();
                     obtemp.UnidadReplicacion = objEntity1.UnidadReplicacion;
                     obtemp.IdEpisodioAtencion = objEntity1.IdEpisodioAtencion;
                     obtemp.IdPaciente = objEntity1.IdPaciente;
                     obtemp.EpisodioClinico = objEntity1.EpisodioClinico;
                     obtemp.Secuencia = objEntity1.Secuencia;
                    // obtemp.UnidadReplicacionReferencia = objEntity1.UnidadReplicacion;
                    // obtemp.IdEpisodioAtencionReferencia = objEntity1.IdEpisodioAtencion;
                   //  obtemp.IdPacienteReferencia = objEntity1.IdPaciente;
                   //  obtemp.EpisodioClinicoReferencia = objEntity1.EpisodioClinico;
                     obtemp.Cantidad = objEntity1.Cantidad;
                     obtemp.Linea = objEntity1.Linea;
                     obtemp.Familia = objEntity1.Familia;
                     obtemp.SubFamilia = objEntity1.SubFamilia;
                     obtemp.TipoComponente = objEntity1.TipoComponente;
                     obtemp.CodigoComponente = objEntity1.CodigoComponente;
                     obtemp.Estado = objEntity1.Estado;
                     obtemp.Accion = objEntity1.Accion;


                     objLista.Add(obtemp);



                 }*/
                Session["HC_DevMedicamentoDetList"] = Listar;

                // }

                return this.Store(Listar);
            }
            catch (Exception ex)
            {
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

        public System.Web.Mvc.ActionResult GrillaListadoMedicamentoPacientesAdd(int start, int limit, string txtFecha1, string txtFecha2,
        string txtPaciente, string tipoEstado, string tipoBuscar)
        {
            Log.Information("DevolucionMedicamentoController - GrillaListadoMedicamentoPacientesAdd - Entrar");

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
                LocalEnty.Familia = "LISTARMEDDEV";

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
                    obtemp.GrupoMedicamento = objEntity1.Forma;

                    objLista.Add(obtemp);



                }
                Session["HC_SolMedicamentoDetList"] = objLista;

                // }

                return this.Store(Listar);
            }
            catch (Exception ex)
            {
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


        public System.Web.Mvc.ActionResult Save_Solicitud(String selectionArray1, String selectionArray2)
        {
            Log.Information("DevolucionMedicamentoController - Save_Solicitud - Entrar");


            List<SS_FA_DevolucionProducto> ObjLista1 = new List<SS_FA_DevolucionProducto>();
            List<SS_FA_DevolucionProductoDetalle> ObjLista2 = new List<SS_FA_DevolucionProductoDetalle>();
            string mensage = "";
            if (selectionArray1.Trim().Length > 0)
            {
                try
                {
                    if (selectionArray1.Trim().Length > 0)
                    {
                        ObjLista1 = (List<SS_FA_DevolucionProducto>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray1, typeof(List<SS_FA_DevolucionProducto>));
                    }
                    if (selectionArray2.Trim().Length > 0)
                    {
                        ObjLista2 = (List<SS_FA_DevolucionProductoDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(selectionArray2, typeof(List<SS_FA_DevolucionProductoDetalle>));
                    }

                    SS_FA_DevolucionProducto ObjSP;
                    SS_FA_DevolucionProductoDetalle ObjSPD;
                    SS_FA_DevolucionProducto cabeceraMed = new SS_FA_DevolucionProducto();
                    List<SS_FA_DevolucionProductoDetalle> listadetalleMed = new List<SS_FA_DevolucionProductoDetalle>();

                    foreach (SS_FA_DevolucionProducto objEntity1 in ObjLista1)
                    {
                        ObjSP = new SS_FA_DevolucionProducto();
                        ObjSP = objEntity1;
                        ObjSP.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
                        ObjSP.EpisodioClinico = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;
                        ObjSP.IdEpisodioAtencion = (long)ENTITY_GLOBAL.Instance.EpisodioAtencion;
                        ObjSP.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

                        ObjSP.IdDevolucionProducto = (int)ENTITY_GLOBAL.Instance.IDDEVOLUCIONPRODUCTO;

                        if (objEntity1.NumeroDocumento.Count() > 0)
                        {
                            ObjSP.Accion = "UPDATE";
                            ObjSP.UsuarioModificacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSP.FechaModificacion = DateTime.Now;
                        }
                        else
                        {
                            ObjSP.Accion = "NUEVO";
                            ObjSP.UsuarioCreacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSP.FechaCreacion = DateTime.Now;
                        }

                        cabeceraMed = ObjSP;
                    }

                    foreach (SS_FA_DevolucionProductoDetalle objEntity2 in ObjLista2)
                    {
                        ObjSPD = new SS_FA_DevolucionProductoDetalle();
                        ObjSPD = objEntity2;

                        ObjSPD.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;

                        ObjSPD.IdEpisodioAtencion = objEntity2.IdEpisodioAtencion;
                        ObjSPD.IdOrdenAtencion = ENTITY_GLOBAL.Instance.IdOrdenAtencion;
                        ObjSPD.EpisodioClinico = objEntity2.EpisodioClinico;
                        ObjSPD.UsuarioCreacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                        ObjSPD.FechaCreacion = DateTime.Now;
                        if (objEntity2.Accion == "NUEVO" || objEntity2.Accion == "UPDATE")
                        {
                            ObjSPD.Accion = "UPDATE";
                            ObjSPD.UsuarioModificacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSPD.FechaModificacion = DateTime.Now;
                        }
                        else
                        {
                            ObjSPD.Accion = "NUEVO";
                            ObjSPD.UsuarioCreacion = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                            ObjSPD.FechaCreacion = DateTime.Now;
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
                        List<SS_FA_DevolucionProductoDetalle> listaDel = (List<SS_FA_DevolucionProductoDetalle>)Session["HC_SolMedicamentoDetListDELETE"];
                        foreach (var result2 in listaDel)
                        {
                            listadetalleMed.Add(result2);
                        }
                    }
                    /************/

                    int result = svcSS_FA_DevolucionProducto.setMantenimiento(cabeceraMed, listadetalleMed);
                    if (result > 0 && ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION == "UPDATE")
                    {
                        List<SS_FA_DevolucionProductoDetalle> listadetalleDev = new List<SS_FA_DevolucionProductoDetalle>();
                        listadetalleDev = listadetalleMed.Where(x => x.Accion != "DELETE").ToList();
                        foreach (SS_FA_DevolucionProductoDetalle lstDevolucion in listadetalleDev)
                        {
                            List<SS_HCE_ConsultaExterna> listaExternaDetalle = new List<SS_HCE_ConsultaExterna>();
                            int idResultadosDE = 0;
                            var objGenralDetalle = new SS_HCE_ConsultaExterna();
                            objGenralDetalle.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim();
                            objGenralDetalle.Linea = lstDevolucion.GrupoMedicamento;
                            objGenralDetalle.Componente = ENTITY_GLOBAL.Instance.CodigoOA;
                            objGenralDetalle.TipoInterConsulta = (int)lstDevolucion.Cantidad;
                            objGenralDetalle.Accion = "DEVOL_DETALLE";
                            idResultadosDE = SOA_AtencionesSpring.ListaConsultaExternaEmergencia(objGenralDetalle);
                        }

                        long registro2 = 0;
                        SS_HC_EpisodioAtencion epiAtencionObjAbrir = new SS_HC_EpisodioAtencion();
                        epiAtencionObjAbrir.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                        epiAtencionObjAbrir.UnidadReplicacionEC = ENTITY_GLOBAL.Instance.UnidadReplicacion.Trim(); // jordan mateo 07/02/2019
                        epiAtencionObjAbrir.IdPaciente = Convert.ToInt32(ENTITY_GLOBAL.Instance.PacienteID);
                        epiAtencionObjAbrir.CodigoOA = ENTITY_GLOBAL.Instance.CodigoOA;
                        epiAtencionObjAbrir.IdEpisodioAtencion = listadetalleMed[0].IdEpisodioAtencion;
                        epiAtencionObjAbrir.EpisodioClinico = listadetalleMed[0].EpisodioClinico;
                        epiAtencionObjAbrir.Accion = "UPDATE_DEVOL";
                        registro2 = SvcEpisodioAtencion.setMantenimiento(epiAtencionObjAbrir);
                    }


                    if (result > 0)
                    {
                        Session["HC_SolMedicamentoDetListDELETE"] = null;
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

    }
}
