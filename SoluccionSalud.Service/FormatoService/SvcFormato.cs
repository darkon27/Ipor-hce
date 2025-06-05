using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFormato;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.FormatoService
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
