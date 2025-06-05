using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSS_FA_DevolucionProducto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSS_FA_DevolucionProducto
{
   public class SS_FA_DevolucionProductoBLL
    {
        public int setMantenimiento(SS_FA_DevolucionProducto ObjTrace, List<SS_FA_DevolucionProductoDetalle> ObjTrace2)
        {
            return new SS_FA_DevolucionProductoRepository().setMantenimiento(ObjTrace, ObjTrace2);
        }
        public List<SS_FA_DevolucionProducto> Listar(SS_FA_DevolucionProducto ObjTrace)
        {
            return new SS_FA_DevolucionProductoRepository().Listar(ObjTrace);
        }
        public List<SS_FA_DevolucionProductoDetalle> ListarDetalle(SS_FA_DevolucionProducto ObjTrace)
        {
            return new SS_FA_DevolucionProductoRepository().ListarDetalle(ObjTrace);
        }
    }
}
