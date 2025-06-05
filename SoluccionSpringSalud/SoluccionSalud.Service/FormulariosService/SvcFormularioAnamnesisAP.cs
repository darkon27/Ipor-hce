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
    }
}
