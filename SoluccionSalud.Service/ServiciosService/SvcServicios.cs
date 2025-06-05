using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLServicios;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ServiciosService
{
    public class SvcServicios
    {
        public static List<SS_GE_Servicio> listarServicio(SS_GE_Servicio objSC, int inicio, int final)
        {
            return new ServiciosBLL().listarServicio(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_GE_Servicio ObjTrace)
        {
            return new ServiciosBLL().setMantenimiento(ObjTrace);
        }
    }
}
