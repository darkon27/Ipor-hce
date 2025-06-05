using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFactorRelacionadoNanda;
using SoluccionSalud.Entidades.Entidades;


namespace SoluccionSalud.Service.FactorRelacionadoNandaService
{
    public class SvcFactorRelacionadoNanda
    {
        public static List<SS_HC_FactorRelacionadoNanda> listarFactorRelacionadoNanda(SS_HC_FactorRelacionadoNanda objSC, int inicio, int final)
        {
            return new FactorRelacionadoNandaBLL().listarFactorRelacionadoNanda(objSC, inicio, final);
        }

        public static int setMantenimientoFRN(SS_HC_FactorRelacionadoNanda   ObjTrace)
        {
            return new FactorRelacionadoNandaBLL().setMantenimientoFRN(ObjTrace);
        }

        public static int setMantenimientoFRN(List<SS_HC_FactorRelacionadoNanda> listaObjSC)
        {
            return new FactorRelacionadoNandaBLL().setMantenimientoFRN(listaObjSC);
        }



    }
}
