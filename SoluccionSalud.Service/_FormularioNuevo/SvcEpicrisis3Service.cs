using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcEpicrisis3Service
    {

        public static int setMantenimiento(SS_HC_Epicrisis_3 objSC, List<SS_HC_Epicrisis_3_Diagnostico> detalle0, List<SS_HC_Epicrisis_3_Diag_Principal> detalle1, List<SS_HC_Epicrisis_3_Diag_Secundaria> detalle2, List<SS_HC_Medicamento_FE_Epi2> detalle3)
        {
            return (new Epicrisis3FERepository().setMantenimiento(objSC, detalle0, detalle1, detalle2, detalle3));
        }

        public static int setMantenimientoMedicamento(SS_HC_InformeAlta_FE objSC, List<SS_HC_MedicamentoAlta_FE> detalle1, List<SS_HC_InformeAltaProxCita_FE> detalle2)
        {
            return (new InformeAltaFERepository().setMantenimientoMedicamento(objSC, detalle1, detalle2));
        }

        public static List<SS_HC_Epicrisis_3> lista_Cabecera(SS_HC_Epicrisis_3 objSC)
        {
            return (new Epicrisis3FERepository().Lista_Cabecera(objSC));
        }


        public static List<SS_HC_InformeAlta_Diagnostico_FE> lista_diagnostico(SS_HC_InformeAlta_Diagnostico_FE detalle1)
        {
            return (new InformeAltaFERepository().Lista_Diagnostico(detalle1));

        }

        public static List<SS_HC_InformeAltaAPD_FE> Listar_Examenes(SS_HC_InformeAltaAPD_FE detalle1)
        {
            return (new InformeAltaFERepository().Listar_Examenes(detalle1));

        }

        public static List<SS_HC_MedicamentoAlta_FE> MedicamentoListar(SS_HC_MedicamentoAlta_FE ObjTrace)
        {
            return new InformeAltaFERepository().MedicamentoListar(ObjTrace);
        }
        public static List<SS_HC_InformeAltaProxCita_FE> ProximaCitaListar(SS_HC_InformeAltaProxCita_FE ObjTrace)
        {
            return new InformeAltaFERepository().ProximaCitaListar(ObjTrace);
        }


        public static int setMantenimientoGrupo(SS_HC_InformeAlta_FE ObjTraces, List<SS_HC_InformeAltaDiagIng_FE> listaCabecera01, List<SS_HC_InformeAltaDiagAlt_FE> listaCabecera02, List<SS_HC_InformeAltaAPD_FE> listaCabecera03)
        {
            return new InformeAltaFERepository().setMantenimientoGrupo(ObjTraces, listaCabecera01, listaCabecera02, listaCabecera03);
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
