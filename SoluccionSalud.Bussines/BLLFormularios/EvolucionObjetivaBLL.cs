using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{
    public class EvolucionObjetivaBLL
    {
        public SS_HC_EvolucionObjetiva getPorId_SS_HC_EvolucionObjetiva(
            SS_HC_EvolucionObjetiva objSC)
        {
            return new EvolucionObjetivaRepository().getPorId_SS_HC_EvolucionObjetiva(objSC);
        }
        public List<SS_HC_EvolucionObjetiva> listarSS_HC_EvolucionObjetiva(SS_HC_EvolucionObjetiva objSC)
        {
            return new EvolucionObjetivaRepository().listarSS_HC_EvolucionObjetiva(objSC);
        }

        public int setMantenimiento(SS_HC_EvolucionObjetiva ObjTraces)
        {
            return new EvolucionObjetivaRepository().setMantenimiento(ObjTraces);
        }
    }
}
