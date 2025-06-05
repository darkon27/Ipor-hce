using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Service.FormulariosService
{
  
    public class SvcFormularioAnamnesisAP
    {
        public static Int32 setMantAnamnesisAP(SS_HC_Anamnesis_AP objSC)
        {
            return new AnamnesisAPBLL().setMantAnamnesisAP(objSC);
        }
        public static List<SS_HC_Anamnesis_AP> AnamnesisAP_Listar(SS_HC_Anamnesis_AP ObjTrace)
        {
            return new AnamnesisAPBLL().AnamnesisAP_Listar(ObjTrace);
        }

        /****/
        public static Int32 setMantAnamnesisAP(SS_HC_Anamnesis_AP objCabecera, List<SS_HC_Anamnesis_AP> listaDetalle,
            List<SS_HC_Anamnesis_AP_Detalle> listaDetalle2)
        {
            return new AnamnesisAPBLL().setMantAnamnesisAP(objCabecera, listaDetalle, listaDetalle2);
        }

    }
}
