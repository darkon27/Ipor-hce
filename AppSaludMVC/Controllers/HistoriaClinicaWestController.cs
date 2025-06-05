using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service.MiscelaneosService;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Serilog;

namespace AppSaludMVC.Controllers
{
    public class HistoriaClinicaWestController : Controller
    {
        //
        // GET: /HistoriaClinicaWest/

        public string draw = "";
        public string start = "";
        public string length = "";
        public string sortColumn = "";
        public string sortColumnDir = "";
        public string searchValue = "";
        public int pageSize, skip, recordsTotal;

        String documento = "";
        String TipoDocumento = "";
        String cod_sucursal = "";

        //String URL_SERVER = "http://localhost/ServiceApi/";
        //String URL_SERVER = "http://10.1.4.72/ServiceApi/";
        //String URL_SERVER = "http://10.1.4.75/ServiceApi/";
        //http://localhost:54561/Consulta/ListarVisorHistoria
        String URL_SERVER = "";
        public void SetDNI()
        {
            Log.Information("HistoriaClinicaWestController - SetDNI - Entrar");
            if (Session["VW_ATENCIONPACIENTE_GEN_SELECC"] != null)
            {
                if (ENTITY_GLOBAL.Instance.COD_BANDEJA == "TRIAJE")
                {
                    documento = ENTITY_GLOBAL.Instance.DocumentoCapTriaje.Trim();
                }
                else
                {
                    VW_ATENCIONPACIENTE_GENERAL objAtencionPacSelecc = (VW_ATENCIONPACIENTE_GENERAL)Session["VW_ATENCIONPACIENTE_GEN_SELECC"];
                    if (objAtencionPacSelecc != null)
                    {
                        try
                        {
                            documento = objAtencionPacSelecc.Documento.Trim();
                            TipoDocumento = objAtencionPacSelecc.TipoDocumento.Trim();
                            if (objAtencionPacSelecc.UnidadReplicacion != null)
                            {
                                cod_sucursal = objAtencionPacSelecc.UnidadReplicacion.Trim();
                            }


                            var birthday = Convert.ToDateTime(objAtencionPacSelecc.FechaNacimiento);
                            DateTime now = DateTime.Today;
                            int age = now.Year - birthday.Year;
                            if (now.Month < birthday.Month || (now.Month == birthday.Month && now.Day < birthday.Day))//not had bday this year yet
                                age--;

                            ViewBag.TxtEdadPaciente = age;
                            ViewBag.TxtPacienteOA = objAtencionPacSelecc.PacienteNombre;

                        }
                        catch (Exception ex)
                        {
                            EventLog.GenerarLogError(ex);
                        }
                    }
                }
            }
        }

        public ActionResult Index()
        {
            Log.Information("HistoriaClinicaWestController - Index - Entrar");
            SetDNI();

            //            Guardar();
            return View();
        }

        public class Usuario
        {
            public Usuario(int id, String user, String password)
            {
                this.id = id;
                this.user = user;
                this.password = password;
            }
            public int id { get; set; }
            public String user { get; set; }
            public String password { get; set; }
        }

        [HttpPost]
        public JsonResult getUsersDate(consultaEnfermedad consulta)
        {
            Log.Information("HistoriaClinicaWestController - getUsersDate - Entrar");
            List<MA_MiscelaneosDetalle> links = ENTITY_GLOBAL.Instance.Links.Where(x => x.CodigoElemento.Trim() == consulta.CodigoSucursal).ToList();

            SetDNI();

            var link = links[0].ValorCodigo1.Trim();

            URL_SERVER = link;


            //documento = "08151830";
            List<SS_HC_Diagnostico_FE> list = new List<SS_HC_Diagnostico_FE>();

            HttpClient clienteHttp = new HttpClient();

            VisorClass visor = new VisorClass();
            visor.Accion = 1;
            //visor.Documento = "80312606";
            visor.Documento = documento;
            visor.cod_sucursal = consulta.CodigoSucursal;

            visor.tipoDocumento = TipoDocumento;
            if (!string.IsNullOrEmpty(consulta.FechaInicio.ToString()))
            {
                if (consulta.FechaInicio >= Convert.ToDateTime("01/12/2008"))
                {
                    visor.FechaInicio = consulta.FechaInicio;
                }
                else
                {
                    DateTime Fecha1 = Convert.ToDateTime("2004-01-01");
                    visor.FechaInicio = Fecha1;
                }
            }
            else
            {
                DateTime Fecha1 = Convert.ToDateTime("2004-01-01");
                visor.FechaInicio = Fecha1;
            }

            if (!string.IsNullOrEmpty(consulta.FechaFin.ToString()))
            {
                visor.FechaFin = consulta.FechaFin;
                if (consulta.FechaFin >= Convert.ToDateTime("01/12/2008"))
                {
                    visor.FechaFin = consulta.FechaFin;
                }
                else
                {
                    DateTime Fecha2 = DateTime.Now;
                    visor.FechaFin = Fecha2;
                }
            }
            else
            {
                DateTime Fecha2 = DateTime.Now;
                visor.FechaFin = Fecha2;
            }

            clienteHttp.BaseAddress = new Uri(URL_SERVER);

            var request = clienteHttp.PostAsync("Consulta/ListarVisorHistoriaFecha", visor, new JsonMediaTypeFormatter()).Result;
            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;

                var arrayOfLines = JArray.Parse(resultString);
                foreach (var a in arrayOfLines)
                {
                    int nu = 0;


                    try
                    {
                        SS_HC_Diagnostico_FE d = new SS_HC_Diagnostico_FE();

                        d.IdPaciente = 1;
                        d.Observacion = a["CodigoOA"].ToString();
                        d.CitaFecha = a["CitaFecha"].ToString();
                        d.Secuencia = Convert.ToInt32(a["LineaOrdenAtencion"]);
                        d.Origen = a["Origen"].ToString();
                        d.Sucursal = a["Sucursal"].ToString();
                        // d.CodigoDiagnostico = a["CodigoDiagnostico"].ToString();
                        d.UnidadReplicacion = a["NombreEspecialidad"].ToString();
                        d.UsuarioCreacion = a["TipoAtencionDescX"].ToString();
                        d.UsuarioModificacion = a["PacienteNombre"].ToString();
                        d.IndicadorAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]);
                        d.TipoAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]) + "|" + Convert.ToInt32(a["LineaOrdenAtencion"]) + "|" + a["Sucursal"].ToString() + "|" + a["TipoAtencionDescX"].ToString();
                        //d.EpisodioClinico = Convert.ToInt32(a["EpisodioClinicoHCE"]);
                        //d.IdDiagnostico = Convert.ToInt32(a["IDEPISODIOAtencionHCE"]);
                        //d.IdDiagnosticoValoracion = Convert.ToInt32(a["IdPacienteHCE"]);
                        if (ENTITY_GLOBAL.Instance.COPIADO_DISABLED == "BN")
                        {
                            d.IndicadorNuevo = 1;
                        }
                        else
                        {
                            d.IndicadorNuevo = 0;
                        }




                        if (a["EstadoEpiAtencion"] == null)
                        {
                            d.Estado = 0;
                        }
                        else
                        {
                            d.Estado = Convert.ToInt32(a["EstadoEpiAtencion"]);
                        }

                        list.Add(d);
                    }
                    catch (Exception e)
                    {
                        Log.Information("HistoriaClinicaWestController - getUsersDate - Bloque Catch");
                        Log.Error(e, e.Message);
                    }
                    nu++;
                    if (nu == 1)
                    {
                        var birthday = Convert.ToDateTime(a["FechaNacimiento"]);
                        DateTime now = DateTime.Today;

                        int age = now.Year - birthday.Year;

                        if (now.Month < birthday.Month || (now.Month == birthday.Month && now.Day < birthday.Day))//not had bday this year yet
                            age--;

                        ViewBag.TxtEdadPaciente = age;
                        var PacienteNombre = list[0].UsuarioModificacion;
                        ViewBag.TxtPacienteOA = PacienteNombre;

                    }
                }
            }

            object json = new { data = list };

            return Json(json, JsonRequestBehavior.AllowGet);

        }

        public JsonResult getEstados()
        {
            Log.Information("HistoriaClinicaWestController - getEstados - Entrar");
            var objMiscl = new MA_MiscelaneosDetalle();
            var aplica = ENTITY_GLOBAL.Instance.APLICATIVOID;
            var model = new SEGURIDADCONCEPTO();


            objMiscl.ACCION = "COMBOSGENERICOS";
            objMiscl.AplicacionCodigo = "WA";
            objMiscl.CodigoTabla = "WSSUCURSAL";
            objMiscl.ValorCodigo5 = ENTITY_GLOBAL.Instance.USUARIO;
            if (objMiscl.CodigoTabla == "FAVORITOLISTA")
            {
                objMiscl.ValorCodigo3 = Convert.ToString(ENTITY_GLOBAL.Instance.IDAGENTE);
            }
            var resulObjMiscl = new MA_MiscelaneosDetalle();

            var data = ENTITY_GLOBAL.Instance.INDICADOR_COMBO;
            string JSONstring = string.Empty;
            JSONstring = JsonConvert.SerializeObject(data);

            List<MA_MiscelaneosDetalle> resulMiscelaneosTitulo = (List<MA_MiscelaneosDetalle>)Newtonsoft.Json.JsonConvert.DeserializeObject(JSONstring, typeof(List<MA_MiscelaneosDetalle>));
            List<MA_MiscelaneosDetalle> listxx = resulMiscelaneosTitulo.Where(x => x.CodigoElemento == ENTITY_GLOBAL.Instance.UnidadReplicacion).ToList();
            resulMiscelaneosTitulo = SvcMiscelaneos.GetFormTitulo(objMiscl);

            List<MA_MiscelaneosDetalle> listxx2 = resulMiscelaneosTitulo.Where(x => x.CodigoElemento.Trim() == ENTITY_GLOBAL.Instance.UnidadReplicacion).ToList();

            ENTITY_GLOBAL.Instance.Links.Clear();

            foreach (var item in resulMiscelaneosTitulo)
            {

                MA_MiscelaneosDetalle mi = new MA_MiscelaneosDetalle();

                item.UsuarioActual = ENTITY_GLOBAL.Instance.UnidadReplicacion;
                item.CodigoElemento = item.CodigoElemento.Trim();

                mi.ValorCodigo1 = item.ValorCodigo1;
                mi.CodigoElemento = item.CodigoElemento.Trim();

                ENTITY_GLOBAL.Instance.Links.Add(mi);
            }

            return Json(resulMiscelaneosTitulo, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public JsonResult getUsers()
        {
            Log.Information("HistoriaClinicaWestController - getUsers - Entrar");
            List<MA_MiscelaneosDetalle> links = ENTITY_GLOBAL.Instance.Links.Where(x => x.CodigoElemento.Trim() == ENTITY_GLOBAL.Instance.UnidadReplicacion).ToList();

            SetDNI();
            var link = links[0].ValorCodigo1.Trim();
            URL_SERVER = link;

            List<SS_HC_Diagnostico_FE> list = new List<SS_HC_Diagnostico_FE>();
            HttpClient clienteHttp = new HttpClient();
            VisorClass visor = new VisorClass();
            visor.Accion = 1;
            //  visor.cod_sucursal = cod_sucursal;
            visor.cod_sucursal = ENTITY_GLOBAL.Instance.Sucursal;
            visor.Documento = documento;
            visor.tipoDocumento = TipoDocumento;
            clienteHttp.BaseAddress = new Uri(URL_SERVER);
            var request = clienteHttp.PostAsync("Consulta/ListarVisorHistoria", visor, new JsonMediaTypeFormatter()).Result;
            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;

                string Jsons = Newtonsoft.Json.JsonConvert.SerializeObject(request);
                JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
                CW_VisorHistoria item = jsonSerializer.Deserialize<CW_VisorHistoria>(Jsons);
                List<CW_VisorHistoria> Resultado = (List<CW_VisorHistoria>)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(List<CW_VisorHistoria>));

                ENTITY_GLOBAL.listaresponsehc = Resultado;

                var arrayOfLines = JArray.Parse(resultString);
                foreach (var a in arrayOfLines)
                {
                    int nu = 0;
                    try
                    {
                        SS_HC_Diagnostico_FE d = new SS_HC_Diagnostico_FE();
                        d.IdPaciente = 1;
                        d.Observacion = a["CodigoOA"].ToString();
                        d.CitaFecha = a["CitaFecha"].ToString();
                        d.Secuencia = Convert.ToInt32(a["LineaOrdenAtencion"]);
                        d.Sucursal = a["Sucursal"].ToString();
                        d.Origen = a["Origen"].ToString();
                        //  d.CodigoDiagnostico = a["CodigoDiagnostico"].ToString();
                        //  d.FechaRegistro. = Convert.ToDateTime(a["FechaCita"]);                        
                        d.UnidadReplicacion = a["NombreEspecialidad"].ToString();
                        d.UsuarioCreacion = a["TipoAtencionDescX"].ToString();
                        d.UsuarioModificacion = a["PacienteNombre"].ToString();
                        d.IndicadorAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]);
                        d.TipoAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]) + "|" + Convert.ToInt32(a["LineaOrdenAtencion"]) + "|" + a["Sucursal"].ToString() + "|" + a["TipoAtencionDescX"].ToString();

                        //d.EpisodioClinico = Convert.ToInt32(a["EpisodioClinicoHCE"]);
                        //d.IdDiagnostico = Convert.ToInt32(a["IDEPISODIOAtencionHCE"]);
                        //d.IdDiagnosticoValoracion = Convert.ToInt32(a["IdPacienteHCE"]);
                        if (ENTITY_GLOBAL.Instance.COPIADO_DISABLED == "BN")
                        {
                            d.IndicadorNuevo = 1;
                        }
                        else
                        {
                            d.IndicadorNuevo = 0;
                        }
                        if (a["EstadoEpiAtencion"] == null)
                        {
                            d.Estado = 0;
                        }
                        else
                        {
                            d.Estado = Convert.ToInt32(a["EstadoEpiAtencion"]);
                        }

                        list.Add(d);
                    }
                    catch (Exception e)
                    {
                        Log.Information("HistoriaClinicaWestController - getUsers - Bloque Catch");
                        Log.Error(e, e.Message);
                    }
                    nu++;
                    if (nu == 1)
                    {
                        var birthday = Convert.ToDateTime(a["FechaNacimiento"]);
                        DateTime now = DateTime.Today;
                        int age = now.Year - birthday.Year;

                        if (now.Month < birthday.Month || (now.Month == birthday.Month && now.Day < birthday.Day))//not had bday this year yet
                            age--;

                        ViewBag.TxtEdadPaciente = age;
                        var PacienteNombre = list[0].UsuarioModificacion;
                        ViewBag.TxtPacienteOA = PacienteNombre;
                    }
                }
            }

            object json = new { data = list };
            return Json(json, JsonRequestBehavior.AllowGet);

        }

        //[HttpPost]
        public ActionResult Json()
        {
            Log.Information("HistoriaClinicaWestController - Json - Entrar");
            List<Usuario> lista = new List<Usuario>();
            SetDNI();
            //documento = "08151830";
            #region CODEwS
            List<SS_HC_Diagnostico_FE> list = new List<SS_HC_Diagnostico_FE>();
            HttpClient clienteHttp = new HttpClient();
            VisorClass visor = new VisorClass();
            visor.Accion = 1;
            //visor.Documento = "80312606";
            visor.Documento = documento;
            visor.tipoDocumento = TipoDocumento;
            clienteHttp.BaseAddress = new Uri(URL_SERVER);
            var request = clienteHttp.PostAsync("Consulta/ListarVisorHistoria", visor, new JsonMediaTypeFormatter()).Result;
            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;
                //list = (List<SS_HC_Diagnostico_FE>)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(List<SS_HC_Diagnostico_FE>));

                var arrayOfLines = JArray.Parse(resultString);
                foreach (var a in arrayOfLines)
                {
                    int nu = 0;
                    SS_HC_Diagnostico_FE d = new SS_HC_Diagnostico_FE();
                    d.IdPaciente = 1;
                    d.Observacion = a["CodigoOA"].ToString();
                    d.CitaFecha = a["CitaFecha"].ToString();
                    d.Secuencia = Convert.ToInt32(a["LineaOrdenAtencion"]);
                    d.UnidadReplicacion = a["NombreEspecialidad"].ToString();
                    d.UsuarioCreacion = a["TipoOrdenAtencionNombre"].ToString();
                    d.UsuarioModificacion = a["PacienteNombre"].ToString();
                    d.IndicadorAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]);
                    d.TipoAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]) + "|" + Convert.ToInt32(a["LineaOrdenAtencion"]);
                    d.EpisodioClinico = Convert.ToInt32(a["EpisodioClinicoHCE"]);
                    d.IdDiagnostico = Convert.ToInt32(a["IDEPISODIOAtencionHCE"]);
                    d.IdDiagnosticoValoracion = Convert.ToInt32(a["IdPacienteHCE"]);
                    d.Estado = Convert.ToInt32(a["Estado"]);
                    list.Add(d);
                    nu++;
                    if (nu == 1)
                    {
                        var birthday = Convert.ToDateTime(a["FechaNacimiento"]);
                        DateTime now = DateTime.Today;
                        int age = now.Year - birthday.Year;
                        if (now.Month < birthday.Month || (now.Month == birthday.Month && now.Day < birthday.Day))//not had bday this year yet
                            age--;

                        ViewBag.TxtEdadPaciente = age;
                        var PacienteNombre = list[0].UsuarioModificacion;
                        ViewBag.TxtPacienteOA = PacienteNombre;

                    }
                }
            }

            #endregion
            var query = list.AsQueryable();
            list = query.Skip(skip).Take(pageSize).ToList();
            return Json(new { data = list });
        }

        [HttpPost]
        public JsonResult ListDate(consultaEnfermedad consulta)
        {
            Log.Information("HistoriaClinicaWestController - ListDate - Entrar");
            SetDNI();
            //documento = "08151830";
            List<SS_HC_Diagnostico_FE> list = new List<SS_HC_Diagnostico_FE>();
            HttpClient clienteHttp = new HttpClient();
            VisorClass visor = new VisorClass();
            visor.Accion = 1;
            //visor.Documento = "80312606";
            visor.Documento = documento;
            visor.tipoDocumento = TipoDocumento;
            visor.FechaInicio = consulta.FechaInicio;
            visor.FechaFin = consulta.FechaFin;
            clienteHttp.BaseAddress = new Uri(URL_SERVER);
            var request = clienteHttp.PostAsync("Consulta/ListarVisorHistoriaFecha", visor, new JsonMediaTypeFormatter()).Result;

            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;
                //list = (List<SS_HC_Diagnostico_FE>)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(List<SS_HC_Diagnostico_FE>));

                var arrayOfLines = JArray.Parse(resultString);
                foreach (var a in arrayOfLines)
                {
                    try
                    {
                        int nu = 0;
                        try
                        {
                            SS_HC_Diagnostico_FE d = new SS_HC_Diagnostico_FE();
                            d.IdPaciente = 1;
                            d.Observacion = a["CodigoOA"].ToString();
                            d.Secuencia = Convert.ToInt32(a["LineaOrdenAtencion"]);
                            d.UnidadReplicacion = a["NombreEspecialidad"].ToString();
                            d.UsuarioCreacion = a["TipoAtencionDescX"].ToString();
                            d.UsuarioModificacion = a["PacienteNombre"].ToString();
                            d.IndicadorAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]);
                            d.TipoAntecedente = Convert.ToInt32(a["IdOrdenAtencion"]) + "|" + Convert.ToInt32(a["LineaOrdenAtencion"]);
                            d.EpisodioClinico = Convert.ToInt32(a["EpisodioClinicoHCE"]);
                            d.IdDiagnostico = Convert.ToInt32(a["IDEPISODIOAtencionHCE"]);
                            d.IdDiagnosticoValoracion = Convert.ToInt32(a["IdPacienteHCE"]);
                            if (ENTITY_GLOBAL.Instance.COPIADO_DISABLED == "BN")
                            {
                                d.IndicadorNuevo = 1;
                            }
                            else
                            {
                                d.IndicadorNuevo = 0;
                            }
                            if (a["EstadoEpiAtencion"] == null)
                            {
                                d.Estado = 0;
                            }
                            else
                            {
                                d.Estado = Convert.ToInt32(a["EstadoEpiAtencion"]);
                            }

                            list.Add(d);
                        }
                        catch (Exception e)
                        {
                            Log.Information("HistoriaClinicaWestController - ListDate - Bloque Catch");
                            Log.Error(e, e.Message);
                        }
                        nu++;
                        if (nu == 1)
                        {
                            var birthday = Convert.ToDateTime(a["FechaNacimiento"]);
                            DateTime now = DateTime.Today;
                            int age = now.Year - birthday.Year;
                            if (now.Month < birthday.Month || (now.Month == birthday.Month && now.Day < birthday.Day))//not had bday this year yet
                                age--;
                            ViewBag.TxtEdadPaciente = age;
                            var PacienteNombre = list[0].UsuarioModificacion;
                            ViewBag.TxtPacienteOA = PacienteNombre;

                        }
                    }
                    catch (Exception e)
                    {
                        Log.Error(e, e.Message);
                    }
                }
            }
            object json = new { data = list };
            return Json(json, JsonRequestBehavior.AllowGet);
        }

        public JsonResult getDataHistoriaClinica(String ID)
        {
            //Log.Information("HistoriaClinicaWestController - getDataHistoriaClinica - Entrar");
            string[] data = ID.Split('|');
            String ioA = data[0].ToString();
            String linea = data[1].ToString();
            String sucursal = data[2].ToString();
            String tipoAtencion = data[3].ToString();
            bool ambulatorio = false;
            if (tipoAtencion == "Ambulatoria")
            {
                ambulatorio = true;
            }

            List<CW_VisorHistoria> list2 = new List<CW_VisorHistoria>();
            List<VW_SS_HCE_VisorAnamnesis> listaAnamnesis = new List<VW_SS_HCE_VisorAnamnesis>();
            HttpClient clienteHttp = new HttpClient();
            VisorClass visor = new VisorClass();
            List<MA_MiscelaneosDetalle> links = ENTITY_GLOBAL.Instance.Links.Where(x => x.CodigoElemento.Trim() == sucursal).ToList();

            SetDNI();

            var link = links[0].ValorCodigo1.Trim();
            URL_SERVER = link;
            visor.Accion = 3;
            visor.Documento = documento;
            visor.tipoDocumento = linea;
            visor.IdOrdenAtencion = ioA;
            visor.cod_sucursal = sucursal;

            clienteHttp.BaseAddress = new Uri(URL_SERVER);
            var request = clienteHttp.PostAsync("Consulta/ListarVisorHistoriaId", visor, new JsonMediaTypeFormatter()).Result;
            if (request.IsSuccessStatusCode)
            {
                var resultString = request.Content.ReadAsStringAsync().Result;
                string Jsons = Newtonsoft.Json.JsonConvert.SerializeObject(request);
                JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
                CW_VisorHistoria item = jsonSerializer.Deserialize<CW_VisorHistoria>(Jsons);
                List<CW_VisorHistoria> Resultado = (List<CW_VisorHistoria>)Newtonsoft.Json.JsonConvert.DeserializeObject(resultString, typeof(List<CW_VisorHistoria>));

                ENTITY_GLOBAL.listaresponsehc = Resultado;
                list2 = new List<CW_VisorHistoria>(Resultado);
                if (ambulatorio)
                {
                    for (int i = 0; i < list2[0].list_VW_SS_HCE_VisorReceta.Count(); i++)
                    {
                        if (!string.IsNullOrEmpty(list2[0].list_VW_SS_HCE_VisorReceta[0].IndicacionesEsp.ToString()))
                        {                           
                           list2[0].list_VW_SS_HCE_VisorReceta[0].IndicacionesEsp = list2[0].list_VW_SS_HCE_VisorReceta[0].IndicacionesEsp.Trim();
                        }
                    }
                }
            }
            return Json(list2, JsonRequestBehavior.AllowGet);
        }

        public string Send<T>(string url, T objectRequest, string method = "POST")
        {
            string result = "";
            try
            {
                Log.Information("HistoriaClinicaWestController - Send - Entrar");
                JavaScriptSerializer js = new JavaScriptSerializer();
                //serializamos el objeto
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(objectRequest);

                //peticion
                WebRequest request = WebRequest.Create(url);
                //headers
                request.Method = method;
                request.PreAuthenticate = true;
                request.ContentType = "application/json;charset=utf-8'";
                request.Timeout = 10000; //esto es opcional

                using (var streamWriter = new StreamWriter(request.GetRequestStream()))
                {
                    streamWriter.Write(json);
                    streamWriter.Flush();
                }

                var httpResponse = (HttpWebResponse)request.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    result = streamReader.ReadToEnd();
                }
            }
            catch (Exception e)
            {
                Log.Information("HistoriaClinicaWestController - Send - Bloque Catch");
                Log.Error(e, e.Message);
                result = e.Message;

            }
            return result;
        }

        public class consultaEnfermedad
        {
            public string TAB { get; set; }
            public long IdordenAtencion { get; set; }
            public int IdPaciente { get; set; }
            public int LineaOrdenAtencion { get; set; }
            public string IdInforme { get; set; }
            public int Secuencial { get; set; }
            public int IdConcepto { get; set; }
            public string ValorCadena { get; set; }
            public string ValorNumerico { get; set; }
            public string Estado { get; set; }
            public string UsuarioCreacion { get; set; }
            public string Codigo { get; set; }
            public string CodigoSucursal { get; set; }
            public DateTime FechaInicio { get; set; }
            public DateTime FechaFin { get; set; }

        }


    }
}