using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALVW_ATENCIONPACIENTEMEDICAMENTOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLVW_ATENCIONPACIENTEMEDICAMENTOS
{
    public class Vw_AtencionPacienteMedicamentoBLL
    {
        public List<VW_ATENCIONPACIENTEMEDICAMENTO> listarVwAtencionPacienteMedicamento(VW_ATENCIONPACIENTEMEDICAMENTO objSC, int inicio, int final)
        {
            return new Vw_AtencionPacienteMedicamentoRepository().listarVwAtencionPacienteMedicamento(objSC, inicio, final);
        }
        /*public int setMantenimiento(VW_ATENCIONPACIENTEMEDICAMENTO ObjTrace)
        {
            return new Vw_AtencionPacienteMedicamentoRepository().setMantenimiento(ObjTrace);
        }*/
    }
}
