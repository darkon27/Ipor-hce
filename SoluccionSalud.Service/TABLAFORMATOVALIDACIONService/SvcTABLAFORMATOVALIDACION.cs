using SoluccionSalud.Bussines.BLLTABLAFORMATOVALIDACION;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.TABLAFORMATOVALIDACIONService
{
    public class SvcTABLAFORMATOVALIDACION
    {
        public static List<VW_SS_HC_TABLAFORMATO_VALIDACION> listarVWTABLAFORMATOVALIDACION(VW_SS_HC_TABLAFORMATO_VALIDACION objSC, int inicio, int final)
        {
            return new VW_TABLAFORMATOVALIDACIONBLL().listarVWTABLAFORMATOVALIDACION(objSC, inicio, final);
        }
        public static int setMantenimiento(VW_SS_HC_TABLAFORMATO_VALIDACION ObjTrace)
        {
            return new VW_TABLAFORMATOVALIDACIONBLL().setMantenimiento(ObjTrace);
        }
    }
}
