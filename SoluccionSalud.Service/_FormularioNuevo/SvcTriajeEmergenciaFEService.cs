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
    public class SvcTriajeEmergenciaFEService
    {

        public static int setMantenimiento(SS_HC_TriajeEmergencia_FE objSC)
        {
            return new TriajeEmergenciaFERepository().setMantenimiento(objSC);
        }

        public static List<SS_HC_TriajeEmergencia_FE> listarEntidad(SS_HC_TriajeEmergencia_FE objSC)
        {

            return new TriajeEmergenciaFERepository().listarEntidad(objSC);
        }
        public static List<SS_HC_TriajeEmergencia_FE> listarEntidadTriajeEmergencia(SS_HC_TriajeEmergencia_FE objSC)
        {

            return new TriajeEmergenciaFERepository().listarEntidadTriajeEmergencia(objSC);
        }

    }
}
