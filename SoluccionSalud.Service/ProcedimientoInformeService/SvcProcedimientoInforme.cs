using SoluccionSalud.Bussines.BLLProcedimientoInforme;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.ProcedimientoInformeService
{
    public class SvcProcedimientoInforme
    {
        public static List<SS_HC_ProcedimientoInforme> listarSS_HC_ProcedimientoInforme(SS_HC_ProcedimientoInforme objSC, int inicio, int final)
        {
            return new ProcedimientoInformeBLL().listarSS_HC_ProcedimientoInforme(objSC, inicio, final);
        }
   

        public static int setMantenimientoDetalle(SS_HC_ProcedimientoEjecucion objSC, List<SS_HC_ProcedimientoInforme> listaExamenes)
        {
            return new ProcedimientoInformeBLL().setMantenimientoDetalle(objSC, listaExamenes);
        }
    }
}
