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

    public class AnamnesisEARepository : GenericDataRepository<SS_HC_Anamnesis_EA>, IAnamnesisEARepository
    {
        public int setMantenimiento(SS_HC_Anamnesis_EA ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
               iReturnValue = context.USP_Anamnesis_EA(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                    ObjTrace.RelatoCronologico, ObjTrace.IdFormaInicio, ObjTrace.IdCursoEnfermedad, ObjTrace.TiempoEnfermedad,
                    ObjTrace.RelatoCronologico, ObjTrace.Apetito, ObjTrace.Sed, ObjTrace.Orina, ObjTrace.Deposiciones, ObjTrace.Sueno,
                    ObjTrace.PesoAnterior, ObjTrace.Infancia, ObjTrace.EvaluacionAlimentacionActual, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                    ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion).SingleOrDefault();
               valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        public List<SS_HC_Anamnesis_EA>  Anamnesis_EA_Listar(SS_HC_Anamnesis_EA ObjTrace)
        {
            
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_Anamnesis_EA_Listar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                     ObjTrace.MotivoConsulta, ObjTrace.IdFormaInicio, ObjTrace.IdCursoEnfermedad, ObjTrace.TiempoEnfermedad,
                     ObjTrace.RelatoCronologico, ObjTrace.Apetito, ObjTrace.Sed, ObjTrace.Orina, ObjTrace.Deposiciones, ObjTrace.Sueno,
                     ObjTrace.PesoAnterior, ObjTrace.Infancia, ObjTrace.EvaluacionAlimentacionActual, ObjTrace.Estado, ObjTrace.UsuarioCreacion,
                     ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion, ObjTrace.FechaModificacion, ObjTrace.Accion).ToList();
               
            }
            
        }
       
    }
}
