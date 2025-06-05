using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLIndicador;

namespace SoluccionSalud.Service.IndicadorService
{
    public class SvcIndicador
    {
        public static List<SS_HC_IndicadorPAE> listarindicador(SS_HC_IndicadorPAE objSC, int inicio, int final)
        {
            return new IndicadorBLL().listarindicador(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_IndicadorPAE ObjTrace)
        {
            return new IndicadorBLL().setMantenimiento(ObjTrace);
        }
    }
}
