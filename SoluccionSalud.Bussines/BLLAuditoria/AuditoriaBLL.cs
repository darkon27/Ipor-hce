using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALAuditoria;

namespace SoluccionSalud.Bussines.BLLAuditoria
{
    public class AuditoriaBLL
    {
        public List<SS_HC_AuditRoyal> listarAuditoRoyal(SS_HC_AuditRoyal objSC, int inicio, int final)
        {
            return new AuditoriaRepository().listarAuditoRoyal(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_AuditRoyal ObjTrace)
        {
            return new AuditoriaRepository().setMantenimiento(ObjTrace);
        }
    }
}
