using SoluccionSalud.Bussines.BLLSS_HC_CuerpoHumano;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SS_HC_CuerpoHumanoService
{
    public class SvcSS_HC_CuerpoHumano
    {
        public static List<SS_HC_CuerpoHumano> listarSSHCCuerpoHumano(SS_HC_CuerpoHumano objSC)
        {
            return new SS_HC_CuerpoHumanoBLL().listarSSHCCuerpoHumano(objSC);
        }
        public static int setMantenimiento(SS_HC_CuerpoHumano ObjTrace)
        {
            return new SS_HC_CuerpoHumanoBLL().setMantenimiento(ObjTrace);
        }
    }
}
