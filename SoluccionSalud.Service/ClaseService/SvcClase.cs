using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLClase;

namespace SoluccionSalud.Service.ClaseService
{
    public class SvcClase
    {
        public static List<SS_HC_ClasePAE> listarclase(SS_HC_ClasePAE objSC, int inicio, int final)
        {
            return new ClaseBLL().listarclase(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_ClasePAE ObjTrace)
        {
            return new ClaseBLL().setMantenimiento(ObjTrace);
        }

    }
}
