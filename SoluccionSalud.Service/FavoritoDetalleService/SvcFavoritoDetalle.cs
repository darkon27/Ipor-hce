using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFavoritoDetalle;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.FavoritoDetalleService
{
    public class SvcFavoritoDetalle
    {
        public static List<SS_HC_FavoritoDetalle> listarFavoritoDetalle(SS_HC_FavoritoDetalle objSC, int inicio, int final
             , int idAgente, int TipoFavorito)
        {
            return new FavoritoDetalleBLL().listarFavoritoDetalle(objSC, inicio, final, idAgente, TipoFavorito);
        }

        public static int setMantenimiento(SS_HC_FavoritoDetalle ObjTrace, int idAgente, int TipoFavorito)
        {
            return new FavoritoDetalleBLL().setMantenimiento(ObjTrace, idAgente, TipoFavorito);
        }
    }
}
