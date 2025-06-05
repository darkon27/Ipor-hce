using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNotificacionDetalle;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NotificacionDetalleService
{
    public class SvcNotificacionDetalle
    {
        public static List<SS_HC_BANDEJA_NOTIFI_DETALLE> listarNotificacionDetalle(SS_HC_BANDEJA_NOTIFI_DETALLE objSC, int inicio, int final)
        {
            return new NotificacionDetalleBLL().listarNotificacionDetalle(objSC, inicio, final);
        }
    }
}
