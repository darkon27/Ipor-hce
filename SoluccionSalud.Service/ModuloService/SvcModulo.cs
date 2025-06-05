using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLModulo;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ModuloService
{
    public class SvcModulo
    {
        public static List<SG_Modulo> listarModulos(SG_Modulo objSC, int inicio, int final)
        {
            return new ModuloBLL().listarModulos(objSC, inicio, final);
        }

        public static int setMantenimiento(SG_Modulo ObjTrace)
        {
            return new ModuloBLL().setMantenimiento(ObjTrace);
        }
    }
}
