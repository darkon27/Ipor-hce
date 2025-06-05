using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcProximaAtencionService
    {

        public static int ProximaAtencion(SS_HC_ProximaAtencion objSC)
        {
            return new ProximaAtencionBLL().ProximaAtencion(objSC);
        }

        public static List<SS_HC_ProximaAtencion> ProximaAtencionListar(SS_HC_ProximaAtencion objSC)
        {
            return new ProximaAtencionBLL().ProximaAtencionListar(objSC);
        }

        public static int setMantenimiento(SS_HC_ProximaAtencion objSC, List<SS_HC_ProximaAtencion> listaDetalle, List<SS_HC_ProximaAtencionDiagnostico> listaDetalleDiagnost)
        {
            return new ProximaAtencionBLL().setMantenimiento(objSC, listaDetalle, listaDetalleDiagnost);
        }

    }
}
