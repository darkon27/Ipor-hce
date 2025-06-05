using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLCategoriaUnidadServicio;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.CategoriaUnidadServicioService
{
    public class SvcCategoriaUnidadServicio
    {
        public static List<SS_HC_CatalogoUnidadServicio> listarCatUnidadServicio(SS_HC_CatalogoUnidadServicio objSC, int inicio, int final)
        {
            return new CatUnidadServicioBLL().listarCatUnidadServicio(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_CatalogoUnidadServicio ObjTrace)
        {
            return new CatUnidadServicioBLL().setMantenimiento(ObjTrace);
        }
    }
}
