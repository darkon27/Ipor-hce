using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCatUnidadServicio;

namespace SoluccionSalud.Bussines.BLLCategoriaUnidadServicio
{
    public class CatUnidadServicioBLL
    {
        public List<SS_HC_CatalogoUnidadServicio> listarCatUnidadServicio(SS_HC_CatalogoUnidadServicio objSC, int inicio, int final)
        {
            return new CatUnidadServicioRepository().listarCatUnidadServicio(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_CatalogoUnidadServicio ObjTrace)
        {
            return new CatUnidadServicioRepository().setMantenimiento(ObjTrace);
        }
    }
}
