using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DAL_PSpring;

namespace SoluccionSalud.Bussines.BLLProcedimientoSpring
{
    public class ProcedimientoSpringBLL
    {

        public List<SS_HC_ProcedimientoInformeSPRING> ListarProcedimientoInformeSPRING(SS_HC_ProcedimientoInformeSPRING objSC, int inicio, int final)
        {
            return new ProcedimientoSpringRepository().ListarProcedimientoInformeSPRING(objSC, inicio, final);
        }
    }
}
