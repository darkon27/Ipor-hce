using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCAMPOTABLA;

namespace SoluccionSalud.Bussines.BLLVW_CAMPOTABLA
{
    public class VW_TABLACAMPOBLL
    {
        public List<VW_TABLACAMPO> listarVwTablaCampo(VW_TABLACAMPO objSC, int inicio, int final)
        {
            return new CampoTablaRepository().listarVwTablaCampo(objSC, inicio, final);
        }

        public int setMantenimiento(VW_TABLACAMPO ObjTrace)
        {
            return new CampoTablaRepository().setMantenimiento(ObjTrace);
        }
    }
}
