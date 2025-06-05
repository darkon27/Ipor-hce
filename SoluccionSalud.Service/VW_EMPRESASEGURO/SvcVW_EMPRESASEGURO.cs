using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLVW_EmpresaSeguro;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.VW_EMPRESASEGURO
{
    public class SvcVW_EMPRESASEGURO
    {
        public static List<VW_SS_GE_EMPRESASEGURO> listarEmpresaSeguro(VW_SS_GE_EMPRESASEGURO objSC, int inicio, int final)
        {
            return new VW_EmpresaSeguroBLL().listarEmpresaSeguro(objSC, inicio, final);
        }

        public static int setMantenimiento(VW_SS_GE_EMPRESASEGURO ObjTrace)
        {
            return new VW_EmpresaSeguroBLL().setMantenimiento(ObjTrace);
        }
    }
}
