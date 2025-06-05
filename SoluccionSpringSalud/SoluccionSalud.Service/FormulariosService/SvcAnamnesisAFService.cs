using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcAnamnesisAFService
    {
        public static long setMantAnamnesisAF(SS_HC_Anamnesis_AF objSC)
        {
            return new AnamnesisAFBLL().setMantAnamnesisAF(objSC);
        }
        public static List<SS_HC_Anamnesis_AF> AnamnesisAFListar(SS_HC_Anamnesis_AF ObjTrace)
        {
            return new AnamnesisAFBLL().AnamnesisAFListar(ObjTrace);
        }
    }
}
