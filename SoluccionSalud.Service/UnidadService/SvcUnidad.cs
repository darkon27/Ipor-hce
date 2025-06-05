using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLUnidad;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.UnidadService
{
    public class SvcUnidad
    {
        public static List<UnidadesMast> listarUnidad(UnidadesMast objSC, int inicio, int final)
        {
            return new UnidadBLL().listarUnidad(objSC, inicio, final);
        }

        public static int setMantenimiento(UnidadesMast ObjTrace)
        {
            return new UnidadBLL().setMantenimiento(ObjTrace);
        }
    }
}
