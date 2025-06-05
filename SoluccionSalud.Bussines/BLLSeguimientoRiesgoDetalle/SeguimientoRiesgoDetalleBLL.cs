using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSeguimientoRiesgoDetalle;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSeguimientoRiesgoDetalle
{
    public class SeguimientoRiesgoDetalleBLL
    {
        public List<SS_HC_SeguimientoRiesgoDetalle> listarSeguimientoRiesgoDetalle(SS_HC_SeguimientoRiesgoDetalle objSC)
        {
            return new SeguimientoRiesgoDetalleRepository().listarSeguimientoRiesgoDetalle(objSC);
        }

        public int setMantenimiento(SS_HC_SeguimientoRiesgoDetalle ObjTrace)
        {
            return new SeguimientoRiesgoDetalleRepository().setMantenimiento(ObjTrace);
        }
    }
}
