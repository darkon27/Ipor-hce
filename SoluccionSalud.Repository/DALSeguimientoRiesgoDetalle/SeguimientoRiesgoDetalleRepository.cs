using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALSeguimientoRiesgoDetalle
{
    public class SeguimientoRiesgoDetalleRepository
    {
        public List<SS_HC_SeguimientoRiesgoDetalle> listarSeguimientoRiesgoDetalle(SS_HC_SeguimientoRiesgoDetalle objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_SeguimientoRiesgoDetalle_Listar(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                 objSC.IdPaciente, objSC.EpisodioClinico, objSC.Secuencia,
                objSC.IdCuidadoPreventivo, objSC.Comentario, objSC.Accion, objSC.Version).ToList();
            }
        }
        public int setMantenimiento(SS_HC_SeguimientoRiesgoDetalle objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_SeguimientoRiesgoDetalle(objSC.UnidadReplicacion, objSC.IdEpisodioAtencion,
                 objSC.IdPaciente, objSC.EpisodioClinico, objSC.Secuencia,
                objSC.IdCuidadoPreventivo, objSC.Comentario, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
