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

    public class SvcKardex3FEService
    {

        public static int setMantenimiento(List<SS_HC_Examen_Kardex_FE> listaDetalle, List<SS_HC_InterConsulta_Kardex_FE> listaDetalle1)
        {
            return new Kardex3FERepository().setMantenimiento(listaDetalle, listaDetalle1);
        }



    }
}

