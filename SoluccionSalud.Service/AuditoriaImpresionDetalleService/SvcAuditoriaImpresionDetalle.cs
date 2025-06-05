using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLAuditoriaImpresionDetalle;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.AuditoriaImpresionDetalleService
{
    public class SvcAuditoriaImpresionDetalle
    {
        public static List<SS_HC_ImpresionHC_Detalle> listarAudi_ImpDetalle(SS_HC_ImpresionHC_Detalle objSC, int inicio, int final)
        {
            return new AuditoriaImpresionDetalleBLL().listarAudi_ImpDetalle(objSC, inicio, final);
        }

        //public static int setMantenimientoAI(SS_HC_ImpresionHC_Detalle ObjTrace)
        //{
        //    return new AuditoriaImpresionDetalleBLL().setMantenimientoAI(ObjTrace);
        //}
    }
}
