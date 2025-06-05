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
    
    public class MedicamentoRepository : GenericDataRepository<SS_HC_Medicamento>
    {
        public int setMantenimiento(SS_HC_Medicamento ObjTrace)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0;
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_Medicamento(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                    ObjTrace.IdEpisodioAtencion, ObjTrace.Secuencia, ObjTrace.IdUnidadMedida,
                    ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.Cantidad,
                    ObjTrace.Frecuencia, ObjTrace.Periodo, ObjTrace.IdUnidadTiempo,
                    ObjTrace.CodigoMedicamento, ObjTrace.CantidadDespachada, ObjTrace.Estado,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Presentacion,
                    ObjTrace.Dosis, ObjTrace.Tiempo).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }

        public List<SS_HC_Medicamento> MedicamentoListar(SS_HC_Medicamento ObjTrace)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_MedicamentoListar(ObjTrace.UnidadReplicacion, ObjTrace.IdPaciente, ObjTrace.EpisodioClinico,
                    ObjTrace.IdEpisodioAtencion, ObjTrace.Secuencia, ObjTrace.IdUnidadMedida,
                    ObjTrace.Linea, ObjTrace.Familia, ObjTrace.SubFamilia, ObjTrace.Cantidad,
                    ObjTrace.Frecuencia, ObjTrace.Periodo, ObjTrace.IdUnidadTiempo,
                    ObjTrace.CodigoMedicamento, ObjTrace.CantidadDespachada, ObjTrace.Estado,
                    ObjTrace.UsuarioCreacion, ObjTrace.FechaCreacion, ObjTrace.UsuarioModificacion,
                    ObjTrace.FechaModificacion, ObjTrace.Accion, ObjTrace.Version, ObjTrace.Presentacion,
                    ObjTrace.Dosis, ObjTrace.Tiempo).ToList();
            }
        }
    }
}


