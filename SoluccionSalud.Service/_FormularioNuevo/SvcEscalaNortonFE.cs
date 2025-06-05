using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEscalaNortonFE
    {
        public static int setMantenimiento(SS_HC_EscalaNorton_FE objSC)
        {
            return new EscalaNortonFERepository().setMantenimiento(objSC);
        }
        public static List<SS_HC_EscalaNorton_FE> listarEntidad(SS_HC_EscalaNorton_FE objSC)
        {

            return new EscalaNortonFERepository().listarEntidad(objSC);
        }
    }
}
