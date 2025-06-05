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
    public class SvcEvolucionObjetivaFEService
    {
        public static int setMantenimiento(SS_HC_EvolucionMedica_FE ObjTraces)
        {
            return new EvolucionObjetivaFERepository().setMantenimiento(ObjTraces);
        }

        public static List<SS_HC_EvolucionMedica_FE> listarSS_HC_EvolucionObjetiva(SS_HC_EvolucionMedica_FE objSC)
        {
            return new EvolucionObjetivaFERepository().listarSS_HC_EvolucionObjetiva(objSC);
        }

    }
}
