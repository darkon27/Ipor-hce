using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEvaluacionDolorEvaNiniosFEService
    {

        public static int setMantenimiento(SS_HC_Evaluacion_DolorEvaNinios_FE objSC)
        {
            return new EvaluacionDolorEvaNiniosFERepository().setMantenimiento(objSC);
        }

        public static List<SS_HC_Evaluacion_DolorEvaNinios_FE> listarEntidad(SS_HC_Evaluacion_DolorEvaNinios_FE objSC)
        {
            return new EvaluacionDolorEvaNiniosFERepository().listarEntidad(objSC);
        }
    }
}
