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
    public class SvcMedicamentoFE
    {
        public static List<SS_HC_Medicamento_FE> MedicamentoListar(SS_HC_Medicamento_FE ObjTrace)
        {
            return new MedicamentoFERepository().MedicamentoListar(ObjTrace);
        }

        public static int setMantenimientoGrupo(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
        {
            return new MedicamentoFERepository().setMantenimientoGrupo(ObjTraces, listaCabecera01, listaCabecera02, listaTraceDetalle01, listaDetalle01);
        }

        public static int setMantenimientoMedicamentosAuditoria(int IndEvento, SS_HC_Medicamento_FE ObjTraces)
        {
            return new MedicamentoFERepository().setMantenimientoMedicamentosAuditoria(IndEvento,ObjTraces);
        }

        public static int setMantenimientoNotificaciones(int flat, List<SS_HC_Medicamento_FE> listaCabecera01, SS_FA_SolicitudProductoDetalle objEntity2)
        {
            return new MedicamentoFERepository().setMantenimientoNotificaciones(flat, listaCabecera01, objEntity2);
        }




        public static int setMantenimiento(SS_HC_Medicamento_FE objSC)
        {
            return new MedicamentoFERepository().setMantenimiento(objSC);
        }
        public static List<SS_HC_Medicamento_FE_Epi2> MedicamentoListarEPICRISIS(SS_HC_Medicamento_FE_Epi2 ObjTrace)
        {

            return new MedicamentoFERepository().MedicamentoListarEPICRISIS(ObjTrace);

        }

        public static List<SS_HC_Medicamento_FE_Epi2> MedicamentoListarEpicrisis(SS_HC_Medicamento_FE_Epi2 ObjTrace)
        {
            return new MedicamentoFERepository().MedicamentoListarEpicrisis(ObjTrace);
        }
        public static int MedicamentoIndicaciones(SS_HC_Indicaciones_FE objSC)
        {
            return new MedicamentoFERepository().MedicamentoIndicaciones(objSC);
        }
        public static List<SS_HC_Indicaciones_FE> MedicamentoIndicacionesListar(SS_HC_Indicaciones_FE ObjTrace)
        {
            return new MedicamentoFERepository().MedicamentoIndicacionesListar(ObjTrace);
        }
        public static int setMantenimientoNutriente(List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02)
        {
            return new MedicamentoFERepository().setMantenimientoNutriente(listaCabecera01, listaCabecera02);
        }

         public static int setMantenimientoGrupoCopia(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
        {
            return new MedicamentoFERepository().setMantenimientoGrupoCopia(ObjTraces, listaCabecera01, listaCabecera02, listaTraceDetalle01, listaDetalle01);
        }        

         public static int setMantenimientoEpi2(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
         {
             return new MedicamentoFERepository().setMantenimientoEpi2(ObjTraces, listaCabecera01, listaCabecera02, listaTraceDetalle01, listaDetalle01);
         }
    }
}
