using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFACTORRELACIONADO;

namespace SoluccionSalud.Bussines.BLLFactorRelacionado
{
    public class FactorRelacionadoCombosBLL
    {
        public List<SS_HC_FactorRelacionado> listarFactorRelacionadocombos(SS_HC_FactorRelacionado objSC, int inicio, int final)
        {
            return new ComboFactorRelacionadoRepository().listarFactorRelacionadocombos(objSC, inicio, final);
        }

     
    }
}
