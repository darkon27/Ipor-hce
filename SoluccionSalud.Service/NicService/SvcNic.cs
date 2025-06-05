using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNic;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NicService
{
    public class SvcNic
    {
        public static List<SS_HC_NIC> listarNic(SS_HC_NIC objSC, int inicio, int final)
        {
            return new NicBLL().listarNic(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_NIC ObjTrace)
        {
            return new NicBLL().setMantenimiento(ObjTrace);
        }
    }
}
