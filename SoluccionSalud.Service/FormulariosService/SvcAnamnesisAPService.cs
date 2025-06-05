using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
     public class SvcAnamnesisAPService
    {
        public static Int32 setMantAnamnesisAP(SS_HC_Anamnesis_AP objSC)
        {
            return new AnamnesisAPBLL().setMantAnamnesisAP(objSC);
        }
         /***/
        public static List<SS_HC_Anamnesis_AP> AnamnesisAP_Listar(SS_HC_Anamnesis_AP ObjTrace)
        {
            return new AnamnesisAPBLL().AnamnesisAP_Listar(ObjTrace);
        }
    }

}
