using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLProHistAdj;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ProHistAdjService
{
    public class SvcProHistAdj
    {
        public static List<VW_SS_IT_ProcesoHistoriaAdjunta> listarProcHistAdj(VW_SS_IT_ProcesoHistoriaAdjunta objSC, int inicio, int final)
        {
            return new ProHistAdjBLL().listarProcHistAdj(objSC, inicio, final);
        }
        public static int setMantenimiento(VW_SS_IT_ProcesoHistoriaAdjunta ObjTrace)
        {
            return new ProHistAdjBLL().setMantenimiento(ObjTrace);
        }
    }
}
