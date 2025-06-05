using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEpicrisis2Service
    {  
               public static int setMantenimiento(SS_HC_Epicrisis_2_FE objSC, List<SS_HC_Epicrisis_2_Detalle_FE> detalle0)
        {
            return (new Epicrisis2FERepository().setMantenimiento(objSC,detalle0));
        }


        public static List<SS_HC_Epicrisis_2_FE> lista_Cabecera(SS_HC_Epicrisis_2_FE objSC)
        {
            return (new Epicrisis2FERepository().Lista_Cabecera(objSC));
        }



       











        public static List<SS_HC_InformeAltaDiagIng_FE> Listar_DiagIngreso(SS_HC_InformeAltaDiagIng_FE detalle1)
        {
            return (new InformeAltaFERepository().Listar_DiagIngreso(detalle1));

        }
        public static List<SS_HC_Epicrisis_3_Diag_Principal> Listar_Epicrisis_3_Principal(SS_HC_Epicrisis_3_Diag_Principal detalle1)
        {
            return (new Epicrisis3FERepository().Listar_Epicrisis_3_Principal(detalle1));

        }

        public static List<SS_HC_Epicrisis_3_Diag_Secundaria> Listar_Epicrisis_3_Secundario(SS_HC_Epicrisis_3_Diag_Secundaria detalle1)
        {
            return (new Epicrisis3FERepository().Listar_Epicrisis_3_Secundario(detalle1));

        }



        public static List<SS_HC_InformeAlta_Examen_FE> lista_Examen(SS_HC_InformeAlta_Examen_FE detalle2)
        {
            return (new InformeAltaFERepository().Lista_Examen(detalle2));
        }


    }
}
