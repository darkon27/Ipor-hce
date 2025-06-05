using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFavoritoDetalle;

namespace SoluccionSalud.Bussines.BLLFavoritoDetalle
{
   public class FavoritoDetalleBLL
    {
       public List<SS_HC_FavoritoDetalle> listarFavoritoDetalle(SS_HC_FavoritoDetalle objSC, int inicio, int final
           ,int idAgente, int TipoFavorito)
        {
            return new FavoritoDetalleRepository().listarFavoritoDetalle(objSC, inicio, final, idAgente, TipoFavorito);
        }

       public int setMantenimiento(SS_HC_FavoritoDetalle ObjTrace, int idAgente, int TipoFavorito)
        {
            return new FavoritoDetalleRepository().setMantenimiento(ObjTrace, idAgente, TipoFavorito);
        }
    }
}
