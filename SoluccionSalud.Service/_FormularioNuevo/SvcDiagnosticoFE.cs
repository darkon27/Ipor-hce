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
    public class SvcDiagnosticoFE
    {

        public static List<SS_HC_Diagnostico_FE> DiagnosticoListar(SS_HC_Diagnostico_FE objSC)
        {
            return new DiagnosticoFERepository().DiagnosticoListar(objSC);
        }
        public static int setMantenimiento(SS_HC_Diagnostico_FE ObjTraces, List<SS_HC_Diagnostico_FE> listaCabecera,
                    List<SS_HC_Diagnostico_FE> listaDetalle)
        {
            return new DiagnosticoFERepository().setMantenimiento(ObjTraces, listaCabecera, listaDetalle);
        }
        public static SS_HC_Diagnostico_FE obtenerPorId(SS_HC_Diagnostico_FE objSC)
        {
            return new DiagnosticoFERepository().obtenerPorId(objSC);
        }

        public static SS_HC_Epicrisis_3_Diagnostico obtenerPorIdALTA(SS_HC_Epicrisis_3_Diagnostico objSC)
        {
            return new DiagnosticoFERepository().obtenerPorIdALTA(objSC);
        }


        public static SS_HC_Epicrisis_3_Diag_Principal obtenerPorIdALTAEXAMEN(SS_HC_Epicrisis_3_Diag_Principal objSC)
        {
            return new DiagnosticoFERepository().obtenerPorIdALTAEXAMEN(objSC);
        }



    }
}
