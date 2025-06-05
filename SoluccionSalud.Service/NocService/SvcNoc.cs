using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNoc;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NocService
{
    public class SvcNoc
    {
            public static List<SS_HC_NOC2> listarNoc(SS_HC_NOC2 objSC, int inicio, int final)
            {
                return new NocBLL().listarNoc(objSC, inicio, final);
            }

            public static int setMantenimiento(SS_HC_NOC2 ObjTrace)
            {
                return new NocBLL().setMantenimiento(ObjTrace);
            }
    
    }
    
}
