using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEvolucionObstetricaPuerperio_FE
    {

        public static int setMantenimiento(SS_HC_EvolucionObstetricaPuerperio_FE objSC)
        {
            return new EvolucionObstetricaPuerperioFERepository().setMantenimiento(objSC);
        }

        public static List<SS_HC_EvolucionObstetricaPuerperio_FE> listarEntidad(SS_HC_EvolucionObstetricaPuerperio_FE objSC)
        {

            return new EvolucionObstetricaPuerperioFERepository().listarEntidad(objSC);
        }

    }
}
