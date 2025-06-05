using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFavorito;

namespace SoluccionSalud.Bussines.BLLFavorito
{
    public class FavoritoBLL
    {
        public List<SS_HC_Favorito> listarFavorito(SS_HC_Favorito objSC, int inicio, int final)
        {
            return new FavoritoRepository().listarFavorito(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_Favorito ObjTrace)
        {
            return new FavoritoRepository().setMantenimiento(ObjTrace);
        }
    }
}
