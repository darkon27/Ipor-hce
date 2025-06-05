using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALWH_VALIDA;

namespace SoluccionSalud.Bussines.BLLWH_VALIDA
{
    public class WH_VALIDABLL
    {
        public List<SS_VW_VALIDA> listarSS_VW_VALIDA(SS_VW_VALIDA objSC, int inicio, int final)
        {
            return new WH_VALIDA().listarSS_VW_VALIDA(objSC, inicio, final);
        }

        public int setMantenimiento(SS_VW_VALIDA ObjTrace)
        {
            return new WH_VALIDA().setMantenimiento(ObjTrace);
        }
    }
}
