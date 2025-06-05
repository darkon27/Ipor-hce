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
    public class SvcAntecedentesPersonalesINFEService
    {
        public static List<SS_HC_AntecedentesPersonalesIN_FE> listarEntidad(SS_HC_AntecedentesPersonalesIN_FE objSC)
        {
            return new AntecedentesPersonalesINFERepository().listarEntidad(objSC);
        }
        
        public static int setMantenimiento(SS_HC_AntecedentesPersonalesIN_FE objSave, List<SS_HC_AntecedentesPersonalesINDetalle_FE> ObjDetalle)
        {
            return new AntecedentesPersonalesINFERepository().setMantenimiento(objSave, ObjDetalle);
        }

        

    }
}
