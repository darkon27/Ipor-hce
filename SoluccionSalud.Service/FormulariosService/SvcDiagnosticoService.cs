using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcDiagnosticoService
    {
        public static int setMantenimiento(SS_HC_Diagnostico objSC)
        {
            return new DiagnosticoBLL().setMantenimiento(objSC);
        }
        public static List<SS_HC_Diagnostico> DiagnosticoListar(SS_HC_Diagnostico objSC)
        {
            return new DiagnosticoBLL().DiagnosticoListar(objSC);
        }
        public static int setMantenimiento(SS_HC_Diagnostico ObjTraces, List<SS_HC_Diagnostico> listaCabecera,
                    List<SS_HC_Diagnostico> listaDetalle)
        {
            return new DiagnosticoBLL().setMantenimiento(ObjTraces, listaCabecera, listaDetalle);
        }

        public static SS_HC_Diagnostico obtenerPorId(SS_HC_Diagnostico objSC)
        {
            return new DiagnosticoBLL().obtenerPorId(objSC);
        }
        
    }


}
