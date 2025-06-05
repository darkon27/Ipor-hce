using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALFormatoC
{
   public class FormatoRepository
    {
        public List<SS_HC_Formato> listarFormato(SS_HC_Formato objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                /*return context.USP_SS_HC_Formato_Lista(objSC.IdFormato, objSC.IdFormatoPadre,
                    objSC.CodigoFormato, objSC.CodigoFormatoPadre, objSC.CadenaRecursividad, objSC.Nivel,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.TipoFormato,
                    objSC.VersionFormatoFijo, objSC.IdFormatoDinamico, objSC.Estado, 
                    objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Modulo, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();
                 */
                return null;
            }
        }
        public int setMantenimiento(SS_HC_Formato objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_Formato_Mantenimiento(objSC.IdFormato, objSC.IdFormatoPadre,
                    objSC.CodigoFormato, objSC.CodigoFormatoPadre, objSC.CadenaRecursividad, objSC.Nivel,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.TipoFormato,
                    objSC.VersionFormatoFijo, objSC.IdFormatoDinamico, objSC.Estado,
                    objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
