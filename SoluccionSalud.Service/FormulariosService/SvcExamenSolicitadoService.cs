using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
     
    public class SvcExamenSolicitadoService
    {
        public static int setMantenimiento(SS_HC_ExamenSolicitado objSC)
        {
            return new ExamenSolicitadoBLL().setMantenimiento(objSC);
        }


        public static List<SS_HC_ExamenSolicitado> MedicamentoListar(SS_HC_ExamenSolicitado ObjTrace)
        {
            return new ExamenSolicitadoBLL().MedicamentoListar(ObjTrace);
        }

        public static int setMantenimiento(SS_HC_ExamenSolicitado objSC,List<SS_HC_ExamenSolicitado> listaDetalle)
        {
            return new ExamenSolicitadoBLL().setMantenimiento(objSC, listaDetalle);
        }
    }
}
