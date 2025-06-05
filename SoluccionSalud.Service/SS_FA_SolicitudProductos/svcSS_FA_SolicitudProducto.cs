using SoluccionSalud.Bussines.BLLSS_FA_SolicitudProducto;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SS_FA_SolicitudProductos
{
   public class svcSS_FA_SolicitudProducto
    {
       public static int setMantenimiento( SS_FA_SolicitudProducto ObjTrace,  List<SS_FA_SolicitudProductoDetalle> ObjTrace2)
        {
            return new SS_FA_SolicitudProductoBLL().setMantenimiento(ObjTrace, ObjTrace2);
        }
        public static int setMantenimiento02(SS_FA_SolicitudProducto ObjTrace)
        {
            return new SS_FA_SolicitudProductoBLL().setMantenimiento02(ObjTrace);
        }

        public static List<SS_FA_SolicitudProducto> ListarSolicitudProductoListar(SS_FA_SolicitudProducto ObjTrace)
       {
           return new SS_FA_SolicitudProductoBLL().ListarSolicitudProductoListar(ObjTrace);
       }
       
       public static object Listar(SS_FA_SolicitudProducto ObjTrace)
       {
           return new SS_FA_SolicitudProductoBLL().Listar(ObjTrace);
       }
       public static List<SS_FA_SolicitudProductoDetalle> ListarDetalle(SS_FA_SolicitudProducto ObjTrace)
       {
           return new SS_FA_SolicitudProductoBLL().ListarDetalle(ObjTrace);
       }
    }
}
