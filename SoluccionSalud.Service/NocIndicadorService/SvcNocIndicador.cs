using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNocIndicador;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NocIndicadorService
{
    public class SvcNocIndicador
    {

        public static List<SS_HC_NOCIndicador> listarNocIndicador(SS_HC_NOCIndicador objSC, int inicio, int final)
        {
            return new NocIndicadorBLL().listarNocIndicador(objSC, inicio, final);
        }

        public static int setMantenimientoNocIndicador(SS_HC_NOCIndicador ObjTrace)
        {
            return new NocIndicadorBLL().setMantenimientoNocIndicador(ObjTrace);
        }

        public static int setMantenimientoNocIndicador(List<SS_HC_NOCIndicador> listaObjSC)
        {
            return new NocIndicadorBLL().setMantenimientoNocIndicador(listaObjSC);
        }



    }
}
