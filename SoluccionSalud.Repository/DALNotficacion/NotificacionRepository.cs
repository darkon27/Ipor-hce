using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.RepositoryReport;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Repository.DALNotficacion
{
    public class NotificacionRepository : AuditGenerico<SS_HC_BANDEJA_NOTIFI_HEADER, SS_HC_BANDEJA_NOTIFI_HEADER> 
    {
        public List<SS_HC_BANDEJA_NOTIFI_HEADER> listarNotificacion(SS_HC_BANDEJA_NOTIFI_HEADER objSC, int inicio, int final)
        {
            
            List<SS_HC_BANDEJA_NOTIFI_HEADER> objLista = new List<SS_HC_BANDEJA_NOTIFI_HEADER>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_BANDEJA_NOTIFI_HEADER_LISTAR(
                    objSC.IdNotificacion,
                    objSC.UnidadReplicacion,
                    objSC.IdPaciente,
                    objSC.CodigoOA,
                    objSC.EpisodioClinico,
                    objSC.IdEpisodioAtencion,
                    objSC.Linea,
                    objSC.IdOrdenAtencion,
                    objSC.IdPersonalSalud,
                    objSC.TipoNotificacion,
                    objSC.Descripcion,
                    objSC.Estado,
                    objSC.Usuario,
                    objSC.UltimaFechaModif,
                    objSC.IdOpcion,                   
                    objSC.Accion,
                    objSC.Version,
                    inicio,
                    final
                ).ToList();

                
            
            }
            return objLista;
        }
    }

  
}
