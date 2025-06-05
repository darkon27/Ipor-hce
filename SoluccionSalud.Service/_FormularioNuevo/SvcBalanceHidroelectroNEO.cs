using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
   public class SvcBalanceHidroelectroNEO
    {
       public static List<SS_HC_BalanceHidroElectNeo_FE> lista_Cabecera(SS_HC_BalanceHidroElectNeo_FE objSC)
       {
           return (new BalanceHidroelectroNEOFERepository().Lista_Cabecera(objSC));
       }
        public static List<SS_HC_SolucionesAdministradas_FE> Listar_Soluciones(SS_HC_SolucionesAdministradas_FE detalle1)
        {
            return (new BalanceHidroelectroNEOFERepository().Listar_Soluciones(detalle1));

        }

        public static int setMantenimiento(SS_HC_BalanceHidroElectNeo_FE objSC, List<SS_HC_SolucionesAdministradas_FE> detalle1)
        {
            return (new BalanceHidroelectroNEOFERepository().setMantenimiento(objSC, detalle1));
        }
    }
}
