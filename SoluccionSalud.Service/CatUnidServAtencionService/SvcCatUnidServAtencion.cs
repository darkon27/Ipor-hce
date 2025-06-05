using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Bussines.BLLCatUnidServAtencion;

namespace SoluccionSalud.Service.CatUnidServAtencionService
{
    public class SvcCatUnidServAtencion
    {
        public static List<SS_HC_CatalogoUnidadServicio_TipoAtencion> listarSysSeguridadAutorizaciones(SS_HC_CatalogoUnidadServicio_TipoAtencion objSC, int inicio, int final)
        {
            return new CatUnidServAtencionBLL().listarCatUnidServAtencion(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_HC_CatalogoUnidadServicio_TipoAtencion ObjTrace)
        {
            return new CatUnidServAtencionBLL().setMantenimiento(ObjTrace);
        }
    }
}
