using SoluccionSalud.Bussines.BLLSeguimientoRiesgo;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.SeguimientoRiesgoService
{
    public class SvcSeguimientoRiesgo
    {
        public static List<SS_HC_SeguimientoRiesgo> listarSeguimientoRiesgo(SS_HC_SeguimientoRiesgo objSC)
        {
            return new SeguimientoRiesgoBLL().listarSeguimientoRiesgo(objSC);
        }
        public static int setMantenimiento(SS_HC_SeguimientoRiesgo ObjTrace)
        {
            return new SeguimientoRiesgoBLL().setMantenimiento(ObjTrace);
        }

        public static int setMantenimiento(SS_HC_SeguimientoRiesgo ObjTraces, List<SS_HC_SeguimientoRiesgo> listaCabecera,
    List<SS_HC_SeguimientoRiesgoDetalle> listaDetalle)
        {
            return new SeguimientoRiesgoBLL().setMantenimiento(ObjTraces, listaCabecera, listaDetalle);
        }
    }
}
