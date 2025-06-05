using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALGe_Varios;

namespace SoluccionSalud.Bussines.BLLGe_Varios
{
    public class Ge_VariosBLL
    {
        public List<GE_Varios> listarGe_Varios(GE_Varios objSC)
        {
            return new Ge_VariosRepository().listarGe_Varios(objSC);
        }
    }
}
