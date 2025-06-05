using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALMaestroDetalle;

namespace SoluccionSalud.Bussines.BLLMaestroDetalle
{
    public class MaestroDetalleBLL
    {
        public List<CM_CO_TablaMaestroDetalle> listarMaestroDetalle(CM_CO_TablaMaestroDetalle objSC, int inicio, int final)
        {
            return new MaestroDetalleRepository().listarMaestroDetalle(objSC, inicio, final);
        }

        public int setMantenimiento(CM_CO_TablaMaestroDetalle ObjTrace)
        {
            return new MaestroDetalleRepository().setMantenimiento(ObjTrace);
        }
    }
}
