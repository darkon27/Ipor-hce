using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLActividades;

namespace SoluccionSalud.Service.ActividadesService
{
    public class SvcActividades
    {
        public static List<SS_HC_Actividad> listarActividades(SS_HC_Actividad objSC, int inicio, int final)
        {
            return new ActividadesBLL().listarActividades(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_Actividad ObjTrace)
        {
            return new ActividadesBLL().setMantenimiento(ObjTrace);
        }
    }
}
