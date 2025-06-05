using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcBalanceHidroelectro
    {
        public static List<SS_HC_BalanceHidroElect_FE> lista_Cabecera(SS_HC_BalanceHidroElect_FE objSC)
        {
            return (new BalanceHidroelectroFERepository().Lista_Cabecera(objSC));
        }
        public static List<SS_HC_BalanceHidroElectDetalle_FE> Listar_Soluciones(SS_HC_BalanceHidroElectDetalle_FE detalle1)
        {
            return (new BalanceHidroelectroFERepository().Listar_Soluciones(detalle1));

        }

        public static int setMantenimiento(SS_HC_BalanceHidroElect_FE objSC, List<SS_HC_BalanceHidroElectDetalle_FE> detalle1)
        {
            return (new BalanceHidroelectroFERepository().setMantenimiento(objSC, detalle1));
        }
    }
}