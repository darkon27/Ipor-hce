using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEvaluacionDolorEvaNeonatosPrematuros_FEService
    {

        public static int setMantenimiento(SS_HC_Evaluacion_DolorEvaNeonatosPrematuros_FE objSC)
        {
            return new EvaluacionDolorEvaNeonatosPrematurosFERepository().setMantenimiento(objSC);
        }

        public static List<SS_HC_Evaluacion_DolorEvaNeonatosPrematuros_FE> listarEntidad(SS_HC_Evaluacion_DolorEvaNeonatosPrematuros_FE objSC)
        {
            return new EvaluacionDolorEvaNeonatosPrematurosFERepository().listarEntidad(objSC);
        }

    }
}
