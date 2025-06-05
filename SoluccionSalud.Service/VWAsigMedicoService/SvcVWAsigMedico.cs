using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLVWAsigMedico;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.VWAsigMedicoService
{
    public class SvcVWAsigMedico
    {
        public static List<VW_SS_HC_ASIGNACIONMEDICO> listarVWAsigMedico(VW_SS_HC_ASIGNACIONMEDICO objSC, int inicio, int final)
        {
            return new VWAsigMedicoBLL().listarVWAsigMedico(objSC, inicio, final);
        }
        public static int setMantenimiento(VW_SS_HC_ASIGNACIONMEDICO ObjTrace)
        {
            return new VWAsigMedicoBLL().setMantenimiento(ObjTrace);
        }
    }
}
