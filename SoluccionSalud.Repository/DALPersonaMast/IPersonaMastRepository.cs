using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALPersonaMast
{
    public interface IPersonaMastRepository : IGenericDataRepository<PERSONAMAST>
    {
        List<PERSONAMAST> GetSelectPersonaMast(PERSONAMAST objSC);
    }
}
