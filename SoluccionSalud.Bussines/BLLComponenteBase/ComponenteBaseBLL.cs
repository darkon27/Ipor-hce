using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALComponenteBase;

namespace SoluccionSalud.Bussines.BLLComponenteBase
{
    public class ComponenteBaseBLL
    {
        public List<CM_CO_ListaBaseComponente> listarCM_CO_ListaBaseComponente(CM_CO_ListaBaseComponente objSC, int inicio, int final)
        {
            return new ComponenteBaseRepository().listarCM_CO_ListaBaseComponente(objSC, inicio, final);
        }

        public int setMantenimiento(CM_CO_ListaBaseComponente ObjTrace)
        {
            return new ComponenteBaseRepository().setMantenimiento(ObjTrace);
        }
    }
}
