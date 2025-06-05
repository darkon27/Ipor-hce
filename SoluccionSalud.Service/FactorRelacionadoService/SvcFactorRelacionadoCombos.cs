using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFactorRelacionado;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.FactorRelacionadoService
{
    public class SvcFactorRelacionadoCombos
    {
        public static List<SS_HC_FactorRelacionado> listarFactorRelacionadocombos(SS_HC_FactorRelacionado objSC, int inicio, int final)
        {
            return new FactorRelacionadoCombosBLL().listarFactorRelacionadocombos(objSC, inicio, final);
        }
    }
}
