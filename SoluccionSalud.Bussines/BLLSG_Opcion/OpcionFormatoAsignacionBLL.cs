using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSG_Opcion;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Bussines.BLLSG_Opcion
{
    public class OpcionFormatoAsignacionBLL
    {
        public List<SS_HC_FormatoAsignacion> listarSS_HC_FormatoAsignacion(SS_HC_FormatoAsignacion objSC, int inicio, int final)
        {
            return new OpcionFormatoAsignacionRepository().listarSS_HC_FormatoAsignacion(objSC, inicio, final);
        }

        public List<SS_HC_FormatoCodigoId> listarSS_HC_FormatoCodigoId(SS_HC_FormatoCodigoId objSC, int inicio, int final)
        {
            return new OpcionFormatoAsignacionRepository().listarSS_HC_FormatoCodigoId(objSC, inicio, final);
        }

        public int setMantenimiento(SS_HC_FormatoAsignacion ObjTrace, List<SS_HC_FormatoCodigoId> detalle)
        {
            return new OpcionFormatoAsignacionRepository().setMantenimiento(ObjTrace, detalle);
        }
    }
}
