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
    public class SvcValoracionAMFEService
    {
        public static int setMantenimiento(SS_HC_ValoracionAM_FE ObjTraces)
        {
            return new ValoracionAMFERepository().setMantenimiento(ObjTraces);
        }

        public static List<SS_HC_ValoracionAM_FE> listarEntidad(SS_HC_ValoracionAM_FE objSC)
        {
            return new ValoracionAMFERepository().listarEntidad(objSC);
        }
    }
}
