using SoluccionSalud.Bussines.BLLAC_Sucursal;
using SoluccionSalud.Entidades.Entidades;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.AC_SucursalService
{
    public class SvcAC_Sucursal
    {
        public static List<AC_Sucursal> listarAC_Sucursal(AC_Sucursal objSC, int inicio, int final)
        {
            return new AC_SucursalBLL().listarAC_Sucursal(objSC, inicio, final);
        }

        public static int setMantenimiento(AC_Sucursal ObjTrace)
        {
            return new AC_SucursalBLL().setMantenimiento(ObjTrace);
        }

        public static int setMantenimiento(List<AC_Sucursal> listaObjSC)
        {
            return new AC_SucursalBLL().setMantenimiento(listaObjSC);
        }
    }
}
