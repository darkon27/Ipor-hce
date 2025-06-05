using SoluccionSalud.Bussines.BLLcompanyowner;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.companyownerService
{
    public class Svccompanyowner
    {
        public static List<companyowner> listarcompanyowner(companyowner objSC, int inicio, int final)
        {
            return new companyownerBLL().listarcompanyowner(objSC, inicio, final);
        }

        public static int setMantenimiento(companyowner ObjTrace)
        {
            return new companyownerBLL().setMantenimiento(ObjTrace);
        }
    }
}
