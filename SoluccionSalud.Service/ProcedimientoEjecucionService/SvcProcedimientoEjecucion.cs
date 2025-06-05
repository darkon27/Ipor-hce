using SoluccionSalud.Bussines.BLLProcedimientoEjecucion;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.ProcedimientoEjecucionService
{
    public class SvcProcedimientoEjecucion
    {
        public static List<SS_HC_ProcedimientoEjecucion> listarSS_HC_ProcedimientoEjecucion(SS_HC_ProcedimientoEjecucion objSC, int inicio, int final)
        {
            return new ProcedimientoEjecucionBLL().listarSS_HC_ProcedimientoEjecucion(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_HC_ProcedimientoEjecucion ObjTrace)
        {
            return new ProcedimientoEjecucionBLL().setMantenimiento(ObjTrace);
        }

        public static long setMantenimientoDetalle(SS_HC_EpisodioAtencion objSC, List<SS_HC_ProcedimientoEjecucion> listaExamenes)
        {
            return new ProcedimientoEjecucionBLL().setMantenimientoDetalle(objSC, listaExamenes);
        }
    }
}
