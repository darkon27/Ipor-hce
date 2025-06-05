using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLFormularios
{
    public class AnamnesisAFBLL
    {
        public long setMantAnamnesisAF(SS_HC_Anamnesis_AF objSC)
        {
            return new AnamnesisAFRepository().setMantAnamnesisAF(objSC);
        }
        public long setMantAnamnesisAF(SS_HC_Anamnesis_AF objSC, List<SS_HC_Anamnesis_AF> Cabecera, List<SS_HC_Anamnesis_AF_Enfermedad> Detalle)
        {
            return new AnamnesisAFRepository().setMantAnamnesisAF(objSC,Cabecera,Detalle);
        }
        public List<SS_HC_Anamnesis_AF> AnamnesisAFListar(SS_HC_Anamnesis_AF ObjTrace)
        {
            return new AnamnesisAFRepository().AnamnesisAFListar(ObjTrace);
        }

        public long setMantAnamnesisAF(SS_HC_Anamnesis_AFAM objSC, List<SS_HC_Anamnesis_AFAM> Cabecera, List<SS_HC_Anamnesis_AFAM_Enfermedad> Detalle)
        {
            return new AnamnesisAFRepository().setMantAnamnesisAF(objSC, Cabecera, Detalle);
        }
        public List<SS_HC_Anamnesis_AFAM> AnamnesisAFListar(SS_HC_Anamnesis_AFAM ObjTrace)
        {
            return new AnamnesisAFRepository().AnamnesisAFListar(ObjTrace);
        }
    }
}
