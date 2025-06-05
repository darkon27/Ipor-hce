using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALSeguimientoRiesgo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLSeguimientoRiesgo
{
    public class SeguimientoRiesgoBLL
    {
        public List<SS_HC_SeguimientoRiesgo> listarSeguimientoRiesgo(SS_HC_SeguimientoRiesgo objSC)
        {
            return new SeguimientoRiesgoRepository().listarSeguimientoRiesgo(objSC);
        }

        public int setMantenimiento(SS_HC_SeguimientoRiesgo ObjTrace)
        {
            return new SeguimientoRiesgoRepository().setMantenimiento(ObjTrace);
        }

        public int setMantenimiento(SS_HC_SeguimientoRiesgo ObjTraces, List<SS_HC_SeguimientoRiesgo> listaCabecera,
List<SS_HC_SeguimientoRiesgoDetalle> listaDetalle)
        {
            return new SeguimientoRiesgoRepository().setMantenimiento(ObjTraces, listaCabecera, listaDetalle);
        }
    }
}
