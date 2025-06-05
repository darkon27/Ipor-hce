using SoluccionSalud.Bussines.BLLWH_Favoritos;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.WH_FavoritosService
{
   public class SvcVW_FavoritosService
   {
       public static List<vw_favoritos> listarvw_favoritos(vw_favoritos objSC, int inicio, int final)
       {
           return new wh_favoritosBLL().listarvw_favoritos(objSC, inicio, final);
       }

       public static int setMantenimiento(vw_favoritos ObjTrace)
       {
           return new wh_favoritosBLL().setMantenimiento(ObjTrace);
       }
    }
}
