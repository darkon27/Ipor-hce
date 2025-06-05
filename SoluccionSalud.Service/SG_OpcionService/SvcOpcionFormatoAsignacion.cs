using System;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Bussines.BLLSG_Opcion;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SG_OpcionService
{
    public class SvcOpcionFormatoAsignacion
    {
        public static List<SS_HC_FormatoAsignacion> listarSS_HC_FormatoAsignacion(SS_HC_FormatoAsignacion objSC, int inicio, int final)
        {
            return new OpcionFormatoAsignacionBLL().listarSS_HC_FormatoAsignacion(objSC, inicio, final);
        }

        public static List<SS_HC_FormatoCodigoId> listarSS_HC_FormatoCodigoId(SS_HC_FormatoCodigoId objSC, int inicio, int final)
        {
            return new OpcionFormatoAsignacionBLL().listarSS_HC_FormatoCodigoId(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_HC_FormatoAsignacion ObjTrace, List<SS_HC_FormatoCodigoId> detalle)
        {
            return new OpcionFormatoAsignacionBLL().setMantenimiento(ObjTrace, detalle);
        }
    }
}
