using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALMiscelaneos
{
    public interface IMiscDetalleRepository : IGenericDataRepository<MA_MiscelaneosDetalle>
    {
        List<MA_MiscelaneosDetalle> getListadoRecursos(MA_MiscelaneosDetalle objSC);
    }
}
