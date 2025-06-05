
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSS_HC_CuerpoHumano;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSS_HC_CuerpoHumano
{
    public class SS_HC_CuerpoHumanoBLL
    {
        public List<SS_HC_CuerpoHumano> listarSSHCCuerpoHumano(SS_HC_CuerpoHumano objSC)
        {
            return new SS_HC_CuerpoHumanoRepository().listarSSHCCuerpoHumano(objSC);
        }

        public int setMantenimiento(SS_HC_CuerpoHumano ObjTrace)
        {
            return new SS_HC_CuerpoHumanoRepository().setMantenimiento(ObjTrace);
        }
    }
}
