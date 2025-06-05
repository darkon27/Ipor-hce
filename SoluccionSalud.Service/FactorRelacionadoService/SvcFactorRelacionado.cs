using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFactorRelacionado;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.FactorRelacionadoService
{
    public class SvcFactorRelacionado
    {
        public static List<SS_HC_FactorRelacionado> listarFactorRelacionado(SS_HC_FactorRelacionado objSC, int inicio, int final)
        {
            return new FactorRelacionadoBLL().listarFactorRelacionado(objSC, inicio, final);
        }

        public static int setMantenimientoFR(SS_HC_FactorRelacionado ObjTrace)
        {
            return new FactorRelacionadoBLL().setMantenimientoFR(ObjTrace);
        }
    }
}
