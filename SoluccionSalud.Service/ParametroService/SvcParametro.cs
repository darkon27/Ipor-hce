using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLParametro;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ParametroService
{
    public class SvcParametro
    {
        public static List<ParametrosMast> listarParametro(ParametrosMast objSC, int inicio, int final)
        {
            return new ParametroBLL().listarParametro(objSC, inicio, final);
        }

        public static List<ParametrosMast> listarParametroWServicio(ParametrosMast objSC, int inicio, int final)
        {
            return new ParametroBLL().listarParametroWServicio(objSC, inicio, final);
        }

        

        public static int setMantenimiento(ParametrosMast ObjTrace)
        {
            return new ParametroBLL().setMantenimiento(ObjTrace);
        }

        public static ParametrosMast getMantenimientoPoId(ParametrosMast ObjTrace)
        {
            return new ParametroBLL().getMantenimientoPoId(ObjTrace);
        }
    }
}
