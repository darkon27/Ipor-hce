using SoluccionSalud.Bussines.BLLSS_FA_DevolucionProducto;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.DevolucionProducto
{
  public  class svcSS_FA_DevolucionProducto
    {
      public static int setMantenimiento(SS_FA_DevolucionProducto ObjTrace, List<SS_FA_DevolucionProductoDetalle> ObjTrace2)
        {
            return new SS_FA_DevolucionProductoBLL().setMantenimiento(ObjTrace, ObjTrace2);
        }

      public static List<SS_FA_DevolucionProducto> Listar(SS_FA_DevolucionProducto ObjTrace)
        {
            return new SS_FA_DevolucionProductoBLL().Listar(ObjTrace);
        }

      public static List<SS_FA_DevolucionProductoDetalle> ListarDetalle(SS_FA_DevolucionProducto ObjTrace)
      {
          return new SS_FA_DevolucionProductoBLL().ListarDetalle(ObjTrace);
      }
    }
}
