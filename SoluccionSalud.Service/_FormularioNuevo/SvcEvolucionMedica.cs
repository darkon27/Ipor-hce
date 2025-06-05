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
    public class SvcEvolucionMedicaFE
    {


        public static List<SS_HC_EvolucionMedica_FE> EvolucionMedicaListar(SS_HC_EvolucionMedica_FE objSC)
        {
            return new EvolucionMedicaFERepository().listarEvolucion(objSC);
        }

    }
}
