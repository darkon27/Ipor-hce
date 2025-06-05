using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Ext.Net;
using Ext.Net.MVC;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service.SeguridadService;

namespace AppSaludMVC.Controllers
{
    using AppSaludMVC.Models;
    using SoluccionSalud.Service.PersonaMastService;
    using SvcDiccionario = SoluccionSalud.Service.DiccionarioService.SvcDiccionario;
    using SvcSeguridad = SoluccionSalud.Service.SeguridadService.SvcSeguridadConcepto;
    using SvcMiscelaneos = SoluccionSalud.Service.MiscelaneosService.SvcMiscelaneos;
    public class GestionController : System.Web.Mvc.Controller
    {
        //
        // GET: /Gestion/
        public PartialViewResult PanelNorth(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "PanelNorth",
                WrapByScriptTag = false
            };
        }
        public System.Web.Mvc.ActionResult GrillaListadoPacientes(int start, int limit, string descript)
        {
            var Listar = new List<PERSONAMAST>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new PERSONAMAST();
            LocalEnty.ACCION = "LISTAR";
            LocalEnty.Estado = "";
            LocalEnty.NombreCompleto = descript;
            return this.Store(SvcPersonaMast.GetSelectPersonaMast(LocalEnty).ToList());
        }
        public System.Web.Mvc.ActionResult GrillaListadPaginas(int start, int limit, string descript)
        {
            var Listar = new List<SEGURIDADCONCEPTO>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new SEGURIDADCONCEPTO();
            LocalEnty.ACCION = "REGISROPAGINAS";
            LocalEnty.GRUPO = "GRUPO018";
            LocalEnty.CONCEPTO = descript;
            Listar = SvcSeguridad.GetSelectSP(LocalEnty);
            //return this.Store(Listar);
            return this.Store(Listar.ToList());
        }
        public System.Web.Mvc.ActionResult GrillaListadoDiccionario(int start, int limit, string descript)
        {
          
            var Listar = new List<SS_CE_DICCIONARIO>();
            System.Collections.IEnumerable dtoArray;
            int total;
            var LocalEnty = new SS_CE_DICCIONARIO();
            LocalEnty.ACCION = "LISTAR";
            LocalEnty.ESTADO = 1;
            LocalEnty.NOMBREDICCIONARIO = descript;
     
            return this.Store(SvcDiccionario.GetSelectDiccionario(LocalEnty).ToList());
        }
        public System.Web.Mvc.ActionResult GetListadoDiccionario(int start, int limit)
        {
            var Listar = new List<SS_CE_DICCIONARIO>();
            int total;
            var LocalEnty = new SS_CE_DICCIONARIO();
            LocalEnty.ACCION = "LISTAR";
            LocalEnty.ESTADO = 1;
            Listar = SoluccionSalud.Service.DiccionarioService.SvcDiccionario.GetSelectDiccionario(LocalEnty);

            total = 2;
            return Json(new { data = SvcDiccionario.GetSelectDiccionario(LocalEnty).ToList(), total = total }, System.Web.Mvc.JsonRequestBehavior.AllowGet); 
        }
        public System.Web.Mvc.ActionResult GetEstadosRegistro(string tiporegistro)
        {
            return this.Store(CombosGenericos.GetEstadoRegistro(tiporegistro));
        }

        public System.Web.Mvc.ActionResult EventGuardarDiccionario(SS_CE_DICCIONARIO objDiccionar)
        {
            objDiccionar.ACCION = "INSERT";
            var retorno = SvcDiccionario.GetSelectDiccionario(objDiccionar);
            if (retorno[0].ESTADO == 9)
            {
                X.MessageBox.Alert("Error", "Ya existe Registro").Show();
                return this.Direct();
            }
            else {
                X.MessageBox.Alert("Ok", "Se registró safictariamente.").Show();
                return this.Direct();
            }
        }
        public System.Web.Mvc.ActionResult CCEP0902_ViewRegistro(String Eventos, String selection, String Mode)
        {


            if (Eventos == "New") {
               
            }

            return View();
           // return null;
            /*
            SelectedRowCollection src = JSON.Deserialize<SelectedRowCollection>(selection);
            List<int> omitIds = new List<int>();
            foreach (SelectedRow row in src)
            {
                omitIds.Add(Convert.ToInt32(row.RecordID));
            }
            var values = new System.Web.Routing.RouteValueDictionary();
            values.Add("id", omitIds[0]);

            return View();*/
        }
        public System.Web.Mvc.ActionResult CCEP0951_View() // Seguridad PAginas
        {
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP0903_View() // Seguridad PAginas
        {
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP0902_View() //Diccionario
        {
            return View();
        }
        public System.Web.Mvc.ActionResult HomeCenter()
        {
            return View();
        }

        public System.Web.Mvc.ActionResult FormView()
        {
            var html = "Html.TextBox(" + "'Textbox1'" + ", " + "'val'" + ")";
            ViewBag.RenderedHtml = html;
          
            return View();
        }
        [DirectMethod]
        public System.Web.Mvc.ActionResult SetPanel()
        {
            var pnlItem = this.GetCmp<Panel>("PanelNorth");
            pnlItem.Split = false;
            pnlItem.Visible = false;
            pnlItem.Collapsed = false;
            pnlItem.Split = false;
            pnlItem.Reload();

            return this.Direct();
        }
        public PartialViewResult LoadCentral(string containerId, string text)
        {
            //return new Ext.Net.MVC.PartialViewResult()
            // view is loaded via ajax request (DirectEvent) therefore script tags will be deactivated automatically
            var model = new SEGURIDADCONCEPTO();
            model.CONCEPTO = text.Trim() + "_View";
           // model.CONCEPTO = "FormView";

            
            return new PartialViewResult
            {
                ViewName = "PanelCenter",
                ContainerId = containerId,
                Model = model,
                //SingleControl = true,
                ClearContainer = true,
                 WrapByScriptTag = true,
                RenderMode = RenderMode.AddTo
            };
           
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


        public System.Web.Mvc.ActionResult Index()
        {
            return View();
        }

        public PartialViewResult LoadViewPacientes(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "GrillaPacientes",
                WrapByScriptTag = false,
                ClearContainer = true
            };
        }
        public PartialViewResult LoadViewIzquierdaPanel(string containerId)
        {
            return new PartialViewResult
            {
                ContainerId = containerId,
                ViewName = "VistaEsteMenu",
                WrapByScriptTag = false
            };
        }
    
        public System.Web.Mvc.ActionResult GetCustomers(int start, int limit)
        {
            System.Collections.IEnumerable dtoArray;
            int total;

            
            return Json(null);
        }

        public System.Web.Mvc.ActionResult GetSelectPacientes(String Name, String selection, String Mode)
        {
            var values = new System.Web.Routing.RouteValueDictionary();
            values.Add("id", '0');
            string url = string.Format("/HClinica/Index?idCodigo={0}", '0');

            //return Redirect(url);
            //return this.RedirectToAction("Index", "PacienteGeneral");
            return this.RedirectToAction("Index", "HClinica");
        }
        public System.Web.Mvc.ActionResult GetSelectPaciente(String Name, String selection, String Mode)
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
           
           // return Redirect(url);
            return this.RedirectToAction("Index", "HClinica");
           // return this.Content(ExamplesModel.GetExamplesNodes().ToJson());


          //  return this.RedirectToAction(url);

            //if (node == "Root")
           // {
           //     return this.Content(ExamplesModel.GetExamplesNodes().ToJson());
           // }

          //  return new System.Web.Mvc.HttpStatusCodeResult((int)System.Net.HttpStatusCode.BadRequest);


           // return RedirectToAction("Index", "HClinica", new { id = omitIds[0] });
           // return this.RedirectToAction("Index", "HClinica");
           //   return this.Direct();
          //  return View();
         }
        


    }
}
