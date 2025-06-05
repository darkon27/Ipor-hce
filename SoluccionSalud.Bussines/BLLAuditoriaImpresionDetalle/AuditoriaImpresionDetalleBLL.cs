using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALAuditoriaImpresionDetalle;
namespace SoluccionSalud.Bussines.BLLAuditoriaImpresionDetalle
{
    public class AuditoriaImpresionDetalleBLL
    {
        public List<SS_HC_ImpresionHC_Detalle> listarAudi_ImpDetalle(SS_HC_ImpresionHC_Detalle objSC, int inicio, int final)
        {
            return new AuditoriaImpresionDetalleRepository().listarAudi_ImpDetalle(objSC, inicio, final);
        }
    }
}
