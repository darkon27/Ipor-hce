using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALTABLAFORMATOVALIDACION;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLTABLAFORMATOVALIDACION
{
    public class VW_TABLAFORMATOVALIDACIONBLL
    {
        public List<VW_SS_HC_TABLAFORMATO_VALIDACION> listarVWTABLAFORMATOVALIDACION(VW_SS_HC_TABLAFORMATO_VALIDACION objSC, int inicio, int final)
        {
            return new VW_TABLAFORMATOVALIDACIONRepository().listarVWTABLAFORMATOVALIDACION(objSC, inicio, final);
        }

        public int setMantenimiento(VW_SS_HC_TABLAFORMATO_VALIDACION ObjTrace)
        {
            return new VW_TABLAFORMATOVALIDACIONRepository().setMantenimiento(ObjTrace);
        }
    }
}
