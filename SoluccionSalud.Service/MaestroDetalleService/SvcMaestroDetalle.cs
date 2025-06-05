using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLMaestroDetalle;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.MaestroDetalleService
{
    public class SvcMaestroDetalle
    {
        public static List<CM_CO_TablaMaestroDetalle> listarMaestroDetalle(CM_CO_TablaMaestroDetalle objSC, int inicio, int final)
        {
            return new MaestroDetalleBLL().listarMaestroDetalle(objSC, inicio, final);
        }

        public static int setMantenimiento(CM_CO_TablaMaestroDetalle ObjTrace)
        {
            return new MaestroDetalleBLL().setMantenimiento(ObjTrace);
        }
    }
}
