using SoluccionSalud.Bussines.BLLWH_ClaseLinea;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.WH_ClaseLineaService
{
    public class SvcWH_ClaseLinea
    {
        public static List<WH_ClaseLinea> listarWH_ClaseLinea(WH_ClaseLinea objSC, int inicio, int final)
        {
            return new WH_ClaseLineaBLL().listarWH_ClaseLinea(objSC, inicio, final);
        }

        public static int setMantenimiento(WH_ClaseLinea ObjTrace)
        {
            return new WH_ClaseLineaBLL().setMantenimiento(ObjTrace);
        }
    }
}
