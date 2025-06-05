using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcDiagnosticoService
    {
        public int setMantenimiento(SS_HC_Diagnostico objSC)
        {
            return new DiagnosticoBLL().setMantenimiento(objSC);
        }
    }


}
