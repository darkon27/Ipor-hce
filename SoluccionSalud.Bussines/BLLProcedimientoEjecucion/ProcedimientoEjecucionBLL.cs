using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALProcedimientoEjecucion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLProcedimientoEjecucion
{
    public  class ProcedimientoEjecucionBLL
    {
        public List<SS_HC_ProcedimientoEjecucion> listarSS_HC_ProcedimientoEjecucion(SS_HC_ProcedimientoEjecucion objSC, int inicio, int final)
        {
            return new ProcedimientoEjecucionRepository().listarSS_HC_ProcedimientoEjecucion(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_ProcedimientoEjecucion ObjTrace)
        {
            return new ProcedimientoEjecucionRepository().setMantenimiento(ObjTrace);
        }

        public  long setMantenimientoDetalle(SS_HC_EpisodioAtencion objSC, List<SS_HC_ProcedimientoEjecucion> listaExamenes)
        {
            return new ProcedimientoEjecucionRepository().setMantenimientoDetalle(objSC, listaExamenes);
        }
    }
}
