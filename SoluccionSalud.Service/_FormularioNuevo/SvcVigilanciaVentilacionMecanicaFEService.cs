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
    public class SvcVigilanciaVentilacionMecanicaFEService
    {
        public static int setMantenimiento(SS_HC_ENFER_VIGI_VentilacionMecanica_FE ObjSave)
        {
            return new VigilanciaVentilacionMecanicaFERepository().setMantenimiento(ObjSave);
        }

        public static List<SS_HC_ENFER_VIGI_VentilacionMecanica_FE> listarSS_HC_ENFER_VIGI_VentilacionMecanica_FE(SS_HC_ENFER_VIGI_VentilacionMecanica_FE objSC)
        {
            return new VigilanciaVentilacionMecanicaFERepository().listarSS_HC_ENFER_VIGI_VentilacionMecanica_FE(objSC);
        }
    }
}
