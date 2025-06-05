using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNocNic;


namespace SoluccionSalud.Bussines.BLLNocNic
{
    public class NocNicBLL
    {
        public List<SS_HC_NocNic> listarNocNic(SS_HC_NocNic objSC, int inicio, int final)
        {
            return new NocNicRepository().listarNocNic(objSC, inicio, final);
        }

        public int setMantenimientoNocNic(SS_HC_NocNic ObjTrace)
        {
            return new NocNicRepository().setMantenimientoNocNic(ObjTrace);
        }

        public int setMantenimientoNocNic(List<SS_HC_NocNic> listaObjSC)
        {
            return new NocNicRepository().setMantenimientoNocNic(listaObjSC);
        }
    }
}
