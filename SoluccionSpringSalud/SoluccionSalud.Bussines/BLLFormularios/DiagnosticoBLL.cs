using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{

    public class DiagnosticoBLL
    {
        public int setMantenimiento(SS_HC_Diagnostico objSC)
        {
            return new  DiagnosticoRepository().setMantenimiento(objSC);
        }
    }
}
