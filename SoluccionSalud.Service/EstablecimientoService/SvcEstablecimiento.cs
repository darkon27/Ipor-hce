using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLEstablecimiento;

using SoluccionSalud.Entidades.Entidades;
namespace SoluccionSalud.Service.EstablecimientoService
{
    public class SvcEstablecimiento
    {
        public static List<CM_CO_Establecimiento> listarEstablecimiento(CM_CO_Establecimiento objSC, int inicio, int final)
        {
            return new BLLEstablecimiento().listarEstablecimiento(objSC, inicio, final);
        }

        public static int setMantenimiento(CM_CO_Establecimiento ObjTrace)
        {
            return new BLLEstablecimiento().setMantenimiento(ObjTrace);
        }
    }
}
