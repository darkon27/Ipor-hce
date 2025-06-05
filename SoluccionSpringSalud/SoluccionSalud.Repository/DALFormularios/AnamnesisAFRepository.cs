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
    public class AnamnesisAFRepository : GenericDataRepository<SS_HC_Anamnesis_AF> 
    {
        public long setMantAnamnesisAF(SS_HC_Anamnesis_AF ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            long  valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_AnamnesisAF(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, 
                    ObjTrace.Secuencia, ObjTrace.IdTipoParentesco, ObjTrace.Edad, ObjTrace.IdVivo, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, 
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt64(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        public List<SS_HC_Anamnesis_AF> AnamnesisAFListar(SS_HC_Anamnesis_AF ObjTrace)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_AnamnesisAFListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                    ObjTrace.Secuencia, ObjTrace.IdTipoParentesco, ObjTrace.Edad, ObjTrace.IdVivo, ObjTrace.Estado, ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();
            }
        }
    }
}
