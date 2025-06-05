using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALDiagnosticoPAE;

namespace SoluccionSalud.Bussines.BLLDiagnosticoPAE
{
    public class DiagnosticoPAEBLL
    {
        public List<SS_HC_PAE_Diagnostico> listarDiagnosticoPAE(SS_HC_PAE_Diagnostico objSC, int inicio, int final)
        {
            return new DiagnosticoPAERepository().listarDiagnosticoPAE(objSC, inicio, final);
        }

        public int setMantenimientoDiagPAE(SS_HC_PAE_Diagnostico ObjTrace)
        {
            return new DiagnosticoPAERepository().setMantenimientoDiagPAE(ObjTrace);
        }


        public int setMantenimientoDiagPAE(SS_HC_PAE_Diagnostico ObjTraces, List<SS_HC_PAE_Diagnostico> listaCabecera,
           List<SS_HC_PAE_Diagnostico> listaDetalle)
        {
            return new DiagnosticoPAERepository().setMantenimientoDiagPAE(ObjTraces, listaCabecera, listaDetalle);
        }
    }
}
