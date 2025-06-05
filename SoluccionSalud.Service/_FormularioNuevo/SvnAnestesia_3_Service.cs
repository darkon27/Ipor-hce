using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvnAnestesia_3_Service
    {


        public static List<SS_HC_FichaAnestesia_3_FE> listarEntidad(SS_HC_FichaAnestesia_3_FE objSC)
        {

            return new Anestesia_3_FERepository().listarEntidad(objSC);
        }



        public static int setMantenimiento(SS_HC_FichaAnestesia_3_FE objSC)
        {
            return new Anestesia_3_FERepository().setMantenimiento(objSC);
        }




    }
}
