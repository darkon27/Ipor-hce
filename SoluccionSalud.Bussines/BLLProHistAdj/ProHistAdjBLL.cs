using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALProHistAdj;

namespace SoluccionSalud.Bussines.BLLProHistAdj
{
    public class ProHistAdjBLL
    {
        public List<VW_SS_IT_ProcesoHistoriaAdjunta> listarProcHistAdj(VW_SS_IT_ProcesoHistoriaAdjunta objSC, int inicio, int final)
        {
            return new ProcHistAdjRepository().listarProcHistAdj(objSC, inicio, final);
        }

        public int setMantenimiento(VW_SS_IT_ProcesoHistoriaAdjunta ObjTrace)
        {
            return new ProcHistAdjRepository().setMantenimiento(ObjTrace);
        }
    }
}
