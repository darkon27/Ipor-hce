using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcEvolucionObjetivaService
    {
        public static SS_HC_EvolucionObjetiva getPorId_SS_HC_EvolucionObjetiva(
            SS_HC_EvolucionObjetiva objSC)
        {
            return new EvolucionObjetivaBLL().getPorId_SS_HC_EvolucionObjetiva(objSC);
        }
        public static List<SS_HC_EvolucionObjetiva> listarSS_HC_EvolucionObjetiva(SS_HC_EvolucionObjetiva objSC)
        {
            return new EvolucionObjetivaBLL().listarSS_HC_EvolucionObjetiva(objSC);
        }

        public static int setMantenimiento(SS_HC_EvolucionObjetiva ObjTraces)
        {
            return new EvolucionObjetivaBLL().setMantenimiento(ObjTraces);
        }
    }
}
