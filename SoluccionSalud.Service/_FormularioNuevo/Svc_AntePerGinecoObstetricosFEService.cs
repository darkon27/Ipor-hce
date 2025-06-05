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
    public class Svc_AntePerGinecoObstetricosFEService
    {
        public static List<SS_HC_AntePerGinecoObstetricos_FE> listarEntidad(SS_HC_AntePerGinecoObstetricos_FE objSC)
        {
            return new AntePerGinecoObstetricosFERepository().listarEntidad(objSC);
        }

        public static List<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE> listarCatalogoDetalle(SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE objSC, int inicio, int final)
        {

            return new AntePerGinecoObstetricosFERepository().listarCatalogoDetalle(objSC, inicio, final);
        }
        public static int setMantenimiento(SS_HC_AntePerGinecoObstetricos_FE ObjTraces, List<SS_HC_AntePerGinecoObstetricosCatalogoCirugia_FE> ObjDetalle, List<SS_HC_GINECOOBSTETRICOS_Diagnostico_FE> ObjDetalleDos)
        {
            return new AntePerGinecoObstetricosFERepository().setMantenimiento(ObjTraces, ObjDetalle, ObjDetalleDos);
        }
    }
}
