using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvnAnestesia_1_Service
    {

        public static int setMantenimiento(SS_HC_FichaAnestesia_1_FE ObjTraces , List<SS_HC_AnestesiaExamenApoyoDetalle_FE> ExamenDetalle1 ,
            List<SS_HC_AnestesiaDiagnosticoDetalle_FE> DiagnosticoDetalle2, List<SS_HC_AnestesiaExamenApoyoDetalle_FE> ObjDetalle3, List<SS_HC_AnestesiaExamenApoyoDetalle_FE> ObjDetalle4, List<SS_HC_AnestesiaDiagnosticoDetalle_FE> ObjDetalle5
            
         )
        {
            return new Anestesia_1_FERepository().setMantenimiento(ObjTraces, ExamenDetalle1, DiagnosticoDetalle2, ObjDetalle3, ObjDetalle4, ObjDetalle5);
        }


        public static List<SS_HC_FichaAnestesia_1_FE> listarEntidad(SS_HC_FichaAnestesia_1_FE objSC)
        {
            return new Anestesia_1_FERepository().listarEntidad(objSC);
        }


    }
}
