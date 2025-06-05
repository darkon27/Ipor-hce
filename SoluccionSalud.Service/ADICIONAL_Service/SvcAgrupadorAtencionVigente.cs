using SoluccionSalud.Bussines.BLL_ADICIONAL;
using SoluccionSalud.Entidades.Entidades;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.ADICIONAL_Service
{
    public class SvcAgrupadorAtencionVigente
    {
        public static List<SS_HC_AgrupadorAtencionVigente> listarSS_HC_AgrupadorAtencionVigente(SS_HC_AgrupadorAtencionVigente objSC, int inicio, int final)
        {
            return new AgrupadorAtencionVigenteBLL().listarSS_HC_AgrupadorAtencionVigente(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_AgrupadorAtencionVigente ObjTrace)
        {
            return new AgrupadorAtencionVigenteBLL().setMantenimiento(ObjTrace);
        }

        public static int setMantenimiento(List<SS_HC_AgrupadorAtencionVigente> listaObjSC)
        {
            return new AgrupadorAtencionVigenteBLL().setMantenimiento(listaObjSC);
        }
    }
}
