using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALMiscelaneos
{

    public interface IMiscelaneosRepository : IGenericDataRepository<MA_MiscelaneosDetalle>
    {
        List<MA_MiscelaneosDetalle> GetUpListadoServicios(MA_MiscelaneosDetalle objSC);
    }
}
