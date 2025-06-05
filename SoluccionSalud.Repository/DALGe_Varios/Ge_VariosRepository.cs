using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Model;
using SoluccionSalud.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALGe_Varios
{
    public class Ge_VariosRepository : GenericDataRepository<GE_Varios>
    {
        public List<GE_Varios> listarGe_Varios(GE_Varios objSC)
        {
            using (var context = new WEB_ERPSALUDEntities())
            {
                return context.USP_GE_VARIOSLISTAR(objSC.CodigoTabla, objSC.Secuencial,
                    objSC.CodigoTablaPadre, objSC.SecuencialPadre, objSC.Nemonico, objSC.Descripcion,
                    objSC.ValorFecha, objSC.ValorNumerico, objSC.ValorTexto, objSC.IndicadorUso,
                    objSC.IndicadorAgregarHijo, objSC.Estado, objSC.UsuarioCreacion,
                    objSC.FechaCreacion, objSC.UsuarioModificacion, objSC.FechaModificacion,
                    objSC.OrdenEstablecido, objSC.Accion).ToList();
            }
        }
    }
}
