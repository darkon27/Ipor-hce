using SoluccionSalud.Bussines.BLLVW_ATENCIONPACIENTE;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.VW_ATENCIONPACIENTEService
{
    public class SvcVw_AtencionPaciente
    {
        public static List<VW_ATENCIONPACIENTE> listarVwAtencionPaciente(VW_ATENCIONPACIENTE objSC, int inicio, int final)
        {
            return new Vw_AtencionPacienteBLL().listarVwAtencionPaciente(objSC,inicio,final);
        }
        public static List<VW_ATENCIONPACIENTE> listarVwAtencionPaciente(VW_ATENCIONPACIENTE_GENERAL objSC, List<VW_ATENCIONPACIENTE_GENERAL> objSCList, int inicio, int final)
        {
            return new Vw_AtencionPacienteBLL().listarVwAtencionPaciente(objSC, objSCList, inicio, final);
        }
        public static int setMantenimiento(VW_ATENCIONPACIENTE ObjTrace)
        {
            return new Vw_AtencionPacienteBLL().setMantenimiento(ObjTrace);
        }
        /**GENERAL*/
        public static List<VW_ATENCIONPACIENTE_GENERAL> listarVwAtencionPacienteGeneral(VW_ATENCIONPACIENTE_GENERAL objSC, int inicio, int final)
        {
            return new Vw_AtencionPacienteBLL().listarVwAtencionPacienteGeneral(objSC, inicio, final);
        }
        public static int setMantenimientoGeneral(VW_ATENCIONPACIENTE_GENERAL ObjTrace)
        {
            return new Vw_AtencionPacienteBLL().setMantenimientoGeneral(ObjTrace);
        }
 
    }
}
