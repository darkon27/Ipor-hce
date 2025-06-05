using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLControlComponente;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ControlComponenteService
{
    public class SvcControlComponente
    {
        public static List<SS_HC_ControlComponente> listarControlComponente(SS_HC_ControlComponente objSC, int inicio, int final)
        {
            return new ControlComponenteBLL().listarControlComponente(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_ControlComponente ObjTrace)
        {
            return new ControlComponenteBLL().setMantenimiento(ObjTrace);
        }
    }
}
