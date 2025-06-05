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
    public class SvcProximaAtencionFE
    {
        public static int ProximaAtencion(SS_HC_ProximaAtencion_FE objSC)
        {
            return new ProximaAtencionFERepository().setMantenimiento(objSC);
        }

        public static List<SS_HC_ProximaAtencion_FE> ProximaAtencionListar(SS_HC_ProximaAtencion_FE objSC)
        {
            return new ProximaAtencionFERepository().ProximaAtencionListar(objSC);
        }

        public static int setMantenimiento(SS_HC_ProximaAtencion_FE objSC, List<SS_HC_ProximaAtencion_FE> listaDetalle, List<SS_HC_ProximaAtencionDiagnostico> listaDetalleDiagnost)
        {
            return new ProximaAtencionFERepository().setMantenimiento(objSC, listaDetalle, listaDetalleDiagnost);
        }
    }
}
