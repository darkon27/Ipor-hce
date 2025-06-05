using SoluccionSalud.Bussines.BLLVw_Miscelaneo;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.Vw_MiscelaneoService
{
    public class SvcVw_Miscelaneo
    {
        public static List<vw_Miscelaneos> listarVw_Miscelaneos(vw_Miscelaneos objSC, int inicio, int final)
        {
            return new Vw_MiscelaneoBLL().listarVw_Miscelaneos(objSC, inicio, final);
        }

        public static int setMantenimiento(vw_Miscelaneos ObjTrace)
        {
            return new Vw_MiscelaneoBLL().setMantenimiento(ObjTrace);
        }
    }
}
