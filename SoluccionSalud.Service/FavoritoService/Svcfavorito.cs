using SoluccionSalud.Bussines.BLLFavorito;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FavoritoService
{
    public class Svcfavorito
    {
        public static List<SS_HC_Favorito> listarFavorito(SS_HC_Favorito objSC, int inicio, int final)
        {
            return new FavoritoBLL().listarFavorito(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_Favorito ObjTrace)
        {
            return new FavoritoBLL().setMantenimiento(ObjTrace);
        }
    }
}
