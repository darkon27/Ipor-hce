using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALUnidadMedidaMinsa;

namespace SoluccionSalud.Bussines.BLLUnidadMedidaMinsa
{
    public class UnidadMedidaMinsaBLL
    {
        public List<SS_HC_UnidadMedidaMinsa> listarUnidadMedidaMinsa(SS_HC_UnidadMedidaMinsa objSC, int inicio, int final)
        {
            return new UnidadMedidaMinsaRepository().listarUnidadMedidaMinsa(objSC, inicio, final);
        }

        public int setMantenimientoUMM(SS_HC_UnidadMedidaMinsa ObjTrace)
        {
            return new UnidadMedidaMinsaRepository().setMantenimientoUMM(ObjTrace);
        }
    }
}
