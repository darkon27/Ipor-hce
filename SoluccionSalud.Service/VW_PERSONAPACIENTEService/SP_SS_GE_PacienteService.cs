using SoluccionSalud.Bussines.BLLVW_PERSONAPACIENTE;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.VW_PERSONAPACIENTEService
{
    public class SP_SS_GE_PacienteService
    {
        public static List<SS_GE_Paciente> listarPaciente(SS_GE_Paciente objSC, int inicio, int final)
        {
            return new SP_SS_GE_PacienteBLL().listarPaciente(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_GE_Paciente ObjTrace, PERSONAMAST ObjTracee)
        {
            return new SP_SS_GE_PacienteBLL().setMantenimiento(ObjTrace, ObjTracee);
        }
    }
}
