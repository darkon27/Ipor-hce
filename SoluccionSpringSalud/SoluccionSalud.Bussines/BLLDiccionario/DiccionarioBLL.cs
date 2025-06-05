using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.DALDiccionario;

namespace SoluccionSalud.Bussines.BLLDiccionario
{
    public class DiccionarioBLL
    {
        public List<SS_CE_DICCIONARIO> GetSelectDiccionario(SS_CE_DICCIONARIO objSC) {
            return new DiccionarioRepository().GetSelectDiccionario(objSC);
        }
    }
}
