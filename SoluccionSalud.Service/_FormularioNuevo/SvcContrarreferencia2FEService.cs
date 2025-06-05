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
    public class SvcContrarreferencia2FEService
    {

        public static int setMantenimiento(SS_HC_CONTRARREFERENCIA_FE ObjTraces, List<SS_HC_CONTRARREFERENCIA_Diagnostico_FE> ObjDetalle)
        {
            return new Contrarreferencia2FERepository().setMantenimiento(ObjTraces, ObjDetalle);
        }

        public static List<SS_HC_CONTRARREFERENCIA_FE> listarEntidad(SS_HC_CONTRARREFERENCIA_FE objSC)
        {
            return new Contrarreferencia2FERepository().listarEntidad(objSC);
        }

    }
}
