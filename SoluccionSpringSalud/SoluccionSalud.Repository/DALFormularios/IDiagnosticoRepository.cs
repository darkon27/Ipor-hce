using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALFormularios
{

    public interface IDiagnosticoRepository : IGenericDataRepository<SS_HC_Diagnostico>
    {
        int setMantenimiento(SS_HC_Diagnostico objSC);
    }
}
