using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALDiccionario
{

    public interface IDiccionarioRepository : IGenericDataRepository<SS_CE_DICCIONARIO>
    {
   
        List<SS_CE_DICCIONARIO> GetSelectDiccionario(SS_CE_DICCIONARIO objSC);

    }
}
