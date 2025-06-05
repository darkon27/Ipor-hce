using SoluccionSalud.Bussines.BLLVW_ServicioPrestacion;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.VW_ServicioPrestacionService
{
    public class SvcVW_ServicioPrestacion
    {
        public static List<VW_ServicioPrestacion> listarVW_ServicioPrestacion(VW_ServicioPrestacion objSC, int inicio, int final)
        {
            return new VW_ServicioPrestacionBLL().listarVW_ServicioPrestacion(objSC, inicio, final);
        }

        public static int setMantenimiento(VW_ServicioPrestacion ObjTrace)
        {
            return new VW_ServicioPrestacionBLL().setMantenimiento(ObjTrace);
        }
    }
}
