using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALTabla
{
    public class TablaRepository : GenericDataRepository<SS_HC_Tabla>
    {
        public List<SS_HC_Tabla> listarTabla(SS_HC_Tabla objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_Tabla_Lista(
                    objSC.IdFavoritoTabla, objSC.NombreTabla,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.TipoClavePrimaria,
                    objSC.TipoTabla, objSC.Condicion, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();
            }
        }
        public int setMantenimiento(SS_HC_Tabla objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_Tabla_Mantenimiento(
                    objSC.IdFavoritoTabla, objSC.NombreTabla,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.TipoClavePrimaria,
                    objSC.TipoTabla, objSC.Condicion, objSC.Estado,
                    objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
