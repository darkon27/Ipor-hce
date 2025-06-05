using SoluccionSalud.Bussines.BLLVW_ATENCIONPACIENTEMEDICAMENTOS;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.VW_ATENCIONPACIENTEMEDICAMENTOS
{
    public class svcVw_AtencionPacienteMedicamento
    {
        public static List<VW_ATENCIONPACIENTEMEDICAMENTO> listarVwAtencionPacienteMedicamento(VW_ATENCIONPACIENTEMEDICAMENTO objSC, int inicio, int final)
        {
            return new Vw_AtencionPacienteMedicamentoBLL().listarVwAtencionPacienteMedicamento(objSC, inicio, final);
        }

       /* public static int setMantenimiento(VW_ATENCIONPACIENTEMEDICAMENTO ObjTrace)
        {
            return new Vw_AtencionPacienteMedicamentoBLL().setMantenimiento(ObjTrace);
        }*/
    }
}



