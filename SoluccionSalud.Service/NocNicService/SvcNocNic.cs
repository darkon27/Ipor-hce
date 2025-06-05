using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLNocNic;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.NocNicService
{
    public class SvcNocNic
    {
        public static List<SS_HC_NocNic> listarNocNic(SS_HC_NocNic objSC, int inicio, int final)
        {
            return new NocNicBLL().listarNocNic(objSC, inicio, final);
        }

        public static int setMantenimientoNocNic(SS_HC_NocNic ObjTrace)
        {
            return new NocNicBLL().setMantenimientoNocNic(ObjTrace);
        }

        public static int setMantenimientoNocNic(List<SS_HC_NocNic> listaObjSC)
        {
            return new NocNicBLL().setMantenimientoNocNic(listaObjSC);
        }


    }
}
