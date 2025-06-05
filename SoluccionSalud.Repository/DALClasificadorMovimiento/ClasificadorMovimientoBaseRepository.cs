using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;

namespace SoluccionSalud.Repository.DALClasificadorMovimiento
{
    public class ClasificadorMovimientoBaseRepository : GenericDataRepository<GE_ClasificadorMovimiento>
    {
        public List<GE_ClasificadorMovimiento> listarClasificadorMovimiento(GE_ClasificadorMovimiento objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_GE_ClasificadorMovimientoListar(objSC.ClasificadorMovimiento, objSC.ClasificadorMovimientoGrupo, objSC.Nombre,
                    objSC.Descripcion, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.FlujodeCaja,objSC.CentroCosto, inicio, final, objSC.ACCION, objSC.VERSION
                   ).ToList();
            }
        }

        public int setMantenimiento(GE_ClasificadorMovimiento objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_GE_ClasificadorMovimiento(
                   objSC.ClasificadorMovimiento, objSC.ClasificadorMovimientoGrupo, objSC.Nombre,
                    objSC.Descripcion, objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion, objSC.UsuarioModificacion,
                    objSC.FechaModificacion, objSC.FlujodeCaja,objSC.CentroCosto, objSC.ACCION, objSC.VERSION).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
