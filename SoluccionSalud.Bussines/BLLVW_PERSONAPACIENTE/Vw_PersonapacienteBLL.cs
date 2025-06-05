using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVW_PERSONAPACIENTE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLVW_PERSONAPACIENTE
{
    public class Vw_PersonapacienteBLL
    {
        public List<VW_PERSONAPACIENTE> listarVwPersonapaciente(VW_PERSONAPACIENTE objSC, int inicio, int final)
        {
            return new Vw_PersonapacienteRepository().listarVwPersonapaciente(objSC, inicio, final);
        }

        public int setMantenimiento(VW_PERSONAPACIENTE ObjTrace)
        {
            return new Vw_PersonapacienteRepository().setMantenimiento(ObjTrace);
        }
    }
}
