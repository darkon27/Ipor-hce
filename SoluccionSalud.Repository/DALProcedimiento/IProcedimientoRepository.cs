using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALProcedimiento
{
    public interface IProcedimientoRepository : IGenericDataRepository<SS_HC_Procedimiento>
    {
        List<SS_HC_Procedimiento> listarProcedimiento(SS_HC_Procedimiento objSC);
    }
}
