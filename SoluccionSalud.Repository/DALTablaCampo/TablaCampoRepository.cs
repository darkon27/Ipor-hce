using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALTablaCampo
{
    public class TablaCampoRepository : GenericDataRepository<SS_HC_TablaCampo>
    {
        public List<SS_HC_TablaCampo> listarTablaCampo(SS_HC_TablaCampo objSC, int inicio, int final)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_SS_HC_TablaCampo_Lista(
                    objSC.IdFavoritoTabla, objSC.IdCampo, objSC.NombreCampo, objSC.Orden,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.TipoCampo,
                    objSC.Longitud, objSC.Decimales, objSC.NumeroClavePrimaria, objSC.TipoCampoDescripcion,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version
                    , inicio
                    , final).ToList();
            }
        }
        public int setMantenimiento(SS_HC_TablaCampo objSC)
        {
            System.Nullable<int> iReturnValue;
            int valorRetorno = 0; //ERROR
            using (var context = new WEB_ERPSALUDEntities())
            {
                iReturnValue = context.USP_SS_HC_TablaCampo_Mantenimiento(
                    objSC.IdFavoritoTabla, objSC.IdCampo, objSC.NombreCampo, objSC.Orden,
                    objSC.Descripcion, objSC.DescripcionExtranjera, objSC.TipoCampo,
                    objSC.Longitud, objSC.Decimales, objSC.NumeroClavePrimaria, objSC.TipoCampoDescripcion,
                    objSC.Estado, objSC.UsuarioCreacion, objSC.FechaCreacion,
                    objSC.UsuarioModificacion, objSC.FechaModificacion, objSC.Accion, objSC.Version).SingleOrDefault();
                valorRetorno = Convert.ToInt32(iReturnValue.ToString().Trim());
            }
            return valorRetorno;
        }
    }
}
