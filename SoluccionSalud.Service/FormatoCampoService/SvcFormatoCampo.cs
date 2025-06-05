using SoluccionSalud.Bussines.BLLFormatoCampo;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormatoCampoService
{
    public class SvcFormatoCampo
    {
        public static List<SS_HC_FormatoCampo> listarFormatoCampo(SS_HC_FormatoCampo objSC, int inicio, int final)
        {
            return new FormatoCampoBLL().listarFormatoCampo(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_FormatoCampo ObjTrace)
        {
            return new FormatoCampoBLL().setMantenimiento(ObjTrace);
        }
    }
}
