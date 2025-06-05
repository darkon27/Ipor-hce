using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLProcMed;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ProcMedService
{
    public class SvcProcMed
    {
        public static List<SS_GE_ProcedimientoMedico> listarProcMedico(SS_GE_ProcedimientoMedico objSC, int inicio, int final)
        {
            return new ProcMedBLL().listarProcMedico(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_GE_ProcedimientoMedico ObjTrace)
        {
            return new ProcMedBLL().setMantenimiento(ObjTrace);
        }
    }
}
