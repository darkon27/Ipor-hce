using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLTipoAtencion;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.AtencionService
{
   public class SvcTipoAtencion
    {        public static List<SS_GE_TipoAtencion> listarTipoAtencion(SS_GE_TipoAtencion objSC, int inicio, int final)
        {
            return new TipoAtencionBLL().listarTipoAtencion(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_GE_TipoAtencion ObjTrace)
        {
            return new TipoAtencionBLL().setMantenimiento(ObjTrace);
        }
        
    }
}
