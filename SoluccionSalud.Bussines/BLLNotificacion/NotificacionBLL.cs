using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNotficacion;

namespace SoluccionSalud.Bussines.BLLNotificacion
{
    public class NotificacionBLL
    {
        public List<SS_HC_BANDEJA_NOTIFI_HEADER> listarNotificacion(SS_HC_BANDEJA_NOTIFI_HEADER objSC, int inicio, int final)
        {
            return new NotificacionRepository().listarNotificacion(objSC, inicio, final);
        }

      
    }
}
