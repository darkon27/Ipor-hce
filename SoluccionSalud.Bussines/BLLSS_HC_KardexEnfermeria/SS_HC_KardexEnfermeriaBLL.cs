using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSS_HC_KardexEnfermeria;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSS_HC_KardexEnfermeria
{
    public class SS_HC_KardexEnfermeriaBLL
    {
        public int setMantenimiento(SS_HC_KardexEnfermeria ObjTrace, List<SS_HC_KardexEnfermeriaDetalle> ObjTrace2)
        {
            return new SS_HC_KardexEnfermeriaRepository().setMantenimiento(ObjTrace, ObjTrace2);
        }
        public object Listar(SS_HC_KardexEnfermeria ObjTrace)
        {
            return new SS_HC_KardexEnfermeriaRepository().Listar(ObjTrace);
        }
    }
}
