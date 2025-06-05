using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLControlValidacion;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ControlValidacionService
{
    public class SvcControlValidacion
    {
        public static List<SS_HC_ControlValidacion> listarControlValidacion(SS_HC_ControlValidacion objSC, int inicio, int final)
        {
            return new ControlValidacionBLL().listarControlValidacion(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_ControlValidacion ObjTrace)
        {
            return new ControlValidacionBLL().setMantenimiento(ObjTrace);
        }
    }
}
