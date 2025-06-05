using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
   public  class SvcExamenFisicoTriajeService
    {
       public static Int32 setMantenimiento(SS_HC_ExamenFisico_Triaje objSC)
        {
            return new ExamenFisicoTriajeBLL().setMantenimiento(objSC);
        }
       public static List<SS_HC_ExamenFisico_Triaje> ExamenFisicoTriajeListar(SS_HC_ExamenFisico_Triaje objSC)
       {
           return new ExamenFisicoTriajeBLL().ExamenFisicoTriajeListar(objSC);
       }
    }
}
