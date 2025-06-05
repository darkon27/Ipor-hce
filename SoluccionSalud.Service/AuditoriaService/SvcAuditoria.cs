using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLAuditoria;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.AuditoriaService
{
    public class SvcAuditoria
    {
        public static List<SS_HC_AuditRoyal> listarAuditoRoyal(SS_HC_AuditRoyal objSC, int inicio, int final)
        {
            return new AuditoriaBLL().listarAuditoRoyal(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_AuditRoyal ObjTrace)
        {
            return new AuditoriaBLL().setMantenimiento(ObjTrace);
        }
    }
}
