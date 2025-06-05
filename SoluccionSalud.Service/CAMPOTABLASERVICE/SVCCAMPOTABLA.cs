using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLVW_CAMPOTABLA;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.CAMPOTABLASERVICE
{
    public class SVCCAMPOTABLA
    {
        public static List<VW_TABLACAMPO> listarVwTablaCampo(VW_TABLACAMPO objSC, int inicio, int final)
        {
            return new VW_TABLACAMPOBLL().listarVwTablaCampo(objSC, inicio, final);
        }

        public static int setMantenimiento(VW_TABLACAMPO ObjTrace)
        {
            return new VW_TABLACAMPOBLL().setMantenimiento(ObjTrace);
        }
    }
}
