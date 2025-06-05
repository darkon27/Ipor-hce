using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLDiagnosticoPAE;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.PAEDiagnostico
{
    public class SvcDiagnosticoPAE
    {

        public static List<SS_HC_PAE_Diagnostico> listarDiagnosticoPAE(SS_HC_PAE_Diagnostico objSC, int inicio, int final)
        {
            return new DiagnosticoPAEBLL().listarDiagnosticoPAE(objSC, inicio, final);
        }

        public static int setMantenimientoDiagPAE(SS_HC_PAE_Diagnostico ObjTrace)
        {
            return new DiagnosticoPAEBLL().setMantenimientoDiagPAE(ObjTrace);
        }

        public static int setMantenimientoDiagPAE(SS_HC_PAE_Diagnostico ObjTraces, List<SS_HC_PAE_Diagnostico> listaCabecera,
                   List<SS_HC_PAE_Diagnostico> listaDetalle)
        {
            return new DiagnosticoPAEBLL().setMantenimientoDiagPAE(ObjTraces, listaCabecera, listaDetalle);
        }

    }
}
