using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Net.Http;
using System.Net.Http.Formatting;
using SoluccionSalud.Entidades.Entidades;
using Ext.Net;
using Ext.Net.MVC;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Serilog;
using System.Net;
using System.DirectoryServices.Protocols;

//using LibEncrypt; 

namespace AppSaludMVC.Controllers
{
    using ServiciosRules = SoluccionSalud.Service.AccionesServiceRules.ServiciosRules;
    using SvcReglasServicios = SoluccionSalud.Service.ReglasServicios.SvcReglasServicios;
    using SvcUsuario = SoluccionSalud.Service.UsuarioService.SvcUsuario;
    using SvcParametro = SoluccionSalud.Service.ParametroService.SvcParametro;
    using SvcSG_Agente = SoluccionSalud.Service.SG_AgenteService.SvcSG_Agente;
    using SvcSeguridadConcepto = SoluccionSalud.Service.SeguridadConceptoService.SvcSeguridadConcepto;
    using SvcSeguridadPerfilUsuario = SoluccionSalud.Service.SeguridadPerfilUsuarioService.SvcSeguridadPerfilUsuario;
    using SvcEspecialidad = SoluccionSalud.Service.EspecialidadService.SvcEspecialidad;
    using SoluccionSalud.Service.MiscelaneosService;
    using SoluccionSalud.Componentes;
    using System.Data.SqlClient;
    using Newtonsoft.Json;
    using SoluccionSalud.Service.ParametroService;
    using System.Net.Http;
    using System.Web.Script.Serialization;
    using System.Net.Http.Formatting;
    using System.Web.Caching;
    using Serilog;
    using System.Data;
    using AppSaludMVC.Models;
    using System.Configuration;

    public class LoginController : Controller
    {    
        // GET: /Login/

        public ActionResult Index()
        {
            Log.Information("Entrando al LoginController");
            return View();
        }

        public ActionResult Preferencia()
        {
            Log.Information("LoginController - Preferencia");
            UTILES_MENSAJES.inicializarParametros_Form(true);
            cargarParametrosSystem_Default("DEFAULT");
            return View();
        }

        public ActionResult Cancelar()
        {
            Log.Information("LoginController - Cancelar");
            return this.RedirectToAction("Index", "Login");
        }

        public static List<SG_Agente> OnlineUsers
        {
            get
            {
                Log.Information("LoginController - OnlineUsers");
                if (System.Web.HttpContext.Current.Cache["OnlineUsers"] != null)
                {
                    return (List<SG_Agente>)System.Web.HttpContext.Current.Cache["OnlineUsers"];
                }
                else
                {
                    List<SG_Agente> list = ENTITY_GLOBAL.Instance.ListarUsuariosTotal;
                    System.Web.HttpContext.Current.Cache.Add("OnlineUsers", list, null, DateTime.MaxValue, new TimeSpan(), CacheItemPriority.NotRemovable, null);
                    return list;
                }
            }
        }

        public ActionResult Ingresar(string cbSucursal, string cbEstablecimiento, string cbCompania, string cbModulos)
        {
            try
            {
                Log.Information("LoginController - Ingresar");
                Log.Debug("cdSucursal {A} , cbEstablecimiento {B} ,cbCompania {C}, cbModulos {D}", cbSucursal, cbEstablecimiento, cbCompania, cbModulos);
                string irmodulo;
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
                ENTITY_GLOBAL.Instance.Compania = cbCompania.Trim();
                ENTITY_GLOBAL.Instance.Sucursal = cbSucursal.Trim();
                ENTITY_GLOBAL.Instance.Establecimiento = cbEstablecimiento.Trim();
                UTILES_MENSAJES.setParametro_Form("COMPANIA_LOGIN", ENTITY_GLOBAL.Instance.Compania);
                UTILES_MENSAJES.setParametro_Form("SUCURSAL_LOGIN", ENTITY_GLOBAL.Instance.Sucursal);
                UTILES_MENSAJES.setParametro_Form("ESTABLEC_LOGIN", Convert.ToInt32(ENTITY_GLOBAL.Instance.Establecimiento));

                //UTILES_MENSAJES.setParametro_Form("MODULO_LOGIN", p.Value.ToString().Trim());
                UTILES_MENSAJES.setParametro_Form("MODULO_LOGIN", (cbModulos + "").Trim());

                //ADD UNIDAD REP
                ENTITY_GLOBAL.Instance.UnidadReplicacion = ENTITY_GLOBAL.Instance.Sucursal;

                //ADD
                Log.Information("Termina LoginController - Ingresar");
                return this.RedirectToAction("Index", irmodulo);
            }
            catch (Exception ex)
            {
                Log.Information("Bloque Catch LoginController - Ingresar");
                Log.Error(ex, ex.Message);
                return this.RedirectToAction("Index", "Login");
                throw;
            }
        }

        public ActionResult Login(string txtUsername, string txtPassword)
        {
            try
            {
                Log.Information("LoginController - Login");
                Log.Debug("txtUsername {A} , cbEstablecimiento {B}", txtUsername, txtPassword);
                var Listar = new List<SG_Agente>();
                SG_Agente objUsuario = new SG_Agente();
                DataTable dtAgente = new DataTable();
                HceService.SoaServiceSoapClient ObtenerTramaOA = new HceService.SoaServiceSoapClient();
                HceService.SS_HC_WS_EpisodioAtencion WsEpisodio = new HceService.SS_HC_WS_EpisodioAtencion();
                var resultString = "";
                string INDADL = "";
                string ADDOMAIN = "";
                string USUARIORED = "";
                if (txtUsername.ToUpper() != "ROYAL")
                {
                    DataTable dtValida = new DataTable();
                    WsEpisodio.SecuenciaHCE = txtUsername.Trim().ToUpper();
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
                                //SP_SS_HC_SG_Agente_LISTAR_Result obj_Agente = new SP_SS_HC_SG_Agente_LISTAR_Result();
                                //obj_Agente.ACCION = "VALIDARADDOMAIN";
                                //obj_Agente.CodigoAgente = txtUsername.Trim().ToUpper();
                                //Log.Information("VALIDARADDOMAIN - inicio VALIDARADDOMAIN :: " + objUsuario.ACCION + " CodigoAgente ::" + objUsuario.CodigoAgente);
                                //Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);

                                string MMessage = " IndicadorValidarUsuarioRed :: " + INDADL + "  NombreDominioRed ::" + ADDOMAIN + "  UsuarioRed ::" + USUARIORED;
                                Log.Debug(MMessage);
                                if (INDADL == "2" || INDADL == "S")
                                {
                                    if (ADDOMAIN.Length > 0)
                                    {
                                        if (USUARIORED.Length > 0)
                                        {
                                            Log.Information("NetworkCredential - inicio");
                                            LdapConnection connection = new LdapConnection(ADDOMAIN);
                                            NetworkCredential credential = new NetworkCredential(USUARIORED.Trim().ToUpper() /*+ "@" + dominio*/, txtPassword);
                                            connection.Credential = credential;
                                            connection.Bind();
                                            Log.Information("NetworkCredential - Fin");
                                        }
                                        else
                                        {
                                            return showMensajeBox("No cuenta con el UsuarioRed en el AD..", "Error al acceder", "ERROR", "Asignarlo en el ERP");
                                        }
                                    }
                                    else
                                    {
                                        return showMensajeBox("No cuenta con el Dominio ASignado para el AD..", "Error al acceder", "ERROR", "Asignarlo en el ERP");
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
                                return showMensajeBox(errorMessage, "No hemos podido acceder", "ERROR", "REINICIAR");
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
                            return showMensajeBox("No hemos podido acceder. Contáctese con Mesa de Ayuda", "Error al acceder", "ERROR", "REINICIAR");
                        }
                    }
                    else
                    {
                        Log.Information("LdapConnection - Login");
                        return showMensajeBox("No hemos podido acceder. Contáctese con Mesa de Ayuda", "Error al acceder", "ERROR", "REINICIAR");
                    }
                }

                var BE_Global = new ENTITY_GLOBAL();
                Session["ENTITY_GLOBAL"] = BE_Global;
                ENTITY_GLOBAL.Instance.APLICATIVOID = 1;
                ENTITY_GLOBAL.Instance.APPCODIGO = "SP4W";
                ENTITY_GLOBAL.Instance.USUARIO = txtUsername.Trim().ToUpper();
                //ENTITY_GLOBAL.Instance.UnidadReplicacion = "LIMA"; //CEG CAMBIO POR ERROR EN PRODUCCION  OBS: HARD CODE
                ENTITY_GLOBAL.Instance.NIVEL = 0;
                ENTITY_GLOBAL.Instance.MODULO = "BE";
                ENTITY_GLOBAL.Instance.HostName = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                ENTITY_GLOBAL objENTITY_GLOBAL = ENTITY_GLOBAL.Instance;

                Log.Information("txtUsername - Inicio");
                if (INDADL == "2" || INDADL == "S")
                {
                    objUsuario.ACCION = "VALIDARADDOMAIN";
                    objUsuario.CodigoAgente = txtUsername.Trim().ToUpper();
                    Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                    foreach (SG_Agente objEntity in Listar)
                    {
                        //objUsuario = objEntity;
                        txtPassword = objEntity.Clave;
                    }
                }
                //if (Listar.Count == 0)
                //{
                    objUsuario.ACCION = "VALIDARLOGIN";
                    objUsuario.CodigoAgente = txtUsername.Trim().ToUpper();
                    objUsuario.Clave = txtPassword;
                    Listar = SvcSG_Agente.listarSG_Agente(objUsuario, 0, 0);
                //}
                Log.Information("txtUsername - Fin");

                Boolean validoLogin = false;
                if (Listar.Count > 0)
                {
                    if (Listar[0].flatUsuGenerico == 2)
                    {
                        ENTITY_GLOBAL.Instance.NOMBREUSU_GENERICO = Listar[0].Descripcion;
                        ENTITY_GLOBAL.Instance.USUARIO_GENERICO = Listar[0].CodigoAgente;
                        ENTITY_GLOBAL.Instance.IDAGENTE_GENERICO = Listar[0].IdAgente;
                        ENTITY_GLOBAL.Instance.IDEMPLEADO_GENERICO = Convert.ToInt32(Listar[0].IdEmpleado);
                    }
                    else
                    {
                        ENTITY_GLOBAL.Instance.NOMBREUSU_GENERICO = null;
                        ENTITY_GLOBAL.Instance.USUARIO_GENERICO = null;
                        ENTITY_GLOBAL.Instance.IDAGENTE_GENERICO = 0;
                        ENTITY_GLOBAL.Instance.IDEMPLEADO_GENERICO = -1;
                    }
                    validoLogin = true;
                    foreach (SG_Agente objEntity in Listar)
                    {
                        objUsuario = objEntity;
                    }
                }
                else
                {
                    Log.Information("LoginController - Login - Se mostró un mensaje al usuario Error al acceder... ");
                    return showMensajeBox("Lo sentimos, la contraseña es incorrecta. Asegúrate de ingresarla correctamente.. Contáctese con Mesa de Ayuda" + resultString, "Error al acceder", "ERROR", "REINICIAR");
                }

                if (objUsuario != null)
                {
                    if (objUsuario.Estado != 2)
                    {
                        Log.Information("LoginController - Login - Se mostró un mensaje al usuario Usuario no se encuentra Activo... ");
                        return showMensajeBox("La Cuenta esta deshabilitada. Contáctese con Mesa de Ayuda.", "Error al acceder", "ERROR", "REINICIAR");
                    }

                    //OBS: 2
                    ENTITY_GLOBAL.Instance.PERFILACTUAL = objUsuario.Descripcion;//debe ser el perfil por defecto
                    ENTITY_GLOBAL.Instance.CODPERSONA = objUsuario.IdEmpleado;
                    ENTITY_GLOBAL.Instance.IDAGENTE = objUsuario.IdAgente;
                    ENTITY_GLOBAL.Instance.Password = objUsuario.Clave;
                    ENTITY_GLOBAL.Instance.TIPOAGENTE = objUsuario.TipoAgente; //ADD
                    Session["TIPOTRABAJADOR_ACTUAL"] = (objUsuario.tipotrabajador + "").Trim(); //ADD
                    Session["IDCONFIG_TRABAJADOR_ACTUAL"] = objUsuario.IdCodigo; //ADD

                    ///////////////////
                    Session["COD_PLATAFORMA"] = "WEB";
                    Session["MODULO_DEF"] = "HC";
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_PREVIA = null;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_ACTUAL = null;
                    ENTITY_GLOBAL.Instance.CODOPCION_PAGINA_SGTE = null;
                    ENTITY_GLOBAL.Instance.CODOPCION_ULTIMOACTOMED = null;
                    ENTITY_GLOBAL.Instance.MedicoNombre = objUsuario.Nombre;
                    Session["NOMBRE_MEDICO"] = objUsuario.Nombre;


                    /************OBTENER OPCION POR DEFECTO DE CRONOLOGIA***ADD**21-02-17*ORLANDO***********/
                    //string codigo = "";
                    //SS_CHE_VistaSeguridad objVistaSeguridad = new SS_CHE_VistaSeguridad();
                    //objVistaSeguridad.Sistema = ENTITY_GLOBAL.Instance.APPCODIGO;
                    //objVistaSeguridad.CodigoAgente = ENTITY_GLOBAL.Instance.USUARIO;
                    //objVistaSeguridad.IdAgente = Convert.ToInt32(ENTITY_GLOBAL.Instance.IDAGENTE);
                    //objVistaSeguridad.Modulo = ENTITY_GLOBAL.Instance.MODULO;
                    //objVistaSeguridad.Accion = "LISTAPROCESOGENERAL";
                    //List<SS_CHE_VistaSeguridad> lista = new List<SS_CHE_VistaSeguridad>();
                    //lista = SvcSeguridadConcepto.ListarSeguridadOpcion(objVistaSeguridad, 0, 0);

                    //if (lista.Count > 0)
                    //{
                    //    foreach (SS_CHE_VistaSeguridad lista2 in lista)
                    //    {
                    //        if (lista2.Descripcion == "DIAGNÓSTICO")
                    //        {
                    //            if (lista2.CodigoOpcion == "3427" || lista2.CodigoOpcion == "3425")
                    //            {
                    //                codigo = lista2.CodigoOpcion;
                    //            }
                    //        }
                    //    }
                    //    if (codigo.Length > 0)
                    //    {
                    //        ENTITY_GLOBAL.Instance.OPCION_PROC_DEF = Convert.ToInt32(codigo);
                    //    }
                    //}
                    /**************************************************************************************/

                    /*****************14032017********ISABELLA*******************/
                    var Lista3 = new List<SG_PerfilUsuario>();
                    var LocalEnty = new SG_PerfilUsuario();

                    LocalEnty.IdPerfil = 0;
                    LocalEnty.IdUsuario = Convert.ToInt32((ENTITY_GLOBAL.Instance.IDAGENTE));
                    LocalEnty.Accion = "LISTARUSUARIOSPERFIL";
                    Lista3 = SvcSeguridadPerfilUsuario.listarSeguridadPerfilUsuario(LocalEnty, 0, 0);
                    if (Lista3.Count > 0)
                    {
                        foreach (var objData in Lista3)
                        {
                            ENTITY_GLOBAL.Instance.PERFILADMIN = objData.IdPerfil;
                            ENTITY_GLOBAL.Instance.CODIGOPERFIL = objData.Version;
                        }
                    }
                    /************************************************************/
                }
                var objMiscl = new MA_MiscelaneosDetalle();
                objMiscl.ACCION = "COMBO01_FORM";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = null;
                if (objMiscl.CodigoTabla == "FAVORITOLISTA")
                {
                    objMiscl.ValorCodigo3 = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
                }
                var resulObjMiscl = new MA_MiscelaneosDetalle();
                var resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);

                if (resulMiscelaneosTitulo.Count > 0)
                {
                    Session["COMBO01"] = resulMiscelaneosTitulo;
                }
                object combo01 = Session["COMBO01"];
                ENTITY_GLOBAL.Instance.INDICADOR_COMBO = combo01;

                var win = X.GetCmp<Window>("WindowLogin");
                if (win != null)
                {
                    win.Hide();
                }

                Session["User"] = objUsuario.IdAgente;
                Log.Debug("objUsuario.IdAgente " + objUsuario.IdAgente);
                return this.RedirectToAction("Preferencia", "Login");
            }
            catch (Exception ex)
            {
                Log.Information("LoginController - Login Bloque Catch ");
                Log.Error(ex, Newtonsoft.Json.JsonConvert.SerializeObject(ex));
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

        public System.Web.Mvc.ActionResult showMensajeNotify(String titulo, String message, String tipo)
        {
            Log.Information("LoginController - showMensajeNotify ");
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
            }).Show();
            Log.Information("LoginController - showMensajeNotify Terminado");
            return this.Direct();
        }

        private void eventoPostFormulario(Boolean succes, String indica)
        {
            Log.Information("LoginController - eventoPostFormulario ");
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
        }

        public System.Web.Mvc.ActionResult crearWindowRegistro(String url, Object objModel, String titulo)
        {
            Log.Information("LoginController - crearWindowRegistro ");
            return new Ext.Net.MVC.PartialViewResult
            {
                ViewName = url,
                Model = objModel,

            };
        }

        public System.Web.Mvc.ActionResult visorFormProcesos(String url, Object objModel, String titulo)
        {
            Log.Information("LoginController - visorFormProcesos ");
            return new Ext.Net.MVC.PartialViewResult
            {
                ViewName = url
            };
        }
        /**MENSAJES*/

        public System.Web.Mvc.ActionResult showMensajeBox(String message, String titulo, String tipo, String accion)
        {
            //Tipo: {"INFO", "WARNING", "ERROR", "QUESTION"}
            Log.Information("LoginController - showMensajeBox ");
            X.Msg.Show(new MessageBoxConfig
            {
                Title = titulo,
                Message = message,
                Buttons = MessageBox.Button.OK,
                Icon = (MessageBox.Icon)Enum.Parse(typeof(MessageBox.Icon), tipo),
            });
            return this.Direct();
        }

        public ActionResult GetCompania(string accion)
        {
            Log.Information("LoginController - GetCompania ");
            return this.Store(SvcMiscelaneos.comboModelGenerico.GetComboSeguridadTxt(accion, "", "", 0).Select(d => new ListItem(d.Name, d.Codigo)));
        }

        public System.Web.Mvc.ActionResult obtenerComboSeguridadTxt(string paramStr01, string paramStr02, string paramInt01, string usuario, string Accion)
        {
            Log.Information("LoginController - obtenerComboSeguridadTxt ");
            Log.Debug("paramStr01 {A} , paramStr02 {B},paramInt01 {C} , usuario {D},Accion {E}", paramStr01, paramStr02, paramInt01, usuario, Accion);

            int valor = Convert.ToInt32(paramInt01);
            Log.Information("LoginController - obtenerComboSeguridadTxt Terminado");
            return this.Store(SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos.comboModelGenerico.GetComboSeguridadTxt(Accion, paramStr01, paramStr02, valor));
        }

        /***/
        public void cargarParametrosSystem_Default(String indica)
        {
            try
            {
                Log.Information("LoginController - cargarParametrosSystem_Default ");
                Log.Debug("indica {A}", indica);


                List<ParametrosMast> listaParam = new List<ParametrosMast>();
                ParametrosMast objParam = new ParametrosMast();
                objParam.Accion = "LISTAR";
                objParam.CompaniaCodigo = "999999";
                objParam.AplicacionCodigo = "WA";//obs
                listaParam = SvcParametro.listarParametro(objParam, 0, 0);


                Session["LoginAttempts"] = 0;

                SS_GE_Especialidad objEspecialidad = new SS_GE_Especialidad();
                objEspecialidad.Accion = "LISTARPORAGENTE";
                objEspecialidad.FormularioInicial = ENTITY_GLOBAL.Instance.CODPERSONA;          //AUX  EMPLEADO SALUD
                objEspecialidad.FormularioInforme = ENTITY_GLOBAL.Instance.TIPOAGENTE;          //AUX  ID AGENTE
                objEspecialidad.FormularioFinal = ENTITY_GLOBAL.Instance.IDAGENTE;              //AUX  ID AGENTE
                objEspecialidad.UsuarioCreacion = ENTITY_GLOBAL.Instance.USUARIO;               //AUX  CODIGO AGENTE
                ENTITY_GLOBAL.SESSIONlistaEspecialidad = SvcEspecialidad.listarEspecialidad(objEspecialidad, 0, 0);

                var objMiscl = new MA_MiscelaneosDetalle();
                List<MA_MiscelaneosDetalle> resulMiscelaneosTitulo = new List<MA_MiscelaneosDetalle>();
                var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
                var model = new SEGURIDADCONCEPTO();
                objMiscl.ACCION = "COMBOSGENERICOS";
                objMiscl.AplicacionCodigo = "CG";
                objMiscl.CodigoTabla = "TECNOSERVICIO";
                objMiscl.ValorCodigo5 = ENTITY_GLOBAL.Instance.USUARIO;
                ENTITY_GLOBAL.SESSIONlistaTECNOSERVICIO = SvcMiscelaneos.GetFormTitulo(objMiscl);

                //ENTITY_GLOBAL.Instance.INDICADOR_COMBO;
                UTILES_MENSAJES.loadParametro_Session("ACTIVIDDIA", "", true, listaParam);
                /**Parametros par los tipo de Trabajadores definidos*/
                UTILES_MENSAJES.loadParametro_Session("CODTRABMED", "", true, listaParam);
                UTILES_MENSAJES.loadParametro_Session("CODTRABOBS", "", true, listaParam);
                UTILES_MENSAJES.loadParametro_Session("CODTRABENF", "", true, listaParam);
                UTILES_MENSAJES.loadParametro_Session("CODTRABTEC", "", true, listaParam);

                ///**Código WEB PLATAFORMA */
                //UTILES_MENSAJES.loadParametro_Session("CODPLATWEB", "", true, listaParam);
                ///**PARÁMETRO  QUE PERMITE O NO LA CONSULTA A DB EXTERNAS */
                //UTILES_MENSAJES.loadParametro_Session("ACTIVOSOA", "", true, listaParam);
                ///**PARÁMETRO  QUE PERMITE O NO LA CONSULTA AL MOTOR DE REGLAS */
                //UTILES_MENSAJES.loadParametro_Session("ACTIVORULE", "", true, listaParam);


                if (listaParam.Count > 0)
                {
                    foreach (var objPara in listaParam)
                    {
                        if (objPara.ParametroClave == "MIRTHENVIO")
                        {
                            ENTITY_GLOBAL.Instance.MIRTENVIO = Convert.ToInt32(objPara.Numero);
                        }
                        if (objPara.ParametroClave == "MIRTHDELAY")
                        {
                            ENTITY_GLOBAL.Instance.MIRTHDELAY = Convert.ToInt32(objPara.Numero);
                        }
                        if (objPara.ParametroClave == "ACTIVOSOA")
                        {
                            ENTITY_GLOBAL.Instance.ACTIVOSOA = objPara.Texto;
                        }
                        if (objPara.ParametroClave == "ACTIVORULE")
                        {
                            ENTITY_GLOBAL.Instance.ACTIVORULE = objPara.Texto;
                        }
                        if (objPara.ParametroClave == "CODPLATWEB")
                            ENTITY_GLOBAL.Instance.CODPLATWEB = objPara.Texto;
                        }                        {


                    }
                }


                var Session_TIPOVIA = SvcMiscelaneos.comboModelGenerico.GetComboGenerico("TIPOVIA");
                object comboSession_TIPOVIA = Session_TIPOVIA;
                ENTITY_GLOBAL.Instance.Session_TIPOVIA = comboSession_TIPOVIA;

                var Session_UNITIEMPO = SvcMiscelaneos.comboModelGenerico.GetComboGenerico("UNITIEMPO");
                object comboSession_UNITIEMPO = Session_UNITIEMPO;
                ENTITY_GLOBAL.Instance.Session_UNITIEMPO = comboSession_UNITIEMPO;

                var Session_TIPOREGMED = SvcMiscelaneos.comboModelGenerico.GetComboGenericoTxt("TIPOREGMED");
                object comboSession_TIPOREGMED = Session_TIPOREGMED;
                ENTITY_GLOBAL.Instance.Session_TIPOREGMED = comboSession_TIPOREGMED;

                var Session_INDIRECETA = SvcMiscelaneos.comboModelGenerico.GetComboGenerico("INDIRECETA");
                object comboSession_INDIRECETA = Session_INDIRECETA;
                ENTITY_GLOBAL.Instance.Session_INDIRECETA = comboSession_INDIRECETA;
                Log.Information("LoginController - cargarParametrosSystem_Default Terminado");
            }
            catch (Exception ex)
            {
                Log.Error(ex, Newtonsoft.Json.JsonConvert.SerializeObject(ex));
            }
        }

        public System.Web.Mvc.ActionResult SessionOut(String containerId)
        {
            Log.Information("LoginController - SessionOut");
            return View();
        }

    }
}
