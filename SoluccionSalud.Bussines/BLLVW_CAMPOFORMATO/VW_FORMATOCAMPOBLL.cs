using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCAMPOFORMATO;

namespace SoluccionSalud.Bussines.BLLVW_CAMPOFORMATO
{
    public class VW_FORMATOCAMPOBLL
    {
        public List<VW_FORMATOCAMPO> listarVWFormatoCampo(VW_FORMATOCAMPO objSC, int inicio, int final)
        {
            return new CampoFormatoRepository().listarVWFormatoCampo(objSC, inicio, final);
        }

        public int setMantenimiento(VW_FORMATOCAMPO ObjTrace)
        {
            return new CampoFormatoRepository().setMantenimiento(ObjTrace);
        }
    }
}
