using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVW_FORMATORECURSOCAMPO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLVW_FORMATORECURSOCAMPO
{
    public class Vw_FORMATORECURSOCAMPOBLL
    {
        public List<VW_FORMATORECURSOCAMPO> listarVW_FORMATORECURSOCAMPO(VW_FORMATORECURSOCAMPO objSC, int inicio, int final)
        {
            return new Vw_FormatoRecursoCampoRepository().listarVW_FORMATORECURSOCAMPO(objSC, inicio, final);
        }

        public int setMantenimiento(VW_FORMATORECURSOCAMPO ObjTrace)
        {
            return new Vw_FormatoRecursoCampoRepository().setMantenimiento(ObjTrace);
        }

    }
}
