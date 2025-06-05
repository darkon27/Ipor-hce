using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcMedicamentoService
    {
        public static int setMantenimiento(SS_HC_Medicamento objSC)
        {
            return new MedicamentoBLL().setMantenimiento(objSC);
        }

        public static List<SS_HC_Medicamento> MedicamentoListar(SS_HC_Medicamento ObjTrace)
        {
            return new MedicamentoBLL().MedicamentoListar(ObjTrace);
        }
        public static int MedicamentoIndicaciones(SS_HC_Indicaciones objSC)
        {
            return new MedicamentoBLL().MedicamentoIndicaciones(objSC);
        }
        public static List<SS_HC_Indicaciones> MedicamentoIndicacionesListar(SS_HC_Indicaciones ObjTrace)
        {
            return new MedicamentoBLL().MedicamentoIndicacionesListar(ObjTrace);
        }

        public static int setMantenimiento(SS_HC_Medicamento ObjTraces, List<SS_HC_Medicamento> listaCabecera01,
            List<SS_HC_Medicamento> listaCabecera02, List<SS_HC_Indicaciones> listaTraceDetalle01, List<SS_HC_Indicaciones> listaDetalle01)
        {
            return new MedicamentoBLL().setMantenimiento(ObjTraces, listaCabecera01, listaCabecera02, listaTraceDetalle01, listaDetalle01);
        }
    }
}
