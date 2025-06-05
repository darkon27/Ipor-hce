using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Bussines;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEvaluacionGradoDependenciaFEService
    {
        public static int setMantenimiento(SS_HC_Evaluacion_GradoDependencia_FE objSC)
        {
            return new EvaluacionGradoDependenciaFERepository().setMantenimiento(objSC);
        }

        public static List<SS_HC_Evaluacion_GradoDependencia_FE> listarEntidad(SS_HC_Evaluacion_GradoDependencia_FE objSC)
        {
            return new EvaluacionGradoDependenciaFERepository().listarEntidad(objSC);
        }

    }
}
