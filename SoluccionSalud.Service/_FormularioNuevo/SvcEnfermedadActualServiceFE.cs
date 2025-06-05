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
    public class SvcEnfermedadActualServiceFE
    {

        public static int setMantenimiento(SS_HC_EnfermedadActual_FE objSC, List<SS_HC_EnfermedadActualDetalle_FE> Detalle)
        {
            return new EnfermedadActualFERepository().setMantenimiento(objSC, Detalle);
        }

        public static int setMantenimientoCopia(SS_HC_EnfermedadActual_FE objSC, List<SS_HC_EnfermedadActualDetalle_FE> Detalle)
        {
            return new EnfermedadActualFERepository().setMantenimientoCopia(objSC, Detalle);
        }
        
        public static List<SS_HC_EnfermedadActual_FE> ApoyoCabecera_Listar(SS_HC_EnfermedadActual_FE objSC)
        {
            return new EnfermedadActualFERepository().Apoyo_Listar(objSC);
        }


    }
}
