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
    public class SvcValoracionFuncionalAMFE
    {
        public static int setMantenimiento(SS_HC_ValoracionFuncionalAM_FE ObjTraces)
        {
            return new ValoracionFuncionalAMFERepository().setMantenimiento(ObjTraces);
        }

        public static List<SS_HC_ValoracionFuncionalAM_FE> listarEntidad(SS_HC_ValoracionFuncionalAM_FE objSC)
        {
            return new ValoracionFuncionalAMFERepository().listarEntidad(objSC);
        }

    }
}
