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
    public class SvcEpicrisis1_FEService
    {
        //public static int setMantenimiento(SS_HC_Epicrisis_1_FE ObjTraces, List<SS_HC_Epicrisis_1_Detalle_FE> ObjDetalle)
        //{
        //    return new Epicrisis_1_FERepository().setMantenimiento(ObjTraces, ObjDetalle);
        //}
        public static int setMantenimiento(SS_HC_Epicrisis_1_FE objSC, List<SS_HC_Epicrisis_3_Diagnostico> detalle0, List<SS_HC_Epicrisis_3_Diag_Principal> detalle1, List<SS_HC_Epicrisis_3_Diag_Secundaria> detalle2, List<SS_HC_InterConsulta_Epricrisis3_FE> detalle3)
        {
            return (new Epicrisis_1_FERepository().setMantenimiento(objSC, detalle0, detalle1,detalle2, detalle3));
        }

        public static int setMantenimientoCabecera(SS_HC_Referencia_FE ObjTraces)
        {
            return new Referencia_FERepository().setMantenimientoCabecera(ObjTraces);
        }
        public static List<SS_HC_Epicrisis_1_FE> listarEntidad(SS_HC_Epicrisis_1_FE objSC)
        {
            return new Epicrisis_1_FERepository().listarEntidad(objSC);
        }
    }
}
