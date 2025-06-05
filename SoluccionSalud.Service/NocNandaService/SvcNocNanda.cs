using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNocNanda;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NocNandaService
{
    public class SvcNocNanda
    {
        public static List<SS_HC_NandaNoc> listarNocNanda(SS_HC_NandaNoc objSC, int inicio, int final)
        {
            return new NocNandaBLL().listarNocNanda(objSC, inicio, final);
        }

        public static int setMantenimientoNanNoc(SS_HC_NandaNoc ObjTrace)
        {
            return new NocNandaBLL().setMantenimientoNanNoc(ObjTrace);
        }

        public static int setMantenimientoNanNoc(List<SS_HC_NandaNoc> listaObjSC)
        {
            return new NocNandaBLL().setMantenimientoNanNoc(listaObjSC);
        }
    }
}
