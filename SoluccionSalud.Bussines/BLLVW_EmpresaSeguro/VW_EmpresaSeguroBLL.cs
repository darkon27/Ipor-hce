using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVWEmpresaSeguro;

namespace SoluccionSalud.Bussines.BLLVW_EmpresaSeguro
{
    public class VW_EmpresaSeguroBLL
    {
        public List<VW_SS_GE_EMPRESASEGURO> listarEmpresaSeguro(VW_SS_GE_EMPRESASEGURO objSC, int inicio, int final)
        {
            return new VW_EmpresaSeguroBaseRepository().listarEmpresaSeguro(objSC, inicio, final);
        }

        public int setMantenimiento(VW_SS_GE_EMPRESASEGURO ObjTrace)
        {
            return new VW_EmpresaSeguroBaseRepository().setMantenimiento(ObjTrace);
        }
    }
}
