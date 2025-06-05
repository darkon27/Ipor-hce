using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLVW_CAMPOFORMATO;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.CAMPOFORMATOSERVICE
{
    public class SVCCAMPOFORMATO
    {
        public static List<VW_FORMATOCAMPO> listarVWFormatoCampo(VW_FORMATOCAMPO objSC, int inicio, int final)
        {
            return new VW_FORMATOCAMPOBLL().listarVWFormatoCampo(objSC, inicio, final);
        }

        public static int setMantenimiento(VW_FORMATOCAMPO ObjTrace)
        {
            return new VW_FORMATOCAMPOBLL().setMantenimiento(ObjTrace);
        }
    }
}
