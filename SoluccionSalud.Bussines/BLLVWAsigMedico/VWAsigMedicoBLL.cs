using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVWAsigMedico;

namespace SoluccionSalud.Bussines.BLLVWAsigMedico
{
    public class VWAsigMedicoBLL
    {
        public List<VW_SS_HC_ASIGNACIONMEDICO> listarVWAsigMedico(VW_SS_HC_ASIGNACIONMEDICO objSC, int inicio, int final)
        {
            return new VWAsigMedicoRepository().listarVWAsigMedico(objSC, inicio, final);
        }
        public int setMantenimiento(VW_SS_HC_ASIGNACIONMEDICO ObjTrace)
        {
            return new VWAsigMedicoRepository().setMantenimiento(ObjTrace);
        }
    }
}
