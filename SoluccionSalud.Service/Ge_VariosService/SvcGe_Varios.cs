using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLGe_Varios;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.Ge_VariosService
{
    public class SvcGe_Varios
    {
        public static List<GE_Varios> listarGe_Varios(GE_Varios objSC)
        {
            return new Ge_VariosBLL().listarGe_Varios(objSC);
        }
        public static List<GE_Varios> listarGe_VariosAccion(GE_Varios objSC, String accion)
        {
            if (objSC == null)
            {
                objSC = new GE_Varios();
            }
            objSC.Accion = accion;
            return new Ge_VariosBLL().listarGe_Varios(objSC);
        }
    }
}
