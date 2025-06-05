using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{ 
    public class MedicamentoBLL
    {
        public int setMantenimiento(SS_HC_Medicamento objSC)
        {
            return new MedicamentoRepository().setMantenimiento(objSC);
        }
        public List<SS_HC_Medicamento> MedicamentoListar(SS_HC_Medicamento ObjTrace)
        {
            return new MedicamentoRepository().MedicamentoListar(ObjTrace);
        }

        public int MedicamentoIndicaciones(SS_HC_Indicaciones objSC)
        {
            return new MedicamentoRepository().MedicamentoIndicaciones(objSC);
        }
        public List<SS_HC_Indicaciones> MedicamentoIndicacionesListar(SS_HC_Indicaciones ObjTrace)
        {
            return new MedicamentoRepository().MedicamentoIndicacionesListar(ObjTrace);
        }

        public int setMantenimiento(SS_HC_Medicamento ObjTraces, List<SS_HC_Medicamento> listaCabecera01,
            List<SS_HC_Medicamento> listaCabecera02, List<SS_HC_Indicaciones> listaTraceDetalle01, List<SS_HC_Indicaciones> listaDetalle01)
        {
            return new MedicamentoRepository().setMantenimiento(ObjTraces, listaCabecera01, listaCabecera02, listaTraceDetalle01, listaDetalle01);
        }
    }
}
