using SoluccionSalud.Bussines.BLLHorario;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Service.HorarioService
{
    public class SvcSS_CC_Horario
    {
        public static List<SS_CC_Horario> listarSS_CC_Horario(SS_CC_Horario objSC, int inicio, int final)
        {
            return new BLLSS_CC_Horario().listarSS_CC_Horario(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_CC_Horario ObjTrace)
        {
            return new BLLSS_CC_Horario().setMantenimiento(ObjTrace);
        }
    }
}
