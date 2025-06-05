using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALCatUnidServAtencion;

namespace SoluccionSalud.Bussines.BLLCatUnidServAtencion
{
    public class CatUnidServAtencionBLL
    {
        public List<SS_HC_CatalogoUnidadServicio_TipoAtencion> listarCatUnidServAtencion(SS_HC_CatalogoUnidadServicio_TipoAtencion objSC, int inicio, int final)
        {
            return new CatUnidServAtencionRepository().listarCatUnidServAtencion(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_CatalogoUnidadServicio_TipoAtencion ObjTrace)
        {
            return new CatUnidServAtencionRepository().setMantenimiento(ObjTrace);
        }
    }
}