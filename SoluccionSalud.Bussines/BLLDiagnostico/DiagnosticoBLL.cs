using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALDiagnostico;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLDiagnostico
{
    public class DiagnosticoBLL
    {
        public List<SS_GE_Diagnostico> listarDiagnostico(SS_GE_Diagnostico objSC, int inicio, int final)
        {
            return new DiagnosticoRepository().listarDiagnostico(objSC,inicio,final);
        }

        public int setMantenimiento(SS_GE_Diagnostico ObjTrace)
        {
            return new DiagnosticoRepository().setMantenimiento(ObjTrace);
        }
    }
}
