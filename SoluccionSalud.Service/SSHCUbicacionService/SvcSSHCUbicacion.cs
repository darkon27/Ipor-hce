using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLSSHCUbicacion;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.SSHCUbicacionService
{
    public class SvcSSHCUbicacion
    {
        public static List<SS_HC_Ubicacion> listarSSHCUbicacion(SS_HC_Ubicacion objSC, int inicio, int final)
        {
            return new SSHCUbicacionBLL().listarSSHCUbicacion(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_Ubicacion ObjTrace)
        {
            return new SSHCUbicacionBLL().setMantenimiento(ObjTrace);
        }
    }
}
