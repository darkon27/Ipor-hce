using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALUnidad;

namespace SoluccionSalud.Bussines.BLLUnidad
{
    public class UnidadBLL
    {        
        public List<UnidadesMast> listarUnidad(UnidadesMast objSC, int inicio, int final)
        {
            return new UnidadRepository().listarUnidad(objSC, inicio, final);
        }

        public int setMantenimiento(UnidadesMast ObjTrace)
        {
            return new UnidadRepository().setMantenimiento(ObjTrace);
        }
    }
}
