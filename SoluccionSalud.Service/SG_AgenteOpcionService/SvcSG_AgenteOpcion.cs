using SoluccionSalud.Bussines.BLLSG_AgenteOpcion;
using SoluccionSalud.Entidades.Entidades;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SG_AgenteOpcionService
{
    public class SvcSG_AgenteOpcion
    {
        public static List<SG_AgenteOpcion> listarSG_AgenteOpcion(SG_AgenteOpcion objSC, int inicio, int final)
        {
            return new SG_AgenteOpcionBLL().listarSG_AgenteOpcion(objSC, inicio, final);
        }

        public static int setMantenimiento(SG_AgenteOpcion ObjTrace)
        {
            return new SG_AgenteOpcionBLL().setMantenimiento(ObjTrace);
        }
    }
}
