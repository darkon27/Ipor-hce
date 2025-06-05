using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.RepositoryReport;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Repository.DALNotificacionDetalle
{
    public class NotificacionDetalleRepository : AuditGenerico<SS_HC_BANDEJA_NOTIFI_DETALLE, SS_HC_BANDEJA_NOTIFI_DETALLE> 
    {
        public List<SS_HC_BANDEJA_NOTIFI_DETALLE> listarNotificacionDetalle(SS_HC_BANDEJA_NOTIFI_DETALLE objSC, int inicio, int final)
        {

            List<SS_HC_BANDEJA_NOTIFI_DETALLE> objLista = new List<SS_HC_BANDEJA_NOTIFI_DETALLE>();

            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_BANDEJA_NOTIFI_DETALLE_LISTAR(
                    objSC.IdNotificacion,
                    objSC.IdSecuencia,
                    objSC.UnidadReplicacion,
                    objSC.IdPaciente,
                    objSC.EpisodioClinico,
                    objSC.IdEpisodioAtencion,
                    objSC.IdComponente,
                    objSC.CodigoComponente,
                    objSC.Id01,
                    objSC.Id02,
                    objSC.codigo01,
                    objSC.codigo02,
                    objSC.codigo03,
                    objSC.Descripcion01,
                    objSC.Descripcion02,
                    objSC.Descripcion03,
                    objSC.Observacion,
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
