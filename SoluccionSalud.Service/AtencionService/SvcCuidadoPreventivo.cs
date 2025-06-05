using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLCuidadoPreventivo;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.CuidadoPreventivoService
{
    public class SvcCuidadoPreventivos
    {
        public static List<SS_HC_CuidadoPreventivo> listarCuidadoPreventivo(SS_HC_CuidadoPreventivo objSC, int inicio, int final)
        {
            return new CuidadoPreventivoBLL().listarCuidadoPreventivo(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_CuidadoPreventivo ObjTrace)
        {
            return new CuidadoPreventivoBLL().setMantenimiento(ObjTrace);
        }
    }
}
