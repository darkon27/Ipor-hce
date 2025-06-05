using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALUnidadServicio;

namespace SoluccionSalud.Bussines.BLLUnidadServicio
{
    public class UnidadServicioBLL
    {
        public List<SS_HC_UnidadServicio> listarUnidadServicio(SS_HC_UnidadServicio objSC, int inicio, int final)
        {
            return new UnidadServicioRepository().listarUnidadServicio(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_UnidadServicio ObjTrace)
        {
            return new UnidadServicioRepository().setMantenimiento(ObjTrace);
        }
    }
}
