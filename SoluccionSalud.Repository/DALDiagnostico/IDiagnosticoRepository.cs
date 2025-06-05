using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Repository.Repository;
using SoluccionSalud.Model;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALDiagnostico
{
    public interface IDiagnosticoRepository : IGenericDataRepository<SS_GE_Diagnostico>
    {
        List<SS_GE_Diagnostico> listarDiagnostico(SS_GE_Diagnostico objSC);
    }
}
