using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALProcedimiento;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLProcedimiento
{
    public class ProcedimientoBLL
    {
        public List<SS_HC_Procedimiento> listarProcedimiento(SS_HC_Procedimiento objSC, int inicio, int final)
        {
            return new ProcedimientoRepository().listarProcedimiento(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_Procedimiento ObjTrace)
        {
            return new ProcedimientoRepository().setMantenimiento(ObjTrace);
        }
    }
}
