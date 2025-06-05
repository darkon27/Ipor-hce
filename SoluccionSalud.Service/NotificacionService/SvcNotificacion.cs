using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNotificacion;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NotificacionService
{
    public class SvcNotificacion
    {
        public static List<SS_HC_BANDEJA_NOTIFI_HEADER> listarNotificacion(SS_HC_BANDEJA_NOTIFI_HEADER objSC, int inicio, int final)
        {
            return new NotificacionBLL().listarNotificacion(objSC, inicio, final);
        }
     
    }
}
