using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLClasificadorMovimiento;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ClasificadorMovimientoService
{
    public class SvcClasificadorMovimiento
    {
        public static List<GE_ClasificadorMovimiento> listarClasificadorMovimiento(GE_ClasificadorMovimiento objSC, int inicio, int final)
        {
            return new ClasificadorMovimientoBLL().listarClasificadorMovimiento(objSC, inicio, final);
        }

        public static int setMantenimiento(GE_ClasificadorMovimiento ObjTrace)
        {
            return new ClasificadorMovimientoBLL().setMantenimiento(ObjTrace);
        }
    }
}
