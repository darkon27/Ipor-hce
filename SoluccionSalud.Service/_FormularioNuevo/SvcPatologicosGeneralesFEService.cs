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
    public class SvcPatologicosGeneralesFEService
        
    {
        public static List<SS_HC_Anam_AP_PatologicosGenerales_FE> listarEntidad(SS_HC_Anam_AP_PatologicosGenerales_FE objSC)
        {
            return new Anam_AP_PatologicosGeneralesFERepository().listarEntidad(objSC);

        }

        public static List<SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE> listarDetalle(SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE objSC, int inicio, int final)
        {

            return new Anam_AP_PatologicosGeneralesFERepository().listarDetalle(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_Anam_AP_PatologicosGenerales_FE objSave, List<SS_HC_Anam_AP_PatologicosGeneralesDetalle_FE> ObjDetalle)
        {
            return new Anam_AP_PatologicosGeneralesFERepository().setMantenimiento(objSave, ObjDetalle);
        }


    }
}
