using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace SoluccionSalud.Bussines.BLLFormularios
{
    public class ProximaAtencionBLL
    {
        public int ProximaAtencion(SS_HC_ProximaAtencion objSC)
        {
            return new ProximaAtencionRepository().ProximaAtencion(objSC);
        }

        public List<SS_HC_ProximaAtencion> ProximaAtencionListar(SS_HC_ProximaAtencion objSC)
        {
            return new ProximaAtencionRepository().ProximaAtencionListar(objSC);
        }

        public int setMantenimiento(SS_HC_ProximaAtencion objSC, List<SS_HC_ProximaAtencion> listaDetalle, List<SS_HC_ProximaAtencionDiagnostico> listaDetalleDiagnost)
        {
            return new ProximaAtencionRepository().setMantenimiento(objSC, listaDetalle, listaDetalleDiagnost);
        }
    }
}
