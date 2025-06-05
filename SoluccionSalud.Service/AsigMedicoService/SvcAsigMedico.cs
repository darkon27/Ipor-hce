using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLAsigMedico;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.AsigMedicoService
{
    public class SvcAsigMedico
    {
        public static List<SS_HC_AsignacionMedico> listarAsigMedico(SS_HC_AsignacionMedico objSC, int inicio, int final)
        {
            return new AsigMedicoBLL().listarAsigMedico(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_AsignacionMedico ObjTrace)
        {
            return new AsigMedicoBLL().setMantenimiento(ObjTrace);
        }
    }
}
