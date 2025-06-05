using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormatoCampo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormatoCampo
{
    public class FormatoCampoBLL
    {
        public List<SS_HC_FormatoCampo> listarFormatoCampo(SS_HC_FormatoCampo objSC, int inicio, int final)
        {
            return new FormatoCampoRepository().listarFormatoCampo(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_FormatoCampo ObjTrace)
        {
            return new FormatoCampoRepository().setMantenimiento(ObjTrace);
        }
    }
}
