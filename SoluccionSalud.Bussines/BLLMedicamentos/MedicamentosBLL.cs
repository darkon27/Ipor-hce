using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALMedicamentos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Bussines.BLLMedicamentos
{
    public class MedicamentosBLL
    {
        public List<WH_ItemMast> listarMedicamentos(WH_ItemMast objSC, int inicio, int final)
        {
            return new MedicamentosRepository().listarMedicamentos(objSC, inicio, final);
        }

        public int setMantenimiento(WH_ItemMast ObjTrace)
        {
            return new MedicamentosRepository().setMantenimiento(ObjTrace);
        }
    }
}
