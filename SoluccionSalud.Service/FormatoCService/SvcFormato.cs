using SoluccionSalud.Bussines.BLLFormatoC;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormatoCService
{
    public class SvcFormato
    {
        public static List<SS_HC_Formato> listarFormato(SS_HC_Formato objSC, int inicio, int final)
        {
            return new FormatoBLL().listarFormato(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_Formato ObjTrace)
        {
            return new FormatoBLL().setMantenimiento(ObjTrace);
        }
    }
}
