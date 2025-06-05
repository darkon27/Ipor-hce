using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSG_Agente;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSG_Agente
{
    public class SG_AgenteBLL
    {
        public List<SG_Agente> listarSG_Agente(SG_Agente objSC, int inicio, int final)
        {
            return new SG_AgenteRepository().listarSG_Agente(objSC, inicio, final);
        }

        public int setMantenimiento(SG_Agente ObjTrace)
        {
            return new SG_AgenteRepository().setMantenimiento(ObjTrace);
        }
    }
}
