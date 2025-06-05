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
    public class SvcAntecedentesPersonalesIAdulFEService
    {
        public static List<SS_HC_AntecedentesPersonalesIAdul_FE> listarEntidad(SS_HC_AntecedentesPersonalesIAdul_FE objSC)
        {
            return new AntecedentesPersonalesIAdulFERepository().listarEntidad(objSC);
        }

        public static List<SS_HC_AntecedentesPersonalesIAdulDetalle_FE> listarDetalle(SS_HC_AntecedentesPersonalesIAdulDetalle_FE objSC, int inicio, int final)
        {

            return new AntecedentesPersonalesIAdulFERepository().listarDetalle(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_AntecedentesPersonalesIAdul_FE objSave, List<SS_HC_AntecedentesPersonalesIAdulDetalle_FE> ObjDetalle)
        {
            return new AntecedentesPersonalesIAdulFERepository().setMantenimiento(objSave, ObjDetalle);
        }


    }
}
