using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Repository.DALFormularios
{
    public class ExamenSolicitadoRepository : GenericDataRepository<SS_HC_ExamenSolicitado>
    {
        public int setMantenimiento(SS_HC_ExamenSolicitado ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_ExamenSolicitado(ObjTrace.UnidadReplicacion,	ObjTrace.IdPaciente,	ObjTrace.EpisodioClinico,	
                    ObjTrace.IdEpisodioAtencion,	ObjTrace.Secuencia,	ObjTrace.Fecha ,ObjTrace.IdProcedimiento,	
                    ObjTrace.Observacion,	ObjTrace.UsuarioCreacion,	ObjTrace.FechaCreacion,	ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdTipoExamen).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }

        public List<SS_HC_ExamenSolicitado> MedicamentoListar(SS_HC_ExamenSolicitado ObjTrace)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_ExamenSolicitadoListar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                    ObjTrace.IdEpisodioAtencion, ObjTrace.Secuencia, ObjTrace.Fecha, ObjTrace.IdProcedimiento,
                    ObjTrace.Observacion, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.IdTipoExamen).ToList();
            }
        }
    }
}

