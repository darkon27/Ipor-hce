using SoluccionSalud.Bussines.BLLDiagnostico;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.DiagnosticoService
{
   public class SvcDiagnostico
   {
       public static List<SS_GE_Diagnostico> listarDiagnostico(SS_GE_Diagnostico objSC, int inicio, int final)
       {
           return new DiagnosticoBLL().listarDiagnostico(objSC, inicio, final);
       }

       public static int setMantenimiento(SS_GE_Diagnostico ObjTrace)
       {
           return new DiagnosticoBLL().setMantenimiento(ObjTrace);
       }
       public static List<SS_GE_Diagnostico> listarDiagnosticAccion(SS_GE_Diagnostico objSC, String accion)
       {
           if (objSC == null)
           {
               objSC = new SS_GE_Diagnostico();
           }
           objSC.Accion = accion;
           return new DiagnosticoBLL().listarDiagnostico(objSC,0,0);
       }
    }
}
