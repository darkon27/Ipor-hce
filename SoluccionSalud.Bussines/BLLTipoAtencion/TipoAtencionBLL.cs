using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALTipoAtencion;

namespace SoluccionSalud.Bussines.BLLTipoAtencion
{
    public class TipoAtencionBLL
    {        public List<SS_GE_TipoAtencion> listarTipoAtencion(SS_GE_TipoAtencion objSC, int inicio, int final)
        {
            return new TipoAtencionBaseRepository().listarTipoAtencion(objSC, inicio, final);
        }

        public int setMantenimiento(SS_GE_TipoAtencion ObjTrace)
        {
            return new TipoAtencionBaseRepository().setMantenimiento(ObjTrace);
        }
    }
}
