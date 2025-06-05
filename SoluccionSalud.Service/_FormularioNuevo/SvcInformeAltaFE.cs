using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcInformeAltaFE
    {

        public static int setMantenimiento(SS_HC_InformeAlta_FE objSC, List<SS_HC_InformeAlta_Diagnostico_FE> detalle1, List<SS_HC_InformeAlta_Examen_FE> detalle2)
        {
            return (new InformeAltaFERepository().setMantenimiento(objSC, detalle1, detalle2));
        }
        
        public static int setMantenimientoMedicamentoAltaAuditoria(int IndEvento, SS_HC_MedicamentoAlta_FE ObjTrace)
        {
            return (new InformeAltaFERepository().setMantenimientoMedicamentoAltaAuditoria(IndEvento, ObjTrace));
        }

        public static int setMantenimientoMedicamento(SS_HC_InformeAlta_FE objSC, List<SS_HC_MedicamentoAlta_FE> detalle1, List<SS_HC_InformeAltaProxCita_FE> detalle2)
        {
            return (new InformeAltaFERepository().setMantenimientoMedicamento(objSC, detalle1, detalle2));
        }

        public static List<SS_HC_InformeAlta_FE> lista_Cabecera(SS_HC_InformeAlta_FE objSC)
        {
            return (new InformeAltaFERepository().Lista_Cabecera(objSC));
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
        public static List<SS_HC_InformeAltaDiagAlt_FE> Listar_DiagAlta(SS_HC_InformeAltaDiagAlt_FE detalle1)
        {
            return (new InformeAltaFERepository().Listar_DiagAlta(detalle1));

        }


        public static List<SS_HC_InformeAlta_Examen_FE> lista_Examen(SS_HC_InformeAlta_Examen_FE detalle2)
        {
            return (new InformeAltaFERepository().Lista_Examen(detalle2));
        }


    }
}
