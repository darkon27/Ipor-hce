using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFavoritoNumero;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.FavoritoNumeroService
{
    public class SvcFavoritoNumero
    {
        public static List<SS_HC_FavoritoNumero> listarFavoritoNumero(SS_HC_FavoritoNumero objSC, int inicio, int final)
        {
            return new FavoritoNumeroBLL().listarFavoritoNumero(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_FavoritoNumero ObjTrace)
        {
            return new FavoritoNumeroBLL().setMantenimiento(ObjTrace);
        }
    }
}
