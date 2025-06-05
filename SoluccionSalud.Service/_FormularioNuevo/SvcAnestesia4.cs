using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcAnestesia4
    {
        public static List<SS_HC_Anestesia_Farmaco_FE> lista_Cabecera(SS_HC_Anestesia_Farmaco_FE objSC)
        {
            return (new Anestesia4FERepository().Lista_Cabecera(objSC));
        }
        public static List<SS_HC_Anestesia_Farmacos_Detalle_FE> Listar_Soluciones(SS_HC_Anestesia_Farmacos_Detalle_FE detalle1)
        {
            return (new Anestesia4FERepository().Listar_Soluciones(detalle1));

        }

        public static int setMantenimiento(SS_HC_Anestesia_Farmaco_FE objSC, List<SS_HC_Anestesia_Farmacos_Detalle_FE> detalle1)
        {
            return (new Anestesia4FERepository().setMantenimiento(objSC, detalle1));
        }
    }
}