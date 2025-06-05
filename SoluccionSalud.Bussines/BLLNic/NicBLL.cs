using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNIC;

namespace SoluccionSalud.Bussines.BLLNic
{
    public class NicBLL
    {
        public List<SS_HC_NIC> listarNic(SS_HC_NIC objSC, int inicio, int final)
        {
            return new NicRepository().listarNic(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_NIC ObjTrace)
        {
            return new NicRepository().setMantenimiento(ObjTrace);
        }
    }
}
