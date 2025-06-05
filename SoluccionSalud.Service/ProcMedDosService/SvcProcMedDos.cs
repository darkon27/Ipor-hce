using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLProcMedDos;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ProcMedDosService
{
    public class SvcProcMedDos
    {
        public static List<SS_GE_ProcedimientoMedicoDos> listarProcMedicoDos(SS_GE_ProcedimientoMedicoDos objSC, int inicio, int final)
        {
            return new ProcMedDosBLL().listarProcMedicoDos(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_GE_ProcedimientoMedicoDos ObjTrace)
        {
            return new ProcMedDosBLL().setMantenimiento(ObjTrace);
        }
    }
}
