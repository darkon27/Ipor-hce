using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALAC_Sucursal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLAC_Sucursal
{
    public class AC_SucursalBLL
    {
        public List<AC_Sucursal> listarAC_Sucursal(AC_Sucursal objSC, int inicio, int final)
        {
            return new AC_SucursalRepository().listarAC_Sucursal(objSC, inicio, final);
        }
        
        public int setMantenimiento(AC_Sucursal ObjTrace)
        {
            return new AC_SucursalRepository().setMantenimiento(ObjTrace);
        }

        public int setMantenimiento(List<AC_Sucursal> listaObjSC)
        {
            return new AC_SucursalRepository().setMantenimiento(listaObjSC);
        }
    }
}
