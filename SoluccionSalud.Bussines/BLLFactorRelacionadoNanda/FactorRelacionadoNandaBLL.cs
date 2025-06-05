using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFactorRelacionadoNanda;

namespace SoluccionSalud.Bussines.BLLFactorRelacionadoNanda
{
    public class FactorRelacionadoNandaBLL
    {

        public List<SS_HC_FactorRelacionadoNanda> listarFactorRelacionadoNanda(SS_HC_FactorRelacionadoNanda objSC, int inicio, int final)
        {
            return new FactorRelacionadoNandaRepository().listarFactorRelacionadoNanda(objSC, inicio, final);
        }

        public int setMantenimientoFRN(SS_HC_FactorRelacionadoNanda ObjTrace)
        {
            return new FactorRelacionadoNandaRepository().setMantenimientoFRN(ObjTrace);
        }


        public int setMantenimientoFRN(List<SS_HC_FactorRelacionadoNanda> listaObjSC)
        {
            return new FactorRelacionadoNandaRepository().setMantenimientoFRN(listaObjSC);
        }

    }
}
