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
    public class SvcMedicamentoKardex
    {


        public static int setEliminarMedicamentoKardekProgramdos(SS_HC_Medicamento_Kardex objSC)
        {
            return new MedicamentoKardexRepository().setEliminarMedicamentoKardekProgramdos(objSC);
        }


        public static int setMantenimiento(List<SS_HC_Medicamento_Kardex> objSC)
        {
            return new MedicamentoKardexRepository().setMantenimiento(objSC);
        }

        public static int setMantenimientoMedicamento(List<SS_HC_Kardex1_FE> obj, List<SS_HC_Medicamento_Kardex_FE> objSC)
        {
            return new MedicamentoKardexRepository().setMantenimientoMedicamento(obj, objSC);
        }

        public static int setMantMedicamentoSinCabezeraFE(List<SS_HC_Medicamento_Kardex_FE> objSC)
        {
            return new MedicamentoKardexRepository().setMantMedicamentoSinCabezeraFE(objSC);
        }



        public static List<SS_HC_Medicamento_Kardex> listarProgramacionKardex(SS_HC_Medicamento_Kardex objSC)
        {
            return new MedicamentoKardexRepository().listarProgramacionKardex(objSC);
        }


        public static List<SS_HC_Kardex1_FE> ListarKardex1(SS_HC_Kardex1_FE objSC)
        {
            return new MedicamentoKardexRepository().ListarKardex1(objSC);
        }


        //public static List<SS_HC_Medicamento_FE> MedicamentoListar(SS_HC_Medicamento_FE ObjTrace)
        //{
        //    return new MedicamentoFERepository().MedicamentoListar(ObjTrace);
        //}
        //public static int MedicamentoIndicaciones(SS_HC_Indicaciones_FE objSC)
        //{
        //    return new MedicamentoFERepository().MedicamentoIndicaciones(objSC);
        //}
        //public static List<SS_HC_Indicaciones_FE> MedicamentoIndicacionesListar(SS_HC_Indicaciones_FE ObjTrace)
        //{
        //    return new MedicamentoFERepository().MedicamentoIndicacionesListar(ObjTrace);
        //}
        //public static int setMantenimientoNutriente(List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02)
        //{
        //    return new MedicamentoFERepository().setMantenimientoNutriente(listaCabecera01, listaCabecera02);
        //}
        // public static int setMantenimientoGrupo(SS_HC_Medicamento_FE ObjTraces, List<SS_HC_Medicamento_FE> listaCabecera01, List<SS_HC_Medicamento_FE> listaCabecera02, List<SS_HC_Indicaciones_FE> listaTraceDetalle01, List<SS_HC_Indicaciones_FE> listaDetalle01)
        //{
        //    return new MedicamentoFERepository().setMantenimientoGrupo(ObjTraces, listaCabecera01, listaCabecera02, listaTraceDetalle01, listaDetalle01);
        //}
    }
}
