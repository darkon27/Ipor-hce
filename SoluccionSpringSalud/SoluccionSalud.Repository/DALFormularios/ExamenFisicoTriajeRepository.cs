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

    public class ExamenFisicoTriajeRepository : GenericDataRepository<SS_HC_ExamenFisico_Triaje>
    {
        public int setMantenimiento(SS_HC_ExamenFisico_Triaje ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_EXAMENFISICOTRIAJE(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.PresionArterial,
                    ObjTrace.FrecuenciaRespiratoria, ObjTrace.FrecuenciaCardiaca, ObjTrace.Temperatura, ObjTrace.Peso,
                    ObjTrace.Talla, ObjTrace.IndiceMasaCorporal, ObjTrace.IdEstadoGeneral, ObjTrace.IdNutricion,
                    ObjTrace.IdHidratacion, ObjTrace.IdColaboracion, ObjTrace.ObservacionesAdicionales, ObjTrace.Estado,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
        public List<SS_HC_ExamenFisico_Triaje> ExamenFisicoTriajeListar(SS_HC_ExamenFisico_Triaje ObjTrace)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_ExamenFisicoTriajeListar(ObjTrace.UnidadReplicacion, ObjTrace.IdEpisodioAtencion,
                    ObjTrace.IdPaciente, ObjTrace.EpisodioClinico, ObjTrace.Secuencia, ObjTrace.PresionArterial,
                    ObjTrace.FrecuenciaRespiratoria, ObjTrace.FrecuenciaCardiaca, ObjTrace.Temperatura, ObjTrace.Peso,
                    ObjTrace.Talla, ObjTrace.IndiceMasaCorporal, ObjTrace.IdEstadoGeneral, ObjTrace.IdNutricion,
                    ObjTrace.IdHidratacion, ObjTrace.IdColaboracion, ObjTrace.ObservacionesAdicionales, ObjTrace.Estado,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version).ToList();
            }

        }
    }
}
