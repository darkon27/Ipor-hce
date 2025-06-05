using SoluccionSalud.Bussines.BLLVW_FORMATORECURSOCAMPO;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.VW_FORMATORECURSOCAMPOService
{
    public class SvcVw_FormatoRecursoCampo
    {
        public static List<VW_FORMATORECURSOCAMPO> listarVW_FORMATORECURSOCAMPO(VW_FORMATORECURSOCAMPO objSC, int inicio, int final)
        {
            return new Vw_FORMATORECURSOCAMPOBLL().listarVW_FORMATORECURSOCAMPO(objSC, inicio, final);
        }

        public static int setMantenimiento(VW_FORMATORECURSOCAMPO ObjTrace)
        {
            return new Vw_FORMATORECURSOCAMPOBLL().setMantenimiento(ObjTrace);
        }
    }
}
