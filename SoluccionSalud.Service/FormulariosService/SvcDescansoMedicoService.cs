using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcDescansoMedicoService
    {
        public static int DescansoMedico(SS_HC_DescansoMedico objSC)
        {
            return new DescansoMedicoBLL().DescansoMedico(objSC);
        }

        public static List<SS_HC_DescansoMedico> DescansoMedicoListar(SS_HC_DescansoMedico objSC)
        {
            return new DescansoMedicoBLL().DescansoMedicoListar(objSC);
        }
    }
}
