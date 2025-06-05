using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFACTORRELACIONADO;


namespace SoluccionSalud.Bussines.BLLFactorRelacionado
{
    public class FactorRelacionadoBLL
    {
        public List<SS_HC_FactorRelacionado> listarFactorRelacionado(SS_HC_FactorRelacionado objSC, int inicio, int final)
        {
            return new FactorRelacionadoRepository().listarFactorRelacionado(objSC, inicio, final);
        }

        public int setMantenimientoFR(SS_HC_FactorRelacionado ObjTrace)
        {
            return new FactorRelacionadoRepository().setMantenimientoFR(ObjTrace);
        }

     
    }
}
