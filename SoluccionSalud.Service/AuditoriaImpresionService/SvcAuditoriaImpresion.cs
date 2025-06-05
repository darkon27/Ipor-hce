using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLAuditoriaImpresion;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.AuditoriaImpresionService
{
    public class SvcAuditoriaImpresion
    {
        public static List<SS_HC_ImpresionHC> listarAudi_Imp(SS_HC_ImpresionHC objSC, int inicio, int final)
        {
            return new AuditoriaImpresionBLL().listarAudi_Imp(objSC, inicio, final);
        }

        public static int setMantenimientoAI(SS_HC_ImpresionHC ObjTrace)
        {
            return new AuditoriaImpresionBLL().setMantenimientoAI(ObjTrace);
        }

        public static int save_ChangesTraking(SS_HC_ImpresionHC objSC, SS_HC_ImpresionHC_Detalle objDetalle, String indica)
        {
            return new AuditoriaImpresionBLL().save_ChangesTraking(objSC, objDetalle, indica);
        }

    }
}
