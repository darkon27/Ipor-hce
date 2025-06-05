using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVW_ATENCIONPACIENTE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLVW_ATENCIONPACIENTE
{
    public class Vw_AtencionPacienteBLL
    {
        public List<VW_ATENCIONPACIENTE> listarVwAtencionPaciente(VW_ATENCIONPACIENTE objSC, int inicio, int final)
        {
            return new Vw_AtencionPacienteRepository().listarVwAtencionPaciente(objSC,inicio,final);
        }
        public List<VW_ATENCIONPACIENTE> listarVwAtencionPaciente(VW_ATENCIONPACIENTE_GENERAL objSC, List<VW_ATENCIONPACIENTE_GENERAL> objSCList, int inicio, int final)
        {
            return new Vw_AtencionPacienteRepository().listarVwAtencionPaciente(objSC, objSCList,inicio, final);
        }
        public int setMantenimiento(VW_ATENCIONPACIENTE ObjTrace)
        {
            return new Vw_AtencionPacienteRepository().setMantenimiento(ObjTrace);
        }

        /**GENERAL*/
        public List<VW_ATENCIONPACIENTE_GENERAL> listarVwAtencionPacienteGeneral(VW_ATENCIONPACIENTE_GENERAL objSC, int inicio, int final)
        {
            return new Vw_AtencionPacienteRepository().listarVwAtencionPacienteGeneral(objSC, inicio, final);
        }

        public int setMantenimientoGeneral(VW_ATENCIONPACIENTE_GENERAL ObjTrace)
        {
            return new Vw_AtencionPacienteRepository().setMantenimientoGeneral(ObjTrace);
        }
    }
}
