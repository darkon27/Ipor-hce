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
    public class SvcSolicitudTransfusionalFE2Service
    // SvcAntecedentesPersonalesINFEService

    {


        public static List<SS_HC_SolicitudTransfusional_2_FE> listarEntidad(SS_HC_SolicitudTransfusional_2_FE objSC)
        {
            return new SolicitudTransfusionalFE2Repository().listarEntidad(objSC);
        }


        public static int setMantenimiento(SS_HC_SolicitudTransfusional_2_FE objSC)
        {
            return new SolicitudTransfusionalFE2Repository().setMantenimiento(objSC);
        }



      
        
    }
}
