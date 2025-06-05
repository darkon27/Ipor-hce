using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcPartograma
    {
        public static List<SS_HC_Partograma_FE> Listar(SS_HC_Partograma_FE detalle1)
        {
            return (new PartogramaFERepository().Listar(detalle1));

        }

        public static List<SS_HC_Partograma_FE> Listar_graficos(SS_HC_Partograma_FE detalle1)
        {
            return (new PartogramaFERepository().Listar_graficos(detalle1));

        }
        public static List<SS_HC_PartogramaDetalle_FE> Listar_Medicamento(SS_HC_PartogramaDetalle_FE detalle1)
        {
            return (new PartogramaFERepository().Listar_Medicamento(detalle1));

        }

        public static int setMantenimiento(SS_HC_Partograma_FE objSC, List<SS_HC_PartogramaDetalle_FE> detalle1)
        {
            return (new PartogramaFERepository().setMantenimiento(objSC, detalle1));
        }
    }
}
