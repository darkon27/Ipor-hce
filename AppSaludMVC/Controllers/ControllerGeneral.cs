using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using Ext.Net;
using Ext.Net.MVC;
using SoluccionSalud.Entidades.Entidades;
//using SoluccionSalud.RepositoryReport;

namespace AppSaludMVC.Controllers
{
    using SvcSG_Agente = SoluccionSalud.Service.SG_AgenteService.SvcSG_Agente;
    using SvcMiscelaneos = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos;
    using SvcTABLAFORMATOVALIDACION = SoluccionSalud.Service.TABLAFORMATOVALIDACIONService.SvcTABLAFORMATOVALIDACION;
    using AppSaludMVC.Models;
    using SoluccionSalud.Service.FormulariosService;
    using System.Collections;
    using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
    using Microsoft.Practices.EnterpriseLibrary.Logging;
    using System.Data.SqlClient;
    using SoluccionSalud.Componentes;
    using System.Web;
    using SoluccionSalud.Service.AccionesServiceRules;
    using System.Diagnostics;
    using Serilog;

    public class ControllerGeneral : System.Web.Mvc.Controller
    {
        public ControllerGeneral()
        {
            //Log.Information("ControllerGeneral - ControllerGeneral");
        }

        public System.Web.Mvc.ActionResult setConfigPath(string path, string indica)
        {
            Log.Information("ControllerGeneral - setConfigPath");
            ENTITY_GLOBAL.Instance.PATH_FORM_ACTUAL = path;
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult obtenerCombo(string Accion)
        {
            Log.Information("ControllerGeneral - obtenerCombo");
            //int valor = Convert.ToInt32(paramInt01);
            return this.Store(SoluccionSalud.Service.MiscelaneosService.
                SvcMiscelaneos.comboModelGenerico.GetComboGenerico(Accion));
        }

        /**Confirmación cancelar Edición de Formualrio*/
        public System.Web.Mvc.ActionResult confirmacionCancelarEdicionForm(String mensaje, String titulo, String id)
        {
            Log.Information("ControllerGeneral - confirmacionCancelarEdicionForm");
            return showMensajeConfirmacionPersonalizado(titulo,
                mensaje, "Sí", "No",
                "eventoCancelarResult()", "DoCancel()", "DoCancel()", 40, 380, 130);

        }
        /*****UTILES CONTRUCCION FORMULARIOS****/
        /**SETEA LAS PROPIEDADES  CARGADAS Y VÁLIDAS PARA EL FORMUALRIO ACTUAL*/
        public static bool setPropiedadesForm(List<VW_SS_HC_TABLAFORMATO_VALIDACION> listaProp)
        {
            //Log.Information("ControllerGeneral - setPropiedadesForm");
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
                            }
                            else if (result.FlagTipoDato == "N")
                            {
                                if (result.ValorNumerico != null)
                                {
                                    valor = result.ValorNumerico;
                                }
                            }
                            else if (result.FlagTipoDato == "D")
                            {
                                if (result.ValorDate != null)
                                {
                                    valor = result.ValorDate;
                                }
                            }
                            else if (result.FlagTipoDato == "B")
                            {
                                if (result.ValorNumerico != null)
                                {
                                    valor = result.ValorNumerico;
                                }
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
        public static Object getValor_FiltroParametros(String valor, String tipoDato)
        {
            //Log.Information("ControllerGeneral - getValor_FiltroParametros");
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
        /**OBTIENE EL COMPONENTE UI DEL FORMULARIO DE ACUERDO AL ID Y AL TIPO DE COMPONENTE*/
        public static Object getComponenteForm(String componente, int indicaCompo, String id)
        {
            //Log.Information("ControllerGeneral - getComponenteForm");
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

        [DirectMethod(Namespace = "CompanyX")]
        public System.Web.Mvc.ActionResult ShowMsg(string msg)
        {
            Log.Information("ControllerGeneral - ShowMsg");
            X.Msg.Notify("Message", msg).Show();

            return this.Direct();
        }

        /**CARGA LAS PROPEDADES DEL FORMULARIO DESDE LA BASE DE DATOS*/
        public bool cargarPropiedadesFormulario(bool activo)
        {
            Log.Information("ControllerGeneral - cargarPropiedadesFormulario");
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
            //Log.Information("ControllerGeneral - setPropiedadesFormulario");
            if (activo)
            {
                if (Session["RECURSOS_VALFORM"] != null)
                {
                    List<VW_SS_HC_TABLAFORMATO_VALIDACION> listaResources = new List<VW_SS_HC_TABLAFORMATO_VALIDACION>();
                    VW_SS_HC_TABLAFORMATO_VALIDACION objRes = new VW_SS_HC_TABLAFORMATO_VALIDACION();
                    listaResources = (List<VW_SS_HC_TABLAFORMATO_VALIDACION>)Session["RECURSOS_VALFORM"];
                    setPropiedadesForm(listaResources);

                    //if (Session["containerIdTemp"] != null && Session["textTemp"] != null)
                    //{
                    //    HClinicaControllerSup datito = new HClinicaControllerSup();
                    //    string containertemp = (string)Session["containerIdTemp"];
                    //    string txttemp = (string)Session["textTemp"];
                    //    datito.LoadFormatos(containertemp, txttemp);
                    //}
                }
            }
            return true;
        }
        public System.Web.Mvc.ActionResult crearWindowRegistro(String url, Object objModel, String titulo)
        {
            Log.Information("ControllerGeneral - crearWindowRegistro");
            return new Ext.Net.MVC.PartialViewResult
            {
                ViewName = url,
                Model = objModel,
            };
        }

        public Ext.Net.MVC.PartialViewResult crearWindowRegistro(String Form, Object objModel, String titulo, String FormContainer)
        {
            Log.Information("ControllerGeneral - crearWindowRegistro");
            return new PartialViewResult
            {
                ViewName = Form,
                ContainerId = FormContainer,
                Model = objModel
                //,
                ////SingleControl = true,
                //ClearContainer = true,
                //WrapByScriptTag = true,
                //RenderMode = RenderMode.AddTo
            };
        }

        /**************TRATAMIENTO DE EXCEPCIONES GEN*********************/
        public System.Web.Mvc.ActionResult showMsgTratamientoExcepcion(Exception ex, String messageExtra)
        {
            Log.Information("ControllerGeneral - showMsgTratamientoExcepcion");
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
            eventoPostFormulario(false, "");
            string mostrarExc = "Excepción genérica:" + ex.Message;
            if (resultado.Count > 0)
            {
                mostrarExc = resultado[0].DescripcionLocal;
            }
            return showMensajeNotifyData("Error", mostrarExc, "ERROR", true);

        }

        /***********************************************************************************/
        /**UTILES*/
        /***********************************************************************************/
        public String getValorFiltroStr(String filtro)
        {
            Log.Information("ControllerGeneral - getValorFiltroStr");
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
        public Nullable<DateTime> getValorFiltroDate(String filtro)
        {
            Log.Information("ControllerGeneral - getValorFiltroDate");
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
                Log.Error(e, e.Message);
            }
            return null;
        }
        public Nullable<int> getValorFiltroInt(String filtro)
        {
            Log.Information("ControllerGeneral - getValorFiltroInt");
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
                    return Convert.ToInt32(filtro);
                }
            }
            catch (Exception ex)
            {
                Log.Information("ControllerGeneral - getValorFiltroInt Bloque Catch");
                Log.Error(ex, ex.Message);
            }
            return null;
        }
        /***/
        public void eventoPostFormulario(Boolean succes, String indica)
        {
            Log.Information("ControllerGeneral - eventoPostFormulario");
            try
            {
                if (succes)
                {
                    /*
                    this.GetCmp<Button>("cmdGuardar").Disabled = true;
                    this.GetCmp<Button>("btnOnEdit").Hidden = false;
                    this.GetCmp<Button>("btnCancel").Hidden = true;
                    */
                    //NUEVA FORMA 14/04/16
                    this.GetCmp<Button>("cmdGuardar").Disabled = false;
                    this.GetCmp<Button>("btnOnEdit").Hidden = true;
                    this.GetCmp<Button>("btnCancel").Hidden = false;

                    ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
                    /*
                    if (this.GetCmp<Button>("cmdImprimir") != null)
                    {
                        this.GetCmp<Button>("cmdImprimir").Hidden = true;
                    }*/
                }
                else
                {
                    this.GetCmp<Button>("cmdGuardar").Disabled = false;
                }
                // this.GetCmp<Button>("cmdGuardar").Text = "Actualizar";
            }
            catch (Exception ex)
            {
                Log.Information("ControllerGeneral - Bloque Catch");
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
                throw;
            }
        }
        public void eventoLoadPostFormulario(Boolean succes, String idCompGridStore, String idCompTree)
        {
            Log.Information("ControllerGeneral - eventoLoadPostFormulario");
            if (succes)
            {

                if (idCompGridStore != null)
                {
                    var store = this.GetCmp<Store>("" + idCompGridStore);
                    if (store != null)
                    {
                        store.Reload();
                    }
                }
                if (idCompTree != null)
                {
                    var tree = this.GetCmp<TreePanel>("" + idCompTree);
                    if (tree != null)
                    {
                        tree.GetStore().Reload();
                    }
                }
            }
            else
            {

            }
            // this.GetCmp<Button>("cmdGuardar").Text = "Actualizar";
        }

        /****************************************************/
        /**********************MENSAJES********************/
        /****************************************************/

        public System.Web.Mvc.ActionResult showMensajeBotton(List<ENTITY_MENSAJES> listaMsgNoValido, String titulo, String tipo)
        {
            Log.Information("ControllerGeneral - showMensajeBotton");
            if (listaMsgNoValido != null)
            {
                return this.Store(listaMsgNoValido);
            }
            else
            {
                return this.Direct();
            }
        }

        /*SALIR DEL SISTEMA**/
        public System.Web.Mvc.ActionResult eventoSalirSistema(string indicador)
        {

            return this.RedirectToAction("Index", "Login");
        }

        //Agregado Joel
        public System.Web.Mvc.ActionResult ValidarPasswordHClinica(string IdUsuario, string IdPasswordAntiguo, string pwd1, string pwd2)
        {
            Log.Information("ControllerGeneral - ValidarPasswordHClinica");
            try
            {
                //  ENTITY_GLOBAL BE_Global = new ENTITY_GLOBAL();
                var BE_Global = new ENTITY_GLOBAL();
                VW_PERSONAPACIENTE BE_Paciente = new VW_PERSONAPACIENTE();
                ENTITY_GLOBAL.Instance.APLICATIVOID = 1;
                ENTITY_GLOBAL.Instance.APPCODIGO = "SP4W";
                //ENTITY_GLOBAL.Instance.UnidadReplicacion = "LIMA";
                string UnidReplica = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                ENTITY_GLOBAL.Instance.NIVEL = 0;
                ENTITY_GLOBAL.Instance.MODULO = "BE";
                //    ENTITY_GLOBAL.Instance.HostName = UtilMVC.ObtenerIP();//MOVIDO 14/04/16
                ENTITY_GLOBAL objENTITY_GLOBAL = ENTITY_GLOBAL.Instance;

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
                                //X.Msg.Show(new MessageBoxConfig
                                //{
                                //    Title = "Icon Support",
                                //    Message = "Message with an Icon",
                                //    Buttons = MessageBox.Button.OK,
                                //    Icon = (MessageBox.Icon)Enum.Parse(typeof(MessageBox.Icon), "ERROR"),
                                //    AnimEl = this.GetCmp<Button>("cmdGuardar").ClientID,
                                //    Fn = new JFunction { Fn = "showResult" }
                                //});
                                //return this.Direct();

                                //       return Json("There is another product with the same name", JsonRequestBehavior.AllowGet);
                                //  Ext.Msg.notify('Error', result.errorMessage);"
                                //return showMensajeBox("Las contraseñas no coinciden",
                                //  "Error al acceder", "ERROR", "REINICIAR");
                                //eventoPostFormulario(true, "");
                                //return showMensajeNotifyData("Error", "Las contraseñas no coinciden", "ERROR", false);
                                return showMensajeBox("Sucedio un error. Las contraseñas no coinciden.", "Mensaje", "ERROR", "");
                            }

                        }
                        else
                        {
                            //return showMensajeBox("Las contraseña nueva no pueder ser igual a la actual.",
                            //      "Error al acceder", "ERROR", "REINICIAR");
                            //eventoPostFormulario(true, "");
                            //return showMensajeNotifyData("Error", "Las contraseña nueva no pueder ser igual a la actual.", "ERROR", false);
                            return showMensajeBox("Sucedio un error. Las contraseña nueva no pueder ser igual a la actual.", "Mensaje", "ERROR", "");
                        }

                    }
                    //
                    var win = X.GetCmp<Window>("winSelectFile");
                    if (win != null)
                    { win.Hide(); }
                    Session["User"] = objUsuario.IdAgente;
                    //Agregado 2018/10/29 Jordan Mateo
                    ENTITY_GLOBAL.Instance.Password = pwd2;
                  
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
                    return showMensajeBox("No se pudo hallar usuario con el nombre o clave especificados",
                        "Error al acceder", "ERROR", "REINICIAR");

            }
            catch (Exception ex)
            {
                Log.Information("ControllerGeneral - Bloque Catch");
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



        public System.Web.Mvc.ActionResult eventoPasswordVista(string indicador)
        {
            Log.Information("ControllerGeneral - eventoPasswordVista");
            ENTITY_GLOBAL objModel = new ENTITY_GLOBAL();
            ENTITY_GLOBAL.Instance.APLICATIVOID = 1;
            ENTITY_GLOBAL.Instance.APPCODIGO = "SP4W";
            objModel.USUARIO = ENTITY_GLOBAL.Instance.USUARIO;
            string Form = "ValidarLoginHClinica";
            return crearWindowRegistro(Form, objModel, "");
        }

        public System.Web.Mvc.ActionResult showMensajeBox(String message, String titulo, String tipo, String nombrefn)
        {
            Log.Information("ControllerGeneral - showMensajeBox");
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
        //Fin agregado joel


        /**CONFIRMACIÓN*/
        public System.Web.Mvc.ActionResult showMensajeConfirmacionPersonalizado(String titulo, String message,String textSI, String textNO,
         String handlerSI, String handlerNO, String handlerCancel, Nullable<int> dimY, Nullable<int> valWidth, Nullable<int> valHeight)   
        {
            Log.Information("ControllerGeneral - showMensajeConfirmacionPersonalizado");
            ENTITY_GENERALHCE obj = new ENTITY_GENERALHCE();
            obj.campoStr01 = textSI;
            obj.campoStr02 = textNO;
            obj.campoStr03 = "Cancelar";
            obj.campoStr04 = handlerSI;
            obj.campoStr05 = handlerNO;
            obj.campoStr06 = handlerCancel;
            obj.campoStr10 = titulo;
            obj.campoStr11 = message;
            obj.campoInt01 = dimY;
            obj.campoInt02 = valWidth;
            obj.campoInt03 = valHeight;
            return crearWindowRegistro("ConfirmacionDialogGeneral", obj, "");

        }
        public System.Web.Mvc.ActionResult showMensajeBox(String message, String titulo, String tipo)
        {
            Log.Information("ControllerGeneral - showMensajeBox");
            X.Msg.Show(new MessageBoxConfig
            {
                Title = "Mensaje",
                Message = message,
                Buttons = MessageBox.Button.OK,
                Icon = (MessageBox.Icon)Enum.Parse(typeof(MessageBox.Icon), tipo),
                //Wait = true,
                //WaitConfig = new WaitConfig { Interval = 100 }
                //AnimEl = this.GetCmp<Button>("Button8").ClientID,
                /*Fn = new JFunction
                {
                    Fn = "accionFinal"
                }*/
            });
            //return this.Store("1");
            return this.Direct();

        }
        public System.Web.Mvc.ActionResult showMensajeNotifyPosi(String titulo, String message, String tipo,
            Nullable<int> offsety, Nullable<int> offsetx)
        {
            Log.Information("ControllerGeneral - showMensajeNotifyPosi");
            NotificationAlignConfig Align = new NotificationAlignConfig()
            {
                OffsetY = offsety != null ? Convert.ToInt32(offsety) : -500,
                OffsetX = offsetx != null ? Convert.ToInt32(offsetx) : 0,

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
            return this.Direct();
        }
        public System.Web.Mvc.ActionResult showMensajeNotify(String titulo, String message, String tipo)
        {
            Log.Information("ControllerGeneral - showMensajeNotify");
            if (tipo == "ERROR")
            {
                EventLog.LogData("Usuario :" + ENTITY_GLOBAL.Instance.USUARIO + " | " + "IdPaciente :" + ENTITY_GLOBAL.Instance.PacienteID + " | " + "EpisodioClinico :" + ENTITY_GLOBAL.Instance.EpisodioClinico + " | " + "EpisodioAtencion :" + ENTITY_GLOBAL.Instance.EpisodioAtencion + " | " + message, TraceEventType.Error);
            }
            NotificationAlignConfig Align = new NotificationAlignConfig()
            {
                OffsetY = -300
            };
            X.Msg.Notify(new NotificationConfig
            {
                Title = titulo,
                Icon = (tipo == "WARNING" ? Icon.Error : (tipo == "ERROR" ? Icon.Error : Icon.Information)),
                AlignCfg = Align,
                Html = message,
                Height = 160
                //AnimEl = this.GetCmp<Button>("Button8").ClientID,
                /*Fn = new JFunction
                {
                    Fn = "accionFinal"
                }*/
            }).Show();
            //return this.Store("1");
            return this.Direct();
        }        

        public System.Web.Mvc.ActionResult showMensajeNotifyData(String titulo, String message, String tipo, bool esException)
        {
            Log.Information("ControllerGeneral - showMensajeNotifyData");
            if (tipo == "ERROR")
            {
                EventLog.LogData("Usuario :" + ENTITY_GLOBAL.Instance.USUARIO + " | " + "IdPaciente :" + ENTITY_GLOBAL.Instance.PacienteID + " | " + "EpisodioClinico :" + ENTITY_GLOBAL.Instance.EpisodioClinico + " | " + "EpisodioAtencion :" + ENTITY_GLOBAL.Instance.EpisodioAtencion + " | " + message, TraceEventType.Error);
            }
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
        public System.Web.Mvc.ActionResult eventoCancelarForm(String indica)
        {
            Log.Information("ControllerGeneral - eventoCancelarForm");
            var panelMainCentral = this.GetCmp<Panel>("PanelMainCenter");
            var panelCentral = this.GetCmp<Panel>("ViewportMainForm");
            if (panelCentral != null)
            {
                return showMensajeNotify("TITULO", "H:" + panelCentral.Height +
                    ";;W:" + panelCentral.Width

                    + ";;H22:" + panelMainCentral.Height
                    + ";;W:" + panelMainCentral.Width
                    ,
                    "INFO");
            }
            else
            {
                return this.Direct();
            }

            //return this.Direct();  
            /*
            var model = new SEGURIDADCONCEPTO();
            model.CONCEPTO = "CCEP0005_View";//ENTITY_GLOBAL.Instance.CONCEPTO + "_View";
            model.DESCRIPCION = "XXXX";
            model.GRUPO = "REG0000";
            //return this.Store("1");
            //return this.Direct();                        
            return new PartialViewResult
            {
                ViewName =  "PanelCentralBlanco",// "PanelCenter",
                ContainerId = "Center1",
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };*/
        }


        [DirectMethod(Namespace = "confirmacionFormX")]
        public System.Web.Mvc.ActionResult showMensajeConfirmacion(String titulo, String message, String textSI, String textNO,           
            String handlerSI, String handlerNO, String handlerCancel)
        {
            Log.Information("ControllerGeneral - showMensajeConfirmacion");
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

        public System.Web.Mvc.ActionResult showMensajeConfirmacionValidaCambios(String titulo, String message,
            String textSI, String handlerSI, String handlerCancel)           
        {
            Log.Information("ControllerGeneral - showMensajeConfirmacionValidaCambios");
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

                Cancel = new MessageBoxButtonConfig
                {
                    Handler = "" + handlerCancel,
                    Text = "Cancelar"

                }
            }).Show();
            //return this.Store("1");
            return this.Direct();

        }

        public System.Web.Mvc.ActionResult showMensajeConfirmacionFirma(String titulo, String message,
            String textSI, String textNO, String handlerSI, String handlerNO, String handlerCancel)           
        {
            Log.Information("ControllerGeneral - showMensajeConfirmacionFirma");
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
        public System.Web.Mvc.ActionResult setIndicaCambiosFormulario(String indica)
        {
            //Log.Information("ControllerGeneral - setIndicaCambiosFormulario");
         if (indica == "1")
            {
                Session["modifica"] = true;
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = true;
              //  ENTITY_GLOBAL.Instance.indicadorUI = true;
                ENTITY_GLOBAL.Instance.INDICA_FORM = 1;
                ENTITY_GLOBAL.Instance.INDICADOR_DOACEPTAR = 1;
                //Agregado por jordan Mateo 12/11/2020   Indicador para bienes y servicios creacion de Favoritos
                ENTITY_GLOBAL.Instance.indicadorUI = false;
               if (ENTITY_GLOBAL.Instance.MENUREC_CODIGO == "MM000")
                {
                    ENTITY_GLOBAL.Instance.indicadorUI = true;
                }
            }
            else
            {
                Session["modifica"] = false;
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
                ENTITY_GLOBAL.Instance.INDICADOR_DOACEPTAR = 0;
            }
            //return this.Store("1");
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult NewPageWindows(String url, Object objModel, String titulo)
        {
            return new Ext.Net.MVC.PartialViewResult
            {
                ViewName = url,
                Model = objModel
            };
        }

        public System.Web.Mvc.ActionResult cerrarBitacora(String UnidadReplicacion, int PacienteID, int EpisodioClinico, int EpisodioAtencion, String ESTADOFORMULARIO, String ConceptoFormulario, int IdOpcionActual)
        {
            Log.Information("ControllerGeneral - cerrarBitacora");
            ENTITY_GLOBAL.Instance.UnidadReplicacion = UnidadReplicacion;
            ENTITY_GLOBAL.Instance.PacienteID = PacienteID;
            ENTITY_GLOBAL.Instance.EpisodioClinico = EpisodioClinico;
            ENTITY_GLOBAL.Instance.EpisodioAtencion = EpisodioAtencion;
            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = ESTADOFORMULARIO;
            ENTITY_GLOBAL.Instance.CONCEPTO = ConceptoFormulario;
            ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL = IdOpcionActual;

            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 1;
            //ENTITY_GLOBAL.Instance.bitacora = 1;
            ENTITY_GLOBAL.Instance.DinamicSecuencia = 0;
            //ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = (String)Session["ESTADOANTERIOR"];
            if (ENTITY_GLOBAL.Instance.INDICADOR_DOACEPTAR == 1)
            {
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = true;
            }
            else
            {
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            }
            Session["HC_MedicamentoDietaList"] = null;
            Session["HC_MedicamentoDetalleList"] = null;
            Session["HC_MedicamentoList"] = null;
            Session["HC_MedicamentoID"] = null;
            Session["HC_MedicamentoDietaList"] = null;
            Session["HC_MedicamentoDietaTemporal"] = null;




            //ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = (String)Session["ESTADOANTERIOR"];
            //Session["HC_MedicamentoList"] = null;
            //Session["HC_MedicamentoDietaList"] = null;
            //Session["Session_HC_MedicamentoDetalleDeleteList"] = null;
            //Session["COPIA_FORMULARIO"] = null;
            //Session["DATA_COPIA_FORM"] = null;
            //Session["CON_DATA_1"] = null;
            //Session["CON_DATA_2"] = null;          
            //Session["ValoresTemporal"] = null;
            //Session["DataSS_HC_Anamnesis_EADelete"] = null;          
            return cerrarWindow("WindowAsignarPerfil");
        }


        public System.Web.Mvc.ActionResult cerrarHistorial(String UnidadReplicacion, int PacienteID, int EpisodioClinico, int EpisodioAtencion, String ESTADOFORMULARIO, String ConceptoFormulario, int IdOpcionActual)
        {
            Log.Information("ControllerGeneral - cerrarHistorial");
            ENTITY_GLOBAL.Instance.UnidadReplicacion = UnidadReplicacion;
            ENTITY_GLOBAL.Instance.PacienteID = PacienteID;
            ENTITY_GLOBAL.Instance.EpisodioClinico = EpisodioClinico;
            ENTITY_GLOBAL.Instance.EpisodioAtencion = EpisodioAtencion;
            ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = ESTADOFORMULARIO;
            ENTITY_GLOBAL.Instance.CONCEPTO = ConceptoFormulario;
            ENTITY_GLOBAL.Instance.IDOPCION_ACTUAL = IdOpcionActual;

            ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 1;
            //ENTITY_GLOBAL.Instance.bitacora = 1;
            ENTITY_GLOBAL.Instance.DinamicSecuencia = 0;

           

            //ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = (String)Session["ESTADOANTERIOR"];
            if (ENTITY_GLOBAL.Instance.INDICADOR_DOACEPTAR == 1)
            {
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = true;
            }
            else
            {
                ENTITY_GLOBAL.Instance.indicadorAuxiliar = false;
            }

            Session["HC_MedicamentoDietaList"] = null;
            Session["HC_MedicamentoDetalleList"] = null;
            Session["HC_MedicamentoList"] = null;
            Session["HC_MedicamentoID"] = null;
            Session["HC_MedicamentoDietaList"] = null;
            Session["HC_MedicamentoDietaTemporal"] = null;




            //ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = (String)Session["ESTADOANTERIOR"];
            //Session["HC_MedicamentoList"] = null;
            //Session["HC_MedicamentoDietaList"] = null;
            //Session["Session_HC_MedicamentoDetalleDeleteList"] = null;
            //Session["COPIA_FORMULARIO"] = null;
            //Session["DATA_COPIA_FORM"] = null;
            //Session["CON_DATA_1"] = null;
            //Session["CON_DATA_2"] = null;          
            //Session["ValoresTemporal"] = null;
            //Session["DataSS_HC_Anamnesis_EADelete"] = null;          
            return cerrarWindow("WindowAsignarPerfil");
        }
        public System.Web.Mvc.ActionResult cerrarWindow(String id)
        {
            Log.Information("ControllerGeneral - cerrarWindow");
            ENTITY_GLOBAL.Instance.INDICADORCOPYARDOBLE = 0;
            Session["COPIA_FORMULARIOEPICRISISI"] = "INACTIVA";

            Session["COPIA_FORMULARIOEPIDIAG"] = "INACTIVA";



            Session["COPIA_FORMULARIOALTACOP"] = "INACTIVA";

            Session["COPIA_FORMULARIOALTAEXAMEM"] = "INACTIVA";

            var win = X.GetCmp<Window>(id);
            if (win != null)
            {
                //X.Msg.Alert("Error ", "000000 WIN NO NULO." + win.Title).Show();
                ENTITY_GLOBAL.Instance.INDICA_VISIBLE_TB_IMPRESION = 1;
                //ENTITY_GLOBAL.Instance.ESTADOFORMULARIO_ACCION = (String)Session["ESTADOANTERIOR"];
                ENTITY_GLOBAL.Instance.DinamicSecuencia = 0;
                //Session["HC_MedicamentoDietaList"] = null;
                //Session["HC_MedicamentoDetalleList"] = null;
                //Session["HC_MedicamentoList"] = null;
                //Session["HC_MedicamentoID"] = null;
                //Session["HC_MedicamentoDietaList"] = null;
                win.Hide();
            }




            //return showMensajeBox("INFORMACION EXITO","Mensaje","INFO");
            return this.Direct();
        }

        public System.Web.Mvc.ActionResult setVariablesTempSession_Default(String indicaController)
        {
            Log.Information("ControllerGeneral - setVariablesTempSession_Default");
            if (indicaController == UTILES_MENSAJES.PATH_MAIN_HCLINICA)
            {
                Session["DATA_COPIA_FORM"] = null;
                Session["COPIA_FORMULARIO"] = null;
                Session["MODO_BITACORA"] = null;
                ENTITY_GLOBAL.Instance.INDICA_SELECCIONCRONOLOGIAS = 0;
            }
            else
            {

            }

            return this.Direct();
        }

    }
}