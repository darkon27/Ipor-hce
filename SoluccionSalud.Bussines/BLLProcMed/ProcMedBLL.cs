using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALProcMedico;

namespace SoluccionSalud.Bussines.BLLProcMed
{
    public class ProcMedBLL
    {
        public List<SS_GE_ProcedimientoMedico> listarProcMedico(SS_GE_ProcedimientoMedico objSC, int inicio, int final)
        {
            return new ProcMedRepository().listarProcMedico(objSC, inicio, final);
        }
        public int setMantenimiento(SS_GE_ProcedimientoMedico ObjTrace)
        {
            return new ProcMedRepository().setMantenimiento(ObjTrace);
        }
    }
}
