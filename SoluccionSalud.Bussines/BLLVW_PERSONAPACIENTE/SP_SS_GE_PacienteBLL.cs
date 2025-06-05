using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVW_PERSONAPACIENTE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLVW_PERSONAPACIENTE
{
    public class SP_SS_GE_PacienteBLL
    {
        public List<SS_GE_Paciente> listarPaciente(SS_GE_Paciente objSC, int inicio, int final)
        {
            return new SP_SS_GE_PacienteRepository().listarPaciente(objSC, inicio, final);
        }

        public int setMantenimiento(SS_GE_Paciente ObjTrace, PERSONAMAST ObjTracee)
        {
            return new SP_SS_GE_PacienteRepository().setMantenimiento(ObjTrace, ObjTracee);
        }
    }
}
