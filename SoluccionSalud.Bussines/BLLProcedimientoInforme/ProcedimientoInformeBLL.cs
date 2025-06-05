using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALProcedimientoInforme;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLProcedimientoInforme
{
    public class ProcedimientoInformeBLL
    {
        public List<SS_HC_ProcedimientoInforme> listarSS_HC_ProcedimientoInforme(SS_HC_ProcedimientoInforme objSC, int inicio, int final)
        {
            return new ProcedimientoInformeRepository().listarSS_HC_ProcedimientoInforme(objSC, inicio, final);
        }

        public int setMantenimientoDetalle(SS_HC_ProcedimientoEjecucion objSC, List<SS_HC_ProcedimientoInforme> listaInforme)
        {
            return new ProcedimientoInformeRepository().setMantenimientoDetalle(objSC, listaInforme);
        }
    }
}
