using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSS_FA_SolicitudProducto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSS_FA_SolicitudProducto
{
    public class SS_FA_SolicitudProductoBLL
    {
        public int setMantenimiento(SS_FA_SolicitudProducto ObjTrace, List<SS_FA_SolicitudProductoDetalle> ObjTrace2)
        {
            return new SS_FA_SolicitudProductoRepository().setMantenimiento(ObjTrace, ObjTrace2);
        }
        public int setMantenimiento02(SS_FA_SolicitudProducto ObjTrace)
        {
            return new SS_FA_SolicitudProductoRepository().retornoMedicamento(ObjTrace);
        }
        public List<SS_FA_SolicitudProducto> ListarSolicitudProductoListar(SS_FA_SolicitudProducto ObjTrace)
        {
            return new SS_FA_SolicitudProductoRepository().ListarSolicitudProductoListar(ObjTrace);
        }

        public object Listar(SS_FA_SolicitudProducto ObjTrace)
        {
            return new SS_FA_SolicitudProductoRepository().Listar(ObjTrace);
        }
        public List<SS_FA_SolicitudProductoDetalle> ListarDetalle(SS_FA_SolicitudProducto ObjTrace)
        {
            return new SS_FA_SolicitudProductoRepository().ListarDetalle(ObjTrace);
        }
    }
}
