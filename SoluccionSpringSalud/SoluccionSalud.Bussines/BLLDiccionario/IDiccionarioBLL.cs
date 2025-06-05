using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;

namespace SoluccionSalud.Bussines.BLLDiccionario
{
    public interface IDiccionarioBLL
    {
       List<SS_CE_DICCIONARIO> GetSelectDiccionario(SS_CE_DICCIONARIO objSC);
    }
}
