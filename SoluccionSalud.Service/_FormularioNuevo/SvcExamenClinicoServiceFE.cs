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
    public class SvcExamenClinicoServiceFE
    {
        public static List<SS_HC_ExamenClinico_FE> ExamenClinicoListar(SS_HC_ExamenClinico_FE objSC)
        {
            return new ExamenClinicoFERepository().ExamenClinicoListar(objSC);
        }

        public static Int32 setMantenimiento(SS_HC_ExamenClinico_FE objSave)
        {
            return new ExamenClinicoFERepository().setMantenimiento(objSave);
        }

        
        public static Int32 setMantenimientoCopia(SS_HC_ExamenClinico_FE objSave)
        {
            return new ExamenClinicoFERepository().setMantenimientoCopia(objSave);
        }
    }
}
