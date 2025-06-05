using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALMaestroDetalle
{
    public class MaestroDetalleRepository : GenericDataRepository<CM_CO_TablaMaestroDetalle>
    {
        public List<CM_CO_TablaMaestroDetalle> listarMaestroDetalle(CM_CO_TablaMaestroDetalle objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_CM_CH_CO_TablaMaestroDetalleListar(objSC.IdTablaMaestro, objSC.IdCodigo, 
                    objSC.Codigo,objSC.Nombre, objSC.Descripcion, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, inicio, final
                   ).ToList();
            }
        }
        public int setMantenimiento(CM_CO_TablaMaestroDetalle objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_CM_CH_CO_TablaMaestroDetalle(objSC.IdTablaMaestro, objSC.IdCodigo,
                    objSC.Codigo, objSC.Nombre, objSC.Descripcion, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
