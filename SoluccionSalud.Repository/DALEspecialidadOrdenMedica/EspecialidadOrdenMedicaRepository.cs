using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALEspecialidadOrdenMedica
{
    public class EspecialidadOrdenMedicaRepository : GenericDataRepository<SS_GE_EspecialidadOrdenMedica>
    {
        public List<SS_GE_EspecialidadOrdenMedica> listarEspecialidadOrdenMedica(SS_GE_EspecialidadOrdenMedica objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_GE_EspecialidadOrdenMedica_Lista(objSC.IdEspecialidad, objSC.Secuencial,
                    objSC.TipoOrdenMedica, objSC.Estado, objSC.FechaCreacion, objSC.UsuarioCreacion,
                    objSC.FechaModificacion, objSC.UsuarioModificacion, objSC.Accion
                    , inicio
                    , final).ToList();
            }
        }
        public int setMantenimiento(SS_GE_EspecialidadOrdenMedica objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_GE_EspecialidadOrdenMedica_mantenimiento(objSC.IdEspecialidad, objSC.Secuencial,
                    objSC.TipoOrdenMedica, objSC.Estado, objSC.FechaCreacion, objSC.UsuarioCreacion,
                    objSC.FechaModificacion, objSC.UsuarioModificacion, objSC.Accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
