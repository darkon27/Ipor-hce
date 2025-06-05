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
    public class PacienteGeneralController : System.Web.Mvc.Controller
    {
        //
        // GET: /PacienteGeneral/

        public System.Web.Mvc.ActionResult Index()
        {
            return View();
        }
        public System.Web.Mvc.ActionResult CCEP0902_View() //Paciente
        {
            return View();
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
                        entidaLocal.ACCION = "CONCEPTOPADRE";
                    entidaLocal.CONCEPTO = node.Trim();
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

        public System.Web.Mvc.ActionResult GetSelectPaciente(String Name, String selection, String Mode)
        {
            var values = new System.Web.Routing.RouteValueDictionary();
            values.Add("id", '0');
            string url = string.Format("/HClinica/Index?idCodigo={0}", '0');

            //return Redirect(url);
            //return this.RedirectToAction("Index", "PacienteGeneral");
            return this.RedirectToAction("Index", "HClinica");
        }
    }
}
