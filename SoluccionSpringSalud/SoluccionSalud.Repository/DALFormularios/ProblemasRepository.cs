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
    public class ProblemasRepository : GenericDataRepository<SS_HC_Problema>
    {
        public int setMantenimiento(SS_HC_Problema ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_Problema(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.TipoProblema, ObjTrace.IdTipoProblemaDiag, ObjTrace.Secuencia, ObjTrace.Fecha, ObjTrace.IdDiagnostico,
                    ObjTrace.Observacion, ObjTrace.IdControlado, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                    ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion,
                    ObjTrace.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        public List<SS_HC_Problema> ProblemasListar(SS_HC_Problema ObjTrace)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_ProblemaListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,
                    ObjTrace.EpisodioClinico, ObjTrace.TipoProblema, ObjTrace.IdTipoProblemaDiag, ObjTrace.Secuencia, ObjTrace.Fecha, ObjTrace.IdDiagnostico,
                    ObjTrace.Observacion, ObjTrace.IdControlado, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                    ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion,
                    ObjTrace.Version).ToList();
            }
        }
    }
}
