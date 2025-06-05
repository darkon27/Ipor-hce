using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALWH_Favoritos;

namespace SoluccionSalud.Bussines.BLLWH_Favoritos
{
    public class wh_favoritosBLL
    {
        public List<vw_favoritos> listarvw_favoritos(vw_favoritos objSC, int inicio, int final)
        {
            return new WH_FavoritosRepository().listarvw_favoritos(objSC, inicio, final);
        }

        public int setMantenimiento(vw_favoritos ObjTrace)
        {
            return new WH_FavoritosRepository().setMantenimiento(ObjTrace);
        }
    }
}
