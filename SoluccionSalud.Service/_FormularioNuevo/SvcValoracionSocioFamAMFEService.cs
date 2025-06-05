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
    public class SvcValoracionSocioFamAMFEService
    {

        public static int setMantenimiento(SS_HC_ValoracionSocioFamAM_FE ObjTraces)
        {
            return new ValoracionSocioFamAMFERepository().setMantenimiento(ObjTraces);
        }

        public static List<SS_HC_ValoracionSocioFamAM_FE> listarEntidad(SS_HC_ValoracionSocioFamAM_FE objSC)
        {
            return new ValoracionSocioFamAMFERepository().listarEntidad(objSC);
        }
    }
}
