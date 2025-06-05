using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFavoritoCodigo;

namespace SoluccionSalud.Bussines.BLLFavoritoCodigo
{
   public class FavoritoCodigoBLL
   {
       public List<SS_HC_FavoritoCodigoId> listarFavoritoCodigo(SS_HC_FavoritoCodigoId objSC, int inicio, int final)
       {
           return new FavoritoCodigoRepository().listarFavoritoCodigo(objSC, inicio, final);
       }

       public int setMantenimiento(SS_HC_FavoritoCodigoId ObjTrace)
       {
           return new FavoritoCodigoRepository().setMantenimiento(ObjTrace);
       }
    }
}
