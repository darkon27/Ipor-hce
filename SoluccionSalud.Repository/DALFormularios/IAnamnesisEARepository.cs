using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoluccionSalud.Repository.DALFormularios
{

    public interface IAnamnesisEARepository : IGenericDataRepository<SS_HC_Anamnesis_EA>
    {
       int setMantenimiento(SS_HC_Anamnesis_EA objSC);
    }
}
