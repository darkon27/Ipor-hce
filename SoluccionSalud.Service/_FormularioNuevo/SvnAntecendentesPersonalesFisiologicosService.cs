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
    public class SvnAntecendentesPersonalesFisiologicosService
    {
        public static List<SS_HC_AntecedentesPersonalesFisiologicos_FE> listarEntidad(SS_HC_AntecedentesPersonalesFisiologicos_FE objSC)
        {
            return new AntecedentesPersonalesFisiologicos_FERepository().listarEntidad(objSC);
        }
        public static int setMantenimiento(SS_HC_AntecedentesPersonalesFisiologicos_FE objSC)
        {
            return new AntecedentesPersonalesFisiologicos_FERepository().setMantenimiento(objSC);
        }
        public static List<SS_HC_AntecedentesPersonalesFisiologicos_FE> listarEntidadTOP(SS_HC_AntecedentesPersonalesFisiologicos_FE objSC)
        {
            return new AntecedentesPersonalesFisiologicos_FERepository().listarEntidadTOP(objSC);
        }
    }
}
