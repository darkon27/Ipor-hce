using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALAuditoriaImpresion;

namespace SoluccionSalud.Bussines.BLLAuditoriaImpresion
{
    public class AuditoriaImpresionBLL
    {
        public List<SS_HC_ImpresionHC> listarAudi_Imp(SS_HC_ImpresionHC objSC, int inicio, int final)
        {
            return new AuditoriaImpresionRepository().listarAudi_Imp(objSC, inicio, final);
        }

        public int setMantenimientoAI(SS_HC_ImpresionHC ObjTrace)
        {
            return new AuditoriaImpresionRepository().setMantenimientoAI(ObjTrace);
        }


        public int save_ChangesTraking(SS_HC_ImpresionHC objSC, SS_HC_ImpresionHC_Detalle objDetalle, String indica)
        {
            return new AuditoriaImpresionRepository().save_ChangesTraking(objSC, objDetalle, indica);
        }
        
    }
}
