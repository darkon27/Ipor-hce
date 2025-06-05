using SoluccionSalud.Bussines.BLLSG_Agente;
using SoluccionSalud.Entidades.Entidades;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SG_AgenteService
{
    public class SvcSG_Agente
    {
        public static List<SG_Agente> listarSG_Agente(SG_Agente objSC, int inicio, int final)
        {
            return new SG_AgenteBLL().listarSG_Agente(objSC, inicio, final);
        }

        public static int setMantenimiento(SG_Agente ObjTrace)
        {
            return new SG_AgenteBLL().setMantenimiento(ObjTrace);
        }

        public static List<SG_Agente> listarSG_AgenteAccion(SG_Agente objSC, String accion)
        {
            if (objSC == null)
            {
                objSC = new SG_Agente();
            }
            objSC.ACCION = accion;
            return new SG_AgenteBLL().listarSG_Agente(objSC,0,0);
        }
    }
}
