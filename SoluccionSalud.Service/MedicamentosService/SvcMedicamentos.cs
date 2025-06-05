using SoluccionSalud.Bussines.BLLMedicamentos;
using SoluccionSalud.Entidades.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Service.MedicamentosService
{
    public class SvcMedicamentos
    {
        public static List<WH_ItemMast> listarMedicamentos(WH_ItemMast objSC, int inicio, int final)
        {
            return new MedicamentosBLL().listarMedicamentos(objSC, inicio, final);
        }

        public static int setMantenimiento(WH_ItemMast ObjTrace)
        {
            return new MedicamentosBLL().setMantenimiento(ObjTrace);
        }
    }
}
