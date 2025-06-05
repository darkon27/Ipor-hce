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
    public class SvcSolucitudTransfusionalFEService
    // SvcAntecedentesPersonalesINFEService

    {


        public static List<SS_HC_SolucitudTransfusional_FE> listarEntidad(SS_HC_SolucitudTransfusional_FE objSC)
        {
            return new SolucitudTransfusionalFERepository().listarEntidad(objSC);
        }


        public static int setMantenimiento(SS_HC_SolucitudTransfusional_FE objSave, List<SS_HC_SolucitudTransfusionalDiagnostico_FE> ObjDetalle)
        {
            return new SolucitudTransfusionalFERepository().setMantenimiento(objSave, ObjDetalle);
        }

        
    }
}
