using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALOrdAtenPreexistencia;

namespace SoluccionSalud.Bussines.BLLOrdAtenPreexistencia
{
    public class OrdAtenPreexistenciaBLL
    {
        public List<SS_AD_OrdenAtencionPreexistencia> listarOrdAtePreexistencia(SS_AD_OrdenAtencionPreexistencia objSC, int inicio, int final)
        {
            return new OrdAtenPreexistenciaRepository().listarOrdAtePreexistencia(objSC, inicio, final);
        }

        public int setMantenimiento(SS_AD_OrdenAtencionPreexistencia ObjTrace)
        {
            return new OrdAtenPreexistenciaRepository().setMantenimiento(ObjTrace);
        }
    }
}
