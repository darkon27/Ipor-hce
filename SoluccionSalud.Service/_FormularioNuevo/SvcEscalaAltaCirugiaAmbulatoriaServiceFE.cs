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
    public class SvcEscalaAltaCirugiaAmbulatoriaServiceFE
    {

        public static int setMantenimiento(SS_HC_EscalaAltaCirugiaAmbulatoria_FE objSC)
        {
            return new EscalaAltaCirugiaAmbulatoriaFERepository().setMantenimiento(objSC);
        }
        public static List<SS_HC_EscalaAltaCirugiaAmbulatoria_FE> listarEntidad(SS_HC_EscalaAltaCirugiaAmbulatoria_FE objSC)
        {

            return new EscalaAltaCirugiaAmbulatoriaFERepository().listarEntidad(objSC);
        }

    }
}
