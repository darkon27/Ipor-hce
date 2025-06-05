using SoluccionSalud.Bussines.BLLWH_VALIDA;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SS_VW_VALIDAService
{
    public class SvcSS_VW_VALIDA
    {
        public static List<SS_VW_VALIDA> listarSS_VW_VALIDA(SS_VW_VALIDA objSC, int inicio, int final)
        {
            return new WH_VALIDABLL().listarSS_VW_VALIDA(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_VW_VALIDA ObjTrace)
        {
            return new WH_VALIDABLL().setMantenimiento(ObjTrace);
        }
    }
}
