using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLUnidadServicio;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.UnidadServicioService
{
    public class SvcUnidadServicio
    {
        public static List<SS_HC_UnidadServicio> listarUnidadServicio(SS_HC_UnidadServicio objSC, int inicio, int final)
        {
            return new UnidadServicioBLL().listarUnidadServicio(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_UnidadServicio ObjTrace)
        {
            return new UnidadServicioBLL().setMantenimiento(ObjTrace);
        }
    }
}
