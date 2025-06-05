using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALUsuario
{
    public interface IUsuarioRepository : IGenericDataRepository<USUARIO>
    {
        List<USUARIO> listarUsuario(USUARIO objSC);
    }
}
