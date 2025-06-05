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
    public class DiagnosticoRepository : GenericDataRepository<SS_HC_Diagnostico>
    {
        public int setMantenimiento(SS_HC_Diagnostico ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_DIAGNOSTICO(ObjTrace.UnidadReplicacion,	ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente,	ObjTrace.EpisodioClinico,	
                    ObjTrace.Secuencia,ObjTrace.IdDiagnostico,	ObjTrace.IdDeterminacionDiagnostica,	ObjTrace.IdGradoAfeccion,	
                    ObjTrace.Estado,	ObjTrace.UsuarioCreacion,	ObjTrace.FechaCreacion,	ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
 

    }

}
