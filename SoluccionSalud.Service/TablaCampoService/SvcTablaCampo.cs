using SoluccionSalud.Bussines.BLLTablaCampo;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.TablaCampoService
{
    public class SvcTablaCampo
    {
        public static List<SS_HC_TablaCampo> listarTablaCampo(SS_HC_TablaCampo objSC, int inicio, int final)
        {
            return new TablaCampoBLL().listarTablaCampo(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_TablaCampo ObjTrace)
        {
            return new TablaCampoBLL().setMantenimiento(ObjTrace);
        }
    }
}
