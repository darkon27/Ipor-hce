using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLCobertura;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.CoberturaService
{
    public class SvcCobertura
    {
        public static List<SS_SG_MaestroCobertura> listarCobertura(SS_SG_MaestroCobertura objSC, int inicio, int final)
        {
            return new CoberturaBLL().listarCobertura(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_SG_MaestroCobertura ObjTrace)
        {
            return new CoberturaBLL().setMantenimiento(ObjTrace);
        }
    }
}
