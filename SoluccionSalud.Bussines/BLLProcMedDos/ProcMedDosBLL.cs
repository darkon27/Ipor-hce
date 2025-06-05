using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALProcMedicoDos;

namespace SoluccionSalud.Bussines.BLLProcMedDos
{
    public class ProcMedDosBLL
    {
        public List<SS_GE_ProcedimientoMedicoDos> listarProcMedicoDos(SS_GE_ProcedimientoMedicoDos objSC, int inicio, int final)
        {
            return new ProcMedDosRepository().listarProcMedicoDos(objSC, inicio, final);
        }

        public int setMantenimiento(SS_GE_ProcedimientoMedicoDos ObjTrace)
        {
            return new ProcMedDosRepository().setMantenimiento(ObjTrace);
        }
    }
}
