using SoluccionSalud.Bussines.BLLProcedimiento;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.ProcedimientoService
{
    public class SvcProcedimiento
    {
        public static List<SS_HC_Procedimiento> listarProcedimiento(SS_HC_Procedimiento objSC, int inicio, int final)
        {
            return new ProcedimientoBLL().listarProcedimiento(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_HC_Procedimiento ObjTrace)
        {
            return new ProcedimientoBLL().setMantenimiento(ObjTrace);
        }
    }
}
