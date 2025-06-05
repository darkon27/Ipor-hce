using SoluccionSalud.Bussines.BLLWH_ClaseFamilia;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.WH_ClaseFamiliaService
{
    public class SvcWH_ClaseFamilia
    {
        public static List<WH_ClaseFamilia> listarWH_ClaseFamilia(WH_ClaseFamilia objSC, int inicio, int final)
        {
            return new WH_ClaseFamiliaBLL().listarWH_ClaseFamilia(objSC, inicio, final);
        }

        public static int setMantenimiento(WH_ClaseFamilia ObjTrace)
        {
            return new WH_ClaseFamiliaBLL().setMantenimiento(ObjTrace);
        }
    }
}
