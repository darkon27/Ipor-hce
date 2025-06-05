using SoluccionSalud.Bussines.BLLSeguimientoRiesgoDetalle;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SeguimientoRiesgoDetalleService
{
    public class SvcSeguimientoRiesgoDetalle
    {
        public static List<SS_HC_SeguimientoRiesgoDetalle> listarSeguimientoRiesgoDetalle(SS_HC_SeguimientoRiesgoDetalle objSC)
        {
            return new SeguimientoRiesgoDetalleBLL().listarSeguimientoRiesgoDetalle(objSC);
        }
        public static int setMantenimiento(SS_HC_SeguimientoRiesgoDetalle ObjTrace)
        {
            return new SeguimientoRiesgoDetalleBLL().setMantenimiento(ObjTrace);
        }
    }
}
