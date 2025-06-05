using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALIndicador;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLIndicador
{
    public class IndicadorBLL
    {
        public List<SS_HC_IndicadorPAE> listarindicador(SS_HC_IndicadorPAE objSC, int inicio, int final)
        {
            return new indicadorRepository().listarindicador(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_IndicadorPAE ObjTrace)
        {
            return new indicadorRepository().setMantenimiento(ObjTrace);
        }
    }
}
