using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcFormularios
    {
        public static Int32 setMantenimiento(SS_HC_Anamnesis_EA objSC)
        {
            return new AnamnesisEABLL().setMantenimiento(objSC);
        }
    }
}
