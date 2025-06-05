using Serilog;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Service._FormularioNuevo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppSaludMVC.Controllers
{
    public class DispositivosController : Controller
    {
        //
        // GET: /Dispositivos/

        public ActionResult Index()
        {
            Log.Information("DispositivosController - Index - Entrar");
            ENTITY_GLOBAL.listaCuerpos.Clear();
            if (ENTITY_GLOBAL.listaCuerpos.Count >= 0)
            {
                DataBandeja objbandeja = new DataBandeja();
                objbandeja.UnidadReplicacion = "LISTA_PARA";
                objbandeja.IdEspecialidad = (int)ENTITY_GLOBAL.Instance.PacienteID; //IDPACIENTE
                objbandeja.Estado = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion; //ID_EPISODIO_ATENCION
                objbandeja.Prioridad = (int)ENTITY_GLOBAL.Instance.EpisodioClinico; //EPISODIO_CLINICO
                var Listar2 = new List<SP_ListarBandejaTriaje_Result>();
                Listar2 = SvcEpisodioTriaje.EpisorioTriaje_Listar(objbandeja, 1, 1);


                foreach (var item in Listar2)
                {

                    CuerpoHumano p = new CuerpoHumano();
                    p.Id = item.IdPaciente;
                    p.Name = item.Accion;
                    p.X = item.UsuarioCreacion;
                    p.Y = item.UsuarioModificacion;



                    ENTITY_GLOBAL.listaCuerpos.Add(p);
                }

            }


            return View();
        }

        public JsonResult ReqDataHuman(CuerpoHumano p)
        {
            Log.Information("DispositivosController - ReqDataHuman - Entrar");
            SS_HC_EpisodioTriaje obje = new SS_HC_EpisodioTriaje();
            obje.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            obje.IdPersonalSalud = p.Id;
            obje.ObservacionFirma = p.Name;
            obje.UsuarioCreacion = p.X;
            obje.Accion = "C_LOCALIZATION";
            obje.UsuarioModificacion = p.Y;
            obje.Estado = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            obje.IdPaciente =(int)ENTITY_GLOBAL.Instance.PacienteID;
            obje.IdPrioridad = (int)ENTITY_GLOBAL.Instance.EpisodioClinico; 



           var idResultado = SvcEpisodioTriaje.setMantenimientoEpisodioTriaje(obje);

           if (idResultado >= 1)
           {

               ENTITY_GLOBAL.listaCuerpos.Add(p);

               if (ENTITY_GLOBAL.listaCuerpos.Count >= 1)
               {
                   var IdCounter = ENTITY_GLOBAL.listaCuerpos.Max(r => r.Id);

                   ENTITY_GLOBAL.listaCuerpos.Where(S => S.Id == S.Id).Select(S =>
                   {
                       S.IdCounter = IdCounter;
                       return S;
                   }).ToList();
               }
           }
         

            


            return Json(1, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateDataHuman(CuerpoHumano p)
        {
            Log.Information("DispositivosController - UpdateDataHuman - Entrar");
            SS_HC_EpisodioTriaje obje = new SS_HC_EpisodioTriaje();
            obje.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            obje.IdPersonalSalud = p.Id;
            obje.ObservacionFirma = p.Name;
            //obje.UsuarioCreacion = p.X;
            obje.Accion = "P_LOCALIZATION";
            //obje.UsuarioModificacion = p.Y;
            obje.Estado = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            obje.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            obje.IdPrioridad = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;



            var idResultado = SvcEpisodioTriaje.setMantenimientoEpisodioTriaje(obje);

            if (idResultado >= 1)
            {
                ENTITY_GLOBAL.listaCuerpos.Where(S => S.Id == p.Id).Select(S =>
                {
                    S.Name = p.Name;

                    return S;
                }).ToList();

            }


         
            return Json(1, JsonRequestBehavior.AllowGet);
        }




        public JsonResult DeleteItem(CuerpoHumano p)
        {

            Log.Information("DispositivosController - DeleteItem - Entrar");

            SS_HC_EpisodioTriaje obje = new SS_HC_EpisodioTriaje();
            obje.UnidadReplicacion = ENTITY_GLOBAL.Instance.UnidadReplicacion;
            obje.IdPersonalSalud = p.Id;
           // obje.ObservacionFirma = p.Name;
            //obje.UsuarioCreacion = p.X;
            obje.Accion = "D_LOCALIZATION";
            //obje.UsuarioModificacion = p.Y;
            obje.Estado = (int)ENTITY_GLOBAL.Instance.EpisodioAtencion;
            obje.IdPaciente = (int)ENTITY_GLOBAL.Instance.PacienteID;
            obje.IdPrioridad = (int)ENTITY_GLOBAL.Instance.EpisodioClinico;

            var idResultado = SvcEpisodioTriaje.setMantenimientoEpisodioTriaje(obje);

            if (idResultado >= 1)
            {
                var itemToRemove = ENTITY_GLOBAL.listaCuerpos.FirstOrDefault(r => r.Id == p.Id);
                ENTITY_GLOBAL.listaCuerpos.Remove(itemToRemove);

            }

          
            return Json(1, JsonRequestBehavior.AllowGet);
        }


        public JsonResult getAllItemsById(CuerpoHumano IdData)
        {
            Log.Information("DispositivosController - getAllItemsById - Entrar");
            var lista = ENTITY_GLOBAL.listaCuerpos.Where(x => x.Id == IdData.Id).ToList();

            return Json(lista, JsonRequestBehavior.AllowGet);
        }

        public JsonResult getAllItems(CuerpoHumano IdData)
        {

            Log.Information("DispositivosController - getAllItems - Entrar");



            if (ENTITY_GLOBAL.listaCuerpos.Count >= 1)
            {
                var IdCounter = ENTITY_GLOBAL.listaCuerpos.Max(r => r.Id);

                ENTITY_GLOBAL.listaCuerpos.Where(S => S.Id == S.Id).Select(S =>
                {
                    S.IdCounter = IdCounter;
                    return S;
                }).ToList();
            }



            return Json(ENTITY_GLOBAL.listaCuerpos, JsonRequestBehavior.AllowGet);
        }

    }
}
