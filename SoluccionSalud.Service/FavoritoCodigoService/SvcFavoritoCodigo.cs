using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFavoritoCodigo;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.FavoritoCodigoService
{
    public class SvcFavoritoCodigo
    {
        public static List<SS_HC_FavoritoCodigoId> listarFavoritoCodigo(SS_HC_FavoritoCodigoId objSC, int inicio, int final)
        {
            return new FavoritoCodigoBLL().listarFavoritoCodigo(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_FavoritoCodigoId ObjTrace)
        {
            return new FavoritoCodigoBLL().setMantenimiento(ObjTrace);
        }
    }
}
