using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSSHCUbicacion;

namespace SoluccionSalud.Bussines.BLLSSHCUbicacion
{
    public class SSHCUbicacionBLL
    {
        public List<SS_HC_Ubicacion> listarSSHCUbicacion(SS_HC_Ubicacion objSC, int inicio, int final)
        {
            return new SSHCUbicacionRepository().listarSSHCUbicacion(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_Ubicacion ObjTrace)
        {
            return new SSHCUbicacionRepository().setMantenimiento(ObjTrace);
        }
    }
}
