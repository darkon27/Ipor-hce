using SoluccionSalud.Bussines.BLLVW_PERSONAPACIENTE;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.VW_PERSONAPACIENTEService
{
    public class SvcVw_Personapaciente
    {
        public static List<VW_PERSONAPACIENTE> listarVwPersonapaciente(VW_PERSONAPACIENTE objSC, int inicio, int final)
        {
            return new Vw_PersonapacienteBLL().listarVwPersonapaciente(objSC, inicio,final);
        }

        public static int setMantenimiento(VW_PERSONAPACIENTE ObjTrace)
        {
            return new Vw_PersonapacienteBLL().setMantenimiento(ObjTrace);
        }
    }
}
