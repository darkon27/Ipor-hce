using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEvaluacionDolorEvaAdultosFEService
    {
        public static int setMantenimiento(SS_HC_Evaluacion_DolorEvaAdultos_FE objSC)
        {
            return new EvaluacionDolorEvaAdultosFERepository().setMantenimiento(objSC);
        }

        public static List<SS_HC_Evaluacion_DolorEvaAdultos_FE> listarEntidad(SS_HC_Evaluacion_DolorEvaAdultos_FE objSC)
        {
            return new EvaluacionDolorEvaAdultosFERepository().listarEntidad(objSC);
        }
    }
}
