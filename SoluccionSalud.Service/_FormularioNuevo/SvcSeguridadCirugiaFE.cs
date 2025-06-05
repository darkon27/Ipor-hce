using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.RepositoryFormulario.DAL_Formularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service._FormularioNuevo
{
    public class SvcSeguridadCirugiaFE
    {
        public static int setMantenimiento(SS_HC_SeguridadCirugia_FE objSC)
        {
            return new SeguridadCirugiaFERepository().setMantenimiento(objSC);
        }
        public static List<SS_HC_SeguridadCirugia_FE> listarEntidad(SS_HC_SeguridadCirugia_FE objSC)
        {

            return new SeguridadCirugiaFERepository().listarEntidad(objSC);
        }

    }
}
