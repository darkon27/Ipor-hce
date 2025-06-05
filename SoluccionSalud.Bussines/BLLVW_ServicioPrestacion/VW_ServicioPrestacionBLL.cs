using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVW_ServicioPrestacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLVW_ServicioPrestacion
{
    public class VW_ServicioPrestacionBLL
    {
        public List<VW_ServicioPrestacion> listarVW_ServicioPrestacion(VW_ServicioPrestacion objSC, int inicio, int final)
        {
            return new VW_ServicioPrestacionRepository().listarVW_ServicioPrestacion(objSC, inicio, final);
        }

        public int setMantenimiento(VW_ServicioPrestacion ObjTrace)
        {
            return new VW_ServicioPrestacionRepository().setMantenimiento(ObjTrace);
        }
    }
}
