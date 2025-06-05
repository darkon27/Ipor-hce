using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLOrdAtenPreexistencia;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.OrdAtenPreexistenciaService
{
    public class SvcOrdAtenPreexistencia
    {
        public static List<SS_AD_OrdenAtencionPreexistencia> listarOrdAtePreexistencia(SS_AD_OrdenAtencionPreexistencia objSC, int inicio, int final)
        {
            return new OrdAtenPreexistenciaBLL().listarOrdAtePreexistencia(objSC, inicio, final);
        }

        public static int setMantenimiento(SS_AD_OrdenAtencionPreexistencia ObjTrace)
        {
            return new OrdAtenPreexistenciaBLL().setMantenimiento(ObjTrace);
        }
    }
}
