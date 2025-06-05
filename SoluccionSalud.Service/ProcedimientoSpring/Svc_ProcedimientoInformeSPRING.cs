using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Bussines.BLLProcedimientoSpring;
using SoluccionSalud.Entidades.Entidades;



namespace SoluccionSalud.Service.ProcedimientoSpring
{
    public class Svc_ProcedimientoInformeSPRING
    {
        public static List<SS_HC_ProcedimientoInformeSPRING> ListarProcedimientoInformeSPRING(SS_HC_ProcedimientoInformeSPRING objSC,int inicio, int final)
        {
            return new ProcedimientoSpringBLL().ListarProcedimientoInformeSPRING(objSC,inicio,final);
        }
    }
}
