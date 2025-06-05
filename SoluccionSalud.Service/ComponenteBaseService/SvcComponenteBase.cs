using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLComponenteBase;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.ComponenteBaseService
{
    public class SvcComponenteBase
    {
        public static List<CM_CO_ListaBaseComponente> listarCM_CO_ListaBaseComponente(CM_CO_ListaBaseComponente objSC, int inicio, int final)
        {
            return new ComponenteBaseBLL().listarCM_CO_ListaBaseComponente(objSC, inicio, final);
        }
        public static int setMantenimiento(CM_CO_ListaBaseComponente ObjTrace)
        {
            return new ComponenteBaseBLL().setMantenimiento(ObjTrace);
        }
    }
}
