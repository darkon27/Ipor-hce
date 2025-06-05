using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALClasificadorMovimiento;

namespace SoluccionSalud.Bussines.BLLClasificadorMovimiento
{
    public class ClasificadorMovimientoBLL
    {
        public List<GE_ClasificadorMovimiento> listarClasificadorMovimiento(GE_ClasificadorMovimiento objSC, int inicio, int final)
        {
            return new ClasificadorMovimientoBaseRepository().listarClasificadorMovimiento(objSC, inicio, final);
        }

        public int setMantenimiento(GE_ClasificadorMovimiento ObjTrace)
        {
            return new ClasificadorMovimientoBaseRepository().setMantenimiento(ObjTrace);
        }
    }
}
