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
    public class SvcInterConsultaFE
    {
        public static int setMantenimiento(SS_HC_InterConsulta_FE objSC, List<SS_HC_InterConsulta_FE> listaDetalle)
        {
            return new InterConsultaFERepository().setMantenimiento(objSC, listaDetalle);
        }

        public static List<SS_HC_InterConsulta_FE> InterConsultaListar(SS_HC_InterConsulta_FE objSC)
        {
            return new InterConsultaFERepository().InterConsultaListar(objSC);
        }

    }
}
