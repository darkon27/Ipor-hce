using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALFormularios;

namespace SoluccionSalud.Bussines.BLLFormularios
{
    
    public class AnamnesisAPBLL
    {
        public int setMantAnamnesisAP(SS_HC_Anamnesis_AP objSC)
        {
            return new AnamnesisAPRepository().registraAnamnesis(objSC);
        }
        public List<SS_HC_Anamnesis_AP> AnamnesisAP_Listar(SS_HC_Anamnesis_AP ObjTrace) {
            return new AnamnesisAPRepository().AnamnesisAP_Listar(ObjTrace);
        }

        public Int32 setMantAnamnesisAP(SS_HC_Anamnesis_AP objCabecera, List<SS_HC_Anamnesis_AP> listaDetalle,
    List<SS_HC_Anamnesis_AP_Detalle> listaDetalle2)
        {
            return new AnamnesisAPRepository().setMantAnamnesisAP(objCabecera, listaDetalle, listaDetalle2);
        }

    }
}
