using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcAntecedentesFisiologicoPediatricoFE
    {

        public static int setMantenimiento(SS_HC_Ant_Fisiologico_Pediatrico_FE objSC)
        {
            return new AntecedentesFisiologicoPediatricoFERepository().setMantenimiento(objSC);
        }
        public static List<SS_HC_Ant_Fisiologico_Pediatrico_FE> listarEntidad(SS_HC_Ant_Fisiologico_Pediatrico_FE objSC)
        {

            return new AntecedentesFisiologicoPediatricoFERepository().listarEntidad(objSC);
        }
        public static List<SS_HC_Ant_Fisiologico_Pediatrico_FE> listarEntidadTOP(SS_HC_Ant_Fisiologico_Pediatrico_FE objSC)
        {

            return new AntecedentesFisiologicoPediatricoFERepository().listarEntidadTOP(objSC);
        }
    }
}
