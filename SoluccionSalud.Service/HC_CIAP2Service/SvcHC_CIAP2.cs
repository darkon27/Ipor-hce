using SoluccionSalud.Bussines.BLLHC_CIAP2;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.HC_CIAP2Service
{
    public class SvcHC_CIAP2
    {
        public static List<SS_HC_CIAP2> listarSS_HC_CIAP2(SS_HC_CIAP2 objSC, int inicio, int final)
        {
            return new HC_CIAP2BLL().listarSS_HC_CIAP2(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_HC_CIAP2 ObjTrace)
        {
            return new HC_CIAP2BLL().setMantenimiento(ObjTrace);
        }
    }
}
