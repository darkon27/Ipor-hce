using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcFichaAnestesia5Service
    {
        public static int setMantenimiento(SS_HC_FichaAnestesia_5_FE objSC)
        {
            return new FichaAnestesia5FERepository().setMantenimiento(objSC);
        }
        public static List<SS_HC_FichaAnestesia_5_FE> listarEntidad(SS_HC_FichaAnestesia_5_FE objSC)
        {

            return new FichaAnestesia5FERepository().listarEntidad(objSC);
        }

    }
}

//Josue Murillo