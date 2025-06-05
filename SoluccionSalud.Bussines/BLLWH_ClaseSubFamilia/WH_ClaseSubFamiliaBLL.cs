using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALWH_ClaseSubFamilia;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLWH_ClaseSubFamilia
{
    public class WH_ClaseSubFamiliaBLL
    {
        public List<WH_ClaseSubFamilia> listarWH_ClaseSubFamilia(WH_ClaseSubFamilia objSC, int inicio, int final)
        {
            return new WH_ClaseSubFamiliaRepository().listarWH_ClaseSubFamilia(objSC, inicio, final);
        }

        public int setMantenimiento(WH_ClaseSubFamilia ObjTrace)
        {
            return new WH_ClaseSubFamiliaRepository().setMantenimiento(ObjTrace);
        }
    }
}
