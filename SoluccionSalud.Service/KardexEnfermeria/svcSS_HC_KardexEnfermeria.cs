using SoluccionSalud.Bussines.BLLSS_HC_KardexEnfermeria;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.KardexEnfermeria
{
    public class svcSS_HC_KardexEnfermeria
    {
        public static int setMantenimiento(SS_HC_KardexEnfermeria ObjTrace, List<SS_HC_KardexEnfermeriaDetalle> ObjTrace2)
        {
            return new SS_HC_KardexEnfermeriaBLL().setMantenimiento(ObjTrace, ObjTrace2);
        }

        public static object Listar(SS_HC_KardexEnfermeria ObjTrace)
        {
            return new SS_HC_KardexEnfermeriaBLL().Listar(ObjTrace);
        }
    }
}
