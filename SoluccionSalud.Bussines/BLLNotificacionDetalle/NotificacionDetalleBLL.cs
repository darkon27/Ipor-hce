using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNotificacionDetalle;

namespace SoluccionSalud.Bussines.BLLNotificacionDetalle
{
    public class NotificacionDetalleBLL
    {
        public List<SS_HC_BANDEJA_NOTIFI_DETALLE> listarNotificacionDetalle(SS_HC_BANDEJA_NOTIFI_DETALLE objSC, int inicio, int final)
        {
            return new NotificacionDetalleRepository().listarNotificacionDetalle(objSC, inicio, final);
        }
    }
}
