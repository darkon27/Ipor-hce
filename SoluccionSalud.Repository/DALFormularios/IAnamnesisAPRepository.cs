using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SoluccionSalud.Entidades.Entidades;
using SoluccionSalud.Entidades.IRepository;

namespace SoluccionSalud.Repository.DALFormularios
{

    public interface IAnamnesisAPRepository : IGenericDataRepository<SS_HC_Anamnesis_AP>
    {
        int setMantAnamnesisAP(SS_HC_Anamnesis_AP objSC);
    }
}
