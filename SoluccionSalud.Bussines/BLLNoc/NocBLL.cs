using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALNOC;

namespace SoluccionSalud.Bussines.BLLNoc
{
    public class NocBLL
    {
        public List<SS_HC_NOC2> listarNoc(SS_HC_NOC2 objSC, int inicio, int final)
        {
            return new NocRepository().listarNoc(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_NOC2 ObjTrace)
        {
            return new NocRepository().setMantenimiento(ObjTrace);
        }
    }
}
