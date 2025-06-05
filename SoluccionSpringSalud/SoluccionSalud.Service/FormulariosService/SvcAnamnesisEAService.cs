using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcAnamnesisEAService
    {
        public static List<SS_HC_Anamnesis_EA> Anamnesis_EA_Listar(SS_HC_Anamnesis_EA ObjTrace)
        {
            return new AnamnesisEABLL().Anamnesis_EA_Listar(ObjTrace);
        }
    }


}
