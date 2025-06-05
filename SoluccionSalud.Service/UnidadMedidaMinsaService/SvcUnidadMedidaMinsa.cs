using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLUnidadMedidaMinsa;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.UnidadMedidaMinsaService
{
    public class SvcUnidadMedidaMinsa
    {
        public static List<SS_HC_UnidadMedidaMinsa> listarUnidadMedidaMinsa(SS_HC_UnidadMedidaMinsa objSC, int inicio, int final)
        {
            return new UnidadMedidaMinsaBLL().listarUnidadMedidaMinsa(objSC, inicio, final);
        }

        public static int setMantenimientoUMM(SS_HC_UnidadMedidaMinsa ObjTrace)
        {
            return new UnidadMedidaMinsaBLL().setMantenimientoUMM(ObjTrace);
        }
    }
}
