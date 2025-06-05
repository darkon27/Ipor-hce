using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNicActividad;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NicActividadService
{
    public class SvcNicActividad
    {

        public static List<SS_HC_NICActividad> listarNicActividad(SS_HC_NICActividad objSC, int inicio, int final)
        {
            return new NicActividadBLL().listarNicActividad(objSC, inicio, final);
        }

        public static int setMantenimientoNicActividad(SS_HC_NICActividad ObjTrace)
        {
            return new NicActividadBLL().setMantenimientoNicActividad(ObjTrace);
        }

        public static int setMantenimientoNicActividad(List<SS_HC_NICActividad> listaObjSC)
        {
            return new NicActividadBLL().setMantenimientoNicActividad(listaObjSC);
        }

    }
}
