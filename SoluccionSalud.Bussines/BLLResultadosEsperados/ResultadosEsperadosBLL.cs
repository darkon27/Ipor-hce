using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALResultadosEsperados;

namespace SoluccionSalud.Bussines.BLLResultadosEsperados
{
    public class ResultadosEsperadosBLL
    {
        public List<SS_HC_NOC> listarResultadosEsperados(SS_HC_NOC objSC, int inicio, int final)
        {
            return new ResultadosEsperadosRepository().listarResultadosEsperados(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_NOC ObjTrace)
        {
            return new ResultadosEsperadosRepository().setMantenimiento(ObjTrace);
        }
    }
}
