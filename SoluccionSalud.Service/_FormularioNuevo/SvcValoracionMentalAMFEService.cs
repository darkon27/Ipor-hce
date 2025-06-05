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
    public class SvcValoracionMentalAMFEService
    {

        public static int setMantenimiento(SS_HC_ValoracionMentalAM_FE ObjTraces)
        {
            return new ValoracionMentalAMFERepository().setMantenimiento(ObjTraces);
        }

        public static List<SS_HC_ValoracionMentalAM_FE> listarEntidad(SS_HC_ValoracionMentalAM_FE objSC)
        {
            return new ValoracionMentalAMFERepository().listarEntidad(objSC);
        }

    }
}
