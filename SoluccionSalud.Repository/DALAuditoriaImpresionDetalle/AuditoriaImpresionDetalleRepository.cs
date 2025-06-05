using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using SoluccionSalud.RepositoryReport;

namespace SoluccionSalud.Repository.DALAuditoriaImpresionDetalle
{
    public class AuditoriaImpresionDetalleRepository
    {
        public List<SS_HC_ImpresionHC_Detalle> listarAudi_ImpDetalle(SS_HC_ImpresionHC_Detalle objSC, int inicio, int final)
        {
            dynamic DataKey = null;
            SS_HC_ImpresionHC_Detalle objSC2 = new SS_HC_ImpresionHC_Detalle();
            List<SS_HC_ImpresionHC_Detalle> objLista = new List<SS_HC_ImpresionHC_Detalle>();
            using (var context = new WEB_ERPSALUDEntities())
            {
                objLista = context.SP_SS_HC_ImpresionHC_Detalle_LISTAR(
                objSC.IdImpresion, objSC.Secuencial, objSC.IdPaciente,objSC.IdEpisodioAtencion,
                objSC.IdOpcion,objSC.EpisodioClinico,objSC.EpisodioAtencion,
                objSC.CodigoOpcion,objSC.IdFormato,objSC.TipoAtencion,
                objSC.IdUnidadServicio,objSC.IdPersonalSalud,
                objSC.HostImpresion, objSC.UsuarioImpresion, 
                objSC.FechaImpresion,objSC.Accion, inicio, final).ToList();

               

            }

            return objLista;
        }
    }
}
