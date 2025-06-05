using SoluccionSalud.Bussines.BLLWH_ClaseSubFamilia;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.WH_ClaseSubFamiliaService
{
    public class SvcWH_ClaseSubFamilia
    {
        public static List<WH_ClaseSubFamilia> listarWH_ClaseSubFamilia(WH_ClaseSubFamilia objSC, int inicio, int final)
        {
            return new WH_ClaseSubFamiliaBLL().listarWH_ClaseSubFamilia(objSC, inicio, final);
        }

        public static int setMantenimiento(WH_ClaseSubFamilia ObjTrace)
        {
            return new WH_ClaseSubFamiliaBLL().setMantenimiento(ObjTrace);
        }
    }
}
