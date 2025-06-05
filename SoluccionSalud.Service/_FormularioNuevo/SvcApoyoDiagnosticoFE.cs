using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using SoluccionSalud.Bussines;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcApoyoDiagnosticoFE
    {
        public static int setMantenimiento(SS_HC_ApoyoDiagnostico_FE objSC, List<SS_HC_ApoyoDiagnosticoDet_FE> Detalle )
        {
            return new ApoyoDiagnosticoFERepository().setMantenimiento(objSC, Detalle);
        }

        public static List<SS_HC_ApoyoDiagnostico_FE> ApoyoCabecera_Listar(SS_HC_ApoyoDiagnostico_FE objSC)
        {
            return new ApoyoDiagnosticoFERepository().ApoyoCabecera_Listar(objSC);
        }

        public static List<SS_HC_ApoyoDiagnosticoFile_FE> Archivos_Listar(SS_HC_ApoyoDiagnosticoFile_FE objSC)
        {
            return new ApoyoDiagnosticoFERepository().Archivos_Listar(objSC);
        }

        public static int setMantenimiento2(SS_HC_ApoyoDiagnostico_FE objSC, List<SS_HC_ApoyoDiagnosticoDet_FE> Detalle, List<SS_HC_ApoyoDiagnosticoFile_FE> Detalle2)
        {
            return new ApoyoDiagnosticoFERepository().setMantenimiento2(objSC, Detalle, Detalle2);
        }

       
    }
}
