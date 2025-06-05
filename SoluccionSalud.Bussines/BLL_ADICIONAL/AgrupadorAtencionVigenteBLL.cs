using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DAL_ADICIONAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLL_ADICIONAL
{
    public class AgrupadorAtencionVigenteBLL
    {
        public List<SS_HC_AgrupadorAtencionVigente> listarSS_HC_AgrupadorAtencionVigente(SS_HC_AgrupadorAtencionVigente objSC, int inicio, int final)
        {
            return new AgrupadorAtencionVigenteRepository().listarSS_HC_AgrupadorAtencionVigente(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_AgrupadorAtencionVigente ObjTrace)
        {
            return new AgrupadorAtencionVigenteRepository().setMantenimiento(ObjTrace);
        }

        public int setMantenimiento(List<SS_HC_AgrupadorAtencionVigente> listaObjSC)
        {
            return new AgrupadorAtencionVigenteRepository().setMantenimiento(listaObjSC);
        }
    }
}
