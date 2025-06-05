using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALWH_ClaseFamilia;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLWH_ClaseFamilia
{
    public class WH_ClaseFamiliaBLL
    {
        public List<WH_ClaseFamilia> listarWH_ClaseFamilia(WH_ClaseFamilia objSC, int inicio, int final)
        {
            return new WH_ClaseFamiliaRepository().listarWH_ClaseFamilia(objSC, inicio, final);
        }

        public int setMantenimiento(WH_ClaseFamilia ObjTrace)
        {
            return new WH_ClaseFamiliaRepository().setMantenimiento(ObjTrace);
        }
    }
}
