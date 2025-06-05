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
    public class SvcInmunizacionesNinioDetalle
    {
        public static List<SS_HC_AntecedentesPersonalesINDetalle_FE> listarDetalle(SS_HC_AntecedentesPersonalesINDetalle_FE objSC, int inicio, int final)
        {

            return new InmunizacionesNinioDetalleRepository().listarDetalle(objSC, inicio, final);
        }
        
    }
}
