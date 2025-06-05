using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFavoritoNumero;

namespace SoluccionSalud.Bussines.BLLFavoritoNumero
{
    public class FavoritoNumeroBLL
    {
        public List<SS_HC_FavoritoNumero> listarFavoritoNumero(SS_HC_FavoritoNumero objSC, int inicio, int final)
        {
            return new FavoritoNumeroRepository().listarFavoritoNumero(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_FavoritoNumero ObjTrace)
        {
            return new FavoritoNumeroRepository().setMantenimiento(ObjTrace);
        }
    }
}
