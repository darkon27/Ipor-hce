using SoluccionSalud.Bussines.BLLFormularios;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.FormulariosService
{
    public class SvcMedicamentoService
    {
        public static int setMantenimiento(SS_HC_Medicamento objSC)
        {
            return new MedicamentoBLL().setMantenimiento(objSC);
        }
        public static List<SS_HC_Medicamento> MedicamentoListar(SS_HC_Medicamento ObjTrace)
        {
            return new MedicamentoBLL().MedicamentoListar(ObjTrace);
        }
    }
}
