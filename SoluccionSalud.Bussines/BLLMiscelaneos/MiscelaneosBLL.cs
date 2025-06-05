using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALMiscelaneos;

namespace SoluccionSalud.Bussines.BLLMiscelaneos
{
     
    public class MiscelaneosBLL
    {
        public List<MA_MiscelaneosDetalle> listarMiscelaneoNuevo(MA_MiscelaneosDetalle objSC)
        {
            return new MiscelaneosRepository().CombosMiscelaneos(objSC);
        }
        public List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle objSC)
        {
            return new MiscelaneosRepository().GetUpListadoServicios(objSC);
        }
        public int setMantenimiento(MA_MiscelaneosDetalle ObjTrace)
        {
            return new MiscelaneosRepository().setMantenimiento(ObjTrace);
        }

        public int setMantenimiento(List<MA_MiscelaneosDetalle> listaObjTrace)
        {
            return new MiscelaneosRepository().setMantenimiento(listaObjTrace);
        }
        public List<MA_MiscelaneosDetalle> listarMA_MiscelaneosDetalle(MA_MiscelaneosDetalle objSC, int inicio, int final)
        {
            return new MiscelaneosRepository().listarMA_MiscelaneosDetalle(objSC,inicio,final);
        }
        public List<MA_MiscelaneosDetalle> CombosMiscelaneos(MA_MiscelaneosDetalle objSC)
        {
            return new MiscelaneosRepository().CombosMiscelaneos(objSC);
        }
         public List<MA_MiscelaneosDetalle> getRuleGetCollectionStore(HC_RuleGetCollectionStore objSC)
        {
            return new MiscelaneosRepository().getRuleGetCollectionStore(objSC);
        }


         public List<SS_FA_NotificacionDetalle> listarNotificaciones()
         {
             return new MiscelaneosRepository().listarNotificaciones();
         }
    }

}
