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

    public class SvcExamenSolicitadoServiceFE
    {

        public static int setMantenimiento(SS_HC_ExamenSolicitadoFE objSC, List<SS_HC_ExamenSolicitadoFE> listaDetalle, List<SS_HC_DescansoMedico_FE> listaDetalle2)
        {
            return new ExamenSolicitadoFERepository().setMantenimiento(objSC, listaDetalle, listaDetalle2);
        }

        public static List<SS_HC_ExamenSolicitadoFE> Examen_Listar(SS_HC_ExamenSolicitadoFE ObjTrace)
        {
            return new ExamenSolicitadoFERepository().Examen_Listar(ObjTrace);
        }
        public static SS_HC_ExamenSolicitadoDet_FE ExamenSol_Listar(SS_HC_ExamenSolicitadoDet_FE ObjTrace)
        {
            return new ExamenSolicitadoFERepository().ExamenSol_Listar(ObjTrace);
        }

    }
}
